using System;
using Core.Unity;
using Core.Util;
using LuaInterface;
using Script;

namespace Wraper
{
	public class script_wraper
	{
		public static string libname = "script";

		private static luaL_Reg[] libfunc = new luaL_Reg[1]
		{
			new luaL_Reg("run", run)
		};

		private static string string_run = "script.run";

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
		private static int run(IntPtr L)
		{
			int result = 0;
			if (WraperUtil.ValidIsString(L, 1, string_run))
			{
				string text = null;
				text = LuaDLL.lua_tostring(L, 1);
				if (Utils.StringContainUpper(text))
				{
					Debug.LogWarning("加载的路径中有大写:" + text);
				}
				ScriptManager.GetInstance().Run(text);
				result = 0;
			}
			return result;
		}
	}
}
