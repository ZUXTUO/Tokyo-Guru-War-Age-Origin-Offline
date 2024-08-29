using System;
using LuaInterface;
using UnityEngine;
using UnityWrap;

namespace Wraper
{
	public class ngui_progress_bar_wraper
	{
		public static string name = "ngui_progress_bar";

		private static luaL_Reg[] func = new luaL_Reg[14]
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
			new luaL_Reg("set_value", set_value),
			new luaL_Reg("get_value", get_value)
		};

		private static string string_get_pid = "ngui_progress_bar:get_pid";

		private static string string_set_active = "ngui_progress_bar:set_active";

		private static string string_set_name = "ngui_progress_bar:set_name";

		private static string string_get_name = "ngui_progress_bar:get_name";

		private static string string_set_position = "ngui_progress_bar:set_position";

		private static string string_get_position = "ngui_progress_bar:get_position";

		private static string string_get_size = "ngui_progress_bar:get_size";

		private static string string_get_game_object = "ngui_progress_bar:get_game_object";

		private static string string_get_parent = "ngui_progress_bar:get_parent";

		private static string string_set_parent = "ngui_progress_bar:set_parent";

		private static string string_clone = "ngui_progress_bar:clone";

		private static string string_destroy_object = "ngui_progress_bar:destroy_object";

		private static string string_set_value = "ngui_progress_bar:set_value";

		private static string string_get_value = "ngui_progress_bar:get_value";

		public static bool init(IntPtr L)
		{
			if (L != IntPtr.Zero)
			{
				LuaDLL.register_class(L, name, func, gc);
				return true;
			}
			return false;
		}

