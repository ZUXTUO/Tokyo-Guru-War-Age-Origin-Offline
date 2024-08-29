using System;
using LuaInterface;
using UnityEngine;
using UnityWrap;

namespace Wraper
{
	public class hud_text_wraper
	{
		public static string name = "hud_text_object";

		public static string libname = "hud_text";

		private static luaL_Reg[] libfunc = new luaL_Reg[1]
		{
			new luaL_Reg("reg_hud_type", reg_hud_type)
		};

		private static luaL_Reg[] func = new luaL_Reg[5]
		{
			new luaL_Reg("get_pid", get_pid),
			new luaL_Reg("add", add_hud),
			new luaL_Reg("set_position", set_position),
			new luaL_Reg("set_name", set_name),
			new luaL_Reg("set_property", set_property)
		};

		private static string string_reg_hud_type = "hud_text.reg_hud_type";

		private static string string_get_pid = "hud_text:get_pid";

		private static string string_add = "hud_text:add";

		private static string string_set_position = "hud_text:set_position";

		private static string string_set_name = "hud_text:set_name";

		private static string string_set_property = "hud_text:set_property";

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

		public static void push(IntPtr L, HudTextWrap obj)
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
			if (!WraperUtil.ValidIsUserdata(L, 1, string_get_pid))
			{
			}
			return result;
		}

		[MonoPInvokeCallback(typeof(LuaCSFunction))]
		private static int add_hud(IntPtr L)
		{
			int result = 0;
			if (WraperUtil.ValidIsUserdata(L, 1, string_add) && WraperUtil.ValidIsNumber(L, 2, string_add) && WraperUtil.ValidIsNumber(L, 3, string_add))
			{
				HudTextWrap hudTextWrap = WraperUtil.LuaToUserdata(L, 1, string_add, HudTextWrap.cache);
				if (hudTextWrap != null && hudTextWrap.HudText != null)
				{
					int num = (int)LuaDLL.lua_tonumber(L, 2);
					int hTypeId = (int)LuaDLL.lua_tonumber(L, 3);
					HUDText hudText = hudTextWrap.HudText;
					Color c = ((num <= 0) ? Color.white : Color.green);
					hudTextWrap.HudText.HTypeId = hTypeId;
					hudTextWrap.HudText.Add(num, c, 0.2f);
				}
			}
			return result;
		}

		[MonoPInvokeCallback(typeof(LuaCSFunction))]
		private static int set_position(IntPtr L)
		{
			int result = 0;
			if (WraperUtil.ValidIsUserdata(L, 1, string_set_position) && WraperUtil.ValidIsNumber(L, 2, string_set_position) && WraperUtil.ValidIsNumber(L, 3, string_set_position) && WraperUtil.ValidIsNumber(L, 4, string_set_position))
			{
				HudTextWrap hudTextWrap = null;
				float num = 0f;
				float num2 = 0f;
				float num3 = 0f;
				hudTextWrap = WraperUtil.LuaToUserdata(L, 1, string_set_position, HudTextWrap.cache);
				num = (float)LuaDLL.lua_tonumber(L, 2);
				num2 = (float)LuaDLL.lua_tonumber(L, 3);
				num3 = (float)LuaDLL.lua_tonumber(L, 4);
				if (hudTextWrap != null && hudTextWrap.HudText != null)
				{
					hudTextWrap.HudText.transform.position = new Vector3(num, num2, num3);
				}
			}
			return result;
		}

		[MonoPInvokeCallback(typeof(LuaCSFunction))]
		private static int set_name(IntPtr L)
		{
			int result = 0;
			if (WraperUtil.ValidIsUserdata(L, 1, string_set_name) && WraperUtil.ValidIsString(L, 2, string_set_name))
			{
				string text = LuaDLL.lua_tostring(L, 2);
				HudTextWrap hudTextWrap = WraperUtil.LuaToUserdata(L, 1, string_set_name, HudTextWrap.cache);
				if (hudTextWrap != null && hudTextWrap.HudText != null)
				{
					hudTextWrap.HudText.transform.name = text;
				}
			}
			return result;
		}

