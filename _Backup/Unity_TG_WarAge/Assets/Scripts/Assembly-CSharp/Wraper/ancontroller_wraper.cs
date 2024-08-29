using System;
using LuaInterface;
using UnityWrap;

namespace Wraper
{
	public class ancontroller_wraper
	{
		public static string name = "ancontroller_object";

		public static string libname = "ancontroller";

		private static luaL_Reg[] libfunc = new luaL_Reg[1]
		{
			new luaL_Reg("load", load)
		};

		private static luaL_Reg[] func = new luaL_Reg[0];

		private static string string_load = "ancontroller.load";

		private static string string_load_resource = "ancontroller.load_resource";

		public static bool init(IntPtr L)
		{
			if (L != IntPtr.Zero)
			{
				LuaDLL.register_class(L, name, func, gc);
				LuaDLL.register_lib(L, libname, libfunc, 0);
				return true;
			}
			return false;
		}

		public static void push(IntPtr L, AncontrollerWraper obj)
		{
			if (obj == null)
			{
				LuaDLL.lua_pushnil(L);
				return;
			}
			LuaDLL.use_lua_newuserdata_ex(L, 4, obj.GetPid());
			LuaDLL.lua_getfield(L, LuaIndexes.LUA_REGISTRYINDEX, name);
			LuaDLL.lua_setmetatable(L, -2);
		}

		[MonoPInvokeCallback(typeof(LuaCSFunction))]
		private static int load(IntPtr L)
		{
			int result = 0;
			if (WraperUtil.ValidIsString(L, 1, string_load) && WraperUtil.ValidIsString(L, 2, string_load))
			{
				string text = null;
				string text2 = null;
				text = LuaDLL.lua_tostring(L, 1);
				text2 = LuaDLL.lua_tostring(L, 2);
				AncontrollerWraper.Load(text, text2);
				result = 0;
			}
			return result;
		}

		[MonoPInvokeCallback(typeof(LuaCSFunction))]
		private static int gc(IntPtr L)
		{
			AncontrollerWraper ancontrollerWraper = WraperUtil.LuaToUserdataByGc(L, 1, "gc ancontroller_object", AncontrollerWraper.cache);
			if (ancontrollerWraper != null)
			{
				AncontrollerWraper.DestroyInstance(ancontrollerWraper);
			}
			return 0;
		}
	}
}
