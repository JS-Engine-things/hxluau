package hxluau;

/**
 * Dummy class for importing Luau types.
 */
#if !cpp
#error 'Luau supports only C++ target platforms.'
#end
class Types {}

/**
 * Lua state type, representing the entire execution context of a Lua interpreter.
 */
@:buildXml('<include name="${haxelib:hxluau}/project/Build.xml" />')
@:include('lua.h')
@:include('lualib.h')
@:include('luacode.h')
@:native('lua_State')
extern class Lua_State {}

/**
 * Type for C functions registered with Lua.
 */
typedef Lua_CFunction = cpp.Callable<(L:cpp.RawPointer<Lua_State>) -> Int>;

/**
 * Type for Lua continuation functions.
 */
typedef Lua_Continuation = cpp.Callable<(L:cpp.RawPointer<Lua_State>, status:Int) -> Int>;

/**
 * Type for functions that read blocks when loading/dumping Lua chunks.
 */
typedef Lua_Reader = cpp.Callable<(L:cpp.RawPointer<Lua_State>, ud:cpp.RawPointer<cpp.Void>, sz:cpp.RawPointer<cpp.SizeT>) -> cpp.ConstCharStar>;

/**
 * Type for functions that write blocks when loading/dumping Lua chunks.
 */
typedef Lua_Writer = cpp.Callable<(L:cpp.RawPointer<Lua_State>, p:cpp.RawConstPointer<cpp.Void>, sz:cpp.SizeT, ud:cpp.RawPointer<cpp.Void>) -> Int>;

/**
 * Type for memory allocation functions.
 */
typedef Lua_Alloc = cpp.Callable<(ud:cpp.RawPointer<cpp.Void>, ptr:cpp.RawPointer<cpp.Void>, osize:cpp.SizeT, nsize:cpp.SizeT) -> cpp.RawPointer<cpp.Void>>;

/**
 * Opaque compile-constant type used by luacode callbacks.
 */
typedef Lua_CompileConstant = cpp.RawPointer<cpp.Void>;

/**
 * Callback that returns a type identifier for a known library member.
 */
typedef Lua_LibraryMemberTypeCallback = cpp.Callable<(library:cpp.ConstCharStar, member:cpp.ConstCharStar) -> Int>;

/**
 * Callback that fills a known constant value for a library member.
 */
typedef Lua_LibraryMemberConstantCallback = cpp.Callable<(library:cpp.ConstCharStar, member:cpp.ConstCharStar, constant:cpp.RawPointer<Lua_CompileConstant>) -> Void>;
/**
 * Type for numbers in Lua.
 */
@:buildXml('<include name="${haxelib:hxluau}/project/Build.xml" />')
@:include('lua.h')
@:native('lua_Number')
@:scalar
@:coreType
@:notNull
extern abstract Lua_Number from Float to Float {}

/**
 * Type for integers in Lua.
 */
@:buildXml('<include name="${haxelib:hxluau}/project/Build.xml" />')
@:include('lua.h')
@:native('lua_Integer')
@:scalar
@:coreType
@:notNull
extern abstract Lua_Integer from Int to Int {}

/**
 * Lua debug information.
 */
@:buildXml('<include name="${haxelib:hxluau}/project/Build.xml" />')
@:include('lua.h')
@:unreflective
@:structAccess
@:native('lua_Debug')
extern class Lua_Debug
{
	/**
	 * Allocates a new Lua_Debug instance.
	 */
	function new():Void;

	/**
	 * Name of the current function.
	 */
	var name:cpp.ConstCharStar;

	/**
	 * Source type ('Lua', 'C', etc.).
	 */
	var what:cpp.ConstCharStar;

	/**
	 * Source of the chunk.
	 */
	var source:cpp.ConstCharStar;

	/**
	 * Current line where the call is.
	 */
	var currentline:Int;

	/**
	 * Number of upvalues.
	 */
	var nupvals:cpp.UInt8;

	/**
	 * Number of parameters.
	 */
	var nparams:cpp.UInt8;

	/**
	 * Line where the function was defined.
	 */
	var linedefined:Int;

	/**
	 * Function source summary.
	 */
	var short_src:cpp.ConstCharStar;

	/**
	 * 1 if function is vararg, 0 otherwise.
	 */
	var isvararg:cpp.Int8;

	/**
	 * User data pointer used by Luau debug callbacks.
	 */
	var userdata:cpp.RawPointer<cpp.Void>;
}

