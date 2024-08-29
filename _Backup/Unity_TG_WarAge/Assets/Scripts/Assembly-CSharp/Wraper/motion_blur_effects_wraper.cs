using System;
using LuaInterface;
using UnityWrap;

namespace Wraper
{
	public class motion_blur_effects_wraper
	{
		public static string name = "motion_blur_effects_object";

		private static luaL_Reg[] func = new luaL_Reg[5]
		{
			new luaL_Reg("set_enable", set_enable),
			new luaL_Reg("set_value", set_value),
			new luaL_Reg("get_intensity_value", get_intensity_value),
			new luaL_Reg("begin_blur_tween", begin_blur_tween),
			new luaL_Reg("begin_tc_tween", begin_tc_tween)
		};

		private static string string_set_enable = "motion_blur_effects_object:set_enable";

		private static string string_set_value = "motion_blur_effects_object:set_value";

		private static string string_get_intensity_value = "motion_blur_effects_object:get_intensity_value";

		private static string string_begin_blur_tween = "motion_blur_effects_object;begin_blur_tween";

		private static string string_begin_tc_tween = "motion_blur_effects_object:begin_tc_tween";

		public static bool init(IntPtr L)
		{
			if (L != IntPtr.Zero)
			{
				LuaDLL.register_class(L, name, func, gc);
				return true;
			}
			return false;
		}

		public static void push(IntPtr L, MotionBlurEffectsWrap obj)
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
		private static int set_enable(IntPtr L)
		{
			int result = 0;
			if (WraperUtil.ValidIsUserdata(L, 1, string_set_enable) && WraperUtil.ValidIsBoolean(L, 2, string_set_enable))
			{
				MotionBlurEffectsWrap motionBlurEffectsWrap = null;
				bool flag = false;
				motionBlurEffectsWrap = WraperUtil.LuaToUserdata(L, 1, string_set_enable, MotionBlurEffectsWrap.cache);
				flag = LuaDLL.lua_toboolean(L, 2);
				motionBlurEffectsWrap.component.enabled = flag;
				WraperUtil.PushObject(L, MotionBlurEffectsWrap.CreateInstance(motionBlurEffectsWrap.component));
				result = 1;
			}
			return result;
		}

		[MonoPInvokeCallback(typeof(LuaCSFunction))]
		private static int set_value(IntPtr L)
		{
			int result = 0;
			if (WraperUtil.ValidIsUserdata(L, 1, string_set_value) && WraperUtil.ValidIsNumber(L, 2, string_set_value) && WraperUtil.ValidIsNumber(L, 3, string_set_value) && WraperUtil.ValidIsNumber(L, 4, string_set_value) && WraperUtil.ValidIsNumber(L, 5, string_set_value))
			{
				MotionBlurEffectsWrap motionBlurEffectsWrap = null;
				float num = 0f;
				float num2 = 0f;
				float num3 = 0f;
				float num4 = 0f;
				motionBlurEffectsWrap = WraperUtil.LuaToUserdata(L, 1, string_set_value, MotionBlurEffectsWrap.cache);
				num = (float)LuaDLL.lua_tonumber(L, 2);
				num2 = (float)LuaDLL.lua_tonumber(L, 3);
				num3 = (float)LuaDLL.lua_tonumber(L, 4);
				num4 = (float)LuaDLL.lua_tonumber(L, 5);
				motionBlurEffectsWrap.component.SetValue(num, num2, num3, num4);
				WraperUtil.PushObject(L, MotionBlurEffectsWrap.CreateInstance(motionBlurEffectsWrap.component));
				result = 1;
			}
			return result;
		}

		[MonoPInvokeCallback(typeof(LuaCSFunction))]
		private static int get_intensity_value(IntPtr L)
		{
			int result = 0;
			if (WraperUtil.ValidIsUserdata(L, 1, string_get_intensity_value))
			{
				MotionBlurEffectsWrap motionBlurEffectsWrap = null;
				motionBlurEffectsWrap = WraperUtil.LuaToUserdata(L, 1, string_get_intensity_value, MotionBlurEffectsWrap.cache);
				LuaDLL.lua_pushnumber(L, motionBlurEffectsWrap.component.GetIntensityValue());
				result = 1;
			}
			return result;
		}

		[MonoPInvokeCallback(typeof(LuaCSFunction))]
		private static int begin_blur_tween(IntPtr L)
		{
			int result = 0;
			if (WraperUtil.ValidIsUserdata(L, 1, string_begin_blur_tween) && WraperUtil.ValidIsNumber(L, 2, string_begin_blur_tween) && WraperUtil.ValidIsNumber(L, 3, string_begin_blur_tween) && WraperUtil.ValidIsNumber(L, 4, string_begin_blur_tween))
			{
				MotionBlurEffectsWrap motionBlurEffectsWrap = WraperUtil.LuaToUserdata(L, 1, string_begin_blur_tween, MotionBlurEffectsWrap.cache);
				float from = (float)LuaDLL.lua_tonumber(L, 2);
				float to = (float)LuaDLL.lua_tonumber(L, 3);
				float duration = (float)LuaDLL.lua_tonumber(L, 4);
				motionBlurEffectsWrap.component.BeginBlurTween(from, to, duration);
				WraperUtil.PushObject(L, MotionBlurEffectsWrap.CreateInstance(motionBlurEffectsWrap.component));
				result = 1;
			}
			return result;
		}

		[MonoPInvokeCallback(typeof(LuaCSFunction))]
		private static int begin_tc_tween(IntPtr L)
		{
			int result = 0;
			if (WraperUtil.ValidIsUserdata(L, 1, string_begin_blur_tween) && WraperUtil.ValidIsNumber(L, 2, string_begin_blur_tween) && WraperUtil.ValidIsNumber(L, 3, string_begin_blur_tween) && WraperUtil.ValidIsNumber(L, 4, string_begin_blur_tween))
			{
				MotionBlurEffectsWrap motionBlurEffectsWrap = WraperUtil.LuaToUserdata(L, 1, string_begin_blur_tween, MotionBlurEffectsWrap.cache);
				float tcfrom = (float)LuaDLL.lua_tonumber(L, 2);
				float tcto = (float)LuaDLL.lua_tonumber(L, 3);
				float duration = (float)LuaDLL.lua_tonumber(L, 4);
				motionBlurEffectsWrap.component.BeginTcTween(tcfrom, tcto, duration);
				WraperUtil.PushObject(L, MotionBlurEffectsWrap.CreateInstance(motionBlurEffectsWrap.component));
				result = 1;
			}
			return result;
		}

		[MonoPInvokeCallback(typeof(LuaCSFunction))]
		private static int gc(IntPtr L)
		{
			MotionBlurEffectsWrap motionBlurEffectsWrap = WraperUtil.LuaToUserdataByGc(L, 1, "gc MotionBlurEffects obj", MotionBlurEffectsWrap.cache);
			if (motionBlurEffectsWrap != null)
			{
				MotionBlurEffectsWrap.DestroyInstance(motionBlurEffectsWrap);
			}
			return 0;
		}
	}
}
