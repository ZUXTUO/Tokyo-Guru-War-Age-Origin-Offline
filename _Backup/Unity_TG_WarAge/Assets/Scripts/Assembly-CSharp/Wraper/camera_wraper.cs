using System;
using Core.Util;
using LuaInterface;
using UnityEngine;
using UnityWrap;

namespace Wraper
{
	public class camera_wraper : MonoBehaviour
	{
		public new static string name = "camera_object";

		public static string libname = "camera";

		private static luaL_Reg[] libfunc = new luaL_Reg[11]
		{
			new luaL_Reg("get_main", get_main),
			new luaL_Reg("get_current", get_current),
			new luaL_Reg("find_by_layer", find_by_layer),
			new luaL_Reg("find_by_name", find_by_name),
			new luaL_Reg("set_ui_camera", set_ui_camera),
			new luaL_Reg("set_bloomfactor", set_bloomfactor),
			new luaL_Reg("set_dof_target", set_dof_target),
			new luaL_Reg("set_bloom", set_bloom),
			new luaL_Reg("on_bloom_camera_change", on_bloom_camera_change),
			new luaL_Reg("set_enable_aa", set_enable_aa),
			new luaL_Reg("enable_dof", enable_dof)
		};

		private static luaL_Reg[] func = new luaL_Reg[24]
		{
			new luaL_Reg("set_enable", set_enable),
			new luaL_Reg("set_culling_mask", set_culling_mask),
			new luaL_Reg("get_culling_mask", get_culling_mask),
			new luaL_Reg("set_fov", set_fov),
			new luaL_Reg("get_fov", get_fov),
			new luaL_Reg("get_game_object", get_game_object),
			new luaL_Reg("set_camera_render_texture", set_camera_render_texture),
			new luaL_Reg("clear_camera_render_texture", clear_camera_render_texture),
			new luaL_Reg("get_camera_render_texture", get_camera_render_texture),
			new luaL_Reg("screen_to_viewport_point", screen_to_viewport_point),
			new luaL_Reg("screen_to_world_point", screen_to_world_point),
			new luaL_Reg("world_to_screen_point", world_to_screen_point),
			new luaL_Reg("world_to_viewport_point", world_to_viewport_point),
			new luaL_Reg("viewport_to_world_point", viewport_to_world_point),
			new luaL_Reg("get_component_camera_shake", get_component_camera_shake),
			new luaL_Reg("get_motion_blur_effect", get_motion_blur_effect),
			new luaL_Reg("set_uicamera_multi_touch", set_uicamera_multi_touch),
			new luaL_Reg("set_clear_flags", set_clear_flags),
			new luaL_Reg("set_background_color", set_background_color),
			new luaL_Reg("set_clip_plane", set_clip_plane),
			new luaL_Reg("re_set_aspect", re_set_aspect),
			new luaL_Reg("start_qte", start_qte),
			new luaL_Reg("stop_qte", stop_qte),
			new luaL_Reg("raycast_out_screen", raycast_out_screen)
		};

		private static string string_find_by_layer = "camera.find_by_layer";

		private static string string_find_by_name = "camera.find_by_name";

		private static string string_set_bloomfactor = "camera.set_bloomfactor";

		private static string string_set_dof_target = "camera.set_dof_target";

		private static string string_enable_dof = "camera.enable_dof";

		private static string string_set_bloom = "camera.set_bloom";

		private static string string_set_enable_aa = "camera.set_enable_aa";

		private static string string_set_enable = "camera_object:set_enable";

		private static string string_set_culling_mask = "camera_object:set_culling_mask";

		private static string string_get_culling_mask = "camera_object:get_culling_mask";

		private static string string_set_fov = "camera_object:set_fov";

		private static string string_get_fov = "camera_object:get_fov";

		private static string string_get_game_object = "camera_object:get_game_object";

		private static string string_set_camera_render_texture = "camera_object:set_camera_render_texture";

		private static string string_clear_camera_render_texture = "camera_object:clear_camera_render_texture";

		private static string string_get_camera_render_texture = "camera_object:get_camera_render_texture";

		private static string string_screen_to_viewport_point = "camera_object:screen_to_viewport_point";

		private static string string_screen_to_world_point = "camera_object:screen_to_world_point";

