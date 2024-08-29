using System;
using LuaInterface;
using UnityEngine;
using UnityWrap;

namespace Wraper
{
	public class ngui_tween_color_wraper
	{
		public static string name = "ngui_tween_color";

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
			new luaL_Reg("set_from_color", set_from_color),
			new luaL_Reg("set_to_color", set_to_color)
		};

		private static string string_get_pid = "ngui_tween_color:get_pid";

		private static string string_set_active = "ngui_tween_color:set_active";

		private static string string_set_name = "ngui_tween_color:set_name";

		private static string string_get_name = "ngui_tween_color:get_name";

		private static string string_set_position = "ngui_tween_color:set_position";

		private static string string_get_position = "ngui_tween_color:get_position";

		private static string string_get_size = "ngui_tween_color:get_size";

		private static string string_get_game_object = "ngui_tween_color:get_game_object";

		private static string string_get_parent = "ngui_tween_color:get_parent";

		private static string string_set_parent = "ngui_tween_color:set_parent";

		private static string string_clone = "ngui_tween_color:clone";

		private static string string_destroy_object = "ngui_tween_color:destroy_object";

		private static string string_set_style = "ngui_tween_color:set_style";

		private static string string_set_duration = "ngui_tween_color:set_duration";

		private static string string_set_delay = "ngui_tween_color:set_delay";

		private static string string_play_foward = "ngui_tween_color:play_foward";

		private static string string_play_reverse = "ngui_tween_color:play_reverse";

		private static string string_reset_to_begining = "ngui_tween_color:reset_to_begining";

		private static string string_toggle = "ngui_tween_color:toggle";

		private static string string_disable = "ngui_tween_color:disable";

		private static string string_set_on_finished = "ngui_tween_color:set_on_finished";

		private static string string_set_from_color = "ngui_tween_color:set_from_color";

		private static string string_set_to_color = "ngui_tween_color:set_to_color";

		public static bool init(IntPtr L)
		{
			if (L != IntPtr.Zero)
			{
				LuaDLL.register_class(L, name, func, gc);
				return true;
			}
			return false;
		}

