using System;
using LuaInterface;
using UnityEngine;
using UnityWrap;

namespace Wraper
{
	public class camera_path_animator_wraper
	{
		public static string name = "camera_path_animator_object";

		private static luaL_Reg[] func = new luaL_Reg[19]
		{
			new luaL_Reg("play", play),
			new luaL_Reg("stop", stop),
			new luaL_Reg("pause", pause),
			new luaL_Reg("set_animation_object", set_animation_object),
			new luaL_Reg("clear_animation_object", clear_animation_object),
			new luaL_Reg("set_orientation_target", set_orientation_target),
			new luaL_Reg("clear_orientation_target", clear_orientation_target),
			new luaL_Reg("get_percentage", get_percentage),
			new luaL_Reg("seek", seek),
			new luaL_Reg("set_path_speed", set_path_speed),
			new luaL_Reg("get_path_speed", get_path_speed),
			new luaL_Reg("set_animation_mode", set_animation_mode),
			new luaL_Reg("set_on_started", set_on_started),
			new luaL_Reg("set_on_paused", set_on_paused),
			new luaL_Reg("set_on_stopped", set_on_stopped),
			new luaL_Reg("set_on_finished", set_on_finished),
			new luaL_Reg("get_nearest_point", get_nearest_point),
			new luaL_Reg("get_path_position", get_path_position),
			new luaL_Reg("get_path_direction", get_path_direction)
		};

		private static string string_play = "camera_path_animator_object:play";

		private static string string_stop = "camera_path_animator_object:stop";

		private static string string_pause = "camera_path_animator_object:pause";

		private static string string_set_animation_object = "camera_path_animator_object:set_animation_object";

		private static string string_clear_animation_object = "camera_path_animator_object:clear_animation_object";

		private static string string_set_orientation_target = "camera_path_animator_object:set_orientation_target";

		private static string string_clear_orientation_target = "camera_path_animator_object:clear_orientation_target";

		private static string string_get_percentage = "camera_path_animator_object:get_percentage";

		private static string string_seek = "camera_path_animator_object:seek";

		private static string string_set_path_speed = "camera_path_animator_object:set_path_speed";

		private static string string_get_path_speed = "camera_path_animator_object:get_path_speed";

		private static string string_set_animation_mode = "camera_path_animator_object:set_animation_mode";

		private static string string_set_on_started = "camera_path_animator_object:set_on_started";

		private static string string_set_on_paused = "camera_path_animator_object:set_on_paused";

		private static string string_set_on_stopped = "camera_path_animator_object:set_on_stopped";

		private static string string_set_on_finished = "camera_path_animator_object:set_on_finished";

		private static string string_get_nearest_point = "camera_path_animator_object:get_nearest_point";

		private static string string_get_path_position = "camera_path_animator_object:get_path_position";

		private static string string_get_path_direction = "camera_path_animator_object:get_path_direction";

		public static bool init(IntPtr L)
		{
			if (L != IntPtr.Zero)
			{
				LuaDLL.register_class(L, name, func, gc);
				return true;
			}
			return false;
		}

		public static void push(IntPtr L, CameraPathAnimatorWrap obj)
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
		private static int play(IntPtr L)
		{
			int result = 0;
			if (WraperUtil.ValidIsUserdata(L, 1, string_play))
			{
				CameraPathAnimatorWrap cameraPathAnimatorWrap = null;
				cameraPathAnimatorWrap = WraperUtil.LuaToUserdata(L, 1, string_play, CameraPathAnimatorWrap.cache);
				cameraPathAnimatorWrap.component.Play();
				result = 0;
			}
			return result;
		}

		[MonoPInvokeCallback(typeof(LuaCSFunction))]
		private static int stop(IntPtr L)
		{
			int result = 0;
			if (WraperUtil.ValidIsUserdata(L, 1, string_stop))
			{
				CameraPathAnimatorWrap cameraPathAnimatorWrap = null;
				cameraPathAnimatorWrap = WraperUtil.LuaToUserdata(L, 1, string_stop, CameraPathAnimatorWrap.cache);
				cameraPathAnimatorWrap.component.Stop();
				result = 0;
			}
			return result;
		}

		[MonoPInvokeCallback(typeof(LuaCSFunction))]
		private static int pause(IntPtr L)
		{
			int result = 0;
			if (WraperUtil.ValidIsUserdata(L, 1, string_pause))
			{
				CameraPathAnimatorWrap cameraPathAnimatorWrap = null;
				cameraPathAnimatorWrap = WraperUtil.LuaToUserdata(L, 1, string_pause, CameraPathAnimatorWrap.cache);
				cameraPathAnimatorWrap.component.Pause();
				result = 0;
			}
			return result;
		}