		private static string string_world_to_screen_point = "camera_object:world_to_screen_point";

		private static string string_world_to_viewport_point = "camera_object:world_to_viewport_point";

		private static string string_viewport_to_world_point = "camera_object:viewport_to_world_point";

		private static string string_get_component_camera_shake = "camera_object:get_component_camera_shake";

		private static string string_get_motion_blur_effect = "camera_object:get_motion_blur_effect";

		private static string string_set_uicamera_multi_touch = "camera_object:set_uicamera_multi_touch";

		private static string string_set_clear_flags = "camera_object:set_clear_flags";

		private static string string_set_background_color = "camera_object:set_background_color";

		private static string string_set_clip_plane = "camera:set_clip_plane";

		private static string string_re_set_aspect = "camera:re_set_aspect";

		private static string string_start_qte = "camera:start_qte";

		private static string string_stop_qte = "camera:stop_qte";

		private static string string_raycast_out_screen = "camera:raycast_out_screen";

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

		public static void push(IntPtr L, CameraWrap obj)
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
		private static int get_main(IntPtr L)
		{
			int num = 0;
			WraperUtil.PushObject(L, CameraWrap.CreateInstance(Camera.main));
			return 1;
		}

		[MonoPInvokeCallback(typeof(LuaCSFunction))]
		private static int get_current(IntPtr L)
		{
			int num = 0;
			WraperUtil.PushObject(L, CameraWrap.CreateInstance(Camera.current));
			return 1;
		}

		[MonoPInvokeCallback(typeof(LuaCSFunction))]
		private static int find_by_layer(IntPtr L)
		{
			int result = 0;
			if (WraperUtil.ValidIsNumber(L, 1, string_find_by_layer))
			{
				int num = 0;
				num = (int)LuaDLL.lua_tonumber(L, 1);
				WraperUtil.PushObject(L, CameraWrap.CreateInstance(NGUITools.FindCameraForLayer(num)));
				result = 1;
			}
			return result;
		}

		[MonoPInvokeCallback(typeof(LuaCSFunction))]
		private static int find_by_name(IntPtr L)
		{
			int result = 0;
			if (WraperUtil.ValidIsString(L, 1, string_find_by_name))
			{
				string text = null;
				text = LuaDLL.lua_tostring(L, 1);
				WraperUtil.PushObject(L, CameraWrap.CreateInstance(Utils.FindCameraForName(text)));
				result = 1;
			}
			return result;
		}

		[MonoPInvokeCallback(typeof(LuaCSFunction))]
		private static int set_ui_camera(IntPtr L)
		{
			int result = 0;
			if (!(Camera.main == null))
			{
				Camera.main.gameObject.AddComponent<UICamera>();
				result = 0;
			}
			return result;
		}

		[MonoPInvokeCallback(typeof(LuaCSFunction))]
		private static int set_enable(IntPtr L)
		{
			int result = 0;
			if (WraperUtil.ValidIsUserdata(L, 1, string_set_enable) && WraperUtil.ValidIsBoolean(L, 2, string_set_enable))
			{
				CameraWrap cameraWrap = null;
				bool flag = false;
				cameraWrap = WraperUtil.LuaToUserdata(L, 1, string_set_enable, CameraWrap.cache);
				flag = LuaDLL.lua_toboolean(L, 2);
				cameraWrap.component.enabled = flag;
				result = 0;
			}
			return result;
		}

		[MonoPInvokeCallback(typeof(LuaCSFunction))]
		private static int set_culling_mask(IntPtr L)
		{
			int result = 0;
			if (WraperUtil.ValidIsUserdata(L, 1, string_set_culling_mask) && WraperUtil.ValidIsNumber(L, 2, string_set_culling_mask))
			{
				CameraWrap cameraWrap = null;
				int num = 0;
				cameraWrap = WraperUtil.LuaToUserdata(L, 1, string_set_culling_mask, CameraWrap.cache);
				num = (int)LuaDLL.lua_tonumber(L, 2);
				cameraWrap.component.cullingMask = num;
				result = 0;
			}
			return result;
		}

