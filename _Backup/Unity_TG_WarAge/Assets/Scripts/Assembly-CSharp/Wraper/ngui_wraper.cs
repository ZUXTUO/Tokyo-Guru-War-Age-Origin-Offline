using System;
using LuaInterface;
using UnityEngine;
using UnityWrap;

namespace Wraper
{
	public class ngui_wraper
	{
		public static string libname = "ngui";

		private static luaL_Reg[] libfunc = new luaL_Reg[26]
		{
			new luaL_Reg("find_label", find_label),
			new luaL_Reg("find_button", find_button),
			new luaL_Reg("find_sprite", find_sprite),
			new luaL_Reg("find_slider", find_slider),
			new luaL_Reg("find_texture", find_texture),
			new luaL_Reg("find_grid", find_grid),
			new luaL_Reg("find_popup_list", find_popup_list),
			new luaL_Reg("find_progress_bar", find_progress_bar),
			new luaL_Reg("find_toggle", find_toggle),
			new luaL_Reg("find_input", find_input),
			new luaL_Reg("find_uitweener", find_uitweener),
			new luaL_Reg("find_tween_color", find_tween_color),
			new luaL_Reg("find_tween_position", find_tween_position),
			new luaL_Reg("find_tween_rotation", find_tween_rotation),
			new luaL_Reg("find_tween_scale", find_tween_scale),
			new luaL_Reg("find_wrap_content", find_wrap_content),
			new luaL_Reg("find_wrap_list", find_wrap_list),
			new luaL_Reg("find_center_child", find_center_child),
			new luaL_Reg("find_scroll_view", find_scroll_view),
			new luaL_Reg("find_panel", find_panel),
			new luaL_Reg("find_table", find_table),
			new luaL_Reg("raycast", raycast),
			new luaL_Reg("find_widget", find_widget),
			new luaL_Reg("find_enchance_scroll_view", find_enchance_scroll_view),
			new luaL_Reg("find_bezierpathspline", find_bezierpathspline),
			new luaL_Reg("find_sprite_animation", find_sprite_animation)
		};

		private static string string_find_label = "ngui.find_label";

		private static string string_find_button = "ngui.find_button";

		private static string string_find_sprite = "ngui.find_sprite";

		private static string string_find_slider = "ngui.find_slider";

		private static string string_find_texture = "ngui.find_texture";

		private static string string_find_grid = "ngui.find_grid";

		private static string string_find_popup_list = "ngui.find_popup_list";

		private static string string_find_progress_bar = "ngui.find_progress_bar";

		private static string string_find_toggle = "ngui.find_toggle";

		private static string string_find_input = "ngui.find_input";

		private static string string_find_uitweener = "ngui.find_uitweener";

		private static string string_find_tween_color = "ngui.find_tween_color";

		private static string string_find_tween_position = "ngui.find_tween_position";

		private static string string_find_tween_rotation = "ngui.find_tween_rotation";

		private static string string_find_tween_scale = "ngui.find_tween_scale";

		private static string string_find_wrap_content = "ngui.find_wrap_content";

		private static string string_find_wrap_list = "ngui.find_wrap_list";

		private static string string_find_center_child = "ngui.find_center_child";

		private static string string_find_scroll_view = "ngui.find_scroll_view";

		private static string string_find_panel = "ngui.find_panel";

		private static string string_find_table = "ngui.find_table";

		private static string string_raycast = "ngui.raycast";

		private static string string_find_widget = "ngui.find_widget";

		private static string string_find_enchance_scroll_view = "ngui.find_enchance_scroll_view";

		private static string string_find_bezierpathspline = "ngui.find_bezierpathspline";

		private static string string_find_sprite_animation = "ngui.find_sprite_animation";

		public static bool init(IntPtr L)
		{
			if (L != IntPtr.Zero)
			{
				LuaDLL.register_lib(L, libname, libfunc, 0);
				return true;
			}
			return false;
		}

