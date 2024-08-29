using System;
using LuaInterface;
using UnityWrap;

namespace Wraper
{
	public class ghttp_wraper
	{
		public static string libname = "ghttp";

		private static luaL_Reg[] libfunc = new luaL_Reg[10]
		{
			new luaL_Reg("set_check_file_listener", set_check_file_listener),
			new luaL_Reg("check_file", check_file),
			new luaL_Reg("get_check_file_value", get_check_file_value),
			new luaL_Reg("set_op_listener", set_op_listener),
			new luaL_Reg("check_op", check_op),
			new luaL_Reg("add_down", add_down),
			new luaL_Reg("down", down),
			new luaL_Reg("get", get),
			new luaL_Reg("post", post),
			new luaL_Reg("post_body_data", post_body_data)
		};

		private static string string_set_check_file_listener = "ghttp.set_check_file_listener";

		private static string string_check_file = "ghttp.check_file";

		private static string string_get_check_file_value = "ghttp.get_check_file_value";

		private static string string_set_op_listener = "ghttp.set_op_listener";

		private static string string_check_op = "ghttp.check_op";

		private static string string_add_down = "ghttp.add_down";

		private static string string_down = "ghttp.down";

		private static string string_get = "ghttp.get";

		private static string string_post = "ghttp.post";

		private static string string_post_body_data = "ghttp_post";

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
		private static int set_check_file_listener(IntPtr L)
		{
			int result = 0;
			if (WraperUtil.ValidIsString(L, 1, string_set_check_file_listener) && WraperUtil.ValidIsString(L, 2, string_set_check_file_listener))
			{
				string text = null;
				string text2 = null;
				text = LuaDLL.lua_tostring(L, 1);
				text2 = LuaDLL.lua_tostring(L, 2);
				HttpUpdateClientWrap.OnCheckFileSuccessStr = text;
				HttpUpdateClientWrap.OnCheckFileErrorStr = text2;
				result = 0;
			}
			return result;
		}

		[MonoPInvokeCallback(typeof(LuaCSFunction))]
		private static int check_file(IntPtr L)
		{
			int result = 0;
			if (WraperUtil.ValidIsString(L, 1, string_check_file) && WraperUtil.ValidIsString(L, 2, string_check_file))
			{
				string text = null;
				string text2 = null;
				text = LuaDLL.lua_tostring(L, 1);
				text2 = LuaDLL.lua_tostring(L, 2);
				HttpUpdateClientWrap.CheckFile(text, text2);
				result = 0;
			}
			return result;
		}

		[MonoPInvokeCallback(typeof(LuaCSFunction))]
		private static int get_check_file_value(IntPtr L)
		{
			int result = 0;
			if (WraperUtil.ValidIsString(L, 1, string_get_check_file_value))
			{
				string text = null;
				text = LuaDLL.lua_tostring(L, 1);
				string checkFileValue = HttpUpdateClientWrap.GetCheckFileValue(text);
				LuaDLL.lua_pushstring(L, checkFileValue);
				result = 1;
			}
			return result;
		}

		[MonoPInvokeCallback(typeof(LuaCSFunction))]
		private static int set_op_listener(IntPtr L)
		{
			int result = 0;
			if (WraperUtil.ValidIsString(L, 1, string_set_op_listener) && WraperUtil.ValidIsString(L, 2, string_set_op_listener))
			{
				string text = null;
				string text2 = null;
				text = LuaDLL.lua_tostring(L, 1);
				text2 = LuaDLL.lua_tostring(L, 2);
				HttpUpdateClientWrap.OnCheckOpSuccessStr = text;
				HttpUpdateClientWrap.OnCheckOpErrorStr = text2;
				result = 0;
			}
			return result;
		}

		[MonoPInvokeCallback(typeof(LuaCSFunction))]
		private static int check_op(IntPtr L)
		{
			int result = 0;
			if (WraperUtil.ValidIsString(L, 1, string_check_op))
			{
				string text = null;
				text = LuaDLL.lua_tostring(L, 1);
				HttpUpdateClientWrap.CheckOp(text);
				result = 0;
			}
			return result;
		}

