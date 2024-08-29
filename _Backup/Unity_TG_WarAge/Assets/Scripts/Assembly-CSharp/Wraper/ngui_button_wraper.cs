using System;
using ComponentEx;
using LuaInterface;
using UnityEngine;
using UnityWrap;

namespace Wraper
{
	public class ngui_button_wraper
	{
		public static string name = "ngui_button";

		public static string libname = "ngui_button";

		private static luaL_Reg[] libfunc = new luaL_Reg[2]
		{
			new luaL_Reg("set_global_event_level", set_global_event_level),
			new luaL_Reg("reset_global_event_level", reset_global_event_level)
		};

		private static luaL_Reg[] func = new luaL_Reg[33]
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
			new luaL_Reg("set_event_level", set_event_level),
			new luaL_Reg("reset_event_level", reset_event_level),
			new luaL_Reg("set_enable", set_enable),
			new luaL_Reg("set_event_value", set_event_value),
			new luaL_Reg("get_event_value", get_event_value),
			new luaL_Reg("set_on_click", set_on_click),
			new luaL_Reg("reset_on_click", reset_on_click),
			new luaL_Reg("set_on_ngui_click", set_on_ngui_click),
			new luaL_Reg("set_on_ngui_press", set_on_ngui_press),
			new luaL_Reg("set_on_ngui_drag_start", set_on_ngui_drag_start),
			new luaL_Reg("set_on_ngui_drag_move", set_on_ngui_drag_move),
			new luaL_Reg("set_on_ngui_drag_end", set_on_ngui_drag_end),
			new luaL_Reg("stop_event_propagation", stop_event_propagation),
			new luaL_Reg("reset_event_propagation", reset_event_propagation),
			new luaL_Reg("set_on_dragdrop_start", set_on_dragdrop_start),
			new luaL_Reg("set_on_dragdrop_release", set_on_dragdrop_release),
			new luaL_Reg("set_is_dragdrop_clone", set_is_dragdrop_clone),
			new luaL_Reg("set_is_hide_clone", set_is_hide_clone),
			new luaL_Reg("set_dragdrop_restriction", set_dragdrop_restriction),
			new luaL_Reg("set_sprite_names", set_sprite_names),
			new luaL_Reg("set_enable_tween_color", set_enable_tween_color)
		};

		private static string string_set_global_event_level = "ngui_button.set_global_event_level";

		private static string string_get_pid = "ngui_button:get_pid";

		private static string string_set_active = "ngui_button:set_active";

		private static string string_set_name = "ngui_button:set_name";

		private static string string_get_name = "ngui_button:get_name";

		private static string string_set_position = "ngui_button:set_position";

		private static string string_get_position = "ngui_button:get_position";

		private static string string_get_size = "ngui_button:get_size";

		private static string string_get_game_object = "ngui_button:get_game_object";

		private static string string_get_parent = "ngui_button:get_parent";

		private static string string_set_parent = "ngui_button:set_parent";

		private static string string_clone = "ngui_button:clone";

		private static string string_destroy_object = "ngui_button:destroy_object";

		private static string string_set_event_level = "ngui_button:set_event_level";

		private static string string_reset_event_level = "ngui_button:reset_event_level";

		private static string string_set_enable = "ngui_button:set_enable";

		private static string string_set_event_value = "ngui_button:set_event_value";

		private static string string_get_event_value = "ngui_button:get_event_value";

		private static string string_set_on_click = "ngui_button:set_on_click";

		private static string string_reset_on_click = "ngui_button:reset_on_click";

		private static string string_set_on_ngui_click = "ngui_button:set_on_ngui_click";

		private static string string_set_on_ngui_press = "ngui_button:set_on_ngui_press";

		private static string string_set_on_ngui_drag_start = "ngui_button:set_on_ngui_drag_start";

		private static string string_set_on_ngui_drag_move = "ngui_button:set_on_ngui_drag_move";

		private static string string_set_on_ngui_drag_end = "ngui_button:set_on_ngui_drag_end";

		private static string string_stop_event_propagation = "ngui_button:stop_event_propagation";

		private static string string_reset_event_propagation = "ngui_button:reset_event_propagation";

		private static string string_set_on_dragdrop_start = "ngui_button:set_on_dragdrop_start";

