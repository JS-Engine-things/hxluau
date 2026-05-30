package hxluau;

#if !cpp
#error 'Luau supports only C++ target platforms.'
#end
import hxluau.Types;

/**
 * Convenient access to cffi-luau, a libffi-based C FFI for Luau.
 *
 * Usage mirrors LuaJIT's FFI. After opening the library into a Lua state,
 * Luau scripts can call `ffi.cdef`, `ffi.new`, `ffi.load`, etc. exactly
 * as they would in LuaJIT.
 *
 * Example from Haxe:
 * ```
 * var vm = LuaL.newstate();
 * LuaL.openlibs(vm);
 * Cffi.register(vm);                   // opens cffi, sets global 'ffi'
 * LuaL.dostring(vm, 'local p = ffi.new("int[4]")');
 * ```
 */
@:buildXml('<include name="${haxelib:hxluau}/project/Build.xml" />')
@:include('lua.h')
@:include('lualib.h')
@:include('LuauImpl.h')
@:unreflective
extern class Cffi
{
	/**
	 * Opens the cffi library and registers it as the global `ffi`.
	 * After calling this, Luau scripts can use `ffi.cdef`, `ffi.new`,
	 * `ffi.load`, and all other LuaJIT FFI-compatible functions.
	 *
	 * @param L The Lua state.
	 */
	inline static function register(L:cpp.RawPointer<Lua_State>):Void
	{
		LuaOpen.cffi(L);
		Lua.setglobal(L, "ffi");
	}
}