/**
 * Functions called by the debugger on specific events.
 */
typedef Lua_Hook = cpp.Callable<(L:cpp.RawPointer<Lua_State>, ar:cpp.RawPointer<Lua_Debug>) -> Void>;

/**
 * Destructor callback for userdata types (lua_Destructor).
 */
typedef Lua_Destructor = cpp.Callable<(L:cpp.RawPointer<Lua_State>, userdata:cpp.RawPointer<cpp.Void>) -> Void>;
/**
 * Direct-access callback for userdata field get/set operations.
 */
typedef Lua_UserdataDirectAccess = cpp.Callable<(L:cpp.RawPointer<Lua_State>, data:cpp.RawPointer<cpp.Void>, atom:Int, cachedslot:cpp.RawPointer<cpp.UInt16>, utag:Int) -> Void>;

/**
 * Direct-access callback for userdata namecall operations.
 */
typedef Lua_UserdataDirectNamecall = cpp.Callable<(L:cpp.RawPointer<Lua_State>, data:cpp.RawPointer<cpp.Void>, atom:Int, cachedslot:cpp.RawPointer<cpp.UInt16>, utag:Int) -> Int>;

/**
 * Direct per-field getter callback for userdata.
 */
typedef Lua_UserdataDirectFieldGet = cpp.Callable<(ud:cpp.RawPointer<cpp.Void>, result:cpp.RawPointer<cpp.Void>) -> Void>;

/**
 * Counter function callback for native code execution profiling.
 */
typedef Lua_CounterFunction = cpp.Callable<(context:cpp.RawPointer<cpp.Void>, functionName:cpp.ConstCharStar, linedefined:Int) -> Void>;

/**
 * Counter value callback for native code execution profiling.
 */
typedef Lua_CounterValue = cpp.Callable<(context:cpp.RawPointer<cpp.Void>, kind:Int, line:Int, hits:haxe.UInt64) -> Void>;

/**
 * Coverage callback for code coverage tracking.
 */
typedef Lua_Coverage = cpp.Callable<(context:cpp.RawPointer<cpp.Void>, functionName:cpp.ConstCharStar, linedefined:Int, depth:Int, hits:cpp.RawConstPointer<Int>, size:cpp.SizeT) -> Void>;

/**
 * Buffer for building Lua strings.
 */
@:buildXml('<include name="${haxelib:hxluau}/project/Build.xml" />')
@:include('lua.h')
@:include('lualib.h')
@:unreflective
@:structAccess
@:native('luaL_Buffer')
extern class LuaL_Buffer
{
	/**
	 * Allocates a new LuaL_Buffer instance.
	 */
	function new():Void;

	/**
	 * Current position in the buffer.
	 */
	var p:cpp.CastCharStar;

	/**
	 * End pointer of the current writable buffer segment.
	 */
	var end:cpp.CastCharStar;

	/**
	 * Lua state.
	 */
	var L:cpp.RawPointer<Lua_State>;

	/**
	 * Internal mutable string storage (opaque).
	 */
	var storage:cpp.RawPointer<cpp.Void>;

	/**
	 * Fixed inline buffer storage (first byte).
	 */
	var buffer:cpp.Char;
}

/**
 * Callbacks struct used to reconfigure VM behavior dynamically.
 * Shared between all coroutines. Use Lua.callbacks(L) to obtain.
 *
 * NOTE: Setting C function pointer fields directly from Haxe is not
 * supported due to ABI differences. Use hxluau utilities instead
 * (e.g. Luau.enableAutoCompile for the interrupt hook).
 */
@:buildXml('<include name="${haxelib:hxluau}/project/Build.xml" />')
@:include('lua.h')
@:unreflective
@:structAccess
@:native('lua_Callbacks')
extern class Lua_Callbacks
{
	/**
	 * Arbitrary userdata pointer that is never overwritten by Luau.
	 */
	var userdata:cpp.RawPointer<cpp.Void>;
}

/**
 * Structure for Lua library functions.
 */
@:buildXml('<include name="${haxelib:hxluau}/project/Build.xml" />')
@:include('lua.h')
@:include('lualib.h')
@:unreflective
@:structAccess
@:native('luaL_Reg')
extern class LuaL_Reg
{
	/**
	 * Allocates a new LuaL_Reg instance.
	 */
	function new():Void;

	/**
	 * Name of the function.
	 */
	var name:cpp.ConstCharStar;

	/**
	 * Function registered with Lua.
	 */
	var func:Lua_CFunction;
}