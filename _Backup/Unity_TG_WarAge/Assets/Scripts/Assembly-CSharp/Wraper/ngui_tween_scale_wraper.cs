using System;
using LuaInterface;
using UnityEngine;
using UnityWrap;

namespace Wraper
{
	public class ngui_tween_scale_wraper
	{
		public static string name = "ngui_tween_scale";

		private static luaL_Reg[] func = new luaL_Reg[23]
		{
			new luaL_Reg("get_pid", get_pid),
			new luaL_Reg("set_active", set_active),
			new luaL_Reg("set_name", set_name),
			new luaL_Reg("get_name", get_name),
			new luaL_Reg("set_position", set_position),
			new luaL_Reg("get_position", get_position),
			new luaL_Reg("get_size", get_size),
			new luaL_Reg("get_game_object", get_game_object),
			new luaL_Reg("get_parent", get_parent),
			new luaL_Reg("set_parent", set_parent),
			new luaL_Reg("clone", clone),
			new luaL_Reg("destroy_object", destroy_object),
			new luaL_Reg("set_style", set_style),
			new luaL_Reg("set_duration", set_duration),
			new luaL_Reg("set_delay", set_delay),
			new luaL_Reg("play_foward", play_foward),
			new luaL_Reg("play_reverse", play_reverse),
			new luaL_Reg("reset_to_begining", reset_to_begining),
			new luaL_Reg("toggle", toggle),
			new luaL_Reg("disable", disable),
			new luaL_Reg("set_on_finished", set_on_finished),
			new luaL_Reg("set_from_scale", set_from_scale),
			new luaL_Reg("set_to_scale", set_to_scale)
		};

		private static string string_get_pid = "ngui_tween_scale:get_pid";

		private static string string_set_active = "ngui_tween_scale:set_active";

		private static string string_set_name = "ngui_tween_scale:set_name";

		private static string string_get_name = "ngui_tween_scale:get_name";

		private static string string_set_position = "ngui_tween_scale:set_position";

		private static string string_get_position = "ngui_tween_scale:get_position";

		private static string string_get_size = "ngui_tween_scale:get_size";

		private static string string_get_game_object = "ngui_tween_scale:get_game_object";

		private static string string_get_parent = "ngui_tween_scale:get_parent";

		private static string string_set_parent = "ngui_tween_scale:set_parent";

		private static string string_clone = "ngui_tween_scale:clone";

		private static string string_destroy_object = "ngui_tween_scale:destroy_object";

		private static string string_set_style = "ngui_tween_scale:set_style";

		private static string string_set_duration = "ngui_tween_scale:set_duration";

		private static string string_set_delay = "ngui_tween_scale:set_delay";

		private static string string_play_foward = "ngui_tween_scale:play_foward";

		private static string string_play_reverse = "ngui_tween_scale:play_reverse";

		private static string string_reset_to_begining = "ngui_tween_scale:reset_to_begining";

		private static string string_toggle = "ngui_tween_scale:toggle";

		private static string string_disable = "ngui_tween_scale:disable";

		private static string string_set_on_finished = "ngui_tween_scale:set_on_finished";

		private static string string_set_from_scale = "ngui_tween_scale:set_from_scale";

		private static string string_set_to_scale = "ngui_tween_scale:set_to_scale";

		public static bool init(IntPtr L)
		{
			if (L != IntPtr.Zero)
			{
				LuaDLL.register_class(L, name, func, gc);
				return true;
			}
			return false;
		}

		public static void push(IntPtr L, NGUITweenScaleWrap obj)
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
		private static int get_pid(IntPtr L)
		{
			int result = 0;
			if (WraperUtil.ValidIsUserdata(L, 1, string_get_pid))
			{
				NGUITweenScaleWrap nGUITweenScaleWrap = null;
				nGUITweenScaleWrap = WraperUtil.LuaToUserdata(L, 1, string_get_pid, NGUITweenScaleWrap.cache);
				LuaDLL.lua_pushnumber(L, nGUITweenScaleWrap.GetPid());
				result = 1;
			}
			return result;
		}

