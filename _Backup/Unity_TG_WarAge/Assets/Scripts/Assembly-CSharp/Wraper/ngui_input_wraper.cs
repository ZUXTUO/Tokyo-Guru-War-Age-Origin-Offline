using System;
using ComponentEx;
using LuaInterface;
using UnityEngine;
using UnityWrap;

namespace Wraper
{
	public class ngui_input_wraper
	{
		public static string name = "ngui_input";

		private static luaL_Reg[] func = new luaL_Reg[20]
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
			new luaL_Reg("get_value", get_value),
			new luaL_Reg("set_value", set_value),
			new luaL_Reg("get_default_text", get_default_text),
			new luaL_Reg("set_default_text", set_default_text),
			new luaL_Reg("set_on_change", set_on_change),
			new luaL_Reg("set_on_submit", set_on_submit),
			new luaL_Reg("set_on_ngui_click", set_on_ngui_click),
			new luaL_Reg("set_characterlimit", set_characterlimit)
		};

		private static string string_get_pid = "ngui_input:get_pid";

		private static string string_set_active = "ngui_input:set_active";

		private static string string_set_name = "ngui_input:set_name";

		private static string string_get_name = "ngui_input:get_name";

		private static string string_set_position = "ngui_input:set_position";

		private static string string_get_position = "ngui_input:get_position";

		private static string string_get_size = "ngui_input:get_size";

		private static string string_get_game_object = "ngui_input:get_game_object";

		private static string string_get_parent = "ngui_input:get_parent";

		private static string string_set_parent = "ngui_input:set_parent";

		private static string string_clone = "ngui_input:clone";

		private static string string_destroy_object = "ngui_input:destroy_object";

		private static string string_get_value = "ngui_input:get_value";

		private static string string_set_value = "ngui_input:set_value";

		private static string string_get_default_text = "ngui_input:get_default_text";

		private static string string_set_default_text = "ngui_input:set_default_text";

		private static string string_set_on_change = "ngui_input:set_on_change";

		private static string string_set_on_submit = "ngui_input:set_on_submit";

		private static string string_set_on_ngui_click = "ngui_input:set_on_ngui_click";

		private static string string_set_characterlimit = "ngui_input:set_characterlimit";

		public static bool init(IntPtr L)
		{
			if (L != IntPtr.Zero)
			{
				LuaDLL.register_class(L, name, func, gc);
				return true;
			}
			return false;
		}

