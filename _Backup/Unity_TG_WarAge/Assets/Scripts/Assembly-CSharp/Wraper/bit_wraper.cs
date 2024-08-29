using System;
using LuaInterface;

namespace Wraper
{
	public class bit_wraper
	{
		public static string libname = "bit";

		private static luaL_Reg[] libfunc = new luaL_Reg[5]
		{
			new luaL_Reg("bit_or", bit_or),
			new luaL_Reg("bit_and", bit_and),
			new luaL_Reg("bit_xor", bit_xor),
			new luaL_Reg("bit_lshift", bit_lshift),
			new luaL_Reg("bit_rshift", bit_rshift)
		};

		private static string string_bit_or = "bit.bit_or";

		private static string string_bit_and = "bit.bit_and";

		private static string string_bit_xor = "bit.bit_xor";

		private static string string_bit_lshift = "bit.bit_lshift";

		private static string string_bit_rshift = "bit.bit_rshift";

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
		private static int bit_or(IntPtr L)
		{
			int result = 0;
			if (WraperUtil.ValidIsNumber(L, 1, string_bit_or) && WraperUtil.ValidIsNumber(L, 2, string_bit_or))
			{
				int num = 0;
				int num2 = 0;
				num = (int)LuaDLL.lua_tonumber(L, 1);
				num2 = (int)LuaDLL.lua_tonumber(L, 2);
				LuaDLL.lua_pushnumber(L, num | num2);
				result = 1;
			}
			return result;
		}

		[MonoPInvokeCallback(typeof(LuaCSFunction))]
		private static int bit_and(IntPtr L)
		{
			int result = 0;
			if (WraperUtil.ValidIsNumber(L, 1, string_bit_and) && WraperUtil.ValidIsNumber(L, 2, string_bit_and))
			{
				int num = 0;
				int num2 = 0;
				num = (int)LuaDLL.lua_tonumber(L, 1);
				num2 = (int)LuaDLL.lua_tonumber(L, 2);
				LuaDLL.lua_pushnumber(L, num & num2);
				result = 1;
			}
			return result;
		}

		[MonoPInvokeCallback(typeof(LuaCSFunction))]
		private static int bit_xor(IntPtr L)
		{
			int result = 0;
			if (WraperUtil.ValidIsNumber(L, 1, string_bit_xor) && WraperUtil.ValidIsNumber(L, 2, string_bit_xor))
			{
				int num = 0;
				int num2 = 0;
				num = (int)LuaDLL.lua_tonumber(L, 1);
				num2 = (int)LuaDLL.lua_tonumber(L, 2);
				LuaDLL.lua_pushnumber(L, num ^ num2);
				result = 1;
			}
			return result;
		}

		[MonoPInvokeCallback(typeof(LuaCSFunction))]
		private static int bit_lshift(IntPtr L)
		{
			int result = 0;
			if (WraperUtil.ValidIsNumber(L, 1, string_bit_lshift) && WraperUtil.ValidIsNumber(L, 2, string_bit_lshift))
			{
				int num = 0;
				int num2 = 0;
				num = (int)LuaDLL.lua_tonumber(L, 1);
				num2 = (int)LuaDLL.lua_tonumber(L, 2);
				LuaDLL.lua_pushnumber(L, num << num2);
				result = 1;
			}
			return result;
		}

		[MonoPInvokeCallback(typeof(LuaCSFunction))]
		private static int bit_rshift(IntPtr L)
		{
			int result = 0;
			if (WraperUtil.ValidIsNumber(L, 1, string_bit_rshift) && WraperUtil.ValidIsNumber(L, 2, string_bit_rshift))
			{
				int num = 0;
				int num2 = 0;
				num = (int)LuaDLL.lua_tonumber(L, 1);
				num2 = (int)LuaDLL.lua_tonumber(L, 2);
				LuaDLL.lua_pushnumber(L, num >> num2);
				result = 1;
			}
			return result;
		}
	}
}
