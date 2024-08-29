using System;
using LuaInterface;
using UnityEngine;
using UnityWrap;

namespace Wraper
{
	public class ngui_toggle_wraper
	{
		public static string name = "ngui_toggle";

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
			new luaL_Reg("set_group", set_group),
			new luaL_Reg("get_group", get_group),
			new luaL_Reg("get_value", get_value),
			new luaL_Reg("set_value", set_value),
			new luaL_Reg("set_on_change", set_on_change),
			new luaL_Reg("can_option_none", can_option_none),
			new luaL_Reg("set_enable", set_enable),
			new luaL_Reg("get_enable", get_enable),
			new luaL_Reg("set_start_active", set_start_active)
		};

		private static string string_get_pid = "ngui_toggle:get_pid";

		private static string string_set_active = "ngui_toggle:set_active";

		private static string string_set_name = "ngui_toggle:set_name";

		private static string string_get_name = "ngui_toggle:get_name";

		private static string string_set_position = "ngui_toggle:set_position";

		private static string string_get_position = "ngui_toggle:get_position";

		private static string string_get_size = "ngui_toggle:get_size";

		private static string string_get_game_object = "ngui_toggle:get_game_object";

		private static string string_get_parent = "ngui_toggle:get_parent";

		private static string string_set_parent = "ngui_toggle:set_parent";

		private static string string_clone = "ngui_toggle:clone";

		private static string string_destroy_object = "ngui_toggle:destroy_object";

		private static string string_set_group = "ngui_toggle:set_group";

		private static string string_get_group = "ngui_toggle:get_group";

		private static string string_get_value = "ngui_toggle:get_value";

		private static string string_set_value = "ngui_toggle:set_value";

		private static string string_set_on_change = "ngui_toggle:set_on_change";

		private static string string_can_option_none = "ngui_toggle:can_option_none";

		private static string string_set_enable = "ngui_toggle:set_enable";

		private static string string_get_enable = "ngui_toggle:get_enable";

		private static string string_set_star_active = "ngui_toggle:set_start_active";

		public static bool init(IntPtr L)
		{
			if (L != IntPtr.Zero)
			{
				LuaDLL.register_class(L, name, func, gc);
				return true;
			}
			return false;
		}

