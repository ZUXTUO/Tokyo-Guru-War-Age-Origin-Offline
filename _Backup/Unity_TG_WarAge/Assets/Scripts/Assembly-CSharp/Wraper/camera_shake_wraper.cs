using System;
using LuaInterface;
using UnityEngine;
using UnityWrap;

namespace Wraper
{
	public class camera_shake_wraper
	{
		public static string name = "camera_shake_object";

		private static luaL_Reg[] func = new luaL_Reg[9]
		{
			new luaL_Reg("shake", shake),
			new luaL_Reg("shake_with", shake_with),
			new luaL_Reg("set_shake_number", set_shake_number),
			new luaL_Reg("set_shake_amount", set_shake_amount),
			new luaL_Reg("set_shake_distance", set_shake_distance),
			new luaL_Reg("set_shake_speed", set_shake_speed),
			new luaL_Reg("set_shake_decay", set_shake_decay),
			new luaL_Reg("set_multiply_by_timeScale", set_multiply_by_timeScale),
			new luaL_Reg("cancel_shake", cancel_shake)
		};

		private static string string_shake = "camera_shake_object:shake";

		private static string string_shake_with = "camera_shake_object:shake_with";

		private static string string_set_shake_number = "camera_shake_object:set_shake_number";

		private static string string_set_shake_amount = "camera_shake_object:set_shake_amount";

		private static string string_set_shake_distance = "camera_shake_object:set_shake_distance";

		private static string string_set_shake_speed = "camera_shake_object:set_shake_speed";

		private static string string_set_shake_decay = "camera_shake_object:set_shake_decay";

		private static string string_set_multiply_by_timeScale = "camera_shake_object:set_multiply_by_timeScale";

		private static string string_cancel_shake = "camera_shake_object:cancel_shake";

		public static bool init(IntPtr L)
		{
			if (L != IntPtr.Zero)
			{
				LuaDLL.register_class(L, name, func, gc);
				return true;
			}
			return false;
		}

		public static void push(IntPtr L, CameraShakeWrap obj)
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
		private static int shake(IntPtr L)
		{
			int result = 0;
			if (WraperUtil.ValidIsUserdata(L, 1, string_shake))
			{
				CameraShakeWrap cameraShakeWrap = null;
				cameraShakeWrap = WraperUtil.LuaToUserdata(L, 1, string_shake, CameraShakeWrap.cache);
				cameraShakeWrap.component.DoShake();
				result = 0;
			}
			return result;
		}

		[MonoPInvokeCallback(typeof(LuaCSFunction))]
		private static int shake_with(IntPtr L)
		{
			int result = 0;
			if (WraperUtil.ValidIsUserdata(L, 1, string_shake_with) && WraperUtil.ValidIsNumber(L, 2, string_shake_with) && WraperUtil.ValidIsNumber(L, 3, string_shake_with) && WraperUtil.ValidIsNumber(L, 4, string_shake_with) && WraperUtil.ValidIsNumber(L, 5, string_shake_with) && WraperUtil.ValidIsNumber(L, 6, string_shake_with) && WraperUtil.ValidIsNumber(L, 7, string_shake_with) && WraperUtil.ValidIsNumber(L, 8, string_shake_with) && WraperUtil.ValidIsBoolean(L, 9, string_shake_with))
			{
				CameraShakeWrap cameraShakeWrap = null;
				int num = 0;
				float num2 = 0f;
				float num3 = 0f;
				float num4 = 0f;
				float num5 = 0f;
				float num6 = 0f;
				float num7 = 0f;
				bool flag = false;
				cameraShakeWrap = WraperUtil.LuaToUserdata(L, 1, string_shake_with, CameraShakeWrap.cache);
				num = (int)LuaDLL.lua_tonumber(L, 2);
				num2 = (float)LuaDLL.lua_tonumber(L, 3);
				num3 = (float)LuaDLL.lua_tonumber(L, 4);
				num4 = (float)LuaDLL.lua_tonumber(L, 5);
				num5 = (float)LuaDLL.lua_tonumber(L, 6);
				num6 = (float)LuaDLL.lua_tonumber(L, 7);
				num7 = (float)LuaDLL.lua_tonumber(L, 8);
				flag = LuaDLL.lua_toboolean(L, 9);
				cameraShakeWrap.component.DoShake(num, new Vector3(num2, num3, num4), Vector3.zero, num5, num6, num7, flag);
				result = 0;
			}
			return result;
		}

		[MonoPInvokeCallback(typeof(LuaCSFunction))]
		private static int set_shake_number(IntPtr L)
		{
			int result = 0;
			if (WraperUtil.ValidIsUserdata(L, 1, string_set_shake_number) && WraperUtil.ValidIsNumber(L, 2, string_set_shake_number))
			{
				CameraShakeWrap cameraShakeWrap = null;
				int num = 0;
				cameraShakeWrap = WraperUtil.LuaToUserdata(L, 1, string_set_shake_number, CameraShakeWrap.cache);
				num = (int)LuaDLL.lua_tonumber(L, 2);
				cameraShakeWrap.component.numberOfShakes = num;
				result = 0;
			}
			return result;
		}

