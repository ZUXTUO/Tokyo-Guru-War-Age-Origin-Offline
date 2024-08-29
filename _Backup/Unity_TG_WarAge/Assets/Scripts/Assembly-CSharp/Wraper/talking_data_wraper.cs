using System;
using LuaInterface;

namespace Wraper
{
	public class talking_data_wraper
	{
		public static string libname = "talking_data";

		private static luaL_Reg[] libfunc = new luaL_Reg[1]
		{
			new luaL_Reg("submit", submit)
		};

		private static string string_submit = "talking_data.submit";

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
		private static int submit(IntPtr L)
		{
			int result = 0;
			if (WraperUtil.ValidIsString(L, 1, string_submit) && WraperUtil.ValidIsString(L, 2, string_submit))
			{
				string text = null;
				string text2 = null;
				text = LuaDLL.lua_tostring(L, 1);
				text2 = LuaDLL.lua_tostring(L, 2);
				LuaDLL.lua_pushboolean(L, TDManager.GetInstance().Submit(text, text2));
				result = 1;
			}
			return result;
		}
	}
}
