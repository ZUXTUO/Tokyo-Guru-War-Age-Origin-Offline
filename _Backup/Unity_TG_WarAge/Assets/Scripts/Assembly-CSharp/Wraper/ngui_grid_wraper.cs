using System;
using LuaInterface;
using UnityEngine;
using UnityWrap;

namespace Wraper
{
	public class ngui_grid_wraper
	{
		public static string name = "ngui_grid";

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
			new luaL_Reg("set_cell_width", set_cell_width),
			new luaL_Reg("set_cell_height", set_cell_height),
			new luaL_Reg("get_cell_width", get_cell_width),
			new luaL_Reg("get_cell_height", get_cell_height),
			new luaL_Reg("set_max_line", set_max_line),
			new luaL_Reg("get_max_line", get_max_line),
			new luaL_Reg("set_arrangement", set_arrangement),
			new luaL_Reg("reposition_now", reposition_now)
		};

		private static string string_get_pid = "ngui_grid:get_pid";

		private static string string_set_active = "ngui_grid:set_active";

		private static string string_set_name = "ngui_grid:set_name";

		private static string string_get_name = "ngui_grid:get_name";

		private static string string_set_position = "ngui_grid:set_position";

		private static string string_get_position = "ngui_grid:get_position";

		private static string string_get_size = "ngui_grid:get_size";

		private static string string_get_game_object = "ngui_grid:get_game_object";

		private static string string_get_parent = "ngui_grid:get_parent";

		private static string string_set_parent = "ngui_grid:set_parent";

		private static string string_clone = "ngui_grid:clone";

		private static string string_destroy_object = "ngui_grid:destroy_object";

		private static string string_set_cell_width = "ngui_grid:set_cell_width";

		private static string string_set_cell_height = "ngui_grid:set_cell_height";

		private static string string_get_cell_width = "ngui_grid:get_cell_width";

		private static string string_get_cell_height = "ngui_grid:get_cell_height";

		private static string string_set_max_line = "ngui_grid:set_max_line";

		private static string string_get_max_line = "ngui_grid:get_max_line";

		private static string string_set_arrangement = "ngui_grid:set_arrangement";

		private static string string_reposition_now = "ngui_grid:reposition_now";

		public static bool init(IntPtr L)
		{
			if (L != IntPtr.Zero)
			{
				LuaDLL.register_class(L, name, func, gc);
				return true;
			}
			return false;
		}