		private static string string_set_on_dragdrop_release = "ngui_button:set_on_dragdrop_release";

		private static string string_set_is_dragdrop_clone = "ngui_button:set_is_dragdrop_clone";

		private static string string_set_is_hide_clone = "ngui_button:set_is_hide_clone";

		private static string string_set_dragdrop_restriction = "ngui_button:set_dragdrop_restriction";

		private static string string_set_sprite_names = "ngui_button:set_sprite_name";

		private static string string_set_enable_tween_color = "ngui_button:set_enable_tween_color";

		public static bool init(IntPtr L)
		{
			if (L != IntPtr.Zero)
			{
				LuaDLL.register_class(L, name, func, gc);
				LuaDLL.register_lib(L, libname, libfunc, 0);
				return true;
			}
			return false;
		}

		public static void push(IntPtr L, NGUIButtonWrap obj)
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
		private static int set_global_event_level(IntPtr L)
		{
			int result = 0;
			if (WraperUtil.ValidIsNumber(L, 1, string_set_global_event_level))
			{
				int num = 0;
				num = (int)LuaDLL.lua_tonumber(L, 1);
				NGUIButtonWrap.globalEventLevel = num;
				result = 0;
			}
			return result;
		}

		[MonoPInvokeCallback(typeof(LuaCSFunction))]
		private static int reset_global_event_level(IntPtr L)
		{
			int num = 0;
			NGUIButtonWrap.globalEventLevel = 1;
			return 0;
		}

		[MonoPInvokeCallback(typeof(LuaCSFunction))]
		private static int get_pid(IntPtr L)
		{
			int result = 0;
			if (WraperUtil.ValidIsUserdata(L, 1, string_get_pid))
			{
				NGUIButtonWrap nGUIButtonWrap = null;
				nGUIButtonWrap = WraperUtil.LuaToUserdata(L, 1, string_get_pid, NGUIButtonWrap.cache);
				LuaDLL.lua_pushnumber(L, nGUIButtonWrap.GetPid());
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
				NGUIButtonWrap nGUIButtonWrap = null;
				bool flag = false;
				nGUIButtonWrap = WraperUtil.LuaToUserdata(L, 1, string_set_active, NGUIButtonWrap.cache);
				flag = LuaDLL.lua_toboolean(L, 2);
				nGUIButtonWrap.bcomponent.gameObject.SetActive(flag);
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
				NGUIButtonWrap nGUIButtonWrap = null;
				string text = null;
				nGUIButtonWrap = WraperUtil.LuaToUserdata(L, 1, string_set_name, NGUIButtonWrap.cache);
				text = LuaDLL.lua_tostring(L, 2);
				nGUIButtonWrap.bcomponent.gameObject.name = text;
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
				NGUIButtonWrap nGUIButtonWrap = null;
				nGUIButtonWrap = WraperUtil.LuaToUserdata(L, 1, string_get_name, NGUIButtonWrap.cache);
				LuaDLL.lua_pushstring(L, nGUIButtonWrap.bcomponent.gameObject.name);
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
				NGUIButtonWrap nGUIButtonWrap = null;
				float num = 0f;
				float num2 = 0f;
				float num3 = 0f;
				nGUIButtonWrap = WraperUtil.LuaToUserdata(L, 1, string_set_position, NGUIButtonWrap.cache);
				num = (float)LuaDLL.lua_tonumber(L, 2);
				num2 = (float)LuaDLL.lua_tonumber(L, 3);
				num3 = (float)LuaDLL.lua_tonumber(L, 4);
				nGUIButtonWrap.bcomponent.gameObject.transform.localPosition = new Vector3(num, num2, num3);
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
				NGUIButtonWrap nGUIButtonWrap = null;
				nGUIButtonWrap = WraperUtil.LuaToUserdata(L, 1, string_get_position, NGUIButtonWrap.cache);
				Vector3 localPosition = nGUIButtonWrap.bcomponent.gameObject.transform.localPosition;
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
				NGUIButtonWrap nGUIButtonWrap = null;
				nGUIButtonWrap = WraperUtil.LuaToUserdata(L, 1, string_get_size, NGUIButtonWrap.cache);
				int num = ((!(nGUIButtonWrap.widget == null)) ? nGUIButtonWrap.widget.width : 0);
				int num2 = ((!(nGUIButtonWrap.widget == null)) ? nGUIButtonWrap.widget.height : 0);
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
				NGUIButtonWrap nGUIButtonWrap = null;
				nGUIButtonWrap = WraperUtil.LuaToUserdata(L, 1, string_get_game_object, NGUIButtonWrap.cache);
				AssetGameObject base_object = AssetGameObject.CreateByInstance(nGUIButtonWrap.bcomponent.gameObject);
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
				NGUIButtonWrap nGUIButtonWrap = null;
				nGUIButtonWrap = WraperUtil.LuaToUserdata(L, 1, string_get_parent, NGUIButtonWrap.cache);
				AssetGameObject assetGameObject = null;
				Transform parent = nGUIButtonWrap.bcomponent.gameObject.transform.parent;
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
				NGUIButtonWrap nGUIButtonWrap = null;
				AssetGameObject assetGameObject = null;
				nGUIButtonWrap = WraperUtil.LuaToUserdata(L, 1, string_set_parent, NGUIButtonWrap.cache);
				assetGameObject = WraperUtil.LuaToUserdataOrNil(L, 2, string_set_parent, AssetGameObject.cache);
				nGUIButtonWrap.bcomponent.gameObject.transform.parent = ((assetGameObject != null) ? assetGameObject.transform : null);
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
				NGUIButtonWrap nGUIButtonWrap = null;
				nGUIButtonWrap = WraperUtil.LuaToUserdata(L, 1, string_clone, NGUIButtonWrap.cache);
				nGUIButtonWrap.Clone(L);
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
				NGUIButtonWrap nGUIButtonWrap = null;
				nGUIButtonWrap = WraperUtil.LuaToUserdata(L, 1, string_destroy_object, NGUIButtonWrap.cache);
				nGUIButtonWrap.isNeedDestroy = true;
				result = 0;
			}
			return result;
		}

