using System;
using LuaInterface;
using UnityEngine;
using UnityWrap;

namespace Wraper
{
	public class ngui_font_wraper
	{
		public static string name = "ngui_font";

		public static string libname = "ngui_font";

		private static luaL_Reg[] libfunc = new luaL_Reg[1]
		{
			new luaL_Reg("create_by_asset", create_by_asset)
		};

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
			new luaL_Reg("set_dynamic_font", set_dynamic_font)
		};

		private static string string_create_by_asset = "ngui_font.create_by_asset";

		private static string string_get_pid = "ngui_font:get_pid";

		private static string string_set_active = "ngui_font:set_active";

		private static string string_set_name = "ngui_font:set_name";

		private static string string_get_name = "ngui_font:get_name";

		private static string string_set_position = "ngui_font:set_position";

		private static string string_get_position = "ngui_font:get_position";

		private static string string_get_size = "ngui_font:get_size";

		private static string string_get_game_object = "ngui_font:get_game_object";

		private static string string_get_parent = "ngui_font:get_parent";

		private static string string_set_parent = "ngui_font:set_parent";

		private static string string_clone = "ngui_font:clone";

		private static string string_destroy_object = "ngui_font:destroy_object";

		private static string string_set_dynamic_font = "ngui_font:set_dynamic_font";

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

		public static void push(IntPtr L, NGUIFontWrap obj)
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
		private static int create_by_asset(IntPtr L)
		{
			int result = 0;
			if (WraperUtil.ValidIsUserdata(L, 1, string_create_by_asset) && WraperUtil.ValidIsBoolean(L, 2, string_create_by_asset))
			{
				AssetObject assetObject = null;
				bool flag = false;
				assetObject = WraperUtil.LuaToUserdata(L, 1, string_create_by_asset, AssetObject.cache);
				flag = LuaDLL.lua_toboolean(L, 2);
				NGUIFontWrap base_object = NGUIFontWrap.CreateByAssetObject(assetObject, flag);
				WraperUtil.PushObject(L, base_object);
				result = 1;
			}
			return result;
		}

