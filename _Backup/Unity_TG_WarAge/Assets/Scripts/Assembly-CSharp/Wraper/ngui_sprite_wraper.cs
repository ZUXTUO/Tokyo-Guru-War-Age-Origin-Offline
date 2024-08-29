using System;
using ComponentEx;
using Core.Unity;
using LuaInterface;
using UnityEngine;
using UnityWrap;

namespace Wraper
{
	public class ngui_sprite_wraper
	{
		public static string name = "ngui_sprite";

		private static luaL_Reg[] func = new luaL_Reg[41]
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
			new luaL_Reg("set_sprite_depth", set_sprite_depth),
			new luaL_Reg("set_sprite_atlas", set_sprite_atlas),
			new luaL_Reg("set_sprite_name", set_sprite_name),
			new luaL_Reg("get_sprite_name", get_sprite_name),
			new luaL_Reg("set_width", set_width),
			new luaL_Reg("get_width", get_width),
			new luaL_Reg("set_height", set_height),
			new luaL_Reg("get_height", get_height),
			new luaL_Reg("set_color", set_color),
			new luaL_Reg("get_color", get_color),
			new luaL_Reg("set_depth", set_depth),
			new luaL_Reg("get_depth", get_depth),
			new luaL_Reg("set_fill_direction", set_fill_direction),
			new luaL_Reg("set_on_ngui_click", set_on_ngui_click),
			new luaL_Reg("set_event_value", set_event_value),
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
			new luaL_Reg("set_fill_amout", set_fill_amout),
			new luaL_Reg("set_flip", set_flip),
			new luaL_Reg("update_anchors", update_anchors)
		};

		private static string string_get_pid = "ngui_sprite:get_pid";

		private static string string_set_active = "ngui_sprite:set_active";

		private static string string_set_name = "ngui_sprite:set_name";

		private static string string_get_name = "ngui_sprite:get_name";

		private static string string_set_position = "ngui_sprite:set_position";

		private static string string_get_position = "ngui_sprite:get_position";

		private static string string_get_size = "ngui_sprite:get_size";

		private static string string_get_game_object = "ngui_sprite:get_game_object";

		private static string string_get_parent = "ngui_sprite:get_parent";

		private static string string_set_parent = "ngui_sprite:set_parent";

		private static string string_clone = "ngui_sprite:clone";

		private static string string_destroy_object = "ngui_sprite:destroy_object";

		private static string string_set_sprite_depth = "ngui_sprite:set_sprite_depth";

		private static string string_set_sprite_atlas = "ngui_sprite:set_sprite_atlas";

		private static string string_set_sprite_name = "ngui_sprite:set_sprite_name";

		private static string string_get_sprite_name = "ngui_sprite:get_sprite_name";

		private static string string_set_width = "ngui_sprite:set_width";

		private static string string_get_width = "ngui_sprite:get_width";

		private static string string_set_height = "ngui_sprite:set_height";

		private static string string_get_height = "ngui_sprite:get_height";

		private static string string_set_color = "ngui_sprite:set_color";

		private static string string_get_color = "ngui_sprite:get_color";

		private static string string_set_depth = "ngui_sprite:set_depth";

		private static string string_get_depth = "ngui_sprite:get_depth";

		private static string string_set_fill_direction = "ngui_sprite:set_fill_direction";

		private static string string_set_on_ngui_click = "ngui_sprite:set_on_ngui_click";

		private static string string_set_event_value = "ngui_sprite:set_event_value";

		private static string string_set_on_ngui_press = "ngui_sprite:set_on_ngui_press";

		private static string string_set_on_ngui_drag_start = "ngui_sprite:set_on_ngui_drag_start";

		private static string string_set_on_ngui_drag_move = "ngui_sprite:set_on_ngui_drag_move";

		private static string string_set_on_ngui_drag_end = "ngui_sprite:set_on_ngui_drag_end";

		private static string string_stop_event_propagation = "ngui_sprite:stop_event_propagation";

		private static string string_reset_event_propagation = "ngui_sprite:reset_event_propagation";

		private static string string_set_on_dragdrop_start = "ngui_sprite:set_on_dragdrop_start";

		private static string string_set_on_dragdrop_release = "ngui_sprite:set_on_dragdrop_release";