		[MonoPInvokeCallback(typeof(LuaCSFunction))]
		private static int set_event_level(IntPtr L)
		{
			int result = 0;
			if (WraperUtil.ValidIsUserdata(L, 1, string_set_event_level) && WraperUtil.ValidIsNumber(L, 2, string_set_event_level))
			{
				NGUIButtonWrap nGUIButtonWrap = null;
				int num = 0;
				nGUIButtonWrap = WraperUtil.LuaToUserdata(L, 1, string_set_event_level, NGUIButtonWrap.cache);
				num = (int)LuaDLL.lua_tonumber(L, 2);
				nGUIButtonWrap.eventLevel = num;
				result = 0;
			}
			return result;
		}

		[MonoPInvokeCallback(typeof(LuaCSFunction))]
		private static int reset_event_level(IntPtr L)
		{
			int result = 0;
			if (WraperUtil.ValidIsUserdata(L, 1, string_reset_event_level))
			{
				NGUIButtonWrap nGUIButtonWrap = null;
				nGUIButtonWrap = WraperUtil.LuaToUserdata(L, 1, string_reset_event_level, NGUIButtonWrap.cache);
				nGUIButtonWrap.eventLevel = 1;
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
				NGUIButtonWrap nGUIButtonWrap = null;
				bool flag = false;
				nGUIButtonWrap = WraperUtil.LuaToUserdata(L, 1, string_set_enable, NGUIButtonWrap.cache);
				flag = LuaDLL.lua_toboolean(L, 2);
				nGUIButtonWrap.component.isEnabled = flag;
				result = 0;
			}
			return result;
		}

		[MonoPInvokeCallback(typeof(LuaCSFunction))]
		private static int set_event_value(IntPtr L)
		{
			int result = 0;
			if (WraperUtil.ValidIsUserdata(L, 1, string_set_event_value) && WraperUtil.ValidIsString(L, 2, string_set_event_value) && WraperUtil.ValidIsNumber(L, 3, string_set_event_value))
			{
				NGUIButtonWrap nGUIButtonWrap = null;
				string text = null;
				float num = 0f;
				nGUIButtonWrap = WraperUtil.LuaToUserdata(L, 1, string_set_event_value, NGUIButtonWrap.cache);
				text = LuaDLL.lua_tostring(L, 2);
				num = (float)LuaDLL.lua_tonumber(L, 3);
				nGUIButtonWrap.eventStringValue = text;
				nGUIButtonWrap.eventFloatValue = num;
				result = 0;
			}
			return result;
		}

