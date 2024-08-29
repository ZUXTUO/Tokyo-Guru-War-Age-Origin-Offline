using System;
using Core.Unity;
using LuaInterface;
using UnityEngine;

namespace Wraper
{
	public class app_wraper
	{
		public static string libname = "app";

		private static luaL_Reg[] libfunc = new luaL_Reg[47]
		{
			new luaL_Reg("clean_cache", clean_cache),
			new luaL_Reg("set_max_diskspace", set_max_diskspace),
			new luaL_Reg("set_lua_version", set_lua_version),
			new luaL_Reg("set_asst_path_shareof", set_asst_path_shareof),
			new luaL_Reg("set_log_level", set_log_level),
			new luaL_Reg("set_log_open_flag", set_log_open_flag),
			new luaL_Reg("log", log),
			new luaL_Reg("log_warning", log_warning),
			new luaL_Reg("log_error", log_error),
			new luaL_Reg("set_on_update", set_on_update),
			new luaL_Reg("set_on_fixed_update", set_on_fixed_update),
			new luaL_Reg("set_on_late_update", set_on_late_update),
			new luaL_Reg("get_real_tick", get_real_tick),
			new luaL_Reg("get_time", get_time),
			new luaL_Reg("get_delta_time", get_delta_time),
			new luaL_Reg("get_real_time", get_real_time),
			new luaL_Reg("get_real_delta_time", get_real_delta_time),
			new luaL_Reg("set_time_scale", set_time_scale),
			new luaL_Reg("get_time_scale", get_time_scale),
			new luaL_Reg("set_frame_rate", set_frame_rate),
			new luaL_Reg("set_gc_time", set_gc_time),
			new luaL_Reg("get_screen_width", get_screen_width),
			new luaL_Reg("get_screen_height", get_screen_height),
			new luaL_Reg("reset_lua", reset_lua),
			new luaL_Reg("get_touch_screen_keyboard_area", get_touch_screen_keyboard_area),
			new luaL_Reg("get_touch_screen_keyboard_visible", get_touch_screen_keyboard_visible),
			new luaL_Reg("on_sanalyze_event", on_sanalyze_event),
			new luaL_Reg("get_device_info_by_key", get_device_info_by_key),
			new luaL_Reg("open_url", open_url),
			new luaL_Reg("opt_enable_net_dispatch", opt_enable_net_dispatch),
			new luaL_Reg("add_net_cache_ignore_msg", add_net_cache_ignore_msg),
			new luaL_Reg("set_on_application_pause_call", set_on_application_pause_call),
			new luaL_Reg("set_on_application_loop_call", set_on_application_loop_call),
			new luaL_Reg("set_pause_loop_call_timeout", set_pause_loop_call_timeout),
			new luaL_Reg("kill_curr_process", kill_curr_process),
			new luaL_Reg("close_background_thead", close_background_thead),
			new luaL_Reg("get_os_type", get_os_type),
			new luaL_Reg("get_internet_reach_ability", get_internet_reach_ability),
			new luaL_Reg("install_apk", install_apk),
			new luaL_Reg("set_texture_quality", set_texture_quality),
			new luaL_Reg("set_quality_level", set_quality_level),
			new luaL_Reg("get_quality_level", get_quality_level),
			new luaL_Reg("get_quality_count", get_quality_count),
			new luaL_Reg("get_frame_count", get_frame_count),
			new luaL_Reg("get_real_since_time", get_real_since_time),
			new luaL_Reg("write_script_recording", write_script_recording),
			new luaL_Reg("reload_shader", reload_shader)
		};

		private static string string_clean_cache = "app.clean_cache";

		private static string string_set_max_diskspace = "app.set_max_diskspace";

		private static string string_set_lua_version = "app.set_lua_version";

		private static string string_set_asst_path_shareof = "app.set_asst_path_shareof";

		private static string string_set_log_level = "app.set_log_level";

		private static string string_set_log_open_flag = "app.set_log_open_flag";