		[MonoPInvokeCallback(typeof(LuaCSFunction))]
		private static int reg_hud_type(IntPtr L)
		{
			int result = 0;
			if (WraperUtil.ValidIsNumber(L, 1, string_reg_hud_type) && WraperUtil.ValidIsNumber(L, 2, string_reg_hud_type) && WraperUtil.ValidIsBoolean(L, 3, string_reg_hud_type) && WraperUtil.ValidIsString(L, 4, string_reg_hud_type) && WraperUtil.ValidIsString(L, 5, string_reg_hud_type) && WraperUtil.ValidIsNumber(L, 6, string_reg_hud_type) && WraperUtil.ValidIsString(L, 7, string_reg_hud_type))
			{
				int id = (int)LuaDLL.lua_tonumber(L, 1);
				int fontSize = (int)LuaDLL.lua_tonumber(L, 2);
				bool applyGradient = LuaDLL.lua_toboolean(L, 3);
				string htmlString = LuaDLL.lua_tostring(L, 4);
				string htmlString2 = LuaDLL.lua_tostring(L, 5);
				UILabel.Effect effectStyle = (UILabel.Effect)LuaDLL.lua_tonumber(L, 6);
				string htmlString3 = LuaDLL.lua_tostring(L, 7);
				Color color;
				ColorUtility.TryParseHtmlString(htmlString, out color);
				Color color2;
				ColorUtility.TryParseHtmlString(htmlString2, out color2);
				Color color3;
				ColorUtility.TryParseHtmlString(htmlString3, out color3);
				HUDText.RegHudType(id, new HUDText.HudType
				{
					applyGradient = applyGradient,
					effectColor = color3,
					effectStyle = effectStyle,
					fontSize = fontSize,
					gradientBottom = color2,
					gradientTop = color
				});
			}
			return result;
		}

		[Obsolete("use reg_hud_type and add intead")]
		[MonoPInvokeCallback(typeof(LuaCSFunction))]
		private static int set_property(IntPtr L)
		{
			int result = 0;
			if (WraperUtil.ValidIsUserdata(L, 1, string_set_property) && WraperUtil.ValidIsNumber(L, 2, string_set_property) && WraperUtil.ValidIsBoolean(L, 3, string_set_property) && WraperUtil.ValidIsString(L, 4, string_set_property) && WraperUtil.ValidIsString(L, 5, string_set_property) && WraperUtil.ValidIsNumber(L, 6, string_set_property) && WraperUtil.ValidIsString(L, 7, string_set_property) && WraperUtil.ValidIsBoolean(L, 8, string_set_property))
			{
				HudTextWrap hudTextWrap = WraperUtil.LuaToUserdata(L, 1, string_add, HudTextWrap.cache);
				if (hudTextWrap != null && hudTextWrap.HudText != null)
				{
					int fontSize = (int)LuaDLL.lua_tonumber(L, 2);
					bool applyGradient = LuaDLL.lua_toboolean(L, 3);
					string htmlString = LuaDLL.lua_tostring(L, 4);
					string htmlString2 = LuaDLL.lua_tostring(L, 5);
					UILabel.Effect effect = (UILabel.Effect)LuaDLL.lua_tonumber(L, 6);
					string htmlString3 = LuaDLL.lua_tostring(L, 7);
					bool flag = LuaDLL.lua_toboolean(L, 8);
					Color color;
					ColorUtility.TryParseHtmlString(htmlString, out color);
					Color color2;
					ColorUtility.TryParseHtmlString(htmlString2, out color2);
					Color color3;
					ColorUtility.TryParseHtmlString(htmlString3, out color3);
					hudTextWrap.HudText.fontSize = fontSize;
					hudTextWrap.HudText.applyGradient = applyGradient;
					hudTextWrap.HudText.gradientTop = color;
					hudTextWrap.HudText.gradienBottom = color2;
					hudTextWrap.HudText.effect = effect;
					hudTextWrap.HudText.effectColor = color3;
					hudTextWrap.HudText.ChangeLisEntryProperty();
				}
			}
			return result;
		}

		[MonoPInvokeCallback(typeof(LuaCSFunction))]
		private static int gc(IntPtr L)
		{
			HudTextWrap hudTextWrap = WraperUtil.LuaToUserdataByGc(L, 1, "gc hud_text_object", HudTextWrap.cache);
			if (hudTextWrap != null)
			{
				hudTextWrap.DestroyInstance();
			}
			return 0;
		}
	}
}
