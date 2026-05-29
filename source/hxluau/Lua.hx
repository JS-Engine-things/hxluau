package hxluau;

#if !cpp
#error 'Luau supports only C++ target platforms.'
#end
import hxluau.Types;

/**
 * Provides access to various properties and functionalities of Lua.
 */
@:buildXml('<include name="${haxelib:hxluau}/project/Build.xml" />')
@:include('lua.h')
@:include('lualib.h')
@:include('luacode.h')
@:include('LuauImpl.h')
@:unreflective
extern class Lua
{
	/**
	 * The version string of Lua.
	 */
	@:native('::String(hxluau_version_string())')
	static var VERSION(default, null):String;

	/**
	 * The release string of Lua.
	 */
	@:native('::String(hxluau_version_release())')
	static var RELEASE(default, null):String;

	/**
	 * The version number of Lua.
	 */
	@:native('hxluau_version_num()')
	static var VERSION_NUM(default, null):Int;

	/**
	 * The copyright information of Lua.
	 */
	@:native('::String("Copyright (C) 2019-2022 Roblox Corporation. Copyright (C) 1994-2022 Lua.org, PUC-Rio.")')
	static var COPYRIGHT(default, null):String;

	/**
	 * The authors of Lua.
	 */
	@:native('::String("Roblox Corporation. Lua.org, PUC-Rio.")')
	static var AUTHORS(default, null):String;

	/**
	 * Return multiple results.
	 */
	@:native('LUA_MULTRET')
	static var MULTRET:Int;

	/**
	 * Registry index.
	 */
	@:native('LUA_REGISTRYINDEX')
	static var REGISTRYINDEX:Int;

	/**
	 * Environment index.
	 */
	@:native('LUA_ENVIRONINDEX')
	static var ENVIRONINDEX:Int;

	/**
	 * Globals index.
	 */
	@:native('LUA_GLOBALSINDEX')
	static var GLOBALSINDEX:Int;

	/**
	 * Check if an index is a pseudo-index.
	 * @param i The index to check.
	 * @return 1 if pseudo, 0 otherwise.
	 */
	@:native('lua_ispseudo')
	static function ispseudo(i:Int):Int;

	/**
	 * Get the upvalue index.
	 *
	 * @param i The upvalue index.
	 * @return The index of the upvalue.
	 */
	@:native('lua_upvalueindex')
	static function upvalueindex(i:Int):Int;

	/**
	 * Status code for success.
	 */
	@:native('LUA_OK')
	static var OK:Int;

	/**
	 * Status code for a yield.
	 */
	@:native('LUA_YIELD')
	static var YIELD:Int;

	/**
	 * Status code for a runtime error.
	 */
	@:native('LUA_ERRRUN')
	static var ERRRUN:Int;

	/**
	 * Status code for a syntax error.
	 */
	@:native('LUA_ERRSYNTAX')
	static var ERRSYNTAX:Int;

	/**
	 * Status code for a memory allocation error.
	 */
	@:native('LUA_ERRMEM')
	static var ERRMEM:Int;

	/**
	 * Status code for an error handling error.
	 */
	@:native('LUA_ERRERR')
	static var ERRERR:Int;

	/**
	 * Status code for a debug breakpoint yield.
	 */
	@:native('LUA_BREAK')
	static var BREAK:Int;

	/**
	 * Type for no type.
	 */
	@:native('LUA_TNONE')
	static var TNONE:Int;

	/**
	 * Type for nil.
	 */
	@:native('LUA_TNIL')
	static var TNIL:Int;

	/**
	 * Type for boolean.
	 */
	@:native('LUA_TBOOLEAN')
	static var TBOOLEAN:Int;

	/**
	 * Type for light userdata.
	 */
	@:native('LUA_TLIGHTUSERDATA')
	static var TLIGHTUSERDATA:Int;

	/**
	 * Type for number.
	 */
	@:native('LUA_TNUMBER')
	static var TNUMBER:Int;

	/**
	 * Type for string.
	 */
	@:native('LUA_TSTRING')
	static var TSTRING:Int;

	/**
	 * Type for table.
	 */
	@:native('LUA_TTABLE')
	static var TTABLE:Int;

	/**
	 * Type for function.
	 */
	@:native('LUA_TFUNCTION')
	static var TFUNCTION:Int;

	/**
	 * Type for userdata.
	 */
	@:native('LUA_TUSERDATA')
	static var TUSERDATA:Int;

	/**
	 * Type for thread.
	 */
	@:native('LUA_TTHREAD')
	static var TTHREAD:Int;

	/**
	 * Type for integer (64-bit).
	 */
	@:native('LUA_TINTEGER')
	static var TINTEGER:Int;

	/**
	 * Type for vector.
	 */
	@:native('LUA_TVECTOR')
	static var TVECTOR:Int;

	/**
	 * Type for buffer.
	 */
	@:native('LUA_TBUFFER')
	static var TBUFFER:Int;

	/**
	 * Type for class.
	 */
	@:native('LUA_TCLASS')
	static var TCLASS:Int;

	/**
	 * Type for object.
	 */
	@:native('LUA_TOBJECT')
	static var TOBJECT:Int;

	/**
	 * Minimum stack size.
	 */
	@:native('LUA_MINSTACK')
	static var MINSTACK:Int;

	/**
	 * Maximum size for the textual description of a source (size of `short_src`).
	 */
	@:native('LUA_IDSIZE')
	static var IDSIZE:Int;

	/**
	 * Upper limit on Lua stack slots usable by a single C function.
	 */
	@:native('LUAI_MAXCSTACK')
	static var MAXCSTACK:Int;

	/**
	 * Maximum number of nested Lua calls.
	 */
	@:native('LUAI_MAXCALLS')
	static var MAXCALLS:Int;

	/**
	 * Maximum depth for nested C calls.
	 */
	@:native('LUAI_MAXCCALLS')
	static var MAXCCALLS:Int;

	/**
	 * Size of the on-stack buffer used by string operations (`LuaL_Buffer`).
	 */
	@:native('LUA_BUFFERSIZE')
	static var BUFFERSIZE:Int;

	/**
	 * Number of valid userdata tags (tags passed to the tagged-userdata API
	 * must be in the range `0..UTAG_LIMIT-1`).
	 */
	@:native('LUA_UTAG_LIMIT')
	static var UTAG_LIMIT:Int;

	/**
	 * Number of valid light userdata tags (`0..LUTAG_LIMIT-1`).
	 */
	@:native('LUA_LUTAG_LIMIT')
	static var LUTAG_LIMIT:Int;

	/**
	 * Number of separate memory categories (`lua_setmemcat` / `lua_totalbytes`
	 * accept a category in the range `0..MEMORY_CATEGORIES-1`).
	 */
	@:native('LUA_MEMORY_CATEGORIES')
	static var MEMORY_CATEGORIES:Int;

	/**
	 * Maximum number of captures supported by pattern matching.
	 */
	@:native('LUA_MAXCAPTURES')
	static var MAXCAPTURES:Int;

	/**
	 * Number of float components per Luau vector (3 by default, may be 4).
	 */
	@:native('LUA_VECTOR_SIZE')
	static var VECTOR_SIZE:Int;

	/**
	 * Coroutine status: the coroutine is currently running.
	 */
	@:native('LUA_CORUN')
	static var CORUN:Int;

	/**
	 * Coroutine status: the coroutine is suspended (yielded or not yet started).
	 */
	@:native('LUA_COSUS')
	static var COSUS:Int;

	/**
	 * Coroutine status: the coroutine is normal — it resumed another coroutine and is waiting.
	 */
	@:native('LUA_CONOR')
	static var CONOR:Int;

	/**
	 * Coroutine status: the coroutine finished execution normally.
	 */
	@:native('LUA_COFIN')
	static var COFIN:Int;

	/**
	 * Coroutine status: the coroutine finished with an unhandled error.
	 */
	@:native('LUA_COERR')
	static var COERR:Int;

	/**
	 * Create a new Lua state.
	 *
	 * @param f The memory allocator function.
	 * @param ud User data to be passed to the allocator function.
	 * @return The new Lua state.
	 */
	@:native('lua_newstate')
	static function newstate(f:Lua_Alloc, ud:cpp.RawPointer<cpp.Void>):cpp.RawPointer<Lua_State>;

	/**
	 * Close a Lua state.
	 *
	 * @param L The Lua state to close.
	 */
	@:native('lua_close')
	static function close(L:cpp.RawPointer<Lua_State>):Void;

	/**
	 * Create a new thread.
	 *
	 * @param L The Lua state.
	 * @return The new thread state.
	 */
	@:native('lua_newthread')
	static function newthread(L:cpp.RawPointer<Lua_State>):cpp.RawPointer<Lua_State>;

	/**
	 * Get the top index of the stack.
	 *
	 * @param L The Lua state.
	 * @return The top index of the stack.
	 */
	@:native('lua_gettop')
	static function gettop(L:cpp.RawPointer<Lua_State>):Int;

	/**
	 * Set the top index of the stack.
	 *
	 * @param L The Lua state.
	 * @param idx The new top index.
	 */
	@:native('lua_settop')
	static function settop(L:cpp.RawPointer<Lua_State>, idx:Int):Void;

	/**
	 * Push a value onto the stack.
	 *
	 * @param L The Lua state.
	 * @param idx The index of the value to push.
	 */
	@:native('lua_pushvalue')
	static function pushvalue(L:cpp.RawPointer<Lua_State>, idx:Int):Void;

	/**
	 * Remove a value from the stack.
	 *
	 * @param L The Lua state.
	 * @param idx The index of the value to remove.
	 */
	@:native('lua_remove')
	static function remove(L:cpp.RawPointer<Lua_State>, idx:Int):Void;

	/**
	 * Insert a value into the stack.
	 *
	 * @param L The Lua state.
	 * @param idx The index where the value should be inserted.
	 */
	@:native('lua_insert')
	static function insert(L:cpp.RawPointer<Lua_State>, idx:Int):Void;

	/**
	 * Replace a value in the stack.
	 *
	 * @param L The Lua state.
	 * @param idx The index of the value to replace.
	 */
	@:native('lua_replace')
	static function replace(L:cpp.RawPointer<Lua_State>, idx:Int):Void;

	/**
	 * Copy a value from one index to another.
	 *
	 * @param L The Lua state.
	 * @param fromidx The index of the value to copy.
	 * @param toidx The index where the value should be copied to.
	 */
	inline static function copy(L:cpp.RawPointer<Lua_State>, fromidx:Int, toidx:Int):Void {
		pushvalue(L, fromidx);
		replace(L, toidx);
	}

	/**
	 * Check the stack size.
	 *
	 * @param L The Lua state.
	 * @param sz The stack size to check.
	 * @return 1 if successful, 0 otherwise.
	 */
	@:native('lua_checkstack')
	static function checkstack(L:cpp.RawPointer<Lua_State>, sz:Int):Int;

	/**
	 * Move values between Lua states.
	 *
	 * @param from The source Lua state.
	 * @param to The destination Lua state.
	 * @param n The number of values to move.
	 */
	@:native('lua_xmove')
	static function xmove(from:cpp.RawPointer<Lua_State>, to:cpp.RawPointer<Lua_State>, n:Int):Void;

	/**
	 * Check if a value is a number.
	 *
	 * @param L The Lua state.
	 * @param idx The index of the value to check.
	 * @return 1 if the value is a number, 0 otherwise.
	 */
	@:native('lua_isnumber')
	static function isnumber(L:cpp.RawPointer<Lua_State>, idx:Int):Int;

	/**
	 * Check if a value is a string.
	 *
	 * @param L The Lua state.
	 * @param idx The index of the value to check.
	 * @return 1 if the value is a string, 0 otherwise.
	 */
	@:native('lua_isstring')
	static function isstring(L:cpp.RawPointer<Lua_State>, idx:Int):Int;

	/**
	 * Check if a value is a C function.
	 *
	 * @param L The Lua state.
	 * @param idx The index of the value to check.
	 * @return 1 if the value is a C function, 0 otherwise.
	 */
	@:native('lua_iscfunction')
	static function iscfunction(L:cpp.RawPointer<Lua_State>, idx:Int):Int;

	/**
	 * Check if a value is userdata.
	 *
	 * @param L The Lua state.
	 * @param idx The index of the value to check.
	 * @return 1 if the value is userdata, 0 otherwise.
	 */
	@:native('lua_isuserdata')
	static function isuserdata(L:cpp.RawPointer<Lua_State>, idx:Int):Int;

	/**
	 * Get the type of a value.
	 *
	 * @param L The Lua state.
	 * @param idx The index of the value.
	 * @return The type of the value.
	 */
	@:native('lua_type')
	static function type(L:cpp.RawPointer<Lua_State>, idx:Int):Int;

	/**
	 * Get the name of a type.
	 *
	 * @param L The Lua state.
	 * @param tp The type.
	 * @return The name of the type.
	 */
	@:native('lua_typename')
	static function typename(L:cpp.RawPointer<Lua_State>, tp:Int):cpp.ConstCharStar;

	/**
	 * Check if two values are equal.
	 *
	 * @param L The Lua state.
	 * @param idx1 The index of the first value.
	 * @param idx2 The index of the second value.
	 * @return 1 if equal, 0 otherwise.
	 */
	@:native('lua_equal')
	static function equal(L:cpp.RawPointer<Lua_State>, idx1:Int, idx2:Int):Int;

	/**
	 * Check if two values are raw equal.
	 *
	 * @param L The Lua state.
	 * @param idx1 The index of the first value.
	 * @param idx2 The index of the second value.
	 * @return 1 if raw equal, 0 otherwise.
	 */
	@:native('lua_rawequal')
	static function rawequal(L:cpp.RawPointer<Lua_State>, idx1:Int, idx2:Int):Int;

	/**
	 * Check if one value is less than another.
	 *
	 * @param L The Lua state.
	 * @param idx1 The index of the first value.
	 * @param idx2 The index of the second value.
	 * @return 1 if less than, 0 otherwise.
	 */
	@:native('lua_lessthan')
	static function lessthan(L:cpp.RawPointer<Lua_State>, idx1:Int, idx2:Int):Int;

	/**
	 * Convert a value to a number.
	 *
	 * @param L The Lua state.
	 * @param idx The index of the value.
	 * @return The number.
	 */
	@:native('lua_tonumber')
	static function tonumber(L:cpp.RawPointer<Lua_State>, idx:Int):Lua_Number;

	/**
	 * Convert a value to an integer.
	 *
	 * @param L The Lua state.
	 * @param idx The index of the value.
	 * @return The integer.
	 */
	@:native('lua_tointeger')
	static function tointeger(L:cpp.RawPointer<Lua_State>, idx:Int):Lua_Integer;

	/**
	 * Convert a value to an unsigned integer (convenience macro).
	 * @param L The Lua state.
	 * @param idx The index of the value.
	 * @return The unsigned integer.
	 */
	@:native('lua_tounsigned')
	static function tounsigned(L:cpp.RawPointer<Lua_State>, idx:Int):UInt;

	/**
	 * Convert a value to a boolean.
	 *
	 * @param L The Lua state.
	 * @param idx The index of the value.
	 * @return The boolean.
	 */
	@:native('lua_toboolean')
	static function toboolean(L:cpp.RawPointer<Lua_State>, idx:Int):Int;

	/**
	 * Convert a value to a string.
	 *
	 * @param L The Lua state.
	 * @param idx The index of the value.
	 * @param len The length of the string.
	 * @return The string.
	 */
	@:native('lua_tolstring')
	static function tolstring(L:cpp.RawPointer<Lua_State>, idx:Int, len:cpp.Star<cpp.SizeT>):cpp.ConstCharStar;

	/**
	 * Convert a value to a string and return its atom id.
	 * @param L The Lua state.
	 * @param idx The index of the value.
	 * @param atom Receives the atom id.
	 * @return The string.
	 */
	@:native('lua_tostringatom')
	static function tostringatom(L:cpp.RawPointer<Lua_State>, idx:Int, atom:cpp.RawPointer<Int>):cpp.ConstCharStar;

	/**
	 * Convert a value to a string with length and return its atom id.
	 * @param L The Lua state.
	 * @param idx The index of the value.
	 * @param len Receives the string length.
	 * @param atom Receives the atom id.
	 * @return The string.
	 */
	@:native('lua_tolstringatom')
	static function tolstringatom(L:cpp.RawPointer<Lua_State>, idx:Int, len:cpp.RawPointer<cpp.SizeT>, atom:cpp.RawPointer<Int>):cpp.ConstCharStar;

	/**
	 * Get the namecall method name and its atom id.
	 * @param L The Lua state.
	 * @param atom Receives the atom id.
	 * @return The namecall method name.
	 */
	@:native('lua_namecallatom')
	static function namecallatom(L:cpp.RawPointer<Lua_State>, atom:cpp.RawPointer<Int>):cpp.ConstCharStar;

	/**
	 * Get the length of an object.
	 *
	 * @param L The Lua state.
	 * @param idx The index of the object.
	 * @return The length.
	 */
	@:native('lua_objlen')
	static function objlen(L:cpp.RawPointer<Lua_State>, idx:Int):cpp.SizeT;

	/**
	 * Convert a value to a C function.
	 *
	 * @param L The Lua state.
	 * @param idx The index of the value.
	 * @return The C function.
	 */
	@:native('lua_tocfunction')
	static function tocfunction(L:cpp.RawPointer<Lua_State>, idx:Int):Lua_CFunction;

	/**
	 * Convert a value to userdata.
	 *
	 * @param L The Lua state.
	 * @param idx The index of the value.
	 * @return The userdata.
	 */
	@:native('lua_touserdata')
	static function touserdata(L:cpp.RawPointer<Lua_State>, idx:Int):cpp.RawPointer<cpp.Void>;

	/**
	 * Convert a value to a thread.
	 *
	 * @param L The Lua state.
	 * @param idx The index of the value.
	 * @return The thread.
	 */
	@:native('lua_tothread')
	static function tothread(L:cpp.RawPointer<Lua_State>, idx:Int):cpp.RawPointer<Lua_State>;

	/**
	 * Convert a value to a pointer.
	 *
	 * @param L The Lua state.
	 * @param idx The index of the value.
	 * @return The pointer.
	 */
	@:native('lua_topointer')
	static function topointer(L:cpp.RawPointer<Lua_State>, idx:Int):cpp.RawConstPointer<cpp.Void>;

	/**
	 * Push a nil value onto the stack.
	 *
	 * @param L The Lua state.
	 */
	@:native('lua_pushnil')
	static function pushnil(L:cpp.RawPointer<Lua_State>):Void;

	/**
	 * Push a number onto the stack.
	 *
	 * @param L The Lua state.
	 * @param n The number to push.
	 */
	@:native('lua_pushnumber')
	static function pushnumber(L:cpp.RawPointer<Lua_State>, n:Lua_Number):Void;

	/**
	 * Push an integer onto the stack.
	 *
	 * @param L The Lua state.
	 * @param n The integer to push.
	 */
	@:native('lua_pushinteger')
	static function pushinteger(L:cpp.RawPointer<Lua_State>, n:Lua_Integer):Void;

	/**
	 * Push a string onto the stack.
	 *
	 * @param L The Lua state.
	 * @param s The string to push.
	 * @param len The length of the string.
	 */
	@:native('lua_pushlstring')
	static function pushlstring(L:cpp.RawPointer<Lua_State>, s:cpp.ConstCharStar, len:cpp.SizeT):Void;

	/**
	 * Push a string onto the stack.
	 *
	 * @param L The Lua state.
	 * @param s The string to push.
	 */
	@:native('lua_pushstring')
	static function pushstring(L:cpp.RawPointer<Lua_State>, s:cpp.ConstCharStar):Void;

	/**
	 * Push a formatted string onto the stack.
	 *
	 * @param L The Lua state.
	 * @param s The format string.
	 * @param argp The arguments for the format string.
	 */
	@:native('lua_pushvfstring')
	static function pushvfstring(L:cpp.RawPointer<Lua_State>, s:cpp.ConstCharStar, argp:cpp.VarList):cpp.ConstCharStar;

	/**
	 * Push a formatted string onto the stack.
	 *
	 * @param L The Lua state.
	 * @param fmt The format string.
	 * @param args The arguments for the format string.
	 * @return The formatted string.
	 */
	@:native('lua_pushfstring')
	static function pushfstring(L:cpp.RawPointer<Lua_State>, fmt:cpp.ConstCharStar, args:cpp.Rest<cpp.VarArg>):cpp.ConstCharStar;

	/**
	 * Push a C closure onto the stack.
	 *
	 * @param L The Lua state.
	 * @param fn The C function.
	 * @param debugname Name for debugging / profiling.
	 * @param n The number of upvalues.
	 */
	@:native('lua_pushcclosure')
	static function pushcclosure(L:cpp.RawPointer<Lua_State>, fn:Lua_CFunction, debugname:cpp.ConstCharStar, n:Int):Void;

	/**
	 * Push a C closure onto the stack with a continuation callback.
	 * @param L The Lua state.
	 * @param fn The C function.
	 * @param debugname Name for debugging / profiling.
	 * @param nup The number of upvalues.
	 * @param cont The continuation function (null if not needed).
	 */
	@:native('lua_pushcclosurek')
	static function pushcclosurek(L:cpp.RawPointer<Lua_State>, fn:Lua_CFunction, debugname:cpp.ConstCharStar, nup:Int, cont:Lua_Continuation):Void;

	/**
	 * Push a boolean onto the stack.
	 *
	 * @param L The Lua state.
	 * @param b The boolean to push.
	 */
	@:native('lua_pushboolean')
	static function pushboolean(L:cpp.RawPointer<Lua_State>, b:Int):Void;

	/**
	 * Push light userdata onto the stack.
	 *
	 * @param L The Lua state.
	 * @param p The light userdata to push.
	 */
	@:native('lua_pushlightuserdata')
	static function pushlightuserdata(L:cpp.RawPointer<Lua_State>, p:cpp.RawPointer<cpp.Void>):Void;

	/**
	 * Push the thread onto the stack.
	 *
	 * @param L The Lua state.
	 * @return 1 if the thread is the main thread, 0 otherwise.
	 */
	@:native('lua_pushthread')
	static function pushthread(L:cpp.RawPointer<Lua_State>):Int;

	/**
	 * Get a table from the stack.
	 *
	 * @param L The Lua state.
	 * @param idx The index of the table.
	 * @return The result of the operation.
	 */
	@:native('lua_gettable')
	static function gettable(L:cpp.RawPointer<Lua_State>, idx:Int):Int;

	/**
	 * Get a field from a table.
	 *
	 * @param L The Lua state.
	 * @param idx The index of the table.
	 * @param k The key of the field to get.
	 * @return The result of the operation.
	 */
	@:native('lua_getfield')
	static function getfield(L:cpp.RawPointer<Lua_State>, idx:Int, k:cpp.ConstCharStar):Int;

	/**
	 * Raw get a table.
	 *
	 * @param L The Lua state.
	 * @param idx The index of the table.
	 */
	@:native('lua_rawget')
	static function rawget(L:cpp.RawPointer<Lua_State>, idx:Int):Int;

	/**
	 * Raw get a field from a table.
	 *
	 * @param L The Lua state.
	 * @param idx The index of the table.
	 * @param n The key of the field to get.
	 */
	@:native('lua_rawgeti')
	static function rawgeti(L:cpp.RawPointer<Lua_State>, idx:Int, n:Int):Int;

	/**
	 * Create a new table and push it onto the stack.
	 *
	 * @param L The Lua state.
	 * @param narr The number of array elements.
	 * @param nrec The number of non-array elements.
	 */
	@:native('lua_createtable')
	static function createtable(L:cpp.RawPointer<Lua_State>, narr:Int, nrec:Int):Void;

	/**
	 * Create a new userdata object.
	 *
	 * @param L The Lua state.
	 * @param size The size of the userdata object.
	 * @return A pointer to the new userdata object.
	 */
	@:native('lua_newuserdata')
	static function newuserdata(L:cpp.RawPointer<Lua_State>, size:cpp.SizeT):cpp.RawPointer<cpp.Void>;

	/**
	 * Get the metatable of a value.
	 *
	 * @param L The Lua state.
	 * @param objindex The index of the value.
	 * @return 1 if the value has a metatable, 0 otherwise.
	 */
	@:native('lua_getmetatable')
	static function getmetatable(L:cpp.RawPointer<Lua_State>, objindex:Int):Int;

	/**
	 * Set a table on the stack.
	 *
	 * @param L The Lua state.
	 * @param idx The index of the table.
	 */
	@:native('lua_settable')
	static function settable(L:cpp.RawPointer<Lua_State>, idx:Int):Void;

	/**
	 * Set a field in a table.
	 *
	 * @param L The Lua state.
	 * @param idx The index of the table.
	 * @param k The key of the field to set.
	 */
	@:native('lua_setfield')
	static function setfield(L:cpp.RawPointer<Lua_State>, idx:Int, k:cpp.ConstCharStar):Void;

	/**
	 * Raw set a table.
	 *
	 * @param L The Lua state.
	 * @param idx The index of the table.
	 */
	@:native('lua_rawset')
	static function rawset(L:cpp.RawPointer<Lua_State>, idx:Int):Void;

	/**
	 * Raw set a field in a table.
	 *
	 * @param L The Lua state.
	 * @param idx The index of the table.
	 * @param n The key of the field to set.
	 */
	@:native('lua_rawseti')
	static function rawseti(L:cpp.RawPointer<Lua_State>, idx:Int, n:Int):Void;

	/**
	 * Set the metatable of a value.
	 *
	 * @param L The Lua state.
	 * @param objindex The index of the value.
	 * @return 1 if the value has a metatable, 0 otherwise.
	 */
	@:native('lua_setmetatable')
	static function setmetatable(L:cpp.RawPointer<Lua_State>, objindex:Int):Int;

	/**
	 * Creates a reference to a value.
	 *
	 * @param L The Lua state.
	 * @param t The index of the table.
	 * @return The reference index.
	 */
	@:native('lua_ref')
	static function ref(L:cpp.RawPointer<Lua_State>, t:Int):Int;

	/**
	 * Releases a reference.
	 *
	 * @param L The Lua state.
	 * @param ref The reference index.
	 */
	@:native('lua_unref')
	static function unref(L:cpp.RawPointer<Lua_State>, ref:Int):Void;

	/**
	 * Get a reference from the registry (macro: rawgeti(L, LUA_REGISTRYINDEX, ref)).
	 * @param L The Lua state.
	 * @param ref The reference index (from lua_ref).
	 */
	@:native('lua_getref')
	static function getref(L:cpp.RawPointer<Lua_State>, ref:Int):Int;

	/**
	 * Call a function.
	 *
	 * @param L The Lua state.
	 * @param nargs The number of arguments.
	 * @param nresults The number of results.
	 */
	@:native('lua_call')
	static function call(L:cpp.RawPointer<Lua_State>, nargs:Int, nresults:Int):Void;

	/**
	 * Call a function with error handling.
	 *
	 * @param L The Lua state.
	 * @param nargs The number of arguments.
	 * @param nresults The number of results.
	 * @param errfunc The index of the error handling function.
	 * @return The result of the call.
	 */
	@:native('lua_pcall')
	static function pcall(L:cpp.RawPointer<Lua_State>, nargs:Int, nresults:Int, errfunc:Int):Int;

	/**
	 * Yield a coroutine.
	 *
	 * @param L The Lua state.
	 * @param nresults The number of results to return.
	 * @return The status code.
	 */
	@:native('lua_yield')
	static function yield(L:cpp.RawPointer<Lua_State>, nresults:Int):Int;

	/**
	 * Resume a coroutine.
	 *
	 * @param L The Lua state.
	 * @param from The source Lua state (for Luau).
	 * @param nargs The number of arguments to pass to the coroutine.
	 * @return The status code.
	 */
	@:native('lua_resume')
	static function resume(L:cpp.RawPointer<Lua_State>, from:cpp.RawPointer<Lua_State>, nargs:Int):Int;

	/**
	 * Get the status of a coroutine.
	 *
	 * @param L The Lua state.
	 * @return The status code.
	 */
	@:native('lua_status')
	static function status(L:cpp.RawPointer<Lua_State>):Int;

	/**
	 * Stop the garbage collector.
	 */
	@:native('LUA_GCSTOP')
	static var GCSTOP:Int;

	/**
	 * Restart the garbage collector.
	 */
	@:native('LUA_GCRESTART')
	static var GCRESTART:Int;

	/**
	 * Perform a full garbage-collection cycle.
	 */
	@:native('LUA_GCCOLLECT')
	static var GCCOLLECT:Int;

	/**
	 * Get the total memory in use by Lua in Kbytes.
	 */
	@:native('LUA_GCCOUNT')
	static var GCCOUNT:Int;

	/**
	 * Garbage collection step in bytes.
	 */
	@:native('LUA_GCCOUNTB')
	static var GCCOUNTB:Int;

	/**
	 * Perform a garbage collection step.
	 */
	@:native('LUA_GCSTEP')
	static var GCSTEP:Int;

	/**
	 * Set the garbage collector's step multiplier.
	 */
	@:native('LUA_GCSETSTEPMUL')
	static var GCSETSTEPMUL:Int;

	/**
	 * Check if the garbage collector is running.
	 */
	@:native('LUA_GCISRUNNING')
	static var GCISRUNNING:Int;

	/**
	 * Perform a garbage collection operation.
	 *
	 * @param L The Lua state.
	 * @param what The operation to perform.
	 * @param data The data for the operation.
	 * @return The result of the operation.
	 */
	@:native('lua_gc')
	static function gc(L:cpp.RawPointer<Lua_State>, what:Int, data:Int):Int;

	/**
	 * Set the GC goal (heap size target = goal% of live data).
	 */
	@:native('LUA_GCSETGOAL')
	static var GCSETGOAL:Int;

	/**
	 * Set the GC step size in KB.
	 */
	@:native('LUA_GCSETSTEPSIZE')
	static var GCSETSTEPSIZE:Int;

	/**
	 * Get the total memory allocated in a memory category.
	 *
	 * @param L The Lua state.
	 * @param category The memory category (0..LUA_MEMORY_CATEGORIES-1).
	 * @return The total allocated bytes.
	 */
	@:native('lua_totalbytes')
	static function totalbytes(L:cpp.RawPointer<Lua_State>, category:Int):cpp.SizeT;

	/**
	 * Set the memory category for subsequent allocations.
	 *
	 * @param L The Lua state.
	 * @param category The memory category.
	 */
	@:native('lua_setmemcat')
	static function setmemcat(L:cpp.RawPointer<Lua_State>, category:Int):Void;

	/**
	 * Set whether a table is read-only.
	 *
	 * @param L The Lua state.
	 * @param idx The stack index of the table.
	 * @param enabled 1 to set read-only, 0 to make writable.
	 */
	@:native('lua_setreadonly')
	static function setreadonly(L:cpp.RawPointer<Lua_State>, idx:Int, enabled:Int):Void;

	/**
	 * Check if a table is read-only.
	 *
	 * @param L The Lua state.
	 * @param idx The stack index of the table.
	 * @return 1 if read-only, 0 otherwise.
	 */
	@:native('lua_getreadonly')
	static function getreadonly(L:cpp.RawPointer<Lua_State>, idx:Int):Int;

	/**
	 * Set whether a table is a safe environment.
	 *
	 * @param L The Lua state.
	 * @param idx The stack index of the table.
	 * @param enabled 1 to mark safe, 0 to unmark.
	 */
	@:native('lua_setsafeenv')
	static function setsafeenv(L:cpp.RawPointer<Lua_State>, idx:Int, enabled:Int):Void;

	/**
	 * Clone the function at the given index.
	 *
	 * @param L The Lua state.
	 * @param idx The stack index of the function to clone.
	 */
	@:native('lua_clonefunction')
	static function clonefunction(L:cpp.RawPointer<Lua_State>, idx:Int):Void;

	/**
	 * Clone the table at the given index.
	 *
	 * @param L The Lua state.
	 * @param idx The stack index of the table to clone.
	 */
	@:native('lua_clonetable')
	static function clonetable(L:cpp.RawPointer<Lua_State>, idx:Int):Void;

	/**
	 * Clear all entries from the table at the given index.
	 *
	 * @param L The Lua state.
	 * @param idx The stack index of the table to clear.
	 */
	@:native('lua_cleartable')
	static function cleartable(L:cpp.RawPointer<Lua_State>, idx:Int):Void;

	/**
	 * Raise a Lua error.
	 *
	 * @param L The Lua state.
	 * @return The error code.
	 */
	@:native('lua_error')
	static function error(L:cpp.RawPointer<Lua_State>):Void;

	/**
	 * Get the next key-value pair from the table at the given index.
	 *
	 * @param L The Lua state.
	 * @param idx The index of the table.
	 * @return 1 if there are more elements, 0 if there are no more elements.
	 */
	@:native('lua_next')
	static function next(L:cpp.RawPointer<Lua_State>, idx:Int):Int;

	/**
	 * Concatenate values.
	 *
	 * @param L The Lua state.
	 * @param n The number of values to concatenate.
	 */
	@:native('lua_concat')
	static function concat(L:cpp.RawPointer<Lua_State>, n:Int):Void;

	/**
	 * Get the memory allocator function.
	 *
	 * @param L The Lua state.
	 * @param ud User data.
	 * @return The memory allocator function.
	 */
	@:native('lua_getallocf')
	static function getallocf(L:cpp.RawPointer<Lua_State>, ud:cpp.RawPointer<cpp.RawPointer<cpp.Void>>):Lua_Alloc;

	// /**
	//  * Set the memory allocator function.
	//  *
	//  * @param L The Lua state.
	//  * @param f The memory allocator function.
	//  * @param ud User data.
	//  */
	// @:native('lua_setallocf')
	// static function setallocf(L:cpp.RawPointer<Lua_State>, f:Lua_Alloc, ud:cpp.RawPointer<cpp.Void>):Void;

	/**
	 * Pop n elements from the stack.
	 *
	 * @param L The Lua state.
	 * @param n The number of elements to pop.
	 */
	@:native('lua_pop')
	static function pop(L:cpp.RawPointer<Lua_State>, n:Int):Void;

	/**
	 * Create a new table.
	 *
	 * @param L The Lua state.
	 */
	@:native('lua_newtable')
	static function newtable(L:cpp.RawPointer<Lua_State>):Void;

	/**
	 * Register functions into a table.
	 *
	 * @param L The Lua state.
	 * @param name The library name (NULL to register into caller's table).
	 * @param l The array of name-function pairs.
	 */
	@:native('luaL_register')
	static function register(L:cpp.RawPointer<Lua_State>, name:cpp.ConstCharStar, l:cpp.RawConstPointer<LuaL_Reg>):Void;

	/**
	 * Push a C function onto the stack.
	 *
	 * @param L The Lua state.
	 * @param fn The C function to push.
	 * @param debugname The debug name for the function.
	 */
	@:native('lua_pushcfunction')
	static function pushcfunction(L:cpp.RawPointer<Lua_State>, fn:Lua_CFunction, debugname:cpp.ConstCharStar):Void;

	/**
	 * Get the length of the value at the given index.
	 *
	 * @param L The Lua state.
	 * @param idx The index of the value.
	 * @return The length of the value.
	 */
	@:native('lua_strlen')
	static function strlen(L:cpp.RawPointer<Lua_State>, idx:Int):cpp.SizeT;

	/**
	 * Check if the value at the given index is a function.
	 *
	 * @param L The Lua state.
	 * @param n The index of the value.
	 * @return 1 if the value is a function, 0 otherwise.
	 */
	@:native('lua_isfunction')
	static function isfunction(L:cpp.RawPointer<Lua_State>, n:Int):Int;

	/**
	 * Check if the value at the given index is a table.
	 *
	 * @param L The Lua state.
	 * @param n The index of the value.
	 * @return 1 if the value is a table, 0 otherwise.
	 */
	@:native('lua_istable')
	static function istable(L:cpp.RawPointer<Lua_State>, n:Int):Int;

	/**
	 * Check if the value at the given index is a light userdata.
	 *
	 * @param L The Lua state.
	 * @param n The index of the value.
	 * @return 1 if the value is a light userdata, 0 otherwise.
	 */
	@:native('lua_islightuserdata')
	static function islightuserdata(L:cpp.RawPointer<Lua_State>, n:Int):Int;

	/**
	 * Check if the value at the given index is nil.
	 *
	 * @param L The Lua state.
	 * @param n The index of the value.
	 * @return 1 if the value is nil, 0 otherwise.
	 */
	@:native('lua_isnil')
	static function isnil(L:cpp.RawPointer<Lua_State>, n:Int):Int;

	/**
	 * Check if the value at the given index is a boolean.
	 *
	 * @param L The Lua state.
	 * @param n The index of the value.
	 * @return 1 if the value is a boolean, 0 otherwise.
	 */
	@:native('lua_isboolean')
	static function isboolean(L:cpp.RawPointer<Lua_State>, n:Int):Int;

	/**
	 * Check if the value at the given index is a thread.
	 *
	 * @param L The Lua state.
	 * @param n The index of the value.
	 * @return 1 if the value is a thread, 0 otherwise.
	 */
	@:native('lua_isthread')
	static function isthread(L:cpp.RawPointer<Lua_State>, n:Int):Int;

	/**
	 * Check if the value at the given index is a vector.
	 * @param L The Lua state.
	 * @param n The index of the value.
	 * @return 1 if the value is a vector, 0 otherwise.
	 */
	@:native('lua_isvector')
	static function isvector(L:cpp.RawPointer<Lua_State>, n:Int):Int;

	/**
	 * Check if the value at the given index is a buffer.
	 * @param L The Lua state.
	 * @param n The index of the value.
	 * @return 1 if the value is a buffer, 0 otherwise.
	 */
	@:native('lua_isbuffer')
	static function isbuffer(L:cpp.RawPointer<Lua_State>, n:Int):Int;

	/**
	 * Check if the value at the given index is a class.
	 * @param L The Lua state.
	 * @param n The index of the value.
	 * @return 1 if the value is a class, 0 otherwise.
	 */
	@:native('lua_isclass')
	static function isclass(L:cpp.RawPointer<Lua_State>, n:Int):Int;

	/**
	 * Check if the value at the given index is an object.
	 * @param L The Lua state.
	 * @param n The index of the value.
	 * @return 1 if the value is an object, 0 otherwise.
	 */
	@:native('lua_isobject')
	static function isobject(L:cpp.RawPointer<Lua_State>, n:Int):Int;

	/**
	 * Check if the value at the given index is none.
	 *
	 * @param L The Lua state.
	 * @param n The index of the value.
	 * @return 1 if the value is none, 0 otherwise.
	 */
	@:native('lua_isnone')
	static function isnone(L:cpp.RawPointer<Lua_State>, n:Int):Int;

	/**
	 * Check if the value at the given index is none or nil.
	 *
	 * @param L The Lua state.
	 * @param n The index of the value.
	 * @return 1 if the value is none or nil, 0 otherwise.
	 */
	@:native('lua_isnoneornil')
	static function isnoneornil(L:cpp.RawPointer<Lua_State>, n:Int):Int;

	/**
	 * Push a literal string onto the stack.
	 *
	 * @param L The Lua state.
	 * @param s The literal string.
	 */
	@:native('lua_pushliteral')
	static function pushliteral(L:cpp.RawPointer<Lua_State>, s:cpp.ConstCharStar):Void;

	/**
	 * Set a global value.
	 *
	 * @param L The Lua state.
	 * @param s The name of the global.
	 * @return The result of the operation.
	 */
	@:native('lua_setglobal')
	static function setglobal(L:cpp.RawPointer<Lua_State>, s:cpp.ConstCharStar):Void;

	/**
	 * Get a global value.
	 *
	 * @param L The Lua state.
	 * @param s The name of the global.
	 * @return The result of the operation.
	 */
	@:native('lua_getglobal')
	static function getglobal(L:cpp.RawPointer<Lua_State>, s:cpp.ConstCharStar):Int;

	/**
	 * Convert a Lua value to a string.
	 *
	 * @param L The Lua state.
	 * @param i The index of the value.
	 * @return The converted string.
	 */
	@:native('lua_tostring')
	static function tostring(L:cpp.RawPointer<Lua_State>, i:Int):cpp.ConstCharStar;

	// /**
	//  * Get the registry table.
	//  *
	//  * @param L The Lua state.
	//  */
	// @:native('lua_getregistry')
	// static function getregistry(L:cpp.RawPointer<Lua_State>):Void;

	/**
	 * Get the main thread of the given state.
	 * @param L The Lua state.
	 * @return The main thread.
	 */
	@:native('lua_mainthread')
	static function mainthread(L:cpp.RawPointer<Lua_State>):cpp.RawPointer<Lua_State>;

	/**
	 * Reset a thread, clearing its stack and call info.
	 * @param L The Lua state (thread) to reset.
	 */
	@:native('lua_resetthread')
	static function resetthread(L:cpp.RawPointer<Lua_State>):Void;

	/**
	 * Check if a thread is in reset state.
	 * @param L The Lua state.
	 * @return 1 if the thread is reset, 0 otherwise.
	 */
	@:native('lua_isthreadreset')
	static function isthreadreset(L:cpp.RawPointer<Lua_State>):Int;

	/**
	 * Convert any stack index to an absolute index.
	 * @param L The Lua state.
	 * @param idx The stack index (pseudo-indices accepted).
	 * @return The absolute index.
	 */
	@:native('lua_absindex')
	static function absindex(L:cpp.RawPointer<Lua_State>, idx:Int):Int;

	/**
	 * Raw check stack space (no error handler).
	 * @param L The Lua state.
	 * @param sz The number of additional slots.
	 */
	@:native('lua_rawcheckstack')
	static function rawcheckstack(L:cpp.RawPointer<Lua_State>, sz:Int):Void;

	/**
	 * Push a value from one state onto another.
	 * @param from Source Lua state.
	 * @param to Destination Lua state.
	 * @param idx Index in the source state.
	 */
	@:native('lua_xpush')
	static function xpush(from:cpp.RawPointer<Lua_State>, to:cpp.RawPointer<Lua_State>, idx:Int):Void;

	/**
	 * Call a C function in protected mode (like pcall for C).
	 * @param L The Lua state.
	 * @param func The C function.
	 * @param ud Userdata passed to func.
	 * @return 0 on success, error code on failure.
	 */
	@:native('lua_cpcall')
	static function cpcall(L:cpp.RawPointer<Lua_State>, func:Lua_CFunction, ud:cpp.RawPointer<cpp.Void>):Int;

	/**
	 * Check if a value is a 64-bit integer.
	 * @param L The Lua state.
	 * @param idx Stack index.
	 * @return 1 if int64, 0 otherwise.
	 */
	@:native('lua_isinteger64')
	static function isinteger64(L:cpp.RawPointer<Lua_State>, idx:Int):Int;

	/**
	 * Check if a value is a Lua function (not C function).
	 * @param L The Lua state.
	 * @param idx Stack index.
	 * @return 1 if Lua function, 0 otherwise.
	 */
	@:native('lua_isLfunction')
	static function isLfunction(L:cpp.RawPointer<Lua_State>, idx:Int):Int;

	/**
	 * Convert value to number with error flag.
	 * @param L The Lua state.
	 * @param idx Stack index.
	 * @param isnum Receives 1 if valid conversion.
	 * @return The number.
	 */
	@:native('lua_tonumberx')
	static function tonumberx(L:cpp.RawPointer<Lua_State>, idx:Int, isnum:cpp.RawPointer<Int>):Lua_Number;

	/**
	 * Convert value to integer with error flag.
	 * @param L The Lua state.
	 * @param idx Stack index.
	 * @param isnum Receives 1 if valid conversion.
	 * @return The integer.
	 */
	@:native('lua_tointegerx')
	static function tointegerx(L:cpp.RawPointer<Lua_State>, idx:Int, isnum:cpp.RawPointer<Int>):Lua_Integer;

	/**
	 * Convert value to unsigned integer with error flag.
	 * @param L The Lua state.
	 * @param idx Stack index.
	 * @param isnum Receives 1 if valid conversion.
	 * @return The unsigned integer.
	 */
	@:native('lua_tounsignedx')
	static function tounsignedx(L:cpp.RawPointer<Lua_State>, idx:Int, isnum:cpp.RawPointer<Int>):UInt;

	/**
	 * Get the vector at the given index.
	 * @param L The Lua state.
	 * @param idx Stack index.
	 * @return Pointer to 3 (or 4) floats, or null.
	 */
	@:native('lua_tovector')
	static function tovector(L:cpp.RawPointer<Lua_State>, idx:Int):cpp.RawConstPointer<Single>;

	/**
	 * Convert value to 64-bit integer.
	 * @param L The Lua state.
	 * @param idx Stack index.
	 * @param isinteger Receives 1 if value was integer.
	 * @return The int64 value.
	 */
	@:native('lua_tointeger64')
	static function tointeger64(L:cpp.RawPointer<Lua_State>, idx:Int, isinteger:cpp.RawPointer<Int>):haxe.Int64;

	/**
	 * Get the buffer and its length at the given index.
	 * @param L The Lua state.
	 * @param idx Stack index.
	 * @param len Receives the buffer length.
	 * @return Pointer to the buffer data.
	 */
	@:native('lua_tobuffer')
	static function tobuffer(L:cpp.RawPointer<Lua_State>, idx:Int, len:cpp.RawPointer<cpp.SizeT>):cpp.RawPointer<cpp.Void>;

	/**
	 * Convert value to a light userdata pointer.
	 * @param L The Lua state.
	 * @param idx Stack index.
	 * @return The pointer, or null.
	 */
	@:native('lua_tolightuserdata')
	static function tolightuserdata(L:cpp.RawPointer<Lua_State>, idx:Int):cpp.RawPointer<cpp.Void>;

	/**
	 * Push a 64-bit integer onto the stack.
	 * @param L The Lua state.
	 * @param n The int64 value.
	 */
	@:native('lua_pushinteger64')
	static function pushinteger64(L:cpp.RawPointer<Lua_State>, n:haxe.Int64):Void;

	/**
	 * Push an unsigned integer onto the stack.
	 * @param L The Lua state.
	 * @param n The unsigned value.
	 */
	@:native('lua_pushunsigned')
	static function pushunsigned(L:cpp.RawPointer<Lua_State>, n:UInt):Void;

	/**
	 * Push a vector (3-component) onto the stack.
	 * @param L The Lua state.
	 * @param x The x component.
	 * @param y The y component.
	 * @param z The z component.
	 */
	@:native('lua_pushvector')
	static function pushvector(L:cpp.RawPointer<Lua_State>, x:Float, y:Float, z:Float):Void;

	/**
	 * Create and push a new buffer.
	 * @param L The Lua state.
	 * @param sz Initial buffer size.
	 * @return Pointer to the buffer data.
	 */
	@:native('lua_newbuffer')
	static function newbuffer(L:cpp.RawPointer<Lua_State>, sz:cpp.SizeT):cpp.RawPointer<cpp.Void>;

	/**
	 * Push a tagged light userdata pointer.
	 * @param L The Lua state.
	 * @param p The pointer.
	 * @param tag The tag id.
	 */
	@:native('lua_pushlightuserdatatagged')
	static function pushlightuserdatatagged(L:cpp.RawPointer<Lua_State>, p:cpp.RawPointer<cpp.Void>, tag:Int):Void;

	/**
	 * Raw get a table field by string key (no metamethods).
	 * @param L The Lua state.
	 * @param idx The table index.
	 * @param k The field name.
	 * @return The type of the pushed value.
	 */
	@:native('lua_rawgetfield')
	static function rawgetfield(L:cpp.RawPointer<Lua_State>, idx:Int, k:cpp.ConstCharStar):Int;

	/**
	 * Raw set a table field by string key (no metamethods).
	 * @param L The Lua state.
	 * @param idx The table index.
	 * @param k The field name.
	 */
	@:native('lua_rawsetfield')
	static function rawsetfield(L:cpp.RawPointer<Lua_State>, idx:Int, k:cpp.ConstCharStar):Void;

	/**
	 * Get the environment of a value.
	 * @param L The Lua state.
	 * @param idx Stack index.
	 */
	@:native('lua_getfenv')
	static function getfenv(L:cpp.RawPointer<Lua_State>, idx:Int):Void;

	/**
	 * Set the environment of a value.
	 * @param L The Lua state.
	 * @param idx Stack index.
	 * @return 1 on success, 0 on failure.
	 */
	@:native('lua_setfenv')
	static function setfenv(L:cpp.RawPointer<Lua_State>, idx:Int):Int;

	/**
	 * Raw table iterator. Returns the next key index or 0 at end.
	 * @param L The Lua state.
	 * @param idx The table index.
	 * @param iter Previous key (0 to start).
	 * @return Next key index, or 0 at end.
	 */
	@:native('lua_rawiter')
	static function rawiter(L:cpp.RawPointer<Lua_State>, idx:Int, iter:Int):Int;

	/**
	 * Raw get table entry by tagged pointer key.
	 * @param L The Lua state.
	 * @param idx The table index.
	 * @param p The pointer key.
	 * @param tag The tag id.
	 */
	@:native('lua_rawgetptagged')
	static function rawgetptagged(L:cpp.RawPointer<Lua_State>, idx:Int, p:cpp.RawPointer<cpp.Void>, tag:Int):Int;

	/**
	 * Raw get table entry by pointer key (macro: rawgetptagged with tag 0).
	 * @param L The Lua state.
	 * @param idx The table index.
	 * @param p The pointer key.
	 * @return The type of the pushed value.
	 */
	@:native('lua_rawgetp')
	static function rawgetp(L:cpp.RawPointer<Lua_State>, idx:Int, p:cpp.RawPointer<cpp.Void>):Int;

	/**
	 * Raw set table entry by tagged pointer key.
	 * @param L The Lua state.
	 * @param idx The table index.
	 * @param p The pointer key.
	 * @param tag The tag id.
	 */
	@:native('lua_rawsetptagged')
	static function rawsetptagged(L:cpp.RawPointer<Lua_State>, idx:Int, p:cpp.RawPointer<cpp.Void>, tag:Int):Void;

	/**
	 * Raw set table entry by pointer key (macro: rawsetptagged with tag 0).
	 * @param L The Lua state.
	 * @param idx The table index.
	 * @param p The pointer key.
	 */
	@:native('lua_rawsetp')
	static function rawsetp(L:cpp.RawPointer<Lua_State>, idx:Int, p:cpp.RawPointer<cpp.Void>):Void;

	/**
	 * Yield for a debug breakpoint.
	 * @param L The Lua state.
	 * @return LUA_YIELD.
	 */
	@:native('lua_break')
	static function lua_break(L:cpp.RawPointer<Lua_State>):Int;

	/**
	 * Resume error handling after a failed resume.
	 * @param L The Lua state.
	 * @param from The source state.
	 * @return Error status.
	 */
	@:native('lua_resumeerror')
	static function resumeerror(L:cpp.RawPointer<Lua_State>, from:cpp.RawPointer<Lua_State>):Int;

	/**
	 * Check if the current thread can yield.
	 * @param L The Lua state.
	 * @return 1 if yieldable, 0 otherwise.
	 */
	@:native('lua_isyieldable')
	static function isyieldable(L:cpp.RawPointer<Lua_State>):Int;

	/**
	 * Get thread-local data pointer.
	 * @param L The Lua state.
	 * @return The thread-local data.
	 */
	@:native('lua_getthreaddata')
	static function getthreaddata(L:cpp.RawPointer<Lua_State>):cpp.RawPointer<cpp.Void>;

	/**
	 * Set thread-local data pointer.
	 * @param L The Lua state.
	 * @param data The thread-local data.
	 */
	@:native('lua_setthreaddata')
	static function setthreaddata(L:cpp.RawPointer<Lua_State>, data:cpp.RawPointer<cpp.Void>):Void;

	/**
	 * Get coroutine status with more detail than lua_status.
	 * @param L The Lua state.
	 * @param co The coroutine to check.
	 * @return One of CORUN/COSUS/CONOR/COFIN/COERR.
	 */
	@:native('lua_costatus')
	static function costatus(L:cpp.RawPointer<Lua_State>, co:cpp.RawPointer<Lua_State>):Int;

	/**
	 * Get a tagged userdata pointer, returning null on tag mismatch.
	 * @param L The Lua state.
	 * @param idx Stack index.
	 * @param tag The expected tag.
	 * @return The userdata block, or null.
	 */
	@:native('lua_touserdatatagged')
	static function touserdatatagged(L:cpp.RawPointer<Lua_State>, idx:Int, tag:Int):cpp.RawPointer<cpp.Void>;

	/**
	 * Get the tag of a userdata.
	 * @param L The Lua state.
	 * @param idx Stack index.
	 * @return The tag id.
	 */
	@:native('lua_userdatatag')
	static function userdatatag(L:cpp.RawPointer<Lua_State>, idx:Int):Int;

	/**
	 * Get a tagged light userdata pointer (checks tag mismatch).
	 * @param L The Lua state.
	 * @param idx Stack index.
	 * @param tag The expected tag.
	 * @return The pointer, or null.
	 */
	@:native('lua_tolightuserdatatagged')
	static function tolightuserdatatagged(L:cpp.RawPointer<Lua_State>, idx:Int, tag:Int):cpp.RawPointer<cpp.Void>;

	/**
	 * Get the tag of a light userdata.
	 * @param L The Lua state.
	 * @param idx Stack index.
	 * @return The tag id.
	 */
	@:native('lua_lightuserdatatag')
	static function lightuserdatatag(L:cpp.RawPointer<Lua_State>, idx:Int):Int;

	/**
	 * Change the tag of a userdata at the given index.
	 * @param L The Lua state.
	 * @param idx Stack index.
	 * @param tag The new tag id.
	 */
	@:native('lua_setuserdatatag')
	static function setuserdatatag(L:cpp.RawPointer<Lua_State>, idx:Int, tag:Int):Void;

	/**
	 * Associate a metatable with a userdata tag.
	 * @param L The Lua state.
	 * @param tag The userdata tag.
	 */
	@:native('lua_setuserdatametatable')
	static function setuserdatametatable(L:cpp.RawPointer<Lua_State>, tag:Int):Void;

	/**
	 * Get the metatable associated with a userdata tag.
	 * @param L The Lua state.
	 * @param tag The userdata tag.
	 */
	@:native('lua_getuserdatametatable')
	static function getuserdatametatable(L:cpp.RawPointer<Lua_State>, tag:Int):Void;

	/**
	 * Register direct userdata access callbacks for __index, __newindex and __namecall.
	 * @param L The Lua state.
	 * @param tag The userdata tag.
	 * @param get Getter callback (nullable).
	 * @param set Setter callback (nullable).
	 * @param namecall Namecall callback (nullable).
	 * @return 1 on success, 0 on failure.
	 */
	@:native('lua_registeruserdatadirectaccess')
	static function registeruserdatadirectaccess(L:cpp.RawPointer<Lua_State>, tag:Int, get:Lua_UserdataDirectAccess, set:Lua_UserdataDirectAccess, namecall:Lua_UserdataDirectNamecall):Int;

	/**
	 * Register a direct field getter for a specific userdata tag + field name.
	 * @param L The Lua state.
	 * @param tag The userdata tag.
	 * @param field The field name to bind.
	 * @param fn The direct field getter callback.
	 */
	@:native('lua_registeruserdatadirectfieldget')
	static function registeruserdatadirectfieldget(L:cpp.RawPointer<Lua_State>, tag:Int, field:cpp.ConstCharStar, fn:Lua_UserdataDirectFieldGet):Void;

	/**
	 * Set a direct-field result to a number value.
	 * @param result Opaque TValue output slot.
	 * @param n The number value.
	 */
	@:native('lua_userdatadirectfield_setnumber')
	static function userdatadirectfield_setnumber(result:cpp.RawPointer<cpp.Void>, n:Lua_Number):Void;

	/**
	 * Set a direct-field result to a vector value.
	 * @param result Opaque TValue output slot.
	 * @param x X component.
	 * @param y Y component.
	 * @param z Z component.
	 */
	@:native('lua_userdatadirectfield_setvector')
	static function userdatadirectfield_setvector(result:cpp.RawPointer<cpp.Void>, x:Float, y:Float, z:Float):Void;

	/**
	 * Set a direct-field result to a boolean value.
	 * @param result Opaque TValue output slot.
	 * @param b The boolean value.
	 */
	@:native('lua_userdatadirectfield_setboolean')
	static function userdatadirectfield_setboolean(result:cpp.RawPointer<cpp.Void>, b:Int):Void;

	/**
	 * Set a direct-field result to a 64-bit integer value.
	 * @param result Opaque TValue output slot.
	 * @param n The integer value.
	 */
	@:native('lua_userdatadirectfield_setinteger64')
	static function userdatadirectfield_setinteger64(result:cpp.RawPointer<cpp.Void>, n:haxe.Int64):Void;

	/**
	 * Set a direct-field result to nil.
	 * @param result Opaque TValue output slot.
	 */
	@:native('lua_userdatadirectfield_setnil')
	static function userdatadirectfield_setnil(result:cpp.RawPointer<cpp.Void>):Void;

	/**
	 * Create and push a tagged userdata block.
	 * @param L The Lua state.
	 * @param sz The block size.
	 * @param tag The userdata tag.
	 * @return Pointer to the new block.
	 */
	@:native('lua_newuserdatatagged')
	static function newuserdatatagged(L:cpp.RawPointer<Lua_State>, sz:cpp.SizeT, tag:Int):cpp.RawPointer<cpp.Void>;

	/**
	 * Create and push a tagged userdata with its pre-registered metatable.
	 * @param L The Lua state.
	 * @param sz The block size.
	 * @param tag The userdata tag.
	 * @return Pointer to the new block.
	 */
	@:native('lua_newuserdatataggedwithmetatable')
	static function newuserdatataggedwithmetatable(L:cpp.RawPointer<Lua_State>, sz:cpp.SizeT, tag:Int):cpp.RawPointer<cpp.Void>;

	/**
	 * Set a human-readable name for a light userdata tag.
	 * @param L The Lua state.
	 * @param tag The light userdata tag.
	 * @param name The display name.
	 */
	@:native('lua_setlightuserdataname')
	static function setlightuserdataname(L:cpp.RawPointer<Lua_State>, tag:Int, name:cpp.ConstCharStar):Void;

	/**
	 * Get the human-readable name for a light userdata tag.
	 * @param L The Lua state.
	 * @param tag The light userdata tag.
	 * @return The display name.
	 */
	@:native('lua_getlightuserdataname')
	static function getlightuserdataname(L:cpp.RawPointer<Lua_State>, tag:Int):cpp.ConstCharStar;

	/**
	 * Encode a pointer for safe use as a table key.
	 * @param L The Lua state.
	 * @param p The pointer value.
	 * @return The encoded value.
	 */
	@:native('lua_encodepointer')
	static function encodepointer(L:cpp.RawPointer<Lua_State>, p:cpp.SizeT):cpp.SizeT;

	/**
	 * Get wall-clock time in seconds (no state needed).
	 * @return Current time as a Lua_Number.
	 */
	@:native('lua_clock')
	static function clock():Lua_Number;

	/**
	 * Get the callbacks struct for a Lua state, allowing customization
	 * of interrupt, panic, debug hooks, etc.
	 * @param L The Lua state.
	 * @return Pointer to the lua_Callbacks struct.
	 */
	@:native('lua_callbacks')
	static function callbacks(L:cpp.RawPointer<Lua_State>):cpp.RawPointer<Lua_Callbacks>;

	/**
	 * Get the current stack depth.
	 * @param L The Lua state.
	 * @return The stack depth.
	 */
	@:native('lua_stackdepth')
	static function stackdepth(L:cpp.RawPointer<Lua_State>):Int;

	/**
	 * Get debug info about a function at a stack level.
	 * @param L The Lua state.
	 * @param level Stack level (0 = current function).
	 * @param what Info flags: "n", "s", "l", "u", "a", "f".
	 * @param ar The debug struct to fill.
	 * @return 1 on success, 0 on failure.
	 */
	@:native('lua_getinfo')
	static function getinfo(L:cpp.RawPointer<Lua_State>, level:Int, what:cpp.ConstCharStar, ar:cpp.RawPointer<Lua_Debug>):Int;

	/**
	 * Get a function argument at a given stack level.
	 * @param L The Lua state.
	 * @param level Stack level.
	 * @param n Argument index (1-based).
	 * @return Type of the pushed value.
	 */
	@:native('lua_getargument')
	static function getargument(L:cpp.RawPointer<Lua_State>, level:Int, n:Int):Int;

	/**
	 * Get the name of a local variable at a stack level.
	 * @param L The Lua state.
	 * @param level Stack level.
	 * @param n Local variable index.
	 * @return Variable name, or null if out of range.
	 */
	@:native('lua_getlocal')
	static function getlocal(L:cpp.RawPointer<Lua_State>, level:Int, n:Int):cpp.ConstCharStar;

	/**
	 * Set the value of a local variable at a stack level.
	 * @param L The Lua state.
	 * @param level Stack level.
	 * @param n Local variable index.
	 * @return Variable name, or null if out of range.
	 */
	@:native('lua_setlocal')
	static function setlocal(L:cpp.RawPointer<Lua_State>, level:Int, n:Int):cpp.ConstCharStar;

	/**
	 * Get the name of an upvalue.
	 * @param L The Lua state.
	 * @param funcindex Function stack index.
	 * @param n Upvalue index (1-based).
	 * @return Upvalue name, or null if out of range.
	 */
	@:native('lua_getupvalue')
	static function getupvalue(L:cpp.RawPointer<Lua_State>, funcindex:Int, n:Int):cpp.ConstCharStar;

	/**
	 * Set the value of an upvalue.
	 * @param L The Lua state.
	 * @param funcindex Function stack index.
	 * @param n Upvalue index (1-based).
	 * @return Upvalue name, or null if out of range.
	 */
	@:native('lua_setupvalue')
	static function setupvalue(L:cpp.RawPointer<Lua_State>, funcindex:Int, n:Int):cpp.ConstCharStar;

	/**
	 * Enable or disable single-stepping for the debugger.
	 * @param L The Lua state.
	 * @param enabled 1 to enable, 0 to disable.
	 */
	@:native('lua_singlestep')
	static function singlestep(L:cpp.RawPointer<Lua_State>, enabled:Int):Void;

	/**
	 * Set or clear a breakpoint in a function.
	 * @param L The Lua state.
	 * @param funcindex Function stack index.
	 * @param line Line number.
	 * @param enabled 1 to set, 0 to clear.
	 * @return 1 if successful, 0 otherwise.
	 */
	@:native('lua_breakpoint')
	static function breakpoint(L:cpp.RawPointer<Lua_State>, funcindex:Int, line:Int, enabled:Int):Int;

	/**
	 * Get a debug stack trace string. Not thread-safe!
	 * @param L The Lua state.
	 * @return The trace string.
	 */
	@:native('lua_debugtrace')
	static function debugtrace(L:cpp.RawPointer<Lua_State>):cpp.ConstCharStar;

	/**
	 * Register a destructor callback for a userdata tag.
	 * @param L The Lua state.
	 * @param tag The userdata tag.
	 * @param dtor The destructor function.
	 */
	@:native('lua_setuserdatadtor')
	static function setuserdatadtor(L:cpp.RawPointer<Lua_State>, tag:Int, dtor:Lua_Destructor):Void;

	/**
	 * Get the destructor callback for a userdata tag.
	 * @param L The Lua state.
	 * @param tag The userdata tag.
	 * @return The destructor function.
	 */
	@:native('lua_getuserdatadtor')
	static function getuserdatadtor(L:cpp.RawPointer<Lua_State>, tag:Int):Lua_Destructor;

	/**
	 * Create and push a userdata with a custom destructor.
	 * @param L The Lua state.
	 * @param sz The block size.
	 * @param dtor Destructor called when GC'd.
	 * @return Pointer to the new userdata block.
	 */
	@:native('lua_newuserdatadtor')
	static function newuserdatadtor(L:cpp.RawPointer<Lua_State>, sz:cpp.SizeT, dtor:cpp.Callable<(raw:cpp.RawPointer<cpp.Void>) -> Void>):cpp.RawPointer<cpp.Void>;

	/**
	 * Retrieve code coverage information for a function.
	 *
	 * @param L        The Lua state.
	 * @param funcindex Stack index of the function.
	 * @param context   Opaque user pointer passed to the callback.
	 * @param callback  Called for each function with coverage data.
	 * 
	 */
	@:native('lua_getcoverage')
	static function getcoverage(L:cpp.RawPointer<Lua_State>, funcindex:Int, context:cpp.RawPointer<cpp.Void>, callback:Lua_Coverage):Void;

	/**
	 * Enumerate native codegen execution counters recorded in a compiled function.
	 *
	 * Counter kinds (int `kind` in valueCallback):
	 *   1 = RegularBlockExecuted, 2 = FallbackBlockExecuted, 3 = VmExitTaken
	 *
	 * @param L          The Lua state.
	 * @param funcindex  Stack index of the native-compiled function.
	 * @param context    Opaque user pointer passed to both callbacks.
	 * @param functioncb Called once per function/closure in the proto tree.
	 *                   Signature: `void cb(void* ctx, const char* name, int linedefined)`
	 * @param valuecb    Called once per counter entry.
	 *                   Signature: `void cb(void* ctx, int kind, int line, uint64_t hits)`
	 */
	@:native('lua_getcounters')
	static function getcounters(L:cpp.RawPointer<Lua_State>, funcindex:Int, context:cpp.RawPointer<cpp.Void>, functioncb:Lua_CounterFunction, valuecb:Lua_CounterValue):Void;
}