		public static void push(IntPtr L, NGUIProgressBarWrap obj)
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
				NGUIProgressBarWrap nGUIProgressBarWrap = null;
				nGUIProgressBarWrap = WraperUtil.LuaToUserdata(L, 1, string_get_pid, NGUIProgressBarWrap.cache);
				LuaDLL.lua_pushnumber(L, nGUIProgressBarWrap.GetPid());
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
				NGUIProgressBarWrap nGUIProgressBarWrap = null;
				bool flag = false;
				nGUIProgressBarWrap = WraperUtil.LuaToUserdata(L, 1, string_set_active, NGUIProgressBarWrap.cache);
				flag = LuaDLL.lua_toboolean(L, 2);
				nGUIProgressBarWrap.bcomponent.gameObject.SetActive(flag);
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
				NGUIProgressBarWrap nGUIProgressBarWrap = null;
				string text = null;
				nGUIProgressBarWrap = WraperUtil.LuaToUserdata(L, 1, string_set_name, NGUIProgressBarWrap.cache);
				text = LuaDLL.lua_tostring(L, 2);
				nGUIProgressBarWrap.bcomponent.gameObject.name = text;
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
				NGUIProgressBarWrap nGUIProgressBarWrap = null;
				nGUIProgressBarWrap = WraperUtil.LuaToUserdata(L, 1, string_get_name, NGUIProgressBarWrap.cache);
				LuaDLL.lua_pushstring(L, nGUIProgressBarWrap.bcomponent.gameObject.name);
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
				NGUIProgressBarWrap nGUIProgressBarWrap = null;
				float num = 0f;
				float num2 = 0f;
				float num3 = 0f;
				nGUIProgressBarWrap = WraperUtil.LuaToUserdata(L, 1, string_set_position, NGUIProgressBarWrap.cache);
				num = (float)LuaDLL.lua_tonumber(L, 2);
				num2 = (float)LuaDLL.lua_tonumber(L, 3);
				num3 = (float)LuaDLL.lua_tonumber(L, 4);
				nGUIProgressBarWrap.bcomponent.gameObject.transform.localPosition = new Vector3(num, num2, num3);
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
				NGUIProgressBarWrap nGUIProgressBarWrap = null;
				nGUIProgressBarWrap = WraperUtil.LuaToUserdata(L, 1, string_get_position, NGUIProgressBarWrap.cache);
				Vector3 localPosition = nGUIProgressBarWrap.bcomponent.gameObject.transform.localPosition;
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
				NGUIProgressBarWrap nGUIProgressBarWrap = null;
				nGUIProgressBarWrap = WraperUtil.LuaToUserdata(L, 1, string_get_size, NGUIProgressBarWrap.cache);
				int num = ((!(nGUIProgressBarWrap.widget == null)) ? nGUIProgressBarWrap.widget.width : 0);
				int num2 = ((!(nGUIProgressBarWrap.widget == null)) ? nGUIProgressBarWrap.widget.height : 0);
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
				NGUIProgressBarWrap nGUIProgressBarWrap = null;
				nGUIProgressBarWrap = WraperUtil.LuaToUserdata(L, 1, string_get_game_object, NGUIProgressBarWrap.cache);
				AssetGameObject base_object = AssetGameObject.CreateByInstance(nGUIProgressBarWrap.bcomponent.gameObject);
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
				NGUIProgressBarWrap nGUIProgressBarWrap = null;
				nGUIProgressBarWrap = WraperUtil.LuaToUserdata(L, 1, string_get_parent, NGUIProgressBarWrap.cache);
				AssetGameObject assetGameObject = null;
				Transform parent = nGUIProgressBarWrap.bcomponent.gameObject.transform.parent;
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
				NGUIProgressBarWrap nGUIProgressBarWrap = null;
				AssetGameObject assetGameObject = null;
				nGUIProgressBarWrap = WraperUtil.LuaToUserdata(L, 1, string_set_parent, NGUIProgressBarWrap.cache);
				assetGameObject = WraperUtil.LuaToUserdataOrNil(L, 2, string_set_parent, AssetGameObject.cache);
				nGUIProgressBarWrap.bcomponent.gameObject.transform.parent = ((assetGameObject != null) ? assetGameObject.transform : null);
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
				NGUIProgressBarWrap nGUIProgressBarWrap = null;
				nGUIProgressBarWrap = WraperUtil.LuaToUserdata(L, 1, string_clone, NGUIProgressBarWrap.cache);
				nGUIProgressBarWrap.Clone(L);
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
				NGUIProgressBarWrap nGUIProgressBarWrap = null;
				nGUIProgressBarWrap = WraperUtil.LuaToUserdata(L, 1, string_destroy_object, NGUIProgressBarWrap.cache);
				nGUIProgressBarWrap.isNeedDestroy = true;
				result = 0;
			}
			return result;
		}

		[MonoPInvokeCallback(typeof(LuaCSFunction))]
		private static int set_value(IntPtr L)
		{
			int result = 0;
			if (WraperUtil.ValidIsUserdata(L, 1, string_set_value) && WraperUtil.ValidIsNumber(L, 2, string_set_value))
			{
				NGUIProgressBarWrap nGUIProgressBarWrap = null;
				float num = 0f;
				nGUIProgressBarWrap = WraperUtil.LuaToUserdata(L, 1, string_set_value, NGUIProgressBarWrap.cache);
				num = (float)LuaDLL.lua_tonumber(L, 2);
				nGUIProgressBarWrap.component.value = num;
				result = 0;
			}
			return result;
		}

		[MonoPInvokeCallback(typeof(LuaCSFunction))]
		private static int get_value(IntPtr L)
		{
			int result = 0;
			if (WraperUtil.ValidIsUserdata(L, 1, string_get_value))
			{
				NGUIProgressBarWrap nGUIProgressBarWrap = null;
				nGUIProgressBarWrap = WraperUtil.LuaToUserdata(L, 1, string_get_value, NGUIProgressBarWrap.cache);
				LuaDLL.lua_pushnumber(L, nGUIProgressBarWrap.component.value);
				result = 1;
			}
			return result;
		}

		[MonoPInvokeCallback(typeof(LuaCSFunction))]
		private static int gc(IntPtr L)
		{
			NGUIProgressBarWrap nGUIProgressBarWrap = WraperUtil.LuaToUserdataByGc(L, 1, "gc ngui_progress_bar", NGUIProgressBarWrap.cache);
			if (nGUIProgressBarWrap != null)
			{
				nGUIProgressBarWrap.DestroyInstance();
			}
			return 0;
		}
	}
}