		private static string string_log = "app.log";

		private static string string_log_warning = "app.log_warning";

		private static string string_log_error = "app.log_error";

		private static string string_set_on_update = "app.set_on_update";

		private static string string_set_on_fixed_update = "app.set_on_fixed_update";

		private static string string_set_on_late_update = "app.set_on_late_update";

		private static string string_set_time_scale = "app.set_time_scale";

		private static string string_set_frame_rate = "app.set_frame_rate";

		private static string string_set_gc_time = "app.set_gc_time";

		private static string string_on_sanalyze_event = "app.on_sanalyze_event";

		private static string string_get_device_info_by_key = "app.get_device_info_by_key";

		private static string string_opt_enable_net_dispatch = "app.opt_enable_net_dispatch";

		private static string string_add_net_cache_ignore_msg = "app.add_net_cache_ignore_msg";

		private static string string_set_on_application_pause_call = "app.set_on_application_pause_call";

		private static string string_set_on_application_loop_call = "app.set_on_application_loop_call";

		private static string string_set_pause_loop_call_timeout = "app.set_pause_loop_call_timeout";

		private static string string_kill_curr_process = "app.kill_curr_process";

		private static string string_close_background_thead = "app.close_background_thead";

		private static string string_open_url = "app.open_url";

		private static string string_install_apk = "app.install_apk";

		private static string string_set_texture_quality = "app.set_texture_quality";

		private static string string_set_quality_level = "app.set_quality_level";

		private static string string_get_frame_count = "app.get_frame_count";

		private static string string_write_script_recording = "app.write_script_recording";

		private static string string_reload_shader = "app.reload_shader";

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
		private static int clean_cache(IntPtr L)
		{
			int result = 0;
			Caching.CleanCache();
			return result;
		}

		[MonoPInvokeCallback(typeof(LuaCSFunction))]
		private static int set_max_diskspace(IntPtr L)
		{
			int result = 0;
			if (WraperUtil.ValidIsNumber(L, 1, string_set_lua_version))
			{
				int num = 50;
				num = (int)LuaDLL.lua_tonumber(L, 1);
				App3.GetInstance().Set_Max_Disk_Space(num);
				result = 0;
			}
			return result;
		}

		[MonoPInvokeCallback(typeof(LuaCSFunction))]
		private static int set_lua_version(IntPtr L)
		{
			int result = 0;
			if (WraperUtil.ValidIsLString(L, 1, string_set_lua_version))
			{
				string empty = string.Empty;
				empty = LuaDLL.lua_tostring(L, 1);
				App3.GetInstance().Set_Lua_Version(empty);
				result = 0;
			}
			return result;
		}

		[MonoPInvokeCallback(typeof(LuaCSFunction))]
		private static int set_asst_path_shareof(IntPtr L)
		{
			int result = 0;
			if (WraperUtil.ValidIsLString(L, 1, string_set_lua_version))
			{
				string empty = string.Empty;
				empty = LuaDLL.lua_tostring(L, 1);
				App3.GetInstance().Set_asst_path_shareof(empty);
				result = 0;
			}
			return result;
		}

		[MonoPInvokeCallback(typeof(LuaCSFunction))]
		private static int set_log_level(IntPtr L)
		{
			int result = 0;
			if (WraperUtil.ValidIsNumber(L, 1, string_set_log_level))
			{
				int num = 0;
				num = (int)LuaDLL.lua_tonumber(L, 1);
				Core.Unity.Debug.logType = (Core.Unity.Debug.LogLevel)num;
				result = 0;
			}
			return result;
		}

		[MonoPInvokeCallback(typeof(LuaCSFunction))]
		private static int set_log_open_flag(IntPtr L)
		{
			int result = 0;
			if (WraperUtil.ValidIsNumber(L, 1, string_set_log_open_flag))
			{
				int num = 0;
				num = (int)LuaDLL.lua_tonumber(L, 1);
				Core.Unity.Debug.logOpen = (Core.Unity.Debug.LogOpen)num;
				result = 0;
			}
			return result;
		}