		[MonoPInvokeCallback(typeof(LuaCSFunction))]
		private static int set_active(IntPtr L)
		{
			int result = 0;
			if (WraperUtil.ValidIsUserdata(L, 1, string_set_active) && WraperUtil.ValidIsBoolean(L, 2, string_set_active))
			{
				NGUITweenScaleWrap nGUITweenScaleWrap = null;
				bool flag = false;
				nGUITweenScaleWrap = WraperUtil.LuaToUserdata(L, 1, string_set_active, NGUITweenScaleWrap.cache);
				flag = LuaDLL.lua_toboolean(L, 2);
				nGUITweenScaleWrap.bcomponent.gameObject.SetActive(flag);
				result = 0;
			}
			return result;
		}

		[MonoPInvokeCallback(typeof(LuaCSFunction))]
		private static int set_name(IntPtr L)
		{
			int result = 0;
			if (WraperUtil.ValidIsUserdata(L, 1, string_set_name) && WraperUtil.ValidIsString(L, 2, string_set_name))
			{
				NGUITweenScaleWrap nGUITweenScaleWrap = null;
				string text = null;
				nGUITweenScaleWrap = WraperUtil.LuaToUserdata(L, 1, string_set_name, NGUITweenScaleWrap.cache);
				text = LuaDLL.lua_tostring(L, 2);
				nGUITweenScaleWrap.bcomponent.gameObject.name = text;
				result = 0;
			}
			return result;
		}

		[MonoPInvokeCallback(typeof(LuaCSFunction))]
		private static int get_name(IntPtr L)
		{
			int result = 0;
			if (WraperUtil.ValidIsUserdata(L, 1, string_get_name))
			{
				NGUITweenScaleWrap nGUITweenScaleWrap = null;
				nGUITweenScaleWrap = WraperUtil.LuaToUserdata(L, 1, string_get_name, NGUITweenScaleWrap.cache);
				LuaDLL.lua_pushstring(L, nGUITweenScaleWrap.bcomponent.gameObject.name);
				result = 1;
			}
			return result;
		}

		[MonoPInvokeCallback(typeof(LuaCSFunction))]
		private static int set_position(IntPtr L)
		{
			int result = 0;
			if (WraperUtil.ValidIsUserdata(L, 1, string_set_position) && WraperUtil.ValidIsNumber(L, 2, string_set_position) && WraperUtil.ValidIsNumber(L, 3, string_set_position) && WraperUtil.ValidIsNumber(L, 4, string_set_position))
			{
				NGUITweenScaleWrap nGUITweenScaleWrap = null;
				float num = 0f;
				float num2 = 0f;
				float num3 = 0f;
				nGUITweenScaleWrap = WraperUtil.LuaToUserdata(L, 1, string_set_position, NGUITweenScaleWrap.cache);
				num = (float)LuaDLL.lua_tonumber(L, 2);
				num2 = (float)LuaDLL.lua_tonumber(L, 3);
				num3 = (float)LuaDLL.lua_tonumber(L, 4);
				nGUITweenScaleWrap.bcomponent.gameObject.transform.localPosition = new Vector3(num, num2, num3);
				result = 0;
			}
			return result;
		}

		[MonoPInvokeCallback(typeof(LuaCSFunction))]
		private static int get_position(IntPtr L)
		{
			int result = 0;
			if (WraperUtil.ValidIsUserdata(L, 1, string_get_position))
			{
				NGUITweenScaleWrap nGUITweenScaleWrap = null;
				nGUITweenScaleWrap = WraperUtil.LuaToUserdata(L, 1, string_get_position, NGUITweenScaleWrap.cache);
				Vector3 localPosition = nGUITweenScaleWrap.bcomponent.gameObject.transform.localPosition;
				LuaDLL.lua_pushnumber(L, localPosition.x);
				LuaDLL.lua_pushnumber(L, localPosition.y);
				LuaDLL.lua_pushnumber(L, localPosition.z);
				result = 3;
			}
			return result;
		}