		public static void push(IntPtr L, NGUITweenColorWrap obj)
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
				NGUITweenColorWrap nGUITweenColorWrap = null;
				nGUITweenColorWrap = WraperUtil.LuaToUserdata(L, 1, string_get_pid, NGUITweenColorWrap.cache);
				LuaDLL.lua_pushnumber(L, nGUITweenColorWrap.GetPid());
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
				NGUITweenColorWrap nGUITweenColorWrap = null;
				bool flag = false;
				nGUITweenColorWrap = WraperUtil.LuaToUserdata(L, 1, string_set_active, NGUITweenColorWrap.cache);
				flag = LuaDLL.lua_toboolean(L, 2);
				nGUITweenColorWrap.bcomponent.gameObject.SetActive(flag);
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
				NGUITweenColorWrap nGUITweenColorWrap = null;
				string text = null;
				nGUITweenColorWrap = WraperUtil.LuaToUserdata(L, 1, string_set_name, NGUITweenColorWrap.cache);
				text = LuaDLL.lua_tostring(L, 2);
				nGUITweenColorWrap.bcomponent.gameObject.name = text;
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
				NGUITweenColorWrap nGUITweenColorWrap = null;
				nGUITweenColorWrap = WraperUtil.LuaToUserdata(L, 1, string_get_name, NGUITweenColorWrap.cache);
				LuaDLL.lua_pushstring(L, nGUITweenColorWrap.bcomponent.gameObject.name);
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
				NGUITweenColorWrap nGUITweenColorWrap = null;
				float num = 0f;
				float num2 = 0f;
				float num3 = 0f;
				nGUITweenColorWrap = WraperUtil.LuaToUserdata(L, 1, string_set_position, NGUITweenColorWrap.cache);
				num = (float)LuaDLL.lua_tonumber(L, 2);
				num2 = (float)LuaDLL.lua_tonumber(L, 3);
				num3 = (float)LuaDLL.lua_tonumber(L, 4);
				nGUITweenColorWrap.bcomponent.gameObject.transform.localPosition = new Vector3(num, num2, num3);
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
				NGUITweenColorWrap nGUITweenColorWrap = null;
				nGUITweenColorWrap = WraperUtil.LuaToUserdata(L, 1, string_get_position, NGUITweenColorWrap.cache);
				Vector3 localPosition = nGUITweenColorWrap.bcomponent.gameObject.transform.localPosition;
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
				NGUITweenColorWrap nGUITweenColorWrap = null;
				nGUITweenColorWrap = WraperUtil.LuaToUserdata(L, 1, string_get_size, NGUITweenColorWrap.cache);
				int num = ((!(nGUITweenColorWrap.widget == null)) ? nGUITweenColorWrap.widget.width : 0);
				int num2 = ((!(nGUITweenColorWrap.widget == null)) ? nGUITweenColorWrap.widget.height : 0);
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
				NGUITweenColorWrap nGUITweenColorWrap = null;
				nGUITweenColorWrap = WraperUtil.LuaToUserdata(L, 1, string_get_game_object, NGUITweenColorWrap.cache);
				AssetGameObject base_object = AssetGameObject.CreateByInstance(nGUITweenColorWrap.bcomponent.gameObject);
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
				NGUITweenColorWrap nGUITweenColorWrap = null;
				nGUITweenColorWrap = WraperUtil.LuaToUserdata(L, 1, string_get_parent, NGUITweenColorWrap.cache);
				AssetGameObject assetGameObject = null;
				Transform parent = nGUITweenColorWrap.bcomponent.gameObject.transform.parent;
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
				NGUITweenColorWrap nGUITweenColorWrap = null;
				AssetGameObject assetGameObject = null;
				nGUITweenColorWrap = WraperUtil.LuaToUserdata(L, 1, string_set_parent, NGUITweenColorWrap.cache);
				assetGameObject = WraperUtil.LuaToUserdataOrNil(L, 2, string_set_parent, AssetGameObject.cache);
				nGUITweenColorWrap.bcomponent.gameObject.transform.parent = ((assetGameObject != null) ? assetGameObject.transform : null);
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
				NGUITweenColorWrap nGUITweenColorWrap = null;
				nGUITweenColorWrap = WraperUtil.LuaToUserdata(L, 1, string_clone, NGUITweenColorWrap.cache);
				nGUITweenColorWrap.Clone(L);
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
				NGUITweenColorWrap nGUITweenColorWrap = null;
				nGUITweenColorWrap = WraperUtil.LuaToUserdata(L, 1, string_destroy_object, NGUITweenColorWrap.cache);
				nGUITweenColorWrap.isNeedDestroy = true;
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
				NGUITweenColorWrap nGUITweenColorWrap = null;
				int num = 0;
				nGUITweenColorWrap = WraperUtil.LuaToUserdata(L, 1, string_set_style, NGUITweenColorWrap.cache);
				switch ((int)LuaDLL.lua_tonumber(L, 2))
				{
				case 1:
					nGUITweenColorWrap.component.style = UITweener.Style.Once;
					break;
				case 2:
					nGUITweenColorWrap.component.style = UITweener.Style.Loop;
					break;
				case 3:
					nGUITweenColorWrap.component.style = UITweener.Style.PingPong;
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
				NGUITweenColorWrap nGUITweenColorWrap = null;
				float num = 0f;
				nGUITweenColorWrap = WraperUtil.LuaToUserdata(L, 1, string_set_duration, NGUITweenColorWrap.cache);
				num = (float)LuaDLL.lua_tonumber(L, 2);
				nGUITweenColorWrap.component.duration = num;
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
				NGUITweenColorWrap nGUITweenColorWrap = null;
				float num = 0f;
				nGUITweenColorWrap = WraperUtil.LuaToUserdata(L, 1, string_set_delay, NGUITweenColorWrap.cache);
				num = (float)LuaDLL.lua_tonumber(L, 2);
				nGUITweenColorWrap.component.delay = num;
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
				NGUITweenColorWrap nGUITweenColorWrap = null;
				nGUITweenColorWrap = WraperUtil.LuaToUserdata(L, 1, string_play_foward, NGUITweenColorWrap.cache);
				nGUITweenColorWrap.component.PlayForward();
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
				NGUITweenColorWrap nGUITweenColorWrap = null;
				nGUITweenColorWrap = WraperUtil.LuaToUserdata(L, 1, string_play_reverse, NGUITweenColorWrap.cache);
				nGUITweenColorWrap.component.PlayReverse();
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
				NGUITweenColorWrap nGUITweenColorWrap = null;
				nGUITweenColorWrap = WraperUtil.LuaToUserdata(L, 1, string_reset_to_begining, NGUITweenColorWrap.cache);
				nGUITweenColorWrap.component.ResetToBeginning();
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
				NGUITweenColorWrap nGUITweenColorWrap = null;
				nGUITweenColorWrap = WraperUtil.LuaToUserdata(L, 1, string_toggle, NGUITweenColorWrap.cache);
				nGUITweenColorWrap.component.Toggle();
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
				NGUITweenColorWrap nGUITweenColorWrap = null;
				nGUITweenColorWrap = WraperUtil.LuaToUserdata(L, 1, string_disable, NGUITweenColorWrap.cache);
				nGUITweenColorWrap.component.enabled = false;
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
				NGUITweenColorWrap nGUITweenColorWrap = null;
				string text = null;
				nGUITweenColorWrap = WraperUtil.LuaToUserdata(L, 1, string_set_on_finished, NGUITweenColorWrap.cache);
				text = LuaDLL.lua_tostring(L, 2);
				nGUITweenColorWrap.onFinish = text;
				result = 0;
			}
			return result;
		}

		[MonoPInvokeCallback(typeof(LuaCSFunction))]
		private static int set_from_color(IntPtr L)
		{
			int result = 0;
			if (WraperUtil.ValidIsUserdata(L, 1, string_set_from_color) && WraperUtil.ValidIsNumber(L, 2, string_set_from_color) && WraperUtil.ValidIsNumber(L, 3, string_set_from_color) && WraperUtil.ValidIsNumber(L, 4, string_set_from_color) && WraperUtil.ValidIsNumber(L, 5, string_set_from_color))
			{
				NGUITweenColorWrap nGUITweenColorWrap = null;
				int num = 0;
				int num2 = 0;
				int num3 = 0;
				int num4 = 0;
				nGUITweenColorWrap = WraperUtil.LuaToUserdata(L, 1, string_set_from_color, NGUITweenColorWrap.cache);
				num = (int)LuaDLL.lua_tonumber(L, 2);
				num2 = (int)LuaDLL.lua_tonumber(L, 3);
				num3 = (int)LuaDLL.lua_tonumber(L, 4);
				num4 = (int)LuaDLL.lua_tonumber(L, 5);
				nGUITweenColorWrap.component.from = new Color(num, num2, num3, num4);
				result = 0;
			}
			return result;
		}

		[MonoPInvokeCallback(typeof(LuaCSFunction))]
		private static int set_to_color(IntPtr L)
		{
			int result = 0;
			if (WraperUtil.ValidIsUserdata(L, 1, string_set_to_color) && WraperUtil.ValidIsNumber(L, 2, string_set_to_color) && WraperUtil.ValidIsNumber(L, 3, string_set_to_color) && WraperUtil.ValidIsNumber(L, 4, string_set_to_color) && WraperUtil.ValidIsNumber(L, 5, string_set_to_color))
			{
				NGUITweenColorWrap nGUITweenColorWrap = null;
				int num = 0;
				int num2 = 0;
				int num3 = 0;
				int num4 = 0;
				nGUITweenColorWrap = WraperUtil.LuaToUserdata(L, 1, string_set_to_color, NGUITweenColorWrap.cache);
				num = (int)LuaDLL.lua_tonumber(L, 2);
				num2 = (int)LuaDLL.lua_tonumber(L, 3);
				num3 = (int)LuaDLL.lua_tonumber(L, 4);
				num4 = (int)LuaDLL.lua_tonumber(L, 5);
				nGUITweenColorWrap.component.to = new Color(num, num2, num3, num4);
				result = 0;
			}
			return result;
		}

		[MonoPInvokeCallback(typeof(LuaCSFunction))]
		private static int gc(IntPtr L)
		{
			NGUITweenColorWrap nGUITweenColorWrap = WraperUtil.LuaToUserdataByGc(L, 1, "gc ngui_tween_color", NGUITweenColorWrap.cache);
			if (nGUITweenColorWrap != null)
			{
				nGUITweenColorWrap.DestroyInstance();
			}
			return 0;
		}
	}
}
