using System;
using LuaInterface;
using Script;
using UnityEngine;
using UnityWrap;

namespace Wraper
{
	public class uni_web_view_wraper
	{
		public static string libname = "uni_web_view_lib";

		public static string name = "uni_web_view";

		private static luaL_Reg[] libfunc = new luaL_Reg[1]
		{
			new luaL_Reg("find_web_view", find_uni_web_view)
		};

		private static luaL_Reg[] func = new luaL_Reg[12]
		{
			new luaL_Reg("get_pid", get_pid),
			new luaL_Reg("get_screen_width", get_screen_width),
			new luaL_Reg("get_screen_height", get_screen_height),
			new luaL_Reg("set_edge_insets", set_edge_insets),
			new luaL_Reg("set_url", set_url),
			new luaL_Reg("set_load_on_start", set_load_on_start),
			new luaL_Reg("set_auto_show_on_loaded", set_auto_show_on_loaded),
			new luaL_Reg("close", close),
			new luaL_Reg("show", show),
			new luaL_Reg("set_on_pause", set_on_pause),
			new luaL_Reg("set_on_receive_keycode", set_on_receive_keycode),
			new luaL_Reg("set_transparent_background", set_transparent_background)
		};

		private static string string_find_uni_web_view = "uni_web_view_lib.find_web_view";

		private static string string_get_screen_width = "uni_web_view.get_screen_width";

		private static string string_get_screen_height = "uni_web_view.get_screen_height";

		private static string string_get_pid = "uni_web_view:get_pid";

		private static string string_set_edge_insets = "uni_web_view:set_edge_insets";

		private static string string_set_url = "uni_web_view:set_url";

		private static string string_set_load_on_start = "uni_web_view:set_load_on_start";

		private static string string_set_auto_show_on_loaded = "uni_web_view:set_auto_show_on_loaded";

		private static string string_close = "uni_web_view:close";

		private static string string_show = "uni_web_view:show";

		private static string string_set_on_pause = "uni_web_view:set_on_pause";

		private static string string_set_on_receive_keycode = "uni_web_view:set_on_receive_keycode";

		private static string string_set_transparent_background = "uni_web_view:set_transparent_background";

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

		public static void push(IntPtr L, NGUILabelWrap obj)
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
		private static int find_uni_web_view(IntPtr L)
		{
			int result = 0;
			if (WraperUtil.ValidIsUserdata(L, 1, string_find_uni_web_view) && WraperUtil.ValidIsString(L, 2, string_find_uni_web_view))
			{
				AssetGameObject assetGameObject = null;
				string text = null;
				assetGameObject = WraperUtil.LuaToUserdata(L, 1, string_find_uni_web_view, AssetGameObject.cache);
				text = LuaDLL.lua_tostring(L, 2);
				WraperUtil.PushObject(L, UniWebViewWrap.GetOrCreateCom(assetGameObject.gameObject, text));
				result = 1;
			}
			return result;
		}

		[MonoPInvokeCallback(typeof(LuaCSFunction))]
		private static int set_edge_insets(IntPtr L)
		{
			int result = 0;
			if (WraperUtil.ValidIsUserdata(L, 1, string_set_edge_insets) && WraperUtil.ValidIsNumber(L, 2, string_set_edge_insets) && WraperUtil.ValidIsNumber(L, 3, string_set_edge_insets) && WraperUtil.ValidIsNumber(L, 4, string_set_edge_insets) && WraperUtil.ValidIsNumber(L, 5, string_set_edge_insets))
			{
				UniWebViewWrap uniWebViewWrap = null;
				uniWebViewWrap = WraperUtil.LuaToUserdata(L, 1, string_set_edge_insets, UniWebViewWrap.cache);
				int aTop = LuaDLL.lua_tointeger(L, 2);
				int aLeft = LuaDLL.lua_tointeger(L, 3);
				int aBottom = LuaDLL.lua_tointeger(L, 4);
				int aRight = LuaDLL.lua_tointeger(L, 5);
				uniWebViewWrap.bcomponent.insets = new UniWebViewEdgeInsets(aTop, aLeft, aBottom, aRight);
				result = 0;
			}
			return result;
		}

