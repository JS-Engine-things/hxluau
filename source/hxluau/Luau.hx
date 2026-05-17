package hxluau;

#if !cpp
#error 'Luau supports only C++ target platforms.'
#end
import hxluau.Types;

@:buildXml('<include name="${haxelib:hxluau}/project/Build.xml" />')
@:include('lua.h')
@:include('lualib.h')
@:include('luacode.h')
@:include('LuauImpl.h')
@:unreflective
extern class Luau
{
	/**
	 * Loads a file for Luau, requires separate compilation step via luau_compile.
	 *
	 * @param L The Lua state.
	 * @param filename The name of the file to load.
	 * @return The result of the load operation.
	 */
	@:native("hxluau_LuaL_loadfile_wrapper")
	static function loadfile(L:cpp.RawPointer<Lua_State>, filename:cpp.ConstCharStar):Int;

	/**
	 * Loads a string for Luau, requires separate compilation step via luau_compile.
	 *
	 * @param L The Lua state.
	 * @param s The string to load.
	 * @return The result of the load operation.
	 */
	@:native("hxluau_LuaL_loadstring_wrapper")
	static function loadstring(L:cpp.RawPointer<Lua_State>, s:cpp.ConstCharStar):Int;

	/**
	 * Executes a Lua file (compile with Luau and pcall).
	 *
	 * @param L The Lua state.
	 * @param filename The name of the file.
	 * @return The status code (0 on success).
	 */
	@:native("hxluau_LuaL_dofile_wrapper")
	static function dofile(L:cpp.RawPointer<Lua_State>, filename:cpp.ConstCharStar):Int;

	/**
	 * Executes a Lua string (compile with Luau and pcall).
	 */
	@:native("hxluau_LuaL_dostring_wrapper")
	static function dostring(L:cpp.RawPointer<Lua_State>, str:cpp.ConstCharStar):Int;

	/**
	 * Registers custom print implementation into global 'print'.
	 */
	@:native("hxluau_register_print")
	static function registerPrint(L:cpp.RawPointer<Lua_State>):Void;

	/**
	 * Clears the internal Luau bytecode cache used for file loads.
	 */
	@:native("hxluau_bytecode_cache_clear")
	static function bytecodeCacheClear():Void;

	/**
	 * Sets the capacity of the internal bytecode cache (default 128 entries).
	 * @param cap New capacity (>0).
	 */
	@:native("hxluau_bytecode_cache_set_capacity")
	static function bytecodeCacheSetCapacity(cap:Int):Void;

	/**
	 * Performs a VM-level soft reset: full GC collect and reset main thread.
	 * Keeps the VM alive without reinitializing libraries/globals.
	 */
	@:native("hxluau_vm_soft_reset")
	static function vmSoftReset(L:cpp.RawPointer<Lua_State>):Void;

	/**
	 * Enable or disable autocompile (hot function AOT compile) for a state.
	 */
	@:native('hxluau_enable_autocompile')
	static function enableAutoCompile(L:cpp.RawPointer<Lua_State>, enable:Int):Void;

	/**
	 * Set the hot-call threshold for autocompile.
	 */
	@:native('hxluau_set_autocompile_threshold')
	static function setAutoCompileThreshold(threshold:Int):Void;

	/**
	 * Enables or disables Luau native codegen for loaded chunks.
	 * When enabled and supported on this platform, loaded functions are
	 * compiled to native code for faster execution.
	 */
	@:native("hxluau_enable_codegen")
	static function enableCodegen(enable:Int):Void;

	/**
	 * Sets global compile options for Luau compiler.
	 * @param optimizationLevel 0..2 (2 = highest performance)
	 * @param debugLevel 0..2 (0 = no debug info)
	 * @param typeInfoLevel 0..1 (1 = emit type info for all modules)
	 */
	@:native("hxluau_set_compile_options")
	static function setCompileOptions(optimizationLevel:Int, debugLevel:Int, typeInfoLevel:Int):Void;

	/**
	 * Set code coverage level for compilation.
	 * @param level 0 = none, 1 = statement coverage, 2 = statement + expression
	 */
	@:native("hxluau_set_compile_coverage")
	static function setCompileCoverage(level:Int):Void;

	/**
	 * Set a custom vector library builtin for the compiler.
	 * @param lib Library name (e.g. "mylib"), or null for default
	 */
	@:native("hxluau_set_compile_vector_lib")
	static function setCompileVectorLib(lib:cpp.ConstCharStar):Void;

	/**
	 * Set a custom vector type name for type tables.
	 * @param type Type name, or null for default "vector"
	 */
	@:native("hxluau_set_compile_vector_type")
	static function setCompileVectorType(type:cpp.ConstCharStar):Void;

	/**
	 * Set the list of globals that are mutable (disables import optimization for their fields).
	 * @param globals Null-terminated array of global names, or null for none.
	 */
	@:native("hxluau_set_compile_mutable_globals")
	static function setCompileMutableGlobals(globals:cpp.RawPointer<cpp.RawConstPointer<cpp.Char>>):Void;

	/**
	 * Set the list of userdata types to include in type information.
	 * @param types Null-terminated array of type names, or null for none.
	 */
	@:native("hxluau_set_compile_userdata_types")
	static function setCompileUserdataTypes(types:cpp.RawPointer<cpp.RawConstPointer<cpp.Char>>):Void;

	/**
	 * Set the list of builtins to disable fast-call optimization for.
	 * @param builtins Null-terminated array of builtin names ("name" or "lib.name"), or null.
	 */
	@:native("hxluau_set_compile_disabled_builtins")
	static function setCompileDisabledBuiltins(builtins:cpp.RawPointer<cpp.RawConstPointer<cpp.Char>>):Void;

	/**
	 * Enable or disable Luau codegen counter recording intent for this process.
	 *
	 * Counters let you collect per-block native execution statistics (regular
	 * blocks executed, fallback blocks executed, VM exits taken) for profiling
	 * purposes.  They are surfaced after execution via `Lua.getcounters`.
	 *
	 * @param enable 1 to enable, 0 to disable.
	 */
	@:native("hxluau_enable_counter_support")
	static function enableCounterSupport(enable:Int):Void;

	/**
	 * Returns 1 if counter support was previously enabled via `enableCounterSupport`, 0 otherwise.
	 */
	@:native("hxluau_counter_support_enabled")
	static function counterSupportEnabled():Int;
}