		[MonoPInvokeCallback(typeof(LuaCSFunction))]
		private static int set_animation_object(IntPtr L)
		{
			int result = 0;
			if (WraperUtil.ValidIsUserdata(L, 1, string_set_animation_object) && WraperUtil.ValidIsUserdata(L, 2, string_set_animation_object))
			{
				CameraPathAnimatorWrap cameraPathAnimatorWrap = null;
				AssetGameObject assetGameObject = null;
				cameraPathAnimatorWrap = WraperUtil.LuaToUserdata(L, 1, string_set_animation_object, CameraPathAnimatorWrap.cache);
				assetGameObject = WraperUtil.LuaToUserdata(L, 2, string_set_animation_object, AssetGameObject.cache);
				cameraPathAnimatorWrap.component.animationObject = assetGameObject.transform;
				result = 0;
			}
			return result;
		}

		[MonoPInvokeCallback(typeof(LuaCSFunction))]
		private static int clear_animation_object(IntPtr L)
		{
			int result = 0;
			if (WraperUtil.ValidIsUserdata(L, 1, string_clear_animation_object))
			{
				CameraPathAnimatorWrap cameraPathAnimatorWrap = null;
				cameraPathAnimatorWrap = WraperUtil.LuaToUserdata(L, 1, string_clear_animation_object, CameraPathAnimatorWrap.cache);
				cameraPathAnimatorWrap.component.animationObject = null;
				result = 0;
			}
			return result;
		}

		[MonoPInvokeCallback(typeof(LuaCSFunction))]
		private static int set_orientation_target(IntPtr L)
		{
			int result = 0;
			if (WraperUtil.ValidIsUserdata(L, 1, string_set_orientation_target) && WraperUtil.ValidIsUserdata(L, 2, string_set_orientation_target))
			{
				CameraPathAnimatorWrap cameraPathAnimatorWrap = null;
				AssetGameObject assetGameObject = null;
				cameraPathAnimatorWrap = WraperUtil.LuaToUserdata(L, 1, string_set_orientation_target, CameraPathAnimatorWrap.cache);
				assetGameObject = WraperUtil.LuaToUserdata(L, 2, string_set_orientation_target, AssetGameObject.cache);
				cameraPathAnimatorWrap.component.orientationTarget = assetGameObject.transform;
				result = 0;
			}
			return result;
		}

		[MonoPInvokeCallback(typeof(LuaCSFunction))]
		private static int clear_orientation_target(IntPtr L)
		{
			int result = 0;
			if (WraperUtil.ValidIsUserdata(L, 1, string_clear_orientation_target))
			{
				CameraPathAnimatorWrap cameraPathAnimatorWrap = null;
				cameraPathAnimatorWrap = WraperUtil.LuaToUserdata(L, 1, string_clear_orientation_target, CameraPathAnimatorWrap.cache);
				cameraPathAnimatorWrap.component.orientationTarget = null;
				result = 0;
			}
			return result;
		}

		[MonoPInvokeCallback(typeof(LuaCSFunction))]
		private static int get_percentage(IntPtr L)
		{
			int result = 0;
			if (WraperUtil.ValidIsUserdata(L, 1, string_get_percentage))
			{
				CameraPathAnimatorWrap cameraPathAnimatorWrap = null;
				cameraPathAnimatorWrap = WraperUtil.LuaToUserdata(L, 1, string_get_percentage, CameraPathAnimatorWrap.cache);
				LuaDLL.lua_pushnumber(L, cameraPathAnimatorWrap.component.percentage);
				result = 1;
			}
			return result;
		}

		[MonoPInvokeCallback(typeof(LuaCSFunction))]
		private static int seek(IntPtr L)
		{
			int result = 0;
			if (WraperUtil.ValidIsUserdata(L, 1, string_seek) && WraperUtil.ValidIsNumber(L, 2, string_seek))
			{
				CameraPathAnimatorWrap cameraPathAnimatorWrap = null;
				float num = 0f;
				cameraPathAnimatorWrap = WraperUtil.LuaToUserdata(L, 1, string_seek, CameraPathAnimatorWrap.cache);
				num = (float)LuaDLL.lua_tonumber(L, 2);
				cameraPathAnimatorWrap.component.Seek(num);
				result = 0;
			}
			return result;
		}

		[MonoPInvokeCallback(typeof(LuaCSFunction))]
		private static int set_path_speed(IntPtr L)
		{
			int result = 0;
			if (WraperUtil.ValidIsUserdata(L, 1, string_set_path_speed) && WraperUtil.ValidIsNumber(L, 2, string_set_path_speed))
			{
				CameraPathAnimatorWrap cameraPathAnimatorWrap = null;
				float num = 0f;
				cameraPathAnimatorWrap = WraperUtil.LuaToUserdata(L, 1, string_set_path_speed, CameraPathAnimatorWrap.cache);
				num = (float)LuaDLL.lua_tonumber(L, 2);
				cameraPathAnimatorWrap.component.pathSpeed = num;
				result = 0;
			}
			return result;
		}

