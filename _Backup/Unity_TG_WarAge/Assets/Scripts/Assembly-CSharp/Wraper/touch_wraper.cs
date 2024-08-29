using System;
using LuaInterface;

namespace Wraper
{
	public class touch_wraper
	{
		public static string libname = "touch";

		private static luaL_Reg[] libfunc = new luaL_Reg[5]
		{
			new luaL_Reg("set_on_begin", set_on_begin),
			new luaL_Reg("set_on_move", set_on_move),
			new luaL_Reg("set_on_end", set_on_end),
			new luaL_Reg("set_on_key_down", set_on_key_down),
			new luaL_Reg("set_on_key_up", set_on_key_up)
		};

		private static string string_set_on_begin = "touch.set_on_begin";

		private static string string_set_on_move = "touch.set_on_move";

		private static string string_set_on_end = "touch.set_on_end";

		private static string string_set_on_key_down = "touch.set_on_key_down";

		private static string string_set_on_key_up = "touch.set_on_key_up";

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
		private static int set_on_begin(IntPtr L)
		{
			int result = 0;
			if (WraperUtil.ValidIsString(L, 1, string_set_on_begin))
			{
				string text = null;
				text = LuaDLL.lua_tostring(L, 1);
				TouchManager.GetInstance().onTouchBegin = text;
				result = 0;
			}
			return result;
		}

		[MonoPInvokeCallback(typeof(LuaCSFunction))]
		private static int set_on_move(IntPtr L)
		{
			int result = 0;
			if (WraperUtil.ValidIsString(L, 1, string_set_on_move))
			{
				string text = null;
				text = LuaDLL.lua_tostring(L, 1);
				TouchManager.GetInstance().onTouchMove = text;
				result = 0;
			}
			return result;
		}

		[MonoPInvokeCallback(typeof(LuaCSFunction))]
		private static int set_on_end(IntPtr L)
		{
			int result = 0;
			if (WraperUtil.ValidIsString(L, 1, string_set_on_end))
			{
				string text = null;
				text = LuaDLL.lua_tostring(L, 1);
				TouchManager.GetInstance().onTouchEnd = text;
				result = 0;
			}
			return result;
		}

		[MonoPInvokeCallback(typeof(LuaCSFunction))]
		private static int set_on_key_down(IntPtr L)
		{
			int result = 0;
			if (WraperUtil.ValidIsString(L, 1, string_set_on_key_down))
			{
				string text = null;
				text = LuaDLL.lua_tostring(L, 1);
				TouchManager.GetInstance().onKeyDown = text;
				result = 0;
			}
			return result;
		}

		[MonoPInvokeCallback(typeof(LuaCSFunction))]
		private static int set_on_key_up(IntPtr L)
		{
			int result = 0;
			if (WraperUtil.ValidIsString(L, 1, string_set_on_key_up))
			{
				string text = null;
				text = LuaDLL.lua_tostring(L, 1);
				TouchManager.GetInstance().onKeyUp = text;
				result = 0;
			}
			return result;
		}
	}
}
