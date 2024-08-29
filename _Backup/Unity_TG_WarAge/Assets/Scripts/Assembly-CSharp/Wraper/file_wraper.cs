using System;
using System.IO;
using Core.Resource;
using LuaInterface;
using UnityEngine;
using UnityWrap;

namespace Wraper
{
	public class file_wraper
	{
		public static string name = "file_object";

		public static string libname = "file";

		private static luaL_Reg[] libfunc = new luaL_Reg[8]
		{
			new luaL_Reg("player_mp4", player_mp4),
			new luaL_Reg("open", open),
			new luaL_Reg("open_read", open_read),
			new luaL_Reg("exist", exist),
			new luaL_Reg("write_exist", write_exist),
			new luaL_Reg("read_exist", read_exist),
			new luaL_Reg("delete", delete),
			new luaL_Reg("delete_dir", delete_dir)
		};

		private static luaL_Reg[] func = new luaL_Reg[16]
		{
			new luaL_Reg("read_all_text", read_all_text),
			new luaL_Reg("read_all_byte", read_all_byte),
			new luaL_Reg("read_line", read_line),
			new luaL_Reg("read_boolean", read_boolean),
			new luaL_Reg("read_int", read_int),
			new luaL_Reg("read_float", read_float),
			new luaL_Reg("read_string", read_string),
			new luaL_Reg("read_bytes", read_bytes),
			new luaL_Reg("write_boolean", write_boolean),
			new luaL_Reg("write_int", write_int),
			new luaL_Reg("write_float", write_float),
			new luaL_Reg("write_string", write_string),
			new luaL_Reg("write_line", write_line),
			new luaL_Reg("write_bytes", write_bytes),
			new luaL_Reg("flush", flush),
			new luaL_Reg("close", close)
		};

		private static string string_player_mp4 = "file_object.player_mp4";

		private static string string_open = "file.open";

		private static string string_open_read = "file.open_read";

		private static string string_exist = "file.exist";

		private static string string_write_exist = "file.write_exist";

		private static string string_read_exist = "file.read_exist";

		private static string string_delete = "file.delete";

		private static string string_delete_dir = "file.delete_dir";

		private static string string_read_all_text = "file_object:read_all_text";

		private static string string_read_all_byte = "file_object:read_all_byte";

		private static string string_read_line = "file_object:read_line";

		private static string string_read_boolean = "file_object:read_boolean";

		private static string string_read_int = "file_object:read_int";

		private static string string_read_float = "file_object:read_float";

		private static string string_read_string = "file_object:read_string";

		private static string string_read_bytes = "file_object:read_bytes";

		private static string string_write_boolean = "file_object:write_boolean";

		private static string string_write_int = "file_object:write_int";

		private static string string_write_float = "file_object:write_float";

		private static string string_write_string = "file_object:write_string";

		private static string string_write_line = "file_object:write_line";

		private static string string_write_bytes = "file_object:write_bytes";

		private static string string_flush = "file_object:flush";

		private static string string_close = "file_object:close";

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

		public static void push(IntPtr L, FileHandleWrap obj)
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
		private static int open(IntPtr L)
		{
			int result = 0;
			if (WraperUtil.ValidIsString(L, 1, string_open) && WraperUtil.ValidIsNumber(L, 2, string_open))
			{
				string text = null;
				int num = 0;
				text = LuaDLL.lua_tostring(L, 1);
				num = (int)LuaDLL.lua_tonumber(L, 2);
				FileStream fileStream = FileHandleWrap.Open(text, num);
				if (fileStream == null)
				{
					WraperUtil.PushObject(L, null);
				}
				else
				{
					FileHandleWrap base_object = FileHandleWrap.CreateInstance(fileStream);
					WraperUtil.PushObject(L, base_object);
				}
				result = 1;
			}
			return result;
		}