		[MonoPInvokeCallback(typeof(LuaCSFunction))]
		private static int get_culling_mask(IntPtr L)
		{
			int result = 0;
			if (WraperUtil.ValidIsUserdata(L, 1, string_get_culling_mask))
			{
				CameraWrap cameraWrap = null;
				cameraWrap = WraperUtil.LuaToUserdata(L, 1, string_get_culling_mask, CameraWrap.cache);
				LuaDLL.lua_pushnumber(L, cameraWrap.component.cullingMask);
				result = 1;
			}
			return result;
		}

		[MonoPInvokeCallback(typeof(LuaCSFunction))]
		private static int set_fov(IntPtr L)
		{
			int result = 0;
			if (WraperUtil.ValidIsUserdata(L, 1, string_set_fov) && WraperUtil.ValidIsNumber(L, 2, string_set_fov))
			{
				CameraWrap cameraWrap = null;
				float num = 0f;
				cameraWrap = WraperUtil.LuaToUserdata(L, 1, string_set_fov, CameraWrap.cache);
				num = (float)LuaDLL.lua_tonumber(L, 2);
				cameraWrap.component.fieldOfView = num;
				result = 0;
			}
			return result;
		}

		[MonoPInvokeCallback(typeof(LuaCSFunction))]
		private static int get_fov(IntPtr L)
		{
			int result = 0;
			if (WraperUtil.ValidIsUserdata(L, 1, string_get_fov))
			{
				CameraWrap cameraWrap = null;
				cameraWrap = WraperUtil.LuaToUserdata(L, 1, string_get_fov, CameraWrap.cache);
				LuaDLL.lua_pushnumber(L, cameraWrap.component.fieldOfView);
				result = 1;
			}
			return result;
		}

		[MonoPInvokeCallback(typeof(LuaCSFunction))]
		private static int get_game_object(IntPtr L)
		{
			int result = 0;
			if (WraperUtil.ValidIsUserdata(L, 1, string_get_game_object))
			{
				CameraWrap cameraWrap = null;
				cameraWrap = WraperUtil.LuaToUserdata(L, 1, string_get_game_object, CameraWrap.cache);
				AssetGameObject base_object = AssetGameObject.CreateByInstance(cameraWrap.component.gameObject);
				WraperUtil.PushObject(L, base_object);
				result = 1;
			}
			return result;
		}

		[MonoPInvokeCallback(typeof(LuaCSFunction))]
		private static int set_camera_render_texture(IntPtr L)
		{
			int result = 0;
			if (WraperUtil.ValidIsUserdata(L, 1, string_set_camera_render_texture) && WraperUtil.ValidIsUserdata(L, 2, string_set_camera_render_texture))
			{
				CameraWrap cameraWrap = null;
				RenderTextureWrap renderTextureWrap = null;
				cameraWrap = WraperUtil.LuaToUserdata(L, 1, string_set_camera_render_texture, CameraWrap.cache);
				renderTextureWrap = WraperUtil.LuaToUserdata(L, 2, string_set_camera_render_texture, RenderTextureWrap.cache);
				cameraWrap.component.targetTexture = renderTextureWrap.component;
				result = 0;
			}
			return result;
		}

		[MonoPInvokeCallback(typeof(LuaCSFunction))]
		private static int clear_camera_render_texture(IntPtr L)
		{
			int result = 0;
			if (WraperUtil.ValidIsUserdata(L, 1, string_clear_camera_render_texture))
			{
				CameraWrap cameraWrap = null;
				cameraWrap = WraperUtil.LuaToUserdata(L, 1, string_clear_camera_render_texture, CameraWrap.cache);
				cameraWrap.component.targetTexture = null;
				result = 0;
			}
			return result;
		}

		[MonoPInvokeCallback(typeof(LuaCSFunction))]
		private static int get_camera_render_texture(IntPtr L)
		{
			int result = 0;
			if (WraperUtil.ValidIsUserdata(L, 1, string_get_camera_render_texture))
			{
				CameraWrap cameraWrap = null;
				cameraWrap = WraperUtil.LuaToUserdata(L, 1, string_get_camera_render_texture, CameraWrap.cache);
				WraperUtil.PushObject(L, TextureWrap.CreateInstance(cameraWrap.component.targetTexture, false));
				result = 1;
			}
			return result;
		}

