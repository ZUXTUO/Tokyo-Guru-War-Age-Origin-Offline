using System;
using LuaInterface;
using UnityEngine;
using UnityWrap;

namespace Wraper
{
	public class ngui_tween_position_wraper
	{
		public static string name = "ngui_tween_position";

		private static luaL_Reg[] func = new luaL_Reg[26]
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
			new luaL_Reg("set_from_postion", set_from_postion),
			new luaL_Reg("set_to_postion", set_to_postion),
			new luaL_Reg("get_to_postion", get_to_postion),
			new luaL_Reg("clear_on_finished", clear_on_finished),
			new luaL_Reg("set_bezier", set_bezier)
		};

		private static string string_get_pid = "ngui_tween_position:get_pid";

		private static string string_set_active = "ngui_tween_position:set_active";

		private static string string_set_name = "ngui_tween_position:set_name";

		private static string string_get_name = "ngui_tween_position:get_name";

		private static string string_set_position = "ngui_tween_position:set_position";

		private static string string_get_position = "ngui_tween_position:get_position";

		private static string string_get_size = "ngui_tween_position:get_size";

		private static string string_get_game_object = "ngui_tween_position:get_game_object";

		private static string string_get_parent = "ngui_tween_position:get_parent";

		private static string string_set_parent = "ngui_tween_position:set_parent";

		private static string string_clone = "ngui_tween_position:clone";

		private static string string_destroy_object = "ngui_tween_position:destroy_object";

		private static string string_set_style = "ngui_tween_position:set_style";

		private static string string_set_duration = "ngui_tween_position:set_duration";

		private static string string_set_delay = "ngui_tween_position:set_delay";

		private static string string_play_foward = "ngui_tween_position:play_foward";

		private static string string_play_reverse = "ngui_tween_position:play_reverse";

		private static string string_reset_to_begining = "ngui_tween_position:reset_to_begining";

		private static string string_toggle = "ngui_tween_position:toggle";

		private static string string_disable = "ngui_tween_position:disable";

		private static string string_set_on_finished = "ngui_tween_position:set_on_finished";

		private static string string_clear_on_finished = "ngui_tween_position:clear_on_finished";

		private static string string_set_from_postion = "ngui_tween_position:set_from_postion";

		private static string string_set_to_postion = "ngui_tween_position:set_to_postion";

		private static string string_get_to_postion = "ngui_tween_position:get_to_postion";

		private static string string_set_bezier = "ngui_tween_position:set_bezier";

		public static bool init(IntPtr L)
		{
			if (L != IntPtr.Zero)
			{
				LuaDLL.register_class(L, name, func, gc);
				return true;
			}
			return false;
		}

