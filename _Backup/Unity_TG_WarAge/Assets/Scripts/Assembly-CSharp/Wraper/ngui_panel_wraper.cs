using System;
using System.Collections.Generic;
using LuaInterface;
using UnityEngine;
using UnityWrap;

namespace Wraper
{
	public class ngui_panel_wraper
	{
		public static string name = "ngui_panel";

		private static luaL_Reg[] func = new luaL_Reg[25]
		{
			new luaL_Reg("get_pid", get_pid),
			new luaL_Reg("set_active", set_active),
			new luaL_Reg("set_enable", set_enable),
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
			new luaL_Reg("set_alpha", set_alpha),
			new luaL_Reg("get_alpha", get_alpha),
			new luaL_Reg("set_range", set_range),
			new luaL_Reg("get_range", get_range),
			new luaL_Reg("set_center", set_center),
			new luaL_Reg("get_center", get_center),
			new luaL_Reg("calculate_constrain_offset", calculate_constrain_offset),
			new luaL_Reg("set_depth", set_depth),
			new luaL_Reg("get_depth", get_depth),
			new luaL_Reg("set_clip_offset", set_clip_offset),
			new luaL_Reg("get_child_hud_text", get_child_hud_text),
			new luaL_Reg("set_onResize", set_onResize)
		};

		private static string string_get_pid = "ngui_panel:get_pid";

		private static string string_set_active = "ngui_panel:set_active";

		private static string string_set_enable = "ngui_panel:set_enable";

		private static string string_set_name = "ngui_panel:set_name";

		private static string string_get_name = "ngui_panel:get_name";

		private static string string_set_position = "ngui_panel:set_position";

		private static string string_get_position = "ngui_panel:get_position";

		private static string string_get_size = "ngui_panel:get_size";

		private static string string_get_game_object = "ngui_panel:get_game_object";

		private static string string_get_parent = "ngui_panel:get_parent";

		private static string string_set_parent = "ngui_panel:set_parent";

		private static string string_clone = "ngui_panel:clone";

		private static string string_destroy_object = "ngui_panel:destroy_object";

		private static string string_set_alpha = "ngui_panel:set_alpha";

		private static string string_get_alpha = "ngui_panel:get_alpha";

		private static string string_set_range = "ngui_panel:set_range";

		private static string string_get_range = "ngui_panel:get_range";

		private static string string_set_center = "ngui_panel:set_center";

		private static string string_get_center = "ngui_panel:get_center";

		private static string string_calculate_constrain_offset = "ngui_panel:calculate_constrain_offset";

		private static string string_set_depth = "ngui_panel:set_depth";

		private static string string_get_depth = "ngui_panel:get_depth";

		private static string string_set_clip_offset = "ngui_panel:set_clip_offset";

		private static string string_get_child_hud_text = "ngui_panel:get_child_hud_text";

		private static string string_set_onResize = "ngui_panel:set_onResize";

		public static bool init(IntPtr L)
		{
			if (L != IntPtr.Zero)
			{
				LuaDLL.register_class(L, name, func, gc);
				return true;
			}
			return false;
		}