		[MonoPInvokeCallback(typeof(LuaCSFunction))]
		private static int find_label(IntPtr L)
		{
			int result = 0;
			if (WraperUtil.ValidIsUserdata(L, 1, string_find_label) && WraperUtil.ValidIsString(L, 2, string_find_label))
			{
				AssetGameObject assetGameObject = null;
				string text = null;
				assetGameObject = WraperUtil.LuaToUserdata(L, 1, string_find_label, AssetGameObject.cache);
				text = LuaDLL.lua_tostring(L, 2);
				WraperUtil.PushObject(L, NGUIWrap.Find<NGUILabelWrap, UILabel>(assetGameObject, text));
				result = 1;
			}
			return result;
		}

		[MonoPInvokeCallback(typeof(LuaCSFunction))]
		private static int find_button(IntPtr L)
		{
			int result = 0;
			if (WraperUtil.ValidIsUserdata(L, 1, string_find_button) && WraperUtil.ValidIsString(L, 2, string_find_button))
			{
				AssetGameObject assetGameObject = null;
				string text = null;
				assetGameObject = WraperUtil.LuaToUserdata(L, 1, string_find_button, AssetGameObject.cache);
				text = LuaDLL.lua_tostring(L, 2);
				WraperUtil.PushObject(L, NGUIWrap.Find<NGUIButtonWrap, UIButton>(assetGameObject, text));
				result = 1;
			}
			return result;
		}

		[MonoPInvokeCallback(typeof(LuaCSFunction))]
		private static int find_sprite(IntPtr L)
		{
			int result = 0;
			if (WraperUtil.ValidIsUserdata(L, 1, string_find_sprite) && WraperUtil.ValidIsString(L, 2, string_find_sprite))
			{
				AssetGameObject assetGameObject = null;
				string text = null;
				assetGameObject = WraperUtil.LuaToUserdata(L, 1, string_find_sprite, AssetGameObject.cache);
				text = LuaDLL.lua_tostring(L, 2);
				WraperUtil.PushObject(L, NGUIWrap.Find<NGUISpriteWrap, UISprite>(assetGameObject, text));
				result = 1;
			}
			return result;
		}

		[MonoPInvokeCallback(typeof(LuaCSFunction))]
		private static int find_slider(IntPtr L)
		{
			int result = 0;
			if (WraperUtil.ValidIsUserdata(L, 1, string_find_slider) && WraperUtil.ValidIsString(L, 2, string_find_slider))
			{
				AssetGameObject assetGameObject = null;
				string text = null;
				assetGameObject = WraperUtil.LuaToUserdata(L, 1, string_find_slider, AssetGameObject.cache);
				text = LuaDLL.lua_tostring(L, 2);
				WraperUtil.PushObject(L, NGUIWrap.Find<NGUISliderWrap, UISlider>(assetGameObject, text));
				result = 1;
			}
			return result;
		}

		[MonoPInvokeCallback(typeof(LuaCSFunction))]
		private static int find_texture(IntPtr L)
		{
			int result = 0;
			if (WraperUtil.ValidIsUserdata(L, 1, string_find_texture) && WraperUtil.ValidIsString(L, 2, string_find_texture))
			{
				AssetGameObject assetGameObject = null;
				string text = null;
				assetGameObject = WraperUtil.LuaToUserdata(L, 1, string_find_texture, AssetGameObject.cache);
				text = LuaDLL.lua_tostring(L, 2);
				WraperUtil.PushObject(L, NGUIWrap.Find<NGUITextureWrap, UITexture>(assetGameObject, text));
				result = 1;
			}
			return result;
		}

