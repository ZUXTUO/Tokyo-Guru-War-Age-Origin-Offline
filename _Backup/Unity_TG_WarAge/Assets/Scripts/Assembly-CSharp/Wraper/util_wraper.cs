using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Security.Cryptography;
using Assets._protol_test;
using Core;
using Core.Resource;
using Core.Unity;
using Core.Util;
using LuaInterface;
using UnityEngine;
using UnityEngine.AI;
using UnityWrap;

namespace Wraper
{
	public class util_wraper
	{
		public static string libname = "util";

		private static luaL_Reg[] libfunc = new luaL_Reg[75]
		{
			new luaL_Reg("v3_normalized", v3_normalized),
			new luaL_Reg("v3_dot", v3_dot),
			new luaL_Reg("v3_angle", v3_angle),
			new luaL_Reg("v3_cross", v3_cross),
			new luaL_Reg("v3_reflect", v3_reflect),
			new luaL_Reg("v3_distance", v3_distance),
			new luaL_Reg("v3_lerp", v3_lerp),
			new luaL_Reg("v3_slerp", v3_slerp),
			new luaL_Reg("quaternion_lerp", quaternion_lerp),
			new luaL_Reg("quaternion_euler", quaternion_euler),
			new luaL_Reg("quaternion_look_rotation", quaternion_look_rotation),
			new luaL_Reg("quaternion_slerp", quaternion_slerp),
			new luaL_Reg("quaternion_angle", quaternion_angle),
			new luaL_Reg("get_quaternion_euler", get_quaternion_euler),
			new luaL_Reg("quaternion_multiply_v3", quaternion_multiply_v3),
			new luaL_Reg("quaternion_multiply", quaternion_multiply),
			new luaL_Reg("raycast_valid", raycast_valid),
			new luaL_Reg("raycase_out2", raycase_out2),
			new luaL_Reg("raycase_out3", raycase_out3),
			new luaL_Reg("raycase_out4", raycase_out4),
			new luaL_Reg("raycase_all", raycase_all),
			new luaL_Reg("raycase_out_screen", raycase_out_screen),
			new luaL_Reg("raycase_out_object", raycase_out_object),
			new luaL_Reg("overlap_sphere", overlap_sphere),
			new luaL_Reg("overlap_sphere_by_name", overlap_sphere_by_name),
			new luaL_Reg("mathf_lerp", mathf_lerp),
			new luaL_Reg("get_md5", get_md5),
			new luaL_Reg("get_file_md5", get_file_md5),
			new luaL_Reg("get_ngui_hovered_object", get_ngui_hovered_object),
			new luaL_Reg("get_navmesh_sampleposition", get_navmesh_sampleposition),
			new luaL_Reg("begin_sample", begin_sample),
			new luaL_Reg("end_sample", end_sample),
			new luaL_Reg("get_devicemodel", get_devicemodel),
			new luaL_Reg("get_deviceuniqueidentifier", get_deviceuniqueidentifier),
			new luaL_Reg("chang_role_s3d_material", chang_role_s3d_material),
			new luaL_Reg("get_click", get_click),
			new luaL_Reg("draw_line", draw_line),
			new luaL_Reg("start_installer", start_installer),
			new luaL_Reg("android_log", android_log),
			new luaL_Reg("quit", quit),
			new luaL_Reg("download_file", download_file),
			new luaL_Reg("get_version_code", get_version_code),
			new luaL_Reg("get_package_name", get_package_name),
			new luaL_Reg("get_signature_hash_code", get_signature_hash_code),
			new luaL_Reg("get_write_dir", get_write_dir),
			new luaL_Reg("click_back_key", click_back_key),
			new luaL_Reg("sleep_timeout", sleep_timeout),
			new luaL_Reg("bind_service", bind_service),
			new luaL_Reg("un_bind_service", un_bind_service),
			new luaL_Reg("capture_screenshot", capture_screenshot),
			new luaL_Reg("unload_unused_assets", unload_unused_assets),
			new luaL_Reg("refresh_all_panel", refresh_all_panel),
			new luaL_Reg("download2file", download2file),
			new luaL_Reg("set_effect_quality_level", set_effect_quality_level),
			new luaL_Reg("set_quality_setting", set_quality_setting),
			new luaL_Reg("set_all_widget_color", set_all_widget_color),
			new luaL_Reg("enable_ui_node_gray_color", enable_ui_node_gray_color),
			new luaL_Reg("media_player_init", media_player_init),
			new luaL_Reg("media_player_play", media_player_play),
			new luaL_Reg("media_player_resume", media_player_resume),
			new luaL_Reg("media_player_destory", media_player_destory),
			new luaL_Reg("audio_set_sample_rate", audio_set_sample_rate),
			new luaL_Reg("set_error_url", set_error_url),
			new luaL_Reg("push_web_info", push_web_info),
			new luaL_Reg("is_write_file", is_write_file),
			new luaL_Reg("is_web_post", is_web_post),
			new luaL_Reg("is_debug_show", is_debug_show),
			new luaL_Reg("is_debug_check", is_debug_check),
			new luaL_Reg("get_readonly_path", get_readonly_path),
			new luaL_Reg("is_effect_console_enable", is_effect_console_enable),
			new luaL_Reg("uwa_push_sample", uwa_push_sample),
			new luaL_Reg("uwa_pop_sample", uwa_pop_sample),
			new luaL_Reg("temp_tween_alpha_replay_forward", temp_tween_alpha_replay_forward),
			new luaL_Reg("camera_layer_bug_fix", camera_layer_bug_fix),
			new luaL_Reg("enable_protol_test", enable_protol_test)
		};

		private static string string_v3_normalized = "util.v3_normalized";

		private static string string_v3_dot = "util.v3_dot";

		private static string string_v3_angle = "util.v3_angle";

		private static string string_v3_cross = "util.v3_cross";

		private static string string_v3_reflect = "util.v3_reflect";

		private static string string_v3_distance = "util.v3_distance";

		private static string string_v3_lerp = "util.v3_lerp";

		private static string string_v3_slerp = "util.v3_slerp";

		private static string string_quaternion_lerp = "util.quaternion_lerp";

		private static string string_quaternion_euler = "util.quaternion_euler";

		private static string string_quaternion_look_rotation = "util.quaternion_look_rotation";

		private static string string_quaternion_slerp = "util.quaternion_slerp";

		private static string string_quaternion_angle = "util.quaternion_angle";

		private static string string_get_quaternion_euler = "util.get_quaternion_euler";

		private static string string_quaternion_multiply_v3 = "util.quaternion_multiply_v3";

		private static string string_quaternion_multiply = "util.quaternion_multiply";

		private static string string_raycast_valid = "util.raycast_valid";

		private static string string_raycase_out2 = "util.raycase_out2";

		private static string string_raycase_out3 = "util.raycase_out3";

		private static string string_raycase_out4 = "util.raycase_out4";

		private static string string_raycase_all = "util.raycase_all";

		private static string string_raycase_out_screen = "util.raycase_out_screen";

		private static string string_raycase_out_object = "util.raycase_out_object";

		private static string string_overlap_sphere = "util.overlap_sphere";

		private static string string_overlap_sphere_by_name = "util.overlap_sphere_by_name";

		private static string string_mathf_lerp = "util.mathf_lerp";

		private static string string_get_md5 = "util.get_md5";

		private static string string_get_file_md5 = "util.get_file_md5";

		private static string string_get_navmesh_sampleposition = "util.get_navmesh_sampleposition";

		private static string string_begin_sample = "util.begin_sample";

		private static string string_chang_role_s3d_material = "util.chang_role_s3d_material";

		private static string string_draw_line = "util.draw_line";

		private static string string_start_installer = "util.start_installer";

		private static string string_android_log = "util.android_log";

		private static string string_download_file = "util.download_file";

		private static string string_get_write_dir = "util.get_write_dir";

		private static string string_bind_service = "util.bind_service";

		private static string string_sleep_timeout = "util.sleep_timeout";

		private static string string_set_effect_quality_level = "util.set_effect_quality_level";

		private static string string_set_quality_setting = "util.set_quality_setting";

		private static string string_set_all_widget_color = "util.set_all_widget_color";

		private static string string_enable_ui_node_gray_color = "util.enable_ui_node_gray_color";

		private static string string_media_player_init = "util.media_player_init";

		private static string string_media_player_play = "util.media_player_play";

		private static string string_media_player_destory = "util.media_player_destory";

		private static string string_audio_set_sample_rate = "util.audio_set_sample_rate";

		private static string string_download2file = "util.download2file";

		private static string string_set_error_url = "util.set_error_url";

		private static string string_push_web_info = "util.push_web_info";

		private static string string_is_write_file = "util.is_write_file";

		private static string string_is_web_post = "util.is_web_post";

		private static string string_is_debug_show = "util.is_debug_show";

		private static string string_is_debug_check = "util.is_debug_check";

		private static string string_is_effect_console_enable = "util.is_effect_console_enable";

		private static string string_umeng_init = "util.umeng_init";

		private static string string_uwa_push_sample = "util.uwa_push_sample";

		private static string string_umeng_start_level = "util.umeng_start_level";

		private static string string_umeng_event_id = "util.umeng_event_id";

		private static string string_capture_screenshot = "util.capture_screenshot";

		private static string string_temp_tween_alpha_replay_forward = "util.temp_tween_alpha_replay_forward";

		private static string string_camera_layer_buf_fix = "util.camera_layer_buf_fix";

