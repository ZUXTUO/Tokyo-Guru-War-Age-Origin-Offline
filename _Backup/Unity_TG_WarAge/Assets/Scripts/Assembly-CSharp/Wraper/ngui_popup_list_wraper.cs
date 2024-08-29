using System;
using LuaInterface;
using UnityEngine;
using UnityWrap;

namespace Wraper
{
	public class ngui_popup_list_wraper
	{
		public static string name = "ngui_popup_list";

		private static luaL_Reg[] func = new luaL_Reg[16]
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
			new luaL_Reg("set_on_value_change", set_on_value_change),
			new luaL_Reg("add_item", add_item),
			new luaL_Reg("remove_item", remove_item),
			new luaL_Reg("clear", clear)
		};

		private static string string_get_pid = "ngui_popup_list:get_pid";

		private static string string_set_active = "ngui_popup_list:set_active";

		private static string string_set_name = "ngui_popup_list:set_name";

		private static string string_get_name = "ngui_popup_list:get_name";

		private static string string_set_position = "ngui_popup_list:set_position";

		private static string string_get_position = "ngui_popup_list:get_position";

		private static string string_get_size = "ngui_popup_list:get_size";

		private static string string_get_game_object = "ngui_popup_list:get_game_object";

		private static string string_get_parent = "ngui_popup_list:get_parent";

		private static string string_set_parent = "ngui_popup_list:set_parent";

		private static string string_clone = "ngui_popup_list:clone";

		private static string string_destroy_object = "ngui_popup_list:destroy_object";

		private static string string_set_on_value_change = "ngui_popup_list:set_on_value_change";

		private static string string_add_item = "ngui_popup_list:add_item";

		private static string string_remove_item = "ngui_popup_list:remove_item";

		private static string string_clear = "ngui_popup_list:clear";

		public static bool init(IntPtr L)
		{
			if (L != IntPtr.Zero)
			{
				LuaDLL.register_class(L, name, func, gc);
				return true;
			}
			return false;
		}