		[MonoPInvokeCallback(typeof(LuaCSFunction))]
		private static int find_grid(IntPtr L)
		{
			int result = 0;
			if (WraperUtil.ValidIsUserdata(L, 1, string_find_grid) && WraperUtil.ValidIsString(L, 2, string_find_grid))
			{
				AssetGameObject assetGameObject = null;
				string text = null;
				assetGameObject = WraperUtil.LuaToUserdata(L, 1, string_find_grid, AssetGameObject.cache);
				text = LuaDLL.lua_tostring(L, 2);
				WraperUtil.PushObject(L, NGUIWrap.Find<NGUIGridWrap, UIGrid>(assetGameObject, text));
				result = 1;
			}
			return result;
		}

		[MonoPInvokeCallback(typeof(LuaCSFunction))]
		private static int find_popup_list(IntPtr L)
		{
			int result = 0;
			if (WraperUtil.ValidIsUserdata(L, 1, string_find_popup_list) && WraperUtil.ValidIsString(L, 2, string_find_popup_list))
			{
				AssetGameObject assetGameObject = null;
				string text = null;
				assetGameObject = WraperUtil.LuaToUserdata(L, 1, string_find_popup_list, AssetGameObject.cache);
				text = LuaDLL.lua_tostring(L, 2);
				WraperUtil.PushObject(L, NGUIWrap.Find<NGUIPopUpListWrap, UIPopupList>(assetGameObject, text));
				result = 1;
			}
			return result;
		}

		[MonoPInvokeCallback(typeof(LuaCSFunction))]
		private static int find_progress_bar(IntPtr L)
		{
			int result = 0;
			if (WraperUtil.ValidIsUserdata(L, 1, string_find_progress_bar) && WraperUtil.ValidIsString(L, 2, string_find_progress_bar))
			{
				AssetGameObject assetGameObject = null;
				string text = null;
				assetGameObject = WraperUtil.LuaToUserdata(L, 1, string_find_progress_bar, AssetGameObject.cache);
				text = LuaDLL.lua_tostring(L, 2);
				WraperUtil.PushObject(L, NGUIWrap.Find<NGUIProgressBarWrap, UIProgressBar>(assetGameObject, text));
				result = 1;
			}
			return result;
		}

		[MonoPInvokeCallback(typeof(LuaCSFunction))]
		private static int find_toggle(IntPtr L)
		{
			int result = 0;
			if (WraperUtil.ValidIsUserdata(L, 1, string_find_toggle) && WraperUtil.ValidIsString(L, 2, string_find_toggle))
			{
				AssetGameObject assetGameObject = null;
				string text = null;
				assetGameObject = WraperUtil.LuaToUserdata(L, 1, string_find_toggle, AssetGameObject.cache);
				text = LuaDLL.lua_tostring(L, 2);
				WraperUtil.PushObject(L, NGUIWrap.Find<NGUIToggleWrap, UIToggle>(assetGameObject, text));
				result = 1;
			}
			return result;
		}

		[MonoPInvokeCallback(typeof(LuaCSFunction))]
		private static int find_input(IntPtr L)
		{
			int result = 0;
			if (WraperUtil.ValidIsUserdata(L, 1, string_find_input) && WraperUtil.ValidIsString(L, 2, string_find_input))
			{
				AssetGameObject assetGameObject = null;
				string text = null;
				assetGameObject = WraperUtil.LuaToUserdata(L, 1, string_find_input, AssetGameObject.cache);
				text = LuaDLL.lua_tostring(L, 2);
				WraperUtil.PushObject(L, NGUIWrap.Find<NGUIInputWrap, UIInput>(assetGameObject, text));
				result = 1;
			}
			return result;
		}

		[MonoPInvokeCallback(typeof(LuaCSFunction))]
		private static int find_uitweener(IntPtr L)
		{
			int result = 0;
			if (WraperUtil.ValidIsUserdata(L, 1, string_find_uitweener) && WraperUtil.ValidIsString(L, 2, string_find_uitweener))
			{
				AssetGameObject assetGameObject = null;
				string text = null;
				assetGameObject = WraperUtil.LuaToUserdata(L, 1, string_find_uitweener, AssetGameObject.cache);
				text = LuaDLL.lua_tostring(L, 2);
				WraperUtil.PushObject(L, NGUIWrap.Find<NGUIUITweenerWrap, UITweener>(assetGameObject, text));
				result = 1;
			}
			return result;
		}