		private static string string_get_readonly_path = "util.get_readonly_path";

		private static string string_enable_protol_test = "util.enable_protol_test";

		private static BaseInterface[] m_OverLapSphereBuff = null;

		private static Vector3 m_OverLapSphereVector;

		private static Dictionary<int, object> m_ResultDic = new Dictionary<int, object>();

		public static bool init(IntPtr L)
		{
			if (L != IntPtr.Zero)
			{
				LuaDLL.register_lib(L, libname, libfunc, 0);
				return true;
			}
			return false;
		}

		[MonoPInvokeCallback(typeof(LuaCSFunction))]
		private static int v3_normalized(IntPtr L)
		{
			int result = 0;
			if (WraperUtil.ValidIsNumber(L, 1, string_v3_normalized) && WraperUtil.ValidIsNumber(L, 2, string_v3_normalized) && WraperUtil.ValidIsNumber(L, 3, string_v3_normalized))
			{
				float x = (float)LuaDLL.lua_tonumber(L, 1);
				float y = (float)LuaDLL.lua_tonumber(L, 2);
				float z = (float)LuaDLL.lua_tonumber(L, 3);
				Vector3 normalized = new Vector3(x, y, z).normalized;
				LuaDLL.lua_pushnumber(L, normalized.x);
				LuaDLL.lua_pushnumber(L, normalized.y);
				LuaDLL.lua_pushnumber(L, normalized.z);
				result = 3;
			}
			return result;
		}

		[MonoPInvokeCallback(typeof(LuaCSFunction))]
		private static int v3_dot(IntPtr L)
		{
			int result = 0;
			if (WraperUtil.ValidIsNumber(L, 1, string_v3_dot) && WraperUtil.ValidIsNumber(L, 2, string_v3_dot) && WraperUtil.ValidIsNumber(L, 3, string_v3_dot) && WraperUtil.ValidIsNumber(L, 4, string_v3_dot) && WraperUtil.ValidIsNumber(L, 5, string_v3_dot) && WraperUtil.ValidIsNumber(L, 6, string_v3_dot))
			{
				float x = (float)LuaDLL.lua_tonumber(L, 1);
				float y = (float)LuaDLL.lua_tonumber(L, 2);
				float z = (float)LuaDLL.lua_tonumber(L, 3);
				float x2 = (float)LuaDLL.lua_tonumber(L, 4);
				float y2 = (float)LuaDLL.lua_tonumber(L, 5);
				float z2 = (float)LuaDLL.lua_tonumber(L, 6);
				float num = Vector3.Dot(new Vector3(x, y, z), new Vector3(x2, y2, z2));
				LuaDLL.lua_pushnumber(L, num);
				result = 1;
			}
			return result;
		}

		[MonoPInvokeCallback(typeof(LuaCSFunction))]
		private static int v3_angle(IntPtr L)
		{
			int result = 0;
			if (WraperUtil.ValidIsNumber(L, 1, string_v3_angle) && WraperUtil.ValidIsNumber(L, 2, string_v3_angle) && WraperUtil.ValidIsNumber(L, 3, string_v3_angle) && WraperUtil.ValidIsNumber(L, 4, string_v3_angle) && WraperUtil.ValidIsNumber(L, 5, string_v3_angle) && WraperUtil.ValidIsNumber(L, 6, string_v3_angle))
			{
				float x = (float)LuaDLL.lua_tonumber(L, 1);
				float y = (float)LuaDLL.lua_tonumber(L, 2);
				float z = (float)LuaDLL.lua_tonumber(L, 3);
				float x2 = (float)LuaDLL.lua_tonumber(L, 4);
				float y2 = (float)LuaDLL.lua_tonumber(L, 5);
				float z2 = (float)LuaDLL.lua_tonumber(L, 6);
				float num = Vector3.Angle(new Vector3(x, y, z), new Vector3(x2, y2, z2));
				LuaDLL.lua_pushnumber(L, num);
				result = 1;
			}
			return result;
		}

		[MonoPInvokeCallback(typeof(LuaCSFunction))]
		private static int v3_cross(IntPtr L)
		{
			int result = 0;
			if (WraperUtil.ValidIsNumber(L, 1, string_v3_cross) && WraperUtil.ValidIsNumber(L, 2, string_v3_cross) && WraperUtil.ValidIsNumber(L, 3, string_v3_cross) && WraperUtil.ValidIsNumber(L, 4, string_v3_cross) && WraperUtil.ValidIsNumber(L, 5, string_v3_cross) && WraperUtil.ValidIsNumber(L, 6, string_v3_cross))
			{
				float x = (float)LuaDLL.lua_tonumber(L, 1);
				float y = (float)LuaDLL.lua_tonumber(L, 2);
				float z = (float)LuaDLL.lua_tonumber(L, 3);
				float x2 = (float)LuaDLL.lua_tonumber(L, 4);
				float y2 = (float)LuaDLL.lua_tonumber(L, 5);
				float z2 = (float)LuaDLL.lua_tonumber(L, 6);
				Vector3 vector = Vector3.Cross(new Vector3(x, y, z), new Vector3(x2, y2, z2));
				LuaDLL.lua_pushnumber(L, vector.x);
				LuaDLL.lua_pushnumber(L, vector.y);
				LuaDLL.lua_pushnumber(L, vector.z);
				result = 3;
			}
			return result;
		}

		[MonoPInvokeCallback(typeof(LuaCSFunction))]
		private static int v3_reflect(IntPtr L)
		{
			int result = 0;
			if (WraperUtil.ValidIsNumber(L, 1, string_v3_reflect) && WraperUtil.ValidIsNumber(L, 2, string_v3_reflect) && WraperUtil.ValidIsNumber(L, 3, string_v3_reflect) && WraperUtil.ValidIsNumber(L, 4, string_v3_reflect) && WraperUtil.ValidIsNumber(L, 5, string_v3_reflect) && WraperUtil.ValidIsNumber(L, 6, string_v3_reflect))
			{
				float x = (float)LuaDLL.lua_tonumber(L, 1);
				float y = (float)LuaDLL.lua_tonumber(L, 2);
				float z = (float)LuaDLL.lua_tonumber(L, 3);
				float x2 = (float)LuaDLL.lua_tonumber(L, 4);
				float y2 = (float)LuaDLL.lua_tonumber(L, 5);
				float z2 = (float)LuaDLL.lua_tonumber(L, 6);
				Vector3 vector = Vector3.Reflect(new Vector3(x, y, z), new Vector3(x2, y2, z2));
				LuaDLL.lua_pushnumber(L, vector.x);
				LuaDLL.lua_pushnumber(L, vector.y);
				LuaDLL.lua_pushnumber(L, vector.z);
				result = 3;
			}
			return result;
		}

		[MonoPInvokeCallback(typeof(LuaCSFunction))]
		private static int v3_distance(IntPtr L)
		{
			int result = 0;
			if (WraperUtil.ValidIsNumber(L, 1, string_v3_distance) && WraperUtil.ValidIsNumber(L, 2, string_v3_distance) && WraperUtil.ValidIsNumber(L, 3, string_v3_distance) && WraperUtil.ValidIsNumber(L, 4, string_v3_distance) && WraperUtil.ValidIsNumber(L, 5, string_v3_distance) && WraperUtil.ValidIsNumber(L, 6, string_v3_distance))
			{
				float x = (float)LuaDLL.lua_tonumber(L, 1);
				float y = (float)LuaDLL.lua_tonumber(L, 2);
				float z = (float)LuaDLL.lua_tonumber(L, 3);
				float x2 = (float)LuaDLL.lua_tonumber(L, 4);
				float y2 = (float)LuaDLL.lua_tonumber(L, 5);
				float z2 = (float)LuaDLL.lua_tonumber(L, 6);
				float num = Vector3.Distance(new Vector3(x, y, z), new Vector3(x2, y2, z2));
				LuaDLL.lua_pushnumber(L, num);
				result = 1;
			}
			return result;
		}

		[MonoPInvokeCallback(typeof(LuaCSFunction))]
		private static int v3_lerp(IntPtr L)
		{
			int result = 0;
			if (WraperUtil.ValidIsNumber(L, 1, string_v3_lerp) && WraperUtil.ValidIsNumber(L, 2, string_v3_lerp) && WraperUtil.ValidIsNumber(L, 3, string_v3_lerp) && WraperUtil.ValidIsNumber(L, 4, string_v3_lerp) && WraperUtil.ValidIsNumber(L, 5, string_v3_lerp) && WraperUtil.ValidIsNumber(L, 6, string_v3_lerp) && WraperUtil.ValidIsNumber(L, 7, string_v3_lerp))
			{
				float x = (float)LuaDLL.lua_tonumber(L, 1);
				float y = (float)LuaDLL.lua_tonumber(L, 2);
				float z = (float)LuaDLL.lua_tonumber(L, 3);
				float x2 = (float)LuaDLL.lua_tonumber(L, 4);
				float y2 = (float)LuaDLL.lua_tonumber(L, 5);
				float z2 = (float)LuaDLL.lua_tonumber(L, 6);
				float t = (float)LuaDLL.lua_tonumber(L, 7);
				Vector3 vector = Vector3.Lerp(new Vector3(x, y, z), new Vector3(x2, y2, z2), t);
				LuaDLL.lua_pushnumber(L, vector.x);
				LuaDLL.lua_pushnumber(L, vector.y);
				LuaDLL.lua_pushnumber(L, vector.z);
				result = 3;
			}
			return result;
		}