		[MonoPInvokeCallback(typeof(LuaCSFunction))]
		private static int open_read(IntPtr L)
		{
			int result = 0;
			if (WraperUtil.ValidIsString(L, 1, string_open_read))
			{
				string text = null;
				text = LuaDLL.lua_tostring(L, 1);
				Stream stream = FileHandleWrap.OpenRead(text);
				if (stream == null)
				{
					WraperUtil.PushObject(L, null);
				}
				else
				{
					FileHandleWrap base_object = FileHandleWrap.CreateInstance(stream);
					WraperUtil.PushObject(L, base_object);
				}
				result = 1;
			}
			return result;
		}

		[MonoPInvokeCallback(typeof(LuaCSFunction))]
		private static int exist(IntPtr L)
		{
			int result = 0;
			if (WraperUtil.ValidIsString(L, 1, string_exist))
			{
				string text = null;
				text = LuaDLL.lua_tostring(L, 1);
				if (FileHandleWrap.Exist(text))
				{
					LuaDLL.lua_pushboolean(L, true);
				}
				else
				{
					LuaDLL.lua_pushboolean(L, false);
				}
				result = 1;
			}
			return result;
		}

		[MonoPInvokeCallback(typeof(LuaCSFunction))]
		private static int player_mp4(IntPtr L)
		{
			int result = 0;
			if (WraperUtil.ValidIsString(L, 1, string_exist))
			{
				string text = null;
				int num = 3;
				text = LuaDLL.lua_tostring(L, 1);
				num = (int)LuaDLL.lua_tonumber(L, 2);
				string empty = string.Empty;
				empty = ((!FileHandleWrap.Exist(text, FileUtil.DirectoryType.WritePath)) ? text : FileUtil.FilePath(text, FileUtil.DirectoryType.WritePath));
				switch (num)
				{
				case 1:
					UtilWraper.GetInstance().AsyncPlayerMp4(empty, Color.black, FullScreenMovieControlMode.CancelOnInput);
					break;
				case 2:
					UtilWraper.GetInstance().AsyncPlayerMp4(empty, Color.black, FullScreenMovieControlMode.Full);
					break;
				case 3:
					UtilWraper.GetInstance().AsyncPlayerMp4(empty, Color.black, FullScreenMovieControlMode.Hidden);
					break;
				case 4:
					UtilWraper.GetInstance().AsyncPlayerMp4(empty, Color.black, FullScreenMovieControlMode.Minimal);
					break;
				}
				result = 0;
			}
			return result;
		}

		[MonoPInvokeCallback(typeof(LuaCSFunction))]
		private static int write_exist(IntPtr L)
		{
			int result = 0;
			if (WraperUtil.ValidIsString(L, 1, string_write_exist))
			{
				string text = null;
				text = LuaDLL.lua_tostring(L, 1);
				if (FileHandleWrap.Exist(text, FileUtil.DirectoryType.WritePath))
				{
					LuaDLL.lua_pushboolean(L, true);
				}
				else
				{
					LuaDLL.lua_pushboolean(L, false);
				}
				result = 1;
			}
			return result;
		}

		[MonoPInvokeCallback(typeof(LuaCSFunction))]
		private static int read_exist(IntPtr L)
		{
			int result = 0;
			if (WraperUtil.ValidIsString(L, 1, string_read_exist))
			{
				string text = null;
				text = LuaDLL.lua_tostring(L, 1);
				if (FileHandleWrap.Exist(text, FileUtil.DirectoryType.ReadPath))
				{
					LuaDLL.lua_pushboolean(L, true);
				}
				else
				{
					LuaDLL.lua_pushboolean(L, false);
				}
				result = 1;
			}
			return result;
		}

		[MonoPInvokeCallback(typeof(LuaCSFunction))]
		private static int delete(IntPtr L)
		{
			int result = 0;
			if (WraperUtil.ValidIsString(L, 1, string_delete))
			{
				string text = null;
				text = LuaDLL.lua_tostring(L, 1);
				FileHandleWrap.Delete(text);
				result = 0;
			}
			return result;
		}