		[MonoPInvokeCallback(typeof(LuaCSFunction))]
		private static int screen_to_viewport_point(IntPtr L)
		{
			int result = 0;
			if (WraperUtil.ValidIsUserdata(L, 1, string_screen_to_viewport_point) && WraperUtil.ValidIsNumber(L, 2, string_screen_to_viewport_point) && WraperUtil.ValidIsNumber(L, 3, string_screen_to_viewport_point) && WraperUtil.ValidIsNumber(L, 4, string_screen_to_viewport_point))
			{
				CameraWrap cameraWrap = null;
				float num = 0f;
				float num2 = 0f;
				float num3 = 0f;
				cameraWrap = WraperUtil.LuaToUserdata(L, 1, string_screen_to_viewport_point, CameraWrap.cache);
				num = (float)LuaDLL.lua_tonumber(L, 2);
				num2 = (float)LuaDLL.lua_tonumber(L, 3);
				num3 = (float)LuaDLL.lua_tonumber(L, 4);
				Vector3 vector = cameraWrap.component.ScreenToViewportPoint(new Vector3(num, num2, num3));
				LuaDLL.lua_pushnumber(L, vector.x);
				LuaDLL.lua_pushnumber(L, vector.y);
				LuaDLL.lua_pushnumber(L, vector.z);
				result = 3;
			}
			return result;
		}

		[MonoPInvokeCallback(typeof(LuaCSFunction))]
		private static int screen_to_world_point(IntPtr L)
		{
			int result = 0;
			if (WraperUtil.ValidIsUserdata(L, 1, string_screen_to_world_point) && WraperUtil.ValidIsNumber(L, 2, string_screen_to_world_point) && WraperUtil.ValidIsNumber(L, 3, string_screen_to_world_point) && WraperUtil.ValidIsNumber(L, 4, string_screen_to_world_point))
			{
				CameraWrap cameraWrap = null;
				float num = 0f;
				float num2 = 0f;
				float num3 = 0f;
				cameraWrap = WraperUtil.LuaToUserdata(L, 1, string_screen_to_world_point, CameraWrap.cache);
				num = (float)LuaDLL.lua_tonumber(L, 2);
				num2 = (float)LuaDLL.lua_tonumber(L, 3);
				num3 = (float)LuaDLL.lua_tonumber(L, 4);
				Vector3 vector = cameraWrap.component.ScreenToWorldPoint(new Vector3(num, num2, num3));
				LuaDLL.lua_pushnumber(L, vector.x);
				LuaDLL.lua_pushnumber(L, vector.y);
				LuaDLL.lua_pushnumber(L, vector.z);
				result = 3;
			}
			return result;
		}

		[MonoPInvokeCallback(typeof(LuaCSFunction))]
		private static int world_to_screen_point(IntPtr L)
		{
			int result = 0;
			if (WraperUtil.ValidIsUserdata(L, 1, string_world_to_screen_point) && WraperUtil.ValidIsNumber(L, 2, string_world_to_screen_point) && WraperUtil.ValidIsNumber(L, 3, string_world_to_screen_point) && WraperUtil.ValidIsNumber(L, 4, string_world_to_screen_point))
			{
				CameraWrap cameraWrap = null;
				float num = 0f;
				float num2 = 0f;
				float num3 = 0f;
				cameraWrap = WraperUtil.LuaToUserdata(L, 1, string_world_to_screen_point, CameraWrap.cache);
				num = (float)LuaDLL.lua_tonumber(L, 2);
				num2 = (float)LuaDLL.lua_tonumber(L, 3);
				num3 = (float)LuaDLL.lua_tonumber(L, 4);
				Vector3 vector = cameraWrap.component.WorldToScreenPoint(new Vector3(num, num2, num3));
				LuaDLL.lua_pushnumber(L, vector.x);
				LuaDLL.lua_pushnumber(L, vector.y);
				LuaDLL.lua_pushnumber(L, vector.z);
				result = 3;
			}
			return result;
		}