		public static void push(IntPtr L, NGUIPopUpListWrap obj)
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
				NGUIPopUpListWrap nGUIPopUpListWrap = null;
				nGUIPopUpListWrap = WraperUtil.LuaToUserdata(L, 1, string_get_pid, NGUIPopUpListWrap.cache);
				LuaDLL.lua_pushnumber(L, nGUIPopUpListWrap.GetPid());
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
				NGUIPopUpListWrap nGUIPopUpListWrap = null;
				bool flag = false;
				nGUIPopUpListWrap = WraperUtil.LuaToUserdata(L, 1, string_set_active, NGUIPopUpListWrap.cache);
				flag = LuaDLL.lua_toboolean(L, 2);
				nGUIPopUpListWrap.bcomponent.gameObject.SetActive(flag);
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
				NGUIPopUpListWrap nGUIPopUpListWrap = null;
				string text = null;
				nGUIPopUpListWrap = WraperUtil.LuaToUserdata(L, 1, string_set_name, NGUIPopUpListWrap.cache);
				text = LuaDLL.lua_tostring(L, 2);
				nGUIPopUpListWrap.bcomponent.gameObject.name = text;
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
				NGUIPopUpListWrap nGUIPopUpListWrap = null;
				nGUIPopUpListWrap = WraperUtil.LuaToUserdata(L, 1, string_get_name, NGUIPopUpListWrap.cache);
				LuaDLL.lua_pushstring(L, nGUIPopUpListWrap.bcomponent.gameObject.name);
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
				NGUIPopUpListWrap nGUIPopUpListWrap = null;
				float num = 0f;
				float num2 = 0f;
				float num3 = 0f;
				nGUIPopUpListWrap = WraperUtil.LuaToUserdata(L, 1, string_set_position, NGUIPopUpListWrap.cache);
				num = (float)LuaDLL.lua_tonumber(L, 2);
				num2 = (float)LuaDLL.lua_tonumber(L, 3);
				num3 = (float)LuaDLL.lua_tonumber(L, 4);
				nGUIPopUpListWrap.bcomponent.gameObject.transform.localPosition = new Vector3(num, num2, num3);
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
				NGUIPopUpListWrap nGUIPopUpListWrap = null;
				nGUIPopUpListWrap = WraperUtil.LuaToUserdata(L, 1, string_get_position, NGUIPopUpListWrap.cache);
				Vector3 localPosition = nGUIPopUpListWrap.bcomponent.gameObject.transform.localPosition;
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
				NGUIPopUpListWrap nGUIPopUpListWrap = null;
				nGUIPopUpListWrap = WraperUtil.LuaToUserdata(L, 1, string_get_size, NGUIPopUpListWrap.cache);
				int num = ((!(nGUIPopUpListWrap.widget == null)) ? nGUIPopUpListWrap.widget.width : 0);
				int num2 = ((!(nGUIPopUpListWrap.widget == null)) ? nGUIPopUpListWrap.widget.height : 0);
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
				NGUIPopUpListWrap nGUIPopUpListWrap = null;
				nGUIPopUpListWrap = WraperUtil.LuaToUserdata(L, 1, string_get_game_object, NGUIPopUpListWrap.cache);
				AssetGameObject base_object = AssetGameObject.CreateByInstance(nGUIPopUpListWrap.bcomponent.gameObject);
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
				NGUIPopUpListWrap nGUIPopUpListWrap = null;
				nGUIPopUpListWrap = WraperUtil.LuaToUserdata(L, 1, string_get_parent, NGUIPopUpListWrap.cache);
				AssetGameObject assetGameObject = null;
				Transform parent = nGUIPopUpListWrap.bcomponent.gameObject.transform.parent;
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
				NGUIPopUpListWrap nGUIPopUpListWrap = null;
				AssetGameObject assetGameObject = null;
				nGUIPopUpListWrap = WraperUtil.LuaToUserdata(L, 1, string_set_parent, NGUIPopUpListWrap.cache);
				assetGameObject = WraperUtil.LuaToUserdataOrNil(L, 2, string_set_parent, AssetGameObject.cache);
				nGUIPopUpListWrap.bcomponent.gameObject.transform.parent = ((assetGameObject != null) ? assetGameObject.transform : null);
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
				NGUIPopUpListWrap nGUIPopUpListWrap = null;
				nGUIPopUpListWrap = WraperUtil.LuaToUserdata(L, 1, string_clone, NGUIPopUpListWrap.cache);
				nGUIPopUpListWrap.Clone(L);
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
				NGUIPopUpListWrap nGUIPopUpListWrap = null;
				nGUIPopUpListWrap = WraperUtil.LuaToUserdata(L, 1, string_destroy_object, NGUIPopUpListWrap.cache);
				nGUIPopUpListWrap.isNeedDestroy = true;
				result = 0;
			}
			return result;
		}

		[MonoPInvokeCallback(typeof(LuaCSFunction))]
		private static int set_on_value_change(IntPtr L)
		{
			int result = 0;
			if (WraperUtil.ValidIsUserdata(L, 1, string_set_on_value_change) && WraperUtil.ValidIsString(L, 2, string_set_on_value_change))
			{
				NGUIPopUpListWrap nGUIPopUpListWrap = null;
				string text = null;
				nGUIPopUpListWrap = WraperUtil.LuaToUserdata(L, 1, string_set_on_value_change, NGUIPopUpListWrap.cache);
				text = LuaDLL.lua_tostring(L, 2);
				nGUIPopUpListWrap.onSelectChange = text;
				result = 0;
			}
			return result;
		}

		[MonoPInvokeCallback(typeof(LuaCSFunction))]
		private static int add_item(IntPtr L)
		{
			int result = 0;
			if (WraperUtil.ValidIsUserdata(L, 1, string_add_item) && WraperUtil.ValidIsString(L, 2, string_add_item))
			{
				NGUIPopUpListWrap nGUIPopUpListWrap = null;
				string text = null;
				nGUIPopUpListWrap = WraperUtil.LuaToUserdata(L, 1, string_add_item, NGUIPopUpListWrap.cache);
				text = LuaDLL.lua_tostring(L, 2);
				nGUIPopUpListWrap.component.AddItem(text);
				result = 0;
			}
			return result;
		}

		[MonoPInvokeCallback(typeof(LuaCSFunction))]
		private static int remove_item(IntPtr L)
		{
			int result = 0;
			if (WraperUtil.ValidIsUserdata(L, 1, string_remove_item) && WraperUtil.ValidIsString(L, 2, string_remove_item))
			{
				NGUIPopUpListWrap nGUIPopUpListWrap = null;
				string text = null;
				nGUIPopUpListWrap = WraperUtil.LuaToUserdata(L, 1, string_remove_item, NGUIPopUpListWrap.cache);
				text = LuaDLL.lua_tostring(L, 2);
				nGUIPopUpListWrap.component.RemoveItem(text);
				result = 0;
			}
			return result;
		}

		[MonoPInvokeCallback(typeof(LuaCSFunction))]
		private static int clear(IntPtr L)
		{
			int result = 0;
			if (WraperUtil.ValidIsUserdata(L, 1, string_clear))
			{
				NGUIPopUpListWrap nGUIPopUpListWrap = null;
				nGUIPopUpListWrap = WraperUtil.LuaToUserdata(L, 1, string_clear, NGUIPopUpListWrap.cache);
				nGUIPopUpListWrap.component.items.Clear();
				nGUIPopUpListWrap.component.itemData.Clear();
				result = 0;
			}
			return result;
		}

		[MonoPInvokeCallback(typeof(LuaCSFunction))]
		private static int gc(IntPtr L)
		{
			NGUIPopUpListWrap nGUIPopUpListWrap = WraperUtil.LuaToUserdataByGc(L, 1, "gc ngui_popup_list", NGUIPopUpListWrap.cache);
			if (nGUIPopUpListWrap != null)
			{
				nGUIPopUpListWrap.DestroyInstance();
			}
			return 0;
		}
	}
}
