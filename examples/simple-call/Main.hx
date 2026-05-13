package;

import hxluau.Lua;
import hxluau.LuaL;
import hxluau.Types;

class Main
{
	public static function main():Void
	{
		/* version info */
		Sys.println(Lua.VERSION);

		/* initialize Lua */
		var vm:cpp.RawPointer<Lua_State> = LuaL.newstate();

		/* load Lua base libraries */
		LuaL.openlibs(vm);

		/* install custom print (optional; mirrors base print) */
		LuaL.registerPrint(vm);

		/* run the script via dofile (compile + pcall) */
		var result = LuaL.dofile(vm, "script.lua");
		
		// Check the result if needed
		if (result != 0) {
			Sys.println("Error running script: " + result);
		}

		/* cleanup Lua */
		Lua.close(vm);
		vm = null;
	}
}