		[MonoPInvokeCallback(typeof(LuaCSFunction))]
		private static int world_to_viewport_point(IntPtr L)
		{
			int result = 0;
			if (WraperUtil.ValidIsUserdata(L, 1, string_world_to_viewport_point) && WraperUtil.ValidIsNumber(L, 2, string_world_to_viewport_point) && WraperUtil.ValidIsNumber(L, 3, string_world_to_viewport_point) && WraperUtil.ValidIsNumber(L, 4, string_world_to_viewport_point))
			{
				CameraWrap cameraWrap = null;
				float num = 0f;
				float num2 = 0f;
				float num3 = 0f;
				cameraWrap = WraperUtil.LuaToUserdata(L, 1, string_world_to_viewport_point, CameraWrap.cache);
				num = (float)LuaDLL.lua_tonumber(L, 2);
				num2 = (float)LuaDLL.lua_tonumber(L, 3);
				num3 = (float)LuaDLL.lua_tonumber(L, 4);
				Vector3 vector = cameraWrap.component.WorldToViewportPoint(new Vector3(num, num2, num3));
				LuaDLL.lua_pushnumber(L, vector.x);
				LuaDLL.lua_pushnumber(L, vector.y);
				LuaDLL.lua_pushnumber(L, vector.z);
				result = 3;
			}
			return result;
		}

		[MonoPInvokeCallback(typeof(LuaCSFunction))]
		private static int viewport_to_world_point(IntPtr L)
		{
			int result = 0;
			if (WraperUtil.ValidIsUserdata(L, 1, string_viewport_to_world_point) && WraperUtil.ValidIsNumber(L, 2, string_viewport_to_world_point) && WraperUtil.ValidIsNumber(L, 3, string_viewport_to_world_point) && WraperUtil.ValidIsNumber(L, 4, string_viewport_to_world_point))
			{
				CameraWrap cameraWrap = null;
				float num = 0f;
				float num2 = 0f;
				float num3 = 0f;
				cameraWrap = WraperUtil.LuaToUserdata(L, 1, string_viewport_to_world_point, CameraWrap.cache);
				num = (float)LuaDLL.lua_tonumber(L, 2);
				num2 = (float)LuaDLL.lua_tonumber(L, 3);
				num3 = (float)LuaDLL.lua_tonumber(L, 4);
				Vector3 vector = cameraWrap.component.ViewportToWorldPoint(new Vector3(num, num2, num3));
				LuaDLL.lua_pushnumber(L, vector.x);
				LuaDLL.lua_pushnumber(L, vector.y);
				LuaDLL.lua_pushnumber(L, vector.z);
				result = 3;
			}
			return result;
		}

		[MonoPInvokeCallback(typeof(LuaCSFunction))]
		private static int get_component_camera_shake(IntPtr L)
		{
			int result = 0;
			if (WraperUtil.ValidIsUserdata(L, 1, string_get_component_camera_shake))
			{
				CameraWrap cameraWrap = null;
				cameraWrap = WraperUtil.LuaToUserdata(L, 1, string_get_component_camera_shake, CameraWrap.cache);
				if (cameraWrap.component.gameObject != null && cameraWrap.component.isActiveAndEnabled)
				{
					CameraShake cameraShake = cameraWrap.component.gameObject.GetComponent<CameraShake>();
					if (cameraShake == null)
					{
						cameraShake = cameraWrap.component.gameObject.AddComponent<CameraShake>();
					}
					WraperUtil.PushObject(L, CameraShakeWrap.CreateInstance(cameraShake));
					result = 1;
				}
			}
			return result;
		}

		[MonoPInvokeCallback(typeof(LuaCSFunction))]
		private static int get_motion_blur_effect(IntPtr L)
		{
			int result = 0;
			if (WraperUtil.ValidIsUserdata(L, 1, string_get_motion_blur_effect))
			{
				CameraWrap cameraWrap = null;
				cameraWrap = WraperUtil.LuaToUserdata(L, 1, string_get_motion_blur_effect, CameraWrap.cache);
				if (cameraWrap.component.gameObject != null)
				{
					MotionBlurEffects motionBlurEffects = cameraWrap.component.gameObject.GetComponent<MotionBlurEffects>();
					if (motionBlurEffects == null)
					{
						motionBlurEffects = cameraWrap.component.gameObject.AddComponent<MotionBlurEffects>();
					}
					WraperUtil.PushObject(L, MotionBlurEffectsWrap.CreateInstance(motionBlurEffects));
				}
				result = 1;
			}
			return result;
		}

