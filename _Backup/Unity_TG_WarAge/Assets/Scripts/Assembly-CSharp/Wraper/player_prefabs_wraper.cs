using System;
using LuaInterface;
using UnityEngine;

namespace Wraper
{
	public class player_prefabs_wraper
	{
		public static string libname = "player_prefabs";

		private static luaL_Reg[] libfunc = new luaL_Reg[9]
		{
			new luaL_Reg("set_int", set_int),
			new luaL_Reg("set_float", set_float),
			new luaL_Reg("set_string", set_string),
			new luaL_Reg("get_int", get_int),
			new luaL_Reg("get_float", get_float),
			new luaL_Reg("get_string", get_string),
			new luaL_Reg("has_key", has_key),
			new luaL_Reg("delete_key", delete_key),
			new luaL_Reg("delete_all", delete_all)
		};

		private static string string_set_int = "player_prefabs.set_int";

		private static string string_set_float = "player_prefabs.set_float";

		private static string string_set_string = "player_prefabs.set_string";

		private static string string_get_int = "player_prefabs.get_int";

		private static string string_get_float = "player_prefabs.get_float";

		private static string string_get_string = "player_prefabs.get_string";

		private static string string_has_key = "player_prefabs.has_key";

		private static string string_delete_key = "player_prefabs.delete_key";

		private static string string_delete_all = "player_prefabs.delete_all";

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
		private static int set_int(IntPtr L)
		{
			int result = 0;
			if (WraperUtil.ValidIsString(L, 1, string_set_int) && WraperUtil.ValidIsNumber(L, 2, string_set_int))
			{
				string text = null;
				int num = 0;
				text = LuaDLL.lua_tostring(L, 1);
				num = (int)LuaDLL.lua_tonumber(L, 2);
				PlayerPrefs.SetInt(text, num);
				result = 0;
			}
			return result;
		}

		[MonoPInvokeCallback(typeof(LuaCSFunction))]
		private static int set_float(IntPtr L)
		{
			int result = 0;
			if (WraperUtil.ValidIsString(L, 1, string_set_float) && WraperUtil.ValidIsNumber(L, 2, string_set_float))
			{
				string text = null;
				float num = 0f;
				text = LuaDLL.lua_tostring(L, 1);
				num = (float)LuaDLL.lua_tonumber(L, 2);
				PlayerPrefs.SetFloat(text, num);
				result = 0;
			}
			return result;
		}

		[MonoPInvokeCallback(typeof(LuaCSFunction))]
		private static int set_string(IntPtr L)
		{
			int result = 0;
			if (WraperUtil.ValidIsString(L, 1, string_set_string) && WraperUtil.ValidIsString(L, 2, string_set_string))
			{
				string text = null;
				string text2 = null;
				text = LuaDLL.lua_tostring(L, 1);
				text2 = LuaDLL.lua_tostring(L, 2);
				PlayerPrefs.SetString(text, text2);
				result = 0;
			}
			return result;
		}

		[MonoPInvokeCallback(typeof(LuaCSFunction))]
		private static int get_int(IntPtr L)
		{
			int result = 0;
			if (WraperUtil.ValidIsString(L, 1, string_get_int))
			{
				string text = null;
				text = LuaDLL.lua_tostring(L, 1);
				LuaDLL.lua_pushnumber(L, PlayerPrefs.GetInt(text));
				result = 1;
			}
			return result;
		}

		[MonoPInvokeCallback(typeof(LuaCSFunction))]
		private static int get_float(IntPtr L)
		{
			int result = 0;
			if (WraperUtil.ValidIsString(L, 1, string_get_float))
			{
				string text = null;
				text = LuaDLL.lua_tostring(L, 1);
				LuaDLL.lua_pushnumber(L, PlayerPrefs.GetFloat(text));
				result = 1;
			}
			return result;
		}

		[MonoPInvokeCallback(typeof(LuaCSFunction))]
		private static int get_string(IntPtr L)
		{
			int result = 0;
			if (WraperUtil.ValidIsString(L, 1, string_get_string))
			{
				string text = null;
				text = LuaDLL.lua_tostring(L, 1);
				LuaDLL.lua_pushstring(L, PlayerPrefs.GetString(text));
				result = 1;
			}
			return result;
		}

		[MonoPInvokeCallback(typeof(LuaCSFunction))]
		private static int has_key(IntPtr L)
		{
			int result = 0;
			if (WraperUtil.ValidIsString(L, 1, string_has_key))
			{
				string text = null;
				text = LuaDLL.lua_tostring(L, 1);
				LuaDLL.lua_pushboolean(L, PlayerPrefs.HasKey(text));
				result = 1;
			}
			return result;
		}

		[MonoPInvokeCallback(typeof(LuaCSFunction))]
		private static int delete_key(IntPtr L)
		{
			int result = 0;
			if (WraperUtil.ValidIsString(L, 1, string_delete_key))
			{
				string text = null;
				text = LuaDLL.lua_tostring(L, 1);
				PlayerPrefs.DeleteKey(text);
				result = 0;
			}
			return result;
		}

		[MonoPInvokeCallback(typeof(LuaCSFunction))]
		private static int delete_all(IntPtr L)
		{
			int result = 0;
			if (WraperUtil.ValidIsString(L, 1, string_delete_all))
			{
				string text = null;
				text = LuaDLL.lua_tostring(L, 1);
				PlayerPrefs.DeleteAll();
				result = 0;
			}
			return result;
		}
	}
}