		[MonoPInvokeCallback(typeof(LuaCSFunction))]
		private static int find_tween_color(IntPtr L)
		{
			int result = 0;
			if (WraperUtil.ValidIsUserdata(L, 1, string_find_tween_color) && WraperUtil.ValidIsString(L, 2, string_find_tween_color))
			{
				AssetGameObject assetGameObject = null;
				string text = null;
				assetGameObject = WraperUtil.LuaToUserdata(L, 1, string_find_tween_color, AssetGameObject.cache);
				text = LuaDLL.lua_tostring(L, 2);
				WraperUtil.PushObject(L, NGUIWrap.Find<NGUITweenColorWrap, TweenColor>(assetGameObject, text));
				result = 1;
			}
			return result;
		}

		[MonoPInvokeCallback(typeof(LuaCSFunction))]
		private static int find_tween_position(IntPtr L)
		{
			int result = 0;
			if (WraperUtil.ValidIsUserdata(L, 1, string_find_tween_position) && WraperUtil.ValidIsString(L, 2, string_find_tween_position))
			{
				AssetGameObject assetGameObject = null;
				string text = null;
				assetGameObject = WraperUtil.LuaToUserdata(L, 1, string_find_tween_position, AssetGameObject.cache);
				text = LuaDLL.lua_tostring(L, 2);
				WraperUtil.PushObject(L, NGUIWrap.Find<NGUITweenPositionWrap, TweenPosition>(assetGameObject, text));
				result = 1;
			}
			return result;
		}

		[MonoPInvokeCallback(typeof(LuaCSFunction))]
		private static int find_tween_rotation(IntPtr L)
		{
			int result = 0;
			if (WraperUtil.ValidIsUserdata(L, 1, string_find_tween_rotation) && WraperUtil.ValidIsString(L, 2, string_find_tween_rotation))
			{
				AssetGameObject assetGameObject = null;
				string text = null;
				assetGameObject = WraperUtil.LuaToUserdata(L, 1, string_find_tween_rotation, AssetGameObject.cache);
				text = LuaDLL.lua_tostring(L, 2);
				WraperUtil.PushObject(L, NGUIWrap.Find<NGUITweenRotationWrap, TweenRotation>(assetGameObject, text));
				result = 1;
			}
			return result;
		}

		[MonoPInvokeCallback(typeof(LuaCSFunction))]
		private static int find_tween_scale(IntPtr L)
		{
			int result = 0;
			if (WraperUtil.ValidIsUserdata(L, 1, string_find_tween_scale) && WraperUtil.ValidIsString(L, 2, string_find_tween_scale))
			{
				AssetGameObject assetGameObject = null;
				string text = null;
				assetGameObject = WraperUtil.LuaToUserdata(L, 1, string_find_tween_scale, AssetGameObject.cache);
				text = LuaDLL.lua_tostring(L, 2);
				WraperUtil.PushObject(L, NGUIWrap.Find<NGUITweenScaleWrap, TweenScale>(assetGameObject, text));
				result = 1;
			}
			return result;
		}

		[MonoPInvokeCallback(typeof(LuaCSFunction))]
		private static int find_wrap_content(IntPtr L)
		{
			int result = 0;
			if (WraperUtil.ValidIsUserdata(L, 1, string_find_wrap_content) && WraperUtil.ValidIsString(L, 2, string_find_wrap_content))
			{
				AssetGameObject assetGameObject = null;
				string text = null;
				assetGameObject = WraperUtil.LuaToUserdata(L, 1, string_find_wrap_content, AssetGameObject.cache);
				text = LuaDLL.lua_tostring(L, 2);
				WraperUtil.PushObject(L, NGUIWrap.Find<NGUIWrapContentWrap, UIWrapContent>(assetGameObject, text));
				result = 1;
			}
			return result;
		}