		[MonoPInvokeCallback(typeof(LuaCSFunction))]
		private static int set_uicamera_multi_touch(IntPtr L)
		{
			int result = 0;
			if (WraperUtil.ValidIsUserdata(L, 1, string_set_uicamera_multi_touch) && WraperUtil.ValidIsBoolean(L, 2, string_set_uicamera_multi_touch))
			{
				CameraWrap cameraWrap = null;
				cameraWrap = WraperUtil.LuaToUserdata(L, 1, string_set_uicamera_multi_touch, CameraWrap.cache);
				if (cameraWrap.component != null && cameraWrap.component.gameObject != null)
				{
					UICamera component = cameraWrap.component.gameObject.GetComponent<UICamera>();
					bool allowMultiTouch = LuaDLL.lua_toboolean(L, 2);
					if (component != null)
					{
						component.allowMultiTouch = allowMultiTouch;
					}
				}
				result = 1;
			}
			return result;
		}

		[MonoPInvokeCallback(typeof(LuaCSFunction))]
		private static int set_clear_flags(IntPtr L)
		{
			int result = 0;
			if (WraperUtil.ValidIsUserdata(L, 1, string_set_clear_flags) && WraperUtil.ValidIsNumber(L, 2, string_set_clear_flags))
			{
				CameraWrap cameraWrap = WraperUtil.LuaToUserdata(L, 1, string_set_clear_flags, CameraWrap.cache);
				if (cameraWrap != null && cameraWrap.component != null)
				{
					int clearFlags = (int)LuaDLL.lua_tonumber(L, 2);
					cameraWrap.component.clearFlags = (CameraClearFlags)clearFlags;
				}
			}
			return result;
		}

		[MonoPInvokeCallback(typeof(LuaCSFunction))]
		private static int set_background_color(IntPtr L)
		{
			int result = 0;
			if (WraperUtil.ValidIsUserdata(L, 1, string_set_background_color) && WraperUtil.ValidIsNumber(L, 2, string_set_background_color) && WraperUtil.ValidIsNumber(L, 3, string_set_background_color) && WraperUtil.ValidIsNumber(L, 4, string_set_background_color) && WraperUtil.ValidIsNumber(L, 5, string_set_background_color))
			{
				CameraWrap cameraWrap = WraperUtil.LuaToUserdata(L, 1, string_set_background_color, CameraWrap.cache);
				if (cameraWrap != null && cameraWrap.component != null)
				{
					float r = (float)LuaDLL.lua_tonumber(L, 2);
					float g = (float)LuaDLL.lua_tonumber(L, 3);
					float b = (float)LuaDLL.lua_tonumber(L, 4);
					float a = (float)LuaDLL.lua_tonumber(L, 5);
					cameraWrap.component.backgroundColor = new Color(r, g, b, a);
				}
			}
			return result;
		}

		[MonoPInvokeCallback(typeof(LuaCSFunction))]
		private static int set_clip_plane(IntPtr L)
		{
			int result = 0;
			if (WraperUtil.ValidIsUserdata(L, 1, string_set_clip_plane) && WraperUtil.ValidIsNumber(L, 2, string_set_clip_plane) && WraperUtil.ValidIsNumber(L, 3, string_set_clip_plane))
			{
				CameraWrap cameraWrap = WraperUtil.LuaToUserdata(L, 1, string_set_clip_plane, CameraWrap.cache);
				if (cameraWrap != null && cameraWrap.component != null)
				{
					float nearClipPlane = (float)LuaDLL.lua_tonumber(L, 2);
					float farClipPlane = (float)LuaDLL.lua_tonumber(L, 3);
					cameraWrap.component.nearClipPlane = nearClipPlane;
					cameraWrap.component.farClipPlane = farClipPlane;
				}
			}
			return result;
		}

		[MonoPInvokeCallback(typeof(LuaCSFunction))]
		private static int re_set_aspect(IntPtr L)
		{
			int result = 0;
			if (WraperUtil.ValidIsUserdata(L, 1, string_re_set_aspect))
			{
				CameraWrap cameraWrap = WraperUtil.LuaToUserdata(L, 1, string_set_clip_plane, CameraWrap.cache);
				if (cameraWrap != null && cameraWrap.component != null)
				{
					cameraWrap.component.ResetAspect();
				}
			}
			return result;
		}

