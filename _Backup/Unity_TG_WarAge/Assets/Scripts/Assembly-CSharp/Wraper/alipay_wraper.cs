using System;
using LuaInterface;

namespace Wraper
{
	public class alipay_wraper
	{
		public static string libname = "alipay";

		private static luaL_Reg[] libfunc = new luaL_Reg[3]
		{
			new luaL_Reg("pay", pay),
			new luaL_Reg("check_account_exist", check_account_exist),
			new luaL_Reg("get_version", get_version)
		};

		private static string string_pay = "alipay.pay";

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
		private static int pay(IntPtr L)
		{
			int result = 0;
			if (WraperUtil.ValidIsString(L, 1, string_pay) && WraperUtil.ValidIsString(L, 2, string_pay))
			{
				string text = null;
				string text2 = null;
				text = LuaDLL.lua_tostring(L, 1);
				text2 = LuaDLL.lua_tostring(L, 2);
				LuaDLL.lua_pushboolean(L, Alipay.GetInstance().Pay(text, text2));
				result = 1;
			}
			return result;
		}

		[MonoPInvokeCallback(typeof(LuaCSFunction))]
		private static int check_account_exist(IntPtr L)
		{
			int num = 0;
			LuaDLL.lua_pushboolean(L, Alipay.GetInstance().CheckAccountExist());
			return 1;
		}

		[MonoPInvokeCallback(typeof(LuaCSFunction))]
		private static int get_version(IntPtr L)
		{
			int num = 0;
			LuaDLL.lua_pushstring(L, Alipay.GetInstance().GetVersion());
			return 1;
		}
	}
}