		[MonoPInvokeCallback(typeof(LuaCSFunction))]
		private static int get_size(IntPtr L)
		{
			int result = 0;
			if (WraperUtil.ValidIsUserdata(L, 1, string_get_size))
			{
				NGUITweenScaleWrap nGUITweenScaleWrap = null;
				nGUITweenScaleWrap = WraperUtil.LuaToUserdata(L, 1, string_get_size, NGUITweenScaleWrap.cache);
				int num = ((!(nGUITweenScaleWrap.widget == null)) ? nGUITweenScaleWrap.widget.width : 0);
				int num2 = ((!(nGUITweenScaleWrap.widget == null)) ? nGUITweenScaleWrap.widget.height : 0);
				LuaDLL.lua_pushnumber(L, num);
				LuaDLL.lua_pushnumber(L, num2);
				result = 2;
			}
			return result;
		}

		[MonoPInvokeCallback(typeof(LuaCSFunction))]
		private static int get_game_object(IntPtr L)
		{
			int result = 0;
			if (WraperUtil.ValidIsUserdata(L, 1, string_get_game_object))
			{
				NGUITweenScaleWrap nGUITweenScaleWrap = null;
				nGUITweenScaleWrap = WraperUtil.LuaToUserdata(L, 1, string_get_game_object, NGUITweenScaleWrap.cache);
				AssetGameObject base_object = AssetGameObject.CreateByInstance(nGUITweenScaleWrap.bcomponent.gameObject);
				WraperUtil.PushObject(L, base_object);
				result = 1;
			}
			return result;
		}