		[MonoPInvokeCallback(typeof(LuaCSFunction))]
		private static int start_qte(IntPtr L)
		{
			int result = 0;
			if (WraperUtil.ValidIsUserdata(L, 1, string_start_qte) && WraperUtil.ValidIsNumber(L, 2, string_start_qte) && WraperUtil.ValidIsNumber(L, 3, string_start_qte))
			{
				CameraWrap cameraWrap = WraperUtil.LuaToUserdata(L, 1, string_start_qte, CameraWrap.cache);
				float alphaEnd = (float)LuaDLL.lua_tonumber(L, 2);
				float tweenTime = (float)LuaDLL.lua_tonumber(L, 3);
				if (cameraWrap != null && cameraWrap.component != null)
				{
					QTEEffect qTEEffect = cameraWrap.component.gameObject.GetComponent<QTEEffect>();
					if (qTEEffect == null)
					{
						qTEEffect = cameraWrap.component.gameObject.AddComponent<QTEEffect>();
					}
					qTEEffect.startEffect(0f, alphaEnd, tweenTime);
				}
			}
			return result;
		}

		[MonoPInvokeCallback(typeof(LuaCSFunction))]
		private static int stop_qte(IntPtr L)
		{
			int result = 0;
			if (WraperUtil.ValidIsUserdata(L, 1, string_stop_qte) && WraperUtil.ValidIsNumber(L, 2, string_stop_qte))
			{
				CameraWrap cameraWrap = WraperUtil.LuaToUserdata(L, 1, string_stop_qte, CameraWrap.cache);
				if (cameraWrap != null && cameraWrap.component != null)
				{
					QTEEffect qTEEffect = cameraWrap.component.gameObject.GetComponent<QTEEffect>();
					float tweenTime = (float)LuaDLL.lua_tonumber(L, 2);
					if (qTEEffect == null)
					{
						qTEEffect = cameraWrap.component.gameObject.AddComponent<QTEEffect>();
					}
					qTEEffect.stopEffect(tweenTime);
				}
			}
			return result;
		}

		[MonoPInvokeCallback(typeof(LuaCSFunction))]
		private static int set_dof_target(IntPtr L)
		{
			int result = 0;
			if (WraperUtil.ValidIsUserdata(L, 1, string_set_dof_target))
			{
				AssetGameObject assetGameObject = WraperUtil.LuaToUserdata(L, 1, string_set_dof_target, AssetGameObject.cache);
				if (assetGameObject != null)
				{
					GhoulAfterEffects.GetInstance().DofTarget = assetGameObject.transform;
					GhoulAfterEffects.GetInstance().DofDistance = 3f;
				}
			}
			return result;
		}

		[MonoPInvokeCallback(typeof(LuaCSFunction))]
		private static int enable_dof(IntPtr L)
		{
			int result = 0;
			if (WraperUtil.ValidIsBoolean(L, 1, string_enable_dof) && WraperUtil.ValidIsNumber(L, 2, string_enable_dof) && WraperUtil.ValidIsNumber(L, 3, string_enable_dof))
			{
				bool enableDOF = LuaDLL.lua_toboolean(L, 1);
				float focusDepth = (float)LuaDLL.lua_tonumber(L, 2);
				float focusDistance = (float)LuaDLL.lua_tonumber(L, 3);
				GhoulAfterEffects.GetInstance().enableDOF = enableDOF;
				GhoulAfterEffects.GetInstance().focusDepth = focusDepth;
				GhoulAfterEffects.GetInstance().focusDistance = focusDistance;
			}
			return result;
		}

		[MonoPInvokeCallback(typeof(LuaCSFunction))]
		private static int set_bloomfactor(IntPtr L)
		{
			int result = 0;
			if (WraperUtil.ValidIsNumber(L, 1, string_set_bloomfactor))
			{
				float bloomFactor = (float)LuaDLL.lua_tonumber(L, 1);
				GhoulAfterEffectsConsole.bloomFactor = bloomFactor;
			}
			return result;
		}

