using System;
using LuaInterface;
using UnityEngine;
using UnityWrap;

namespace Wraper
{
	public class ngui_tween_rotation_wraper
	{
		public static string name = "ngui_tween_rotation";

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
			new luaL_Reg("set_from_rotation", set_from_rotation),
			new luaL_Reg("set_to_rotation", set_to_rotation)
		};

		private static string string_get_pid = "ngui_tween_rotation:get_pid";

		private static string string_set_active = "ngui_tween_rotation:set_active";

		private static string string_set_name = "ngui_tween_rotation:set_name";

		private static string string_get_name = "ngui_tween_rotation:get_name";

		private static string string_set_position = "ngui_tween_rotation:set_position";

		private static string string_get_position = "ngui_tween_rotation:get_position";

		private static string string_get_size = "ngui_tween_rotation:get_size";

		private static string string_get_game_object = "ngui_tween_rotation:get_game_object";

		private static string string_get_parent = "ngui_tween_rotation:get_parent";

		private static string string_set_parent = "ngui_tween_rotation:set_parent";

		private static string string_clone = "ngui_tween_rotation:clone";

		private static string string_destroy_object = "ngui_tween_rotation:destroy_object";

		private static string string_set_style = "ngui_tween_rotation:set_style";

		private static string string_set_duration = "ngui_tween_rotation:set_duration";

		private static string string_set_delay = "ngui_tween_rotation:set_delay";

		private static string string_play_foward = "ngui_tween_rotation:play_foward";

		private static string string_play_reverse = "ngui_tween_rotation:play_reverse";

		private static string string_reset_to_begining = "ngui_tween_rotation:reset_to_begining";

		private static string string_toggle = "ngui_tween_rotation:toggle";

		private static string string_disable = "ngui_tween_rotation:disable";

		private static string string_set_on_finished = "ngui_tween_rotation:set_on_finished";

		private static string string_set_from_rotation = "ngui_tween_rotation:set_from_rotation";

		private static string string_set_to_rotation = "ngui_tween_rotation:set_to_rotation";

		public static bool init(IntPtr L)
		{
			if (L != IntPtr.Zero)
			{
				LuaDLL.register_class(L, name, func, gc);
				return true;
			}
			return false;
		}

