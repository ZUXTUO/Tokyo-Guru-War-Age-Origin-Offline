using System;
using LuaInterface;
using Script;
using UnityWrap;

namespace Wraper
{
	public class scene_wraper
	{
		public static string libname = "scene";

		private static luaL_Reg[] libfunc = new luaL_Reg[4]
		{
			new luaL_Reg("set_listener", set_listener),
			new luaL_Reg("load", load),
			new luaL_Reg("set_listener_v5", set_listener_v5),
			new luaL_Reg("load_v5", load_v5)
		};

		private static string string_set_listener = "scene.set_listener";

		private static string string_load = "scene.load";

		private static string string_set_listener_v5 = "scene.set_listener_v5";

		private static string string_load_v5 = "scene.load_v5";

		public static bool init(IntPtr L)
		{
			if (L != IntPtr.Zero)
			{
				LuaDLL.register_lib(L, libname, libfunc, 0);
				return true;
			}
			return false;
		}

		[MonoPInvokeCallback(typeof(LuaCSFunction))]
		private static int set_listener(IntPtr L)
		{
			int result = 0;
			if (WraperUtil.ValidIsStringOrNil(L, 1, string_set_listener) && WraperUtil.ValidIsStringOrNil(L, 2, string_set_listener) && WraperUtil.ValidIsStringOrNil(L, 3, string_set_listener) && WraperUtil.ValidIsStringOrNil(L, 4, string_set_listener))
			{
				string text = null;
				string text2 = null;
				string text3 = null;
				string text4 = null;
				text = LuaDLL.lua_tostring(L, 1);
				text2 = LuaDLL.lua_tostring(L, 2);
				text3 = LuaDLL.lua_tostring(L, 3);
				text4 = LuaDLL.lua_tostring(L, 4);
				SceneScriptManager.GetInstance().SetLoadListener(text2, text, text4, text3);
				result = 0;
			}
			return result;
		}

		[MonoPInvokeCallback(typeof(LuaCSFunction))]
		private static int load(IntPtr L)
		{
			int result = 0;
			if (WraperUtil.ValidIsString(L, 1, string_load))
			{
				string text = null;
				text = LuaDLL.lua_tostring(L, 1);
				SceneScriptManager.GetInstance().LoadScene(text);
				result = 0;
			}
			return result;
		}

		[MonoPInvokeCallback(typeof(LuaCSFunction))]
		private static int set_listener_v5(IntPtr L)
		{
			int result = 0;
			if (WraperUtil.ValidIsStringOrNil(L, 1, string_set_listener_v5) && WraperUtil.ValidIsStringOrNil(L, 2, string_set_listener_v5) && WraperUtil.ValidIsStringOrNil(L, 3, string_set_listener_v5) && WraperUtil.ValidIsStringOrNil(L, 4, string_set_listener_v5))
			{
				string text = null;
				string text2 = null;
				string text3 = null;
				string text4 = null;
				text = LuaDLL.lua_tostring(L, 1);
				text2 = LuaDLL.lua_tostring(L, 2);
				text3 = LuaDLL.lua_tostring(L, 3);
				text4 = LuaDLL.lua_tostring(L, 4);
				SceneLoaderWrap.GetInstance().SetLoadListener(text2, text, text4, text3);
				result = 0;
			}
			return result;
		}

		[MonoPInvokeCallback(typeof(LuaCSFunction))]
		private static int load_v5(IntPtr L)
		{
			int result = 0;
			if (WraperUtil.ValidIsString(L, 1, string_load_v5))
			{
				string text = null;
				text = LuaDLL.lua_tostring(L, 1);
				SceneLoaderWrap.GetInstance().LoadScene(text);
				result = 0;
			}
			return result;
		}
	}
}
