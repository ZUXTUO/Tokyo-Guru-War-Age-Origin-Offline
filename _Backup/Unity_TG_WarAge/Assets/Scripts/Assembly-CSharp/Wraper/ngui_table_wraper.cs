using System;
using LuaInterface;
using UnityEngine;
using UnityWrap;

namespace Wraper
{
	public class ngui_table_wraper
	{
		public static string name = "ngui_table";

		private static luaL_Reg[] func = new luaL_Reg[13]
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
			new luaL_Reg("reposition_now", reposition_now)
		};

		private static string string_get_pid = "ngui_table:get_pid";

		private static string string_set_active = "ngui_table:set_active";

		private static string string_set_name = "ngui_table:set_name";

		private static string string_get_name = "ngui_table:get_name";

		private static string string_set_position = "ngui_table:set_position";

		private static string string_get_position = "ngui_table:get_position";

		private static string string_get_size = "ngui_table:get_size";

		private static string string_get_game_object = "ngui_table:get_game_object";

		private static string string_get_parent = "ngui_table:get_parent";

		private static string string_set_parent = "ngui_table:set_parent";

		private static string string_clone = "ngui_table:clone";

		private static string string_destroy_object = "ngui_table:destroy_object";

		private static string string_reposition_now = "ngui_table:reposition_now";

		public static bool init(IntPtr L)
		{
			if (L != IntPtr.Zero)
			{
				LuaDLL.register_class(L, name, func, gc);
				return true;
			}
			return false;
		}

		public static void push(IntPtr L, NGUITableWrap obj)
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
				NGUITableWrap nGUITableWrap = null;
				nGUITableWrap = WraperUtil.LuaToUserdata(L, 1, string_get_pid, NGUITableWrap.cache);
				LuaDLL.lua_pushnumber(L, nGUITableWrap.GetPid());
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
				NGUITableWrap nGUITableWrap = null;
				bool flag = false;
				nGUITableWrap = WraperUtil.LuaToUserdata(L, 1, string_set_active, NGUITableWrap.cache);
				flag = LuaDLL.lua_toboolean(L, 2);
				nGUITableWrap.bcomponent.gameObject.SetActive(flag);
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
				NGUITableWrap nGUITableWrap = null;
				string text = null;
				nGUITableWrap = WraperUtil.LuaToUserdata(L, 1, string_set_name, NGUITableWrap.cache);
				text = LuaDLL.lua_tostring(L, 2);
				nGUITableWrap.bcomponent.gameObject.name = text;
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
				NGUITableWrap nGUITableWrap = null;
				nGUITableWrap = WraperUtil.LuaToUserdata(L, 1, string_get_name, NGUITableWrap.cache);
				LuaDLL.lua_pushstring(L, nGUITableWrap.bcomponent.gameObject.name);
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
				NGUITableWrap nGUITableWrap = null;
				float num = 0f;
				float num2 = 0f;
				float num3 = 0f;
				nGUITableWrap = WraperUtil.LuaToUserdata(L, 1, string_set_position, NGUITableWrap.cache);
				num = (float)LuaDLL.lua_tonumber(L, 2);
				num2 = (float)LuaDLL.lua_tonumber(L, 3);
				num3 = (float)LuaDLL.lua_tonumber(L, 4);
				nGUITableWrap.bcomponent.gameObject.transform.localPosition = new Vector3(num, num2, num3);
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
				NGUITableWrap nGUITableWrap = null;
				nGUITableWrap = WraperUtil.LuaToUserdata(L, 1, string_get_position, NGUITableWrap.cache);
				Vector3 localPosition = nGUITableWrap.bcomponent.gameObject.transform.localPosition;
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
				NGUITableWrap nGUITableWrap = null;
				nGUITableWrap = WraperUtil.LuaToUserdata(L, 1, string_get_size, NGUITableWrap.cache);
				int num = ((!(nGUITableWrap.widget == null)) ? nGUITableWrap.widget.width : 0);
				int num2 = ((!(nGUITableWrap.widget == null)) ? nGUITableWrap.widget.height : 0);
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
				NGUITableWrap nGUITableWrap = null;
				nGUITableWrap = WraperUtil.LuaToUserdata(L, 1, string_get_game_object, NGUITableWrap.cache);
				AssetGameObject base_object = AssetGameObject.CreateByInstance(nGUITableWrap.bcomponent.gameObject);
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
				NGUITableWrap nGUITableWrap = null;
				nGUITableWrap = WraperUtil.LuaToUserdata(L, 1, string_get_parent, NGUITableWrap.cache);
				AssetGameObject assetGameObject = null;
				Transform parent = nGUITableWrap.bcomponent.gameObject.transform.parent;
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
				NGUITableWrap nGUITableWrap = null;
				AssetGameObject assetGameObject = null;
				nGUITableWrap = WraperUtil.LuaToUserdata(L, 1, string_set_parent, NGUITableWrap.cache);
				assetGameObject = WraperUtil.LuaToUserdataOrNil(L, 2, string_set_parent, AssetGameObject.cache);
				nGUITableWrap.bcomponent.gameObject.transform.parent = ((assetGameObject != null) ? assetGameObject.transform : null);
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
				NGUITableWrap nGUITableWrap = null;
				nGUITableWrap = WraperUtil.LuaToUserdata(L, 1, string_clone, NGUITableWrap.cache);
				nGUITableWrap.Clone(L);
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
				NGUITableWrap nGUITableWrap = null;
				nGUITableWrap = WraperUtil.LuaToUserdata(L, 1, string_destroy_object, NGUITableWrap.cache);
				nGUITableWrap.isNeedDestroy = true;
				result = 0;
			}
			return result;
		}

		[MonoPInvokeCallback(typeof(LuaCSFunction))]
		private static int reposition_now(IntPtr L)
		{
			int result = 0;
			if (WraperUtil.ValidIsUserdata(L, 1, string_reposition_now))
			{
				NGUITableWrap nGUITableWrap = null;
				nGUITableWrap = WraperUtil.LuaToUserdata(L, 1, string_reposition_now, NGUITableWrap.cache);
				nGUITableWrap.component.repositionNow = true;
				result = 0;
			}
			return result;
		}

		[MonoPInvokeCallback(typeof(LuaCSFunction))]
		private static int gc(IntPtr L)
		{
			NGUITableWrap nGUITableWrap = WraperUtil.LuaToUserdataByGc(L, 1, "gc ngui_table", NGUITableWrap.cache);
			if (nGUITableWrap != null)
			{
				nGUITableWrap.DestroyInstance();
			}
			return 0;
		}
	}
}