		public static void push(IntPtr L, NGUITweenPositionWrap obj)
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
				NGUITweenPositionWrap nGUITweenPositionWrap = null;
				nGUITweenPositionWrap = WraperUtil.LuaToUserdata(L, 1, string_get_pid, NGUITweenPositionWrap.cache);
				LuaDLL.lua_pushnumber(L, nGUITweenPositionWrap.GetPid());
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
				NGUITweenPositionWrap nGUITweenPositionWrap = null;
				bool flag = false;
				nGUITweenPositionWrap = WraperUtil.LuaToUserdata(L, 1, string_set_active, NGUITweenPositionWrap.cache);
				flag = LuaDLL.lua_toboolean(L, 2);
				nGUITweenPositionWrap.bcomponent.gameObject.SetActive(flag);
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
				NGUITweenPositionWrap nGUITweenPositionWrap = null;
				string text = null;
				nGUITweenPositionWrap = WraperUtil.LuaToUserdata(L, 1, string_set_name, NGUITweenPositionWrap.cache);
				text = LuaDLL.lua_tostring(L, 2);
				nGUITweenPositionWrap.bcomponent.gameObject.name = text;
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
				NGUITweenPositionWrap nGUITweenPositionWrap = null;
				nGUITweenPositionWrap = WraperUtil.LuaToUserdata(L, 1, string_get_name, NGUITweenPositionWrap.cache);
				LuaDLL.lua_pushstring(L, nGUITweenPositionWrap.bcomponent.gameObject.name);
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
				NGUITweenPositionWrap nGUITweenPositionWrap = null;
				float num = 0f;
				float num2 = 0f;
				float num3 = 0f;
				nGUITweenPositionWrap = WraperUtil.LuaToUserdata(L, 1, string_set_position, NGUITweenPositionWrap.cache);
				num = (float)LuaDLL.lua_tonumber(L, 2);
				num2 = (float)LuaDLL.lua_tonumber(L, 3);
				num3 = (float)LuaDLL.lua_tonumber(L, 4);
				nGUITweenPositionWrap.bcomponent.gameObject.transform.localPosition = new Vector3(num, num2, num3);
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
				NGUITweenPositionWrap nGUITweenPositionWrap = null;
				nGUITweenPositionWrap = WraperUtil.LuaToUserdata(L, 1, string_get_position, NGUITweenPositionWrap.cache);
				Vector3 localPosition = nGUITweenPositionWrap.bcomponent.gameObject.transform.localPosition;
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
				NGUITweenPositionWrap nGUITweenPositionWrap = null;
				nGUITweenPositionWrap = WraperUtil.LuaToUserdata(L, 1, string_get_size, NGUITweenPositionWrap.cache);
				int num = ((!(nGUITweenPositionWrap.widget == null)) ? nGUITweenPositionWrap.widget.width : 0);
				int num2 = ((!(nGUITweenPositionWrap.widget == null)) ? nGUITweenPositionWrap.widget.height : 0);
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
				NGUITweenPositionWrap nGUITweenPositionWrap = null;
				nGUITweenPositionWrap = WraperUtil.LuaToUserdata(L, 1, string_get_game_object, NGUITweenPositionWrap.cache);
				AssetGameObject base_object = AssetGameObject.CreateByInstance(nGUITweenPositionWrap.bcomponent.gameObject);
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
				NGUITweenPositionWrap nGUITweenPositionWrap = null;
				nGUITweenPositionWrap = WraperUtil.LuaToUserdata(L, 1, string_get_parent, NGUITweenPositionWrap.cache);
				AssetGameObject assetGameObject = null;
				Transform parent = nGUITweenPositionWrap.bcomponent.gameObject.transform.parent;
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
				NGUITweenPositionWrap nGUITweenPositionWrap = null;
				AssetGameObject assetGameObject = null;
				nGUITweenPositionWrap = WraperUtil.LuaToUserdata(L, 1, string_set_parent, NGUITweenPositionWrap.cache);
				assetGameObject = WraperUtil.LuaToUserdataOrNil(L, 2, string_set_parent, AssetGameObject.cache);
				nGUITweenPositionWrap.bcomponent.gameObject.transform.parent = ((assetGameObject != null) ? assetGameObject.transform : null);
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
				NGUITweenPositionWrap nGUITweenPositionWrap = null;
				nGUITweenPositionWrap = WraperUtil.LuaToUserdata(L, 1, string_clone, NGUITweenPositionWrap.cache);
				nGUITweenPositionWrap.Clone(L);
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
				NGUITweenPositionWrap nGUITweenPositionWrap = null;
				nGUITweenPositionWrap = WraperUtil.LuaToUserdata(L, 1, string_destroy_object, NGUITweenPositionWrap.cache);
				nGUITweenPositionWrap.isNeedDestroy = true;
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
				NGUITweenPositionWrap nGUITweenPositionWrap = null;
				int num = 0;
				nGUITweenPositionWrap = WraperUtil.LuaToUserdata(L, 1, string_set_style, NGUITweenPositionWrap.cache);
				switch ((int)LuaDLL.lua_tonumber(L, 2))
				{
				case 1:
					nGUITweenPositionWrap.component.style = UITweener.Style.Once;
					break;
				case 2:
					nGUITweenPositionWrap.component.style = UITweener.Style.Loop;
					break;
				case 3:
					nGUITweenPositionWrap.component.style = UITweener.Style.PingPong;
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
				NGUITweenPositionWrap nGUITweenPositionWrap = null;
				float num = 0f;
				nGUITweenPositionWrap = WraperUtil.LuaToUserdata(L, 1, string_set_duration, NGUITweenPositionWrap.cache);
				num = (float)LuaDLL.lua_tonumber(L, 2);
				nGUITweenPositionWrap.component.duration = num;
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
				NGUITweenPositionWrap nGUITweenPositionWrap = null;
				float num = 0f;
				nGUITweenPositionWrap = WraperUtil.LuaToUserdata(L, 1, string_set_delay, NGUITweenPositionWrap.cache);
				num = (float)LuaDLL.lua_tonumber(L, 2);
				nGUITweenPositionWrap.component.delay = num;
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
				NGUITweenPositionWrap nGUITweenPositionWrap = null;
				nGUITweenPositionWrap = WraperUtil.LuaToUserdata(L, 1, string_play_foward, NGUITweenPositionWrap.cache);
				nGUITweenPositionWrap.component.PlayForward();
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
				NGUITweenPositionWrap nGUITweenPositionWrap = null;
				nGUITweenPositionWrap = WraperUtil.LuaToUserdata(L, 1, string_play_reverse, NGUITweenPositionWrap.cache);
				nGUITweenPositionWrap.component.PlayReverse();
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
				NGUITweenPositionWrap nGUITweenPositionWrap = null;
				nGUITweenPositionWrap = WraperUtil.LuaToUserdata(L, 1, string_reset_to_begining, NGUITweenPositionWrap.cache);
				nGUITweenPositionWrap.component.ResetToBeginning();
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
				NGUITweenPositionWrap nGUITweenPositionWrap = null;
				nGUITweenPositionWrap = WraperUtil.LuaToUserdata(L, 1, string_toggle, NGUITweenPositionWrap.cache);
				nGUITweenPositionWrap.component.Toggle();
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
				NGUITweenPositionWrap nGUITweenPositionWrap = null;
				nGUITweenPositionWrap = WraperUtil.LuaToUserdata(L, 1, string_disable, NGUITweenPositionWrap.cache);
				nGUITweenPositionWrap.component.enabled = false;
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
				NGUITweenPositionWrap nGUITweenPositionWrap = null;
				string text = null;
				nGUITweenPositionWrap = WraperUtil.LuaToUserdata(L, 1, string_set_on_finished, NGUITweenPositionWrap.cache);
				text = LuaDLL.lua_tostring(L, 2);
				nGUITweenPositionWrap.onFinish = text;
				result = 0;
			}
			return result;
		}

		[MonoPInvokeCallback(typeof(LuaCSFunction))]
		private static int clear_on_finished(IntPtr L)
		{
			int result = 0;
			if (WraperUtil.ValidIsUserdata(L, 1, string_clear_on_finished))
			{
				NGUITweenPositionWrap nGUITweenPositionWrap = null;
				nGUITweenPositionWrap = WraperUtil.LuaToUserdata(L, 1, string_clear_on_finished, NGUITweenPositionWrap.cache);
				nGUITweenPositionWrap.component.onFinished.Clear();
				result = 0;
			}
			return result;
		}

		[MonoPInvokeCallback(typeof(LuaCSFunction))]
		private static int set_from_postion(IntPtr L)
		{
			int result = 0;
			if (WraperUtil.ValidIsUserdata(L, 1, string_set_from_postion) && WraperUtil.ValidIsNumber(L, 2, string_set_from_postion) && WraperUtil.ValidIsNumber(L, 3, string_set_from_postion) && WraperUtil.ValidIsNumber(L, 4, string_set_from_postion))
			{
				NGUITweenPositionWrap nGUITweenPositionWrap = null;
				int num = 0;
				int num2 = 0;
				int num3 = 0;
				nGUITweenPositionWrap = WraperUtil.LuaToUserdata(L, 1, string_set_from_postion, NGUITweenPositionWrap.cache);
				num = (int)LuaDLL.lua_tonumber(L, 2);
				num2 = (int)LuaDLL.lua_tonumber(L, 3);
				num3 = (int)LuaDLL.lua_tonumber(L, 4);
				nGUITweenPositionWrap.component.from = new Vector3(num, num2, num3);
				result = 0;
			}
			return result;
		}

		[MonoPInvokeCallback(typeof(LuaCSFunction))]
		private static int set_to_postion(IntPtr L)
		{
			int result = 0;
			if (WraperUtil.ValidIsUserdata(L, 1, string_set_to_postion) && WraperUtil.ValidIsNumber(L, 2, string_set_to_postion) && WraperUtil.ValidIsNumber(L, 3, string_set_to_postion) && WraperUtil.ValidIsNumber(L, 4, string_set_to_postion))
			{
				NGUITweenPositionWrap nGUITweenPositionWrap = null;
				int num = 0;
				int num2 = 0;
				int num3 = 0;
				nGUITweenPositionWrap = WraperUtil.LuaToUserdata(L, 1, string_set_to_postion, NGUITweenPositionWrap.cache);
				num = (int)LuaDLL.lua_tonumber(L, 2);
				num2 = (int)LuaDLL.lua_tonumber(L, 3);
				num3 = (int)LuaDLL.lua_tonumber(L, 4);
				nGUITweenPositionWrap.component.to = new Vector3(num, num2, num3);
				result = 0;
			}
			return result;
		}

		[MonoPInvokeCallback(typeof(LuaCSFunction))]
		private static int get_to_postion(IntPtr L)
		{
			int result = 0;
			if (WraperUtil.ValidIsUserdata(L, 1, string_get_to_postion))
			{
				NGUITweenPositionWrap nGUITweenPositionWrap = null;
				nGUITweenPositionWrap = WraperUtil.LuaToUserdata(L, 1, string_set_to_postion, NGUITweenPositionWrap.cache);
				Vector3 to = nGUITweenPositionWrap.component.to;
				LuaDLL.lua_pushnumber(L, nGUITweenPositionWrap.component.to.x);
				LuaDLL.lua_pushnumber(L, nGUITweenPositionWrap.component.to.y);
				LuaDLL.lua_pushnumber(L, nGUITweenPositionWrap.component.to.z);
				result = 3;
			}
			return result;
		}

		[MonoPInvokeCallback(typeof(LuaCSFunction))]
		private static int set_bezier(IntPtr L)
		{
			int result = 0;
			if (WraperUtil.ValidIsUserdata(L, 1, string_set_bezier) && WraperUtil.ValidIsBoolean(L, 2, string_set_bezier) && WraperUtil.ValidIsNumber(L, 3, string_set_bezier) && WraperUtil.ValidIsNumber(L, 4, string_set_bezier) && WraperUtil.ValidIsNumber(L, 5, string_set_bezier) && WraperUtil.ValidIsNumber(L, 6, string_set_bezier) && WraperUtil.ValidIsNumber(L, 7, string_set_bezier) && WraperUtil.ValidIsNumber(L, 8, string_set_bezier))
			{
				bool isBezier = LuaDLL.lua_toboolean(L, 2);
				float x = (float)LuaDLL.lua_tonumber(L, 3);
				float y = (float)LuaDLL.lua_tonumber(L, 4);
				float z = (float)LuaDLL.lua_tonumber(L, 5);
				float x2 = (float)LuaDLL.lua_tonumber(L, 6);
				float y2 = (float)LuaDLL.lua_tonumber(L, 7);
				float z2 = (float)LuaDLL.lua_tonumber(L, 8);
				NGUITweenPositionWrap nGUITweenPositionWrap = null;
				nGUITweenPositionWrap = WraperUtil.LuaToUserdata(L, 1, string_set_from_postion, NGUITweenPositionWrap.cache);
				nGUITweenPositionWrap.component.isBezier = isBezier;
				nGUITweenPositionWrap.component.p0 = new Vector3(x, y, z);
				nGUITweenPositionWrap.component.p1 = new Vector3(x2, y2, z2);
				result = 0;
			}
			return result;
		}

		[MonoPInvokeCallback(typeof(LuaCSFunction))]
		private static int gc(IntPtr L)
		{
			NGUITweenPositionWrap nGUITweenPositionWrap = WraperUtil.LuaToUserdataByGc(L, 1, "gc ngui_tween_position", NGUITweenPositionWrap.cache);
			if (nGUITweenPositionWrap != null)
			{
				nGUITweenPositionWrap.DestroyInstance();
			}
			return 0;
		}
	}
}