		[MonoPInvokeCallback(typeof(LuaCSFunction))]
		private static int get_pid(IntPtr L)
		{
			int result = 0;
			if (WraperUtil.ValidIsUserdata(L, 1, string_get_pid))
			{
				UniWebViewWrap uniWebViewWrap = null;
				uniWebViewWrap = WraperUtil.LuaToUserdata(L, 1, string_get_pid, UniWebViewWrap.cache);
				LuaDLL.lua_pushnumber(L, uniWebViewWrap.GetPid());
				result = 1;
			}
			return result;
		}

		[MonoPInvokeCallback(typeof(LuaCSFunction))]
		private static int set_url(IntPtr L)
		{
			int result = 0;
			if (WraperUtil.ValidIsUserdata(L, 1, string_set_url) && WraperUtil.ValidIsString(L, 2, string_set_url))
			{
				UniWebViewWrap uniWebViewWrap = WraperUtil.LuaToUserdata(L, 1, string_set_url, UniWebViewWrap.cache);
				uniWebViewWrap.bcomponent.url = LuaDLL.lua_tostring(L, 2);
			}
			return result;
		}

		[MonoPInvokeCallback(typeof(LuaCSFunction))]
		private static int set_load_on_start(IntPtr L)
		{
			int result = 0;
			if (WraperUtil.ValidIsUserdata(L, 1, string_set_load_on_start) && WraperUtil.ValidIsBoolean(L, 2, string_set_load_on_start))
			{
				UniWebViewWrap uniWebViewWrap = WraperUtil.LuaToUserdata(L, 1, string_set_load_on_start, UniWebViewWrap.cache);
				uniWebViewWrap.bcomponent.loadOnStart = LuaDLL.lua_toboolean(L, 2);
			}
			return result;
		}

		[MonoPInvokeCallback(typeof(LuaCSFunction))]
		private static int set_auto_show_on_loaded(IntPtr L)
		{
			int result = 0;
			if (WraperUtil.ValidIsUserdata(L, 1, string_set_auto_show_on_loaded) && WraperUtil.ValidIsBoolean(L, 2, string_set_auto_show_on_loaded))
			{
				UniWebViewWrap uniWebViewWrap = WraperUtil.LuaToUserdata(L, 1, string_set_auto_show_on_loaded, UniWebViewWrap.cache);
				uniWebViewWrap.bcomponent.autoShowWhenLoadComplete = LuaDLL.lua_toboolean(L, 2);
			}
			return result;
		}

		[MonoPInvokeCallback(typeof(LuaCSFunction))]
		private static int get_screen_width(IntPtr L)
		{
			int result = 0;
			if (WraperUtil.ValidIsUserdata(L, 1, string_get_screen_width))
			{
				UniWebViewWrap uniWebViewWrap = null;
				uniWebViewWrap = WraperUtil.LuaToUserdata(L, 1, string_get_screen_width, UniWebViewWrap.cache);
				LuaDLL.lua_pushnumber(L, UniWebViewHelper.screenWidth);
				result = 1;
			}
			return result;
		}

		[MonoPInvokeCallback(typeof(LuaCSFunction))]
		private static int get_screen_height(IntPtr L)
		{
			int result = 0;
			if (WraperUtil.ValidIsUserdata(L, 1, string_get_screen_height))
			{
				UniWebViewWrap uniWebViewWrap = null;
				uniWebViewWrap = WraperUtil.LuaToUserdata(L, 1, string_get_screen_height, UniWebViewWrap.cache);
				LuaDLL.lua_pushnumber(L, UniWebViewHelper.screenHeight);
				result = 1;
			}
			return result;
		}