		[MonoPInvokeCallback(typeof(LuaCSFunction))]
		private static int get_event_value(IntPtr L)
		{
			int result = 0;
			if (WraperUtil.ValidIsUserdata(L, 1, string_get_event_value))
			{
				NGUIButtonWrap nGUIButtonWrap = null;
				nGUIButtonWrap = WraperUtil.LuaToUserdata(L, 1, string_get_event_value, NGUIButtonWrap.cache);
				LuaDLL.lua_pushstring(L, nGUIButtonWrap.eventStringValue);
				LuaDLL.lua_pushnumber(L, nGUIButtonWrap.eventFloatValue);
				result = 2;
			}
			return result;
		}

		[MonoPInvokeCallback(typeof(LuaCSFunction))]
		private static int set_on_click(IntPtr L)
		{
			int result = 0;
			if (WraperUtil.ValidIsUserdata(L, 1, string_set_on_click) && WraperUtil.ValidIsString(L, 2, string_set_on_click))
			{
				NGUIButtonWrap nGUIButtonWrap = null;
				string text = null;
				nGUIButtonWrap = WraperUtil.LuaToUserdata(L, 1, string_set_on_click, NGUIButtonWrap.cache);
				text = LuaDLL.lua_tostring(L, 2);
				nGUIButtonWrap.onClick = text;
				result = 0;
			}
			return result;
		}

		[MonoPInvokeCallback(typeof(LuaCSFunction))]
		private static int reset_on_click(IntPtr L)
		{
			int result = 0;
			if (WraperUtil.ValidIsUserdata(L, 1, string_reset_on_click))
			{
				NGUIButtonWrap nGUIButtonWrap = null;
				nGUIButtonWrap = WraperUtil.LuaToUserdata(L, 1, string_reset_on_click, NGUIButtonWrap.cache);
				nGUIButtonWrap.ResetOnClick();
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
				NGUIButtonWrap nGUIButtonWrap = null;
				string text = null;
				nGUIButtonWrap = WraperUtil.LuaToUserdata(L, 1, string_set_on_ngui_click, NGUIButtonWrap.cache);
				text = LuaDLL.lua_tostring(L, 2);
				NGUIEventListener nGUIEventListener = nGUIButtonWrap.component.gameObject.GetComponent<NGUIEventListener>();
				if (nGUIEventListener == null)
				{
					nGUIEventListener = nGUIButtonWrap.component.gameObject.AddComponent<NGUIEventListener>();
				}
				nGUIEventListener.SetOnClick();
				nGUIEventListener.onClickScript = text;
				result = 0;
			}
			return result;
		}

		[MonoPInvokeCallback(typeof(LuaCSFunction))]
		private static int set_on_ngui_press(IntPtr L)
		{
			int result = 0;
			if (WraperUtil.ValidIsUserdata(L, 1, string_set_on_ngui_press) && WraperUtil.ValidIsString(L, 2, string_set_on_ngui_press))
			{
				NGUIButtonWrap nGUIButtonWrap = null;
				string text = null;
				nGUIButtonWrap = WraperUtil.LuaToUserdata(L, 1, string_set_on_ngui_press, NGUIButtonWrap.cache);
				text = LuaDLL.lua_tostring(L, 2);
				NGUIEventListener nGUIEventListener = nGUIButtonWrap.component.gameObject.GetComponent<NGUIEventListener>();
				if (nGUIEventListener == null)
				{
					nGUIEventListener = nGUIButtonWrap.component.gameObject.AddComponent<NGUIEventListener>();
				}
				nGUIEventListener.SetOnPress();
				nGUIEventListener.onPressScript = text;
				result = 0;
			}
			return result;
		}

		[MonoPInvokeCallback(typeof(LuaCSFunction))]
		private static int set_on_ngui_drag_start(IntPtr L)
		{
			int result = 0;
			if (WraperUtil.ValidIsUserdata(L, 1, string_set_on_ngui_drag_start) && WraperUtil.ValidIsString(L, 2, string_set_on_ngui_drag_start))
			{
				NGUIButtonWrap nGUIButtonWrap = null;
				string text = null;
				nGUIButtonWrap = WraperUtil.LuaToUserdata(L, 1, string_set_on_ngui_drag_start, NGUIButtonWrap.cache);
				text = LuaDLL.lua_tostring(L, 2);
				NGUIEventListener nGUIEventListener = nGUIButtonWrap.component.gameObject.GetComponent<NGUIEventListener>();
				if (nGUIEventListener == null)
				{
					nGUIEventListener = nGUIButtonWrap.component.gameObject.AddComponent<NGUIEventListener>();
				}
				nGUIEventListener.SetOnDragStart();
				nGUIEventListener.onDragStartScript = text;
				result = 0;
			}
			return result;
		}