		[MonoPInvokeCallback(typeof(LuaCSFunction))]
		private static int get_path_speed(IntPtr L)
		{
			int result = 0;
			if (WraperUtil.ValidIsUserdata(L, 1, string_get_path_speed))
			{
				CameraPathAnimatorWrap cameraPathAnimatorWrap = null;
				cameraPathAnimatorWrap = WraperUtil.LuaToUserdata(L, 1, string_get_path_speed, CameraPathAnimatorWrap.cache);
				LuaDLL.lua_pushnumber(L, cameraPathAnimatorWrap.component.pathSpeed);
				result = 1;
			}
			return result;
		}

		[MonoPInvokeCallback(typeof(LuaCSFunction))]
		private static int set_animation_mode(IntPtr L)
		{
			int result = 0;
			if (WraperUtil.ValidIsUserdata(L, 1, string_set_animation_mode) && WraperUtil.ValidIsNumber(L, 2, string_set_animation_mode))
			{
				CameraPathAnimatorWrap cameraPathAnimatorWrap = null;
				int num = 0;
				cameraPathAnimatorWrap = WraperUtil.LuaToUserdata(L, 1, string_set_animation_mode, CameraPathAnimatorWrap.cache);
				switch ((int)LuaDLL.lua_tonumber(L, 2))
				{
				case 1:
					cameraPathAnimatorWrap.component.animationMode = CameraPathAnimator.animationModes.once;
					break;
				case 2:
					cameraPathAnimatorWrap.component.animationMode = CameraPathAnimator.animationModes.loop;
					break;
				case 3:
					cameraPathAnimatorWrap.component.animationMode = CameraPathAnimator.animationModes.reverse;
					break;
				}
				result = 0;
			}
			return result;
		}

		[MonoPInvokeCallback(typeof(LuaCSFunction))]
		private static int set_on_started(IntPtr L)
		{
			int result = 0;
			if (WraperUtil.ValidIsUserdata(L, 1, string_set_on_started) && WraperUtil.ValidIsString(L, 2, string_set_on_started))
			{
				CameraPathAnimatorWrap cameraPathAnimatorWrap = null;
				string text = null;
				cameraPathAnimatorWrap = WraperUtil.LuaToUserdata(L, 1, string_set_on_started, CameraPathAnimatorWrap.cache);
				text = LuaDLL.lua_tostring(L, 2);
				cameraPathAnimatorWrap.onStarted = text;
				result = 0;
			}
			return result;
		}

		[MonoPInvokeCallback(typeof(LuaCSFunction))]
		private static int set_on_paused(IntPtr L)
		{
			int result = 0;
			if (WraperUtil.ValidIsUserdata(L, 1, string_set_on_paused) && WraperUtil.ValidIsString(L, 2, string_set_on_paused))
			{
				CameraPathAnimatorWrap cameraPathAnimatorWrap = null;
				string text = null;
				cameraPathAnimatorWrap = WraperUtil.LuaToUserdata(L, 1, string_set_on_paused, CameraPathAnimatorWrap.cache);
				text = LuaDLL.lua_tostring(L, 2);
				cameraPathAnimatorWrap.onPaused = text;
				result = 0;
			}
			return result;
		}

		[MonoPInvokeCallback(typeof(LuaCSFunction))]
		private static int set_on_stopped(IntPtr L)
		{
			int result = 0;
			if (WraperUtil.ValidIsUserdata(L, 1, string_set_on_stopped) && WraperUtil.ValidIsString(L, 2, string_set_on_stopped))
			{
				CameraPathAnimatorWrap cameraPathAnimatorWrap = null;
				string text = null;
				cameraPathAnimatorWrap = WraperUtil.LuaToUserdata(L, 1, string_set_on_stopped, CameraPathAnimatorWrap.cache);
				text = LuaDLL.lua_tostring(L, 2);
				cameraPathAnimatorWrap.onStopped = text;
				result = 0;
			}
			return result;
		}

		[MonoPInvokeCallback(typeof(LuaCSFunction))]
		private static int set_on_finished(IntPtr L)
		{
			int result = 0;
			if (WraperUtil.ValidIsUserdata(L, 1, string_set_on_finished) && WraperUtil.ValidIsString(L, 2, string_set_on_finished))
			{
				CameraPathAnimatorWrap cameraPathAnimatorWrap = null;
				string text = null;
				cameraPathAnimatorWrap = WraperUtil.LuaToUserdata(L, 1, string_set_on_finished, CameraPathAnimatorWrap.cache);
				text = LuaDLL.lua_tostring(L, 2);
				cameraPathAnimatorWrap.onFinished = text;
				result = 0;
			}
			return result;
		}