		[MonoPInvokeCallback(typeof(LuaCSFunction))]
		private static int set_shake_amount(IntPtr L)
		{
			int result = 0;
			if (WraperUtil.ValidIsUserdata(L, 1, string_set_shake_amount) && WraperUtil.ValidIsNumber(L, 2, string_set_shake_amount) && WraperUtil.ValidIsNumber(L, 3, string_set_shake_amount) && WraperUtil.ValidIsNumber(L, 4, string_set_shake_amount))
			{
				CameraShakeWrap cameraShakeWrap = null;
				float num = 0f;
				float num2 = 0f;
				float num3 = 0f;
				cameraShakeWrap = WraperUtil.LuaToUserdata(L, 1, string_set_shake_amount, CameraShakeWrap.cache);
				num = (float)LuaDLL.lua_tonumber(L, 2);
				num2 = (float)LuaDLL.lua_tonumber(L, 3);
				num3 = (float)LuaDLL.lua_tonumber(L, 4);
				cameraShakeWrap.component.shakeAmount = new Vector3(num, num2, num3);
				result = 0;
			}
			return result;
		}

		[MonoPInvokeCallback(typeof(LuaCSFunction))]
		private static int set_shake_distance(IntPtr L)
		{
			int result = 0;
			if (WraperUtil.ValidIsUserdata(L, 1, string_set_shake_distance) && WraperUtil.ValidIsNumber(L, 2, string_set_shake_distance))
			{
				CameraShakeWrap cameraShakeWrap = null;
				float num = 0f;
				cameraShakeWrap = WraperUtil.LuaToUserdata(L, 1, string_set_shake_distance, CameraShakeWrap.cache);
				num = (float)LuaDLL.lua_tonumber(L, 2);
				cameraShakeWrap.component.distance = num;
				result = 0;
			}
			return result;
		}

		[MonoPInvokeCallback(typeof(LuaCSFunction))]
		private static int set_shake_speed(IntPtr L)
		{
			int result = 0;
			if (WraperUtil.ValidIsUserdata(L, 1, string_set_shake_speed) && WraperUtil.ValidIsNumber(L, 2, string_set_shake_speed))
			{
				CameraShakeWrap cameraShakeWrap = null;
				float num = 0f;
				cameraShakeWrap = WraperUtil.LuaToUserdata(L, 1, string_set_shake_speed, CameraShakeWrap.cache);
				num = (float)LuaDLL.lua_tonumber(L, 2);
				cameraShakeWrap.component.speed = num;
				result = 0;
			}
			return result;
		}

		[MonoPInvokeCallback(typeof(LuaCSFunction))]
		private static int set_shake_decay(IntPtr L)
		{
			int result = 0;
			if (WraperUtil.ValidIsUserdata(L, 1, string_set_shake_decay) && WraperUtil.ValidIsNumber(L, 2, string_set_shake_decay))
			{
				CameraShakeWrap cameraShakeWrap = null;
				float num = 0f;
				cameraShakeWrap = WraperUtil.LuaToUserdata(L, 1, string_set_shake_decay, CameraShakeWrap.cache);
				num = (float)LuaDLL.lua_tonumber(L, 2);
				cameraShakeWrap.component.decay = num;
				result = 0;
			}
			return result;
		}

		[MonoPInvokeCallback(typeof(LuaCSFunction))]
		private static int set_multiply_by_timeScale(IntPtr L)
		{
			int result = 0;
			if (WraperUtil.ValidIsUserdata(L, 1, string_set_multiply_by_timeScale) && WraperUtil.ValidIsBoolean(L, 2, string_set_multiply_by_timeScale))
			{
				CameraShakeWrap cameraShakeWrap = null;
				bool flag = false;
				cameraShakeWrap = WraperUtil.LuaToUserdata(L, 1, string_set_multiply_by_timeScale, CameraShakeWrap.cache);
				flag = LuaDLL.lua_toboolean(L, 2);
				cameraShakeWrap.component.multiplyByTimeScale = flag;
				result = 0;
			}
			return result;
		}

		[MonoPInvokeCallback(typeof(LuaCSFunction))]
		private static int cancel_shake(IntPtr L)
		{
			int result = 0;
			if (WraperUtil.ValidIsUserdata(L, 1, string_cancel_shake))
			{
				CameraShakeWrap cameraShakeWrap = null;
				cameraShakeWrap = WraperUtil.LuaToUserdata(L, 1, string_cancel_shake, CameraShakeWrap.cache);
				cameraShakeWrap.component.DoCancelShake();
				result = 0;
			}
			return result;
		}

		[MonoPInvokeCallback(typeof(LuaCSFunction))]
		private static int gc(IntPtr L)
		{
			CameraShakeWrap cameraShakeWrap = WraperUtil.LuaToUserdataByGc(L, 1, "gc camera_shake_object", CameraShakeWrap.cache);
			if (cameraShakeWrap != null)
			{
				CameraShakeWrap.DestroyInstance(cameraShakeWrap);
			}
			return 0;
		}
	}
}
