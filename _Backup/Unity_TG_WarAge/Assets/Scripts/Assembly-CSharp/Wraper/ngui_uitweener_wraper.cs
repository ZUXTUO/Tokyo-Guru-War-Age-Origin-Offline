using System;
using LuaInterface;
using UnityEngine;
using UnityWrap;

namespace Wraper
{
	public class ngui_uitweener_wraper
	{
		public static string name = "ngui_uitweener";

		private static luaL_Reg[] func = new luaL_Reg[21]
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
			new luaL_Reg("set_on_finished", set_on_finished)
		};

		private static string string_get_pid = "ngui_uitweener:get_pid";

		private static string string_set_active = "ngui_uitweener:set_active";

		private static string string_set_name = "ngui_uitweener:set_name";

		private static string string_get_name = "ngui_uitweener:get_name";

		private static string string_set_position = "ngui_uitweener:set_position";

		private static string string_get_position = "ngui_uitweener:get_position";

		private static string string_get_size = "ngui_uitweener:get_size";

		private static string string_get_game_object = "ngui_uitweener:get_game_object";

		private static string string_get_parent = "ngui_uitweener:get_parent";

		private static string string_set_parent = "ngui_uitweener:set_parent";

		private static string string_clone = "ngui_uitweener:clone";

		private static string string_destroy_object = "ngui_uitweener:destroy_object";

		private static string string_set_style = "ngui_uitweener:set_style";

		private static string string_set_duration = "ngui_uitweener:set_duration";

		private static string string_set_delay = "ngui_uitweener:set_delay";

		private static string string_play_foward = "ngui_uitweener:play_foward";

		private static string string_play_reverse = "ngui_uitweener:play_reverse";

		private static string string_reset_to_begining = "ngui_uitweener:reset_to_begining";

		private static string string_toggle = "ngui_uitweener:toggle";

		private static string string_disable = "ngui_uitweener:disable";

		private static string string_set_on_finished = "ngui_uitweener:set_on_finished";

		public static bool init(IntPtr L)
		{
			if (L != IntPtr.Zero)
			{
				LuaDLL.register_class(L, name, func, gc);
				return true;
			}
			return false;
		}

