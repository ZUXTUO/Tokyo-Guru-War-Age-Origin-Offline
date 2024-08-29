using System;
using LuaInterface;
using UnityEngine;
using UnityWrap;

namespace Wraper
{
	public class ngui_center_child_wraper
	{
		public static string name = "ngui_center_child";

		private static luaL_Reg[] func = new luaL_Reg[15]
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
			new luaL_Reg("set_on_center_item", set_on_center_item),
			new luaL_Reg("recenter", recenter),
			new luaL_Reg("center_on", center_on)
		};

		private static string string_get_pid = "ngui_center_child:get_pid";

		private static string string_set_active = "ngui_center_child:set_active";

		private static string string_set_name = "ngui_center_child:set_name";

		private static string string_get_name = "ngui_center_child:get_name";

		private static string string_set_position = "ngui_center_child:set_position";

		private static string string_get_position = "ngui_center_child:get_position";

		private static string string_get_size = "ngui_center_child:get_size";

		private static string string_get_game_object = "ngui_center_child:get_game_object";

		private static string string_get_parent = "ngui_center_child:get_parent";

		private static string string_set_parent = "ngui_center_child:set_parent";

		private static string string_clone = "ngui_center_child:clone";

		private static string string_destroy_object = "ngui_center_child:destroy_object";

		private static string string_set_on_center_item = "ngui_center_child:set_on_center_item";

		private static string string_recenter = "ngui_center_child:recenter";

		private static string string_center_on = "ngui_center_child:center_on";

		public static bool init(IntPtr L)
		{
			if (L != IntPtr.Zero)
			{
				LuaDLL.register_class(L, name, func, gc);
				return true;
			}
			return false;
		}