		public static void push(IntPtr L, NGUIInputWrap obj)
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
				NGUIInputWrap nGUIInputWrap = null;
				nGUIInputWrap = WraperUtil.LuaToUserdata(L, 1, string_get_pid, NGUIInputWrap.cache);
				LuaDLL.lua_pushnumber(L, nGUIInputWrap.GetPid());
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
				NGUIInputWrap nGUIInputWrap = null;
				bool flag = false;
				nGUIInputWrap = WraperUtil.LuaToUserdata(L, 1, string_set_active, NGUIInputWrap.cache);
				flag = LuaDLL.lua_toboolean(L, 2);
				nGUIInputWrap.bcomponent.gameObject.SetActive(flag);
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
				NGUIInputWrap nGUIInputWrap = null;
				string text = null;
				nGUIInputWrap = WraperUtil.LuaToUserdata(L, 1, string_set_name, NGUIInputWrap.cache);
				text = LuaDLL.lua_tostring(L, 2);
				nGUIInputWrap.bcomponent.gameObject.name = text;
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
				NGUIInputWrap nGUIInputWrap = null;
				nGUIInputWrap = WraperUtil.LuaToUserdata(L, 1, string_get_name, NGUIInputWrap.cache);
				LuaDLL.lua_pushstring(L, nGUIInputWrap.bcomponent.gameObject.name);
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
				NGUIInputWrap nGUIInputWrap = null;
				float num = 0f;
				float num2 = 0f;
				float num3 = 0f;
				nGUIInputWrap = WraperUtil.LuaToUserdata(L, 1, string_set_position, NGUIInputWrap.cache);
				num = (float)LuaDLL.lua_tonumber(L, 2);
				num2 = (float)LuaDLL.lua_tonumber(L, 3);
				num3 = (float)LuaDLL.lua_tonumber(L, 4);
				nGUIInputWrap.bcomponent.gameObject.transform.localPosition = new Vector3(num, num2, num3);
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
				NGUIInputWrap nGUIInputWrap = null;
				nGUIInputWrap = WraperUtil.LuaToUserdata(L, 1, string_get_position, NGUIInputWrap.cache);
				Vector3 localPosition = nGUIInputWrap.bcomponent.gameObject.transform.localPosition;
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
				NGUIInputWrap nGUIInputWrap = null;
				nGUIInputWrap = WraperUtil.LuaToUserdata(L, 1, string_get_size, NGUIInputWrap.cache);
				int num = ((!(nGUIInputWrap.widget == null)) ? nGUIInputWrap.widget.width : 0);
				int num2 = ((!(nGUIInputWrap.widget == null)) ? nGUIInputWrap.widget.height : 0);
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
				NGUIInputWrap nGUIInputWrap = null;
				nGUIInputWrap = WraperUtil.LuaToUserdata(L, 1, string_get_game_object, NGUIInputWrap.cache);
				AssetGameObject base_object = AssetGameObject.CreateByInstance(nGUIInputWrap.bcomponent.gameObject);
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
				NGUIInputWrap nGUIInputWrap = null;
				nGUIInputWrap = WraperUtil.LuaToUserdata(L, 1, string_get_parent, NGUIInputWrap.cache);
				AssetGameObject assetGameObject = null;
				Transform parent = nGUIInputWrap.bcomponent.gameObject.transform.parent;
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
				NGUIInputWrap nGUIInputWrap = null;
				AssetGameObject assetGameObject = null;
				nGUIInputWrap = WraperUtil.LuaToUserdata(L, 1, string_set_parent, NGUIInputWrap.cache);
				assetGameObject = WraperUtil.LuaToUserdataOrNil(L, 2, string_set_parent, AssetGameObject.cache);
				nGUIInputWrap.bcomponent.gameObject.transform.parent = ((assetGameObject != null) ? assetGameObject.transform : null);
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
				NGUIInputWrap nGUIInputWrap = null;
				nGUIInputWrap = WraperUtil.LuaToUserdata(L, 1, string_clone, NGUIInputWrap.cache);
				nGUIInputWrap.Clone(L);
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
				NGUIInputWrap nGUIInputWrap = null;
				nGUIInputWrap = WraperUtil.LuaToUserdata(L, 1, string_destroy_object, NGUIInputWrap.cache);
				nGUIInputWrap.isNeedDestroy = true;
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
				NGUIInputWrap nGUIInputWrap = null;
				nGUIInputWrap = WraperUtil.LuaToUserdata(L, 1, string_get_value, NGUIInputWrap.cache);
				LuaDLL.lua_pushstring(L, nGUIInputWrap.component.value);
				result = 1;
			}
			return result;
		}

		[MonoPInvokeCallback(typeof(LuaCSFunction))]
		private static int set_value(IntPtr L)
		{
			int result = 0;
			if (WraperUtil.ValidIsUserdata(L, 1, string_set_value) && WraperUtil.ValidIsString(L, 2, string_set_value))
			{
				NGUIInputWrap nGUIInputWrap = null;
				string text = null;
				nGUIInputWrap = WraperUtil.LuaToUserdata(L, 1, string_set_value, NGUIInputWrap.cache);
				text = LuaDLL.lua_tostring(L, 2);
				nGUIInputWrap.component.value = text;
				result = 0;
			}
			return result;
		}

		[MonoPInvokeCallback(typeof(LuaCSFunction))]
		private static int get_default_text(IntPtr L)
		{
			int result = 0;
			if (WraperUtil.ValidIsUserdata(L, 1, string_get_default_text))
			{
				NGUIInputWrap nGUIInputWrap = null;
				nGUIInputWrap = WraperUtil.LuaToUserdata(L, 1, string_get_default_text, NGUIInputWrap.cache);
				LuaDLL.lua_pushstring(L, nGUIInputWrap.component.defaultText);
				result = 1;
			}
			return result;
		}

		[MonoPInvokeCallback(typeof(LuaCSFunction))]
		private static int set_default_text(IntPtr L)
		{
			int result = 0;
			if (WraperUtil.ValidIsUserdata(L, 1, string_set_default_text) && WraperUtil.ValidIsString(L, 2, string_set_default_text))
			{
				NGUIInputWrap nGUIInputWrap = null;
				string text = null;
				nGUIInputWrap = WraperUtil.LuaToUserdata(L, 1, string_set_default_text, NGUIInputWrap.cache);
				text = LuaDLL.lua_tostring(L, 2);
				nGUIInputWrap.component.defaultText = text;
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
				NGUIInputWrap nGUIInputWrap = null;
				string text = null;
				nGUIInputWrap = WraperUtil.LuaToUserdata(L, 1, string_set_on_change, NGUIInputWrap.cache);
				text = LuaDLL.lua_tostring(L, 2);
				nGUIInputWrap.onChange = text;
				result = 0;
			}
			return result;
		}

		[MonoPInvokeCallback(typeof(LuaCSFunction))]
		private static int set_on_submit(IntPtr L)
		{
			int result = 0;
			if (WraperUtil.ValidIsUserdata(L, 1, string_set_on_submit) && WraperUtil.ValidIsString(L, 2, string_set_on_submit))
			{
				NGUIInputWrap nGUIInputWrap = null;
				string text = null;
				nGUIInputWrap = WraperUtil.LuaToUserdata(L, 1, string_set_on_submit, NGUIInputWrap.cache);
				text = LuaDLL.lua_tostring(L, 2);
				nGUIInputWrap.onSubmit = text;
				result = 0;
			}
			return result;
		}

		[MonoPInvokeCallback(typeof(LuaCSFunction))]
		private static int set_on_ngui_click(IntPtr L)
		{
			int result = 0;
			if (WraperUtil.ValidIsUserdata(L, 1, string_set_on_ngui_click) && WraperUtil.ValidIsString(L, 2, string_set_on_ngui_click))
			{
				NGUIInputWrap nGUIInputWrap = null;
				string text = null;
				nGUIInputWrap = WraperUtil.LuaToUserdata(L, 1, string_set_on_ngui_click, NGUIInputWrap.cache);
				text = LuaDLL.lua_tostring(L, 2);
				NGUIEventListener nGUIEventListener = nGUIInputWrap.component.gameObject.GetComponent<NGUIEventListener>();
				if (nGUIEventListener == null)
				{
					nGUIEventListener = nGUIInputWrap.component.gameObject.AddComponent<NGUIEventListener>();
				}
				nGUIEventListener.onClickScript = text;
				nGUIEventListener.SetOnClick();
				result = 0;
			}
			return result;
		}

		[MonoPInvokeCallback(typeof(LuaCSFunction))]
		private static int set_characterlimit(IntPtr L)
		{
			int result = 0;
			if (WraperUtil.ValidIsUserdata(L, 1, string_set_characterlimit) && WraperUtil.ValidIsString(L, 2, string_set_characterlimit))
			{
				NGUIInputWrap nGUIInputWrap = null;
				int num = 0;
				nGUIInputWrap = WraperUtil.LuaToUserdata(L, 1, string_set_default_text, NGUIInputWrap.cache);
				num = (int)LuaDLL.lua_tonumber(L, 2);
				nGUIInputWrap.component.characterLimit = num;
				result = 0;
			}
			return result;
		}

		[MonoPInvokeCallback(typeof(LuaCSFunction))]
		private static int gc(IntPtr L)
		{
			NGUIInputWrap nGUIInputWrap = WraperUtil.LuaToUserdataByGc(L, 1, "gc ngui_input", NGUIInputWrap.cache);
			if (nGUIInputWrap != null)
			{
				nGUIInputWrap.DestroyInstance();
			}
			return 0;
		}
	}
}
