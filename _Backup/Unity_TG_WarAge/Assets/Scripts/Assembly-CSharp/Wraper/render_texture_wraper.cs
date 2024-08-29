using System;
using LuaInterface;
using UnityWrap;

namespace Wraper
{
	public class render_texture_wraper
	{
		public static string name = "render_texture_object";

		public static string libname = "render_texture";

		private static luaL_Reg[] libfunc = new luaL_Reg[1]
		{
			new luaL_Reg("create", create)
		};

		private static luaL_Reg[] func = new luaL_Reg[2]
		{
			new luaL_Reg("get_width", get_width),
			new luaL_Reg("get_height", get_height)
		};

		private static string string_create = "render_texture.create";

		private static string string_get_width = "render_texture_object:get_width";

		private static string string_get_height = "render_texture_object:get_height";

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

		public static void push(IntPtr L, RenderTextureWrap obj)
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
		private static int create(IntPtr L)
		{
			int result = 0;
			if (WraperUtil.ValidIsNumber(L, 1, string_create) && WraperUtil.ValidIsNumber(L, 2, string_create) && WraperUtil.ValidIsNumber(L, 3, string_create) && WraperUtil.ValidIsNumber(L, 4, string_create))
			{
				int num = 0;
				int num2 = 0;
				int num3 = 0;
				int num4 = 0;
				num = (int)LuaDLL.lua_tonumber(L, 1);
				num2 = (int)LuaDLL.lua_tonumber(L, 2);
				num3 = (int)LuaDLL.lua_tonumber(L, 3);
				num4 = (int)LuaDLL.lua_tonumber(L, 4);
				WraperUtil.PushObject(L, RenderTextureWrap.Create(num, num2, num3, num4));
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
				RenderTextureWrap renderTextureWrap = null;
				renderTextureWrap = WraperUtil.LuaToUserdata(L, 1, string_get_width, RenderTextureWrap.cache);
				LuaDLL.lua_pushnumber(L, renderTextureWrap.component.width);
				result = 1;
			}
			return result;
		}

		[MonoPInvokeCallback(typeof(LuaCSFunction))]
		private static int get_height(IntPtr L)
		{
			int result = 0;
			if (WraperUtil.ValidIsUserdata(L, 1, string_get_height))
			{
				RenderTextureWrap renderTextureWrap = null;
				renderTextureWrap = WraperUtil.LuaToUserdata(L, 1, string_get_height, RenderTextureWrap.cache);
				LuaDLL.lua_pushnumber(L, renderTextureWrap.component.height);
				result = 1;
			}
			return result;
		}

		[MonoPInvokeCallback(typeof(LuaCSFunction))]
		private static int gc(IntPtr L)
		{
			RenderTextureWrap renderTextureWrap = WraperUtil.LuaToUserdataByGc(L, 1, "gc render_texture_object", RenderTextureWrap.cache);
			if (renderTextureWrap != null)
			{
				RenderTextureWrap.DestroyInstance(renderTextureWrap);
			}
			return 0;
		}
	}
}