		[MonoPInvokeCallback(typeof(LuaCSFunction))]
		private static int find_wrap_list(IntPtr L)
		{
			int result = 0;
			if (WraperUtil.ValidIsUserdata(L, 1, string_find_wrap_list) && WraperUtil.ValidIsString(L, 2, string_find_wrap_list))
			{
				AssetGameObject assetGameObject = null;
				string text = null;
				assetGameObject = WraperUtil.LuaToUserdata(L, 1, string_find_wrap_list, AssetGameObject.cache);
				text = LuaDLL.lua_tostring(L, 2);
				WraperUtil.PushObject(L, NGUIWrap.Find<NGUIWrapListWrap, UIWrapList>(assetGameObject, text));
				result = 1;
			}
			return result;
		}

		[MonoPInvokeCallback(typeof(LuaCSFunction))]
		private static int find_center_child(IntPtr L)
		{
			int result = 0;
			if (WraperUtil.ValidIsUserdata(L, 1, string_find_center_child) && WraperUtil.ValidIsString(L, 2, string_find_center_child))
			{
				AssetGameObject assetGameObject = null;
				string text = null;
				assetGameObject = WraperUtil.LuaToUserdata(L, 1, string_find_center_child, AssetGameObject.cache);
				text = LuaDLL.lua_tostring(L, 2);
				WraperUtil.PushObject(L, NGUIWrap.Find<NGUICenterOnChildWrap, UICenterOnChild>(assetGameObject, text));
				result = 1;
			}
			return result;
		}

		[MonoPInvokeCallback(typeof(LuaCSFunction))]
		private static int find_scroll_view(IntPtr L)
		{
			int result = 0;
			if (WraperUtil.ValidIsUserdata(L, 1, string_find_scroll_view) && WraperUtil.ValidIsString(L, 2, string_find_scroll_view))
			{
				AssetGameObject assetGameObject = null;
				string text = null;
				assetGameObject = WraperUtil.LuaToUserdata(L, 1, string_find_scroll_view, AssetGameObject.cache);
				text = LuaDLL.lua_tostring(L, 2);
				WraperUtil.PushObject(L, NGUIWrap.Find<NGUIScrollViewWrap, UIScrollView>(assetGameObject, text));
				result = 1;
			}
			return result;
		}

		[MonoPInvokeCallback(typeof(LuaCSFunction))]
		private static int find_panel(IntPtr L)
		{
			int result = 0;
			if (WraperUtil.ValidIsUserdata(L, 1, string_find_panel) && WraperUtil.ValidIsString(L, 2, string_find_panel))
			{
				AssetGameObject assetGameObject = null;
				string text = null;
				assetGameObject = WraperUtil.LuaToUserdata(L, 1, string_find_panel, AssetGameObject.cache);
				text = LuaDLL.lua_tostring(L, 2);
				WraperUtil.PushObject(L, NGUIWrap.Find<NGUIPanelWrap, UIPanel>(assetGameObject, text));
				result = 1;
			}
			return result;
		}

		[MonoPInvokeCallback(typeof(LuaCSFunction))]
		private static int find_table(IntPtr L)
		{
			int result = 0;
			if (WraperUtil.ValidIsUserdata(L, 1, string_find_table) && WraperUtil.ValidIsString(L, 2, string_find_table))
			{
				AssetGameObject assetGameObject = null;
				string text = null;
				assetGameObject = WraperUtil.LuaToUserdata(L, 1, string_find_table, AssetGameObject.cache);
				text = LuaDLL.lua_tostring(L, 2);
				WraperUtil.PushObject(L, NGUIWrap.Find<NGUITableWrap, UITable>(assetGameObject, text));
				result = 1;
			}
			return result;
		}

