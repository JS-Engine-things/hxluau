package;

import hxluau.Lua;
import hxluau.LuaL;
import hxluau.Types;
import cpp.Callable;

class Main {
    static function customPrint(L:cpp.RawPointer<hxluau.Lua_State>):Int {
        final nargs:Int = Lua.gettop(L);
        
        for (i in 0...nargs) {
            final str = Lua.tostring(L, i + 1);
            if (str != null) {
                final msg:String = str;
                Sys.println(msg);
                Sys.stdout().flush();
            }
        }
        
        return 0;
    }
    public static function main() {
        Sys.println("Luau Example - Reading script file");
        
        var L:cpp.RawPointer<hxluau.Lua_State> = LuaL.newstate();
        
        LuaL.openlibs(L);
        
        Lua.pushcfunction(L, cpp.Callable.fromStaticFunction(customPrint), "print");
        Lua.setglobal(L, "print");
        
        Sys.println("\n--- Running script.lua ---");
        var scriptContent:String = sys.io.File.getContent("script.lua");
        LuaL.dostring(L, scriptContent);
        
        Lua.close(L);
        
        Sys.println("\nExample completed!");
    }
}
