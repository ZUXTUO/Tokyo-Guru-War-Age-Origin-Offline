using System;
using LuaInterface;
using UnityEngine;
using UnityWrap;

namespace Wraper
{
	public class ngui_wrap_list_wraper
	{
		public static string name = "ngui_wrap_list";

		private static luaL_Reg[] func = new luaL_Reg[25]
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
			new luaL_Reg("set_on_initialize_item", set_on_initialize_item),
			new luaL_Reg("set_on_item_move_finish", set_on_item_move_finish),
			new luaL_Reg("set_on_move_last_finish", set_on_move_last_finish),
			new luaL_Reg("set_min_index", set_min_index),
			new luaL_Reg("set_max_index", set_max_index),
			new luaL_Reg("move_at_last", move_at_last),
			new luaL_Reg("reset", reset),
			new luaL_Reg("drag_item", drag_item),
			new luaL_Reg("align_pre_item", align_pre_item),
			new luaL_Reg("fast_move", fast_move),
			new luaL_Reg("set_move_switch", set_move_switch),
			new luaL_Reg("is_bottom", is_bottom),
			new luaL_Reg("is_top", is_top)
		};

		private static string string_get_pid = "ngui_wrap_list:get_pid";

		private static string string_set_active = "ngui_wrap_list:set_active";

		private static string string_set_name = "ngui_wrap_list:set_name";

		private static string string_get_name = "ngui_wrap_list:get_name";

		private static string string_set_position = "ngui_wrap_list:set_position";

		private static string string_get_position = "ngui_wrap_list:get_position";

		private static string string_get_size = "ngui_wrap_list:get_size";

		private static string string_get_game_object = "ngui_wrap_list:get_game_object";

		private static string string_get_parent = "ngui_wrap_list:get_parent";

		private static string string_set_parent = "ngui_wrap_list:set_parent";

		private static string string_clone = "ngui_wrap_list:clone";

		private static string string_destroy_object = "ngui_wrap_list:destroy_object";

		private static string string_set_on_initialize_item = "ngui_wrap_list:set_on_initialize_item";

		private static string string_set_on_item_move_finish = "ngui_wrap_list:set_on_item_move_finish";

		private static string string_set_on_move_last_finish = "ngui_wrap_list:set_on_move_last_finish";

		private static string string_set_min_index = "ngui_wrap_list:set_min_index";

		private static string string_set_max_index = "ngui_wrap_list:set_max_index";

		private static string string_move_at_last = "ngui_wrap_list:move_at_last";

		private static string string_reset = "ngui_wrap_list:reset";

		private static string string_drag_item = "ngui_wrap_list:drag_item";

		private static string string_align_pre_item = "ngui_wrap_list:align_pre_item";

		private static string string_fast_move = "ngui_wrap_list:fast_move";

		private static string string_set_move_switch = "ngui_wrap_list:set_move_switch";

		private static string string_is_bottom = "ngui_wrap_list:is_bottom";

		private static string string_is_top = "ngui_wrap_list:is_top";

		public static bool init(IntPtr L)
		{
			if (L != IntPtr.Zero)
			{
				LuaDLL.register_class(L, name, func, gc);
				return true;
			}
			return false;
		}