		public static void push(IntPtr L, NGUIGridWrap obj)
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
				NGUIGridWrap nGUIGridWrap = null;
				nGUIGridWrap = WraperUtil.LuaToUserdata(L, 1, string_get_pid, NGUIGridWrap.cache);
				LuaDLL.lua_pushnumber(L, nGUIGridWrap.GetPid());
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
				NGUIGridWrap nGUIGridWrap = null;
				bool flag = false;
				nGUIGridWrap = WraperUtil.LuaToUserdata(L, 1, string_set_active, NGUIGridWrap.cache);
				flag = LuaDLL.lua_toboolean(L, 2);
				nGUIGridWrap.bcomponent.gameObject.SetActive(flag);
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
				NGUIGridWrap nGUIGridWrap = null;
				string text = null;
				nGUIGridWrap = WraperUtil.LuaToUserdata(L, 1, string_set_name, NGUIGridWrap.cache);
				text = LuaDLL.lua_tostring(L, 2);
				nGUIGridWrap.bcomponent.gameObject.name = text;
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
				NGUIGridWrap nGUIGridWrap = null;
				nGUIGridWrap = WraperUtil.LuaToUserdata(L, 1, string_get_name, NGUIGridWrap.cache);
				LuaDLL.lua_pushstring(L, nGUIGridWrap.bcomponent.gameObject.name);
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
				NGUIGridWrap nGUIGridWrap = null;
				float num = 0f;
				float num2 = 0f;
				float num3 = 0f;
				nGUIGridWrap = WraperUtil.LuaToUserdata(L, 1, string_set_position, NGUIGridWrap.cache);
				num = (float)LuaDLL.lua_tonumber(L, 2);
				num2 = (float)LuaDLL.lua_tonumber(L, 3);
				num3 = (float)LuaDLL.lua_tonumber(L, 4);
				nGUIGridWrap.bcomponent.gameObject.transform.localPosition = new Vector3(num, num2, num3);
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
				NGUIGridWrap nGUIGridWrap = null;
				nGUIGridWrap = WraperUtil.LuaToUserdata(L, 1, string_get_position, NGUIGridWrap.cache);
				Vector3 localPosition = nGUIGridWrap.bcomponent.gameObject.transform.localPosition;
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
				NGUIGridWrap nGUIGridWrap = null;
				nGUIGridWrap = WraperUtil.LuaToUserdata(L, 1, string_get_size, NGUIGridWrap.cache);
				int num = ((!(nGUIGridWrap.widget == null)) ? nGUIGridWrap.widget.width : 0);
				int num2 = ((!(nGUIGridWrap.widget == null)) ? nGUIGridWrap.widget.height : 0);
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
				NGUIGridWrap nGUIGridWrap = null;
				nGUIGridWrap = WraperUtil.LuaToUserdata(L, 1, string_get_game_object, NGUIGridWrap.cache);
				AssetGameObject base_object = AssetGameObject.CreateByInstance(nGUIGridWrap.bcomponent.gameObject);
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
				NGUIGridWrap nGUIGridWrap = null;
				nGUIGridWrap = WraperUtil.LuaToUserdata(L, 1, string_get_parent, NGUIGridWrap.cache);
				AssetGameObject assetGameObject = null;
				Transform parent = nGUIGridWrap.bcomponent.gameObject.transform.parent;
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
				NGUIGridWrap nGUIGridWrap = null;
				AssetGameObject assetGameObject = null;
				nGUIGridWrap = WraperUtil.LuaToUserdata(L, 1, string_set_parent, NGUIGridWrap.cache);
				assetGameObject = WraperUtil.LuaToUserdataOrNil(L, 2, string_set_parent, AssetGameObject.cache);
				nGUIGridWrap.bcomponent.gameObject.transform.parent = ((assetGameObject != null) ? assetGameObject.transform : null);
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
				NGUIGridWrap nGUIGridWrap = null;
				nGUIGridWrap = WraperUtil.LuaToUserdata(L, 1, string_clone, NGUIGridWrap.cache);
				nGUIGridWrap.Clone(L);
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
				NGUIGridWrap nGUIGridWrap = null;
				nGUIGridWrap = WraperUtil.LuaToUserdata(L, 1, string_destroy_object, NGUIGridWrap.cache);
				nGUIGridWrap.isNeedDestroy = true;
				result = 0;
			}
			return result;
		}

		[MonoPInvokeCallback(typeof(LuaCSFunction))]
		private static int set_cell_width(IntPtr L)
		{
			int result = 0;
			if (WraperUtil.ValidIsUserdata(L, 1, string_set_cell_width) && WraperUtil.ValidIsNumber(L, 2, string_set_cell_width))
			{
				NGUIGridWrap nGUIGridWrap = null;
				float num = 0f;
				nGUIGridWrap = WraperUtil.LuaToUserdata(L, 1, string_set_cell_width, NGUIGridWrap.cache);
				num = (float)LuaDLL.lua_tonumber(L, 2);
				nGUIGridWrap.component.cellWidth = num;
				result = 0;
			}
			return result;
		}

		[MonoPInvokeCallback(typeof(LuaCSFunction))]
		private static int get_cell_width(IntPtr L)
		{
			int result = 0;
			if (WraperUtil.ValidIsUserdata(L, 1, string_get_cell_width))
			{
				NGUIGridWrap nGUIGridWrap = null;
				nGUIGridWrap = WraperUtil.LuaToUserdata(L, 1, string_get_cell_width, NGUIGridWrap.cache);
				LuaDLL.lua_pushnumber(L, nGUIGridWrap.component.cellWidth);
				result = 1;
			}
			return result;
		}

		[MonoPInvokeCallback(typeof(LuaCSFunction))]
		private static int set_cell_height(IntPtr L)
		{
			int result = 0;
			if (WraperUtil.ValidIsUserdata(L, 1, string_set_cell_height) && WraperUtil.ValidIsNumber(L, 2, string_set_cell_height))
			{
				NGUIGridWrap nGUIGridWrap = null;
				float num = 0f;
				nGUIGridWrap = WraperUtil.LuaToUserdata(L, 1, string_set_cell_height, NGUIGridWrap.cache);
				num = (float)LuaDLL.lua_tonumber(L, 2);
				nGUIGridWrap.component.cellHeight = num;
				result = 0;
			}
			return result;
		}

		[MonoPInvokeCallback(typeof(LuaCSFunction))]
		private static int get_cell_height(IntPtr L)
		{
			int result = 0;
			if (WraperUtil.ValidIsUserdata(L, 1, string_get_cell_height))
			{
				NGUIGridWrap nGUIGridWrap = null;
				nGUIGridWrap = WraperUtil.LuaToUserdata(L, 1, string_get_cell_height, NGUIGridWrap.cache);
				LuaDLL.lua_pushnumber(L, nGUIGridWrap.component.cellHeight);
				result = 1;
			}
			return result;
		}

		[MonoPInvokeCallback(typeof(LuaCSFunction))]
		private static int set_max_line(IntPtr L)
		{
			int result = 0;
			if (WraperUtil.ValidIsUserdata(L, 1, string_set_max_line) && WraperUtil.ValidIsNumber(L, 2, string_set_max_line))
			{
				NGUIGridWrap nGUIGridWrap = null;
				int num = 0;
				nGUIGridWrap = WraperUtil.LuaToUserdata(L, 1, string_set_max_line, NGUIGridWrap.cache);
				num = (int)LuaDLL.lua_tonumber(L, 2);
				nGUIGridWrap.component.maxPerLine = num;
				result = 0;
			}
			return result;
		}

		[MonoPInvokeCallback(typeof(LuaCSFunction))]
		private static int get_max_line(IntPtr L)
		{
			int result = 0;
			if (WraperUtil.ValidIsUserdata(L, 1, string_get_max_line))
			{
				NGUIGridWrap nGUIGridWrap = null;
				nGUIGridWrap = WraperUtil.LuaToUserdata(L, 1, string_get_max_line, NGUIGridWrap.cache);
				LuaDLL.lua_pushnumber(L, nGUIGridWrap.component.maxPerLine);
				result = 1;
			}
			return result;
		}

		[MonoPInvokeCallback(typeof(LuaCSFunction))]
		private static int set_arrangement(IntPtr L)
		{
			int result = 0;
			if (WraperUtil.ValidIsUserdata(L, 1, string_set_arrangement) && WraperUtil.ValidIsNumber(L, 2, string_set_arrangement))
			{
				NGUIGridWrap nGUIGridWrap = null;
				int num = 0;
				nGUIGridWrap = WraperUtil.LuaToUserdata(L, 1, string_set_arrangement, NGUIGridWrap.cache);
				switch ((int)LuaDLL.lua_tonumber(L, 2))
				{
				case 1:
					nGUIGridWrap.component.arrangement = UIGrid.Arrangement.Horizontal;
					break;
				case 2:
					nGUIGridWrap.component.arrangement = UIGrid.Arrangement.Vertical;
					break;
				case 3:
					nGUIGridWrap.component.arrangement = UIGrid.Arrangement.CellSnap;
					break;
				}
				result = 0;
			}
			return result;
		}

		[MonoPInvokeCallback(typeof(LuaCSFunction))]
		private static int reposition_now(IntPtr L)
		{
			int result = 0;
			if (WraperUtil.ValidIsUserdata(L, 1, string_reposition_now))
			{
				NGUIGridWrap nGUIGridWrap = null;
				nGUIGridWrap = WraperUtil.LuaToUserdata(L, 1, string_reposition_now, NGUIGridWrap.cache);
				nGUIGridWrap.component.Reposition();
				result = 0;
			}
			return result;
		}

		[MonoPInvokeCallback(typeof(LuaCSFunction))]
		private static int gc(IntPtr L)
		{
			NGUIGridWrap nGUIGridWrap = WraperUtil.LuaToUserdataByGc(L, 1, "gc ngui_grid", NGUIGridWrap.cache);
			if (nGUIGridWrap != null)
			{
				nGUIGridWrap.DestroyInstance();
			}
			return 0;
		}
	}
}