		[MonoPInvokeCallback(typeof(LuaCSFunction))]
		private static int v3_slerp(IntPtr L)
		{
			int result = 0;
			if (WraperUtil.ValidIsNumber(L, 1, string_v3_slerp) && WraperUtil.ValidIsNumber(L, 2, string_v3_slerp) && WraperUtil.ValidIsNumber(L, 3, string_v3_slerp) && WraperUtil.ValidIsNumber(L, 4, string_v3_slerp) && WraperUtil.ValidIsNumber(L, 5, string_v3_slerp) && WraperUtil.ValidIsNumber(L, 6, string_v3_slerp) && WraperUtil.ValidIsNumber(L, 7, string_v3_slerp))
			{
				float x = (float)LuaDLL.lua_tonumber(L, 1);
				float y = (float)LuaDLL.lua_tonumber(L, 2);
				float z = (float)LuaDLL.lua_tonumber(L, 3);
				float x2 = (float)LuaDLL.lua_tonumber(L, 4);
				float y2 = (float)LuaDLL.lua_tonumber(L, 5);
				float z2 = (float)LuaDLL.lua_tonumber(L, 6);
				float t = (float)LuaDLL.lua_tonumber(L, 7);
				Vector3 vector = Vector3.Slerp(new Vector3(x, y, z), new Vector3(x2, y2, z2), t);
				LuaDLL.lua_pushnumber(L, vector.x);
				LuaDLL.lua_pushnumber(L, vector.y);
				LuaDLL.lua_pushnumber(L, vector.z);
				result = 3;
			}
			return result;
		}

		[MonoPInvokeCallback(typeof(LuaCSFunction))]
		private static int quaternion_lerp(IntPtr L)
		{
			int result = 0;
			if (WraperUtil.ValidIsNumber(L, 1, string_quaternion_lerp) && WraperUtil.ValidIsNumber(L, 2, string_quaternion_lerp) && WraperUtil.ValidIsNumber(L, 3, string_quaternion_lerp) && WraperUtil.ValidIsNumber(L, 4, string_quaternion_lerp) && WraperUtil.ValidIsNumber(L, 5, string_quaternion_lerp) && WraperUtil.ValidIsNumber(L, 6, string_quaternion_lerp) && WraperUtil.ValidIsNumber(L, 7, string_quaternion_lerp) && WraperUtil.ValidIsNumber(L, 8, string_quaternion_lerp) && WraperUtil.ValidIsNumber(L, 9, string_quaternion_lerp))
			{
				float x = (float)LuaDLL.lua_tonumber(L, 1);
				float y = (float)LuaDLL.lua_tonumber(L, 2);
				float z = (float)LuaDLL.lua_tonumber(L, 3);
				float w = (float)LuaDLL.lua_tonumber(L, 4);
				float x2 = (float)LuaDLL.lua_tonumber(L, 5);
				float y2 = (float)LuaDLL.lua_tonumber(L, 6);
				float z2 = (float)LuaDLL.lua_tonumber(L, 7);
				float w2 = (float)LuaDLL.lua_tonumber(L, 8);
				float t = (float)LuaDLL.lua_tonumber(L, 9);
				Quaternion quaternion = Quaternion.Lerp(new Quaternion(x, y, z, w), new Quaternion(x2, y2, z2, w2), t);
				LuaDLL.lua_pushnumber(L, quaternion.x);
				LuaDLL.lua_pushnumber(L, quaternion.y);
				LuaDLL.lua_pushnumber(L, quaternion.z);
				LuaDLL.lua_pushnumber(L, quaternion.w);
				result = 4;
			}
			return result;
		}

		[MonoPInvokeCallback(typeof(LuaCSFunction))]
		private static int quaternion_euler(IntPtr L)
		{
			int result = 0;
			if (WraperUtil.ValidIsNumber(L, 1, string_quaternion_euler) && WraperUtil.ValidIsNumber(L, 2, string_quaternion_euler) && WraperUtil.ValidIsNumber(L, 3, string_quaternion_euler))
			{
				float x = (float)LuaDLL.lua_tonumber(L, 1);
				float y = (float)LuaDLL.lua_tonumber(L, 2);
				float z = (float)LuaDLL.lua_tonumber(L, 3);
				Quaternion quaternion = Quaternion.Euler(new Vector3(x, y, z));
				LuaDLL.lua_pushnumber(L, quaternion.x);
				LuaDLL.lua_pushnumber(L, quaternion.y);
				LuaDLL.lua_pushnumber(L, quaternion.z);
				LuaDLL.lua_pushnumber(L, quaternion.w);
				result = 4;
			}
			return result;
		}

		[MonoPInvokeCallback(typeof(LuaCSFunction))]
		private static int quaternion_look_rotation(IntPtr L)
		{
			int result = 0;
			if (WraperUtil.ValidIsNumber(L, 1, string_quaternion_look_rotation) && WraperUtil.ValidIsNumber(L, 2, string_quaternion_look_rotation) && WraperUtil.ValidIsNumber(L, 3, string_quaternion_look_rotation))
			{
				float x = (float)LuaDLL.lua_tonumber(L, 1);
				float y = (float)LuaDLL.lua_tonumber(L, 2);
				float z = (float)LuaDLL.lua_tonumber(L, 3);
				Quaternion quaternion = Quaternion.LookRotation(new Vector3(x, y, z));
				LuaDLL.lua_pushnumber(L, quaternion.x);
				LuaDLL.lua_pushnumber(L, quaternion.y);
				LuaDLL.lua_pushnumber(L, quaternion.z);
				LuaDLL.lua_pushnumber(L, quaternion.w);
				result = 4;
			}
			return result;
		}

		[MonoPInvokeCallback(typeof(LuaCSFunction))]
		private static int quaternion_slerp(IntPtr L)
		{
			int result = 0;
			if (WraperUtil.ValidIsNumber(L, 1, string_quaternion_slerp) && WraperUtil.ValidIsNumber(L, 2, string_quaternion_slerp) && WraperUtil.ValidIsNumber(L, 3, string_quaternion_slerp) && WraperUtil.ValidIsNumber(L, 4, string_quaternion_slerp) && WraperUtil.ValidIsNumber(L, 5, string_quaternion_slerp) && WraperUtil.ValidIsNumber(L, 6, string_quaternion_slerp) && WraperUtil.ValidIsNumber(L, 7, string_quaternion_slerp) && WraperUtil.ValidIsNumber(L, 8, string_quaternion_slerp) && WraperUtil.ValidIsNumber(L, 9, string_quaternion_slerp))
			{
				float x = (float)LuaDLL.lua_tonumber(L, 1);
				float y = (float)LuaDLL.lua_tonumber(L, 2);
				float z = (float)LuaDLL.lua_tonumber(L, 3);
				float w = (float)LuaDLL.lua_tonumber(L, 4);
				float x2 = (float)LuaDLL.lua_tonumber(L, 5);
				float y2 = (float)LuaDLL.lua_tonumber(L, 6);
				float z2 = (float)LuaDLL.lua_tonumber(L, 7);
				float w2 = (float)LuaDLL.lua_tonumber(L, 8);
				float t = (float)LuaDLL.lua_tonumber(L, 9);
				Quaternion quaternion = Quaternion.Slerp(new Quaternion(x, y, z, w), new Quaternion(x2, y2, z2, w2), t);
				LuaDLL.lua_pushnumber(L, quaternion.x);
				LuaDLL.lua_pushnumber(L, quaternion.y);
				LuaDLL.lua_pushnumber(L, quaternion.z);
				LuaDLL.lua_pushnumber(L, quaternion.w);
				result = 4;
			}
			return result;
		}

		[MonoPInvokeCallback(typeof(LuaCSFunction))]
		private static int quaternion_angle(IntPtr L)
		{
			int result = 0;
			if (WraperUtil.ValidIsNumber(L, 1, string_quaternion_angle) && WraperUtil.ValidIsNumber(L, 2, string_quaternion_angle) && WraperUtil.ValidIsNumber(L, 3, string_quaternion_angle) && WraperUtil.ValidIsNumber(L, 4, string_quaternion_angle) && WraperUtil.ValidIsNumber(L, 5, string_quaternion_angle) && WraperUtil.ValidIsNumber(L, 6, string_quaternion_angle) && WraperUtil.ValidIsNumber(L, 7, string_quaternion_angle) && WraperUtil.ValidIsNumber(L, 8, string_quaternion_angle))
			{
				float x = (float)LuaDLL.lua_tonumber(L, 1);
				float y = (float)LuaDLL.lua_tonumber(L, 2);
				float z = (float)LuaDLL.lua_tonumber(L, 3);
				float w = (float)LuaDLL.lua_tonumber(L, 4);
				float x2 = (float)LuaDLL.lua_tonumber(L, 5);
				float y2 = (float)LuaDLL.lua_tonumber(L, 6);
				float z2 = (float)LuaDLL.lua_tonumber(L, 7);
				float w2 = (float)LuaDLL.lua_tonumber(L, 8);
				Quaternion a = new Quaternion(x, y, z, w);
				Quaternion b = new Quaternion(x2, y2, z2, w2);
				float num = Quaternion.Angle(a, b);
				LuaDLL.lua_pushnumber(L, num);
				result = 1;
			}
			return result;
		}