		[MonoPInvokeCallback(typeof(LuaCSFunction))]
		private static int delete_dir(IntPtr L)
		{
			int result = 0;
			if (WraperUtil.ValidIsString(L, 1, string_delete_dir) && WraperUtil.ValidIsBoolean(L, 2, string_delete_dir))
			{
				string text = null;
				bool flag = false;
				text = LuaDLL.lua_tostring(L, 1);
				flag = LuaDLL.lua_toboolean(L, 2);
				FileHandleWrap.DeleteDir(text, flag);
				result = 0;
			}
			return result;
		}

		[MonoPInvokeCallback(typeof(LuaCSFunction))]
		private static int read_all_text(IntPtr L)
		{
			int result = 0;
			if (WraperUtil.ValidIsUserdata(L, 1, string_read_all_text))
			{
				FileHandleWrap fileHandleWrap = null;
				fileHandleWrap = WraperUtil.LuaToUserdata(L, 1, string_read_all_text, FileHandleWrap.cache);
				string value = string.Empty;
				fileHandleWrap.ReadAll(ref value);
				if (value == null)
				{
					LuaDLL.lua_pushnil(L);
				}
				else
				{
					LuaDLL.lua_pushstring(L, value);
				}
				result = 1;
			}
			return result;
		}

		[MonoPInvokeCallback(typeof(LuaCSFunction))]
		private static int read_all_byte(IntPtr L)
		{
			int result = 0;
			if (WraperUtil.ValidIsUserdata(L, 1, string_read_all_byte))
			{
				FileHandleWrap fileHandleWrap = null;
				fileHandleWrap = WraperUtil.LuaToUserdata(L, 1, string_read_all_byte, FileHandleWrap.cache);
				byte[] array = fileHandleWrap.ReadAll();
				if (array.Length == 0)
				{
					LuaDLL.lua_pushnil(L);
				}
				else
				{
					LuaDLL.lua_pushlstring(L, ref array[0], array.Length);
				}
				result = 1;
			}
			return result;
		}

		[MonoPInvokeCallback(typeof(LuaCSFunction))]
		private static int read_line(IntPtr L)
		{
			int result = 0;
			if (WraperUtil.ValidIsUserdata(L, 1, string_read_line))
			{
				FileHandleWrap fileHandleWrap = null;
				fileHandleWrap = WraperUtil.LuaToUserdata(L, 1, string_read_line, FileHandleWrap.cache);
				string value = string.Empty;
				fileHandleWrap.ReadLine(ref value);
				if (value == null)
				{
					LuaDLL.lua_pushnil(L);
				}
				else
				{
					LuaDLL.lua_pushstring(L, value);
				}
				result = 1;
			}
			return result;
		}

		[MonoPInvokeCallback(typeof(LuaCSFunction))]
		private static int read_boolean(IntPtr L)
		{
			int result = 0;
			if (WraperUtil.ValidIsUserdata(L, 1, string_read_boolean))
			{
				FileHandleWrap fileHandleWrap = null;
				fileHandleWrap = WraperUtil.LuaToUserdata(L, 1, string_read_boolean, FileHandleWrap.cache);
				bool value = false;
				if (fileHandleWrap.Read(ref value) == 0)
				{
					LuaDLL.lua_pushnil(L);
				}
				else
				{
					LuaDLL.lua_pushboolean(L, value);
				}
				result = 1;
			}
			return result;
		}

		[MonoPInvokeCallback(typeof(LuaCSFunction))]
		private static int read_int(IntPtr L)
		{
			int result = 0;
			if (WraperUtil.ValidIsUserdata(L, 1, string_read_int))
			{
				FileHandleWrap fileHandleWrap = null;
				fileHandleWrap = WraperUtil.LuaToUserdata(L, 1, string_read_int, FileHandleWrap.cache);
				int value = 0;
				if (fileHandleWrap.Read(ref value) == 0)
				{
					LuaDLL.lua_pushnil(L);
				}
				else
				{
					LuaDLL.lua_pushnumber(L, value);
				}
				result = 1;
			}
			return result;
		}