		[MonoPInvokeCallback(typeof(LuaCSFunction))]
		private static int log(IntPtr L)
		{
			int result = 0;
			if (WraperUtil.ValidIsString(L, 1, string_log))
			{
				string text = null;
				text = LuaDLL.lua_tostring(L, 1);
				Core.Unity.Debug.Log(text, Core.Unity.Debug.LogLevel.Lua);
				result = 0;
			}
			return result;
		}

		[MonoPInvokeCallback(typeof(LuaCSFunction))]
		private static int log_warning(IntPtr L)
		{
			int result = 0;
			if (WraperUtil.ValidIsString(L, 1, string_log_warning))
			{
				string text = null;
				text = LuaDLL.lua_tostring(L, 1);
				Core.Unity.Debug.LogWarning(text);
				result = 0;
			}
			return result;
		}

		[MonoPInvokeCallback(typeof(LuaCSFunction))]
		private static int log_error(IntPtr L)
		{
			int result = 0;
			if (WraperUtil.ValidIsString(L, 1, string_log_error))
			{
				string text = null;
				text = LuaDLL.lua_tostring(L, 1);
				Core.Unity.Debug.LogError(text);
				result = 0;
			}
			return result;
		}

		[MonoPInvokeCallback(typeof(LuaCSFunction))]
		private static int set_on_update(IntPtr L)
		{
			int result = 0;
			if (WraperUtil.ValidIsString(L, 1, string_set_on_update))
			{
				string text = null;
				text = LuaDLL.lua_tostring(L, 1);
				App3.GetInstance().onUpdate = text;
				result = 0;
			}
			return result;
		}

		[MonoPInvokeCallback(typeof(LuaCSFunction))]
		private static int set_on_fixed_update(IntPtr L)
		{
			int result = 0;
			if (WraperUtil.ValidIsString(L, 1, string_set_on_fixed_update))
			{
				string text = null;
				text = LuaDLL.lua_tostring(L, 1);
				App3.GetInstance().onFixedUpdate = text;
				result = 0;
			}
			return result;
		}

		[MonoPInvokeCallback(typeof(LuaCSFunction))]
		private static int set_on_late_update(IntPtr L)
		{
			int result = 0;
			if (WraperUtil.ValidIsString(L, 1, string_set_on_late_update))
			{
				string text = null;
				text = LuaDLL.lua_tostring(L, 1);
				App3.GetInstance().onLateUpdate = text;
				result = 0;
			}
			return result;
		}

		[MonoPInvokeCallback(typeof(LuaCSFunction))]
		private static int get_real_tick(IntPtr L)
		{
			int num = 0;
			LuaDLL.lua_pushnumber(L, DateTime.Now.Ticks / 10000);
			return 1;
		}

		[MonoPInvokeCallback(typeof(LuaCSFunction))]
		private static int get_time(IntPtr L)
		{
			int num = 0;
			LuaDLL.lua_pushnumber(L, Time.time);
			return 1;
		}

		[MonoPInvokeCallback(typeof(LuaCSFunction))]
		private static int get_delta_time(IntPtr L)
		{
			int num = 0;
			LuaDLL.lua_pushnumber(L, Time.deltaTime);
			return 1;
		}

		[MonoPInvokeCallback(typeof(LuaCSFunction))]
		private static int get_real_time(IntPtr L)
		{
			int num = 0;
			LuaDLL.lua_pushnumber(L, RealTime.time);
			return 1;
		}

		[MonoPInvokeCallback(typeof(LuaCSFunction))]
		private static int get_real_delta_time(IntPtr L)
		{
			int num = 0;
			LuaDLL.lua_pushnumber(L, RealTime.deltaTime);
			return 1;
		}

		[MonoPInvokeCallback(typeof(LuaCSFunction))]
		private static int set_time_scale(IntPtr L)
		{
			int result = 0;
			if (WraperUtil.ValidIsNumber(L, 1, string_set_time_scale))
			{
				float num = 0f;
				num = (float)LuaDLL.lua_tonumber(L, 1);
				Time.timeScale = num;
				result = 0;
			}
			return result;
		}