		public static void push(IntPtr L, NGUIToggleWrap obj)
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
				NGUIToggleWrap nGUIToggleWrap = null;
				nGUIToggleWrap = WraperUtil.LuaToUserdata(L, 1, string_get_pid, NGUIToggleWrap.cache);
				LuaDLL.lua_pushnumber(L, nGUIToggleWrap.GetPid());
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
				NGUIToggleWrap nGUIToggleWrap = null;
				bool flag = false;
				nGUIToggleWrap = WraperUtil.LuaToUserdata(L, 1, string_set_active, NGUIToggleWrap.cache);
				flag = LuaDLL.lua_toboolean(L, 2);
				nGUIToggleWrap.bcomponent.gameObject.SetActive(flag);
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
				NGUIToggleWrap nGUIToggleWrap = null;
				string text = null;
				nGUIToggleWrap = WraperUtil.LuaToUserdata(L, 1, string_set_name, NGUIToggleWrap.cache);
				text = LuaDLL.lua_tostring(L, 2);
				nGUIToggleWrap.bcomponent.gameObject.name = text;
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
				NGUIToggleWrap nGUIToggleWrap = null;
				nGUIToggleWrap = WraperUtil.LuaToUserdata(L, 1, string_get_name, NGUIToggleWrap.cache);
				LuaDLL.lua_pushstring(L, nGUIToggleWrap.bcomponent.gameObject.name);
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
				NGUIToggleWrap nGUIToggleWrap = null;
				float num = 0f;
				float num2 = 0f;
				float num3 = 0f;
				nGUIToggleWrap = WraperUtil.LuaToUserdata(L, 1, string_set_position, NGUIToggleWrap.cache);
				num = (float)LuaDLL.lua_tonumber(L, 2);
				num2 = (float)LuaDLL.lua_tonumber(L, 3);
				num3 = (float)LuaDLL.lua_tonumber(L, 4);
				nGUIToggleWrap.bcomponent.gameObject.transform.localPosition = new Vector3(num, num2, num3);
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
				NGUIToggleWrap nGUIToggleWrap = null;
				nGUIToggleWrap = WraperUtil.LuaToUserdata(L, 1, string_get_position, NGUIToggleWrap.cache);
				Vector3 localPosition = nGUIToggleWrap.bcomponent.gameObject.transform.localPosition;
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
				NGUIToggleWrap nGUIToggleWrap = null;
				nGUIToggleWrap = WraperUtil.LuaToUserdata(L, 1, string_get_size, NGUIToggleWrap.cache);
				int num = ((!(nGUIToggleWrap.widget == null)) ? nGUIToggleWrap.widget.width : 0);
				int num2 = ((!(nGUIToggleWrap.widget == null)) ? nGUIToggleWrap.widget.height : 0);
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
				NGUIToggleWrap nGUIToggleWrap = null;
				nGUIToggleWrap = WraperUtil.LuaToUserdata(L, 1, string_get_game_object, NGUIToggleWrap.cache);
				AssetGameObject base_object = AssetGameObject.CreateByInstance(nGUIToggleWrap.bcomponent.gameObject);
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
				NGUIToggleWrap nGUIToggleWrap = null;
				nGUIToggleWrap = WraperUtil.LuaToUserdata(L, 1, string_get_parent, NGUIToggleWrap.cache);
				AssetGameObject assetGameObject = null;
				Transform parent = nGUIToggleWrap.bcomponent.gameObject.transform.parent;
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
				NGUIToggleWrap nGUIToggleWrap = null;
				AssetGameObject assetGameObject = null;
				nGUIToggleWrap = WraperUtil.LuaToUserdata(L, 1, string_set_parent, NGUIToggleWrap.cache);
				assetGameObject = WraperUtil.LuaToUserdataOrNil(L, 2, string_set_parent, AssetGameObject.cache);
				nGUIToggleWrap.bcomponent.gameObject.transform.parent = ((assetGameObject != null) ? assetGameObject.transform : null);
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
				NGUIToggleWrap nGUIToggleWrap = null;
				nGUIToggleWrap = WraperUtil.LuaToUserdata(L, 1, string_clone, NGUIToggleWrap.cache);
				nGUIToggleWrap.Clone(L);
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
				NGUIToggleWrap nGUIToggleWrap = null;
				nGUIToggleWrap = WraperUtil.LuaToUserdata(L, 1, string_destroy_object, NGUIToggleWrap.cache);
				nGUIToggleWrap.isNeedDestroy = true;
				result = 0;
			}
			return result;
		}

		[MonoPInvokeCallback(typeof(LuaCSFunction))]
		private static int set_group(IntPtr L)
		{
			int result = 0;
			if (WraperUtil.ValidIsUserdata(L, 1, string_set_group) && WraperUtil.ValidIsNumber(L, 2, string_set_group))
			{
				NGUIToggleWrap nGUIToggleWrap = null;
				int num = 0;
				nGUIToggleWrap = WraperUtil.LuaToUserdata(L, 1, string_set_group, NGUIToggleWrap.cache);
				num = (int)LuaDLL.lua_tonumber(L, 2);
				nGUIToggleWrap.component.group = num;
				result = 0;
			}
			return result;
		}

		[MonoPInvokeCallback(typeof(LuaCSFunction))]
		private static int get_group(IntPtr L)
		{
			int result = 0;
			if (WraperUtil.ValidIsUserdata(L, 1, string_get_group))
			{
				NGUIToggleWrap nGUIToggleWrap = null;
				nGUIToggleWrap = WraperUtil.LuaToUserdata(L, 1, string_get_group, NGUIToggleWrap.cache);
				LuaDLL.lua_pushnumber(L, nGUIToggleWrap.component.group);
				result = 1;
			}
			return result;
		}

		[MonoPInvokeCallback(typeof(LuaCSFunction))]
		private static int get_value(IntPtr L)
		{
			int result = 0;
			if (WraperUtil.ValidIsUserdata(L, 1, string_get_value))
			{
				NGUIToggleWrap nGUIToggleWrap = null;
				nGUIToggleWrap = WraperUtil.LuaToUserdata(L, 1, string_get_value, NGUIToggleWrap.cache);
				LuaDLL.lua_pushboolean(L, nGUIToggleWrap.component.value);
				result = 1;
			}
			return result;
		}

		[MonoPInvokeCallback(typeof(LuaCSFunction))]
		private static int set_value(IntPtr L)
		{
			int result = 0;
			if (WraperUtil.ValidIsUserdata(L, 1, string_set_value) && WraperUtil.ValidIsBoolean(L, 2, string_set_value))
			{
				NGUIToggleWrap nGUIToggleWrap = null;
				bool flag = false;
				nGUIToggleWrap = WraperUtil.LuaToUserdata(L, 1, string_set_value, NGUIToggleWrap.cache);
				flag = LuaDLL.lua_toboolean(L, 2);
				nGUIToggleWrap.component.value = flag;
				result = 0;
			}
			return result;
		}

		[MonoPInvokeCallback(typeof(LuaCSFunction))]
		private static int set_on_change(IntPtr L)
		{
			int result = 0;
			if (WraperUtil.ValidIsUserdata(L, 1, string_set_on_change) && WraperUtil.ValidIsString(L, 2, string_set_on_change))
			{
				NGUIToggleWrap nGUIToggleWrap = null;
				string text = null;
				nGUIToggleWrap = WraperUtil.LuaToUserdata(L, 1, string_set_on_change, NGUIToggleWrap.cache);
				text = LuaDLL.lua_tostring(L, 2);
				nGUIToggleWrap.onChange = text;
				result = 0;
			}
			return result;
		}

		[MonoPInvokeCallback(typeof(LuaCSFunction))]
		private static int can_option_none(IntPtr L)
		{
			int result = 0;
			if (WraperUtil.ValidIsUserdata(L, 1, string_can_option_none) && WraperUtil.ValidIsBoolean(L, 2, string_can_option_none))
			{
				NGUIToggleWrap nGUIToggleWrap = null;
				bool flag = false;
				nGUIToggleWrap = WraperUtil.LuaToUserdata(L, 1, string_can_option_none, NGUIToggleWrap.cache);
				flag = LuaDLL.lua_toboolean(L, 2);
				nGUIToggleWrap.component.optionCanBeNone = flag;
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
				NGUIToggleWrap nGUIToggleWrap = null;
				bool flag = false;
				nGUIToggleWrap = WraperUtil.LuaToUserdata(L, 1, string_set_enable, NGUIToggleWrap.cache);
				flag = LuaDLL.lua_toboolean(L, 2);
				nGUIToggleWrap.SetEnable(flag);
				result = 0;
			}
			return result;
		}

		[MonoPInvokeCallback(typeof(LuaCSFunction))]
		private static int get_enable(IntPtr L)
		{
			int result = 0;
			if (WraperUtil.ValidIsUserdata(L, 1, string_get_enable))
			{
				NGUIToggleWrap nGUIToggleWrap = WraperUtil.LuaToUserdata(L, 1, string_get_enable, NGUIToggleWrap.cache);
				LuaDLL.lua_pushboolean(L, nGUIToggleWrap.component.enabled);
				result = 1;
			}
			return result;
		}

		[MonoPInvokeCallback(typeof(LuaCSFunction))]
		private static int set_start_active(IntPtr L)
		{
			int result = 0;
			if (WraperUtil.ValidIsUserdata(L, 1, string_set_star_active) && WraperUtil.ValidIsBoolean(L, 2, string_set_star_active))
			{
				NGUIToggleWrap nGUIToggleWrap = null;
				bool flag = false;
				nGUIToggleWrap = WraperUtil.LuaToUserdata(L, 1, string_set_star_active, NGUIToggleWrap.cache);
				flag = LuaDLL.lua_toboolean(L, 2);
				nGUIToggleWrap.component.startsActive = flag;
				result = 0;
			}
			return result;
		}

		[MonoPInvokeCallback(typeof(LuaCSFunction))]
		private static int gc(IntPtr L)
		{
			NGUIToggleWrap nGUIToggleWrap = WraperUtil.LuaToUserdataByGc(L, 1, "gc ngui_toggle", NGUIToggleWrap.cache);
			if (nGUIToggleWrap != null)
			{
				nGUIToggleWrap.DestroyInstance();
			}
			return 0;
		}
	}
}