		[MonoPInvokeCallback(typeof(LuaCSFunction))]
		private static int get_quaternion_euler(IntPtr L)
		{
			int result = 0;
			if (WraperUtil.ValidIsNumber(L, 1, string_get_quaternion_euler) && WraperUtil.ValidIsNumber(L, 2, string_get_quaternion_euler) && WraperUtil.ValidIsNumber(L, 3, string_get_quaternion_euler) && WraperUtil.ValidIsNumber(L, 4, string_get_quaternion_euler))
			{
				float x = (float)LuaDLL.lua_tonumber(L, 1);
				float y = (float)LuaDLL.lua_tonumber(L, 2);
				float z = (float)LuaDLL.lua_tonumber(L, 3);
				float w = (float)LuaDLL.lua_tonumber(L, 4);
				Quaternion quaternion = new Quaternion(x, y, z, w);
				LuaDLL.lua_pushnumber(L, quaternion.eulerAngles.x);
				LuaDLL.lua_pushnumber(L, quaternion.eulerAngles.y);
				LuaDLL.lua_pushnumber(L, quaternion.eulerAngles.z);
				result = 3;
			}
			return result;
		}

		[MonoPInvokeCallback(typeof(LuaCSFunction))]
		private static int quaternion_multiply_v3(IntPtr L)
		{
			int result = 0;
			if (WraperUtil.ValidIsNumber(L, 1, string_quaternion_multiply_v3) && WraperUtil.ValidIsNumber(L, 2, string_quaternion_multiply_v3) && WraperUtil.ValidIsNumber(L, 3, string_quaternion_multiply_v3) && WraperUtil.ValidIsNumber(L, 4, string_quaternion_multiply_v3) && WraperUtil.ValidIsNumber(L, 5, string_quaternion_multiply_v3) && WraperUtil.ValidIsNumber(L, 6, string_quaternion_multiply_v3) && WraperUtil.ValidIsNumber(L, 7, string_quaternion_multiply_v3))
			{
				float x = (float)LuaDLL.lua_tonumber(L, 1);
				float y = (float)LuaDLL.lua_tonumber(L, 2);
				float z = (float)LuaDLL.lua_tonumber(L, 3);
				float w = (float)LuaDLL.lua_tonumber(L, 4);
				float x2 = (float)LuaDLL.lua_tonumber(L, 5);
				float y2 = (float)LuaDLL.lua_tonumber(L, 6);
				float z2 = (float)LuaDLL.lua_tonumber(L, 7);
				Quaternion quaternion = new Quaternion(x, y, z, w);
				Vector3 vector = quaternion * new Vector3(x2, y2, z2);
				LuaDLL.lua_pushnumber(L, vector.x);
				LuaDLL.lua_pushnumber(L, vector.y);
				LuaDLL.lua_pushnumber(L, vector.z);
				result = 3;
			}
			return result;
		}

		[MonoPInvokeCallback(typeof(LuaCSFunction))]
		private static int quaternion_multiply(IntPtr L)
		{
			int result = 0;
			if (WraperUtil.ValidIsNumber(L, 1, string_quaternion_multiply) && WraperUtil.ValidIsNumber(L, 2, string_quaternion_multiply) && WraperUtil.ValidIsNumber(L, 3, string_quaternion_multiply) && WraperUtil.ValidIsNumber(L, 4, string_quaternion_multiply) && WraperUtil.ValidIsNumber(L, 5, string_quaternion_multiply) && WraperUtil.ValidIsNumber(L, 6, string_quaternion_multiply) && WraperUtil.ValidIsNumber(L, 7, string_quaternion_multiply) && WraperUtil.ValidIsNumber(L, 8, string_quaternion_multiply))
			{
				float x = (float)LuaDLL.lua_tonumber(L, 1);
				float y = (float)LuaDLL.lua_tonumber(L, 2);
				float z = (float)LuaDLL.lua_tonumber(L, 3);
				float w = (float)LuaDLL.lua_tonumber(L, 4);
				float x2 = (float)LuaDLL.lua_tonumber(L, 5);
				float y2 = (float)LuaDLL.lua_tonumber(L, 6);
				float z2 = (float)LuaDLL.lua_tonumber(L, 7);
				float w2 = (float)LuaDLL.lua_tonumber(L, 8);
				Quaternion quaternion = new Quaternion(x, y, z, w);
				Quaternion quaternion2 = new Quaternion(x2, y2, z2, w2);
				Quaternion quaternion3 = quaternion * quaternion2;
				LuaDLL.lua_pushnumber(L, quaternion3.x);
				LuaDLL.lua_pushnumber(L, quaternion3.y);
				LuaDLL.lua_pushnumber(L, quaternion3.z);
				LuaDLL.lua_pushnumber(L, quaternion3.w);
				result = 4;
			}
			return result;
		}

		[MonoPInvokeCallback(typeof(LuaCSFunction))]
		private static int raycast_valid(IntPtr L)
		{
			int result = 0;
			if (WraperUtil.ValidIsNumber(L, 1, string_raycast_valid) && WraperUtil.ValidIsNumber(L, 2, string_raycast_valid) && WraperUtil.ValidIsNumber(L, 3, string_raycast_valid) && WraperUtil.ValidIsNumber(L, 4, string_raycast_valid) && WraperUtil.ValidIsNumber(L, 5, string_raycast_valid) && WraperUtil.ValidIsNumber(L, 6, string_raycast_valid) && WraperUtil.ValidIsNumber(L, 7, string_raycast_valid) && WraperUtil.ValidIsNumber(L, 8, string_raycast_valid))
			{
				float x = (float)LuaDLL.lua_tonumber(L, 1);
				float y = (float)LuaDLL.lua_tonumber(L, 2);
				float z = (float)LuaDLL.lua_tonumber(L, 3);
				float x2 = (float)LuaDLL.lua_tonumber(L, 4);
				float y2 = (float)LuaDLL.lua_tonumber(L, 5);
				float z2 = (float)LuaDLL.lua_tonumber(L, 6);
				float maxDistance = (float)LuaDLL.lua_tonumber(L, 7);
				int layerMask = (int)LuaDLL.lua_tonumber(L, 8);
				LuaDLL.lua_pushboolean(L, Physics.Raycast(new Vector3(x, y, z), new Vector3(x2, y2, z2), maxDistance, layerMask));
				result = 1;
			}
			return result;
		}

