using System;
using LuaInterface;
using UnityEngine;
using UnityWrap;

namespace Wraper
{
	public class ngui_slider_wraper
	{
		public static string name = "ngui_slider";

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
			new luaL_Reg("set_value", set_value),
			new luaL_Reg("get_value", get_value),
			new luaL_Reg("set_on_change", set_on_change),
			new luaL_Reg("set_steps", set_steps)
		};

		private static string string_get_pid = "ngui_slider:get_pid";

		private static string string_set_active = "ngui_slider:set_active";

		private static string string_set_name = "ngui_slider:set_name";

		private static string string_get_name = "ngui_slider:get_name";

		private static string string_set_position = "ngui_slider:set_position";

		private static string string_get_position = "ngui_slider:get_position";

		private static string string_get_size = "ngui_slider:get_size";

		private static string string_get_game_object = "ngui_slider:get_game_object";

		private static string string_get_parent = "ngui_slider:get_parent";

		private static string string_set_parent = "ngui_slider:set_parent";

		private static string string_clone = "ngui_slider:clone";

		private static string string_destroy_object = "ngui_slider:destroy_object";

		private static string string_set_value = "ngui_slider:set_value";

		private static string string_get_value = "ngui_slider:get_value";

		private static string string_set_on_change = "ngui_slider:set_on_change";

		private static string string_set_steps = "ngui_slider:set_steps";

		public static bool init(IntPtr L)
		{
			if (L != IntPtr.Zero)
			{
				LuaDLL.register_class(L, name, func, gc);
				return true;
			}
			return false;
		}

