using System;
using LuaInterface;
using UnityEngine;
using UnityWrap;

namespace Wraper
{
	public class ngui_scroll_view_wraper
	{
		public static string name = "ngui_scroll_view";

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
			new luaL_Reg("reset_position", reset_position),
			new luaL_Reg("set_on_drag_started", set_on_drag_started),
			new luaL_Reg("set_on_drag_finished", set_on_drag_finished),
			new luaL_Reg("update_position", update_position),
			new luaL_Reg("get_bounds_box", get_bounds_box),
			new luaL_Reg("move_relative", move_relative),
			new luaL_Reg("set_enable", set_enable),
			new luaL_Reg("set_restrict_within_panel", set_restrict_within_panel),
			new luaL_Reg("set_drag_amount", set_drag_amount)
		};

		private static string string_get_pid = "ngui_scroll_view:get_pid";

		private static string string_set_active = "ngui_scroll_view:set_active";

		private static string string_set_name = "ngui_scroll_view:set_name";

		private static string string_get_name = "ngui_scroll_view:get_name";

		private static string string_set_position = "ngui_scroll_view:set_position";

		private static string string_get_position = "ngui_scroll_view:get_position";

		private static string string_get_size = "ngui_scroll_view:get_size";

		private static string string_get_game_object = "ngui_scroll_view:get_game_object";

		private static string string_get_parent = "ngui_scroll_view:get_parent";

		private static string string_set_parent = "ngui_scroll_view:set_parent";

		private static string string_clone = "ngui_scroll_view:clone";

		private static string string_destroy_object = "ngui_scroll_view:destroy_object";

		private static string string_reset_position = "ngui_scroll_view:reset_position";

		private static string string_set_on_drag_started = "ngui_scroll_view:set_on_drag_started";

		private static string string_set_on_drag_finished = "ngui_scroll_view:set_on_drag_finished";

		private static string string_update_position = "ngui_scroll_view:update_position";

		private static string string_get_bounds_box = "ngui_scroll_view:get_bounds_box";

		private static string string_move_relative = "ngui_scroll_view:move_relative";

		private static string string_set_enable = "ngui_scroll_view:set_enable";

		private static string string_set_restrict_within_panel = "ngui_scroll_view:set_restrict_within_panel";

		private static string string_set_drag_amount = "ngui_scroll_view:set_drag_amount";

		public static bool init(IntPtr L)
		{
			if (L != IntPtr.Zero)
			{
				LuaDLL.register_class(L, name, func, gc);
				return true;
			}
			return false;
		}

