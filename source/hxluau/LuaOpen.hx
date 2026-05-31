package hxluau;

#if !cpp
#error 'Luau supports only C++ target platforms.'
#end
import hxluau.Luau;
import hxluau.Types;

/**
 * Provides static methods to open various standard Lua libraries and extensions.
 */
@:buildXml('<include name="${haxelib:hxluau}/project/Build.xml" />')
@:include('lua.h')
@:include('lualib.h')
@:include('LuauImpl.h')
@:unreflective
extern class LuaOpen
{
	/**
	 * Opens the basic library (`base`) into the given Lua state.
	 *
	 * @param L The Lua state.
	 * @return The number of results pushed onto the Lua stack.
	 */
	@:native('luaopen_base')
	static function base(L:cpp.RawPointer<Lua_State>):Int;

	/**
	 * Opens the mathematical library (`math`) into the given Lua state.
	 *
	 * @param L The Lua state.
	 * @return The number of results pushed onto the Lua stack.
	 */
	@:native('luaopen_math')
	static function math(L:cpp.RawPointer<Lua_State>):Int;

	/**
	 * Opens the string manipulation library (`string`) into the given Lua state.
	 *
	 * @param L The Lua state.
	 * @return The number of results pushed onto the Lua stack.
	 */
	@:native('luaopen_string')
	static function string(L:cpp.RawPointer<Lua_State>):Int;

	/**
	 * Opens the table manipulation library (`table`) into the given Lua state.
	 *
	 * @param L The Lua state.
	 * @return The number of results pushed onto the Lua stack.
	 */
	@:native('luaopen_table')
	static function table(L:cpp.RawPointer<Lua_State>):Int;

	/**
	 * Opens the coroutine library (`coroutine`) into the given Lua state.
	 *
	 * @param L The Lua state.
	 * @return The number of results pushed onto the Lua stack.
	 */
	@:native('luaopen_coroutine')
	static function coroutine(L:cpp.RawPointer<Lua_State>):Int;

	/**
	 * Opens the bit manipulation library (`bit32`) into the given Lua state.
	 *
	 * @param L The Lua state.
	 * @return The number of results pushed onto the Lua stack.
	 */
	@:native('luaopen_bit32')
	static function bit32(L:cpp.RawPointer<Lua_State>):Int;

	/**
	 * Opens the UTF-8 library (`utf8`) into the given Lua state.
	 *
	 * @param L The Lua state.
	 * @return The number of results pushed onto the Lua stack.
	 */
	@:native('luaopen_utf8')
	static function utf8(L:cpp.RawPointer<Lua_State>):Int;

	/**
	 * Opens the buffer library (`buffer`) into the given Lua state.
	 *
	 * @param L The Lua state.
	 * @return The number of results pushed onto the Lua stack.
	 */
	@:native('luaopen_buffer')
	static function buffer(L:cpp.RawPointer<Lua_State>):Int;

	/**
	 * Opens the class library (`class`) into the given Lua state.
	 *
	 * @param L The Lua state.
	 * @return The number of results pushed onto the Lua stack.
	 */
	@:native('luaopen_class')
	static function classlib(L:cpp.RawPointer<Lua_State>):Int;

	/**
	 * Opens the operating system library (`os`) into the given Lua state.
	 *
	 * @param L The Lua state.
	 * @return The number of results pushed onto the Lua stack.
	 */
	@:native('luaopen_os')
	static function os(L:cpp.RawPointer<Lua_State>):Int;

	/**
	 * Opens the debug library (`debug`) into the given Lua state.
	 *
	 * @param L The Lua state.
	 * @return The number of results pushed onto the Lua stack.
	 */
	@:native('luaopen_debug')
	static function debug(L:cpp.RawPointer<Lua_State>):Int;

	/**
	 * Opens the vector library (`vector`) into the given Lua state.
	 *
	 * @param L The Lua state.
	 * @return The number of results pushed onto the Lua stack.
	 */
	@:native('luaopen_vector')
	static function vector(L:cpp.RawPointer<Lua_State>):Int;

	/**
	 * Opens the integer library (`integer`) into the given Lua state.
	 *
	 * @param L The Lua state.
	 * @return The number of results pushed onto the Lua stack.
	 */
	@:native('luaopen_integer')
	static function integer(L:cpp.RawPointer<Lua_State>):Int;

	#if !HXLUAU_DISABLE_FFI
	/**
	 * Opens the cffi-luau library into the given Lua state.
	 * Leaves the `cffi` module table on top of the stack.
	 * Register it globally with:
	 * ```
	 * LuaOpen.cffi(vm);
	 * Lua.setglobal(vm, "ffi");
	 * ```
	 *
	 * @param L The Lua state.
	 * @return 1 (the cffi module table is left on the stack).
	 */
	inline static function cffi(L:cpp.RawPointer<Lua_State>):Int
	{
		return Luau.openCFFI(L);
	}
	#end
}