		public static void push(IntPtr L, NGUITweenRotationWrap obj)
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
				NGUITweenRotationWrap nGUITweenRotationWrap = null;
				nGUITweenRotationWrap = WraperUtil.LuaToUserdata(L, 1, string_get_pid, NGUITweenRotationWrap.cache);
				LuaDLL.lua_pushnumber(L, nGUITweenRotationWrap.GetPid());
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
				NGUITweenRotationWrap nGUITweenRotationWrap = null;
				bool flag = false;
				nGUITweenRotationWrap = WraperUtil.LuaToUserdata(L, 1, string_set_active, NGUITweenRotationWrap.cache);
				flag = LuaDLL.lua_toboolean(L, 2);
				nGUITweenRotationWrap.bcomponent.gameObject.SetActive(flag);
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
				NGUITweenRotationWrap nGUITweenRotationWrap = null;
				string text = null;
				nGUITweenRotationWrap = WraperUtil.LuaToUserdata(L, 1, string_set_name, NGUITweenRotationWrap.cache);
				text = LuaDLL.lua_tostring(L, 2);
				nGUITweenRotationWrap.bcomponent.gameObject.name = text;
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
				NGUITweenRotationWrap nGUITweenRotationWrap = null;
				nGUITweenRotationWrap = WraperUtil.LuaToUserdata(L, 1, string_get_name, NGUITweenRotationWrap.cache);
				LuaDLL.lua_pushstring(L, nGUITweenRotationWrap.bcomponent.gameObject.name);
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
				NGUITweenRotationWrap nGUITweenRotationWrap = null;
				float num = 0f;
				float num2 = 0f;
				float num3 = 0f;
				nGUITweenRotationWrap = WraperUtil.LuaToUserdata(L, 1, string_set_position, NGUITweenRotationWrap.cache);
				num = (float)LuaDLL.lua_tonumber(L, 2);
				num2 = (float)LuaDLL.lua_tonumber(L, 3);
				num3 = (float)LuaDLL.lua_tonumber(L, 4);
				nGUITweenRotationWrap.bcomponent.gameObject.transform.localPosition = new Vector3(num, num2, num3);
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
				NGUITweenRotationWrap nGUITweenRotationWrap = null;
				nGUITweenRotationWrap = WraperUtil.LuaToUserdata(L, 1, string_get_position, NGUITweenRotationWrap.cache);
				Vector3 localPosition = nGUITweenRotationWrap.bcomponent.gameObject.transform.localPosition;
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
				NGUITweenRotationWrap nGUITweenRotationWrap = null;
				nGUITweenRotationWrap = WraperUtil.LuaToUserdata(L, 1, string_get_size, NGUITweenRotationWrap.cache);
				int num = ((!(nGUITweenRotationWrap.widget == null)) ? nGUITweenRotationWrap.widget.width : 0);
				int num2 = ((!(nGUITweenRotationWrap.widget == null)) ? nGUITweenRotationWrap.widget.height : 0);
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
				NGUITweenRotationWrap nGUITweenRotationWrap = null;
				nGUITweenRotationWrap = WraperUtil.LuaToUserdata(L, 1, string_get_game_object, NGUITweenRotationWrap.cache);
				AssetGameObject base_object = AssetGameObject.CreateByInstance(nGUITweenRotationWrap.bcomponent.gameObject);
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
				NGUITweenRotationWrap nGUITweenRotationWrap = null;
				nGUITweenRotationWrap = WraperUtil.LuaToUserdata(L, 1, string_get_parent, NGUITweenRotationWrap.cache);
				AssetGameObject assetGameObject = null;
				Transform parent = nGUITweenRotationWrap.bcomponent.gameObject.transform.parent;
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
				NGUITweenRotationWrap nGUITweenRotationWrap = null;
				AssetGameObject assetGameObject = null;
				nGUITweenRotationWrap = WraperUtil.LuaToUserdata(L, 1, string_set_parent, NGUITweenRotationWrap.cache);
				assetGameObject = WraperUtil.LuaToUserdataOrNil(L, 2, string_set_parent, AssetGameObject.cache);
				nGUITweenRotationWrap.bcomponent.gameObject.transform.parent = ((assetGameObject != null) ? assetGameObject.transform : null);
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
				NGUITweenRotationWrap nGUITweenRotationWrap = null;
				nGUITweenRotationWrap = WraperUtil.LuaToUserdata(L, 1, string_clone, NGUITweenRotationWrap.cache);
				nGUITweenRotationWrap.Clone(L);
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
				NGUITweenRotationWrap nGUITweenRotationWrap = null;
				nGUITweenRotationWrap = WraperUtil.LuaToUserdata(L, 1, string_destroy_object, NGUITweenRotationWrap.cache);
				nGUITweenRotationWrap.isNeedDestroy = true;
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
				NGUITweenRotationWrap nGUITweenRotationWrap = null;
				int num = 0;
				nGUITweenRotationWrap = WraperUtil.LuaToUserdata(L, 1, string_set_style, NGUITweenRotationWrap.cache);
				switch ((int)LuaDLL.lua_tonumber(L, 2))
				{
				case 1:
					nGUITweenRotationWrap.component.style = UITweener.Style.Once;
					break;
				case 2:
					nGUITweenRotationWrap.component.style = UITweener.Style.Loop;
					break;
				case 3:
					nGUITweenRotationWrap.component.style = UITweener.Style.PingPong;
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
				NGUITweenRotationWrap nGUITweenRotationWrap = null;
				float num = 0f;
				nGUITweenRotationWrap = WraperUtil.LuaToUserdata(L, 1, string_set_duration, NGUITweenRotationWrap.cache);
				num = (float)LuaDLL.lua_tonumber(L, 2);
				nGUITweenRotationWrap.component.duration = num;
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
				NGUITweenRotationWrap nGUITweenRotationWrap = null;
				float num = 0f;
				nGUITweenRotationWrap = WraperUtil.LuaToUserdata(L, 1, string_set_delay, NGUITweenRotationWrap.cache);
				num = (float)LuaDLL.lua_tonumber(L, 2);
				nGUITweenRotationWrap.component.delay = num;
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
				NGUITweenRotationWrap nGUITweenRotationWrap = null;
				nGUITweenRotationWrap = WraperUtil.LuaToUserdata(L, 1, string_play_foward, NGUITweenRotationWrap.cache);
				nGUITweenRotationWrap.component.PlayForward();
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
				NGUITweenRotationWrap nGUITweenRotationWrap = null;
				nGUITweenRotationWrap = WraperUtil.LuaToUserdata(L, 1, string_play_reverse, NGUITweenRotationWrap.cache);
				nGUITweenRotationWrap.component.PlayReverse();
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
				NGUITweenRotationWrap nGUITweenRotationWrap = null;
				nGUITweenRotationWrap = WraperUtil.LuaToUserdata(L, 1, string_reset_to_begining, NGUITweenRotationWrap.cache);
				nGUITweenRotationWrap.component.ResetToBeginning();
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
				NGUITweenRotationWrap nGUITweenRotationWrap = null;
				nGUITweenRotationWrap = WraperUtil.LuaToUserdata(L, 1, string_toggle, NGUITweenRotationWrap.cache);
				nGUITweenRotationWrap.component.Toggle();
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
				NGUITweenRotationWrap nGUITweenRotationWrap = null;
				nGUITweenRotationWrap = WraperUtil.LuaToUserdata(L, 1, string_disable, NGUITweenRotationWrap.cache);
				nGUITweenRotationWrap.component.enabled = false;
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
				NGUITweenRotationWrap nGUITweenRotationWrap = null;
				string text = null;
				nGUITweenRotationWrap = WraperUtil.LuaToUserdata(L, 1, string_set_on_finished, NGUITweenRotationWrap.cache);
				text = LuaDLL.lua_tostring(L, 2);
				nGUITweenRotationWrap.onFinish = text;
				result = 0;
			}
			return result;
		}

		[MonoPInvokeCallback(typeof(LuaCSFunction))]
		private static int set_from_rotation(IntPtr L)
		{
			int result = 0;
			if (WraperUtil.ValidIsUserdata(L, 1, string_set_from_rotation) && WraperUtil.ValidIsNumber(L, 2, string_set_from_rotation) && WraperUtil.ValidIsNumber(L, 3, string_set_from_rotation) && WraperUtil.ValidIsNumber(L, 4, string_set_from_rotation))
			{
				NGUITweenRotationWrap nGUITweenRotationWrap = null;
				int num = 0;
				int num2 = 0;
				int num3 = 0;
				nGUITweenRotationWrap = WraperUtil.LuaToUserdata(L, 1, string_set_from_rotation, NGUITweenRotationWrap.cache);
				num = (int)LuaDLL.lua_tonumber(L, 2);
				num2 = (int)LuaDLL.lua_tonumber(L, 3);
				num3 = (int)LuaDLL.lua_tonumber(L, 4);
				nGUITweenRotationWrap.component.from = new Vector3(num, num2, num3);
				result = 0;
			}
			return result;
		}

		[MonoPInvokeCallback(typeof(LuaCSFunction))]
		private static int set_to_rotation(IntPtr L)
		{
			int result = 0;
			if (WraperUtil.ValidIsUserdata(L, 1, string_set_to_rotation) && WraperUtil.ValidIsNumber(L, 2, string_set_to_rotation) && WraperUtil.ValidIsNumber(L, 3, string_set_to_rotation) && WraperUtil.ValidIsNumber(L, 4, string_set_to_rotation))
			{
				NGUITweenRotationWrap nGUITweenRotationWrap = null;
				int num = 0;
				int num2 = 0;
				int num3 = 0;
				nGUITweenRotationWrap = WraperUtil.LuaToUserdata(L, 1, string_set_to_rotation, NGUITweenRotationWrap.cache);
				num = (int)LuaDLL.lua_tonumber(L, 2);
				num2 = (int)LuaDLL.lua_tonumber(L, 3);
				num3 = (int)LuaDLL.lua_tonumber(L, 4);
				nGUITweenRotationWrap.component.to = new Vector3(num, num2, num3);
				result = 0;
			}
			return result;
		}

		[MonoPInvokeCallback(typeof(LuaCSFunction))]
		private static int gc(IntPtr L)
		{
			NGUITweenRotationWrap nGUITweenRotationWrap = WraperUtil.LuaToUserdataByGc(L, 1, "gc ngui_tween_rotation", NGUITweenRotationWrap.cache);
			if (nGUITweenRotationWrap != null)
			{
				nGUITweenRotationWrap.DestroyInstance();
			}
			return 0;
		}
	}
}
