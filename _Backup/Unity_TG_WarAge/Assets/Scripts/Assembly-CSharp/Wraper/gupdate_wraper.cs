using System;
using System.Collections.Generic;
using LuaInterface;
using SUpdate.Logic;

namespace Wraper
{
	public class gupdate_wraper
	{
		public static string libname = "gupdate";

		private static luaL_Reg[] libfunc = new luaL_Reg[7]
		{
			new luaL_Reg("set_op_listener", set_op_listener),
			new luaL_Reg("async_connect", async_connect),
			new luaL_Reg("close_connect", close_connect),
			new luaL_Reg("set_device_id", set_device_id),
			new luaL_Reg("check_op", check_op),
			new luaL_Reg("add_down", add_down),
			new luaL_Reg("add_down_group", add_down_group)
		};

		private static string string_set_op_listener = "gupdate.set_op_listener";

		private static string string_async_connect = "gupdate.async_connect";

		private static string string_set_device_id = "gupdate.set_device_id";

		private static string string_check_op = "gupdate.check_op";

		private static string string_add_down = "gupdate.add_down";

		private static string string_add_down_group = "gupdate.add_down_group";

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
		private static int set_op_listener(IntPtr L)
		{
			int result = 0;
			if (WraperUtil.ValidIsString(L, 1, string_set_op_listener) && WraperUtil.ValidIsString(L, 2, string_set_op_listener) && WraperUtil.ValidIsString(L, 3, string_set_op_listener) && WraperUtil.ValidIsString(L, 4, string_set_op_listener) && WraperUtil.ValidIsString(L, 5, string_set_op_listener))
			{
				string text = null;
				string text2 = null;
				string text3 = null;
				string text4 = null;
				string text5 = null;
				text = LuaDLL.lua_tostring(L, 1);
				text2 = LuaDLL.lua_tostring(L, 2);
				text3 = LuaDLL.lua_tostring(L, 3);
				text4 = LuaDLL.lua_tostring(L, 4);
				text5 = LuaDLL.lua_tostring(L, 5);
				update_processs instance = update_processs.Instance;
				instance.ConnectionFunction = text;
				instance.CloseFunction = text2;
				instance.ErrorFunction = text3;
				instance.DeviceErrorFunction = text4;
				instance.OpVerFunction = text5;
				result = 0;
			}
			return result;
		}

		[MonoPInvokeCallback(typeof(LuaCSFunction))]
		private static int async_connect(IntPtr L)
		{
			int result = 0;
			if (WraperUtil.ValidIsString(L, 1, string_async_connect) && WraperUtil.ValidIsNumber(L, 2, string_async_connect))
			{
				string text = null;
				int num = 0;
				text = LuaDLL.lua_tostring(L, 1);
				num = (int)LuaDLL.lua_tonumber(L, 2);
				UpdateManager.GetInstance().AsycConnection(text, num);
				result = 0;
			}
			return result;
		}

		[MonoPInvokeCallback(typeof(LuaCSFunction))]
		private static int close_connect(IntPtr L)
		{
			int num = 0;
			UpdateManager.GetInstance().CloseConnection();
			return 0;
		}

		[MonoPInvokeCallback(typeof(LuaCSFunction))]
		private static int set_device_id(IntPtr L)
		{
			int result = 0;
			if (WraperUtil.ValidIsNumber(L, 1, string_set_device_id))
			{
				int num = 0;
				num = (int)LuaDLL.lua_tonumber(L, 1);
				UpdateManager.GetInstance().DeviceId = num;
				result = 0;
			}
			return result;
		}

		[MonoPInvokeCallback(typeof(LuaCSFunction))]
		private static int check_op(IntPtr L)
		{
			int result = 0;
			if (WraperUtil.ValidIsNumber(L, 1, string_check_op))
			{
				int num = 0;
				num = (int)LuaDLL.lua_tonumber(L, 1);
				int verid = 1;
				UpdateManager.GetInstance().CheckOp(num, verid);
				result = 0;
			}
			return result;
		}

		[MonoPInvokeCallback(typeof(LuaCSFunction))]
		private static int add_down(IntPtr L)
		{
			int result = 0;
			if (WraperUtil.ValidIsNumber(L, 1, string_add_down) && WraperUtil.ValidIsString(L, 2, string_add_down) && WraperUtil.ValidIsString(L, 3, string_add_down) && WraperUtil.ValidIsString(L, 4, string_add_down))
			{
				int num = 0;
				string text = null;
				string text2 = null;
				string text3 = null;
				num = (int)LuaDLL.lua_tonumber(L, 1);
				text = LuaDLL.lua_tostring(L, 2);
				text2 = LuaDLL.lua_tostring(L, 3);
				text3 = LuaDLL.lua_tostring(L, 4);
				UpdateManager.GetInstance().AddDown(text3, text, text2, num);
				result = 0;
			}
			return result;
		}

		[MonoPInvokeCallback(typeof(LuaCSFunction))]
		private static int add_down_group(IntPtr L)
		{
			int result = 0;
			if (WraperUtil.ValidIsNumber(L, 1, string_add_down_group) && WraperUtil.ValidIsString(L, 2, string_add_down_group) && WraperUtil.ValidIsString(L, 3, string_add_down_group))
			{
				int num = 0;
				string text = null;
				string text2 = null;
				num = (int)LuaDLL.lua_tonumber(L, 1);
				text = LuaDLL.lua_tostring(L, 2);
				text2 = LuaDLL.lua_tostring(L, 3);
				if (LuaDLL.lua_istable(L, 4))
				{
					List<string> list = new List<string>();
					int num2 = LuaDLL.lua_objlen(L, 4);
					for (int i = 1; i <= num2; i++)
					{
						LuaDLL.lua_rawgeti(L, 4, i);
						if (LuaDLL.lua_isstring(L, -1))
						{
							string item = LuaDLL.lua_tostring(L, -1);
							list.Add(item);
						}
						LuaDLL.lua_pop(L, 1);
					}
					UpdateManager.GetInstance().AddDownGroup(list, text, text2, num);
				}
				result = 0;
			}
			return result;
		}
	}
}