		public static void push(IntPtr L, NGUIPanelWrap obj)
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
				NGUIPanelWrap nGUIPanelWrap = null;
				nGUIPanelWrap = WraperUtil.LuaToUserdata(L, 1, string_get_pid, NGUIPanelWrap.cache);
				LuaDLL.lua_pushnumber(L, nGUIPanelWrap.GetPid());
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
				NGUIPanelWrap nGUIPanelWrap = null;
				bool flag = false;
				nGUIPanelWrap = WraperUtil.LuaToUserdata(L, 1, string_set_active, NGUIPanelWrap.cache);
				flag = LuaDLL.lua_toboolean(L, 2);
				nGUIPanelWrap.bcomponent.gameObject.SetActive(flag);
				result = 0;
			}
			return result;
		}

		[MonoPInvokeCallback(typeof(LuaCSFunction))]
		private static int set_enable(IntPtr L)
		{
			int result = 0;
			if (WraperUtil.ValidIsUserdata(L, 1, string_set_active) && WraperUtil.ValidIsBoolean(L, 2, string_set_active))
			{
				NGUIPanelWrap nGUIPanelWrap = null;
				bool flag = false;
				nGUIPanelWrap = WraperUtil.LuaToUserdata(L, 1, string_set_active, NGUIPanelWrap.cache);
				flag = LuaDLL.lua_toboolean(L, 2);
				UIPanel[] componentsInChildren = nGUIPanelWrap.component.GetComponentsInChildren<UIPanel>();
				BoxCollider[] componentsInChildren2 = nGUIPanelWrap.component.GetComponentsInChildren<BoxCollider>();
				int num = 0;
				for (num = 0; num < componentsInChildren.Length; num++)
				{
					componentsInChildren[num].enabled = flag;
				}
				for (num = 0; num < componentsInChildren2.Length; num++)
				{
					componentsInChildren2[num].enabled = flag;
				}
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
				NGUIPanelWrap nGUIPanelWrap = null;
				string text = null;
				nGUIPanelWrap = WraperUtil.LuaToUserdata(L, 1, string_set_name, NGUIPanelWrap.cache);
				text = LuaDLL.lua_tostring(L, 2);
				nGUIPanelWrap.bcomponent.gameObject.name = text;
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
				NGUIPanelWrap nGUIPanelWrap = null;
				nGUIPanelWrap = WraperUtil.LuaToUserdata(L, 1, string_get_name, NGUIPanelWrap.cache);
				LuaDLL.lua_pushstring(L, nGUIPanelWrap.bcomponent.gameObject.name);
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
				NGUIPanelWrap nGUIPanelWrap = null;
				float num = 0f;
				float num2 = 0f;
				float num3 = 0f;
				nGUIPanelWrap = WraperUtil.LuaToUserdata(L, 1, string_set_position, NGUIPanelWrap.cache);
				num = (float)LuaDLL.lua_tonumber(L, 2);
				num2 = (float)LuaDLL.lua_tonumber(L, 3);
				num3 = (float)LuaDLL.lua_tonumber(L, 4);
				nGUIPanelWrap.bcomponent.gameObject.transform.localPosition = new Vector3(num, num2, num3);
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
				NGUIPanelWrap nGUIPanelWrap = null;
				nGUIPanelWrap = WraperUtil.LuaToUserdata(L, 1, string_get_position, NGUIPanelWrap.cache);
				Vector3 localPosition = nGUIPanelWrap.bcomponent.gameObject.transform.localPosition;
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
				NGUIPanelWrap nGUIPanelWrap = null;
				nGUIPanelWrap = WraperUtil.LuaToUserdata(L, 1, string_get_size, NGUIPanelWrap.cache);
				float num = ((!(nGUIPanelWrap.widget == null)) ? nGUIPanelWrap.widget.width : 0);
				float num2 = ((!(nGUIPanelWrap.widget == null)) ? nGUIPanelWrap.widget.height : 0);
				float z = nGUIPanelWrap.component.finalClipRegion.z;
				float w = nGUIPanelWrap.component.finalClipRegion.w;
				LuaDLL.lua_pushnumber(L, num);
				LuaDLL.lua_pushnumber(L, num2);
				LuaDLL.lua_pushnumber(L, z);
				LuaDLL.lua_pushnumber(L, w);
				result = 4;
			}
			return result;
		}

		[MonoPInvokeCallback(typeof(LuaCSFunction))]
		private static int get_game_object(IntPtr L)
		{
			int result = 0;
			if (WraperUtil.ValidIsUserdata(L, 1, string_get_game_object))
			{
				NGUIPanelWrap nGUIPanelWrap = null;
				nGUIPanelWrap = WraperUtil.LuaToUserdata(L, 1, string_get_game_object, NGUIPanelWrap.cache);
				AssetGameObject base_object = AssetGameObject.CreateByInstance(nGUIPanelWrap.bcomponent.gameObject);
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
				NGUIPanelWrap nGUIPanelWrap = null;
				nGUIPanelWrap = WraperUtil.LuaToUserdata(L, 1, string_get_parent, NGUIPanelWrap.cache);
				AssetGameObject assetGameObject = null;
				Transform parent = nGUIPanelWrap.bcomponent.gameObject.transform.parent;
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
				NGUIPanelWrap nGUIPanelWrap = null;
				AssetGameObject assetGameObject = null;
				nGUIPanelWrap = WraperUtil.LuaToUserdata(L, 1, string_set_parent, NGUIPanelWrap.cache);
				assetGameObject = WraperUtil.LuaToUserdataOrNil(L, 2, string_set_parent, AssetGameObject.cache);
				nGUIPanelWrap.bcomponent.gameObject.transform.parent = ((assetGameObject != null) ? assetGameObject.transform : null);
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
				NGUIPanelWrap nGUIPanelWrap = null;
				nGUIPanelWrap = WraperUtil.LuaToUserdata(L, 1, string_clone, NGUIPanelWrap.cache);
				nGUIPanelWrap.Clone(L);
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
				NGUIPanelWrap nGUIPanelWrap = null;
				nGUIPanelWrap = WraperUtil.LuaToUserdata(L, 1, string_destroy_object, NGUIPanelWrap.cache);
				nGUIPanelWrap.isNeedDestroy = true;
				result = 0;
			}
			return result;
		}

		[MonoPInvokeCallback(typeof(LuaCSFunction))]
		private static int set_alpha(IntPtr L)
		{
			int result = 0;
			if (WraperUtil.ValidIsUserdata(L, 1, string_set_alpha) && WraperUtil.ValidIsNumber(L, 2, string_set_alpha))
			{
				NGUIPanelWrap nGUIPanelWrap = null;
				float num = 0f;
				nGUIPanelWrap = WraperUtil.LuaToUserdata(L, 1, string_set_alpha, NGUIPanelWrap.cache);
				num = (float)LuaDLL.lua_tonumber(L, 2);
				nGUIPanelWrap.component.alpha = num;
				result = 0;
			}
			return result;
		}

		[MonoPInvokeCallback(typeof(LuaCSFunction))]
		private static int get_alpha(IntPtr L)
		{
			int result = 0;
			if (WraperUtil.ValidIsUserdata(L, 1, string_get_alpha))
			{
				NGUIPanelWrap nGUIPanelWrap = null;
				nGUIPanelWrap = WraperUtil.LuaToUserdata(L, 1, string_get_alpha, NGUIPanelWrap.cache);
				LuaDLL.lua_pushnumber(L, nGUIPanelWrap.component.alpha);
				result = 1;
			}
			return result;
		}

		[MonoPInvokeCallback(typeof(LuaCSFunction))]
		private static int set_range(IntPtr L)
		{
			int result = 0;
			if (WraperUtil.ValidIsUserdata(L, 1, string_set_range) && WraperUtil.ValidIsNumber(L, 2, string_set_range) && WraperUtil.ValidIsNumber(L, 3, string_set_range))
			{
				NGUIPanelWrap nGUIPanelWrap = null;
				float num = 0f;
				float num2 = 0f;
				nGUIPanelWrap = WraperUtil.LuaToUserdata(L, 1, string_set_range, NGUIPanelWrap.cache);
				num = (float)LuaDLL.lua_tonumber(L, 2);
				num2 = (float)LuaDLL.lua_tonumber(L, 3);
				nGUIPanelWrap.component.baseClipRegion = new Vector4(nGUIPanelWrap.component.baseClipRegion.x, nGUIPanelWrap.component.baseClipRegion.y, num, num2);
				result = 0;
			}
			return result;
		}

		[MonoPInvokeCallback(typeof(LuaCSFunction))]
		private static int get_range(IntPtr L)
		{
			int result = 0;
			if (WraperUtil.ValidIsUserdata(L, 1, string_get_range))
			{
				NGUIPanelWrap nGUIPanelWrap = null;
				nGUIPanelWrap = WraperUtil.LuaToUserdata(L, 1, string_get_range, NGUIPanelWrap.cache);
				LuaDLL.lua_pushnumber(L, nGUIPanelWrap.component.baseClipRegion.z);
				LuaDLL.lua_pushnumber(L, nGUIPanelWrap.component.baseClipRegion.w);
				result = 2;
			}
			return result;
		}

		[MonoPInvokeCallback(typeof(LuaCSFunction))]
		private static int set_center(IntPtr L)
		{
			int result = 0;
			if (WraperUtil.ValidIsUserdata(L, 1, string_set_center) && WraperUtil.ValidIsNumber(L, 2, string_set_center) && WraperUtil.ValidIsNumber(L, 3, string_set_center))
			{
				NGUIPanelWrap nGUIPanelWrap = null;
				float num = 0f;
				float num2 = 0f;
				nGUIPanelWrap = WraperUtil.LuaToUserdata(L, 1, string_set_center, NGUIPanelWrap.cache);
				num = (float)LuaDLL.lua_tonumber(L, 2);
				num2 = (float)LuaDLL.lua_tonumber(L, 3);
				nGUIPanelWrap.component.baseClipRegion = new Vector4(num, num2, nGUIPanelWrap.component.baseClipRegion.z, nGUIPanelWrap.component.baseClipRegion.w);
				result = 0;
			}
			return result;
		}

		[MonoPInvokeCallback(typeof(LuaCSFunction))]
		private static int set_clip_offset(IntPtr L)
		{
			int result = 0;
			if (WraperUtil.ValidIsUserdata(L, 1, string_set_center) && WraperUtil.ValidIsNumber(L, 2, string_set_clip_offset) && WraperUtil.ValidIsNumber(L, 3, string_set_clip_offset))
			{
				NGUIPanelWrap nGUIPanelWrap = null;
				float num = 0f;
				float num2 = 0f;
				nGUIPanelWrap = WraperUtil.LuaToUserdata(L, 1, string_set_clip_offset, NGUIPanelWrap.cache);
				num = (float)LuaDLL.lua_tonumber(L, 2);
				num2 = (float)LuaDLL.lua_tonumber(L, 3);
				nGUIPanelWrap.component.clipOffset = new Vector2(num, num2);
				result = 0;
			}
			return result;
		}

		[MonoPInvokeCallback(typeof(LuaCSFunction))]
		private static int get_center(IntPtr L)
		{
			int result = 0;
			if (WraperUtil.ValidIsUserdata(L, 1, string_get_center))
			{
				NGUIPanelWrap nGUIPanelWrap = null;
				nGUIPanelWrap = WraperUtil.LuaToUserdata(L, 1, string_get_center, NGUIPanelWrap.cache);
				LuaDLL.lua_pushnumber(L, nGUIPanelWrap.component.baseClipRegion.x);
				LuaDLL.lua_pushnumber(L, nGUIPanelWrap.component.baseClipRegion.y);
				result = 2;
			}
			return result;
		}

		[MonoPInvokeCallback(typeof(LuaCSFunction))]
		private static int calculate_constrain_offset(IntPtr L)
		{
			int result = 0;
			if (WraperUtil.ValidIsUserdata(L, 1, string_calculate_constrain_offset) && WraperUtil.ValidIsNumber(L, 2, string_calculate_constrain_offset) && WraperUtil.ValidIsNumber(L, 3, string_calculate_constrain_offset) && WraperUtil.ValidIsNumber(L, 4, string_calculate_constrain_offset) && WraperUtil.ValidIsNumber(L, 5, string_calculate_constrain_offset))
			{
				NGUIPanelWrap nGUIPanelWrap = null;
				float num = 0f;
				float num2 = 0f;
				float num3 = 0f;
				float num4 = 0f;
				nGUIPanelWrap = WraperUtil.LuaToUserdata(L, 1, string_calculate_constrain_offset, NGUIPanelWrap.cache);
				num = (float)LuaDLL.lua_tonumber(L, 2);
				num2 = (float)LuaDLL.lua_tonumber(L, 3);
				num3 = (float)LuaDLL.lua_tonumber(L, 4);
				num4 = (float)LuaDLL.lua_tonumber(L, 5);
				Vector3 vector = nGUIPanelWrap.component.CalculateConstrainOffset(new Vector2(num, num2), new Vector2(num3, num4));
				LuaDLL.lua_pushnumber(L, vector.x);
				LuaDLL.lua_pushnumber(L, vector.y);
				LuaDLL.lua_pushnumber(L, vector.z);
				result = 3;
			}
			return result;
		}

		[MonoPInvokeCallback(typeof(LuaCSFunction))]
		private static int set_depth(IntPtr L)
		{
			int result = 0;
			if (WraperUtil.ValidIsUserdata(L, 1, string_set_depth) && WraperUtil.ValidIsNumber(L, 2, string_set_depth))
			{
				NGUIPanelWrap nGUIPanelWrap = null;
				int num = 0;
				nGUIPanelWrap = WraperUtil.LuaToUserdata(L, 1, string_set_depth, NGUIPanelWrap.cache);
				num = (int)LuaDLL.lua_tonumber(L, 2);
				nGUIPanelWrap.component.depth = num;
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
				NGUIPanelWrap nGUIPanelWrap = null;
				nGUIPanelWrap = WraperUtil.LuaToUserdata(L, 1, string_get_depth, NGUIPanelWrap.cache);
				LuaDLL.lua_pushnumber(L, nGUIPanelWrap.component.depth);
				result = 1;
			}
			return result;
		}

		[MonoPInvokeCallback(typeof(LuaCSFunction))]
		private static int get_child_hud_text(IntPtr L)
		{
			int result = 0;
			if (WraperUtil.ValidIsUserdata(L, 1, string_get_child_hud_text))
			{
				NGUIPanelWrap nGUIPanelWrap = null;
				nGUIPanelWrap = WraperUtil.LuaToUserdata(L, 1, string_get_child_hud_text, NGUIPanelWrap.cache);
				if (nGUIPanelWrap != null)
				{
					HUDText[] componentsInChildren = nGUIPanelWrap.component.gameObject.GetComponentsInChildren<HUDText>();
					if (componentsInChildren.Length > 0)
					{
						List<HudTextWrap> list = new List<HudTextWrap>();
						for (int i = 0; i < componentsInChildren.Length; i++)
						{
							HudTextWrap hudTextWrap = new HudTextWrap();
							list.Add(hudTextWrap.InitInstance(componentsInChildren[i], componentsInChildren[i].GetComponent<UIFollowTarget>()));
						}
						if (list.Count > 0)
						{
							WraperUtil.PushObjects(L, list.ToArray());
							result = 1;
						}
					}
				}
			}
			return result;
		}

		[MonoPInvokeCallback(typeof(LuaCSFunction))]
		private static int set_onResize(IntPtr L)
		{
			int result = 0;
			if (WraperUtil.ValidIsUserdata(L, 1, string_set_onResize) && WraperUtil.ValidIsString(L, 2, string_set_onResize))
			{
				NGUIPanelWrap nGUIPanelWrap = null;
				string text = null;
				nGUIPanelWrap = WraperUtil.LuaToUserdata(L, 1, string_set_onResize, NGUIPanelWrap.cache);
				text = LuaDLL.lua_tostring(L, 2);
				nGUIPanelWrap.onResize = text;
				result = 0;
			}
			return result;
		}

		[MonoPInvokeCallback(typeof(LuaCSFunction))]
		private static int gc(IntPtr L)
		{
			NGUIPanelWrap nGUIPanelWrap = WraperUtil.LuaToUserdataByGc(L, 1, "gc ngui_panel", NGUIPanelWrap.cache);
			if (nGUIPanelWrap != null)
			{
				nGUIPanelWrap.DestroyInstance();
			}
			return 0;
		}
	}
}
