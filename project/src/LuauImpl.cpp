// hxcpp precompiled header must be included first
#include "hxcpp.h"

#include "lua.h"
#include "lualib.h"
#include "luacode.h"
#include "luacodegen.h"
#include <stdio.h>
#include <string.h>
#include <stdlib.h>
#include <climits>
#include <unordered_map>
#include <string>
#include <deque>
#include <vector>
#include <stdint.h>

// Luau does not define LUA_ERRFILE; provide a fallback to match PUC-Lua
#ifndef LUA_ERRFILE
#define LUA_ERRFILE 7
#endif

// Forward declarations for codegen control state used below
extern bool g_codegen_enabled;
extern std::unordered_map<lua_State*, bool> g_codegen_created;

// ------------------------------------
// RAII guard to pause/resume the GC during bulk operations
// ------------------------------------
struct GcGuard
{
    lua_State* L;
    bool wasRunning;

    GcGuard(lua_State* L)
        : L(L)
        , wasRunning(lua_gc(L, LUA_GCISRUNNING, 0) != 0)
    {
        if (wasRunning)
            lua_gc(L, LUA_GCSTOP, 0);
    }

    ~GcGuard()
    {
        if (wasRunning)
            lua_gc(L, LUA_GCRESTART, 0);
    }

    GcGuard(const GcGuard&) = delete;
    GcGuard& operator=(const GcGuard&) = delete;
};

// ------------------------------------
// Simple bytecode cache for files (LRU)
// ------------------------------------
struct BytecodeCache
{
    static std::unordered_map<std::string, std::string>& data()
    {
        static std::unordered_map<std::string, std::string> inst;
        return inst;
    }

    static std::unordered_map<std::string, uint64_t>& hashes()
    {
        static std::unordered_map<std::string, uint64_t> inst;
        return inst;
    }

    static std::deque<std::string>& order()
    {
        static std::deque<std::string> inst;
        return inst;
    }

    static size_t& capacity()
    {
        static size_t cap = 128;
        return cap;
    }

    static void setCapacity(size_t cap)
    {
        capacity() = cap > 0 ? cap : 1;
        trim();
    }

    static void clear()
    {
        data().clear();
        hashes().clear();
        order().clear();
    }

    static uint64_t fnv1a64(const char* buf, size_t size)
    {
        const uint64_t FNV_OFFSET = 1469598103934665603ull;
        const uint64_t FNV_PRIME = 1099511628211ull;
        uint64_t h = FNV_OFFSET;
        for (size_t i = 0; i < size; ++i)
        {
            h ^= (uint8_t)buf[i];
            h *= FNV_PRIME;
        }
        return h;
    }

    static bool get(const std::string& key, uint64_t h, std::string& out)
    {
        auto hi = hashes().find(key);
        if (hi == hashes().end() || hi->second != h)
            return false;

        auto di = data().find(key);
        if (di == data().end())
            return false;

        out = di->second;
        touch(key);
        return true;
    }

    static void put(const std::string& key, uint64_t h, const char* bytecode, size_t size)
    {
        data()[key] = std::string(bytecode, size);
        hashes()[key] = h;
        touch(key);
        trim();
    }

private:
    static void touch(const std::string& key)
    {
        auto& o = order();
        for (auto it = o.begin(); it != o.end(); ++it)
        {
            if (*it == key)
            {
                o.erase(it);
                break;
            }
        }
        o.push_back(key);
    }

    static void trim()
    {
        auto& o = order();
        auto& d = data();
        auto& h = hashes();
        while (o.size() > capacity())
        {
            const std::string& victim = o.front();
            o.pop_front();
            d.erase(victim);
            h.erase(victim);
        }
    }
};

// ------------------------------------
// Codegen helper — shared by load wrappers and autocompile
// ------------------------------------
static void ensure_codegen_and_compile(lua_State* L)
{
    if (!g_codegen_enabled || !luau_codegen_supported())
        return;

    lua_State* mainL = lua_mainthread(L);
    if (!g_codegen_created[mainL])
    {
        luau_codegen_create(mainL);
        g_codegen_created[mainL] = true;
    }
    luau_codegen_compile(L, -1);
}

