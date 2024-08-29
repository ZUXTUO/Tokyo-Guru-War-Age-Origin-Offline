using System;
using ComponentEx;
using Core.Unity;
using LuaInterface;
using UnityEngine;
using UnityWrap;

namespace Wraper
{
	public class ngui_label_wraper
	{
		public static string name = "ngui_label";

		private static luaL_Reg[] func = new luaL_Reg[31]
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
			new luaL_Reg("set_text", set_text),
			new luaL_Reg("get_text", get_text),
			new luaL_Reg("set_color", set_color),
			new luaL_Reg("get_color", get_color),
			new luaL_Reg("set_font_size", set_font_size),
			new luaL_Reg("get_font_size", get_font_size),
			new luaL_Reg("set_overflow", set_overflow),
			new luaL_Reg("get_overflow", get_overflow),
			new luaL_Reg("set_on_ngui_click", set_on_ngui_click),
			new luaL_Reg("set_ngui_font", set_ngui_font),
			new luaL_Reg("get_ngui_font", get_ngui_font),
			new luaL_Reg("set_effect_type", set_effect_type),
			new luaL_Reg("set_effect_color", set_effect_color),
			new luaL_Reg("get_effect_color", get_effect_color),
			new luaL_Reg("set_gradient_top", set_gradient_top),
			new luaL_Reg("get_gradient_top", get_gradient_top),
			new luaL_Reg("set_gradient_bottom", set_gradient_bottom),
			new luaL_Reg("get_gradient_bottom", get_gradient_bottom),
			new luaL_Reg("set_space", set_space)
		};

		private static string string_get_pid = "ngui_label:get_pid";

		private static string string_set_active = "ngui_label:set_active";

		private static string string_set_name = "ngui_label:set_name";

		private static string string_get_name = "ngui_label:get_name";

		private static string string_set_position = "ngui_label:set_position";

		private static string string_get_position = "ngui_label:get_position";

		private static string string_get_size = "ngui_label:get_size";

		private static string string_get_game_object = "ngui_label:get_game_object";

		private static string string_get_parent = "ngui_label:get_parent";

		private static string string_set_parent = "ngui_label:set_parent";

		private static string string_clone = "ngui_label:clone";

		private static string string_destroy_object = "ngui_label:destroy_object";

		private static string string_set_text = "ngui_label:set_text";

		private static string string_get_text = "ngui_label:get_text";

		private static string string_set_color = "ngui_label:set_color";

		private static string string_get_color = "ngui_label:get_color";

		private static string string_set_font_size = "ngui_label:set_font_size";

		private static string string_get_font_size = "ngui_label:get_font_size";

		private static string string_set_overflow = "ngui_label:set_overflow";

		private static string string_get_overflow = "ngui_label:get_overflow";

		private static string string_set_on_ngui_click = "ngui_label:set_on_ngui_click";

		private static string string_set_ngui_font = "ngui_label:set_ngui_font";

		private static string string_get_ngui_font = "ngui_label:get_ngui_font";

		private static string string_set_effect_type = "ngui_label:set_effect_type";

		private static string string_set_effect_color = "ngui_label:set_effect_color";

		private static string string_get_effect_color = "ngui_label:get_effect_color";

		private static string string_set_gradient_top = "ngui_label:set_gradient_top";

		private static string string_get_gradient_top = "ngui_label:get_gradient_top";

		private static string string_set_gradient_bottom = "ngui_label:set_gradient_bottom";

		private static string string_get_gradient_bottom = "ngui_label:get_gradient_bottom";

		private static string string_set_space = "ngui_label:set_space";

		public static bool init(IntPtr L)
		{
			if (L != IntPtr.Zero)
			{
				LuaDLL.register_class(L, name, func, gc);
				return true;
			}
			return false;
		}

