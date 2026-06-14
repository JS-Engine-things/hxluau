package hxluau;

#if !cpp
#error 'Luau supports only C++ target platforms.'
#end
import hxluau.Types;

/**
 * libffi-based C FFI for Luau, with a LuaJIT-style API.
 *
 * Once registered, Luau scripts use `ffi.cdef`, `ffi.new`, `ffi.load`, etc.
 * exactly as in LuaJIT.
 * ```
 * var vm = LuaL.newstate();
 * LuaL.openlibs(vm);
 * Cffi.register(vm);                   // opens cffi as the global `ffi`
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
	 * Opens cffi and registers it as the global `ffi`.
	 * @param L Lua state.
	 */
	inline static function register(L:cpp.RawPointer<Lua_State>):Void
	{
		#if !HXLUAU_DISABLE_FFI
		LuaOpen.cffi(L);
		Lua.setglobal(L, "ffi");
		#end
	}
}