		[MonoPInvokeCallback(typeof(LuaCSFunction))]
		private static int get_parent(IntPtr L)
		{
			int result = 0;
			if (WraperUtil.ValidIsUserdata(L, 1, string_get_parent))
			{
				NGUITweenScaleWrap nGUITweenScaleWrap = null;
				nGUITweenScaleWrap = WraperUtil.LuaToUserdata(L, 1, string_get_parent, NGUITweenScaleWrap.cache);
				AssetGameObject assetGameObject = null;
				Transform parent = nGUITweenScaleWrap.bcomponent.gameObject.transform.parent;
				if (parent != null)
				{
					assetGameObject = AssetGameObject.CreateByInstance(parent.gameObject);
				}
				if (assetGameObject != null)
				{
					WraperUtil.PushObject(L, assetGameObject);
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
		private static int set_parent(IntPtr L)
		{
			int result = 0;
			if (WraperUtil.ValidIsUserdata(L, 1, string_set_parent) && WraperUtil.ValidIsUserdataOrNil(L, 2, string_set_parent))
			{
				NGUITweenScaleWrap nGUITweenScaleWrap = null;
				AssetGameObject assetGameObject = null;
				nGUITweenScaleWrap = WraperUtil.LuaToUserdata(L, 1, string_set_parent, NGUITweenScaleWrap.cache);
				assetGameObject = WraperUtil.LuaToUserdataOrNil(L, 2, string_set_parent, AssetGameObject.cache);
				nGUITweenScaleWrap.bcomponent.gameObject.transform.parent = ((assetGameObject != null) ? assetGameObject.transform : null);
				result = 0;
			}
			return result;
		}

		[MonoPInvokeCallback(typeof(LuaCSFunction))]
		private static int clone(IntPtr L)
		{
			int result = 0;
			if (WraperUtil.ValidIsUserdata(L, 1, string_clone))
			{
				NGUITweenScaleWrap nGUITweenScaleWrap = null;
				nGUITweenScaleWrap = WraperUtil.LuaToUserdata(L, 1, string_clone, NGUITweenScaleWrap.cache);
				nGUITweenScaleWrap.Clone(L);
				result = 1;
			}
			return result;
		}

		[MonoPInvokeCallback(typeof(LuaCSFunction))]
		private static int destroy_object(IntPtr L)
		{
			int result = 0;
			if (WraperUtil.ValidIsUserdata(L, 1, string_destroy_object))
			{
				NGUITweenScaleWrap nGUITweenScaleWrap = null;
				nGUITweenScaleWrap = WraperUtil.LuaToUserdata(L, 1, string_destroy_object, NGUITweenScaleWrap.cache);
				nGUITweenScaleWrap.isNeedDestroy = true;
				result = 0;
			}
			return result;
		}

		[MonoPInvokeCallback(typeof(LuaCSFunction))]
		private static int set_style(IntPtr L)
		{
			int result = 0;
			if (WraperUtil.ValidIsUserdata(L, 1, string_set_style) && WraperUtil.ValidIsNumber(L, 2, string_set_style))
			{
				NGUITweenScaleWrap nGUITweenScaleWrap = null;
				int num = 0;
				nGUITweenScaleWrap = WraperUtil.LuaToUserdata(L, 1, string_set_style, NGUITweenScaleWrap.cache);
				switch ((int)LuaDLL.lua_tonumber(L, 2))
				{
				case 1:
					nGUITweenScaleWrap.component.style = UITweener.Style.Once;
					break;
				case 2:
					nGUITweenScaleWrap.component.style = UITweener.Style.Loop;
					break;
				case 3:
					nGUITweenScaleWrap.component.style = UITweener.Style.PingPong;
					break;
				}
				result = 0;
			}
			return result;
		}

		[MonoPInvokeCallback(typeof(LuaCSFunction))]
		private static int set_duration(IntPtr L)
		{
			int result = 0;
			if (WraperUtil.ValidIsUserdata(L, 1, string_set_duration) && WraperUtil.ValidIsNumber(L, 2, string_set_duration))
			{
				NGUITweenScaleWrap nGUITweenScaleWrap = null;
				float num = 0f;
				nGUITweenScaleWrap = WraperUtil.LuaToUserdata(L, 1, string_set_duration, NGUITweenScaleWrap.cache);
				num = (float)LuaDLL.lua_tonumber(L, 2);
				nGUITweenScaleWrap.component.duration = num;
				result = 0;
			}
			return result;
		}

		[MonoPInvokeCallback(typeof(LuaCSFunction))]
		private static int set_delay(IntPtr L)
		{
			int result = 0;
			if (WraperUtil.ValidIsUserdata(L, 1, string_set_delay) && WraperUtil.ValidIsNumber(L, 2, string_set_delay))
			{
				NGUITweenScaleWrap nGUITweenScaleWrap = null;
				float num = 0f;
				nGUITweenScaleWrap = WraperUtil.LuaToUserdata(L, 1, string_set_delay, NGUITweenScaleWrap.cache);
				num = (float)LuaDLL.lua_tonumber(L, 2);
				nGUITweenScaleWrap.component.delay = num;
				result = 0;
			}
			return result;
		}

		[MonoPInvokeCallback(typeof(LuaCSFunction))]
		private static int play_foward(IntPtr L)
		{
			int result = 0;
			if (WraperUtil.ValidIsUserdata(L, 1, string_play_foward))
			{
				NGUITweenScaleWrap nGUITweenScaleWrap = null;
				nGUITweenScaleWrap = WraperUtil.LuaToUserdata(L, 1, string_play_foward, NGUITweenScaleWrap.cache);
				nGUITweenScaleWrap.component.PlayForward();
				result = 0;
			}
			return result;
		}

		[MonoPInvokeCallback(typeof(LuaCSFunction))]
		private static int play_reverse(IntPtr L)
		{
			int result = 0;
			if (WraperUtil.ValidIsUserdata(L, 1, string_play_reverse))
			{
				NGUITweenScaleWrap nGUITweenScaleWrap = null;
				nGUITweenScaleWrap = WraperUtil.LuaToUserdata(L, 1, string_play_reverse, NGUITweenScaleWrap.cache);
				nGUITweenScaleWrap.component.PlayReverse();
				result = 0;
			}
			return result;
		}

		[MonoPInvokeCallback(typeof(LuaCSFunction))]
		private static int reset_to_begining(IntPtr L)
		{
			int result = 0;
			if (WraperUtil.ValidIsUserdata(L, 1, string_reset_to_begining))
			{
				NGUITweenScaleWrap nGUITweenScaleWrap = null;
				nGUITweenScaleWrap = WraperUtil.LuaToUserdata(L, 1, string_reset_to_begining, NGUITweenScaleWrap.cache);
				nGUITweenScaleWrap.component.ResetToBeginning();
				result = 0;
			}
			return result;
		}

		[MonoPInvokeCallback(typeof(LuaCSFunction))]
		private static int toggle(IntPtr L)
		{
			int result = 0;
			if (WraperUtil.ValidIsUserdata(L, 1, string_toggle))
			{
				NGUITweenScaleWrap nGUITweenScaleWrap = null;
				nGUITweenScaleWrap = WraperUtil.LuaToUserdata(L, 1, string_toggle, NGUITweenScaleWrap.cache);
				nGUITweenScaleWrap.component.Toggle();
				result = 0;
			}
			return result;
		}

		[MonoPInvokeCallback(typeof(LuaCSFunction))]
		private static int disable(IntPtr L)
		{
			int result = 0;
			if (WraperUtil.ValidIsUserdata(L, 1, string_disable))
			{
				NGUITweenScaleWrap nGUITweenScaleWrap = null;
				nGUITweenScaleWrap = WraperUtil.LuaToUserdata(L, 1, string_disable, NGUITweenScaleWrap.cache);
				nGUITweenScaleWrap.component.enabled = false;
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
				NGUITweenScaleWrap nGUITweenScaleWrap = null;
				string text = null;
				nGUITweenScaleWrap = WraperUtil.LuaToUserdata(L, 1, string_set_on_finished, NGUITweenScaleWrap.cache);
				text = LuaDLL.lua_tostring(L, 2);
				nGUITweenScaleWrap.onFinish = text;
				result = 0;
			}
			return result;
		}

		[MonoPInvokeCallback(typeof(LuaCSFunction))]
		private static int set_from_scale(IntPtr L)
		{
			int result = 0;
			if (WraperUtil.ValidIsUserdata(L, 1, string_set_from_scale) && WraperUtil.ValidIsNumber(L, 2, string_set_from_scale) && WraperUtil.ValidIsNumber(L, 3, string_set_from_scale) && WraperUtil.ValidIsNumber(L, 4, string_set_from_scale))
			{
				NGUITweenScaleWrap nGUITweenScaleWrap = null;
				int num = 0;
				int num2 = 0;
				int num3 = 0;
				nGUITweenScaleWrap = WraperUtil.LuaToUserdata(L, 1, string_set_from_scale, NGUITweenScaleWrap.cache);
				num = (int)LuaDLL.lua_tonumber(L, 2);
				num2 = (int)LuaDLL.lua_tonumber(L, 3);
				num3 = (int)LuaDLL.lua_tonumber(L, 4);
				nGUITweenScaleWrap.component.from = new Vector3(num, num2, num3);
				result = 0;
			}
			return result;
		}

		[MonoPInvokeCallback(typeof(LuaCSFunction))]
		private static int set_to_scale(IntPtr L)
		{
			int result = 0;
			if (WraperUtil.ValidIsUserdata(L, 1, string_set_to_scale) && WraperUtil.ValidIsNumber(L, 2, string_set_to_scale) && WraperUtil.ValidIsNumber(L, 3, string_set_to_scale) && WraperUtil.ValidIsNumber(L, 4, string_set_to_scale))
			{
				NGUITweenScaleWrap nGUITweenScaleWrap = null;
				int num = 0;
				int num2 = 0;
				int num3 = 0;
				nGUITweenScaleWrap = WraperUtil.LuaToUserdata(L, 1, string_set_to_scale, NGUITweenScaleWrap.cache);
				num = (int)LuaDLL.lua_tonumber(L, 2);
				num2 = (int)LuaDLL.lua_tonumber(L, 3);
				num3 = (int)LuaDLL.lua_tonumber(L, 4);
				nGUITweenScaleWrap.component.to = new Vector3(num, num2, num3);
				result = 0;
			}
			return result;
		}

		[MonoPInvokeCallback(typeof(LuaCSFunction))]
		private static int gc(IntPtr L)
		{
			NGUITweenScaleWrap nGUITweenScaleWrap = WraperUtil.LuaToUserdataByGc(L, 1, "gc ngui_tween_scale", NGUITweenScaleWrap.cache);
			if (nGUITweenScaleWrap != null)
			{
				nGUITweenScaleWrap.DestroyInstance();
			}
			return 0;
		}
	}
}