		[MonoPInvokeCallback(typeof(LuaCSFunction))]
		private static int read_float(IntPtr L)
		{
			int result = 0;
			if (WraperUtil.ValidIsUserdata(L, 1, string_read_float))
			{
				FileHandleWrap fileHandleWrap = null;
				fileHandleWrap = WraperUtil.LuaToUserdata(L, 1, string_read_float, FileHandleWrap.cache);
				float value = 0f;
				if (fileHandleWrap.Read(ref value) == 0)
				{
					LuaDLL.lua_pushnil(L);
				}
				else
				{
					LuaDLL.lua_pushnumber(L, value);
				}
				result = 1;
			}
			return result;
		}

		[MonoPInvokeCallback(typeof(LuaCSFunction))]
		private static int read_string(IntPtr L)
		{
			int result = 0;
			if (WraperUtil.ValidIsUserdata(L, 1, string_read_string))
			{
				FileHandleWrap fileHandleWrap = null;
				fileHandleWrap = WraperUtil.LuaToUserdata(L, 1, string_read_string, FileHandleWrap.cache);
				string value = string.Empty;
				int num = fileHandleWrap.Read(ref value);
				LuaDLL.lua_pushstring(L, value);
				result = 1;
			}
			return result;
		}

		[MonoPInvokeCallback(typeof(LuaCSFunction))]
		private static int read_bytes(IntPtr L)
		{
			int result = 0;
			if (WraperUtil.ValidIsUserdata(L, 1, string_read_bytes) && WraperUtil.ValidIsNumber(L, 2, string_read_bytes))
			{
				FileHandleWrap fileHandleWrap = null;
				int num = 0;
				fileHandleWrap = WraperUtil.LuaToUserdata(L, 1, string_read_bytes, FileHandleWrap.cache);
				num = (int)LuaDLL.lua_tonumber(L, 2);
				byte[] array = new byte[num];
				if (fileHandleWrap.Read(array, num) == 0)
				{
					LuaDLL.lua_pushnil(L);
				}
				else
				{
					LuaDLL.lua_pushlstring(L, ref array[0], array.Length);
				}
				result = 1;
			}
			return result;
		}

		[MonoPInvokeCallback(typeof(LuaCSFunction))]
		private static int write_boolean(IntPtr L)
		{
			int result = 0;
			if (WraperUtil.ValidIsUserdata(L, 1, string_write_boolean) && WraperUtil.ValidIsBoolean(L, 2, string_write_boolean))
			{
				FileHandleWrap fileHandleWrap = null;
				bool flag = false;
				fileHandleWrap = WraperUtil.LuaToUserdata(L, 1, string_write_boolean, FileHandleWrap.cache);
				flag = LuaDLL.lua_toboolean(L, 2);
				fileHandleWrap.Write(flag);
				result = 0;
			}
			return result;
		}

		[MonoPInvokeCallback(typeof(LuaCSFunction))]
		private static int write_int(IntPtr L)
		{
			int result = 0;
			if (WraperUtil.ValidIsUserdata(L, 1, string_write_int) && WraperUtil.ValidIsNumber(L, 2, string_write_int))
			{
				FileHandleWrap fileHandleWrap = null;
				int num = 0;
				fileHandleWrap = WraperUtil.LuaToUserdata(L, 1, string_write_int, FileHandleWrap.cache);
				num = (int)LuaDLL.lua_tonumber(L, 2);
				fileHandleWrap.Write(num);
				result = 0;
			}
			return result;
		}