		[MonoPInvokeCallback(typeof(LuaCSFunction))]
		private static int get_nearest_point(IntPtr L)
		{
			int result = 0;
			if (WraperUtil.ValidIsUserdata(L, 1, string_get_nearest_point) && WraperUtil.ValidIsNumber(L, 2, string_get_nearest_point) && WraperUtil.ValidIsNumber(L, 3, string_get_nearest_point) && WraperUtil.ValidIsNumber(L, 4, string_get_nearest_point) && WraperUtil.ValidIsBoolean(L, 5, string_get_nearest_point) && WraperUtil.ValidIsNumber(L, 6, string_get_nearest_point))
			{
				CameraPathAnimatorWrap cameraPathAnimatorWrap = null;
				float num = 0f;
				float num2 = 0f;
				float num3 = 0f;
				bool flag = false;
				int num4 = 0;
				cameraPathAnimatorWrap = WraperUtil.LuaToUserdata(L, 1, string_get_nearest_point, CameraPathAnimatorWrap.cache);
				num = (float)LuaDLL.lua_tonumber(L, 2);
				num2 = (float)LuaDLL.lua_tonumber(L, 3);
				num3 = (float)LuaDLL.lua_tonumber(L, 4);
				flag = LuaDLL.lua_toboolean(L, 5);
				num4 = (int)LuaDLL.lua_tonumber(L, 6);
				float nearestPoint = cameraPathAnimatorWrap.component.cameraPath.GetNearestPoint(new Vector3(num, num2, num3), flag, num4);
				LuaDLL.lua_pushnumber(L, nearestPoint);
				result = 1;
			}
			return result;
		}

		[MonoPInvokeCallback(typeof(LuaCSFunction))]
		private static int get_path_position(IntPtr L)
		{
			int result = 0;
			if (WraperUtil.ValidIsUserdata(L, 1, string_get_path_position) && WraperUtil.ValidIsNumber(L, 2, string_get_path_position) && WraperUtil.ValidIsBoolean(L, 3, string_get_path_position))
			{
				CameraPathAnimatorWrap cameraPathAnimatorWrap = null;
				float num = 0f;
				bool flag = false;
				cameraPathAnimatorWrap = WraperUtil.LuaToUserdata(L, 1, string_get_path_position, CameraPathAnimatorWrap.cache);
				num = (float)LuaDLL.lua_tonumber(L, 2);
				flag = LuaDLL.lua_toboolean(L, 3);
				Vector3 pathPosition = cameraPathAnimatorWrap.component.cameraPath.GetPathPosition(num, flag);
				LuaDLL.lua_pushnumber(L, pathPosition.x);
				LuaDLL.lua_pushnumber(L, pathPosition.y);
				LuaDLL.lua_pushnumber(L, pathPosition.z);
				result = 3;
			}
			return result;
		}

		[MonoPInvokeCallback(typeof(LuaCSFunction))]
		private static int get_path_direction(IntPtr L)
		{
			int result = 0;
			if (WraperUtil.ValidIsUserdata(L, 1, string_get_path_direction) && WraperUtil.ValidIsNumber(L, 2, string_get_path_direction) && WraperUtil.ValidIsBoolean(L, 3, string_get_path_direction))
			{
				CameraPathAnimatorWrap cameraPathAnimatorWrap = null;
				float num = 0f;
				bool flag = false;
				cameraPathAnimatorWrap = WraperUtil.LuaToUserdata(L, 1, string_get_path_direction, CameraPathAnimatorWrap.cache);
				num = (float)LuaDLL.lua_tonumber(L, 2);
				flag = LuaDLL.lua_toboolean(L, 3);
				Vector3 pathDirection = cameraPathAnimatorWrap.component.cameraPath.GetPathDirection(num, flag);
				LuaDLL.lua_pushnumber(L, pathDirection.x);
				LuaDLL.lua_pushnumber(L, pathDirection.y);
				LuaDLL.lua_pushnumber(L, pathDirection.z);
				result = 3;
			}
			return result;
		}

		[MonoPInvokeCallback(typeof(LuaCSFunction))]
		private static int gc(IntPtr L)
		{
			CameraPathAnimatorWrap cameraPathAnimatorWrap = WraperUtil.LuaToUserdataByGc(L, 1, "gc camera_path_animator_object", CameraPathAnimatorWrap.cache);
			if (cameraPathAnimatorWrap != null)
			{
				CameraPathAnimatorWrap.DestroyInstance(cameraPathAnimatorWrap);
			}
			return 0;
		}
	}
}
