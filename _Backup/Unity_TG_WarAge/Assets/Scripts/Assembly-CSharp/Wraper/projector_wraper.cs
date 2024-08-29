using System;
using LuaInterface;
using UnityWrap;

namespace Wraper
{
	public class projector_wraper
	{
		public static string name = "projector_object";

		private static luaL_Reg[] func = new luaL_Reg[3]
		{
			new luaL_Reg("set_orthographic", set_orthographic),
			new luaL_Reg("set_orthographic_size", set_orthographic_size),
			new luaL_Reg("set_aspect_ratio", set_aspect_ratio)
		};

		private static string string_set_orthographic = "projector_object:set_orthographic";

		private static string string_set_orthographic_size = "projector_object:set_orthographic_size";

		private static string string_set_aspect_ratio = "projector_object:set_aspect_ratio";

		public static bool init(IntPtr L)
		{
			if (L != IntPtr.Zero)
			{
				LuaDLL.register_class(L, name, func, gc);
				return true;
			}
			return false;
		}

		public static void push(IntPtr L, ProjectorWrap obj)
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
		private static int set_orthographic(IntPtr L)
		{
			int result = 0;
			if (WraperUtil.ValidIsUserdata(L, 1, string_set_orthographic) && WraperUtil.ValidIsBoolean(L, 2, string_set_orthographic))
			{
				ProjectorWrap projectorWrap = null;
				bool flag = false;
				projectorWrap = WraperUtil.LuaToUserdata(L, 1, string_set_orthographic, ProjectorWrap.cache);
				flag = LuaDLL.lua_toboolean(L, 2);
				projectorWrap.component.orthographic = flag;
				result = 0;
			}
			return result;
		}

		[MonoPInvokeCallback(typeof(LuaCSFunction))]
		private static int set_orthographic_size(IntPtr L)
		{
			int result = 0;
			if (WraperUtil.ValidIsUserdata(L, 1, string_set_orthographic_size) && WraperUtil.ValidIsNumber(L, 2, string_set_orthographic_size))
			{
				ProjectorWrap projectorWrap = null;
				float num = 0f;
				projectorWrap = WraperUtil.LuaToUserdata(L, 1, string_set_orthographic_size, ProjectorWrap.cache);
				num = (float)LuaDLL.lua_tonumber(L, 2);
				projectorWrap.component.orthographicSize = num;
				result = 0;
			}
			return result;
		}

		[MonoPInvokeCallback(typeof(LuaCSFunction))]
		private static int set_aspect_ratio(IntPtr L)
		{
			int result = 0;
			if (WraperUtil.ValidIsUserdata(L, 1, string_set_aspect_ratio) && WraperUtil.ValidIsNumber(L, 2, string_set_aspect_ratio))
			{
				ProjectorWrap projectorWrap = null;
				float num = 0f;
				projectorWrap = WraperUtil.LuaToUserdata(L, 1, string_set_aspect_ratio, ProjectorWrap.cache);
				num = (float)LuaDLL.lua_tonumber(L, 2);
				projectorWrap.component.aspectRatio = num;
				result = 0;
			}
			return result;
		}

		[MonoPInvokeCallback(typeof(LuaCSFunction))]
		private static int gc(IntPtr L)
		{
			ProjectorWrap projectorWrap = WraperUtil.LuaToUserdataByGc(L, 1, "gc projector_object", ProjectorWrap.cache);
			if (projectorWrap != null)
			{
				ProjectorWrap.DestroyInstance(projectorWrap);
			}
			return 0;
		}
	}
}
