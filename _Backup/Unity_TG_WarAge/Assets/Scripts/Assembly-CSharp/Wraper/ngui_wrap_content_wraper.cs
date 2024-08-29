using System;
using LuaInterface;
using UnityEngine;
using UnityWrap;

namespace Wraper
{
	public class ngui_wrap_content_wraper
	{
		public static string name = "ngui_wrap_content";

		private static luaL_Reg[] func = new luaL_Reg[18]
		{
			new luaL_Reg("get_pid", get_pid),
			new luaL_Reg("set_active", set_active),
			new luaL_Reg("set_name", set_name),
			new luaL_Reg("get_name", get_name),
			new luaL_Reg("set_position", set_position),
			new luaL_Reg("get_position", get_position),
			new luaL_Reg("get_size", get_size),
			new luaL_Reg("get_item_size", get_item_size),
			new luaL_Reg("get_game_object", get_game_object),
			new luaL_Reg("get_parent", get_parent),
			new luaL_Reg("set_parent", set_parent),
			new luaL_Reg("clone", clone),
			new luaL_Reg("destroy_object", destroy_object),
			new luaL_Reg("set_on_initialize_item", set_on_initialize_item),
			new luaL_Reg("set_min_index", set_min_index),
			new luaL_Reg("set_max_index", set_max_index),
			new luaL_Reg("reset", reset),
			new luaL_Reg("set_base_clone_item", set_base_clone_item)
		};

		private static string string_get_pid = "ngui_wrap_content:get_pid";

		private static string string_set_active = "ngui_wrap_content:set_active";

		private static string string_set_name = "ngui_wrap_content:set_name";

		private static string string_get_name = "ngui_wrap_content:get_name";

		private static string string_set_position = "ngui_wrap_content:set_position";

		private static string string_get_position = "ngui_wrap_content:get_position";

		private static string string_get_size = "ngui_wrap_content:get_size";

		private static string string_get_item_size = "ngui_wrap_content:get_item_size";

		private static string string_get_game_object = "ngui_wrap_content:get_game_object";

		private static string string_get_parent = "ngui_wrap_content:get_parent";

		private static string string_set_parent = "ngui_wrap_content:set_parent";

		private static string string_clone = "ngui_wrap_content:clone";

		private static string string_destroy_object = "ngui_wrap_content:destroy_object";

		private static string string_set_on_initialize_item = "ngui_wrap_content:set_on_initialize_item";

		private static string string_set_min_index = "ngui_wrap_content:set_min_index";

		private static string string_set_max_index = "ngui_wrap_content:set_max_index";

		private static string string_reset = "ngui_wrap_content:reset";

		private static string string_set_base_clone_item = "ngui_wrap_content:set_base_clone_item";

		public static bool init(IntPtr L)
		{
			if (L != IntPtr.Zero)
			{
				LuaDLL.register_class(L, name, func, gc);
				return true;
			}
			return false;
		}