		public static void push(IntPtr L, NGUILabelWrap obj)
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
				NGUILabelWrap nGUILabelWrap = null;
				nGUILabelWrap = WraperUtil.LuaToUserdata(L, 1, string_get_pid, NGUILabelWrap.cache);
				LuaDLL.lua_pushnumber(L, nGUILabelWrap.GetPid());
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
				NGUILabelWrap nGUILabelWrap = null;
				bool flag = false;
				nGUILabelWrap = WraperUtil.LuaToUserdata(L, 1, string_set_active, NGUILabelWrap.cache);
				flag = LuaDLL.lua_toboolean(L, 2);
				nGUILabelWrap.bcomponent.gameObject.SetActive(flag);
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
				NGUILabelWrap nGUILabelWrap = null;
				string text = null;
				nGUILabelWrap = WraperUtil.LuaToUserdata(L, 1, string_set_name, NGUILabelWrap.cache);
				text = LuaDLL.lua_tostring(L, 2);
				nGUILabelWrap.bcomponent.gameObject.name = text;
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
				NGUILabelWrap nGUILabelWrap = null;
				nGUILabelWrap = WraperUtil.LuaToUserdata(L, 1, string_get_name, NGUILabelWrap.cache);
				LuaDLL.lua_pushstring(L, nGUILabelWrap.bcomponent.gameObject.name);
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
				NGUILabelWrap nGUILabelWrap = null;
				float num = 0f;
				float num2 = 0f;
				float num3 = 0f;
				nGUILabelWrap = WraperUtil.LuaToUserdata(L, 1, string_set_position, NGUILabelWrap.cache);
				num = (float)LuaDLL.lua_tonumber(L, 2);
				num2 = (float)LuaDLL.lua_tonumber(L, 3);
				num3 = (float)LuaDLL.lua_tonumber(L, 4);
				nGUILabelWrap.bcomponent.gameObject.transform.localPosition = new Vector3(num, num2, num3);
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
				NGUILabelWrap nGUILabelWrap = null;
				nGUILabelWrap = WraperUtil.LuaToUserdata(L, 1, string_get_position, NGUILabelWrap.cache);
				Vector3 localPosition = nGUILabelWrap.bcomponent.gameObject.transform.localPosition;
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
				NGUILabelWrap nGUILabelWrap = null;
				nGUILabelWrap = WraperUtil.LuaToUserdata(L, 1, string_get_size, NGUILabelWrap.cache);
				int num = ((!(nGUILabelWrap.widget == null)) ? nGUILabelWrap.widget.width : 0);
				int num2 = ((!(nGUILabelWrap.widget == null)) ? nGUILabelWrap.widget.height : 0);
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
				NGUILabelWrap nGUILabelWrap = null;
				nGUILabelWrap = WraperUtil.LuaToUserdata(L, 1, string_get_game_object, NGUILabelWrap.cache);
				AssetGameObject base_object = AssetGameObject.CreateByInstance(nGUILabelWrap.bcomponent.gameObject);
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
				NGUILabelWrap nGUILabelWrap = null;
				nGUILabelWrap = WraperUtil.LuaToUserdata(L, 1, string_get_parent, NGUILabelWrap.cache);
				AssetGameObject assetGameObject = null;
				Transform parent = nGUILabelWrap.bcomponent.gameObject.transform.parent;
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
				NGUILabelWrap nGUILabelWrap = null;
				AssetGameObject assetGameObject = null;
				nGUILabelWrap = WraperUtil.LuaToUserdata(L, 1, string_set_parent, NGUILabelWrap.cache);
				assetGameObject = WraperUtil.LuaToUserdataOrNil(L, 2, string_set_parent, AssetGameObject.cache);
				nGUILabelWrap.bcomponent.gameObject.transform.parent = ((assetGameObject != null) ? assetGameObject.transform : null);
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
				NGUILabelWrap nGUILabelWrap = null;
				nGUILabelWrap = WraperUtil.LuaToUserdata(L, 1, string_clone, NGUILabelWrap.cache);
				nGUILabelWrap.Clone(L);
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
				NGUILabelWrap nGUILabelWrap = null;
				nGUILabelWrap = WraperUtil.LuaToUserdata(L, 1, string_destroy_object, NGUILabelWrap.cache);
				nGUILabelWrap.isNeedDestroy = true;
				result = 0;
			}
			return result;
		}

		[MonoPInvokeCallback(typeof(LuaCSFunction))]
		private static int set_text(IntPtr L)
		{
			int result = 0;
			if (WraperUtil.ValidIsUserdata(L, 1, string_set_text) && WraperUtil.ValidIsString(L, 2, string_set_text))
			{
				NGUILabelWrap nGUILabelWrap = null;
				string text = null;
				nGUILabelWrap = WraperUtil.LuaToUserdata(L, 1, string_set_text, NGUILabelWrap.cache);
				text = LuaDLL.lua_tostring(L, 2);
				nGUILabelWrap.component.text = text;
				result = 0;
			}
			return result;
		}

		[MonoPInvokeCallback(typeof(LuaCSFunction))]
		private static int get_text(IntPtr L)
		{
			int result = 0;
			if (WraperUtil.ValidIsUserdata(L, 1, string_get_text))
			{
				NGUILabelWrap nGUILabelWrap = null;
				nGUILabelWrap = WraperUtil.LuaToUserdata(L, 1, string_get_text, NGUILabelWrap.cache);
				LuaDLL.lua_pushstring(L, nGUILabelWrap.component.text);
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
				NGUILabelWrap nGUILabelWrap = null;
				float num = 0f;
				float num2 = 0f;
				float num3 = 0f;
				float num4 = 0f;
				nGUILabelWrap = WraperUtil.LuaToUserdata(L, 1, string_set_color, NGUILabelWrap.cache);
				num = (float)LuaDLL.lua_tonumber(L, 2);
				num2 = (float)LuaDLL.lua_tonumber(L, 3);
				num3 = (float)LuaDLL.lua_tonumber(L, 4);
				num4 = (float)LuaDLL.lua_tonumber(L, 5);
				nGUILabelWrap.component.color = new Color(num, num2, num3, num4);
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
				NGUILabelWrap nGUILabelWrap = null;
				nGUILabelWrap = WraperUtil.LuaToUserdata(L, 1, string_get_color, NGUILabelWrap.cache);
				LuaDLL.lua_pushnumber(L, nGUILabelWrap.component.color.r);
				LuaDLL.lua_pushnumber(L, nGUILabelWrap.component.color.g);
				LuaDLL.lua_pushnumber(L, nGUILabelWrap.component.color.b);
				LuaDLL.lua_pushnumber(L, nGUILabelWrap.component.color.a);
				result = 4;
			}
			return result;
		}

		[MonoPInvokeCallback(typeof(LuaCSFunction))]
		private static int set_font_size(IntPtr L)
		{
			int result = 0;
			if (WraperUtil.ValidIsUserdata(L, 1, string_set_font_size) && WraperUtil.ValidIsNumber(L, 2, string_set_font_size))
			{
				NGUILabelWrap nGUILabelWrap = null;
				int num = 0;
				nGUILabelWrap = WraperUtil.LuaToUserdata(L, 1, string_set_font_size, NGUILabelWrap.cache);
				num = (int)LuaDLL.lua_tonumber(L, 2);
				nGUILabelWrap.component.fontSize = num;
				result = 0;
			}
			return result;
		}

		[MonoPInvokeCallback(typeof(LuaCSFunction))]
		private static int get_font_size(IntPtr L)
		{
			int result = 0;
			if (WraperUtil.ValidIsUserdata(L, 1, string_get_font_size))
			{
				NGUILabelWrap nGUILabelWrap = null;
				nGUILabelWrap = WraperUtil.LuaToUserdata(L, 1, string_get_font_size, NGUILabelWrap.cache);
				LuaDLL.lua_pushnumber(L, nGUILabelWrap.component.fontSize);
				result = 1;
			}
			return result;
		}

		[MonoPInvokeCallback(typeof(LuaCSFunction))]
		private static int set_overflow(IntPtr L)
		{
			int result = 0;
			if (WraperUtil.ValidIsUserdata(L, 1, string_set_overflow) && WraperUtil.ValidIsNumber(L, 2, string_set_overflow))
			{
				NGUILabelWrap nGUILabelWrap = null;
				int num = 0;
				nGUILabelWrap = WraperUtil.LuaToUserdata(L, 1, string_set_overflow, NGUILabelWrap.cache);
				num = (int)LuaDLL.lua_tonumber(L, 2);
				if (num < 1 || num > 4)
				{
					Core.Unity.Debug.LogError("[ngui_label set_overflow] overflow_type is wrong, it is between 1 ~ 4");
				}
				nGUILabelWrap.component.overflowMethod = (UILabel.Overflow)num;
				result = 0;
			}
			return result;
		}

		[MonoPInvokeCallback(typeof(LuaCSFunction))]
		private static int get_overflow(IntPtr L)
		{
			int result = 0;
			if (WraperUtil.ValidIsUserdata(L, 1, string_get_overflow))
			{
				NGUILabelWrap nGUILabelWrap = null;
				nGUILabelWrap = WraperUtil.LuaToUserdata(L, 1, string_get_overflow, NGUILabelWrap.cache);
				LuaDLL.lua_pushnumber(L, (double)nGUILabelWrap.component.overflowMethod);
				result = 1;
			}
			return result;
		}

		[MonoPInvokeCallback(typeof(LuaCSFunction))]
		private static int set_on_ngui_click(IntPtr L)
		{
			int result = 0;
			if (WraperUtil.ValidIsUserdata(L, 1, string_set_on_ngui_click) && WraperUtil.ValidIsString(L, 2, string_set_on_ngui_click))
			{
				NGUILabelWrap nGUILabelWrap = null;
				string text = null;
				nGUILabelWrap = WraperUtil.LuaToUserdata(L, 1, string_set_on_ngui_click, NGUILabelWrap.cache);
				text = LuaDLL.lua_tostring(L, 2);
				NGUIEventListener nGUIEventListener = nGUILabelWrap.component.gameObject.GetComponent<NGUIEventListener>();
				if (nGUIEventListener == null)
				{
					nGUIEventListener = nGUILabelWrap.component.gameObject.AddComponent<NGUIEventListener>();
				}
				nGUIEventListener.SetOnClick();
				nGUIEventListener.onClickScript = text;
				result = 0;
			}
			return result;
		}

		[MonoPInvokeCallback(typeof(LuaCSFunction))]
		private static int set_ngui_font(IntPtr L)
		{
			int result = 0;
			if (WraperUtil.ValidIsUserdata(L, 1, string_set_ngui_font) && WraperUtil.ValidIsUserdata(L, 2, string_set_ngui_font))
			{
				NGUILabelWrap nGUILabelWrap = null;
				NGUIFontWrap nGUIFontWrap = null;
				nGUILabelWrap = WraperUtil.LuaToUserdata(L, 1, string_set_ngui_font, NGUILabelWrap.cache);
				nGUIFontWrap = WraperUtil.LuaToUserdata(L, 2, string_set_ngui_font, NGUIFontWrap.cache);
				nGUILabelWrap.component.bitmapFont = nGUIFontWrap.component;
				result = 0;
			}
			return result;
		}

		[MonoPInvokeCallback(typeof(LuaCSFunction))]
		private static int get_ngui_font(IntPtr L)
		{
			int result = 0;
			if (WraperUtil.ValidIsUserdata(L, 1, string_get_ngui_font))
			{
				NGUILabelWrap nGUILabelWrap = null;
				nGUILabelWrap = WraperUtil.LuaToUserdata(L, 1, string_get_ngui_font, NGUILabelWrap.cache);
				NGUIFontWrap base_object = NGUIFontWrap.CreateInstance(nGUILabelWrap.component.bitmapFont);
				WraperUtil.PushObject(L, base_object);
				result = 1;
			}
			return result;
		}

		[MonoPInvokeCallback(typeof(LuaCSFunction))]
		private static int set_effect_color(IntPtr L)
		{
			int result = 0;
			if (WraperUtil.ValidIsUserdata(L, 1, string_set_effect_color) && WraperUtil.ValidIsNumber(L, 2, string_set_effect_color) && WraperUtil.ValidIsNumber(L, 3, string_set_effect_color) && WraperUtil.ValidIsNumber(L, 4, string_set_effect_color) && WraperUtil.ValidIsNumber(L, 5, string_set_effect_color))
			{
				NGUILabelWrap nGUILabelWrap = null;
				float num = 0f;
				float num2 = 0f;
				float num3 = 0f;
				float num4 = 0f;
				nGUILabelWrap = WraperUtil.LuaToUserdata(L, 1, string_set_effect_color, NGUILabelWrap.cache);
				num = (float)LuaDLL.lua_tonumber(L, 2);
				num2 = (float)LuaDLL.lua_tonumber(L, 3);
				num3 = (float)LuaDLL.lua_tonumber(L, 4);
				num4 = (float)LuaDLL.lua_tonumber(L, 5);
				nGUILabelWrap.component.effectColor = new Color(num, num2, num3, num4);
				result = 0;
			}
			return result;
		}

		[MonoPInvokeCallback(typeof(LuaCSFunction))]
		private static int set_effect_type(IntPtr L)
		{
			int result = 0;
			if (WraperUtil.ValidIsUserdata(L, 1, string_set_effect_type) && WraperUtil.ValidIsNumber(L, 2, string_set_effect_type))
			{
				NGUILabelWrap nGUILabelWrap = null;
				int num = (int)LuaDLL.lua_tonumber(L, 2);
				nGUILabelWrap = WraperUtil.LuaToUserdata(L, 1, string_set_effect_type, NGUILabelWrap.cache);
				UILabel.Effect effectStyle = (UILabel.Effect)num;
				nGUILabelWrap.component.effectStyle = effectStyle;
				result = 0;
			}
			return result;
		}

		[MonoPInvokeCallback(typeof(LuaCSFunction))]
		private static int get_effect_color(IntPtr L)
		{
			int result = 0;
			if (WraperUtil.ValidIsUserdata(L, 1, string_get_effect_color))
			{
				NGUILabelWrap nGUILabelWrap = null;
				nGUILabelWrap = WraperUtil.LuaToUserdata(L, 1, string_get_effect_color, NGUILabelWrap.cache);
				LuaDLL.lua_pushnumber(L, nGUILabelWrap.component.effectColor.r);
				LuaDLL.lua_pushnumber(L, nGUILabelWrap.component.effectColor.g);
				LuaDLL.lua_pushnumber(L, nGUILabelWrap.component.effectColor.b);
				LuaDLL.lua_pushnumber(L, nGUILabelWrap.component.effectColor.a);
				result = 4;
			}
			return result;
		}

		[MonoPInvokeCallback(typeof(LuaCSFunction))]
		private static int set_gradient_top(IntPtr L)
		{
			int result = 0;
			if (WraperUtil.ValidIsUserdata(L, 1, string_set_gradient_top) && WraperUtil.ValidIsNumber(L, 2, string_set_gradient_top) && WraperUtil.ValidIsNumber(L, 3, string_set_gradient_top) && WraperUtil.ValidIsNumber(L, 4, string_set_gradient_top) && WraperUtil.ValidIsNumber(L, 5, string_set_gradient_top))
			{
				NGUILabelWrap nGUILabelWrap = null;
				float num = 0f;
				float num2 = 0f;
				float num3 = 0f;
				float num4 = 0f;
				nGUILabelWrap = WraperUtil.LuaToUserdata(L, 1, string_set_gradient_top, NGUILabelWrap.cache);
				num = (float)LuaDLL.lua_tonumber(L, 2);
				num2 = (float)LuaDLL.lua_tonumber(L, 3);
				num3 = (float)LuaDLL.lua_tonumber(L, 4);
				num4 = (float)LuaDLL.lua_tonumber(L, 5);
				nGUILabelWrap.component.gradientTop = new Color(num, num2, num3, num4);
				result = 0;
			}
			return result;
		}

		[MonoPInvokeCallback(typeof(LuaCSFunction))]
		private static int get_gradient_top(IntPtr L)
		{
			int result = 0;
			if (WraperUtil.ValidIsUserdata(L, 1, string_get_gradient_top))
			{
				NGUILabelWrap nGUILabelWrap = null;
				nGUILabelWrap = WraperUtil.LuaToUserdata(L, 1, string_get_gradient_top, NGUILabelWrap.cache);
				LuaDLL.lua_pushnumber(L, nGUILabelWrap.component.gradientTop.r);
				LuaDLL.lua_pushnumber(L, nGUILabelWrap.component.gradientTop.g);
				LuaDLL.lua_pushnumber(L, nGUILabelWrap.component.gradientTop.b);
				LuaDLL.lua_pushnumber(L, nGUILabelWrap.component.gradientTop.a);
				result = 4;
			}
			return result;
		}

		[MonoPInvokeCallback(typeof(LuaCSFunction))]
		private static int set_gradient_bottom(IntPtr L)
		{
			int result = 0;
			if (WraperUtil.ValidIsUserdata(L, 1, string_set_gradient_bottom) && WraperUtil.ValidIsNumber(L, 2, string_set_gradient_bottom) && WraperUtil.ValidIsNumber(L, 3, string_set_gradient_bottom) && WraperUtil.ValidIsNumber(L, 4, string_set_gradient_bottom) && WraperUtil.ValidIsNumber(L, 5, string_set_gradient_bottom))
			{
				NGUILabelWrap nGUILabelWrap = null;
				float num = 0f;
				float num2 = 0f;
				float num3 = 0f;
				float num4 = 0f;
				nGUILabelWrap = WraperUtil.LuaToUserdata(L, 1, string_set_gradient_bottom, NGUILabelWrap.cache);
				num = (float)LuaDLL.lua_tonumber(L, 2);
				num2 = (float)LuaDLL.lua_tonumber(L, 3);
				num3 = (float)LuaDLL.lua_tonumber(L, 4);
				num4 = (float)LuaDLL.lua_tonumber(L, 5);
				nGUILabelWrap.component.gradientBottom = new Color(num, num2, num3, num4);
				result = 0;
			}
			return result;
		}

		[MonoPInvokeCallback(typeof(LuaCSFunction))]
		private static int get_gradient_bottom(IntPtr L)
		{
			int result = 0;
			if (WraperUtil.ValidIsUserdata(L, 1, string_get_gradient_bottom))
			{
				NGUILabelWrap nGUILabelWrap = null;
				nGUILabelWrap = WraperUtil.LuaToUserdata(L, 1, string_get_gradient_bottom, NGUILabelWrap.cache);
				LuaDLL.lua_pushnumber(L, nGUILabelWrap.component.gradientBottom.r);
				LuaDLL.lua_pushnumber(L, nGUILabelWrap.component.gradientBottom.g);
				LuaDLL.lua_pushnumber(L, nGUILabelWrap.component.gradientBottom.b);
				LuaDLL.lua_pushnumber(L, nGUILabelWrap.component.gradientBottom.a);
				result = 4;
			}
			return result;
		}

		[MonoPInvokeCallback(typeof(LuaCSFunction))]
		private static int set_space(IntPtr L)
		{
			int result = 0;
			if (WraperUtil.ValidIsUserdata(L, 1, string_set_space))
			{
				NGUILabelWrap nGUILabelWrap = null;
				nGUILabelWrap = WraperUtil.LuaToUserdata(L, 1, string_set_space, NGUILabelWrap.cache);
				if (WraperUtil.ValidIsUserdata(L, 1, string_set_space) && WraperUtil.ValidIsBoolean(L, 2, string_set_space) && WraperUtil.ValidIsNumber(L, 3, string_set_space) && WraperUtil.ValidIsNumber(L, 4, string_set_space))
				{
					UILabel component = nGUILabelWrap.component;
					if (component.useFloatSpacing = LuaDLL.lua_toboolean(L, 2))
					{
						component.floatSpacingX = (float)LuaDLL.lua_tonumber(L, 3);
						component.floatSpacingY = (float)LuaDLL.lua_tonumber(L, 4);
					}
					else
					{
						component.spacingX = (int)LuaDLL.lua_tonumber(L, 3);
						component.spacingY = (int)LuaDLL.lua_tonumber(L, 4);
					}
					result = 4;
				}
			}
			return result;
		}

		[MonoPInvokeCallback(typeof(LuaCSFunction))]
		private static int gc(IntPtr L)
		{
			NGUILabelWrap nGUILabelWrap = WraperUtil.LuaToUserdataByGc(L, 1, "gc ngui_label", NGUILabelWrap.cache);
			if (nGUILabelWrap != null)
			{
				nGUILabelWrap.DestroyInstance();
			}
			return 0;
		}
	}
}