		[MonoPInvokeCallback(typeof(LuaCSFunction))]
		private static int get_time_scale(IntPtr L)
		{
			int num = 0;
			LuaDLL.lua_pushnumber(L, Time.timeScale);
			return 1;
		}

		[MonoPInvokeCallback(typeof(LuaCSFunction))]
		private static int set_frame_rate(IntPtr L)
		{
			int result = 0;
			if (WraperUtil.ValidIsNumber(L, 1, string_set_frame_rate))
			{
				int num = 0;
				num = (int)LuaDLL.lua_tonumber(L, 1);
				Application.targetFrameRate = num;
				result = 0;
			}
			return result;
		}

		[MonoPInvokeCallback(typeof(LuaCSFunction))]
		private static int set_gc_time(IntPtr L)
		{
			int result = 0;
			if (WraperUtil.ValidIsNumber(L, 1, string_set_gc_time) && WraperUtil.ValidIsNumber(L, 2, string_set_gc_time))
			{
				float num = 0f;
				int num2 = 0;
				num = (float)LuaDLL.lua_tonumber(L, 1);
				num2 = (int)LuaDLL.lua_tonumber(L, 2);
				App3.GetInstance().gcInterval = num;
				App3.GetInstance().gcStep = num2;
				result = 0;
			}
			return result;
		}

		[MonoPInvokeCallback(typeof(LuaCSFunction))]
		private static int get_screen_width(IntPtr L)
		{
			int num = 0;
			LuaDLL.lua_pushnumber(L, Screen.width);
			return 1;
		}

		[MonoPInvokeCallback(typeof(LuaCSFunction))]
		private static int get_screen_height(IntPtr L)
		{
			int num = 0;
			LuaDLL.lua_pushnumber(L, Screen.height);
			return 1;
		}

		[MonoPInvokeCallback(typeof(LuaCSFunction))]
		private static int reset_lua(IntPtr L)
		{
			int num = 0;
			App3.GetInstance().ResetScript();
			return 0;
		}

		[MonoPInvokeCallback(typeof(LuaCSFunction))]
		private static int get_touch_screen_keyboard_area(IntPtr L)
		{
			int num = 0;
			LuaDLL.lua_pushnumber(L, TouchScreenKeyboard.area.width);
			LuaDLL.lua_pushnumber(L, TouchScreenKeyboard.area.height);
			return 2;
		}

		[MonoPInvokeCallback(typeof(LuaCSFunction))]
		private static int get_touch_screen_keyboard_visible(IntPtr L)
		{
			int num = 0;
			LuaDLL.lua_pushboolean(L, TouchScreenKeyboard.visible);
			return 1;
		}

		[MonoPInvokeCallback(typeof(LuaCSFunction))]
		private static int on_sanalyze_event(IntPtr L)
		{
			int result = 0;
			if (WraperUtil.ValidIsString(L, 1, string_on_sanalyze_event) && WraperUtil.ValidIsString(L, 2, string_on_sanalyze_event))
			{
				string text = null;
				string text2 = null;
				text = LuaDLL.lua_tostring(L, 1);
				text2 = LuaDLL.lua_tostring(L, 2);
				UserCenter.GetInstance().SanalyzeReport(text, text2);
				result = 0;
			}
			return result;
		}

		[MonoPInvokeCallback(typeof(LuaCSFunction))]
		private static int get_device_info_by_key(IntPtr L)
		{
			int result = 0;
			if (WraperUtil.ValidIsString(L, 1, string_get_device_info_by_key))
			{
				string text = null;
				text = LuaDLL.lua_tostring(L, 1);
				LuaDLL.lua_pushstring(L, UserCenter.GetInstance().getDeviceInfo(text));
				result = 1;
			}
			return result;
		}