		[MonoPInvokeCallback(typeof(LuaCSFunction))]
		private static int raycast(IntPtr L)
		{
			int result = 0;
			if (WraperUtil.ValidIsNumber(L, 1, string_raycast) && WraperUtil.ValidIsNumber(L, 2, string_raycast) && WraperUtil.ValidIsNumber(L, 3, string_raycast))
			{
				float num = 0f;
				float num2 = 0f;
				float num3 = 0f;
				num = (float)LuaDLL.lua_tonumber(L, 1);
				num2 = (float)LuaDLL.lua_tonumber(L, 2);
				num3 = (float)LuaDLL.lua_tonumber(L, 3);
				LuaDLL.lua_pushboolean(L, UICamera.Raycast(new Vector3(num, num2, num3)));
				result = 1;
			}
			return result;
		}

		[MonoPInvokeCallback(typeof(LuaCSFunction))]
		private static int find_widget(IntPtr L)
		{
			int result = 0;
			if (WraperUtil.ValidIsUserdata(L, 1, string_find_table) && WraperUtil.ValidIsString(L, 2, string_find_table))
			{
				AssetGameObject assetGameObject = null;
				string text = null;
				assetGameObject = WraperUtil.LuaToUserdata(L, 1, string_find_widget, AssetGameObject.cache);
				text = LuaDLL.lua_tostring(L, 2);
				WraperUtil.PushObject(L, NGUIWrap.Find<NGUIWidgetWrap, UIWidget>(assetGameObject, text));
				result = 1;
			}
			return result;
		}

		[MonoPInvokeCallback(typeof(LuaCSFunction))]
		private static int find_enchance_scroll_view(IntPtr L)
		{
			int result = 0;
			if (WraperUtil.ValidIsUserdata(L, 1, string_find_enchance_scroll_view) && WraperUtil.ValidIsString(L, 2, string_find_enchance_scroll_view))
			{
				AssetGameObject assetGameObject = null;
				string text = null;
				assetGameObject = WraperUtil.LuaToUserdata(L, 1, string_find_enchance_scroll_view, AssetGameObject.cache);
				text = LuaDLL.lua_tostring(L, 2);
				WraperUtil.PushObject(L, NGUIWrap.Find<NGUIEnchanceScrollViewWrap, EnchanceScollView>(assetGameObject, text));
				result = 1;
			}
			return result;
		}

		[MonoPInvokeCallback(typeof(LuaCSFunction))]
		private static int find_bezierpathspline(IntPtr L)
		{
			int result = 0;
			if (WraperUtil.ValidIsUserdata(L, 1, string_find_bezierpathspline) && WraperUtil.ValidIsString(L, 2, string_find_bezierpathspline))
			{
				AssetGameObject assetGameObject = null;
				string text = null;
				assetGameObject = WraperUtil.LuaToUserdata(L, 1, string_find_bezierpathspline, AssetGameObject.cache);
				text = LuaDLL.lua_tostring(L, 2);
				WraperUtil.PushObject(L, NGUIWrap.Find<NGUIBezierPathSplineWrap, BezierPathSpline>(assetGameObject, text));
				result = 1;
			}
			return result;
		}

		[MonoPInvokeCallback(typeof(LuaCSFunction))]
		private static int find_sprite_animation(IntPtr L)
		{
			int result = 0;
			if (WraperUtil.ValidIsUserdata(L, 1, string_find_sprite_animation) && WraperUtil.ValidIsString(L, 2, string_find_sprite_animation))
			{
				AssetGameObject assetGameObject = null;
				string text = null;
				assetGameObject = WraperUtil.LuaToUserdata(L, 1, string_find_sprite_animation, AssetGameObject.cache);
				text = LuaDLL.lua_tostring(L, 2);
				WraperUtil.PushObject(L, NGUIWrap.Find<NGUISpriteAnimationWrap, UISpriteAnimation>(assetGameObject, text));
				result = 1;
			}
			return result;
		}
	}
}