		public static void push(IntPtr L, NGUICenterOnChildWrap obj)
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
				NGUICenterOnChildWrap nGUICenterOnChildWrap = null;
				nGUICenterOnChildWrap = WraperUtil.LuaToUserdata(L, 1, string_get_pid, NGUICenterOnChildWrap.cache);
				LuaDLL.lua_pushnumber(L, nGUICenterOnChildWrap.GetPid());
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
				NGUICenterOnChildWrap nGUICenterOnChildWrap = null;
				bool flag = false;
				nGUICenterOnChildWrap = WraperUtil.LuaToUserdata(L, 1, string_set_active, NGUICenterOnChildWrap.cache);
				flag = LuaDLL.lua_toboolean(L, 2);
				nGUICenterOnChildWrap.bcomponent.gameObject.SetActive(flag);
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
				NGUICenterOnChildWrap nGUICenterOnChildWrap = null;
				string text = null;
				nGUICenterOnChildWrap = WraperUtil.LuaToUserdata(L, 1, string_set_name, NGUICenterOnChildWrap.cache);
				text = LuaDLL.lua_tostring(L, 2);
				nGUICenterOnChildWrap.bcomponent.gameObject.name = text;
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
				NGUICenterOnChildWrap nGUICenterOnChildWrap = null;
				nGUICenterOnChildWrap = WraperUtil.LuaToUserdata(L, 1, string_get_name, NGUICenterOnChildWrap.cache);
				LuaDLL.lua_pushstring(L, nGUICenterOnChildWrap.bcomponent.gameObject.name);
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
				NGUICenterOnChildWrap nGUICenterOnChildWrap = null;
				float num = 0f;
				float num2 = 0f;
				float num3 = 0f;
				nGUICenterOnChildWrap = WraperUtil.LuaToUserdata(L, 1, string_set_position, NGUICenterOnChildWrap.cache);
				num = (float)LuaDLL.lua_tonumber(L, 2);
				num2 = (float)LuaDLL.lua_tonumber(L, 3);
				num3 = (float)LuaDLL.lua_tonumber(L, 4);
				nGUICenterOnChildWrap.bcomponent.gameObject.transform.localPosition = new Vector3(num, num2, num3);
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
				NGUICenterOnChildWrap nGUICenterOnChildWrap = null;
				nGUICenterOnChildWrap = WraperUtil.LuaToUserdata(L, 1, string_get_position, NGUICenterOnChildWrap.cache);
				Vector3 localPosition = nGUICenterOnChildWrap.bcomponent.gameObject.transform.localPosition;
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
				NGUICenterOnChildWrap nGUICenterOnChildWrap = null;
				nGUICenterOnChildWrap = WraperUtil.LuaToUserdata(L, 1, string_get_size, NGUICenterOnChildWrap.cache);
				int num = ((!(nGUICenterOnChildWrap.widget == null)) ? nGUICenterOnChildWrap.widget.width : 0);
				int num2 = ((!(nGUICenterOnChildWrap.widget == null)) ? nGUICenterOnChildWrap.widget.height : 0);
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
				NGUICenterOnChildWrap nGUICenterOnChildWrap = null;
				nGUICenterOnChildWrap = WraperUtil.LuaToUserdata(L, 1, string_get_game_object, NGUICenterOnChildWrap.cache);
				AssetGameObject base_object = AssetGameObject.CreateByInstance(nGUICenterOnChildWrap.bcomponent.gameObject);
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
				NGUICenterOnChildWrap nGUICenterOnChildWrap = null;
				nGUICenterOnChildWrap = WraperUtil.LuaToUserdata(L, 1, string_get_parent, NGUICenterOnChildWrap.cache);
				AssetGameObject assetGameObject = null;
				Transform parent = nGUICenterOnChildWrap.bcomponent.gameObject.transform.parent;
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
				NGUICenterOnChildWrap nGUICenterOnChildWrap = null;
				AssetGameObject assetGameObject = null;
				nGUICenterOnChildWrap = WraperUtil.LuaToUserdata(L, 1, string_set_parent, NGUICenterOnChildWrap.cache);
				assetGameObject = WraperUtil.LuaToUserdataOrNil(L, 2, string_set_parent, AssetGameObject.cache);
				nGUICenterOnChildWrap.bcomponent.gameObject.transform.parent = ((assetGameObject != null) ? assetGameObject.transform : null);
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
				NGUICenterOnChildWrap nGUICenterOnChildWrap = null;
				nGUICenterOnChildWrap = WraperUtil.LuaToUserdata(L, 1, string_clone, NGUICenterOnChildWrap.cache);
				nGUICenterOnChildWrap.Clone(L);
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
				NGUICenterOnChildWrap nGUICenterOnChildWrap = null;
				nGUICenterOnChildWrap = WraperUtil.LuaToUserdata(L, 1, string_destroy_object, NGUICenterOnChildWrap.cache);
				nGUICenterOnChildWrap.isNeedDestroy = true;
				result = 0;
			}
			return result;
		}

		[MonoPInvokeCallback(typeof(LuaCSFunction))]
		private static int set_on_center_item(IntPtr L)
		{
			int result = 0;
			if (WraperUtil.ValidIsUserdata(L, 1, string_set_on_center_item) && WraperUtil.ValidIsString(L, 2, string_set_on_center_item))
			{
				NGUICenterOnChildWrap nGUICenterOnChildWrap = null;
				string text = null;
				nGUICenterOnChildWrap = WraperUtil.LuaToUserdata(L, 1, string_set_on_center_item, NGUICenterOnChildWrap.cache);
				text = LuaDLL.lua_tostring(L, 2);
				nGUICenterOnChildWrap.onCenterItem = text;
				result = 0;
			}
			return result;
		}

		[MonoPInvokeCallback(typeof(LuaCSFunction))]
		private static int recenter(IntPtr L)
		{
			int result = 0;
			if (WraperUtil.ValidIsUserdata(L, 1, string_recenter))
			{
				NGUICenterOnChildWrap nGUICenterOnChildWrap = null;
				nGUICenterOnChildWrap = WraperUtil.LuaToUserdata(L, 1, string_recenter, NGUICenterOnChildWrap.cache);
				nGUICenterOnChildWrap.component.Recenter();
				result = 0;
			}
			return result;
		}

		[MonoPInvokeCallback(typeof(LuaCSFunction))]
		private static int center_on(IntPtr L)
		{
			int result = 0;
			if (WraperUtil.ValidIsUserdata(L, 1, string_center_on) && WraperUtil.ValidIsUserdata(L, 2, string_center_on))
			{
				NGUICenterOnChildWrap nGUICenterOnChildWrap = null;
				AssetGameObject assetGameObject = null;
				nGUICenterOnChildWrap = WraperUtil.LuaToUserdata(L, 1, string_center_on, NGUICenterOnChildWrap.cache);
				assetGameObject = WraperUtil.LuaToUserdata(L, 2, string_center_on, AssetGameObject.cache);
				nGUICenterOnChildWrap.component.CenterOn(assetGameObject.transform);
				result = 0;
			}
			return result;
		}

		[MonoPInvokeCallback(typeof(LuaCSFunction))]
		private static int gc(IntPtr L)
		{
			NGUICenterOnChildWrap nGUICenterOnChildWrap = WraperUtil.LuaToUserdataByGc(L, 1, "gc ngui_center_child", NGUICenterOnChildWrap.cache);
			if (nGUICenterOnChildWrap != null)
			{
				nGUICenterOnChildWrap.DestroyInstance();
			}
			return 0;
		}
	}
}