		[MonoPInvokeCallback(typeof(LuaCSFunction))]
		private static int set_on_ngui_drag_move(IntPtr L)
		{
			int result = 0;
			if (WraperUtil.ValidIsUserdata(L, 1, string_set_on_ngui_drag_move) && WraperUtil.ValidIsString(L, 2, string_set_on_ngui_drag_move))
			{
				NGUIButtonWrap nGUIButtonWrap = null;
				string text = null;
				nGUIButtonWrap = WraperUtil.LuaToUserdata(L, 1, string_set_on_ngui_drag_move, NGUIButtonWrap.cache);
				text = LuaDLL.lua_tostring(L, 2);
				NGUIEventListener nGUIEventListener = nGUIButtonWrap.component.gameObject.GetComponent<NGUIEventListener>();
				if (nGUIEventListener == null)
				{
					nGUIEventListener = nGUIButtonWrap.component.gameObject.AddComponent<NGUIEventListener>();
				}
				nGUIEventListener.SetOnDrag();
				nGUIEventListener.onDragScript = text;
				result = 0;
			}
			return result;
		}

		[MonoPInvokeCallback(typeof(LuaCSFunction))]
		private static int set_on_ngui_drag_end(IntPtr L)
		{
			int result = 0;
			if (WraperUtil.ValidIsUserdata(L, 1, string_set_on_ngui_drag_end) && WraperUtil.ValidIsString(L, 2, string_set_on_ngui_drag_end))
			{
				NGUIButtonWrap nGUIButtonWrap = null;
				string text = null;
				nGUIButtonWrap = WraperUtil.LuaToUserdata(L, 1, string_set_on_ngui_drag_end, NGUIButtonWrap.cache);
				text = LuaDLL.lua_tostring(L, 2);
				NGUIEventListener nGUIEventListener = nGUIButtonWrap.component.gameObject.GetComponent<NGUIEventListener>();
				if (nGUIEventListener == null)
				{
					nGUIEventListener = nGUIButtonWrap.component.gameObject.AddComponent<NGUIEventListener>();
				}
				nGUIEventListener.SetOnDragEnd();
				nGUIEventListener.onDragEndScript = text;
				result = 0;
			}
			return result;
		}

		[MonoPInvokeCallback(typeof(LuaCSFunction))]
		private static int stop_event_propagation(IntPtr L)
		{
			int result = 0;
			if (WraperUtil.ValidIsUserdata(L, 1, string_stop_event_propagation))
			{
				NGUIButtonWrap nGUIButtonWrap = null;
				nGUIButtonWrap = WraperUtil.LuaToUserdata(L, 1, string_stop_event_propagation, NGUIButtonWrap.cache);
				NGUIEventListener nGUIEventListener = nGUIButtonWrap.component.gameObject.GetComponent<NGUIEventListener>();
				if (nGUIEventListener == null)
				{
					nGUIEventListener = nGUIButtonWrap.component.gameObject.AddComponent<NGUIEventListener>();
				}
				nGUIEventListener.StopPropagation();
				result = 0;
			}
			return result;
		}

		[MonoPInvokeCallback(typeof(LuaCSFunction))]
		private static int reset_event_propagation(IntPtr L)
		{
			int result = 0;
			if (WraperUtil.ValidIsUserdata(L, 1, string_reset_event_propagation))
			{
				NGUIButtonWrap nGUIButtonWrap = null;
				nGUIButtonWrap = WraperUtil.LuaToUserdata(L, 1, string_reset_event_propagation, NGUIButtonWrap.cache);
				NGUIEventListener nGUIEventListener = nGUIButtonWrap.component.gameObject.GetComponent<NGUIEventListener>();
				if (nGUIEventListener == null)
				{
					nGUIEventListener = nGUIButtonWrap.component.gameObject.AddComponent<NGUIEventListener>();
				}
				nGUIEventListener.ResetPropagation();
				result = 0;
			}
			return result;
		}