		public static void push(IntPtr L, NGUIWrapListWrap obj)
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
				NGUIWrapListWrap nGUIWrapListWrap = null;
				nGUIWrapListWrap = WraperUtil.LuaToUserdata(L, 1, string_get_pid, NGUIWrapListWrap.cache);
				LuaDLL.lua_pushnumber(L, nGUIWrapListWrap.GetPid());
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
				NGUIWrapListWrap nGUIWrapListWrap = null;
				bool flag = false;
				nGUIWrapListWrap = WraperUtil.LuaToUserdata(L, 1, string_set_active, NGUIWrapListWrap.cache);
				flag = LuaDLL.lua_toboolean(L, 2);
				nGUIWrapListWrap.bcomponent.gameObject.SetActive(flag);
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
				NGUIWrapListWrap nGUIWrapListWrap = null;
				string text = null;
				nGUIWrapListWrap = WraperUtil.LuaToUserdata(L, 1, string_set_name, NGUIWrapListWrap.cache);
				text = LuaDLL.lua_tostring(L, 2);
				nGUIWrapListWrap.bcomponent.gameObject.name = text;
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
				NGUIWrapListWrap nGUIWrapListWrap = null;
				nGUIWrapListWrap = WraperUtil.LuaToUserdata(L, 1, string_get_name, NGUIWrapListWrap.cache);
				LuaDLL.lua_pushstring(L, nGUIWrapListWrap.bcomponent.gameObject.name);
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
				NGUIWrapListWrap nGUIWrapListWrap = null;
				float num = 0f;
				float num2 = 0f;
				float num3 = 0f;
				nGUIWrapListWrap = WraperUtil.LuaToUserdata(L, 1, string_set_position, NGUIWrapListWrap.cache);
				num = (float)LuaDLL.lua_tonumber(L, 2);
				num2 = (float)LuaDLL.lua_tonumber(L, 3);
				num3 = (float)LuaDLL.lua_tonumber(L, 4);
				nGUIWrapListWrap.bcomponent.gameObject.transform.localPosition = new Vector3(num, num2, num3);
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
				NGUIWrapListWrap nGUIWrapListWrap = null;
				nGUIWrapListWrap = WraperUtil.LuaToUserdata(L, 1, string_get_position, NGUIWrapListWrap.cache);
				Vector3 localPosition = nGUIWrapListWrap.bcomponent.gameObject.transform.localPosition;
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
				NGUIWrapListWrap nGUIWrapListWrap = null;
				nGUIWrapListWrap = WraperUtil.LuaToUserdata(L, 1, string_get_size, NGUIWrapListWrap.cache);
				int num = ((!(nGUIWrapListWrap.widget == null)) ? nGUIWrapListWrap.widget.width : 0);
				int num2 = ((!(nGUIWrapListWrap.widget == null)) ? nGUIWrapListWrap.widget.height : 0);
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
				NGUIWrapListWrap nGUIWrapListWrap = null;
				nGUIWrapListWrap = WraperUtil.LuaToUserdata(L, 1, string_get_game_object, NGUIWrapListWrap.cache);
				AssetGameObject base_object = AssetGameObject.CreateByInstance(nGUIWrapListWrap.bcomponent.gameObject);
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
				NGUIWrapListWrap nGUIWrapListWrap = null;
				nGUIWrapListWrap = WraperUtil.LuaToUserdata(L, 1, string_get_parent, NGUIWrapListWrap.cache);
				AssetGameObject assetGameObject = null;
				Transform parent = nGUIWrapListWrap.bcomponent.gameObject.transform.parent;
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
				NGUIWrapListWrap nGUIWrapListWrap = null;
				AssetGameObject assetGameObject = null;
				nGUIWrapListWrap = WraperUtil.LuaToUserdata(L, 1, string_set_parent, NGUIWrapListWrap.cache);
				assetGameObject = WraperUtil.LuaToUserdataOrNil(L, 2, string_set_parent, AssetGameObject.cache);
				nGUIWrapListWrap.bcomponent.gameObject.transform.parent = ((assetGameObject != null) ? assetGameObject.transform : null);
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
				NGUIWrapListWrap nGUIWrapListWrap = null;
				nGUIWrapListWrap = WraperUtil.LuaToUserdata(L, 1, string_clone, NGUIWrapListWrap.cache);
				nGUIWrapListWrap.Clone(L);
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
				NGUIWrapListWrap nGUIWrapListWrap = null;
				nGUIWrapListWrap = WraperUtil.LuaToUserdata(L, 1, string_destroy_object, NGUIWrapListWrap.cache);
				nGUIWrapListWrap.isNeedDestroy = true;
				result = 0;
			}
			return result;
		}

		[MonoPInvokeCallback(typeof(LuaCSFunction))]
		private static int set_on_initialize_item(IntPtr L)
		{
			int result = 0;
			if (WraperUtil.ValidIsUserdata(L, 1, string_set_on_initialize_item) && WraperUtil.ValidIsString(L, 2, string_set_on_initialize_item))
			{
				NGUIWrapListWrap nGUIWrapListWrap = null;
				string text = null;
				nGUIWrapListWrap = WraperUtil.LuaToUserdata(L, 1, string_set_on_initialize_item, NGUIWrapListWrap.cache);
				text = LuaDLL.lua_tostring(L, 2);
				nGUIWrapListWrap.onInitializeItem = text;
				result = 0;
			}
			return result;
		}

		[MonoPInvokeCallback(typeof(LuaCSFunction))]
		private static int set_on_item_move_finish(IntPtr L)
		{
			int result = 0;
			if (WraperUtil.ValidIsUserdata(L, 1, string_set_on_item_move_finish) && WraperUtil.ValidIsString(L, 2, string_set_on_item_move_finish))
			{
				NGUIWrapListWrap nGUIWrapListWrap = null;
				string text = null;
				nGUIWrapListWrap = WraperUtil.LuaToUserdata(L, 1, string_set_on_item_move_finish, NGUIWrapListWrap.cache);
				text = LuaDLL.lua_tostring(L, 2);
				nGUIWrapListWrap.onItemMoveFinish = text;
				result = 0;
			}
			return result;
		}

		[MonoPInvokeCallback(typeof(LuaCSFunction))]
		private static int set_on_move_last_finish(IntPtr L)
		{
			int result = 0;
			if (WraperUtil.ValidIsUserdata(L, 1, string_set_on_move_last_finish) && WraperUtil.ValidIsString(L, 2, string_set_on_move_last_finish))
			{
				NGUIWrapListWrap nGUIWrapListWrap = null;
				string text = null;
				nGUIWrapListWrap = WraperUtil.LuaToUserdata(L, 1, string_set_on_move_last_finish, NGUIWrapListWrap.cache);
				text = LuaDLL.lua_tostring(L, 2);
				nGUIWrapListWrap.onMoveLastFinish = text;
				result = 0;
			}
			return result;
		}

		[MonoPInvokeCallback(typeof(LuaCSFunction))]
		private static int set_min_index(IntPtr L)
		{
			int result = 0;
			if (WraperUtil.ValidIsUserdata(L, 1, string_set_min_index) && WraperUtil.ValidIsNumber(L, 2, string_set_min_index))
			{
				NGUIWrapListWrap nGUIWrapListWrap = null;
				int num = 0;
				nGUIWrapListWrap = WraperUtil.LuaToUserdata(L, 1, string_set_min_index, NGUIWrapListWrap.cache);
				num = (int)LuaDLL.lua_tonumber(L, 2);
				nGUIWrapListWrap.component.minIndex = num;
				result = 0;
			}
			return result;
		}

		[MonoPInvokeCallback(typeof(LuaCSFunction))]
		private static int set_max_index(IntPtr L)
		{
			int result = 0;
			if (WraperUtil.ValidIsUserdata(L, 1, string_set_max_index) && WraperUtil.ValidIsNumber(L, 2, string_set_max_index))
			{
				NGUIWrapListWrap nGUIWrapListWrap = null;
				int num = 0;
				nGUIWrapListWrap = WraperUtil.LuaToUserdata(L, 1, string_set_max_index, NGUIWrapListWrap.cache);
				num = (int)LuaDLL.lua_tonumber(L, 2);
				nGUIWrapListWrap.component.maxIndex = num;
				result = 0;
			}
			return result;
		}

		[MonoPInvokeCallback(typeof(LuaCSFunction))]
		private static int move_at_last(IntPtr L)
		{
			int result = 0;
			if (WraperUtil.ValidIsUserdata(L, 1, string_move_at_last))
			{
				NGUIWrapListWrap nGUIWrapListWrap = null;
				nGUIWrapListWrap = WraperUtil.LuaToUserdata(L, 1, string_move_at_last, NGUIWrapListWrap.cache);
				nGUIWrapListWrap.component.mMoveAtLast = true;
				result = 0;
			}
			return result;
		}

		[MonoPInvokeCallback(typeof(LuaCSFunction))]
		private static int reset(IntPtr L)
		{
			int result = 0;
			if (WraperUtil.ValidIsUserdata(L, 1, string_reset))
			{
				NGUIWrapListWrap nGUIWrapListWrap = null;
				nGUIWrapListWrap = WraperUtil.LuaToUserdata(L, 1, string_reset, NGUIWrapListWrap.cache);
				if (nGUIWrapListWrap != null && nGUIWrapListWrap.component != null)
				{
					nGUIWrapListWrap.component.SortBasedOnScrollMovement();
				}
				result = 0;
			}
			return result;
		}

		[MonoPInvokeCallback(typeof(LuaCSFunction))]
		private static int drag_item(IntPtr L)
		{
			int result = 0;
			if (WraperUtil.ValidIsUserdata(L, 1, string_drag_item) && WraperUtil.ValidIsUserdata(L, 2, string_drag_item) && WraperUtil.ValidIsBoolean(L, 3, string_drag_item))
			{
				NGUIWrapListWrap nGUIWrapListWrap = null;
				nGUIWrapListWrap = WraperUtil.LuaToUserdata(L, 1, string_drag_item, NGUIWrapListWrap.cache);
				AssetGameObject assetGameObject = null;
				assetGameObject = WraperUtil.LuaToUserdata(L, 2, string_align_pre_item, AssetGameObject.cache);
				bool up = LuaDLL.lua_toboolean(L, 3);
				if (nGUIWrapListWrap != null && nGUIWrapListWrap.component != null)
				{
					nGUIWrapListWrap.component.DragItem(assetGameObject.gameObject, up);
				}
				result = 0;
			}
			return result;
		}

		[MonoPInvokeCallback(typeof(LuaCSFunction))]
		private static int align_pre_item(IntPtr L)
		{
			int result = 0;
			if (WraperUtil.ValidIsUserdata(L, 1, string_align_pre_item) && WraperUtil.ValidIsUserdata(L, 2, string_align_pre_item))
			{
				NGUIWrapListWrap nGUIWrapListWrap = null;
				nGUIWrapListWrap = WraperUtil.LuaToUserdata(L, 1, string_align_pre_item, NGUIWrapListWrap.cache);
				AssetGameObject assetGameObject = null;
				assetGameObject = WraperUtil.LuaToUserdata(L, 2, string_align_pre_item, AssetGameObject.cache);
				bool up = LuaDLL.lua_toboolean(L, 3);
				if (nGUIWrapListWrap != null && nGUIWrapListWrap.component != null)
				{
					nGUIWrapListWrap.component.AlignPreItem(assetGameObject.gameObject, up);
				}
				result = 0;
			}
			return result;
		}

		[MonoPInvokeCallback(typeof(LuaCSFunction))]
		private static int fast_move(IntPtr L)
		{
			int result = 0;
			if (WraperUtil.ValidIsUserdata(L, 1, string_fast_move))
			{
				NGUIWrapListWrap nGUIWrapListWrap = null;
				nGUIWrapListWrap = WraperUtil.LuaToUserdata(L, 1, string_fast_move, NGUIWrapListWrap.cache);
				if (nGUIWrapListWrap != null && nGUIWrapListWrap.component != null)
				{
					nGUIWrapListWrap.component.FastMove();
				}
				result = 0;
			}
			return result;
		}

		[MonoPInvokeCallback(typeof(LuaCSFunction))]
		private static int set_move_switch(IntPtr L)
		{
			int result = 0;
			if (WraperUtil.ValidIsUserdata(L, 1, string_set_move_switch) && WraperUtil.ValidIsBoolean(L, 2, string_set_move_switch))
			{
				NGUIWrapListWrap nGUIWrapListWrap = null;
				nGUIWrapListWrap = WraperUtil.LuaToUserdata(L, 1, string_set_move_switch, NGUIWrapListWrap.cache);
				bool bMoveSwitch = LuaDLL.lua_toboolean(L, 2);
				if (nGUIWrapListWrap != null && nGUIWrapListWrap.component != null)
				{
					nGUIWrapListWrap.component.bMoveSwitch = bMoveSwitch;
				}
				result = 0;
			}
			return result;
		}

		[MonoPInvokeCallback(typeof(LuaCSFunction))]
		private static int is_bottom(IntPtr L)
		{
			int num = 0;
			NGUIWrapListWrap nGUIWrapListWrap = null;
			nGUIWrapListWrap = WraperUtil.LuaToUserdata(L, 1, string_is_bottom, NGUIWrapListWrap.cache);
			if (nGUIWrapListWrap != null && nGUIWrapListWrap.component != null)
			{
				LuaDLL.lua_pushboolean(L, nGUIWrapListWrap.component.IsBottom());
				return 1;
			}
			return 0;
		}

		[MonoPInvokeCallback(typeof(LuaCSFunction))]
		private static int is_top(IntPtr L)
		{
			int num = 0;
			NGUIWrapListWrap nGUIWrapListWrap = null;
			nGUIWrapListWrap = WraperUtil.LuaToUserdata(L, 1, string_is_top, NGUIWrapListWrap.cache);
			if (nGUIWrapListWrap != null && nGUIWrapListWrap.component != null)
			{
				LuaDLL.lua_pushboolean(L, nGUIWrapListWrap.component.IsTop());
				return 1;
			}
			return 0;
		}

		[MonoPInvokeCallback(typeof(LuaCSFunction))]
		private static int gc(IntPtr L)
		{
			NGUIWrapListWrap nGUIWrapListWrap = WraperUtil.LuaToUserdataByGc(L, 1, "gc ngui_wrap_list", NGUIWrapListWrap.cache);
			if (nGUIWrapListWrap != null)
			{
				nGUIWrapListWrap.DestroyInstance();
			}
			return 0;
		}
	}
}