		[MonoPInvokeCallback(typeof(LuaCSFunction))]
		private static int open_url(IntPtr L)
		{
			int result = 0;
			if (WraperUtil.ValidIsString(L, 1, string_open_url))
			{
				string text = null;
				text = LuaDLL.lua_tostring(L, 1);
				Application.OpenURL(text);
				result = 0;
			}
			return result;
		}

		[MonoPInvokeCallback(typeof(LuaCSFunction))]
		private static int opt_enable_net_dispatch(IntPtr L)
		{
			int result = 0;
			if (WraperUtil.ValidIsBoolean(L, 1, string_opt_enable_net_dispatch))
			{
				bool flag = false;
				flag = LuaDLL.lua_toboolean(L, 1);
				App3.GetInstance().opt_enable_net_dispatch(flag);
				result = 0;
			}
			return result;
		}

		[MonoPInvokeCallback(typeof(LuaCSFunction))]
		private static int add_net_cache_ignore_msg(IntPtr L)
		{
			int result = 0;
			if (WraperUtil.ValidIsString(L, 1, string_add_net_cache_ignore_msg))
			{
				string funcName = LuaDLL.lua_tostring(L, 1);
				App3.GetInstance().add_net_cache_ignore_msg(funcName);
			}
			return result;
		}

		[MonoPInvokeCallback(typeof(LuaCSFunction))]
		private static int get_os_type(IntPtr L)
		{
			int num = 0;
			LuaDLL.lua_pushnumber(L, (double)Application.platform);
			return 1;
		}

		[MonoPInvokeCallback(typeof(LuaCSFunction))]
		private static int get_internet_reach_ability(IntPtr L)
		{
			int num = 0;
			LuaDLL.lua_pushnumber(L, (double)Application.internetReachability);
			return 1;
		}

		[MonoPInvokeCallback(typeof(LuaCSFunction))]
		private static int install_apk(IntPtr L)
		{
			int result = 0;
			if (WraperUtil.ValidIsString(L, 1, string_install_apk))
			{
				string text = null;
				text = LuaDLL.lua_tostring(L, 1);
				//AndroidBehaviour.instance.CallStatic("com.unityplugin.Utils", "ApkInatall", text);
				result = 0;
			}
			return result;
		}

		[MonoPInvokeCallback(typeof(LuaCSFunction))]
		private static int set_texture_quality(IntPtr L)
		{
			int result = 0;
			if (WraperUtil.ValidIsNumber(L, 1, string_set_texture_quality))
			{
				int num = 0;
				num = (int)LuaDLL.lua_tonumber(L, 1);
				if (num < 0 || num > 3)
				{
					Core.Unity.Debug.LogError("[app_wraper set_texture_quality] texture_level should between 0 and 3");
				}
				else
				{
					QualitySettings.masterTextureLimit = num;
					result = 0;
				}
			}
			return result;
		}

		[MonoPInvokeCallback(typeof(LuaCSFunction))]
		private static int set_quality_level(IntPtr L)
		{
			int result = 0;
			if (WraperUtil.ValidIsNumber(L, 1, string_set_quality_level) && WraperUtil.ValidIsBoolean(L, 2, string_set_quality_level))
			{
				int num = 0;
				bool flag = false;
				num = (int)LuaDLL.lua_tonumber(L, 1);
				flag = LuaDLL.lua_toboolean(L, 2);
				QualitySettings.SetQualityLevel(num, flag);
				result = 0;
			}
			return result;
		}

		[MonoPInvokeCallback(typeof(LuaCSFunction))]
		private static int get_quality_level(IntPtr L)
		{
			int num = 0;
			LuaDLL.lua_pushnumber(L, QualitySettings.GetQualityLevel());
			return 1;
		}

