using System;
using LuaInterface;
using UnityWrap;

namespace Wraper
{
	public class texture_wraper
	{
		public static string name = "texture_object";

		public static string libname = "texture";

		private static luaL_Reg[] libfunc = new luaL_Reg[3]
		{
			new luaL_Reg("load", load),
			new luaL_Reg("load_resource", load_resource),
			new luaL_Reg("create", create)
		};

		private static luaL_Reg[] func = new luaL_Reg[3]
		{
			new luaL_Reg("get_width", get_width),
			new luaL_Reg("get_size", get_size),
			new luaL_Reg("set_name", set_name)
		};

		private static string string_load = "texture.load";

		private static string string_load_resource = "texture.load_resource";

		private static string string_create = "texture.create";

		private static string string_get_width = "texture_object:get_width";

		private static string string_get_size = "texture_object:get_size";

		private static string string_set_name = "texture_object:set_name";

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

		public static void push(IntPtr L, TextureWrap obj)
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
		private static int load(IntPtr L)
		{
			int result = 0;
			if (WraperUtil.ValidIsString(L, 1, string_load) && WraperUtil.ValidIsString(L, 2, string_load))
			{
				string text = null;
				string text2 = null;
				text = LuaDLL.lua_tostring(L, 1);
				text2 = LuaDLL.lua_tostring(L, 2);
				TextureWrap.Load(text, text2);
				result = 0;
			}
			return result;
		}

		[MonoPInvokeCallback(typeof(LuaCSFunction))]
		private static int load_resource(IntPtr L)
		{
			int result = 0;
			if (WraperUtil.ValidIsString(L, 1, string_load_resource))
			{
				string text = null;
				text = LuaDLL.lua_tostring(L, 1);
				WraperUtil.PushObject(L, TextureWrap.Load(text));
				result = 1;
			}
			return result;
		}

		[MonoPInvokeCallback(typeof(LuaCSFunction))]
		private static int create(IntPtr L)
		{
			int result = 0;
			if (WraperUtil.ValidIsNumber(L, 1, string_create) && WraperUtil.ValidIsNumber(L, 2, string_create))
			{
				int num = 0;
				int num2 = 0;
				num = (int)LuaDLL.lua_tonumber(L, 1);
				num2 = (int)LuaDLL.lua_tonumber(L, 2);
				WraperUtil.PushObject(L, TextureWrap.Create(num, num2));
				result = 1;
			}
			return result;
		}

		[MonoPInvokeCallback(typeof(LuaCSFunction))]
		private static int get_width(IntPtr L)
		{
			int result = 0;
			if (WraperUtil.ValidIsUserdata(L, 1, string_get_width))
			{
				TextureWrap textureWrap = null;
				textureWrap = WraperUtil.LuaToUserdata(L, 1, string_get_width, TextureWrap.cache);
				LuaDLL.lua_pushnumber(L, textureWrap.component.width);
				result = 1;
			}
			return result;
		}

		[MonoPInvokeCallback(typeof(LuaCSFunction))]
		private static int get_size(IntPtr L)
		{
			int result = 0;
			if (WraperUtil.ValidIsUserdata(L, 1, string_get_size))
			{
				TextureWrap textureWrap = null;
				textureWrap = WraperUtil.LuaToUserdata(L, 1, string_get_size, TextureWrap.cache);
				LuaDLL.lua_pushnumber(L, textureWrap.component.width);
				LuaDLL.lua_pushnumber(L, textureWrap.component.height);
				result = 2;
			}
			return result;
		}

		[MonoPInvokeCallback(typeof(LuaCSFunction))]
		private static int set_name(IntPtr L)
		{
			int result = 0;
			if (WraperUtil.ValidIsUserdata(L, 1, string_set_name) && WraperUtil.ValidIsString(L, 2, string_set_name))
			{
				TextureWrap textureWrap = null;
				string text = null;
				textureWrap = WraperUtil.LuaToUserdata(L, 1, string_set_name, TextureWrap.cache);
				text = LuaDLL.lua_tostring(L, 2);
				textureWrap.component.name = text;
				result = 0;
			}
			return result;
		}

		[MonoPInvokeCallback(typeof(LuaCSFunction))]
		private static int gc(IntPtr L)
		{
			TextureWrap textureWrap = WraperUtil.LuaToUserdataByGc(L, 1, "gc texture_object", TextureWrap.cache);
			if (textureWrap != null)
			{
				TextureWrap.DestroyInstance(textureWrap);
			}
			return 0;
		}
	}
}