		public static void push(IntPtr L, NGUIScrollViewWrap obj)
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
				NGUIScrollViewWrap nGUIScrollViewWrap = null;
				nGUIScrollViewWrap = WraperUtil.LuaToUserdata(L, 1, string_get_pid, NGUIScrollViewWrap.cache);
				LuaDLL.lua_pushnumber(L, nGUIScrollViewWrap.GetPid());
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
				NGUIScrollViewWrap nGUIScrollViewWrap = null;
				bool flag = false;
				nGUIScrollViewWrap = WraperUtil.LuaToUserdata(L, 1, string_set_active, NGUIScrollViewWrap.cache);
				flag = LuaDLL.lua_toboolean(L, 2);
				nGUIScrollViewWrap.bcomponent.gameObject.SetActive(flag);
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
				NGUIScrollViewWrap nGUIScrollViewWrap = null;
				string text = null;
				nGUIScrollViewWrap = WraperUtil.LuaToUserdata(L, 1, string_set_name, NGUIScrollViewWrap.cache);
				text = LuaDLL.lua_tostring(L, 2);
				nGUIScrollViewWrap.bcomponent.gameObject.name = text;
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
				NGUIScrollViewWrap nGUIScrollViewWrap = null;
				nGUIScrollViewWrap = WraperUtil.LuaToUserdata(L, 1, string_get_name, NGUIScrollViewWrap.cache);
				LuaDLL.lua_pushstring(L, nGUIScrollViewWrap.bcomponent.gameObject.name);
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
				NGUIScrollViewWrap nGUIScrollViewWrap = null;
				float num = 0f;
				float num2 = 0f;
				float num3 = 0f;
				nGUIScrollViewWrap = WraperUtil.LuaToUserdata(L, 1, string_set_position, NGUIScrollViewWrap.cache);
				num = (float)LuaDLL.lua_tonumber(L, 2);
				num2 = (float)LuaDLL.lua_tonumber(L, 3);
				num3 = (float)LuaDLL.lua_tonumber(L, 4);
				nGUIScrollViewWrap.bcomponent.gameObject.transform.localPosition = new Vector3(num, num2, num3);
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
				NGUIScrollViewWrap nGUIScrollViewWrap = null;
				nGUIScrollViewWrap = WraperUtil.LuaToUserdata(L, 1, string_get_position, NGUIScrollViewWrap.cache);
				Vector3 localPosition = nGUIScrollViewWrap.bcomponent.gameObject.transform.localPosition;
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
				NGUIScrollViewWrap nGUIScrollViewWrap = null;
				nGUIScrollViewWrap = WraperUtil.LuaToUserdata(L, 1, string_get_size, NGUIScrollViewWrap.cache);
				int num = ((!(nGUIScrollViewWrap.widget == null)) ? nGUIScrollViewWrap.widget.width : 0);
				int num2 = ((!(nGUIScrollViewWrap.widget == null)) ? nGUIScrollViewWrap.widget.height : 0);
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
				NGUIScrollViewWrap nGUIScrollViewWrap = null;
				nGUIScrollViewWrap = WraperUtil.LuaToUserdata(L, 1, string_get_game_object, NGUIScrollViewWrap.cache);
				AssetGameObject base_object = AssetGameObject.CreateByInstance(nGUIScrollViewWrap.bcomponent.gameObject);
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
				NGUIScrollViewWrap nGUIScrollViewWrap = null;
				nGUIScrollViewWrap = WraperUtil.LuaToUserdata(L, 1, string_get_parent, NGUIScrollViewWrap.cache);
				AssetGameObject assetGameObject = null;
				Transform parent = nGUIScrollViewWrap.bcomponent.gameObject.transform.parent;
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
				NGUIScrollViewWrap nGUIScrollViewWrap = null;
				AssetGameObject assetGameObject = null;
				nGUIScrollViewWrap = WraperUtil.LuaToUserdata(L, 1, string_set_parent, NGUIScrollViewWrap.cache);
				assetGameObject = WraperUtil.LuaToUserdataOrNil(L, 2, string_set_parent, AssetGameObject.cache);
				nGUIScrollViewWrap.bcomponent.gameObject.transform.parent = ((assetGameObject != null) ? assetGameObject.transform : null);
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
				NGUIScrollViewWrap nGUIScrollViewWrap = null;
				nGUIScrollViewWrap = WraperUtil.LuaToUserdata(L, 1, string_clone, NGUIScrollViewWrap.cache);
				nGUIScrollViewWrap.Clone(L);
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
				NGUIScrollViewWrap nGUIScrollViewWrap = null;
				nGUIScrollViewWrap = WraperUtil.LuaToUserdata(L, 1, string_destroy_object, NGUIScrollViewWrap.cache);
				nGUIScrollViewWrap.isNeedDestroy = true;
				result = 0;
			}
			return result;
		}

		[MonoPInvokeCallback(typeof(LuaCSFunction))]
		private static int reset_position(IntPtr L)
		{
			int result = 0;
			if (WraperUtil.ValidIsUserdata(L, 1, string_reset_position))
			{
				NGUIScrollViewWrap nGUIScrollViewWrap = null;
				nGUIScrollViewWrap = WraperUtil.LuaToUserdata(L, 1, string_reset_position, NGUIScrollViewWrap.cache);
				nGUIScrollViewWrap.component.ResetPosition();
				result = 0;
			}
			return result;
		}

		[MonoPInvokeCallback(typeof(LuaCSFunction))]
		private static int set_on_drag_started(IntPtr L)
		{
			int result = 0;
			if (WraperUtil.ValidIsUserdata(L, 1, string_set_on_drag_started) && WraperUtil.ValidIsString(L, 2, string_set_on_drag_started))
			{
				NGUIScrollViewWrap nGUIScrollViewWrap = null;
				string text = null;
				nGUIScrollViewWrap = WraperUtil.LuaToUserdata(L, 1, string_set_on_drag_started, NGUIScrollViewWrap.cache);
				text = LuaDLL.lua_tostring(L, 2);
				nGUIScrollViewWrap.onDragStarted = text;
				result = 0;
			}
			return result;
		}

		[MonoPInvokeCallback(typeof(LuaCSFunction))]
		private static int set_on_drag_finished(IntPtr L)
		{
			int result = 0;
			if (WraperUtil.ValidIsUserdata(L, 1, string_set_on_drag_finished) && WraperUtil.ValidIsString(L, 2, string_set_on_drag_finished))
			{
				NGUIScrollViewWrap nGUIScrollViewWrap = null;
				string text = null;
				nGUIScrollViewWrap = WraperUtil.LuaToUserdata(L, 1, string_set_on_drag_finished, NGUIScrollViewWrap.cache);
				text = LuaDLL.lua_tostring(L, 2);
				nGUIScrollViewWrap.onDragFinished = text;
				result = 0;
			}
			return result;
		}

		[MonoPInvokeCallback(typeof(LuaCSFunction))]
		private static int update_position(IntPtr L)
		{
			int result = 0;
			if (WraperUtil.ValidIsUserdata(L, 1, string_update_position))
			{
				NGUIScrollViewWrap nGUIScrollViewWrap = null;
				nGUIScrollViewWrap = WraperUtil.LuaToUserdata(L, 1, string_update_position, NGUIScrollViewWrap.cache);
				nGUIScrollViewWrap.component.UpdatePosition();
				result = 0;
			}
			return result;
		}

		[MonoPInvokeCallback(typeof(LuaCSFunction))]
		private static int get_bounds_box(IntPtr L)
		{
			int result = 0;
			if (WraperUtil.ValidIsUserdata(L, 1, string_get_bounds_box))
			{
				NGUIScrollViewWrap nGUIScrollViewWrap = null;
				nGUIScrollViewWrap = WraperUtil.LuaToUserdata(L, 1, string_get_bounds_box, NGUIScrollViewWrap.cache);
				LuaDLL.lua_pushnumber(L, nGUIScrollViewWrap.component.bounds.min.x);
				LuaDLL.lua_pushnumber(L, nGUIScrollViewWrap.component.bounds.min.y);
				LuaDLL.lua_pushnumber(L, nGUIScrollViewWrap.component.bounds.max.x);
				LuaDLL.lua_pushnumber(L, nGUIScrollViewWrap.component.bounds.max.y);
				result = 4;
			}
			return result;
		}

		[MonoPInvokeCallback(typeof(LuaCSFunction))]
		private static int move_relative(IntPtr L)
		{
			int result = 0;
			if (WraperUtil.ValidIsUserdata(L, 1, string_move_relative) && WraperUtil.ValidIsNumber(L, 2, string_move_relative) && WraperUtil.ValidIsNumber(L, 3, string_move_relative) && WraperUtil.ValidIsNumber(L, 4, string_move_relative))
			{
				NGUIScrollViewWrap nGUIScrollViewWrap = null;
				float num = 0f;
				float num2 = 0f;
				float num3 = 0f;
				nGUIScrollViewWrap = WraperUtil.LuaToUserdata(L, 1, string_move_relative, NGUIScrollViewWrap.cache);
				num = (float)LuaDLL.lua_tonumber(L, 2);
				num2 = (float)LuaDLL.lua_tonumber(L, 3);
				num3 = (float)LuaDLL.lua_tonumber(L, 4);
				nGUIScrollViewWrap.component.MoveRelative(new Vector3(num, num2, num3));
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
				NGUIScrollViewWrap nGUIScrollViewWrap = null;
				bool flag = false;
				nGUIScrollViewWrap = WraperUtil.LuaToUserdata(L, 1, string_set_enable, NGUIScrollViewWrap.cache);
				flag = LuaDLL.lua_toboolean(L, 2);
				nGUIScrollViewWrap.component.enabled = flag;
				result = 0;
			}
			return result;
		}

		[MonoPInvokeCallback(typeof(LuaCSFunction))]
		private static int set_restrict_within_panel(IntPtr L)
		{
			int result = 0;
			if (WraperUtil.ValidIsUserdata(L, 1, string_set_restrict_within_panel) && WraperUtil.ValidIsBoolean(L, 2, string_set_restrict_within_panel))
			{
				NGUIScrollViewWrap nGUIScrollViewWrap = null;
				bool flag = false;
				nGUIScrollViewWrap = WraperUtil.LuaToUserdata(L, 1, string_set_restrict_within_panel, NGUIScrollViewWrap.cache);
				flag = LuaDLL.lua_toboolean(L, 2);
				nGUIScrollViewWrap.component.restrictWithinPanel = flag;
				result = 0;
			}
			return result;
		}

		[MonoPInvokeCallback(typeof(LuaCSFunction))]
		private static int gc(IntPtr L)
		{
			NGUIScrollViewWrap nGUIScrollViewWrap = WraperUtil.LuaToUserdataByGc(L, 1, "gc ngui_scroll_view", NGUIScrollViewWrap.cache);
			if (nGUIScrollViewWrap != null)
			{
				nGUIScrollViewWrap.DestroyInstance();
			}
			return 0;
		}

		[MonoPInvokeCallback(typeof(LuaCSFunction))]
		private static int set_drag_amount(IntPtr L)
		{
			int result = 0;
			if (WraperUtil.ValidIsUserdata(L, 1, string_set_drag_amount) && WraperUtil.ValidIsNumber(L, 2, string_set_drag_amount) && WraperUtil.ValidIsNumber(L, 3, string_set_drag_amount))
			{
				NGUIScrollViewWrap nGUIScrollViewWrap = null;
				float num = 0f;
				float num2 = 0f;
				nGUIScrollViewWrap = WraperUtil.LuaToUserdata(L, 1, string_set_drag_amount, NGUIScrollViewWrap.cache);
				num = (float)LuaDLL.lua_tonumber(L, 2);
				num2 = (float)LuaDLL.lua_tonumber(L, 3);
				nGUIScrollViewWrap.component.SetDragAmount(num, num2, false);
				result = 0;
			}
			return result;
		}
	}
}