		[MonoPInvokeCallback(typeof(LuaCSFunction))]
		private static int get_pid(IntPtr L)
		{
			int result = 0;
			if (WraperUtil.ValidIsUserdata(L, 1, string_get_pid))
			{
				NGUIFontWrap nGUIFontWrap = null;
				nGUIFontWrap = WraperUtil.LuaToUserdata(L, 1, string_get_pid, NGUIFontWrap.cache);
				LuaDLL.lua_pushnumber(L, nGUIFontWrap.GetPid());
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
				NGUIFontWrap nGUIFontWrap = null;
				bool flag = false;
				nGUIFontWrap = WraperUtil.LuaToUserdata(L, 1, string_set_active, NGUIFontWrap.cache);
				flag = LuaDLL.lua_toboolean(L, 2);
				nGUIFontWrap.bcomponent.gameObject.SetActive(flag);
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
				NGUIFontWrap nGUIFontWrap = null;
				string text = null;
				nGUIFontWrap = WraperUtil.LuaToUserdata(L, 1, string_set_name, NGUIFontWrap.cache);
				text = LuaDLL.lua_tostring(L, 2);
				nGUIFontWrap.bcomponent.gameObject.name = text;
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
				NGUIFontWrap nGUIFontWrap = null;
				nGUIFontWrap = WraperUtil.LuaToUserdata(L, 1, string_get_name, NGUIFontWrap.cache);
				LuaDLL.lua_pushstring(L, nGUIFontWrap.bcomponent.gameObject.name);
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
				NGUIFontWrap nGUIFontWrap = null;
				float num = 0f;
				float num2 = 0f;
				float num3 = 0f;
				nGUIFontWrap = WraperUtil.LuaToUserdata(L, 1, string_set_position, NGUIFontWrap.cache);
				num = (float)LuaDLL.lua_tonumber(L, 2);
				num2 = (float)LuaDLL.lua_tonumber(L, 3);
				num3 = (float)LuaDLL.lua_tonumber(L, 4);
				nGUIFontWrap.bcomponent.gameObject.transform.localPosition = new Vector3(num, num2, num3);
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
				NGUIFontWrap nGUIFontWrap = null;
				nGUIFontWrap = WraperUtil.LuaToUserdata(L, 1, string_get_position, NGUIFontWrap.cache);
				Vector3 localPosition = nGUIFontWrap.bcomponent.gameObject.transform.localPosition;
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
				NGUIFontWrap nGUIFontWrap = null;
				nGUIFontWrap = WraperUtil.LuaToUserdata(L, 1, string_get_size, NGUIFontWrap.cache);
				int num = ((!(nGUIFontWrap.widget == null)) ? nGUIFontWrap.widget.width : 0);
				int num2 = ((!(nGUIFontWrap.widget == null)) ? nGUIFontWrap.widget.height : 0);
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
				NGUIFontWrap nGUIFontWrap = null;
				nGUIFontWrap = WraperUtil.LuaToUserdata(L, 1, string_get_game_object, NGUIFontWrap.cache);
				AssetGameObject base_object = AssetGameObject.CreateByInstance(nGUIFontWrap.bcomponent.gameObject);
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
				NGUIFontWrap nGUIFontWrap = null;
				nGUIFontWrap = WraperUtil.LuaToUserdata(L, 1, string_get_parent, NGUIFontWrap.cache);
				AssetGameObject assetGameObject = null;
				Transform parent = nGUIFontWrap.bcomponent.gameObject.transform.parent;
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
				NGUIFontWrap nGUIFontWrap = null;
				AssetGameObject assetGameObject = null;
				nGUIFontWrap = WraperUtil.LuaToUserdata(L, 1, string_set_parent, NGUIFontWrap.cache);
				assetGameObject = WraperUtil.LuaToUserdataOrNil(L, 2, string_set_parent, AssetGameObject.cache);
				nGUIFontWrap.bcomponent.gameObject.transform.parent = ((assetGameObject != null) ? assetGameObject.transform : null);
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
				NGUIFontWrap nGUIFontWrap = null;
				nGUIFontWrap = WraperUtil.LuaToUserdata(L, 1, string_clone, NGUIFontWrap.cache);
				nGUIFontWrap.Clone(L);
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
				NGUIFontWrap nGUIFontWrap = null;
				nGUIFontWrap = WraperUtil.LuaToUserdata(L, 1, string_destroy_object, NGUIFontWrap.cache);
				nGUIFontWrap.isNeedDestroy = true;
				result = 0;
			}
			return result;
		}

		[MonoPInvokeCallback(typeof(LuaCSFunction))]
		private static int set_dynamic_font(IntPtr L)
		{
			int result = 0;
			if (WraperUtil.ValidIsUserdata(L, 1, string_set_dynamic_font) && WraperUtil.ValidIsUserdata(L, 2, string_set_dynamic_font))
			{
				NGUIFontWrap nGUIFontWrap = null;
				FontWrap fontWrap = null;
				nGUIFontWrap = WraperUtil.LuaToUserdata(L, 1, string_set_dynamic_font, NGUIFontWrap.cache);
				fontWrap = WraperUtil.LuaToUserdata(L, 2, string_set_dynamic_font, FontWrap.cache);
				nGUIFontWrap.component.dynamicFont = fontWrap.component;
				result = 0;
			}
			return result;
		}

		[MonoPInvokeCallback(typeof(LuaCSFunction))]
		private static int gc(IntPtr L)
		{
			NGUIFontWrap nGUIFontWrap = WraperUtil.LuaToUserdataByGc(L, 1, "gc ngui_font", NGUIFontWrap.cache);
			if (nGUIFontWrap != null)
			{
				nGUIFontWrap.DestroyInstance();
			}
			return 0;
		}
	}
}