		public static void push(IntPtr L, NGUIWrapContentWrap obj)
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
				NGUIWrapContentWrap nGUIWrapContentWrap = null;
				nGUIWrapContentWrap = WraperUtil.LuaToUserdata(L, 1, string_get_pid, NGUIWrapContentWrap.cache);
				LuaDLL.lua_pushnumber(L, nGUIWrapContentWrap.GetPid());
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
				NGUIWrapContentWrap nGUIWrapContentWrap = null;
				bool flag = false;
				nGUIWrapContentWrap = WraperUtil.LuaToUserdata(L, 1, string_set_active, NGUIWrapContentWrap.cache);
				flag = LuaDLL.lua_toboolean(L, 2);
				nGUIWrapContentWrap.bcomponent.gameObject.SetActive(flag);
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
				NGUIWrapContentWrap nGUIWrapContentWrap = null;
				string text = null;
				nGUIWrapContentWrap = WraperUtil.LuaToUserdata(L, 1, string_set_name, NGUIWrapContentWrap.cache);
				text = LuaDLL.lua_tostring(L, 2);
				nGUIWrapContentWrap.bcomponent.gameObject.name = text;
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
				NGUIWrapContentWrap nGUIWrapContentWrap = null;
				nGUIWrapContentWrap = WraperUtil.LuaToUserdata(L, 1, string_get_name, NGUIWrapContentWrap.cache);
				LuaDLL.lua_pushstring(L, nGUIWrapContentWrap.bcomponent.gameObject.name);
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
				NGUIWrapContentWrap nGUIWrapContentWrap = null;
				float num = 0f;
				float num2 = 0f;
				float num3 = 0f;
				nGUIWrapContentWrap = WraperUtil.LuaToUserdata(L, 1, string_set_position, NGUIWrapContentWrap.cache);
				num = (float)LuaDLL.lua_tonumber(L, 2);
				num2 = (float)LuaDLL.lua_tonumber(L, 3);
				num3 = (float)LuaDLL.lua_tonumber(L, 4);
				nGUIWrapContentWrap.bcomponent.gameObject.transform.localPosition = new Vector3(num, num2, num3);
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
				NGUIWrapContentWrap nGUIWrapContentWrap = null;
				nGUIWrapContentWrap = WraperUtil.LuaToUserdata(L, 1, string_get_position, NGUIWrapContentWrap.cache);
				Vector3 localPosition = nGUIWrapContentWrap.bcomponent.gameObject.transform.localPosition;
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
				NGUIWrapContentWrap nGUIWrapContentWrap = null;
				nGUIWrapContentWrap = WraperUtil.LuaToUserdata(L, 1, string_get_size, NGUIWrapContentWrap.cache);
				int num = ((!(nGUIWrapContentWrap.widget == null)) ? nGUIWrapContentWrap.widget.width : 0);
				int num2 = ((!(nGUIWrapContentWrap.widget == null)) ? nGUIWrapContentWrap.widget.height : 0);
				LuaDLL.lua_pushnumber(L, num);
				LuaDLL.lua_pushnumber(L, num2);
				result = 2;
			}
			return result;
		}

		[MonoPInvokeCallback(typeof(LuaCSFunction))]
		private static int get_item_size(IntPtr L)
		{
			int result = 0;
			if (WraperUtil.ValidIsUserdata(L, 1, string_get_item_size))
			{
				NGUIWrapContentWrap nGUIWrapContentWrap = null;
				nGUIWrapContentWrap = WraperUtil.LuaToUserdata(L, 1, string_get_item_size, NGUIWrapContentWrap.cache);
				int num = ((!(nGUIWrapContentWrap.component == null)) ? nGUIWrapContentWrap.component.itemSize : 0);
				LuaDLL.lua_pushnumber(L, num);
				result = 1;
			}
			return result;
		}

		[MonoPInvokeCallback(typeof(LuaCSFunction))]
		private static int get_game_object(IntPtr L)
		{
			int result = 0;
			if (WraperUtil.ValidIsUserdata(L, 1, string_get_game_object))
			{
				NGUIWrapContentWrap nGUIWrapContentWrap = null;
				nGUIWrapContentWrap = WraperUtil.LuaToUserdata(L, 1, string_get_game_object, NGUIWrapContentWrap.cache);
				AssetGameObject base_object = AssetGameObject.CreateByInstance(nGUIWrapContentWrap.bcomponent.gameObject);
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
				NGUIWrapContentWrap nGUIWrapContentWrap = null;
				nGUIWrapContentWrap = WraperUtil.LuaToUserdata(L, 1, string_get_parent, NGUIWrapContentWrap.cache);
				AssetGameObject assetGameObject = null;
				Transform parent = nGUIWrapContentWrap.bcomponent.gameObject.transform.parent;
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
				NGUIWrapContentWrap nGUIWrapContentWrap = null;
				AssetGameObject assetGameObject = null;
				nGUIWrapContentWrap = WraperUtil.LuaToUserdata(L, 1, string_set_parent, NGUIWrapContentWrap.cache);
				assetGameObject = WraperUtil.LuaToUserdataOrNil(L, 2, string_set_parent, AssetGameObject.cache);
				nGUIWrapContentWrap.bcomponent.gameObject.transform.parent = ((assetGameObject != null) ? assetGameObject.transform : null);
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
				NGUIWrapContentWrap nGUIWrapContentWrap = null;
				nGUIWrapContentWrap = WraperUtil.LuaToUserdata(L, 1, string_clone, NGUIWrapContentWrap.cache);
				nGUIWrapContentWrap.Clone(L);
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
				NGUIWrapContentWrap nGUIWrapContentWrap = null;
				nGUIWrapContentWrap = WraperUtil.LuaToUserdata(L, 1, string_destroy_object, NGUIWrapContentWrap.cache);
				nGUIWrapContentWrap.isNeedDestroy = true;
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
				NGUIWrapContentWrap nGUIWrapContentWrap = null;
				string text = null;
				nGUIWrapContentWrap = WraperUtil.LuaToUserdata(L, 1, string_set_on_initialize_item, NGUIWrapContentWrap.cache);
				text = LuaDLL.lua_tostring(L, 2);
				nGUIWrapContentWrap.onInitializeItem = text;
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
				NGUIWrapContentWrap nGUIWrapContentWrap = null;
				int num = 0;
				nGUIWrapContentWrap = WraperUtil.LuaToUserdata(L, 1, string_set_min_index, NGUIWrapContentWrap.cache);
				num = (int)LuaDLL.lua_tonumber(L, 2);
				nGUIWrapContentWrap.component.minIndex = num;
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
				NGUIWrapContentWrap nGUIWrapContentWrap = null;
				int num = 0;
				nGUIWrapContentWrap = WraperUtil.LuaToUserdata(L, 1, string_set_max_index, NGUIWrapContentWrap.cache);
				num = (int)LuaDLL.lua_tonumber(L, 2);
				nGUIWrapContentWrap.component.maxIndex = num;
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
				NGUIWrapContentWrap nGUIWrapContentWrap = null;
				nGUIWrapContentWrap = WraperUtil.LuaToUserdata(L, 1, string_reset, NGUIWrapContentWrap.cache);
				nGUIWrapContentWrap.component.SortBasedOnScrollMovement();
				result = 0;
			}
			return result;
		}

		[MonoPInvokeCallback(typeof(LuaCSFunction))]
		private static int set_base_clone_item(IntPtr L)
		{
			int result = 0;
			if (WraperUtil.ValidIsUserdata(L, 1, string_set_base_clone_item) && WraperUtil.ValidIsUserdata(L, 2, string_set_base_clone_item))
			{
				NGUIWrapContentWrap nGUIWrapContentWrap = null;
				AssetGameObject assetGameObject = null;
				nGUIWrapContentWrap = WraperUtil.LuaToUserdata(L, 1, string_set_base_clone_item, NGUIWrapContentWrap.cache);
				assetGameObject = WraperUtil.LuaToUserdata(L, 2, string_set_base_clone_item, AssetGameObject.cache);
				if (assetGameObject.transform != null && nGUIWrapContentWrap.component.transform != null)
				{
					assetGameObject.transform.parent = nGUIWrapContentWrap.component.transform;
					assetGameObject.transform.localScale = new Vector3(1f, 1f, 1f);
					assetGameObject.transform.localPosition = new Vector3(0f, 0f, 0f);
					assetGameObject.gameObject.SetActive(false);
					nGUIWrapContentWrap.component.SetBaseCloneItem(assetGameObject.transform);
					nGUIWrapContentWrap.component.SortBasedOnScrollMovement();
				}
				result = 0;
			}
			return result;
		}

		[MonoPInvokeCallback(typeof(LuaCSFunction))]
		private static int gc(IntPtr L)
		{
			NGUIWrapContentWrap nGUIWrapContentWrap = WraperUtil.LuaToUserdataByGc(L, 1, "gc ngui_wrap_content", NGUIWrapContentWrap.cache);
			if (nGUIWrapContentWrap != null)
			{
				nGUIWrapContentWrap.DestroyInstance();
			}
			return 0;
		}
	}
}
