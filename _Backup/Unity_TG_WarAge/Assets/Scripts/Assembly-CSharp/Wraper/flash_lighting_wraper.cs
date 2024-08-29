using System;
using LuaInterface;
using UnityEngine;
using UnityWrap;

namespace Wraper
{
	public class flash_lighting_wraper
	{
		public static string name = "flash_lighting_object";

		private static luaL_Reg[] func = new luaL_Reg[3]
		{
			new luaL_Reg("set_target_position", set_target_position),
			new luaL_Reg("set_source_position", set_source_position),
			new luaL_Reg("set_active", set_active)
		};

		private static string string_set_target_position = "flash_lighting_object:set_target_position";

		private static string string_set_source_position = "flash_lighting_object:set_source_position";

		private static string string_set_active = "flash_lighting_object:set_active";

		public static bool init(IntPtr L)
		{
			if (L != IntPtr.Zero)
			{
				LuaDLL.register_class(L, name, func, gc);
				return true;
			}
			return false;
		}

		public static void push(IntPtr L, FlashLightingWrap obj)
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
		private static int set_target_position(IntPtr L)
		{
			int result = 0;
			if (WraperUtil.ValidIsUserdata(L, 1, string_set_target_position) && WraperUtil.ValidIsNumber(L, 2, string_set_target_position) && WraperUtil.ValidIsNumber(L, 3, string_set_target_position) && WraperUtil.ValidIsNumber(L, 4, string_set_target_position))
			{
				FlashLightingWrap flashLightingWrap = null;
				float num = 0f;
				float num2 = 0f;
				float num3 = 0f;
				flashLightingWrap = WraperUtil.LuaToUserdata(L, 1, string_set_target_position, FlashLightingWrap.cache);
				num = (float)LuaDLL.lua_tonumber(L, 2);
				num2 = (float)LuaDLL.lua_tonumber(L, 3);
				num3 = (float)LuaDLL.lua_tonumber(L, 4);
				if (flashLightingWrap != null)
				{
					flashLightingWrap.component.startPos = new Vector3(num, num2, num3);
				}
				result = 0;
			}
			return result;
		}

		[MonoPInvokeCallback(typeof(LuaCSFunction))]
		private static int set_source_position(IntPtr L)
		{
			int result = 0;
			if (WraperUtil.ValidIsUserdata(L, 1, string_set_source_position) && WraperUtil.ValidIsNumber(L, 2, string_set_source_position) && WraperUtil.ValidIsNumber(L, 3, string_set_source_position) && WraperUtil.ValidIsNumber(L, 4, string_set_source_position))
			{
				FlashLightingWrap flashLightingWrap = null;
				float num = 0f;
				float num2 = 0f;
				float num3 = 0f;
				flashLightingWrap = WraperUtil.LuaToUserdata(L, 1, string_set_source_position, FlashLightingWrap.cache);
				num = (float)LuaDLL.lua_tonumber(L, 2);
				num2 = (float)LuaDLL.lua_tonumber(L, 3);
				num3 = (float)LuaDLL.lua_tonumber(L, 4);
				if (flashLightingWrap != null)
				{
					flashLightingWrap.component.endPos = new Vector3(num, num2, num3);
				}
				result = 0;
			}
			return result;
		}

		[MonoPInvokeCallback(typeof(LuaCSFunction))]
		private static int set_active(IntPtr L)
		{
			int result = 0;
			if (WraperUtil.ValidIsUserdata(L, 1, string_set_active) && WraperUtil.ValidIsBoolean(L, 2, string_set_active))
			{
				FlashLightingWrap flashLightingWrap = null;
				bool flag = false;
				flashLightingWrap = WraperUtil.LuaToUserdata(L, 1, string_set_active, FlashLightingWrap.cache);
				flag = LuaDLL.lua_toboolean(L, 2);
				if (flashLightingWrap != null)
				{
					flashLightingWrap.component.activeFlash = flag;
				}
				result = 0;
			}
			return result;
		}

		[MonoPInvokeCallback(typeof(LuaCSFunction))]
		private static int gc(IntPtr L)
		{
			FlashLightingWrap flashLightingWrap = WraperUtil.LuaToUserdataByGc(L, 1, "gc flash_lighting_object", FlashLightingWrap.cache);
			if (flashLightingWrap != null)
			{
				FlashLightingWrap.DestroyInstance(flashLightingWrap);
			}
			return 0;
		}
	}
}