		[MonoPInvokeCallback(typeof(LuaCSFunction))]
		private static int set_on_dragdrop_start(IntPtr L)
		{
			int result = 0;
			if (WraperUtil.ValidIsUserdata(L, 1, string_set_on_dragdrop_start) && WraperUtil.ValidIsString(L, 2, string_set_on_dragdrop_start))
			{
				NGUIButtonWrap nGUIButtonWrap = null;
				string text = null;
				nGUIButtonWrap = WraperUtil.LuaToUserdata(L, 1, string_set_on_dragdrop_start, NGUIButtonWrap.cache);
				text = LuaDLL.lua_tostring(L, 2);
				ExUIDragDropItem exUIDragDropItem = nGUIButtonWrap.component.gameObject.GetComponent<ExUIDragDropItem>();
				if (exUIDragDropItem == null)
				{
					exUIDragDropItem = nGUIButtonWrap.component.gameObject.AddComponent<ExUIDragDropItem>();
				}
				exUIDragDropItem.onDragDropStartScript = text;
				result = 0;
			}
			return result;
		}

		[MonoPInvokeCallback(typeof(LuaCSFunction))]
		private static int set_on_dragdrop_release(IntPtr L)
		{
			int result = 0;
			if (WraperUtil.ValidIsUserdata(L, 1, string_set_on_dragdrop_release) && WraperUtil.ValidIsString(L, 2, string_set_on_dragdrop_release))
			{
				NGUIButtonWrap nGUIButtonWrap = null;
				string text = null;
				nGUIButtonWrap = WraperUtil.LuaToUserdata(L, 1, string_set_on_dragdrop_release, NGUIButtonWrap.cache);
				text = LuaDLL.lua_tostring(L, 2);
				ExUIDragDropItem exUIDragDropItem = nGUIButtonWrap.component.gameObject.GetComponent<ExUIDragDropItem>();
				if (exUIDragDropItem == null)
				{
					exUIDragDropItem = nGUIButtonWrap.component.gameObject.AddComponent<ExUIDragDropItem>();
				}
				exUIDragDropItem.onDragDropReleaseScript = text;
				result = 0;
			}
			return result;
		}

		[MonoPInvokeCallback(typeof(LuaCSFunction))]
		private static int set_is_dragdrop_clone(IntPtr L)
		{
			int result = 0;
			if (WraperUtil.ValidIsUserdata(L, 1, string_set_is_dragdrop_clone) && WraperUtil.ValidIsBoolean(L, 2, string_set_is_dragdrop_clone))
			{
				NGUIButtonWrap nGUIButtonWrap = null;
				bool flag = false;
				nGUIButtonWrap = WraperUtil.LuaToUserdata(L, 1, string_set_is_dragdrop_clone, NGUIButtonWrap.cache);
				flag = LuaDLL.lua_toboolean(L, 2);
				ExUIDragDropItem exUIDragDropItem = nGUIButtonWrap.component.gameObject.GetComponent<ExUIDragDropItem>();
				if (exUIDragDropItem == null)
				{
					exUIDragDropItem = nGUIButtonWrap.component.gameObject.AddComponent<ExUIDragDropItem>();
				}
				exUIDragDropItem.cloneOnDrag = flag;
				result = 0;
			}
			return result;
		}

		[MonoPInvokeCallback(typeof(LuaCSFunction))]
		private static int set_is_hide_clone(IntPtr L)
		{
			int result = 0;
			if (WraperUtil.ValidIsUserdata(L, 1, string_set_is_hide_clone) && WraperUtil.ValidIsBoolean(L, 2, string_set_is_hide_clone))
			{
				NGUIButtonWrap nGUIButtonWrap = null;
				bool flag = false;
				nGUIButtonWrap = WraperUtil.LuaToUserdata(L, 1, string_set_is_hide_clone, NGUIButtonWrap.cache);
				flag = LuaDLL.lua_toboolean(L, 2);
				ExUIDragDropItem exUIDragDropItem = nGUIButtonWrap.component.gameObject.GetComponent<ExUIDragDropItem>();
				if (exUIDragDropItem == null)
				{
					exUIDragDropItem = nGUIButtonWrap.component.gameObject.AddComponent<ExUIDragDropItem>();
				}
				exUIDragDropItem.hideCloneObj = flag;
				result = 0;
			}
			return result;
		}

