#ifndef HXLUAU_LUA_IMPL_H
#define HXLUAU_LUA_IMPL_H

#include "lua.h"

#ifdef __cplusplus
extern "C" {
#endif

// Wrapper for luaL_loadstring functionality using Luau
int hxluau_loadstring_wrapper(lua_State* L, const char* s);

// Wrapper for luaL_loadfile functionality using Luau
int hxluau_loadfile_wrapper(lua_State* L, const char* filename);

// Wrapper for luaL_dostring functionality
int hxluau_dostring_wrapper(lua_State* L, const char* str);

// Wrapper for luaL_dofile functionality
int hxluau_dofile_wrapper(lua_State* L, const char* filename);

// Register a custom print implementation into global 'print'
void hxluau_register_print(lua_State* L);

// Bytecode cache control
void hxluau_bytecode_cache_clear();
void hxluau_bytecode_cache_set_capacity(int cap);

// VM soft reset: collect & reset main thread without destroying VM
void hxluau_vm_soft_reset(lua_State* L);

// Enable/disable Luau native codegen (ahead-of-time) for loaded chunks
// 0 = disable, non-zero = enable
void hxluau_enable_codegen(int enable);

// Configure global compile options used by luau_compile
void hxluau_set_compile_options(int optimizationLevel, int debugLevel, int typeInfoLevel);

// Autocompile (hot-counter) control
void hxluau_enable_autocompile(lua_State* L, int enable);
void hxluau_set_autocompile_threshold(int threshold);

// Extended compile option setters
void hxluau_set_compile_coverage(int coverageLevel);
void hxluau_set_compile_vector_lib(const char* lib);
void hxluau_set_compile_vector_type(const char* type);
void hxluau_set_compile_vector_ctor(const char* ctor);
void hxluau_set_compile_mutable_globals(const char* const* mutableGlobals);
void hxluau_set_compile_userdata_types(const char* const* userdataTypes);
void hxluau_set_compile_disabled_builtins(const char* const* disabledBuiltins);

// Version information (update when vendored Luau library changes)
const char* hxluau_version_string();
const char* hxluau_version_release();
int hxluau_version_num();

#ifdef __cplusplus
}
#endif

#endif // HXLUAU_LUA_IMPL_H