		public static void push(IntPtr L, NGUIUITweenerWrap obj)
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
				NGUIUITweenerWrap nGUIUITweenerWrap = null;
				nGUIUITweenerWrap = WraperUtil.LuaToUserdata(L, 1, string_get_pid, NGUIUITweenerWrap.cache);
				LuaDLL.lua_pushnumber(L, nGUIUITweenerWrap.GetPid());
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
				NGUIUITweenerWrap nGUIUITweenerWrap = null;
				bool flag = false;
				nGUIUITweenerWrap = WraperUtil.LuaToUserdata(L, 1, string_set_active, NGUIUITweenerWrap.cache);
				flag = LuaDLL.lua_toboolean(L, 2);
				nGUIUITweenerWrap.bcomponent.gameObject.SetActive(flag);
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
				NGUIUITweenerWrap nGUIUITweenerWrap = null;
				string text = null;
				nGUIUITweenerWrap = WraperUtil.LuaToUserdata(L, 1, string_set_name, NGUIUITweenerWrap.cache);
				text = LuaDLL.lua_tostring(L, 2);
				nGUIUITweenerWrap.bcomponent.gameObject.name = text;
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
				NGUIUITweenerWrap nGUIUITweenerWrap = null;
				nGUIUITweenerWrap = WraperUtil.LuaToUserdata(L, 1, string_get_name, NGUIUITweenerWrap.cache);
				LuaDLL.lua_pushstring(L, nGUIUITweenerWrap.bcomponent.gameObject.name);
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
				NGUIUITweenerWrap nGUIUITweenerWrap = null;
				float num = 0f;
				float num2 = 0f;
				float num3 = 0f;
				nGUIUITweenerWrap = WraperUtil.LuaToUserdata(L, 1, string_set_position, NGUIUITweenerWrap.cache);
				num = (float)LuaDLL.lua_tonumber(L, 2);
				num2 = (float)LuaDLL.lua_tonumber(L, 3);
				num3 = (float)LuaDLL.lua_tonumber(L, 4);
				nGUIUITweenerWrap.bcomponent.gameObject.transform.localPosition = new Vector3(num, num2, num3);
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
				NGUIUITweenerWrap nGUIUITweenerWrap = null;
				nGUIUITweenerWrap = WraperUtil.LuaToUserdata(L, 1, string_get_position, NGUIUITweenerWrap.cache);
				Vector3 localPosition = nGUIUITweenerWrap.bcomponent.gameObject.transform.localPosition;
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
				NGUIUITweenerWrap nGUIUITweenerWrap = null;
				nGUIUITweenerWrap = WraperUtil.LuaToUserdata(L, 1, string_get_size, NGUIUITweenerWrap.cache);
				int num = ((!(nGUIUITweenerWrap.widget == null)) ? nGUIUITweenerWrap.widget.width : 0);
				int num2 = ((!(nGUIUITweenerWrap.widget == null)) ? nGUIUITweenerWrap.widget.height : 0);
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
				NGUIUITweenerWrap nGUIUITweenerWrap = null;
				nGUIUITweenerWrap = WraperUtil.LuaToUserdata(L, 1, string_get_game_object, NGUIUITweenerWrap.cache);
				AssetGameObject base_object = AssetGameObject.CreateByInstance(nGUIUITweenerWrap.bcomponent.gameObject);
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
				NGUIUITweenerWrap nGUIUITweenerWrap = null;
				nGUIUITweenerWrap = WraperUtil.LuaToUserdata(L, 1, string_get_parent, NGUIUITweenerWrap.cache);
				AssetGameObject assetGameObject = null;
				Transform parent = nGUIUITweenerWrap.bcomponent.gameObject.transform.parent;
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
				NGUIUITweenerWrap nGUIUITweenerWrap = null;
				AssetGameObject assetGameObject = null;
				nGUIUITweenerWrap = WraperUtil.LuaToUserdata(L, 1, string_set_parent, NGUIUITweenerWrap.cache);
				assetGameObject = WraperUtil.LuaToUserdataOrNil(L, 2, string_set_parent, AssetGameObject.cache);
				nGUIUITweenerWrap.bcomponent.gameObject.transform.parent = ((assetGameObject != null) ? assetGameObject.transform : null);
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
				NGUIUITweenerWrap nGUIUITweenerWrap = null;
				nGUIUITweenerWrap = WraperUtil.LuaToUserdata(L, 1, string_clone, NGUIUITweenerWrap.cache);
				nGUIUITweenerWrap.Clone(L);
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
				NGUIUITweenerWrap nGUIUITweenerWrap = null;
				nGUIUITweenerWrap = WraperUtil.LuaToUserdata(L, 1, string_destroy_object, NGUIUITweenerWrap.cache);
				nGUIUITweenerWrap.isNeedDestroy = true;
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
				NGUIUITweenerWrap nGUIUITweenerWrap = null;
				int num = 0;
				nGUIUITweenerWrap = WraperUtil.LuaToUserdata(L, 1, string_set_style, NGUIUITweenerWrap.cache);
				switch ((int)LuaDLL.lua_tonumber(L, 2))
				{
				case 1:
					nGUIUITweenerWrap.component.style = UITweener.Style.Once;
					break;
				case 2:
					nGUIUITweenerWrap.component.style = UITweener.Style.Loop;
					break;
				case 3:
					nGUIUITweenerWrap.component.style = UITweener.Style.PingPong;
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
				NGUIUITweenerWrap nGUIUITweenerWrap = null;
				float num = 0f;
				nGUIUITweenerWrap = WraperUtil.LuaToUserdata(L, 1, string_set_duration, NGUIUITweenerWrap.cache);
				num = (float)LuaDLL.lua_tonumber(L, 2);
				nGUIUITweenerWrap.component.duration = num;
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
				NGUIUITweenerWrap nGUIUITweenerWrap = null;
				float num = 0f;
				nGUIUITweenerWrap = WraperUtil.LuaToUserdata(L, 1, string_set_delay, NGUIUITweenerWrap.cache);
				num = (float)LuaDLL.lua_tonumber(L, 2);
				nGUIUITweenerWrap.component.delay = num;
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
				NGUIUITweenerWrap nGUIUITweenerWrap = null;
				nGUIUITweenerWrap = WraperUtil.LuaToUserdata(L, 1, string_play_foward, NGUIUITweenerWrap.cache);
				nGUIUITweenerWrap.component.PlayForward();
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
				NGUIUITweenerWrap nGUIUITweenerWrap = null;
				nGUIUITweenerWrap = WraperUtil.LuaToUserdata(L, 1, string_play_reverse, NGUIUITweenerWrap.cache);
				nGUIUITweenerWrap.component.PlayReverse();
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
				NGUIUITweenerWrap nGUIUITweenerWrap = null;
				nGUIUITweenerWrap = WraperUtil.LuaToUserdata(L, 1, string_reset_to_begining, NGUIUITweenerWrap.cache);
				nGUIUITweenerWrap.component.ResetToBeginning();
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
				NGUIUITweenerWrap nGUIUITweenerWrap = null;
				nGUIUITweenerWrap = WraperUtil.LuaToUserdata(L, 1, string_toggle, NGUIUITweenerWrap.cache);
				nGUIUITweenerWrap.component.Toggle();
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
				NGUIUITweenerWrap nGUIUITweenerWrap = null;
				nGUIUITweenerWrap = WraperUtil.LuaToUserdata(L, 1, string_disable, NGUIUITweenerWrap.cache);
				nGUIUITweenerWrap.component.enabled = false;
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
				NGUIUITweenerWrap nGUIUITweenerWrap = null;
				string text = null;
				nGUIUITweenerWrap = WraperUtil.LuaToUserdata(L, 1, string_set_on_finished, NGUIUITweenerWrap.cache);
				text = LuaDLL.lua_tostring(L, 2);
				nGUIUITweenerWrap.onFinish = text;
				result = 0;
			}
			return result;
		}

		[MonoPInvokeCallback(typeof(LuaCSFunction))]
		private static int gc(IntPtr L)
		{
			NGUIUITweenerWrap nGUIUITweenerWrap = WraperUtil.LuaToUserdataByGc(L, 1, "gc ngui_uitweener", NGUIUITweenerWrap.cache);
			if (nGUIUITweenerWrap != null)
			{
				nGUIUITweenerWrap.DestroyInstance();
			}
			return 0;
		}
	}
}
