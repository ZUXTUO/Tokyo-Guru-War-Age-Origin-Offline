using System;
using LuaInterface;
using UnityWrap;

namespace Wraper
{
	public class camera_follow_wraper
	{
		public static string name = "camera_follow_object";

		private static luaL_Reg[] func = new luaL_Reg[6]
		{
			new luaL_Reg("set_target", set_target),
			new luaL_Reg("clear_target", clear_target),
			new luaL_Reg("init_camera", init_camera),
			new luaL_Reg("get_x_angle", get_x_angle),
			new luaL_Reg("get_y_angle", get_y_angle),
			new luaL_Reg("get_z_distance", get_z_distance)
		};

		private static string string_set_target = "camera_follow_object:set_target";

		private static string string_clear_target = "camera_follow_object:clear_target";

		private static string string_init_camera = "camera_follow_object:init_camera";

		private static string string_get_x_angle = "camera_follow_object:get_x_angle";

		private static string string_get_y_angle = "camera_follow_object:get_y_angle";

		private static string string_get_z_distance = "camera_follow_object:get_z_distance";

		public static bool init(IntPtr L)
		{
			if (L != IntPtr.Zero)
			{
				LuaDLL.register_class(L, name, func, gc);
				return true;
			}
			return false;
		}

		public static void push(IntPtr L, CameraFollowWrap obj)
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
		private static int set_target(IntPtr L)
		{
			int result = 0;
			if (WraperUtil.ValidIsUserdata(L, 1, string_set_target) && WraperUtil.ValidIsUserdataOrNil(L, 2, string_set_target))
			{
				CameraFollowWrap cameraFollowWrap = null;
				AssetGameObject assetGameObject = null;
				cameraFollowWrap = WraperUtil.LuaToUserdata(L, 1, string_set_target, CameraFollowWrap.cache);
				assetGameObject = WraperUtil.LuaToUserdataOrNil(L, 2, string_set_target, AssetGameObject.cache);
				if (cameraFollowWrap != null && cameraFollowWrap.component != null)
				{
					cameraFollowWrap.component.target = ((assetGameObject == null) ? null : assetGameObject.gameObject);
				}
				result = 0;
			}
			return result;
		}

		[MonoPInvokeCallback(typeof(LuaCSFunction))]
		private static int clear_target(IntPtr L)
		{
			int result = 0;
			if (WraperUtil.ValidIsUserdata(L, 1, string_clear_target))
			{
				CameraFollowWrap cameraFollowWrap = null;
				cameraFollowWrap = WraperUtil.LuaToUserdata(L, 1, string_clear_target, CameraFollowWrap.cache);
				if (cameraFollowWrap.component != null)
				{
					cameraFollowWrap.component.target = null;
				}
				result = 0;
			}
			return result;
		}

		[MonoPInvokeCallback(typeof(LuaCSFunction))]
		private static int init_camera(IntPtr L)
		{
			int result = 0;
			if (WraperUtil.ValidIsUserdata(L, 1, string_init_camera) && WraperUtil.ValidIsNumber(L, 2, string_init_camera) && WraperUtil.ValidIsNumber(L, 3, string_init_camera) && WraperUtil.ValidIsNumber(L, 4, string_init_camera))
			{
				CameraFollowWrap cameraFollowWrap = null;
				float num = 0f;
				float num2 = 0f;
				float num3 = 0f;
				cameraFollowWrap = WraperUtil.LuaToUserdata(L, 1, string_init_camera, CameraFollowWrap.cache);
				num = (float)LuaDLL.lua_tonumber(L, 2);
				num2 = (float)LuaDLL.lua_tonumber(L, 3);
				num3 = (float)LuaDLL.lua_tonumber(L, 4);
				if (cameraFollowWrap != null && cameraFollowWrap.component != null)
				{
					cameraFollowWrap.component.xAngle = num;
					cameraFollowWrap.component.yAngle = num2;
					cameraFollowWrap.component.zDistance = num3;
				}
				result = 0;
			}
			return result;
		}

		[MonoPInvokeCallback(typeof(LuaCSFunction))]
		private static int get_x_angle(IntPtr L)
		{
			int result = 0;
			if (WraperUtil.ValidIsUserdata(L, 1, string_get_x_angle))
			{
				CameraFollowWrap cameraFollowWrap = null;
				cameraFollowWrap = WraperUtil.LuaToUserdata(L, 1, string_get_x_angle, CameraFollowWrap.cache);
				if (cameraFollowWrap != null && cameraFollowWrap.component != null)
				{
					LuaDLL.lua_pushnumber(L, cameraFollowWrap.component.xAngle);
				}
				result = 1;
			}
			return result;
		}

		[MonoPInvokeCallback(typeof(LuaCSFunction))]
		private static int get_y_angle(IntPtr L)
		{
			int result = 0;
			if (WraperUtil.ValidIsUserdata(L, 1, string_get_y_angle))
			{
				CameraFollowWrap cameraFollowWrap = null;
				cameraFollowWrap = WraperUtil.LuaToUserdata(L, 1, string_get_y_angle, CameraFollowWrap.cache);
				if (cameraFollowWrap != null && cameraFollowWrap.component != null)
				{
					LuaDLL.lua_pushnumber(L, cameraFollowWrap.component.yAngle);
				}
				result = 1;
			}
			return result;
		}

		[MonoPInvokeCallback(typeof(LuaCSFunction))]
		private static int get_z_distance(IntPtr L)
		{
			int result = 0;
			if (WraperUtil.ValidIsUserdata(L, 1, string_get_z_distance))
			{
				CameraFollowWrap cameraFollowWrap = null;
				cameraFollowWrap = WraperUtil.LuaToUserdata(L, 1, string_get_z_distance, CameraFollowWrap.cache);
				if (cameraFollowWrap != null && cameraFollowWrap.component != null)
				{
					LuaDLL.lua_pushnumber(L, cameraFollowWrap.component.zDistance);
				}
				result = 1;
			}
			return result;
		}

		[MonoPInvokeCallback(typeof(LuaCSFunction))]
		private static int gc(IntPtr L)
		{
			CameraFollowWrap cameraFollowWrap = WraperUtil.LuaToUserdataByGc(L, 1, "gc camera_follow_object", CameraFollowWrap.cache);
			if (cameraFollowWrap != null)
			{
				CameraFollowWrap.DestroyInstance(cameraFollowWrap);
			}
			return 0;
		}
	}
}