		private static string string_set_is_dragdrop_clone = "ngui_sprite:set_is_dragdrop_clone";

		private static string string_set_is_hide_clone = "ngui_sprite:set_is_hide_clone";

		private static string string_set_dragdrop_restriction = "ngui_sprite:set_dragdrop_restriction";

		private static string string_set_fill_amout = "ngui_sprite:set_fill_amout";

		private static string string_set_flip = "ngui_sprite:set_flip";

		private static string string_update_anchors = "ngui_sprite:update_anchors";

		public static bool init(IntPtr L)
		{
			if (L != IntPtr.Zero)
			{
				LuaDLL.register_class(L, name, func, gc);
				return true;
			}
			return false;
		}

		public static void push(IntPtr L, NGUISpriteWrap obj)
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
				NGUISpriteWrap nGUISpriteWrap = null;
				nGUISpriteWrap = WraperUtil.LuaToUserdata(L, 1, string_get_pid, NGUISpriteWrap.cache);
				LuaDLL.lua_pushnumber(L, nGUISpriteWrap.GetPid());
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
				NGUISpriteWrap nGUISpriteWrap = null;
				bool flag = false;
				nGUISpriteWrap = WraperUtil.LuaToUserdata(L, 1, string_set_active, NGUISpriteWrap.cache);
				flag = LuaDLL.lua_toboolean(L, 2);
				nGUISpriteWrap.bcomponent.gameObject.SetActive(flag);
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
				NGUISpriteWrap nGUISpriteWrap = null;
				string text = null;
				nGUISpriteWrap = WraperUtil.LuaToUserdata(L, 1, string_set_name, NGUISpriteWrap.cache);
				text = LuaDLL.lua_tostring(L, 2);
				nGUISpriteWrap.bcomponent.gameObject.name = text;
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
				NGUISpriteWrap nGUISpriteWrap = null;
				nGUISpriteWrap = WraperUtil.LuaToUserdata(L, 1, string_get_name, NGUISpriteWrap.cache);
				LuaDLL.lua_pushstring(L, nGUISpriteWrap.bcomponent.gameObject.name);
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
				NGUISpriteWrap nGUISpriteWrap = null;
				float num = 0f;
				float num2 = 0f;
				float num3 = 0f;
				nGUISpriteWrap = WraperUtil.LuaToUserdata(L, 1, string_set_position, NGUISpriteWrap.cache);
				num = (float)LuaDLL.lua_tonumber(L, 2);
				num2 = (float)LuaDLL.lua_tonumber(L, 3);
				num3 = (float)LuaDLL.lua_tonumber(L, 4);
				nGUISpriteWrap.bcomponent.gameObject.transform.localPosition = new Vector3(num, num2, num3);
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
				NGUISpriteWrap nGUISpriteWrap = null;
				nGUISpriteWrap = WraperUtil.LuaToUserdata(L, 1, string_get_position, NGUISpriteWrap.cache);
				Vector3 localPosition = nGUISpriteWrap.bcomponent.gameObject.transform.localPosition;
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
				NGUISpriteWrap nGUISpriteWrap = null;
				nGUISpriteWrap = WraperUtil.LuaToUserdata(L, 1, string_get_size, NGUISpriteWrap.cache);
				int num = ((!(nGUISpriteWrap.widget == null)) ? nGUISpriteWrap.widget.width : 0);
				int num2 = ((!(nGUISpriteWrap.widget == null)) ? nGUISpriteWrap.widget.height : 0);
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
				NGUISpriteWrap nGUISpriteWrap = null;
				nGUISpriteWrap = WraperUtil.LuaToUserdata(L, 1, string_get_game_object, NGUISpriteWrap.cache);
				AssetGameObject base_object = AssetGameObject.CreateByInstance(nGUISpriteWrap.bcomponent.gameObject);
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
				NGUISpriteWrap nGUISpriteWrap = null;
				nGUISpriteWrap = WraperUtil.LuaToUserdata(L, 1, string_get_parent, NGUISpriteWrap.cache);
				AssetGameObject assetGameObject = null;
				Transform parent = nGUISpriteWrap.bcomponent.gameObject.transform.parent;
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
				NGUISpriteWrap nGUISpriteWrap = null;
				AssetGameObject assetGameObject = null;
				nGUISpriteWrap = WraperUtil.LuaToUserdata(L, 1, string_set_parent, NGUISpriteWrap.cache);
				assetGameObject = WraperUtil.LuaToUserdataOrNil(L, 2, string_set_parent, AssetGameObject.cache);
				nGUISpriteWrap.bcomponent.gameObject.transform.parent = ((assetGameObject != null) ? assetGameObject.transform : null);
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
				NGUISpriteWrap nGUISpriteWrap = null;
				nGUISpriteWrap = WraperUtil.LuaToUserdata(L, 1, string_clone, NGUISpriteWrap.cache);
				nGUISpriteWrap.Clone(L);
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
				NGUISpriteWrap nGUISpriteWrap = null;
				nGUISpriteWrap = WraperUtil.LuaToUserdata(L, 1, string_destroy_object, NGUISpriteWrap.cache);
				nGUISpriteWrap.isNeedDestroy = true;
				result = 0;
			}
			return result;
		}

		[MonoPInvokeCallback(typeof(LuaCSFunction))]
		private static int set_sprite_depth(IntPtr L)
		{
			int result = 0;
			if (WraperUtil.ValidIsUserdata(L, 1, string_set_sprite_depth) && WraperUtil.ValidIsNumber(L, 2, string_set_sprite_depth))
			{
				NGUISpriteWrap nGUISpriteWrap = null;
				int num = 0;
				nGUISpriteWrap = WraperUtil.LuaToUserdata(L, 1, string_set_sprite_depth, NGUISpriteWrap.cache);
				num = (int)LuaDLL.lua_tonumber(L, 2);
				nGUISpriteWrap.component.depth = num;
				result = 0;
			}
			return result;
		}

		[MonoPInvokeCallback(typeof(LuaCSFunction))]
		private static int set_sprite_atlas(IntPtr L)
		{
			int result = 0;
			if (WraperUtil.ValidIsUserdata(L, 1, string_set_sprite_atlas) && WraperUtil.ValidIsUserdata(L, 2, string_set_sprite_atlas))
			{
				NGUISpriteWrap nGUISpriteWrap = null;
				NGUIAtlasWrap nGUIAtlasWrap = null;
				nGUISpriteWrap = WraperUtil.LuaToUserdata(L, 1, string_set_sprite_atlas, NGUISpriteWrap.cache);
				nGUIAtlasWrap = WraperUtil.LuaToUserdata(L, 2, string_set_sprite_atlas, NGUIAtlasWrap.cache);
				nGUISpriteWrap.component.atlas = nGUIAtlasWrap.component;
				result = 0;
			}
			return result;
		}

		[MonoPInvokeCallback(typeof(LuaCSFunction))]
		private static int set_sprite_name(IntPtr L)
		{
			int result = 0;
			if (WraperUtil.ValidIsUserdata(L, 1, string_set_sprite_name) && WraperUtil.ValidIsString(L, 2, string_set_sprite_name))
			{
				NGUISpriteWrap nGUISpriteWrap = null;
				string text = null;
				nGUISpriteWrap = WraperUtil.LuaToUserdata(L, 1, string_set_sprite_name, NGUISpriteWrap.cache);
				text = LuaDLL.lua_tostring(L, 2);
				nGUISpriteWrap.component.spriteName = text;
				result = 0;
			}
			return result;
		}

		[MonoPInvokeCallback(typeof(LuaCSFunction))]
		private static int get_sprite_name(IntPtr L)
		{
			int result = 0;
			if (WraperUtil.ValidIsUserdata(L, 1, string_get_sprite_name))
			{
				NGUISpriteWrap nGUISpriteWrap = null;
				nGUISpriteWrap = WraperUtil.LuaToUserdata(L, 1, string_get_sprite_name, NGUISpriteWrap.cache);
				LuaDLL.lua_pushstring(L, nGUISpriteWrap.component.spriteName);
				result = 1;
			}
			return result;
		}

		[MonoPInvokeCallback(typeof(LuaCSFunction))]
		private static int set_width(IntPtr L)
		{
			int result = 0;
			if (WraperUtil.ValidIsUserdata(L, 1, string_set_width) && WraperUtil.ValidIsNumber(L, 2, string_set_width))
			{
				NGUISpriteWrap nGUISpriteWrap = null;
				int num = 0;
				nGUISpriteWrap = WraperUtil.LuaToUserdata(L, 1, string_set_width, NGUISpriteWrap.cache);
				num = (int)LuaDLL.lua_tonumber(L, 2);
				nGUISpriteWrap.component.width = num;
				result = 0;
			}
			return result;
		}

		[MonoPInvokeCallback(typeof(LuaCSFunction))]
		private static int get_width(IntPtr L)
		{
			int result = 0;
			if (WraperUtil.ValidIsUserdata(L, 1, string_get_width))
			{
				NGUISpriteWrap nGUISpriteWrap = null;
				nGUISpriteWrap = WraperUtil.LuaToUserdata(L, 1, string_get_width, NGUISpriteWrap.cache);
				LuaDLL.lua_pushnumber(L, nGUISpriteWrap.component.width);
				result = 1;
			}
			return result;
		}

		[MonoPInvokeCallback(typeof(LuaCSFunction))]
		private static int set_height(IntPtr L)
		{
			int result = 0;
			if (WraperUtil.ValidIsUserdata(L, 1, string_set_height) && WraperUtil.ValidIsNumber(L, 2, string_set_height))
			{
				NGUISpriteWrap nGUISpriteWrap = null;
				int num = 0;
				nGUISpriteWrap = WraperUtil.LuaToUserdata(L, 1, string_set_height, NGUISpriteWrap.cache);
				num = (int)LuaDLL.lua_tonumber(L, 2);
				nGUISpriteWrap.component.height = num;
				result = 0;
			}
			return result;
		}

		[MonoPInvokeCallback(typeof(LuaCSFunction))]
		private static int get_height(IntPtr L)
		{
			int result = 0;
			if (WraperUtil.ValidIsUserdata(L, 1, string_get_height))
			{
				NGUISpriteWrap nGUISpriteWrap = null;
				nGUISpriteWrap = WraperUtil.LuaToUserdata(L, 1, string_get_height, NGUISpriteWrap.cache);
				LuaDLL.lua_pushnumber(L, nGUISpriteWrap.component.height);
				result = 1;
			}
			return result;
		}

		[MonoPInvokeCallback(typeof(LuaCSFunction))]
		private static int set_color(IntPtr L)
		{
			int result = 0;
			if (WraperUtil.ValidIsUserdata(L, 1, string_set_color) && WraperUtil.ValidIsNumber(L, 2, string_set_color) && WraperUtil.ValidIsNumber(L, 3, string_set_color) && WraperUtil.ValidIsNumber(L, 4, string_set_color) && WraperUtil.ValidIsNumber(L, 5, string_set_color))
			{
				NGUISpriteWrap nGUISpriteWrap = null;
				float num = 0f;
				float num2 = 0f;
				float num3 = 0f;
				float num4 = 0f;
				nGUISpriteWrap = WraperUtil.LuaToUserdata(L, 1, string_set_color, NGUISpriteWrap.cache);
				num = (float)LuaDLL.lua_tonumber(L, 2);
				num2 = (float)LuaDLL.lua_tonumber(L, 3);
				num3 = (float)LuaDLL.lua_tonumber(L, 4);
				num4 = (float)LuaDLL.lua_tonumber(L, 5);
				nGUISpriteWrap.component.color = new Color(num, num2, num3, num4);
				result = 0;
			}
			return result;
		}

		[MonoPInvokeCallback(typeof(LuaCSFunction))]
		private static int get_color(IntPtr L)
		{
			int result = 0;
			if (WraperUtil.ValidIsUserdata(L, 1, string_get_color))
			{
				NGUISpriteWrap nGUISpriteWrap = null;
				nGUISpriteWrap = WraperUtil.LuaToUserdata(L, 1, string_get_color, NGUISpriteWrap.cache);
				LuaDLL.lua_pushnumber(L, nGUISpriteWrap.component.color.r);
				LuaDLL.lua_pushnumber(L, nGUISpriteWrap.component.color.g);
				LuaDLL.lua_pushnumber(L, nGUISpriteWrap.component.color.b);
				LuaDLL.lua_pushnumber(L, nGUISpriteWrap.component.color.a);
				result = 4;
			}
			return result;
		}

		[MonoPInvokeCallback(typeof(LuaCSFunction))]
		private static int set_depth(IntPtr L)
		{
			int result = 0;
			if (WraperUtil.ValidIsUserdata(L, 1, string_set_depth) && WraperUtil.ValidIsNumber(L, 2, string_set_depth))
			{
				NGUISpriteWrap nGUISpriteWrap = null;
				int num = 0;
				nGUISpriteWrap = WraperUtil.LuaToUserdata(L, 1, string_set_depth, NGUISpriteWrap.cache);
				num = (int)LuaDLL.lua_tonumber(L, 2);
				nGUISpriteWrap.component.depth = num;
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
				NGUISpriteWrap nGUISpriteWrap = null;
				nGUISpriteWrap = WraperUtil.LuaToUserdata(L, 1, string_get_depth, NGUISpriteWrap.cache);
				LuaDLL.lua_pushnumber(L, nGUISpriteWrap.component.depth);
				result = 1;
			}
			return result;
		}

		[MonoPInvokeCallback(typeof(LuaCSFunction))]
		private static int set_fill_direction(IntPtr L)
		{
			int result = 0;
			if (WraperUtil.ValidIsUserdata(L, 1, string_set_fill_direction) && WraperUtil.ValidIsNumber(L, 2, string_set_fill_direction))
			{
				NGUISpriteWrap nGUISpriteWrap = null;
				int num = 0;
				nGUISpriteWrap = WraperUtil.LuaToUserdata(L, 1, string_set_fill_direction, NGUISpriteWrap.cache);
				num = (int)LuaDLL.lua_tonumber(L, 2);
				if (num < 1 || num > 5)
				{
					Core.Unity.Debug.LogError("[ngui_sprite_wraper set_fill_direction] error: direction should between 1 ~ 5");
				}
				else if (nGUISpriteWrap.component == null)
				{
					Core.Unity.Debug.LogError("[ngui_sprite_wraper set_fill_direction] error: component is null");
				}
				else
				{
					nGUISpriteWrap.component.fillDirection = (UIBasicSprite.FillDirection)num;
					result = 0;
				}
			}
			return result;
		}

		[MonoPInvokeCallback(typeof(LuaCSFunction))]
		private static int set_on_ngui_click(IntPtr L)
		{
			int result = 0;
			if (WraperUtil.ValidIsUserdata(L, 1, string_set_on_ngui_click) && WraperUtil.ValidIsString(L, 2, string_set_on_ngui_click))
			{
				NGUISpriteWrap nGUISpriteWrap = null;
				string text = null;
				nGUISpriteWrap = WraperUtil.LuaToUserdata(L, 1, string_set_on_ngui_click, NGUISpriteWrap.cache);
				text = LuaDLL.lua_tostring(L, 2);
				NGUIEventListener nGUIEventListener = nGUISpriteWrap.component.gameObject.GetComponent<NGUIEventListener>();
				if (nGUIEventListener == null)
				{
					nGUIEventListener = nGUISpriteWrap.component.gameObject.AddComponent<NGUIEventListener>();
				}
				nGUIEventListener.SetOnClick();
				nGUIEventListener.onClickScript = text;
				result = 0;
			}
			return result;
		}

		[MonoPInvokeCallback(typeof(LuaCSFunction))]
		private static int set_event_value(IntPtr L)
		{
			int result = 0;
			if (WraperUtil.ValidIsUserdata(L, 1, string_set_event_value) && WraperUtil.ValidIsString(L, 2, string_set_event_value))
			{
				NGUISpriteWrap nGUISpriteWrap = null;
				string text = null;
				nGUISpriteWrap = WraperUtil.LuaToUserdata(L, 1, string_set_on_ngui_click, NGUISpriteWrap.cache);
				text = LuaDLL.lua_tostring(L, 2);
				NGUIEventListener nGUIEventListener = nGUISpriteWrap.component.gameObject.GetComponent<NGUIEventListener>();
				if (nGUIEventListener == null)
				{
					nGUIEventListener = nGUISpriteWrap.component.gameObject.AddComponent<NGUIEventListener>();
				}
				nGUIEventListener.setOnStrvalue = text;
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
				NGUISpriteWrap nGUISpriteWrap = null;
				string text = null;
				nGUISpriteWrap = WraperUtil.LuaToUserdata(L, 1, string_set_on_ngui_press, NGUISpriteWrap.cache);
				text = LuaDLL.lua_tostring(L, 2);
				NGUIEventListener nGUIEventListener = nGUISpriteWrap.component.gameObject.GetComponent<NGUIEventListener>();
				if (nGUIEventListener == null)
				{
					nGUIEventListener = nGUISpriteWrap.component.gameObject.AddComponent<NGUIEventListener>();
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
				NGUISpriteWrap nGUISpriteWrap = null;
				string text = null;
				nGUISpriteWrap = WraperUtil.LuaToUserdata(L, 1, string_set_on_ngui_drag_start, NGUISpriteWrap.cache);
				text = LuaDLL.lua_tostring(L, 2);
				NGUIEventListener nGUIEventListener = nGUISpriteWrap.component.gameObject.GetComponent<NGUIEventListener>();
				if (nGUIEventListener == null)
				{
					nGUIEventListener = nGUISpriteWrap.component.gameObject.AddComponent<NGUIEventListener>();
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
				NGUISpriteWrap nGUISpriteWrap = null;
				string text = null;
				nGUISpriteWrap = WraperUtil.LuaToUserdata(L, 1, string_set_on_ngui_drag_move, NGUISpriteWrap.cache);
				text = LuaDLL.lua_tostring(L, 2);
				NGUIEventListener nGUIEventListener = nGUISpriteWrap.component.gameObject.GetComponent<NGUIEventListener>();
				if (nGUIEventListener == null)
				{
					nGUIEventListener = nGUISpriteWrap.component.gameObject.AddComponent<NGUIEventListener>();
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
				NGUISpriteWrap nGUISpriteWrap = null;
				string text = null;
				nGUISpriteWrap = WraperUtil.LuaToUserdata(L, 1, string_set_on_ngui_drag_end, NGUISpriteWrap.cache);
				text = LuaDLL.lua_tostring(L, 2);
				NGUIEventListener nGUIEventListener = nGUISpriteWrap.component.gameObject.GetComponent<NGUIEventListener>();
				if (nGUIEventListener == null)
				{
					nGUIEventListener = nGUISpriteWrap.component.gameObject.AddComponent<NGUIEventListener>();
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
				NGUISpriteWrap nGUISpriteWrap = null;
				nGUISpriteWrap = WraperUtil.LuaToUserdata(L, 1, string_stop_event_propagation, NGUISpriteWrap.cache);
				NGUIEventListener nGUIEventListener = nGUISpriteWrap.component.gameObject.GetComponent<NGUIEventListener>();
				if (nGUIEventListener == null)
				{
					nGUIEventListener = nGUISpriteWrap.component.gameObject.AddComponent<NGUIEventListener>();
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
				NGUISpriteWrap nGUISpriteWrap = null;
				nGUISpriteWrap = WraperUtil.LuaToUserdata(L, 1, string_reset_event_propagation, NGUISpriteWrap.cache);
				NGUIEventListener nGUIEventListener = nGUISpriteWrap.component.gameObject.GetComponent<NGUIEventListener>();
				if (nGUIEventListener == null)
				{
					nGUIEventListener = nGUISpriteWrap.component.gameObject.AddComponent<NGUIEventListener>();
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
				NGUISpriteWrap nGUISpriteWrap = null;
				string text = null;
				nGUISpriteWrap = WraperUtil.LuaToUserdata(L, 1, string_set_on_dragdrop_start, NGUISpriteWrap.cache);
				text = LuaDLL.lua_tostring(L, 2);
				ExUIDragDropItem exUIDragDropItem = nGUISpriteWrap.component.gameObject.GetComponent<ExUIDragDropItem>();
				if (exUIDragDropItem == null)
				{
					exUIDragDropItem = nGUISpriteWrap.component.gameObject.AddComponent<ExUIDragDropItem>();
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
				NGUISpriteWrap nGUISpriteWrap = null;
				string text = null;
				nGUISpriteWrap = WraperUtil.LuaToUserdata(L, 1, string_set_on_dragdrop_release, NGUISpriteWrap.cache);
				text = LuaDLL.lua_tostring(L, 2);
				ExUIDragDropItem exUIDragDropItem = nGUISpriteWrap.component.gameObject.GetComponent<ExUIDragDropItem>();
				if (exUIDragDropItem == null)
				{
					exUIDragDropItem = nGUISpriteWrap.component.gameObject.AddComponent<ExUIDragDropItem>();
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
				NGUISpriteWrap nGUISpriteWrap = null;
				bool flag = false;
				nGUISpriteWrap = WraperUtil.LuaToUserdata(L, 1, string_set_is_dragdrop_clone, NGUISpriteWrap.cache);
				flag = LuaDLL.lua_toboolean(L, 2);
				ExUIDragDropItem exUIDragDropItem = nGUISpriteWrap.component.gameObject.GetComponent<ExUIDragDropItem>();
				if (exUIDragDropItem == null)
				{
					exUIDragDropItem = nGUISpriteWrap.component.gameObject.AddComponent<ExUIDragDropItem>();
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
				NGUISpriteWrap nGUISpriteWrap = null;
				bool flag = false;
				nGUISpriteWrap = WraperUtil.LuaToUserdata(L, 1, string_set_is_hide_clone, NGUISpriteWrap.cache);
				flag = LuaDLL.lua_toboolean(L, 2);
				ExUIDragDropItem exUIDragDropItem = nGUISpriteWrap.component.gameObject.GetComponent<ExUIDragDropItem>();
				if (exUIDragDropItem == null)
				{
					exUIDragDropItem = nGUISpriteWrap.component.gameObject.AddComponent<ExUIDragDropItem>();
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
				NGUISpriteWrap nGUISpriteWrap = null;
				int num = 0;
				nGUISpriteWrap = WraperUtil.LuaToUserdata(L, 1, string_set_dragdrop_restriction, NGUISpriteWrap.cache);
				num = (int)LuaDLL.lua_tonumber(L, 2);
				ExUIDragDropItem component = nGUISpriteWrap.component.gameObject.GetComponent<ExUIDragDropItem>();
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
		private static int set_fill_amout(IntPtr L)
		{
			int result = 0;
			if (WraperUtil.ValidIsUserdata(L, 1, string_set_fill_amout) && WraperUtil.ValidIsNumber(L, 2, string_set_fill_amout))
			{
				NGUISpriteWrap nGUISpriteWrap = null;
				float num = 0f;
				nGUISpriteWrap = WraperUtil.LuaToUserdata(L, 1, string_set_fill_amout, NGUISpriteWrap.cache);
				num = (float)LuaDLL.lua_tonumber(L, 2);
				nGUISpriteWrap.component.fillAmount = num;
				result = 0;
			}
			return result;
		}

		[MonoPInvokeCallback(typeof(LuaCSFunction))]
		private static int set_flip(IntPtr L)
		{
			int result = 0;
			if (WraperUtil.ValidIsUserdata(L, 1, string_set_flip) && WraperUtil.ValidIsNumber(L, 2, string_set_flip))
			{
				NGUISpriteWrap nGUISpriteWrap = null;
				int num = 0;
				nGUISpriteWrap = WraperUtil.LuaToUserdata(L, 1, string_set_flip, NGUISpriteWrap.cache);
				num = (int)LuaDLL.lua_tonumber(L, 2);
				if (num >= 0 && num <= 3)
				{
					nGUISpriteWrap.component.flip = (UIBasicSprite.Flip)num;
				}
				else
				{
					Core.Unity.Debug.LogError("flip must between 0 ~ 3");
				}
				result = 0;
			}
			return result;
		}

		[MonoPInvokeCallback(typeof(LuaCSFunction))]
		private static int update_anchors(IntPtr L)
		{
			int result = 0;
			if (WraperUtil.ValidIsUserdata(L, 1, string_update_anchors))
			{
				NGUISpriteWrap nGUISpriteWrap = null;
				nGUISpriteWrap = WraperUtil.LuaToUserdata(L, 1, string_update_anchors, NGUISpriteWrap.cache);
				nGUISpriteWrap.component.UpdateAnchors();
				result = 0;
			}
			return result;
		}

		[MonoPInvokeCallback(typeof(LuaCSFunction))]
		private static int gc(IntPtr L)
		{
			NGUISpriteWrap nGUISpriteWrap = WraperUtil.LuaToUserdataByGc(L, 1, "gc ngui_sprite", NGUISpriteWrap.cache);
			if (nGUISpriteWrap != null)
			{
				nGUISpriteWrap.DestroyInstance();
			}
			return 0;
		}
	}
}
