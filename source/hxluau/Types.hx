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
	 * Event code.
	 */
	var event:Int;

	/**
	 * Name of the current function.
	 */
	var name:cpp.ConstCharStar;

	/**
	 * Type of name ('global', 'local', etc.).
	 */
	var namewhat:cpp.ConstCharStar;

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
	var nups:Int;

	/**
	 * Number of parameters.
	 */
	var nparams:Int;

	/**
	 * Line where the function was defined.
	 */
	var linedefined:Int;

	/**
	 * Last line where the function was defined.
	 */
	var lastlinedefined:Int;

	/**
	 * Short description of the location.
	 */
	var short_src:cpp.CastCharStar;

	/**
	 * Instruction index.
	 */
	var i_ci:Int;
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
typedef Lua_Coverage = cpp.Callable<(context:cpp.RawPointer<cpp.Void>, functionName:cpp.ConstCharStar, linedefined:Int, depth:Int, hits:cpp.RawPointer<Int>, size:cpp.SizeT) -> Void>;

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
	 * Number of elements in the buffer.
	 */
	var lvl:Int;

	/**
	 * Lua state.
	 */
	var L:cpp.RawPointer<Lua_State>;

	/**
	 * Buffer storage.
	 */
	var buffer:cpp.Char;
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