		[MonoPInvokeCallback(typeof(LuaCSFunction))]
		private static int close(IntPtr L)
		{
			int result = 0;
			if (WraperUtil.ValidIsUserdata(L, 1, string_close))
			{
				UniWebViewWrap uniWebViewWrap = null;
				uniWebViewWrap = WraperUtil.LuaToUserdata(L, 1, string_close, UniWebViewWrap.cache);
				uniWebViewWrap.bcomponent.Hide();
				result = 0;
			}
			return result;
		}

		[MonoPInvokeCallback(typeof(LuaCSFunction))]
		private static int show(IntPtr L)
		{
			int result = 0;
			if (WraperUtil.ValidIsUserdata(L, 1, string_show))
			{
				UniWebViewWrap uniWebViewWrap = null;
				uniWebViewWrap = WraperUtil.LuaToUserdata(L, 1, string_show, UniWebViewWrap.cache);
				uniWebViewWrap.bcomponent.Show();
				result = 0;
			}
			return result;
		}

		[MonoPInvokeCallback(typeof(LuaCSFunction))]
		private static int set_on_pause(IntPtr L)
		{
			int result = 0;
			if (WraperUtil.ValidIsUserdata(L, 1, string_set_on_pause) && WraperUtil.ValidIsString(L, 2, string_set_on_pause))
			{
				UniWebViewWrap uniWebViewWrap = null;
				uniWebViewWrap = WraperUtil.LuaToUserdata(L, 1, string_set_on_pause, UniWebViewWrap.cache);
				uniWebViewWrap.bcomponent.OnApplicationPauseLuaString = LuaDLL.lua_tostring(L, 2);
				result = 0;
			}
			return result;
		}

		[MonoPInvokeCallback(typeof(LuaCSFunction))]
		private static int set_transparent_background(IntPtr L)
		{
			int result = 0;
			if (WraperUtil.ValidIsUserdata(L, 1, string_set_transparent_background) && WraperUtil.ValidIsBoolean(L, 2, string_set_transparent_background))
			{
				UniWebViewWrap uniWebViewWrap = null;
				uniWebViewWrap = WraperUtil.LuaToUserdata(L, 1, string_set_transparent_background, UniWebViewWrap.cache);
				uniWebViewWrap.bcomponent.SetTransparentBackground(LuaDLL.lua_toboolean(L, 2));
				result = 0;
			}
			return result;
		}

		[MonoPInvokeCallback(typeof(LuaCSFunction))]
		private static int set_on_receive_keycode(IntPtr L)
		{
			int result = 0;
			if (WraperUtil.ValidIsUserdata(L, 1, string_set_on_receive_keycode) && WraperUtil.ValidIsString(L, 2, string_set_on_receive_keycode))
			{
				UniWebViewWrap arg1 = null;
				arg1 = WraperUtil.LuaToUserdata(L, 1, string_set_on_receive_keycode, UniWebViewWrap.cache);
				arg1.bcomponent.OnReceivedKeyCode += delegate(UniWebView a, int k)
				{
					arg1.bcomponent.OnReceivedKeyCodeLuaString = LuaDLL.lua_tostring(L, 2);
					ScriptCall scriptCall = ScriptCall.Create(arg1.bcomponent.OnReceivedKeyCodeLuaString);
					if (scriptCall != null)
					{
						Debug.Log("set_on_receive_keycode," + k);
						if (scriptCall.Start())
						{
							LuaDLL.lua_newtable(scriptCall.L);
							scriptCall.lua_settable("key_code", k);
							scriptCall.Finish(0);
						}
					}
				};
				result = 0;
			}
			return result;
		}

		[MonoPInvokeCallback(typeof(LuaCSFunction))]
		private static int gc(IntPtr L)
		{
			UniWebViewWrap uniWebViewWrap = WraperUtil.LuaToUserdataByGc(L, 1, "gc audio_source_object", UniWebViewWrap.cache);
			if (uniWebViewWrap != null)
			{
				uniWebViewWrap.DestroyInstance();
			}
			return 0;
		}
	}
}