		[MonoPInvokeCallback(typeof(LuaCSFunction))]
		private static int add_down(IntPtr L)
		{
			int result = 0;
			if (WraperUtil.ValidIsString(L, 1, string_add_down) && WraperUtil.ValidIsNumber(L, 2, string_add_down) && WraperUtil.ValidIsString(L, 3, string_add_down) && WraperUtil.ValidIsString(L, 4, string_add_down) && WraperUtil.ValidIsString(L, 5, string_add_down))
			{
				string text = null;
				int num = 0;
				string text2 = null;
				string text3 = null;
				string text4 = null;
				text = LuaDLL.lua_tostring(L, 1);
				num = (int)LuaDLL.lua_tonumber(L, 2);
				text2 = LuaDLL.lua_tostring(L, 3);
				text3 = LuaDLL.lua_tostring(L, 4);
				text4 = LuaDLL.lua_tostring(L, 5);
				HttpUpdateClientWrap.AddDown(text, num, text4, text2, text3);
				result = 0;
			}
			return result;
		}

		[MonoPInvokeCallback(typeof(LuaCSFunction))]
		private static int down(IntPtr L)
		{
			int result = 0;
			if (WraperUtil.ValidIsString(L, 1, string_down) && WraperUtil.ValidIsString(L, 2, string_down) && WraperUtil.ValidIsString(L, 3, string_down) && WraperUtil.ValidIsString(L, 4, string_down) && WraperUtil.ValidIsString(L, 5, string_down) && WraperUtil.ValidIsString(L, 6, string_down))
			{
				string text = null;
				string text2 = null;
				string text3 = null;
				string text4 = null;
				string text5 = null;
				string text6 = null;
				text = LuaDLL.lua_tostring(L, 1);
				text2 = LuaDLL.lua_tostring(L, 2);
				text3 = LuaDLL.lua_tostring(L, 3);
				text4 = LuaDLL.lua_tostring(L, 4);
				text5 = LuaDLL.lua_tostring(L, 5);
				text6 = LuaDLL.lua_tostring(L, 6);
				HttpUpdateClientWrap.Down(text, text5, text6, text2, text3, text4);
				result = 0;
			}
			return result;
		}

		[MonoPInvokeCallback(typeof(LuaCSFunction))]
		private static int get(IntPtr L)
		{
			int result = 0;
			if (WraperUtil.ValidIsString(L, 1, string_get) && WraperUtil.ValidIsString(L, 2, string_get) && WraperUtil.ValidIsString(L, 3, string_get) && WraperUtil.ValidIsString(L, 4, string_get))
			{
				string text = null;
				string text2 = null;
				string text3 = null;
				string text4 = null;
				text = LuaDLL.lua_tostring(L, 1);
				text2 = LuaDLL.lua_tostring(L, 2);
				text3 = LuaDLL.lua_tostring(L, 3);
				text4 = LuaDLL.lua_tostring(L, 4);
				HttpUpdateClientWrap.Request(text, text4, text2, text3, string.Empty);
				result = 0;
			}
			return result;
		}

		[MonoPInvokeCallback(typeof(LuaCSFunction))]
		private static int post(IntPtr L)
		{
			int result = 0;
			if (WraperUtil.ValidIsString(L, 1, string_post) && WraperUtil.ValidIsString(L, 2, string_post) && WraperUtil.ValidIsString(L, 3, string_post) && WraperUtil.ValidIsString(L, 4, string_post) && WraperUtil.ValidIsString(L, 5, string_post))
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
				HttpUpdateClientWrap.Request(text, text4, text2, text3, text5);
				result = 0;
			}
			return result;
		}

		[MonoPInvokeCallback(typeof(LuaCSFunction))]
		private static int post_body_data(IntPtr L)
		{
			int result = 0;
			if (WraperUtil.ValidIsString(L, 1, string_post_body_data) && WraperUtil.ValidIsString(L, 2, string_post_body_data) && WraperUtil.ValidIsString(L, 3, string_post_body_data) && WraperUtil.ValidIsString(L, 4, string_post_body_data))
			{
				string empty = string.Empty;
				string empty2 = string.Empty;
				string empty3 = string.Empty;
				string empty4 = string.Empty;
				empty = LuaDLL.lua_tostring(L, 1);
				empty2 = LuaDLL.lua_tostring(L, 2);
				empty3 = LuaDLL.lua_tostring(L, 3);
				empty4 = LuaDLL.lua_tostring(L, 4);
				UtilWraper.GetInstance().AsyncPost(empty, empty2, empty3, empty4);
				result = 0;
			}
			return result;
		}
	}
}