		[MonoPInvokeCallback(typeof(LuaCSFunction))]
		private static int raycase_out2(IntPtr L)
		{
			int result = 0;
			if (WraperUtil.ValidIsNumber(L, 1, string_raycase_out2) && WraperUtil.ValidIsNumber(L, 2, string_raycase_out2) && WraperUtil.ValidIsNumber(L, 3, string_raycase_out2) && WraperUtil.ValidIsNumber(L, 4, string_raycase_out2) && WraperUtil.ValidIsNumber(L, 5, string_raycase_out2) && WraperUtil.ValidIsNumber(L, 6, string_raycase_out2))
			{
				float x = (float)LuaDLL.lua_tonumber(L, 1);
				float y = (float)LuaDLL.lua_tonumber(L, 2);
				float z = (float)LuaDLL.lua_tonumber(L, 3);
				float x2 = (float)LuaDLL.lua_tonumber(L, 4);
				float y2 = (float)LuaDLL.lua_tonumber(L, 5);
				float z2 = (float)LuaDLL.lua_tonumber(L, 6);
				RaycastHit hitInfo;
				bool flag = Physics.Raycast(new Vector3(x, y, z), new Vector3(x2, y2, z2), out hitInfo);
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
		private static int raycase_out3(IntPtr L)
		{
			int result = 0;
			if (WraperUtil.ValidIsNumber(L, 1, string_raycase_out3) && WraperUtil.ValidIsNumber(L, 2, string_raycase_out3) && WraperUtil.ValidIsNumber(L, 3, string_raycase_out3) && WraperUtil.ValidIsNumber(L, 4, string_raycase_out3) && WraperUtil.ValidIsNumber(L, 5, string_raycase_out3) && WraperUtil.ValidIsNumber(L, 6, string_raycase_out3) && WraperUtil.ValidIsNumber(L, 7, string_raycase_out3))
			{
				float x = (float)LuaDLL.lua_tonumber(L, 1);
				float y = (float)LuaDLL.lua_tonumber(L, 2);
				float z = (float)LuaDLL.lua_tonumber(L, 3);
				float x2 = (float)LuaDLL.lua_tonumber(L, 4);
				float y2 = (float)LuaDLL.lua_tonumber(L, 5);
				float z2 = (float)LuaDLL.lua_tonumber(L, 6);
				float maxDistance = (float)LuaDLL.lua_tonumber(L, 7);
				RaycastHit hitInfo;
				bool flag = Physics.Raycast(new Vector3(x, y, z), new Vector3(x2, y2, z2), out hitInfo, maxDistance);
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
		private static int raycase_out4(IntPtr L)
		{
			int result = 0;
			if (WraperUtil.ValidIsNumber(L, 1, string_raycase_out4) && WraperUtil.ValidIsNumber(L, 2, string_raycase_out4) && WraperUtil.ValidIsNumber(L, 3, string_raycase_out4) && WraperUtil.ValidIsNumber(L, 4, string_raycase_out4) && WraperUtil.ValidIsNumber(L, 5, string_raycase_out4) && WraperUtil.ValidIsNumber(L, 6, string_raycase_out4) && WraperUtil.ValidIsNumber(L, 7, string_raycase_out4) && WraperUtil.ValidIsNumber(L, 8, string_raycase_out4))
			{
				float x = (float)LuaDLL.lua_tonumber(L, 1);
				float y = (float)LuaDLL.lua_tonumber(L, 2);
				float z = (float)LuaDLL.lua_tonumber(L, 3);
				float x2 = (float)LuaDLL.lua_tonumber(L, 4);
				float y2 = (float)LuaDLL.lua_tonumber(L, 5);
				float z2 = (float)LuaDLL.lua_tonumber(L, 6);
				float maxDistance = (float)LuaDLL.lua_tonumber(L, 7);
				int layerMask = (int)LuaDLL.lua_tonumber(L, 8);
				RaycastHit hitInfo;
				bool flag = Physics.Raycast(new Vector3(x, y, z), new Vector3(x2, y2, z2), out hitInfo, maxDistance, layerMask);
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
		private static int raycase_all(IntPtr L)
		{
			int result = 0;
			if (WraperUtil.ValidIsNumber(L, 1, string_raycase_all) && WraperUtil.ValidIsNumber(L, 2, string_raycase_all) && WraperUtil.ValidIsNumber(L, 3, string_raycase_all) && WraperUtil.ValidIsNumber(L, 4, string_raycase_all) && WraperUtil.ValidIsNumber(L, 5, string_raycase_all) && WraperUtil.ValidIsNumber(L, 6, string_raycase_all) && WraperUtil.ValidIsNumber(L, 7, string_raycase_all) && WraperUtil.ValidIsNumber(L, 8, string_raycase_all))
			{
				float x = (float)LuaDLL.lua_tonumber(L, 1);
				float y = (float)LuaDLL.lua_tonumber(L, 2);
				float z = (float)LuaDLL.lua_tonumber(L, 3);
				float x2 = (float)LuaDLL.lua_tonumber(L, 4);
				float y2 = (float)LuaDLL.lua_tonumber(L, 5);
				float z2 = (float)LuaDLL.lua_tonumber(L, 6);
				float maxDistance = (float)LuaDLL.lua_tonumber(L, 7);
				int layermask = (int)LuaDLL.lua_tonumber(L, 8);
				RaycastHit[] hits = Physics.RaycastAll(new Vector3(x, y, z), new Vector3(x2, y2, z2), maxDistance, layermask);
				WraperUtil.Push(L, ref hits);
				result = 1;
			}
			return result;
		}

		[MonoPInvokeCallback(typeof(LuaCSFunction))]
		private static int raycase_out_screen(IntPtr L)
		{
			int result = 0;
			if (WraperUtil.ValidIsNumber(L, 1, string_raycase_out_screen) && WraperUtil.ValidIsNumber(L, 2, string_raycase_out_screen) && WraperUtil.ValidIsNumber(L, 3, string_raycase_out_screen) && WraperUtil.ValidIsNumber(L, 4, string_raycase_out_screen))
			{
				float x = (float)LuaDLL.lua_tonumber(L, 1);
				float y = (float)LuaDLL.lua_tonumber(L, 2);
				float maxDistance = (float)LuaDLL.lua_tonumber(L, 3);
				int layerMask = (int)LuaDLL.lua_tonumber(L, 4);
				Ray ray = Camera.main.ScreenPointToRay(new Vector3(x, y, 0f));
				RaycastHit hitInfo;
				bool flag = Physics.Raycast(ray, out hitInfo, maxDistance, layerMask);
				LuaDLL.lua_pushboolean(L, flag);
				if (flag)
				{
					LuaDLL.lua_pushnumber(L, hitInfo.point.x);
					LuaDLL.lua_pushnumber(L, hitInfo.point.y);
					LuaDLL.lua_pushnumber(L, hitInfo.point.z);
				}
				else
				{
					LuaDLL.lua_pushnil(L);
					LuaDLL.lua_pushnil(L);
					LuaDLL.lua_pushnil(L);
				}
				result = 4;
			}
			return result;
		}

		[MonoPInvokeCallback(typeof(LuaCSFunction))]
		private static int raycase_out_object(IntPtr L)
		{
			int result = 0;
			if (WraperUtil.ValidIsNumber(L, 1, string_raycase_out_object) && WraperUtil.ValidIsNumber(L, 2, string_raycase_out_object) && WraperUtil.ValidIsNumber(L, 3, string_raycase_out_object) && WraperUtil.ValidIsNumber(L, 4, string_raycase_out_object))
			{
				float x = (float)LuaDLL.lua_tonumber(L, 1);
				float y = (float)LuaDLL.lua_tonumber(L, 2);
				float maxDistance = (float)LuaDLL.lua_tonumber(L, 3);
				int layerMask = (int)LuaDLL.lua_tonumber(L, 4);
				if ((bool)Camera.main)
				{
					Ray ray = Camera.main.ScreenPointToRay(new Vector3(x, y, 0f));
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
				}
				else
				{
					LuaDLL.lua_pushboolean(L, false);
					LuaDLL.lua_pushnil(L);
				}
				result = 2;
			}
			return result;
		}

		[MonoPInvokeCallback(typeof(LuaCSFunction))]
		private static int overlap_sphere(IntPtr L)
		{
			int result = 0;
			if (WraperUtil.ValidIsNumber(L, 1, string_overlap_sphere) && WraperUtil.ValidIsNumber(L, 2, string_overlap_sphere) && WraperUtil.ValidIsNumber(L, 3, string_overlap_sphere) && WraperUtil.ValidIsNumber(L, 4, string_overlap_sphere) && WraperUtil.ValidIsNumber(L, 5, string_overlap_sphere))
			{
				m_ResultDic.Clear();
				float x = (float)LuaDLL.lua_tonumber(L, 1);
				float y = (float)LuaDLL.lua_tonumber(L, 2);
				float z = (float)LuaDLL.lua_tonumber(L, 3);
				float radius = (float)LuaDLL.lua_tonumber(L, 4);
				int layerMask = (int)LuaDLL.lua_tonumber(L, 5);
				m_OverLapSphereVector.x = x;
				m_OverLapSphereVector.y = y;
				m_OverLapSphereVector.z = z;
				Collider[] array = Physics.OverlapSphere(m_OverLapSphereVector, radius, layerMask);
				if (array.Length == 0)
				{
					LuaDLL.lua_pushnil(L);
					return 0;
				}
				int[] array2 = new int[array.Length];
				if (m_OverLapSphereBuff == null || m_OverLapSphereBuff.Length < array.Length)
				{
					int num = 1000;
					num = ((array.Length <= num) ? array.Length : num);
					m_OverLapSphereBuff = new BaseInterface[num];
				}
				int num2 = ((array.Length <= m_OverLapSphereBuff.Length) ? array.Length : m_OverLapSphereBuff.Length);
				for (int i = 0; i < num2; i++)
				{
					int instanceID = array[i].gameObject.GetInstanceID();
					if (!m_ResultDic.ContainsKey(instanceID))
					{
						m_ResultDic.Add(instanceID, null);
					}
				}
				WraperUtil.PushIntArray(L, m_ResultDic.Keys.ToArray());
				result = 1;
			}
			return result;
		}

		[MonoPInvokeCallback(typeof(LuaCSFunction))]
		private static int overlap_sphere_by_name(IntPtr L)
		{
			int result = 0;
			if (WraperUtil.ValidIsNumber(L, 1, string_overlap_sphere_by_name) && WraperUtil.ValidIsNumber(L, 2, string_overlap_sphere_by_name) && WraperUtil.ValidIsNumber(L, 3, string_overlap_sphere_by_name) && WraperUtil.ValidIsNumber(L, 4, string_overlap_sphere_by_name) && WraperUtil.ValidIsNumber(L, 5, string_overlap_sphere_by_name))
			{
				float x = (float)LuaDLL.lua_tonumber(L, 1);
				float y = (float)LuaDLL.lua_tonumber(L, 2);
				float z = (float)LuaDLL.lua_tonumber(L, 3);
				float radius = (float)LuaDLL.lua_tonumber(L, 4);
				int layerMask = (int)LuaDLL.lua_tonumber(L, 5);
				Collider[] array = Physics.OverlapSphere(new Vector3(x, y, z), radius, layerMask);
				if (array.Length > 0)
				{
					LuaDLL.lua_newtable(L);
					for (int i = 0; i < array.Length; i++)
					{
						LuaDLL.lua_pushstring(L, System.Convert.ToString(i + 1));
						LuaDLL.lua_pushstring(L, array[i].name);
						LuaDLL.lua_settable(L, -3);
					}
				}
				else
				{
					LuaDLL.lua_pushnil(L);
				}
				result = 1;
			}
			return result;
		}

		[MonoPInvokeCallback(typeof(LuaCSFunction))]
		private static int mathf_lerp(IntPtr L)
		{
			int result = 0;
			if (WraperUtil.ValidIsNumber(L, 1, string_mathf_lerp) && WraperUtil.ValidIsNumber(L, 2, string_mathf_lerp) && WraperUtil.ValidIsNumber(L, 3, string_mathf_lerp))
			{
				float a = (float)LuaDLL.lua_tonumber(L, 1);
				float b = (float)LuaDLL.lua_tonumber(L, 2);
				float t = (float)LuaDLL.lua_tonumber(L, 3);
				LuaDLL.lua_pushnumber(L, Mathf.Lerp(a, b, t));
				result = 1;
			}
			return result;
		}

		[MonoPInvokeCallback(typeof(LuaCSFunction))]
		private static int get_md5(IntPtr L)
		{
			int result = 0;
			if (WraperUtil.ValidIsString(L, 1, string_get_md5))
			{
				string toCryString = LuaDLL.lua_tostring(L, 1);
				toCryString = Utils.MD5(toCryString);
				LuaDLL.lua_pushstring(L, toCryString);
				result = 1;
			}
			return result;
		}

		[MonoPInvokeCallback(typeof(LuaCSFunction))]
		private static int get_file_md5(IntPtr L)
		{
			int result = 0;
			if (WraperUtil.ValidIsString(L, 1, string_get_file_md5))
			{
				string path = LuaDLL.lua_tostring(L, 1);
				string str = string.Empty;
				try
				{
					FileStream fileStream = new FileStream(path, FileMode.Open);
					MD5 mD = new MD5CryptoServiceProvider();
					byte[] array = mD.ComputeHash(fileStream);
					fileStream.Close();
					string text = BitConverter.ToString(array);
					str = text.Replace("-", string.Empty);
				}
				catch (Exception ex)
				{
					UnityEngine.Debug.LogError(ex.ToString());
				}
				LuaDLL.lua_pushstring(L, str);
				result = 1;
			}
			return result;
		}

		[MonoPInvokeCallback(typeof(LuaCSFunction))]
		private static int get_ngui_hovered_object(IntPtr L)
		{
			if (UICamera.isOverUI)
			{
				AssetGameObject base_object = AssetGameObject.CreateByInstance(UICamera.hoveredObject);
				WraperUtil.PushObject(L, base_object);
			}
			else
			{
				LuaDLL.lua_pushnil(L);
			}
			return 1;
		}

		[MonoPInvokeCallback(typeof(LuaCSFunction))]
		private static int get_navmesh_sampleposition(IntPtr L)
		{
			int result = 0;
			if (WraperUtil.ValidIsNumber(L, 1, string_get_navmesh_sampleposition) && WraperUtil.ValidIsNumber(L, 2, string_get_navmesh_sampleposition) && WraperUtil.ValidIsNumber(L, 3, string_get_navmesh_sampleposition) && WraperUtil.ValidIsNumber(L, 4, string_get_navmesh_sampleposition))
			{
				float x = (float)LuaDLL.lua_tonumber(L, 1);
				float y = (float)LuaDLL.lua_tonumber(L, 2);
				float z = (float)LuaDLL.lua_tonumber(L, 3);
				float maxDistance = (float)LuaDLL.lua_tonumber(L, 4);
				int areaMask = -1;
				if (LuaDLL.lua_isnumber(L, 5))
				{
					areaMask = (int)LuaDLL.lua_tonumber(L, 5);
				}
				Vector3 sourcePosition = new Vector3(x, y, z);
				NavMeshHit hit;
				bool value = NavMesh.SamplePosition(sourcePosition, out hit, maxDistance, areaMask);
				LuaDLL.lua_pushboolean(L, value);
				LuaDLL.lua_pushnumber(L, hit.position.x);
				LuaDLL.lua_pushnumber(L, hit.position.y);
				LuaDLL.lua_pushnumber(L, hit.position.z);
				result = 4;
			}
			return result;
		}

		[MonoPInvokeCallback(typeof(LuaCSFunction))]
		private static int chang_role_s3d_material(IntPtr L)
		{
			int result = 0;
			if (WraperUtil.ValidIsUserdata(L, 1, string_chang_role_s3d_material) && WraperUtil.ValidIsString(L, 2, string_chang_role_s3d_material) && WraperUtil.ValidIsUserdata(L, 3, string_chang_role_s3d_material))
			{
				AssetGameObject assetGameObject = null;
				TextureWrap textureWrap = null;
				string empty = string.Empty;
				assetGameObject = WraperUtil.LuaToUserdata(L, 1, string.Empty, AssetGameObject.cache);
				if (assetGameObject.gameObject != null)
				{
					empty = LuaDLL.lua_tostring(L, 2);
					textureWrap = WraperUtil.LuaToUserdata(L, 3, string.Empty, TextureWrap.cache);
					Material material = assetGameObject.gameObject.GetComponent<SkinnedMeshRenderer>().material;
					if (material != null)
					{
						material.SetTexture(empty, textureWrap.component);
					}
				}
			}
			return result;
		}

		[MonoPInvokeCallback(typeof(LuaCSFunction))]
		private static int begin_sample(IntPtr L)
		{
			int result = 0;
			if (WraperUtil.ValidIsString(L, 1, string_begin_sample))
			{
				string text = LuaDLL.lua_tostring(L, 1);
			}
			return result;
		}

		[MonoPInvokeCallback(typeof(LuaCSFunction))]
		private static int end_sample(IntPtr L)
		{
			return 0;
		}

		[MonoPInvokeCallback(typeof(LuaCSFunction))]
		private static int get_devicemodel(IntPtr L)
		{
			string empty = string.Empty;
			empty = SystemInfo.deviceModel;
			LuaDLL.lua_pushstring(L, empty);
			return 1;
		}

		[MonoPInvokeCallback(typeof(LuaCSFunction))]
		private static int get_deviceuniqueidentifier(IntPtr L)
		{
			string empty = string.Empty;
			empty = SystemInfo.deviceUniqueIdentifier;
			LuaDLL.lua_pushstring(L, empty);
			return 1;
		}

		[MonoPInvokeCallback(typeof(LuaCSFunction))]
		private static int get_click(IntPtr L)
		{
			int result = 1;
			bool flag = false;
			float num = 0f;
			float num2 = 0f;
			if (Input.touchCount > 0)
			{
				Touch touch = Input.GetTouch(0);
				if (touch.phase == TouchPhase.Ended)
				{
					flag = true;
					num = touch.position.x;
					num2 = touch.position.y;
				}
			}
			LuaDLL.lua_pushboolean(L, flag);
			if (flag)
			{
				result = 3;
				LuaDLL.lua_pushnumber(L, num);
				LuaDLL.lua_pushnumber(L, num2);
			}
			return result;
		}

		[MonoPInvokeCallback(typeof(LuaCSFunction))]
		private static int draw_line(IntPtr L)
		{
			int result = 0;
			if (WraperUtil.ValidIsNumber(L, 1, string_draw_line) && WraperUtil.ValidIsNumber(L, 2, string_draw_line) && WraperUtil.ValidIsNumber(L, 3, string_draw_line) && WraperUtil.ValidIsNumber(L, 4, string_draw_line) && WraperUtil.ValidIsNumber(L, 5, string_draw_line) && WraperUtil.ValidIsNumber(L, 6, string_draw_line))
			{
				float x = (float)LuaDLL.lua_tonumber(L, 1);
				float y = (float)LuaDLL.lua_tonumber(L, 2);
				float z = (float)LuaDLL.lua_tonumber(L, 3);
				float x2 = (float)LuaDLL.lua_tonumber(L, 4);
				float y2 = (float)LuaDLL.lua_tonumber(L, 5);
				float z2 = (float)LuaDLL.lua_tonumber(L, 6);
				float r = 1f;
				float g = 0f;
				float b = 0f;
				if (LuaDLL.lua_isnumber(L, 7) && LuaDLL.lua_isnumber(L, 8) && LuaDLL.lua_isnumber(L, 9))
				{
					r = (float)LuaDLL.lua_tonumber(L, 7);
					g = (float)LuaDLL.lua_tonumber(L, 8);
					b = (float)LuaDLL.lua_tonumber(L, 9);
				}
				UnityEngine.Debug.DrawLine(new Vector3(x, y, z), new Vector3(x2, y2, z2), new Color(r, g, b, 1f));
			}
			return result;
		}

		[MonoPInvokeCallback(typeof(LuaCSFunction))]
		private static int start_installer(IntPtr L)
		{
			int result = 1;
			if (WraperUtil.ValidIsString(L, 1, string_start_installer))
			{
				string path = LuaDLL.lua_tostring(L, 1);
				int num = Installer.Instance().StartInstaller(path);
				LuaDLL.lua_pushnumber(L, num);
			}
			return result;
		}

		[MonoPInvokeCallback(typeof(LuaCSFunction))]
		private static int android_log(IntPtr L)
		{
			int result = 0;
			if (WraperUtil.ValidIsString(L, 1, string_android_log))
			{
				string path = LuaDLL.lua_tostring(L, 1);
				Installer.Instance().AndroidLog(path);
			}
			return result;
		}

		[MonoPInvokeCallback(typeof(LuaCSFunction))]
		private static int quit(IntPtr L)
		{
			int result = 0;
			Application.Quit();
			return result;
		}

		[MonoPInvokeCallback(typeof(LuaCSFunction))]
		private static int download_file(IntPtr L)
		{
			int result = 0;
			if (WraperUtil.ValidIsString(L, 1, string_download_file) && WraperUtil.ValidIsString(L, 2, string_download_file) && WraperUtil.ValidIsString(L, 3, string_download_file) && WraperUtil.ValidIsString(L, 4, string_download_file))
			{
				string url = LuaDLL.lua_tostring(L, 1);
				string saveFile = LuaDLL.lua_tostring(L, 2);
				string progressCallback = LuaDLL.lua_tostring(L, 3);
				string retCallback = LuaDLL.lua_tostring(L, 4);
				Installer.Instance().DownLoadFile(url, saveFile, progressCallback, retCallback);
			}
			return result;
		}

		[MonoPInvokeCallback(typeof(LuaCSFunction))]
		private static int get_version_code(IntPtr L)
		{
			int result = 1;
			LuaDLL.lua_pushnumber(L, Installer.Instance().GetVersionCode());
			return result;
		}

		[MonoPInvokeCallback(typeof(LuaCSFunction))]
		private static int get_package_name(IntPtr L)
		{
			int result = 1;
			LuaDLL.lua_pushstring(L, Installer.Instance().GetPackageName());
			return result;
		}

		[MonoPInvokeCallback(typeof(LuaCSFunction))]
		private static int get_signature_hash_code(IntPtr L)
		{
			int result = 1;
			LuaDLL.lua_pushnumber(L, Installer.Instance().GetSignatureHashCode());
			return result;
		}

		[MonoPInvokeCallback(typeof(LuaCSFunction))]
		private static int get_write_dir(IntPtr L)
		{
			int result = 1;
			if (WraperUtil.ValidIsString(L, 1, string_get_write_dir))
			{
				string filepath = LuaDLL.lua_tostring(L, 1);
				string writePath = FileUtil.GetWritePath(filepath);
				LuaDLL.lua_pushstring(L, writePath);
			}
			return result;
		}

		[MonoPInvokeCallback(typeof(LuaCSFunction))]
		private static int click_back_key(IntPtr L)
		{
			int result = 1;
			if (Input.GetKeyDown(KeyCode.Escape))
			{
				LuaDLL.lua_pushboolean(L, true);
			}
			else
			{
				LuaDLL.lua_pushboolean(L, false);
			}
			return result;
		}

		[MonoPInvokeCallback(typeof(LuaCSFunction))]
		private static int sleep_timeout(IntPtr L)
		{
			int result = 0;
			if (WraperUtil.ValidIsNumber(L, 1, string_sleep_timeout))
			{
				int num = -1;
				if (LuaDLL.lua_isnumber(L, 1))
				{
					num = (int)LuaDLL.lua_tonumber(L, 1);
				}
				if (num == -1)
				{
					Screen.sleepTimeout = -1;
				}
				else
				{
					Screen.sleepTimeout = num;
				}
			}
			return result;
		}

		[MonoPInvokeCallback(typeof(LuaCSFunction))]
		private static int set_error_url(IntPtr L)
		{
			int result = 0;
			if (WraperUtil.ValidIsString(L, 1, string_set_error_url))
			{
				string text = LuaDLL.lua_tostring(L, 1);
				if (text != string.Empty)
				{
					Core.Unity.Debug.httppost_url = text;
				}
			}
			return result;
		}

		[MonoPInvokeCallback(typeof(LuaCSFunction))]
		private static int push_web_info(IntPtr L)
		{
			int result = 0;
			Dictionary<string, string> dictionary = new Dictionary<string, string>();
			if (WraperUtil.ValidIsString(L, 1, string_push_web_info) && WraperUtil.ValidIsString(L, 2, string_push_web_info))
			{
				string value = LuaDLL.lua_tostring(L, 1);
				string value2 = LuaDLL.lua_tostring(L, 2);
				dictionary = Core.Unity.Debug.get_necessary_info();
				dictionary.Add("info", value2);
				dictionary.Add("info_type", value);
				Core.Unity.Debug.push_web_info("need", dictionary);
			}
			return result;
		}

		[MonoPInvokeCallback(typeof(LuaCSFunction))]
		private static int is_write_file(IntPtr L)
		{
			int result = 0;
			if (WraperUtil.ValidIsBoolean(L, 1, string_is_write_file))
			{
				bool bFile = LuaDLL.lua_toboolean(L, 1);
				Core.Unity.Debug.bFile = bFile;
			}
			return result;
		}

		[MonoPInvokeCallback(typeof(LuaCSFunction))]
		private static int is_web_post(IntPtr L)
		{
			int result = 0;
			if (WraperUtil.ValidIsBoolean(L, 1, string_is_web_post))
			{
				bool bWebPost = LuaDLL.lua_toboolean(L, 1);
				Core.Unity.Debug.bWebPost = bWebPost;
			}
			return result;
		}

		[MonoPInvokeCallback(typeof(LuaCSFunction))]
		private static int is_debug_show(IntPtr L)
		{
			int result = 0;
			if (WraperUtil.ValidIsBoolean(L, 1, string_is_debug_show))
			{
				bool bDebug = LuaDLL.lua_toboolean(L, 1);
				Core.Unity.Debug.bDebug = bDebug;
			}
			return result;
		}

		[MonoPInvokeCallback(typeof(LuaCSFunction))]
		private static int is_debug_check(IntPtr L)
		{
			int result = 0;
			if (WraperUtil.ValidIsBoolean(L, 1, string_is_debug_check))
			{
				Core.Unity.Debug.IsCheckOpenLog = (Core.Unity.Debug.IsCheckOpenDebug = LuaDLL.lua_toboolean(L, 1));
			}
			return result;
		}

		[MonoPInvokeCallback(typeof(LuaCSFunction))]
		private static int is_effect_console_enable(IntPtr L)
		{
			int result = 0;
			if (WraperUtil.ValidIsBoolean(L, 1, string_is_effect_console_enable))
			{
				bool showFPS = LuaDLL.lua_toboolean(L, 1);
				GhoulAfterEffectsConsole.showFPS = showFPS;
			}
			return result;
		}

		[MonoPInvokeCallback(typeof(LuaCSFunction))]
		private static int bind_service(IntPtr L)
		{
			int result = 0;
			if (WraperUtil.ValidIsNumber(L, 1, string_bind_service))
			{
				int time = (int)LuaDLL.lua_tonumber(L, 1);
				Utils.BindService(time);
			}
			return result;
		}

		[MonoPInvokeCallback(typeof(LuaCSFunction))]
		private static int un_bind_service(IntPtr L)
		{
			int result = 0;
			Utils.UnBindService();
			return result;
		}

		[MonoPInvokeCallback(typeof(LuaCSFunction))]
		private static int capture_screenshot(IntPtr L)
		{
			int result = 0;
			if (WraperUtil.ValidIsString(L, 1, string_capture_screenshot) && WraperUtil.ValidIsString(L, 2, string_capture_screenshot) && WraperUtil.ValidIsNumber(L, 3, string_capture_screenshot))
			{
				string empty = string.Empty;
				string empty2 = string.Empty;
				int num = -1;
				empty = LuaDLL.lua_tostring(L, 1);
				empty2 = LuaDLL.lua_tostring(L, 2);
				num = LuaDLL.lua_tointeger(L, 3);
				LuaDLL.lua_pushboolean(L, App3.GetScreedCaptureInstance().StartCapture(empty, empty2, num));
				result = 1;
			}
			return result;
		}

		[MonoPInvokeCallback(typeof(LuaCSFunction))]
		private static int download2file(IntPtr L)
		{
			int result = 0;
			if (WraperUtil.ValidIsString(L, 1, string_download2file) && WraperUtil.ValidIsString(L, 2, string_download2file) && WraperUtil.ValidIsString(L, 3, string_download2file) && WraperUtil.ValidIsString(L, 4, string_download2file) && WraperUtil.ValidIsString(L, 5, string_download2file) && WraperUtil.ValidIsString(L, 6, string_download2file))
			{
				string url = LuaDLL.lua_tostring(L, 1);
				string saveFile = LuaDLL.lua_tostring(L, 2);
				string progressCallback = LuaDLL.lua_tostring(L, 3);
				string errorCallBack = LuaDLL.lua_tostring(L, 4);
				string succCallback = LuaDLL.lua_tostring(L, 5);
				string redirectCallback = LuaDLL.lua_tostring(L, 6);
				bool value = SimpleHttpManager.GetInstance().DownLoadFile(url, saveFile, progressCallback, succCallback, errorCallBack, redirectCallback);
				LuaDLL.lua_pushboolean(L, value);
				result = 1;
			}
			return result;
		}

		[MonoPInvokeCallback(typeof(LuaCSFunction))]
		private static int set_effect_quality_level(IntPtr L)
		{
			int result = 0;
			if (WraperUtil.ValidIsNumber(L, 1, string_set_effect_quality_level))
			{
				int fxQualityLevel = (int)LuaDLL.lua_tonumber(L, 1);
				AppConfig.SetFxQualityLevel(fxQualityLevel);
			}
			return result;
		}

		[MonoPInvokeCallback(typeof(LuaCSFunction))]
		private static int set_quality_setting(IntPtr L)
		{
			int result = 0;
			if (WraperUtil.ValidIsNumber(L, 1, string_set_quality_setting) && WraperUtil.ValidIsBoolean(L, 2, string_set_quality_setting))
			{
				int index = (int)LuaDLL.lua_tonumber(L, 1);
				bool applyExpensiveChanges = LuaDLL.lua_toboolean(L, 2);
				QualitySettings.SetQualityLevel(index, applyExpensiveChanges);
			}
			return result;
		}

		[MonoPInvokeCallback(typeof(LuaCSFunction))]
		private static int set_all_widget_color(IntPtr L)
		{
			int result = 0;
			if (WraperUtil.ValidIsUserdata(L, 1, string_set_all_widget_color) && WraperUtil.ValidIsBoolean(L, 2, string_set_all_widget_color) && WraperUtil.ValidIsBoolean(L, 3, string_set_all_widget_color) && WraperUtil.ValidIsNumber(L, 4, string_set_all_widget_color) && WraperUtil.ValidIsNumber(L, 5, string_set_all_widget_color) && WraperUtil.ValidIsNumber(L, 6, string_set_all_widget_color) && WraperUtil.ValidIsNumber(L, 7, string_set_all_widget_color))
			{
				AssetGameObject assetGameObject = WraperUtil.LuaToUserdata(L, 1, string_set_all_widget_color, AssetGameObject.cache);
				bool includeInactive = WraperUtil.ValidIsBoolean(L, 2, string_set_all_widget_color);
				bool flag = WraperUtil.ValidIsBoolean(L, 3, string_set_all_widget_color);
				float r = (float)LuaDLL.lua_tonumber(L, 4);
				float g = (float)LuaDLL.lua_tonumber(L, 5);
				float b = (float)LuaDLL.lua_tonumber(L, 6);
				float a = (float)LuaDLL.lua_tonumber(L, 7);
				UIWidget[] componentsInChildren = assetGameObject.gameObject.GetComponentsInChildren<UIWidget>(includeInactive);
				if (componentsInChildren != null && componentsInChildren.Length > 0)
				{
					for (int i = 0; i < componentsInChildren.Length; i++)
					{
						if (!flag || componentsInChildren[i].GetType() != typeof(UILabel))
						{
							componentsInChildren[i].color = new Color(r, g, b, a);
						}
					}
				}
			}
			return result;
		}

		[MonoPInvokeCallback(typeof(LuaCSFunction))]
		private static int enable_ui_node_gray_color(IntPtr L)
		{
			int result = 0;
			if (WraperUtil.ValidIsUserdata(L, 1, string_enable_ui_node_gray_color) && WraperUtil.ValidIsBoolean(L, 2, string_enable_ui_node_gray_color))
			{
				AssetGameObject assetGameObject = WraperUtil.LuaToUserdata(L, 1, string_enable_ui_node_gray_color, AssetGameObject.cache);
				bool enable = LuaDLL.lua_toboolean(L, 2);
				_foreach_ui_transform(assetGameObject.transform, enable);
			}
			return result;
		}

		[MonoPInvokeCallback(typeof(LuaCSFunction))]
		private static int media_player_init(IntPtr L)
		{
			int result = 0;
			SimpleMediaPlayer.getInstance().Init();
			return result;
		}

		[MonoPInvokeCallback(typeof(LuaCSFunction))]
		private static int media_player_play(IntPtr L)
		{
			int result = 0;
			if (WraperUtil.ValidIsBoolean(L, 1, string_media_player_play) && WraperUtil.ValidIsLString(L, 2, string_media_player_play) && WraperUtil.ValidIsLString(L, 3, string_media_player_play) && WraperUtil.ValidIsLString(L, 4, string_media_player_play))
			{
				bool playDirectly = LuaDLL.lua_toboolean(L, 1);
				string fileName = LuaDLL.lua_tostring(L, 2);
				string onFinishCallback = LuaDLL.lua_tostring(L, 3);
				string onFailedCallback = LuaDLL.lua_tostring(L, 4);
				string onFirstFrameReadyCallback = string.Empty;
				bool pauseOnFirstFrameReady = false;
				bool showSkipBtn = false;
				string skipBtFileName = string.Empty;
				int skipBtnPosX = 20;
				int skipBtnPosY = 20;
				int num = LuaDLL.lua_gettop(L);
				if (num > 4)
				{
					if (!WraperUtil.ValidIsLString(L, 5, string_media_player_play) || !WraperUtil.ValidIsBoolean(L, 6, string_media_player_play))
					{
						goto IL_0196;
					}
					onFirstFrameReadyCallback = LuaDLL.lua_tostring(L, 5);
					pauseOnFirstFrameReady = LuaDLL.lua_toboolean(L, 6);
				}
				if (num > 6)
				{
					if (!WraperUtil.ValidIsBoolean(L, 7, string_media_player_play) || !WraperUtil.ValidIsString(L, 8, string_media_player_play) || !WraperUtil.ValidIsNumber(L, 9, string_media_player_play) || !WraperUtil.ValidIsNumber(L, 10, string_media_player_play))
					{
						goto IL_0196;
					}
					showSkipBtn = LuaDLL.lua_toboolean(L, 7);
					skipBtFileName = LuaDLL.lua_tostring(L, 8);
					skipBtnPosX = (int)LuaDLL.lua_tonumber(L, 9);
					skipBtnPosY = (int)LuaDLL.lua_tonumber(L, 10);
				}
				bool value = SimpleMediaPlayer.getInstance().Play(playDirectly, fileName, onFinishCallback, onFailedCallback, onFirstFrameReadyCallback, pauseOnFirstFrameReady, showSkipBtn, skipBtFileName, skipBtnPosX, skipBtnPosY);
				LuaDLL.lua_pushboolean(L, value);
				result = 1;
			}
			goto IL_0196;
			IL_0196:
			return result;
		}

		[MonoPInvokeCallback(typeof(LuaCSFunction))]
		private static int media_player_destory(IntPtr L)
		{
			SimpleMediaPlayer.getInstance().Destory();
			return 0;
		}

		[MonoPInvokeCallback(typeof(LuaCSFunction))]
		private static int audio_set_sample_rate(IntPtr L)
		{
			int result = 1;
			if (WraperUtil.ValidIsNumber(L, 1, string_audio_set_sample_rate))
			{
				int num = LuaDLL.lua_tointeger(L, 1);
				AudioConfiguration configuration = AudioSettings.GetConfiguration();
				if (configuration.sampleRate != num && num >= 0 && num < 50000)
				{
					configuration.sampleRate = num;
					AudioSettings.Reset(configuration);
					LuaDLL.lua_pushboolean(L, true);
					return result;
				}
			}
			LuaDLL.lua_pushboolean(L, false);
			return result;
		}

		[MonoPInvokeCallback(typeof(LuaCSFunction))]
		private static int media_player_resume(IntPtr L)
		{
			int result = 0;
			SimpleMediaPlayer.getInstance().Resume();
			return result;
		}

		private static void _foreach_ui_transform(Transform parent, bool enable)
		{
			foreach (Transform item in parent)
			{
				UITexture component = item.GetComponent<UITexture>();
				if (component != null)
				{
					if (enable)
					{
						component.color = new Color(0f, 0f, 0f, 1f);
					}
					else
					{
						component.color = new Color(1f, 1f, 1f, 1f);
					}
					if (item.childCount > 0)
					{
						_foreach_ui_transform(item, enable);
					}
					continue;
				}
				UISprite component2 = item.GetComponent<UISprite>();
				if (component2 != null)
				{
					if (enable)
					{
						component2.color = new Color(0f, 0f, 0f, 1f);
					}
					else
					{
						component2.color = new Color(1f, 1f, 1f, 1f);
					}
					if (item.childCount > 0)
					{
						_foreach_ui_transform(item, enable);
					}
				}
				else if (item.childCount > 0)
				{
					_foreach_ui_transform(item, enable);
				}
			}
		}

		[MonoPInvokeCallback(typeof(LuaCSFunction))]
		private static int uwa_push_sample(IntPtr L)
		{
			int result = 0;
			if (WraperUtil.ValidIsString(L, 1, string_uwa_push_sample))
			{
				string text = LuaDLL.lua_tostring(L, 1);
			}
			return result;
		}

		[MonoPInvokeCallback(typeof(LuaCSFunction))]
		private static int uwa_pop_sample(IntPtr L)
		{
			return 0;
		}

		[MonoPInvokeCallback(typeof(LuaCSFunction))]
		private static int temp_tween_alpha_replay_forward(IntPtr L)
		{
			int result = 0;
			if (WraperUtil.ValidIsUserdata(L, 1, string_temp_tween_alpha_replay_forward))
			{
				AssetGameObject assetGameObject = WraperUtil.LuaToUserdata(L, 1, string_temp_tween_alpha_replay_forward, AssetGameObject.cache);
				if (assetGameObject != null)
				{
					TweenAlpha component = assetGameObject.gameObject.GetComponent<TweenAlpha>();
					if (component != null)
					{
						component.ResetToBeginning();
						component.PlayForward();
					}
				}
			}
			return result;
		}

		[MonoPInvokeCallback(typeof(LuaCSFunction))]
		private static int get_readonly_path(IntPtr L)
		{
			int result = 1;
			if (WraperUtil.ValidIsString(L, 1, string_get_readonly_path))
			{
				string filepath = LuaDLL.lua_tostring(L, 1);
				LuaDLL.lua_pushstring(L, FileUtil.GetReadOnlyPath(filepath));
			}
			return result;
		}

		[MonoPInvokeCallback(typeof(LuaCSFunction))]
		private static int unload_unused_assets(IntPtr L)
		{
			int result = 0;
			UtilWraper.GetInstance().AsyncUnloadUnusedAssets();
			return result;
		}

		[MonoPInvokeCallback(typeof(LuaCSFunction))]
		private static int refresh_all_panel(IntPtr L)
		{
			int result = 0;
			UtilWraper.GetInstance().AsyncRefreshAllPanel();
			return result;
		}

		[MonoPInvokeCallback(typeof(LuaCSFunction))]
		private static int camera_layer_bug_fix(IntPtr L)
		{
			int result = 0;
			if (WraperUtil.ValidIsBoolean(L, 1, string_is_web_post))
			{
				bool isOpen = LuaDLL.lua_toboolean(L, 1);
				CheckCamera.isOpen = isOpen;
			}
			return result;
		}

		[MonoPInvokeCallback(typeof(LuaCSFunction))]
		private static int enable_protol_test(IntPtr L)
		{
			int result = 0;
			ProtolTestServer.GetInst().Begin();
			return result;
		}
	}
}
