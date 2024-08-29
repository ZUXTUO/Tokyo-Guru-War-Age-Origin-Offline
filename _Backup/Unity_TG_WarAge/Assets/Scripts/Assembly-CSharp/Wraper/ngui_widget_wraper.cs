using System;
using LuaInterface;
using UnityEngine;
using UnityWrap;

namespace Wraper
{
	public class ngui_widget_wraper
	{
		public static string name = "ngui_widget";

		private static luaL_Reg[] func = new luaL_Reg[15]
		{
			new luaL_Reg("get_pid", get_pid),
			new luaL_Reg("set_active", set_active),
			new luaL_Reg("set_name", set_name),
			new luaL_Reg("get_name", get_name),
			new luaL_Reg("set_position", set_position),
			new luaL_Reg("get_position", get_position),
			new luaL_Reg("get_size", get_size),
			new luaL_Reg("set_size", set_size),
			new luaL_Reg("set_depth", set_depth),
			new luaL_Reg("get_depth", get_depth),
			new luaL_Reg("get_game_object", get_game_object),
			new luaL_Reg("get_parent", get_parent),
			new luaL_Reg("set_parent", set_parent),
			new luaL_Reg("clone", clone),
			new luaL_Reg("destroy_object", destroy_object)
		};

		private static string string_get_pid = "ngui_widget:get_pid";

		private static string string_set_active = "ngui_widget:set_active";

		private static string string_set_name = "ngui_widget:set_name";

		private static string string_get_name = "ngui_widget:get_name";

		private static string string_set_position = "ngui_widget:set_position";

		private static string string_get_position = "ngui_widget:get_position";

		private static string string_get_size = "ngui_widget:get_size";

		private static string string_set_size = "ngui_widget:set_size";

		private static string string_set_depth = "ngui_widget:set_depth";

		private static string string_get_depth = "ngui_widget:get_depth";

		private static string string_get_game_object = "ngui_widget:get_game_object";

		private static string string_get_parent = "ngui_widget:get_parent";

		private static string string_set_parent = "ngui_widget:set_parent";

		private static string string_clone = "ngui_widget:clone";

		private static string string_destroy_object = "ngui_widget:destroy_object";

		public static bool init(IntPtr L)
		{
			if (L != IntPtr.Zero)
			{
				LuaDLL.register_class(L, name, func, gc);
				return true;
			}
			return false;
		}