		public static void push(IntPtr L, NGUISliderWrap obj)
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
				NGUISliderWrap nGUISliderWrap = null;
				nGUISliderWrap = WraperUtil.LuaToUserdata(L, 1, string_get_pid, NGUISliderWrap.cache);
				LuaDLL.lua_pushnumber(L, nGUISliderWrap.GetPid());
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
				NGUISliderWrap nGUISliderWrap = null;
				bool flag = false;
				nGUISliderWrap = WraperUtil.LuaToUserdata(L, 1, string_set_active, NGUISliderWrap.cache);
				flag = LuaDLL.lua_toboolean(L, 2);
				nGUISliderWrap.bcomponent.gameObject.SetActive(flag);
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
				NGUISliderWrap nGUISliderWrap = null;
				string text = null;
				nGUISliderWrap = WraperUtil.LuaToUserdata(L, 1, string_set_name, NGUISliderWrap.cache);
				text = LuaDLL.lua_tostring(L, 2);
				nGUISliderWrap.bcomponent.gameObject.name = text;
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
				NGUISliderWrap nGUISliderWrap = null;
				nGUISliderWrap = WraperUtil.LuaToUserdata(L, 1, string_get_name, NGUISliderWrap.cache);
				LuaDLL.lua_pushstring(L, nGUISliderWrap.bcomponent.gameObject.name);
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
				NGUISliderWrap nGUISliderWrap = null;
				float num = 0f;
				float num2 = 0f;
				float num3 = 0f;
				nGUISliderWrap = WraperUtil.LuaToUserdata(L, 1, string_set_position, NGUISliderWrap.cache);
				num = (float)LuaDLL.lua_tonumber(L, 2);
				num2 = (float)LuaDLL.lua_tonumber(L, 3);
				num3 = (float)LuaDLL.lua_tonumber(L, 4);
				nGUISliderWrap.bcomponent.gameObject.transform.localPosition = new Vector3(num, num2, num3);
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
				NGUISliderWrap nGUISliderWrap = null;
				nGUISliderWrap = WraperUtil.LuaToUserdata(L, 1, string_get_position, NGUISliderWrap.cache);
				Vector3 localPosition = nGUISliderWrap.bcomponent.gameObject.transform.localPosition;
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
				NGUISliderWrap nGUISliderWrap = null;
				nGUISliderWrap = WraperUtil.LuaToUserdata(L, 1, string_get_size, NGUISliderWrap.cache);
				int num = ((!(nGUISliderWrap.widget == null)) ? nGUISliderWrap.widget.width : 0);
				int num2 = ((!(nGUISliderWrap.widget == null)) ? nGUISliderWrap.widget.height : 0);
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
				NGUISliderWrap nGUISliderWrap = null;
				nGUISliderWrap = WraperUtil.LuaToUserdata(L, 1, string_get_game_object, NGUISliderWrap.cache);
				AssetGameObject base_object = AssetGameObject.CreateByInstance(nGUISliderWrap.bcomponent.gameObject);
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
				NGUISliderWrap nGUISliderWrap = null;
				nGUISliderWrap = WraperUtil.LuaToUserdata(L, 1, string_get_parent, NGUISliderWrap.cache);
				AssetGameObject assetGameObject = null;
				Transform parent = nGUISliderWrap.bcomponent.gameObject.transform.parent;
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
				NGUISliderWrap nGUISliderWrap = null;
				AssetGameObject assetGameObject = null;
				nGUISliderWrap = WraperUtil.LuaToUserdata(L, 1, string_set_parent, NGUISliderWrap.cache);
				assetGameObject = WraperUtil.LuaToUserdataOrNil(L, 2, string_set_parent, AssetGameObject.cache);
				nGUISliderWrap.bcomponent.gameObject.transform.parent = ((assetGameObject != null) ? assetGameObject.transform : null);
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
				NGUISliderWrap nGUISliderWrap = null;
				nGUISliderWrap = WraperUtil.LuaToUserdata(L, 1, string_clone, NGUISliderWrap.cache);
				nGUISliderWrap.Clone(L);
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
				NGUISliderWrap nGUISliderWrap = null;
				nGUISliderWrap = WraperUtil.LuaToUserdata(L, 1, string_destroy_object, NGUISliderWrap.cache);
				nGUISliderWrap.isNeedDestroy = true;
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
				NGUISliderWrap nGUISliderWrap = null;
				float num = 0f;
				nGUISliderWrap = WraperUtil.LuaToUserdata(L, 1, string_set_value, NGUISliderWrap.cache);
				num = (float)LuaDLL.lua_tonumber(L, 2);
				nGUISliderWrap.component.value = num;
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
				NGUISliderWrap nGUISliderWrap = null;
				nGUISliderWrap = WraperUtil.LuaToUserdata(L, 1, string_get_value, NGUISliderWrap.cache);
				LuaDLL.lua_pushnumber(L, nGUISliderWrap.component.value);
				result = 1;
			}
			return result;
		}

		[MonoPInvokeCallback(typeof(LuaCSFunction))]
		private static int set_on_change(IntPtr L)
		{
			int result = 0;
			if (WraperUtil.ValidIsUserdata(L, 1, string_set_on_change) && WraperUtil.ValidIsString(L, 2, string_set_on_change))
			{
				NGUISliderWrap nGUISliderWrap = null;
				string text = null;
				nGUISliderWrap = WraperUtil.LuaToUserdata(L, 1, string_set_on_change, NGUISliderWrap.cache);
				text = LuaDLL.lua_tostring(L, 2);
				nGUISliderWrap.onChange = text;
				result = 0;
			}
			return result;
		}

		[MonoPInvokeCallback(typeof(LuaCSFunction))]
		private static int set_steps(IntPtr L)
		{
			int result = 0;
			if (WraperUtil.ValidIsUserdata(L, 1, string_set_steps) && WraperUtil.ValidIsNumber(L, 2, string_set_steps))
			{
				NGUISliderWrap nGUISliderWrap = null;
				int num = 0;
				nGUISliderWrap = WraperUtil.LuaToUserdata(L, 1, string_set_steps, NGUISliderWrap.cache);
				num = LuaDLL.lua_tointeger(L, 2);
				nGUISliderWrap.component.numberOfSteps = num;
				result = 0;
			}
			return result;
		}

		[MonoPInvokeCallback(typeof(LuaCSFunction))]
		private static int gc(IntPtr L)
		{
			NGUISliderWrap nGUISliderWrap = WraperUtil.LuaToUserdataByGc(L, 1, "gc ngui_slider", NGUISliderWrap.cache);
			if (nGUISliderWrap != null)
			{
				nGUISliderWrap.DestroyInstance();
			}
			return 0;
		}
	}
}