		[MonoPInvokeCallback(typeof(LuaCSFunction))]
		private static int write_float(IntPtr L)
		{
			int result = 0;
			if (WraperUtil.ValidIsUserdata(L, 1, string_write_float) && WraperUtil.ValidIsNumber(L, 2, string_write_float))
			{
				FileHandleWrap fileHandleWrap = null;
				float num = 0f;
				fileHandleWrap = WraperUtil.LuaToUserdata(L, 1, string_write_float, FileHandleWrap.cache);
				num = (float)LuaDLL.lua_tonumber(L, 2);
				fileHandleWrap.Write(num);
				result = 0;
			}
			return result;
		}

		[MonoPInvokeCallback(typeof(LuaCSFunction))]
		private static int write_string(IntPtr L)
		{
			int result = 0;
			if (WraperUtil.ValidIsUserdata(L, 1, string_write_string) && WraperUtil.ValidIsString(L, 2, string_write_string))
			{
				FileHandleWrap fileHandleWrap = null;
				string text = null;
				fileHandleWrap = WraperUtil.LuaToUserdata(L, 1, string_write_string, FileHandleWrap.cache);
				text = LuaDLL.lua_tostring(L, 2);
				fileHandleWrap.Write(text);
				result = 0;
			}
			return result;
		}

		[MonoPInvokeCallback(typeof(LuaCSFunction))]
		private static int write_line(IntPtr L)
		{
			int result = 0;
			if (WraperUtil.ValidIsUserdata(L, 1, string_write_line) && WraperUtil.ValidIsString(L, 2, string_write_line))
			{
				FileHandleWrap fileHandleWrap = null;
				string text = null;
				fileHandleWrap = WraperUtil.LuaToUserdata(L, 1, string_write_line, FileHandleWrap.cache);
				text = LuaDLL.lua_tostring(L, 2);
				fileHandleWrap.WriteLine(text);
				result = 0;
			}
			return result;
		}

		[MonoPInvokeCallback(typeof(LuaCSFunction))]
		private static int write_bytes(IntPtr L)
		{
			int result = 0;
			if (WraperUtil.ValidIsUserdata(L, 1, string_write_bytes) && WraperUtil.ValidIsLString(L, 2, string_write_bytes))
			{
				FileHandleWrap fileHandleWrap = null;
				int strLen = 0;
				IntPtr zero = IntPtr.Zero;
				fileHandleWrap = WraperUtil.LuaToUserdata(L, 1, string_write_bytes, FileHandleWrap.cache);
				zero = LuaDLL.lua_tolstring(L, 2, out strLen);
				fileHandleWrap.Write(zero, strLen);
				result = 0;
			}
			return result;
		}

		[MonoPInvokeCallback(typeof(LuaCSFunction))]
		private static int flush(IntPtr L)
		{
			int result = 0;
			if (WraperUtil.ValidIsUserdata(L, 1, string_flush))
			{
				FileHandleWrap fileHandleWrap = null;
				fileHandleWrap = WraperUtil.LuaToUserdata(L, 1, string_flush, FileHandleWrap.cache);
				fileHandleWrap.Flush();
				result = 0;
			}
			return result;
		}

		[MonoPInvokeCallback(typeof(LuaCSFunction))]
		private static int close(IntPtr L)
		{
			int result = 0;
			if (WraperUtil.ValidIsUserdata(L, 1, string_close))
			{
				FileHandleWrap fileHandleWrap = null;
				fileHandleWrap = WraperUtil.LuaToUserdata(L, 1, string_close, FileHandleWrap.cache);
				fileHandleWrap.Close();
				result = 0;
			}
			return result;
		}

		[MonoPInvokeCallback(typeof(LuaCSFunction))]
		private static int gc(IntPtr L)
		{
			try
			{
				FileHandleWrap fileHandleWrap = WraperUtil.LuaToUserdataByGc(L, 1, "gc file_object", FileHandleWrap.cache);
				if (fileHandleWrap != null)
				{
					FileHandleWrap.DestroyInstance(fileHandleWrap);
				}
			}
			catch
			{
				Debug.Log("GC ERROR");
			}
			return 0;
		}
	}
}