// ------------------------------------
// Global compile options for luau_compile
// ------------------------------------
static lua_CompileOptions g_compile_opts = {
    /*optimizationLevel*/ 2,
    /*debugLevel*/ 0,
    /*typeInfoLevel*/ 0,
    /*coverageLevel*/ 0,
    /*vectorLib*/ nullptr,
    /*vectorCtor*/ nullptr,
    /*vectorType*/ nullptr,
    /*mutableGlobals*/ nullptr,
    /*userdataTypes*/ nullptr,
    /*librariesWithKnownMembers*/ nullptr,
    /*libraryMemberTypeCb*/ nullptr,
    /*libraryMemberConstantCb*/ nullptr,
    /*disabledBuiltins*/ nullptr,
};

// ------------------------------------
// Autocompile (hot-counter) state
// ------------------------------------
static std::unordered_map<const void*, int> g_hot_counters;
static int g_autocompile_threshold = 1000;
static bool g_autocompile_enabled = false;

// Storage for extended compile option string pointers (must outlive g_compile_opts)
static std::string g_vector_lib;
static std::string g_vector_type;

extern "C" {

// Cache control APIs
void hxluau_bytecode_cache_clear()
{
    BytecodeCache::clear();
}

void hxluau_bytecode_cache_set_capacity(int cap)
{
    BytecodeCache::setCapacity((size_t)cap);
}

void hxluau_set_compile_options(int optimizationLevel, int debugLevel, int typeInfoLevel)
{
    if (optimizationLevel >= 0 && optimizationLevel <= 2)
        g_compile_opts.optimizationLevel = optimizationLevel;
    if (debugLevel >= 0 && debugLevel <= 2)
        g_compile_opts.debugLevel = debugLevel;
    if (typeInfoLevel >= 0 && typeInfoLevel <= 1)
        g_compile_opts.typeInfoLevel = typeInfoLevel;
}

void hxluau_enable_codegen(int enable)
{
    g_codegen_enabled = (enable != 0);
}

// Wrapper for luaL_loadstring functionality using Luau
int hxluau_LuaL_loadstring_wrapper(lua_State* L, const char* s)
{
    GcGuard gc(L);

    size_t bytecodeSize;
    char* bytecode = luau_compile(s, strlen(s), &g_compile_opts, &bytecodeSize);

    if (!bytecode)
    {
        lua_pushstring(L, "out of memory while compiling string");
        return LUA_ERRMEM;
    }

    int loadResult = luau_load(L, "string", bytecode, bytecodeSize, 0);

    if (loadResult == 0)
        ensure_codegen_and_compile(L);

    free(bytecode);
    return loadResult;
}

// Wrapper for luaL_loadfile functionality using Luau
int hxluau_LuaL_loadfile_wrapper(lua_State* L, const char* filename)
{
    GcGuard gc(L);

    FILE* file = fopen(filename, "rb");
    if (!file)
    {
        lua_pushfstring(L, "cannot open %s", filename);
        return LUA_ERRFILE;
    }

    fseek(file, 0, SEEK_END);
    long fileSize = ftell(file);
    fseek(file, 0, SEEK_SET);

    if (fileSize < 0)
    {
        fclose(file);
        lua_pushfstring(L, "cannot read %s", filename);
        return LUA_ERRFILE;
    }

    size_t size = (size_t)fileSize;
    std::vector<char> buffer(size);
    size_t read = fread(buffer.data(), 1, size, file);
    fclose(file);

    if (read != size)
    {
        lua_pushfstring(L, "cannot read %s", filename);
        return LUA_ERRFILE;
    }

    // Compute content hash for cache lookup
    uint64_t h = BytecodeCache::fnv1a64(buffer.data(), size);

    // Try cache first
    std::string cached;
    bool haveCached = BytecodeCache::get(filename, h, cached);

    int loadResult;
    if (haveCached)
    {
        loadResult = luau_load(L, filename, cached.data(), cached.size(), 0);
    }
    else
    {
        size_t bytecodeSize;
        char* bytecode = luau_compile(buffer.data(), size, &g_compile_opts, &bytecodeSize);

        if (!bytecode)
        {
            lua_pushstring(L, "out of memory while compiling file");
            return LUA_ERRMEM;
        }

        loadResult = luau_load(L, filename, bytecode, bytecodeSize, 0);
        BytecodeCache::put(filename, h, bytecode, bytecodeSize);
        free(bytecode);
    }

    if (loadResult == 0)
        ensure_codegen_and_compile(L);

    return loadResult;
}

// Wrapper for luaL_dostring functionality
int hxluau_LuaL_dostring_wrapper(lua_State* L, const char* str)
{
    int loadResult = hxluau_LuaL_loadstring_wrapper(L, str);
    if (loadResult == 0)
        return lua_pcall(L, 0, LUA_MULTRET, 0);
    return loadResult;
}

// Wrapper for luaL_dofile functionality
int hxluau_LuaL_dofile_wrapper(lua_State* L, const char* filename)
{
    int loadResult = hxluau_LuaL_loadfile_wrapper(L, filename);
    if (loadResult == 0)
        return lua_pcall(L, 0, LUA_MULTRET, 0);
    return loadResult;
}

// Custom print implementation that mirrors Lua's base print behavior
static int hxluau_print(lua_State* L)
{
    int n = lua_gettop(L);
    for (int i = 1; i <= n; i++)
    {
        const char* s = lua_tolstring(L, i, NULL);
        if (!s)
        {
            luaL_tolstring(L, i, NULL);
            s = lua_tolstring(L, -1, NULL);
            lua_remove(L, -2);
        }
        fputs(s ? s : "nil", stdout);
        if (i < n)
            fputc('\t', stdout);
    }
    fputc('\n', stdout);
    return 0;
}

// Register the custom print into the global 'print'
void hxluau_register_print(lua_State* L)
{
    lua_pushcfunction(L, hxluau_print, "print");
    lua_setglobal(L, "print");
}

// VM soft reset: collect & reset main thread without destroying VM
void hxluau_vm_soft_reset(lua_State* L)
{
    int running = lua_gc(L, LUA_GCISRUNNING, 0);
    if (running)
        lua_gc(L, LUA_GCSTOP, 0);
    lua_gc(L, LUA_GCCOLLECT, 0);
    if (running)
        lua_gc(L, LUA_GCRESTART, 0);

    lua_resetthread(lua_mainthread(L));
}

// Lower-overhead interrupt hook: called at VM safepoints (loop back edges, call/ret, gc)
static void hxluau_interrupt_hook(lua_State* L, int gc)
{
    (void)gc;

    if (!g_autocompile_enabled)
        return;

    if (!luau_codegen_supported())
        return;

    lua_Debug ar;
    if (lua_getinfo(L, 0, "f", &ar))
    {
        const void* funcptr = lua_topointer(L, -1);
        if (funcptr)
        {
            int& cnt = g_hot_counters[funcptr];
            ++cnt;
            if (cnt >= g_autocompile_threshold)
            {
                ensure_codegen_and_compile(L);
                cnt = INT_MIN / 2;
            }
        }
        lua_pop(L, 1);
    }
}

// Enable or disable the autocompile hook for a given state
void hxluau_enable_autocompile(lua_State* L, int enable)
{
    g_autocompile_enabled = (enable != 0);

    lua_Callbacks* cbs = lua_callbacks(L);
    if (cbs)
        cbs->interrupt = g_autocompile_enabled ? hxluau_interrupt_hook : NULL;
}

// Set the hot-call threshold
void hxluau_set_autocompile_threshold(int threshold)
{
    g_autocompile_threshold = (threshold <= 0) ? 1 : threshold;
}

// Extended compile option setters
void hxluau_set_compile_coverage(int coverageLevel)
{
    if (coverageLevel >= 0 && coverageLevel <= 2)
        g_compile_opts.coverageLevel = coverageLevel;
}

void hxluau_set_compile_vector_lib(const char* lib)
{
    g_vector_lib = lib ? lib : "";
    g_compile_opts.vectorLib = g_vector_lib.data();
}

void hxluau_set_compile_vector_type(const char* type)
{
    g_vector_type = type ? type : "";
    g_compile_opts.vectorType = g_vector_type.data();
}

void hxluau_set_compile_mutable_globals(const char* const* mutableGlobals)
{
    g_compile_opts.mutableGlobals = mutableGlobals;
}

void hxluau_set_compile_userdata_types(const char* const* userdataTypes)
{
    g_compile_opts.userdataTypes = userdataTypes;
}

void hxluau_set_compile_disabled_builtins(const char* const* disabledBuiltins)
{
    g_compile_opts.disabledBuiltins = disabledBuiltins;
}

const char* hxluau_version_string()
{
    return "Luau 0.720";
}

const char* hxluau_version_release()
{
    return "Luau 0.720";
}

int hxluau_version_num()
{
    return 720;
}

} // extern "C"

// -----------------------------
// Optional native codegen (AOT)
// -----------------------------
bool g_codegen_enabled = true;
std::unordered_map<lua_State*, bool> g_codegen_created;