		public static void push(IntPtr L, NGUIWidgetWrap obj)
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
				NGUIWidgetWrap nGUIWidgetWrap = null;
				nGUIWidgetWrap = WraperUtil.LuaToUserdata(L, 1, string_get_pid, NGUIWidgetWrap.cache);
				LuaDLL.lua_pushnumber(L, nGUIWidgetWrap.GetPid());
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
				NGUIWidgetWrap nGUIWidgetWrap = null;
				bool flag = false;
				nGUIWidgetWrap = WraperUtil.LuaToUserdata(L, 1, string_set_active, NGUIWidgetWrap.cache);
				flag = LuaDLL.lua_toboolean(L, 2);
				nGUIWidgetWrap.bcomponent.gameObject.SetActive(flag);
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
				NGUIWidgetWrap nGUIWidgetWrap = null;
				string text = null;
				nGUIWidgetWrap = WraperUtil.LuaToUserdata(L, 1, string_set_name, NGUIWidgetWrap.cache);
				text = LuaDLL.lua_tostring(L, 2);
				nGUIWidgetWrap.bcomponent.gameObject.name = text;
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
				NGUIWidgetWrap nGUIWidgetWrap = null;
				nGUIWidgetWrap = WraperUtil.LuaToUserdata(L, 1, string_get_name, NGUIWidgetWrap.cache);
				LuaDLL.lua_pushstring(L, nGUIWidgetWrap.bcomponent.gameObject.name);
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
				NGUIWidgetWrap nGUIWidgetWrap = null;
				float num = 0f;
				float num2 = 0f;
				float num3 = 0f;
				nGUIWidgetWrap = WraperUtil.LuaToUserdata(L, 1, string_set_position, NGUIWidgetWrap.cache);
				num = (float)LuaDLL.lua_tonumber(L, 2);
				num2 = (float)LuaDLL.lua_tonumber(L, 3);
				num3 = (float)LuaDLL.lua_tonumber(L, 4);
				nGUIWidgetWrap.bcomponent.gameObject.transform.localPosition = new Vector3(num, num2, num3);
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
				NGUIWidgetWrap nGUIWidgetWrap = null;
				nGUIWidgetWrap = WraperUtil.LuaToUserdata(L, 1, string_get_position, NGUIWidgetWrap.cache);
				Vector3 localPosition = nGUIWidgetWrap.bcomponent.gameObject.transform.localPosition;
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
				NGUIWidgetWrap nGUIWidgetWrap = null;
				nGUIWidgetWrap = WraperUtil.LuaToUserdata(L, 1, string_get_size, NGUIWidgetWrap.cache);
				int num = ((!(nGUIWidgetWrap.widget == null)) ? nGUIWidgetWrap.widget.width : 0);
				int num2 = ((!(nGUIWidgetWrap.widget == null)) ? nGUIWidgetWrap.widget.height : 0);
				LuaDLL.lua_pushnumber(L, num);
				LuaDLL.lua_pushnumber(L, num2);
				result = 2;
			}
			return result;
		}

		[MonoPInvokeCallback(typeof(LuaCSFunction))]
		private static int set_size(IntPtr L)
		{
			int result = 0;
			if (WraperUtil.ValidIsUserdata(L, 1, string_set_size) && WraperUtil.ValidIsNumber(L, 2, string_set_size) && WraperUtil.ValidIsNumber(L, 3, string_set_size))
			{
				NGUIWidgetWrap nGUIWidgetWrap = null;
				nGUIWidgetWrap = WraperUtil.LuaToUserdata(L, 1, string_set_size, NGUIWidgetWrap.cache);
				int width = LuaDLL.lua_tointeger(L, 2);
				int height = LuaDLL.lua_tointeger(L, 3);
				if (nGUIWidgetWrap != null && nGUIWidgetWrap.widget != null)
				{
					nGUIWidgetWrap.widget.width = width;
					nGUIWidgetWrap.widget.height = height;
				}
				result = 0;
			}
			return result;
		}

		[MonoPInvokeCallback(typeof(LuaCSFunction))]
		private static int set_depth(IntPtr L)
		{
			int result = 0;
			if (WraperUtil.ValidIsUserdata(L, 1, string_set_depth) && WraperUtil.ValidIsNumber(L, 2, string_set_depth))
			{
				NGUIWidgetWrap nGUIWidgetWrap = null;
				int num = 0;
				nGUIWidgetWrap = WraperUtil.LuaToUserdata(L, 1, string_set_depth, NGUIWidgetWrap.cache);
				num = (int)LuaDLL.lua_tonumber(L, 2);
				nGUIWidgetWrap.component.depth = num;
				result = 0;
			}
			return result;
		}

		[MonoPInvokeCallback(typeof(LuaCSFunction))]
		private static int get_depth(IntPtr L)
		{
			int result = 0;
			if (WraperUtil.ValidIsUserdata(L, 1, string_get_depth))
			{
				NGUIWidgetWrap nGUIWidgetWrap = null;
				nGUIWidgetWrap = WraperUtil.LuaToUserdata(L, 1, string_get_depth, NGUIWidgetWrap.cache);
				LuaDLL.lua_pushnumber(L, nGUIWidgetWrap.component.depth);
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
				NGUIWidgetWrap nGUIWidgetWrap = null;
				nGUIWidgetWrap = WraperUtil.LuaToUserdata(L, 1, string_get_game_object, NGUIWidgetWrap.cache);
				AssetGameObject base_object = AssetGameObject.CreateByInstance(nGUIWidgetWrap.bcomponent.gameObject);
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
				NGUIWidgetWrap nGUIWidgetWrap = null;
				nGUIWidgetWrap = WraperUtil.LuaToUserdata(L, 1, string_get_parent, NGUIWidgetWrap.cache);
				AssetGameObject assetGameObject = null;
				Transform parent = nGUIWidgetWrap.bcomponent.gameObject.transform.parent;
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
				NGUIWidgetWrap nGUIWidgetWrap = null;
				AssetGameObject assetGameObject = null;
				nGUIWidgetWrap = WraperUtil.LuaToUserdata(L, 1, string_set_parent, NGUIWidgetWrap.cache);
				assetGameObject = WraperUtil.LuaToUserdataOrNil(L, 2, string_set_parent, AssetGameObject.cache);
				nGUIWidgetWrap.bcomponent.gameObject.transform.parent = ((assetGameObject != null) ? assetGameObject.transform : null);
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
				NGUIWidgetWrap nGUIWidgetWrap = null;
				nGUIWidgetWrap = WraperUtil.LuaToUserdata(L, 1, string_clone, NGUIWidgetWrap.cache);
				nGUIWidgetWrap.Clone(L);
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
				NGUIWidgetWrap nGUIWidgetWrap = null;
				nGUIWidgetWrap = WraperUtil.LuaToUserdata(L, 1, string_destroy_object, NGUIWidgetWrap.cache);
				nGUIWidgetWrap.isNeedDestroy = true;
				result = 0;
			}
			return result;
		}

		[MonoPInvokeCallback(typeof(LuaCSFunction))]
		private static int gc(IntPtr L)
		{
			NGUIWidgetWrap nGUIWidgetWrap = WraperUtil.LuaToUserdataByGc(L, 1, "gc ngui_widget", NGUIWidgetWrap.cache);
			if (nGUIWidgetWrap != null)
			{
				nGUIWidgetWrap.DestroyInstance();
			}
			return 0;
		}
	}
}