		[MonoPInvokeCallback(typeof(LuaCSFunction))]
		private static int set_on_application_pause_call(IntPtr L)
		{
			int result = 0;
			if (WraperUtil.ValidIsLString(L, 1, string_set_on_application_loop_call))
			{
				string onApplicationPauseCall = LuaDLL.lua_tostring(L, 1);
				App3 instance = App3.GetInstance();
				if (instance != null)
				{
					instance.SetOnApplicationPauseCall(onApplicationPauseCall);
				}
				result = 0;
			}
			return result;
		}

		[MonoPInvokeCallback(typeof(LuaCSFunction))]
		private static int set_on_application_loop_call(IntPtr L)
		{
			int result = 0;
			if (WraperUtil.ValidIsLString(L, 1, string_set_on_application_loop_call))
			{
				string onApplicationPauseLoopCall = LuaDLL.lua_tostring(L, 1);
				App3 instance = App3.GetInstance();
				if (instance != null)
				{
					instance.SetOnApplicationPauseLoopCall(onApplicationPauseLoopCall);
					UnityEngine.Debug.Log("#####SetOnApplicationPauseLoopCall:" + DateTime.Now.ToString());
				}
				result = 0;
			}
			return result;
		}

		[MonoPInvokeCallback(typeof(LuaCSFunction))]
		private static int set_pause_loop_call_timeout(IntPtr L)
		{
			int result = 0;
			if (WraperUtil.ValidIsNumber(L, 1, string_set_pause_loop_call_timeout))
			{
				int pauseLoopCallTimeOut = (int)LuaDLL.lua_tonumber(L, 1);
				App3 instance = App3.GetInstance();
				if (instance != null)
				{
					instance.SetPauseLoopCallTimeOut(pauseLoopCallTimeOut);
				}
				result = 0;
			}
			return result;
		}

		[MonoPInvokeCallback(typeof(LuaCSFunction))]
		private static int kill_curr_process(IntPtr L)
		{
			int num = 0;
			string text = LuaDLL.lua_tostring(L, 1);
			App3 instance = App3.GetInstance();
			if (instance != null)
			{
				UnityEngine.Debug.Log("###########kill_curr_process0");
			}
			return 0;
		}

		[MonoPInvokeCallback(typeof(LuaCSFunction))]
		private static int close_background_thead(IntPtr L)
		{
			int result = 0;
			if (WraperUtil.ValidIsLString(L, 1, string_close_background_thead))
			{
				string text = LuaDLL.lua_tostring(L, 1);
				App3 instance = App3.GetInstance();
				if (instance != null)
				{
					instance.CloseBackgroundThead();
				}
				result = 0;
			}
			return result;
		}

		[MonoPInvokeCallback(typeof(LuaCSFunction))]
		private static int get_frame_count(IntPtr L)
		{
			int result = 1;
			LuaDLL.lua_pushnumber(L, App3.fps);
			return result;
		}

		[MonoPInvokeCallback(typeof(LuaCSFunction))]
		private static int get_real_since_time(IntPtr L)
		{
			LuaDLL.lua_pushnumber(L, Time.realtimeSinceStartup);
			return 1;
		}

		[MonoPInvokeCallback(typeof(LuaCSFunction))]
		private static int get_quality_count(IntPtr L)
		{
			int num = 0;
			LuaDLL.lua_pushnumber(L, QualitySettings.names.Length);
			return 1;
		}

		[MonoPInvokeCallback(typeof(LuaCSFunction))]
		private static int write_script_recording(IntPtr L)
		{
			int result = 0;
			if (WraperUtil.ValidIsNumber(L, 1, string_write_script_recording) && WraperUtil.ValidIsString(L, 2, string_write_script_recording))
			{
				string text = null;
				int num = 0;
				num = (int)LuaDLL.lua_tonumber(L, 1);
				text = LuaDLL.lua_tostring(L, 2);
				Core.Unity.Debug.WriteScriptRecording(num, text);
				result = 0;
			}
			return result;
		}

		[MonoPInvokeCallback(typeof(LuaCSFunction))]
		private static int reload_shader(IntPtr L)
		{
			int num = 0;
			App3.GetInstance().HotUpdateReloadShader();
			return 0;
		}
	}
}