		[MonoPInvokeCallback(typeof(LuaCSFunction))]
		private static int set_dragdrop_restriction(IntPtr L)
		{
			int result = 0;
			if (WraperUtil.ValidIsUserdata(L, 1, string_set_dragdrop_restriction) && WraperUtil.ValidIsNumber(L, 2, string_set_dragdrop_restriction))
			{
				NGUIButtonWrap nGUIButtonWrap = null;
				int num = 0;
				nGUIButtonWrap = WraperUtil.LuaToUserdata(L, 1, string_set_dragdrop_restriction, NGUIButtonWrap.cache);
				num = (int)LuaDLL.lua_tonumber(L, 2);
				ExUIDragDropItem component = nGUIButtonWrap.component.gameObject.GetComponent<ExUIDragDropItem>();
				if (!(component == null))
				{
					switch (num)
					{
					case 1:
						component.restriction = UIDragDropItem.Restriction.None;
						break;
					case 2:
						component.restriction = UIDragDropItem.Restriction.Horizontal;
						break;
					case 3:
						component.restriction = UIDragDropItem.Restriction.Vertical;
						break;
					case 4:
						component.restriction = UIDragDropItem.Restriction.PressAndHold;
						break;
					}
					result = 0;
				}
			}
			return result;
		}

		[MonoPInvokeCallback(typeof(LuaCSFunction))]
		private static int set_sprite_names(IntPtr L)
		{
			int result = 0;
			if (WraperUtil.ValidIsUserdata(L, 1, string_set_sprite_names) && WraperUtil.ValidIsString(L, 2, string_set_sprite_names) && WraperUtil.ValidIsString(L, 3, string_set_sprite_names) && WraperUtil.ValidIsString(L, 4, string_set_sprite_names) && WraperUtil.ValidIsString(L, 5, string_set_sprite_names))
			{
				NGUIButtonWrap nGUIButtonWrap = WraperUtil.LuaToUserdata(L, 1, string_reset_on_click, NGUIButtonWrap.cache);
				if (nGUIButtonWrap != null)
				{
					string text = LuaDLL.lua_tostring(L, 2);
					string text2 = LuaDLL.lua_tostring(L, 3);
					string text3 = LuaDLL.lua_tostring(L, 4);
					string text4 = LuaDLL.lua_tostring(L, 5);
					if (!string.IsNullOrEmpty(text))
					{
						nGUIButtonWrap.component.normalSprite = text;
					}
					if (!string.IsNullOrEmpty(text2))
					{
						nGUIButtonWrap.component.hoverSprite = text2;
					}
					if (!string.IsNullOrEmpty(text3))
					{
						nGUIButtonWrap.component.pressedSprite = text3;
					}
					if (!string.IsNullOrEmpty(text4))
					{
						nGUIButtonWrap.component.disabledSprite = text4;
					}
				}
				result = 0;
			}
			return result;
		}

		[MonoPInvokeCallback(typeof(LuaCSFunction))]
		private static int set_enable_tween_color(IntPtr L)
		{
			int result = 0;
			if (WraperUtil.ValidIsUserdata(L, 1, string_set_enable_tween_color) && WraperUtil.ValidIsBoolean(L, 2, string_set_enable_tween_color))
			{
				NGUIButtonWrap nGUIButtonWrap = WraperUtil.LuaToUserdata(L, 1, string_set_enable_tween_color, NGUIButtonWrap.cache);
				if (nGUIButtonWrap != null)
				{
					bool enableTweenColor = LuaDLL.lua_toboolean(L, 2);
					nGUIButtonWrap.component.enableTweenColor = enableTweenColor;
				}
				result = 0;
			}
			return result;
		}

		[MonoPInvokeCallback(typeof(LuaCSFunction))]
		private static int gc(IntPtr L)
		{
			NGUIButtonWrap nGUIButtonWrap = WraperUtil.LuaToUserdataByGc(L, 1, "gc ngui_button", NGUIButtonWrap.cache);
			if (nGUIButtonWrap != null)
			{
				nGUIButtonWrap.DestroyInstance();
			}
			return 0;
		}
	}
}