		[MonoPInvokeCallback(typeof(LuaCSFunction))]
		private static int set_bloom(IntPtr L)
		{
			int result = 0;
			if (WraperUtil.ValidIsNumber(L, 1, string_set_bloom) && WraperUtil.ValidIsNumber(L, 2, string_set_bloom) && WraperUtil.ValidIsNumber(L, 3, string_set_bloom) && WraperUtil.ValidIsNumber(L, 4, string_set_bloom))
			{
				float screenIntensity = (float)LuaDLL.lua_tonumber(L, 1);
				float screenLuminanceThreshold = (float)LuaDLL.lua_tonumber(L, 2);
				float bloomFactor = (float)LuaDLL.lua_tonumber(L, 3);
				float blurSize = (float)LuaDLL.lua_tonumber(L, 4);
				GhoulAfterEffectsConsole.bloomFactor = bloomFactor;
				GhoulAfterEffectsConsole.screenIntensity = screenIntensity;
				GhoulAfterEffectsConsole.screenLuminanceThreshold = screenLuminanceThreshold;
				GhoulAfterEffectsConsole.blurSize = blurSize;
				if (QualitySettings.GetQualityLevel() > 0)
				{
					GhoulAfterEffectsConsole.enableBloom = 1;
					GhoulAfterEffectsConsole.enableEffect = 1;
					GhoulAfterEffectsConsole.enableDistortion = 1;
				}
			}
			return result;
		}

		[MonoPInvokeCallback(typeof(LuaCSFunction))]
		private static int set_enable_aa(IntPtr L)
		{
			int result = 0;
			if (WraperUtil.ValidIsBoolean(L, 1, string_set_enable_aa))
			{
				bool aAenabled = LuaDLL.lua_toboolean(L, 1);
				GhoulAfterEffects.GetInstance().AAenabled = aAenabled;
			}
			return result;
		}

		[MonoPInvokeCallback(typeof(LuaCSFunction))]
		private static int on_bloom_camera_change(IntPtr L)
		{
			int result = 0;
			if (WraperUtil.ValidIsString(L, 1, string_set_bloom))
			{
				string onCameraChangeScript = LuaDLL.lua_tostring(L, 1);
				GhoulAfterEffects instance = GhoulAfterEffects.GetInstance();
				instance.onCameraChangeScript = onCameraChangeScript;
			}
			return result;
		}

		[MonoPInvokeCallback(typeof(LuaCSFunction))]
		private static int raycast_out_screen(IntPtr L)
		{
			int result = 0;
			if (WraperUtil.ValidIsUserdata(L, 1, string_raycast_out_screen) && WraperUtil.ValidIsNumber(L, 2, string_raycast_out_screen) && WraperUtil.ValidIsNumber(L, 3, string_raycast_out_screen) && WraperUtil.ValidIsNumber(L, 4, string_raycast_out_screen) && WraperUtil.ValidIsNumber(L, 5, string_raycast_out_screen))
			{
				CameraWrap cameraWrap = (cameraWrap = WraperUtil.LuaToUserdata(L, 1, string_raycast_out_screen, CameraWrap.cache));
				float x = (float)LuaDLL.lua_tonumber(L, 2);
				float y = (float)LuaDLL.lua_tonumber(L, 3);
				float maxDistance = (float)LuaDLL.lua_tonumber(L, 4);
				int layerMask = (int)LuaDLL.lua_tonumber(L, 5);
				Ray ray = cameraWrap.component.ScreenPointToRay(new Vector3(x, y, 0f));
				RaycastHit hitInfo;
				bool flag = Physics.Raycast(ray, out hitInfo, maxDistance, layerMask);
				LuaDLL.lua_pushboolean(L, flag);
				if (flag)
				{
					WraperUtil.Push(L, hitInfo);
				}
				else
				{
					LuaDLL.lua_pushnil(L);
				}
				result = 2;
			}
			return result;
		}

		[MonoPInvokeCallback(typeof(LuaCSFunction))]
		private static int gc(IntPtr L)
		{
			CameraWrap cameraWrap = WraperUtil.LuaToUserdataByGc(L, 1, "gc camera_object", CameraWrap.cache);
			if (cameraWrap != null)
			{
				CameraWrap.DestroyInstance(cameraWrap);
			}
			return 0;
		}
	}
}
