package hxluau;

#if !cpp
#error 'Luau supports only C++ target platforms.'
#end
import hxluau.Types;

/**
 * Provides access to various properties and functionalities of Luau.
 * This class contains Luau-specific extensions that are not part of the standard Lua API.
 */
@:buildXml('<include name="${haxelib:hxluau}/project/Build.xml" />')
@:include('lua.h')
@:include('luacode.h')
@:include('luacodegen.h')
@:unreflective
extern class LuauVM
{
	/**
	 * Compile a string of Lua source code into bytecode for execution by Luau VM.
	 *
	 * @param source The Lua source code to compile.
	 * @param size The size of the source code string.
	 * @param options Compilation options (can be null).
	 * @param bytecodeSize Pointer to store the size of the resulting bytecode.
	 * @return A pointer to the compiled bytecode, or null on error.
	 */
	@:native('luau_compile')
	static function compile(source:cpp.ConstCharStar, size:cpp.SizeT, options:cpp.RawPointer<cpp.Void>, bytecodeSize:cpp.Star<cpp.SizeT>):cpp.RawPointer<cpp.Char>;

	/**
	 * Load a precompiled Luau chunk into the Lua state.
	 *
	 * @param L The Lua state.
	 * @param chunkname The name of the chunk.
	 * @param bytecode The compiled bytecode.
	 * @param bytecodeSize The size of the bytecode.
	 * @param env The environment index (0 for default).
	 * @return 0 on success, or an error code on failure.
	 */
	@:native('luau_load')
	static function load(L:cpp.RawPointer<Lua_State>, chunkname:cpp.ConstCharStar, bytecode:cpp.ConstCharStar, bytecodeSize:cpp.SizeT, env:Int):Int;

	/**
	 * Returns 1 if Luau native code generator is supported on this platform, 0 otherwise.
	 */
	@:native('luau_codegen_supported')
	static function codegen_supported():Int;

	/**
	 * Creates a code generator instance bound to the given state. Must check support first.
	 */
	@:native('luau_codegen_create')
	static function codegen_create(L:cpp.RawPointer<Lua_State>):Void;

	/**
	 * Builds native code for target function (and inner functions) at stack index `idx`.
	 */
	@:native('luau_codegen_compile')
	static function codegen_compile(L:cpp.RawPointer<Lua_State>, idx:Int):Void;

	/**
	 * Set a nil constant value in the compile constant struct.
	 * @param constant Pointer to the compile constant to set.
	 */
	@:native('luau_set_compile_constant_nil')
	static function compileConstantNil(constant:cpp.RawPointer<cpp.Void>):Void;

	/**
	 * Set a boolean constant value in the compile constant struct.
	 * @param constant Pointer to the compile constant to set.
	 * @param b The boolean value.
	 */
	@:native('luau_set_compile_constant_boolean')
	static function compileConstantBoolean(constant:cpp.RawPointer<cpp.Void>, b:Int):Void;

	/**
	 * Set a number constant value in the compile constant struct.
	 * @param constant Pointer to the compile constant to set.
	 * @param n The number value.
	 */
	@:native('luau_set_compile_constant_number')
	static function compileConstantNumber(constant:cpp.RawPointer<cpp.Void>, n:Lua_Number):Void;

	/**
	 * Set a 64-bit integer constant value in the compile constant struct.
	 * @param constant Pointer to the compile constant to set.
	 * @param l The 64-bit integer value.
	 */
	@:native('luau_set_compile_constant_integer64')
	static function compileConstantInteger64(constant:cpp.RawPointer<cpp.Void>, l:haxe.Int64):Void;

	/**
	 * Set a vector constant value in the compile constant struct.
	 * @param constant Pointer to the compile constant to set.
	 * @param x The x component.
	 * @param y The y component.
	 * @param z The z component.
	 * @param w The w component.
	 */
	@:native('luau_set_compile_constant_vector')
	static function compileConstantVector(constant:cpp.RawPointer<cpp.Void>, x:Float, y:Float, z:Float, w:Float):Void;

	/**
	 * Set a string constant value in the compile constant struct.
	 * @param constant Pointer to the compile constant to set.
	 * @param s The string value.
	 * @param l The string length.
	 */
	@:native('luau_set_compile_constant_string')
	static function compileConstantString(constant:cpp.RawPointer<cpp.Void>, s:cpp.ConstCharStar, l:cpp.SizeT):Void;
}
