using System;
using LuaInterface;
using UnityWrap;

namespace Wraper
{
	public class ngui_enchancescrollview_wraper
	{
		public static string name = "ngui_enchancescrollview";

		private static luaL_Reg[] func = new luaL_Reg[37]
		{
			new luaL_Reg("get_pid", get_pid),
			new luaL_Reg("get_name", get_name),
			new luaL_Reg("set_name", set_name),
			new luaL_Reg("get_raid", get_raid),
			new luaL_Reg("set_raid", set_raid),
			new luaL_Reg("get_showNum", get_showNum),
			new luaL_Reg("set_showNum", set_showNum),
			new luaL_Reg("get_maxNum", get_maxNum),
			new luaL_Reg("set_maxNum", set_maxNum),
			new luaL_Reg("get_farScale", get_farScale),
			new luaL_Reg("set_farScale", set_farScale),
			new luaL_Reg("get_nearScale", get_nearScale),
			new luaL_Reg("set_nearScale", set_nearScale),
			new luaL_Reg("get_offsetAngle", get_offsetAngle),
			new luaL_Reg("set_offsetAngle", set_offsetAngle),
			new luaL_Reg("get_dragMult", get_dragMult),
			new luaL_Reg("set_dragMult", set_dragMult),
			new luaL_Reg("set_slideMult", set_slideMult),
			new luaL_Reg("get_slideMult", get_slideMult),
			new luaL_Reg("get_distanceFollowScale", get_distanceFollowScale),
			new luaL_Reg("set_distanceFollowScale", set_distanceFollowScale),
			new luaL_Reg("set_nearStopProgress", set_nearStopProgress),
			new luaL_Reg("full_display_item", full_display_item),
			new luaL_Reg("set_on_stop_move", set_on_stop_move),
			new luaL_Reg("set_on_start_move", set_on_start_move),
			new luaL_Reg("set_index", set_index),
			new luaL_Reg("set_showIndex", set_showIndex),
			new luaL_Reg("tween_to_index", tween_to_index),
			new luaL_Reg("refresh_list", refresh_list),
			new luaL_Reg("set_on_initialize_item", set_on_initialize_item),
			new luaL_Reg("set_enable_drag", set_enable_drag),
			new luaL_Reg("set_dynamic", set_dynamic),
			new luaL_Reg("set_on_outstart", set_on_outstart),
			new luaL_Reg("set_on_outend", set_on_outend),
			new luaL_Reg("get_game_object", get_game_object),
			new luaL_Reg("clone", clone),
			new luaL_Reg("destroy_object", destroy_object)
		};

		private static string string_get_pid = "ngui_enchancescrollview:get_pid";

		private static string string_get_name = "ngui_enchancescrollview:get_name";

		private static string string_set_name = "ngui_enchancescrollview:set_name";

		private static string string_get_raid = "ngui_enchancescrollview:get_raid";

		private static string string_set_raid = "ngui_enchancescrollview:set_raid";

		private static string string_get_showNum = "ngui_enchancescrollview:get_showNum";

		private static string string_set_showNum = "ngui_enchancescrollview:set_showNum";

		private static string string_get_maxNum = "ngui_enchancescrollview:get_maxNum";

		private static string string_set_maxNum = "ngui_enchancescrollview:set_maxNum";

		private static string string_get_farScale = "ngui_enchancescrollview:get_farScale";

		private static string string_set_farScale = "ngui_enchancescrollview:set_farScale";

		private static string string_get_nearScale = "ngui_enchancescrollview:get_nearScale";

		private static string string_set_nearScale = "ngui_enchancescrollview:set_nearScale";

		private static string string_get_offsetAngle = "ngui_enchancescrollview:get_offsetAngle";

		private static string string_set_offsetAngle = "ngui_enchancescrollview:set_offsetAngle";

		private static string string_get_dragMult = "ngui_enchancescrollview:get_dragMult";

		private static string string_set_dragMult = "ngui_enchancescrollview:set_dragMult";

		private static string string_set_slideMult = "ngui_enchancescrollview:set_slideMult";

		private static string string_get_slideMult = "ngui_enchancescrollview:get_slideMult";

		private static string string_get_distanceFollowScale = "ngui_enchancescrollview:get_distanceFollowScale";

		private static string string_set_distanceFollowScale = "ngui_enchancescrollview:set_distanceFollowScale";

		private static string string_set_nearStopProgress = "ngui_enchancescrollview:set_nearStopProgress";

		private static string string_full_display_item = "ngui_enchancescrollview:full_display_item";

		private static string string_set_on_stop_move = "ngui_enchancescrollview:set_on_stop_move";

		private static string string_set_on_start_move = "ngui_enchancescrollview:set_on_start_move";

		private static string string_set_index = "ngui_enchancescrollview:set_index";

		private static string string_set_showIndex = "ngui_enchancescrollview:set_showIndex";

		private static string string_tween_to_index = "ngui_enchancescrollview:tween_to_index";

		private static string string_refresh_list = "ngui_enchancescrollview:refresh_list";

		private static string string_set_on_initialize_item = "ngui_enchancescrollview:set_on_initialize_item";

		private static string string_set_enable_drag = "ngui_enchancescrollview:string_set_enable_drag";

		private static string string_set_dynamic = "ngui_enchancescrollview:set_dynamic";

		private static string string_set_on_outstart = "ngui_enchancescrollview:set_on_outstart";

		private static string string_set_on_outend = "ngui_enchancescrollview:set_on_outend";

		private static string string_get_game_object = "ngui_enchancescrollview:get_game_object";

		private static string string_clone = "ngui_enchancescrollview:clone";

		private static string string_destroy_object = "ngui_enchancescrollview:destroy_object";

		public static bool init(IntPtr L)
		{
			if (L != IntPtr.Zero)
			{
				LuaDLL.register_class(L, name, func, gc);
				return true;
			}
			return false;
		}

		public static void push(IntPtr L, NGUIEnchanceScrollViewWrap obj)
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
				NGUIEnchanceScrollViewWrap nGUIEnchanceScrollViewWrap = null;
				nGUIEnchanceScrollViewWrap = WraperUtil.LuaToUserdata(L, 1, string_get_pid, NGUIEnchanceScrollViewWrap.cache);
				LuaDLL.lua_pushnumber(L, nGUIEnchanceScrollViewWrap.GetPid());
				result = 1;
			}
			return result;
		}

		[MonoPInvokeCallback(typeof(LuaCSFunction))]
		private static int set_name(IntPtr L)
		{
			int result = 0;
			if (WraperUtil.ValidIsUserdata(L, 1, string_set_name) && WraperUtil.ValidIsString(L, 2, string_set_name))
			{
				NGUIEnchanceScrollViewWrap nGUIEnchanceScrollViewWrap = null;
				string text = null;
				nGUIEnchanceScrollViewWrap = WraperUtil.LuaToUserdata(L, 1, string_set_name, NGUIEnchanceScrollViewWrap.cache);
				text = LuaDLL.lua_tostring(L, 2);
				nGUIEnchanceScrollViewWrap.bcomponent.gameObject.name = text;
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
				NGUIEnchanceScrollViewWrap nGUIEnchanceScrollViewWrap = null;
				nGUIEnchanceScrollViewWrap = WraperUtil.LuaToUserdata(L, 1, string_get_name, NGUIEnchanceScrollViewWrap.cache);
				LuaDLL.lua_pushstring(L, nGUIEnchanceScrollViewWrap.bcomponent.gameObject.name);
				result = 1;
			}
			return result;
		}

		[MonoPInvokeCallback(typeof(LuaCSFunction))]
		private static int get_raid(IntPtr L)
		{
			int result = 0;
			if (WraperUtil.ValidIsUserdata(L, 1, string_get_raid))
			{
				NGUIEnchanceScrollViewWrap nGUIEnchanceScrollViewWrap = null;
				nGUIEnchanceScrollViewWrap = WraperUtil.LuaToUserdata(L, 1, string_get_raid, NGUIEnchanceScrollViewWrap.cache);
				int raid = nGUIEnchanceScrollViewWrap.raid;
				LuaDLL.lua_pushnumber(L, raid);
				result = 1;
			}
			return result;
		}

		[MonoPInvokeCallback(typeof(LuaCSFunction))]
		private static int set_raid(IntPtr L)
		{
			int result = 0;
			if (WraperUtil.ValidIsUserdata(L, 1, string_set_raid) && WraperUtil.ValidIsNumber(L, 2, string_set_raid))
			{
				NGUIEnchanceScrollViewWrap nGUIEnchanceScrollViewWrap = null;
				nGUIEnchanceScrollViewWrap = WraperUtil.LuaToUserdata(L, 1, string_set_raid, NGUIEnchanceScrollViewWrap.cache);
				int raid = LuaDLL.lua_tointeger(L, 2);
				if (nGUIEnchanceScrollViewWrap != null)
				{
					nGUIEnchanceScrollViewWrap.raid = raid;
				}
				result = 0;
			}
			return result;
		}

		[MonoPInvokeCallback(typeof(LuaCSFunction))]
		private static int get_showNum(IntPtr L)
		{
			int result = 0;
			if (WraperUtil.ValidIsUserdata(L, 1, string_get_showNum))
			{
				NGUIEnchanceScrollViewWrap nGUIEnchanceScrollViewWrap = null;
				nGUIEnchanceScrollViewWrap = WraperUtil.LuaToUserdata(L, 1, string_get_showNum, NGUIEnchanceScrollViewWrap.cache);
				int showNum = nGUIEnchanceScrollViewWrap.showNum;
				LuaDLL.lua_pushnumber(L, showNum);
				result = 1;
			}
			return result;
		}

		[MonoPInvokeCallback(typeof(LuaCSFunction))]
		private static int set_showNum(IntPtr L)
		{
			int result = 0;
			if (WraperUtil.ValidIsUserdata(L, 1, string_set_showNum) && WraperUtil.ValidIsNumber(L, 2, string_set_showNum))
			{
				NGUIEnchanceScrollViewWrap nGUIEnchanceScrollViewWrap = null;
				nGUIEnchanceScrollViewWrap = WraperUtil.LuaToUserdata(L, 1, string_set_showNum, NGUIEnchanceScrollViewWrap.cache);
				int showNum = LuaDLL.lua_tointeger(L, 2);
				if (nGUIEnchanceScrollViewWrap != null)
				{
					nGUIEnchanceScrollViewWrap.showNum = showNum;
				}
				result = 0;
			}
			return result;
		}

		[MonoPInvokeCallback(typeof(LuaCSFunction))]
		private static int get_maxNum(IntPtr L)
		{
			int result = 0;
			if (WraperUtil.ValidIsUserdata(L, 1, string_get_maxNum))
			{
				NGUIEnchanceScrollViewWrap nGUIEnchanceScrollViewWrap = null;
				nGUIEnchanceScrollViewWrap = WraperUtil.LuaToUserdata(L, 1, string_get_maxNum, NGUIEnchanceScrollViewWrap.cache);
				int maxNum = nGUIEnchanceScrollViewWrap.maxNum;
				LuaDLL.lua_pushnumber(L, maxNum);
				result = 1;
			}
			return result;
		}

		[MonoPInvokeCallback(typeof(LuaCSFunction))]
		private static int set_maxNum(IntPtr L)
		{
			int result = 0;
			if (WraperUtil.ValidIsUserdata(L, 1, string_set_maxNum) && WraperUtil.ValidIsNumber(L, 2, string_set_maxNum))
			{
				NGUIEnchanceScrollViewWrap nGUIEnchanceScrollViewWrap = null;
				nGUIEnchanceScrollViewWrap = WraperUtil.LuaToUserdata(L, 1, string_set_maxNum, NGUIEnchanceScrollViewWrap.cache);
				int maxNum = LuaDLL.lua_tointeger(L, 2);
				if (nGUIEnchanceScrollViewWrap != null)
				{
					nGUIEnchanceScrollViewWrap.maxNum = maxNum;
				}
				result = 0;
			}
			return result;
		}

		[MonoPInvokeCallback(typeof(LuaCSFunction))]
		private static int get_farScale(IntPtr L)
		{
			int result = 0;
			if (WraperUtil.ValidIsUserdata(L, 1, string_get_farScale))
			{
				NGUIEnchanceScrollViewWrap nGUIEnchanceScrollViewWrap = null;
				nGUIEnchanceScrollViewWrap = WraperUtil.LuaToUserdata(L, 1, string_get_farScale, NGUIEnchanceScrollViewWrap.cache);
				float farScale = nGUIEnchanceScrollViewWrap.farScale;
				LuaDLL.lua_pushnumber(L, farScale);
				result = 1;
			}
			return result;
		}

		[MonoPInvokeCallback(typeof(LuaCSFunction))]
		private static int set_farScale(IntPtr L)
		{
			int result = 0;
			if (WraperUtil.ValidIsUserdata(L, 1, string_set_farScale) && WraperUtil.ValidIsNumber(L, 2, string_set_farScale))
			{
				NGUIEnchanceScrollViewWrap nGUIEnchanceScrollViewWrap = null;
				nGUIEnchanceScrollViewWrap = WraperUtil.LuaToUserdata(L, 1, string_set_farScale, NGUIEnchanceScrollViewWrap.cache);
				float farScale = (float)LuaDLL.lua_tonumber(L, 2);
				if (nGUIEnchanceScrollViewWrap != null)
				{
					nGUIEnchanceScrollViewWrap.farScale = farScale;
				}
				result = 0;
			}
			return result;
		}

		[MonoPInvokeCallback(typeof(LuaCSFunction))]
		private static int get_nearScale(IntPtr L)
		{
			int result = 0;
			if (WraperUtil.ValidIsUserdata(L, 1, string_get_nearScale))
			{
				NGUIEnchanceScrollViewWrap nGUIEnchanceScrollViewWrap = null;
				nGUIEnchanceScrollViewWrap = WraperUtil.LuaToUserdata(L, 1, string_get_nearScale, NGUIEnchanceScrollViewWrap.cache);
				float nearScale = nGUIEnchanceScrollViewWrap.nearScale;
				LuaDLL.lua_pushnumber(L, nearScale);
				result = 1;
			}
			return result;
		}

		[MonoPInvokeCallback(typeof(LuaCSFunction))]
		private static int set_nearScale(IntPtr L)
		{
			int result = 0;
			if (WraperUtil.ValidIsUserdata(L, 1, string_set_nearScale) && WraperUtil.ValidIsNumber(L, 2, string_set_nearScale))
			{
				NGUIEnchanceScrollViewWrap nGUIEnchanceScrollViewWrap = null;
				nGUIEnchanceScrollViewWrap = WraperUtil.LuaToUserdata(L, 1, string_set_nearScale, NGUIEnchanceScrollViewWrap.cache);
				float nearScale = (float)LuaDLL.lua_tonumber(L, 2);
				if (nGUIEnchanceScrollViewWrap != null)
				{
					nGUIEnchanceScrollViewWrap.nearScale = nearScale;
				}
				result = 0;
			}
			return result;
		}

		[MonoPInvokeCallback(typeof(LuaCSFunction))]
		private static int get_offsetAngle(IntPtr L)
		{
			int result = 0;
			if (WraperUtil.ValidIsUserdata(L, 1, string_get_offsetAngle))
			{
				NGUIEnchanceScrollViewWrap nGUIEnchanceScrollViewWrap = null;
				nGUIEnchanceScrollViewWrap = WraperUtil.LuaToUserdata(L, 1, string_get_offsetAngle, NGUIEnchanceScrollViewWrap.cache);
				float offsetAngle = nGUIEnchanceScrollViewWrap.offsetAngle;
				LuaDLL.lua_pushnumber(L, offsetAngle);
				result = 1;
			}
			return result;
		}

		[MonoPInvokeCallback(typeof(LuaCSFunction))]
		private static int set_offsetAngle(IntPtr L)
		{
			int result = 0;
			if (WraperUtil.ValidIsUserdata(L, 1, string_set_offsetAngle) && WraperUtil.ValidIsNumber(L, 2, string_set_offsetAngle))
			{
				NGUIEnchanceScrollViewWrap nGUIEnchanceScrollViewWrap = null;
				nGUIEnchanceScrollViewWrap = WraperUtil.LuaToUserdata(L, 1, string_set_offsetAngle, NGUIEnchanceScrollViewWrap.cache);
				float offsetAngle = (float)LuaDLL.lua_tonumber(L, 2);
				if (nGUIEnchanceScrollViewWrap != null)
				{
					nGUIEnchanceScrollViewWrap.offsetAngle = offsetAngle;
				}
				result = 0;
			}
			return result;
		}

		[MonoPInvokeCallback(typeof(LuaCSFunction))]
		private static int get_dragMult(IntPtr L)
		{
			int result = 0;
			if (WraperUtil.ValidIsUserdata(L, 1, string_get_dragMult))
			{
				NGUIEnchanceScrollViewWrap nGUIEnchanceScrollViewWrap = null;
				nGUIEnchanceScrollViewWrap = WraperUtil.LuaToUserdata(L, 1, string_get_dragMult, NGUIEnchanceScrollViewWrap.cache);
				float dragMult = nGUIEnchanceScrollViewWrap.dragMult;
				LuaDLL.lua_pushnumber(L, dragMult);
				result = 1;
			}
			return result;
		}

		[MonoPInvokeCallback(typeof(LuaCSFunction))]
		private static int set_dragMult(IntPtr L)
		{
			int result = 0;
			if (WraperUtil.ValidIsUserdata(L, 1, string_set_dragMult) && WraperUtil.ValidIsNumber(L, 2, string_set_dragMult))
			{
				NGUIEnchanceScrollViewWrap nGUIEnchanceScrollViewWrap = null;
				nGUIEnchanceScrollViewWrap = WraperUtil.LuaToUserdata(L, 1, string_set_dragMult, NGUIEnchanceScrollViewWrap.cache);
				float dragMult = (float)LuaDLL.lua_tonumber(L, 2);
				if (nGUIEnchanceScrollViewWrap != null)
				{
					nGUIEnchanceScrollViewWrap.dragMult = dragMult;
				}
				result = 0;
			}
			return result;
		}

		[MonoPInvokeCallback(typeof(LuaCSFunction))]
		private static int get_slideMult(IntPtr L)
		{
			int result = 0;
			if (WraperUtil.ValidIsUserdata(L, 1, string_get_slideMult))
			{
				NGUIEnchanceScrollViewWrap nGUIEnchanceScrollViewWrap = null;
				nGUIEnchanceScrollViewWrap = WraperUtil.LuaToUserdata(L, 1, string_get_slideMult, NGUIEnchanceScrollViewWrap.cache);
				float slideMult = nGUIEnchanceScrollViewWrap.component.slideMult;
				LuaDLL.lua_pushnumber(L, slideMult);
				result = 1;
			}
			return result;
		}

		[MonoPInvokeCallback(typeof(LuaCSFunction))]
		private static int set_slideMult(IntPtr L)
		{
			int result = 0;
			if (WraperUtil.ValidIsUserdata(L, 1, string_set_slideMult) && WraperUtil.ValidIsNumber(L, 2, string_set_slideMult))
			{
				NGUIEnchanceScrollViewWrap nGUIEnchanceScrollViewWrap = null;
				nGUIEnchanceScrollViewWrap = WraperUtil.LuaToUserdata(L, 1, string_set_slideMult, NGUIEnchanceScrollViewWrap.cache);
				float slideMult = (float)LuaDLL.lua_tonumber(L, 2);
				if (nGUIEnchanceScrollViewWrap != null)
				{
					nGUIEnchanceScrollViewWrap.component.slideMult = slideMult;
				}
				result = 0;
			}
			return result;
		}

		[MonoPInvokeCallback(typeof(LuaCSFunction))]
		private static int get_distanceFollowScale(IntPtr L)
		{
			int result = 0;
			if (WraperUtil.ValidIsUserdata(L, 1, string_get_distanceFollowScale))
			{
				NGUIEnchanceScrollViewWrap nGUIEnchanceScrollViewWrap = null;
				nGUIEnchanceScrollViewWrap = WraperUtil.LuaToUserdata(L, 1, string_get_distanceFollowScale, NGUIEnchanceScrollViewWrap.cache);
				bool distanceFollowScale = nGUIEnchanceScrollViewWrap.distanceFollowScale;
				LuaDLL.lua_pushboolean(L, distanceFollowScale);
				result = 1;
			}
			return result;
		}

		[MonoPInvokeCallback(typeof(LuaCSFunction))]
		private static int set_distanceFollowScale(IntPtr L)
		{
			int result = 0;
			if (WraperUtil.ValidIsUserdata(L, 1, string_set_distanceFollowScale) && WraperUtil.ValidIsNumber(L, 2, string_set_distanceFollowScale))
			{
				NGUIEnchanceScrollViewWrap nGUIEnchanceScrollViewWrap = null;
				nGUIEnchanceScrollViewWrap = WraperUtil.LuaToUserdata(L, 1, string_set_distanceFollowScale, NGUIEnchanceScrollViewWrap.cache);
				bool distanceFollowScale = LuaDLL.lua_toboolean(L, 2);
				if (nGUIEnchanceScrollViewWrap != null)
				{
					nGUIEnchanceScrollViewWrap.distanceFollowScale = distanceFollowScale;
				}
				result = 0;
			}
			return result;
		}

		[MonoPInvokeCallback(typeof(LuaCSFunction))]
		private static int set_nearStopProgress(IntPtr L)
		{
			int result = 0;
			if (WraperUtil.ValidIsUserdata(L, 1, string_set_nearStopProgress) && WraperUtil.ValidIsNumber(L, 2, string_set_nearStopProgress))
			{
				NGUIEnchanceScrollViewWrap nGUIEnchanceScrollViewWrap = null;
				nGUIEnchanceScrollViewWrap = WraperUtil.LuaToUserdata(L, 1, string_set_nearStopProgress, NGUIEnchanceScrollViewWrap.cache);
				float nearStopProgress = (float)LuaDLL.lua_tonumber(L, 2);
				if (nGUIEnchanceScrollViewWrap != null)
				{
					nGUIEnchanceScrollViewWrap.nearStopProgress = nearStopProgress;
				}
				result = 0;
			}
			return result;
		}

		[MonoPInvokeCallback(typeof(LuaCSFunction))]
		private static int full_display_item(IntPtr L)
		{
			int result = 0;
			if (WraperUtil.ValidIsUserdata(L, 1, string_set_nearStopProgress) && WraperUtil.ValidIsNumber(L, 2, string_set_nearStopProgress))
			{
				NGUIEnchanceScrollViewWrap nGUIEnchanceScrollViewWrap = null;
				nGUIEnchanceScrollViewWrap = WraperUtil.LuaToUserdata(L, 1, string_set_nearStopProgress, NGUIEnchanceScrollViewWrap.cache);
				int index = LuaDLL.lua_tointeger(L, 2);
				if (nGUIEnchanceScrollViewWrap != null)
				{
					nGUIEnchanceScrollViewWrap.component.fullDisplayItem(index);
				}
				result = 0;
			}
			return result;
		}

		[MonoPInvokeCallback(typeof(LuaCSFunction))]
		private static int set_on_initialize_item(IntPtr L)
		{
			int result = 0;
			if (WraperUtil.ValidIsUserdata(L, 1, string_set_on_initialize_item) && WraperUtil.ValidIsString(L, 2, string_set_on_initialize_item))
			{
				NGUIEnchanceScrollViewWrap nGUIEnchanceScrollViewWrap = null;
				string text = null;
				nGUIEnchanceScrollViewWrap = WraperUtil.LuaToUserdata(L, 1, string_set_on_initialize_item, NGUIEnchanceScrollViewWrap.cache);
				text = LuaDLL.lua_tostring(L, 2);
				nGUIEnchanceScrollViewWrap.onInitializeItem = text;
				result = 0;
			}
			return result;
		}

		[MonoPInvokeCallback(typeof(LuaCSFunction))]
		private static int set_enable_drag(IntPtr L)
		{
			int result = 0;
			if (WraperUtil.ValidIsUserdata(L, 1, string_set_enable_drag) && WraperUtil.ValidIsBoolean(L, 2, string_set_enable_drag))
			{
				NGUIEnchanceScrollViewWrap nGUIEnchanceScrollViewWrap = null;
				bool flag = true;
				nGUIEnchanceScrollViewWrap = WraperUtil.LuaToUserdata(L, 1, string_set_enable_drag, NGUIEnchanceScrollViewWrap.cache);
				flag = LuaDLL.lua_toboolean(L, 2);
				nGUIEnchanceScrollViewWrap.component.enableDrag = flag;
				result = 0;
			}
			return result;
		}

		[MonoPInvokeCallback(typeof(LuaCSFunction))]
		private static int set_dynamic(IntPtr L)
		{
			int result = 0;
			if (WraperUtil.ValidIsUserdata(L, 1, string_set_on_initialize_item) && WraperUtil.ValidIsBoolean(L, 2, string_set_on_initialize_item))
			{
				NGUIEnchanceScrollViewWrap nGUIEnchanceScrollViewWrap = null;
				bool flag = false;
				nGUIEnchanceScrollViewWrap = WraperUtil.LuaToUserdata(L, 1, string_set_on_initialize_item, NGUIEnchanceScrollViewWrap.cache);
				flag = LuaDLL.lua_toboolean(L, 2);
				nGUIEnchanceScrollViewWrap.component.SetDynamic(flag);
				result = 0;
			}
			return result;
		}

		[MonoPInvokeCallback(typeof(LuaCSFunction))]
		private static int set_on_outstart(IntPtr L)
		{
			int result = 0;
			if (WraperUtil.ValidIsUserdata(L, 1, string_set_on_outstart) && WraperUtil.ValidIsString(L, 2, string_set_on_outstart))
			{
				NGUIEnchanceScrollViewWrap nGUIEnchanceScrollViewWrap = null;
				string text = null;
				nGUIEnchanceScrollViewWrap = WraperUtil.LuaToUserdata(L, 1, string_set_on_outstart, NGUIEnchanceScrollViewWrap.cache);
				text = LuaDLL.lua_tostring(L, 2);
				nGUIEnchanceScrollViewWrap.onOutStart = text;
				result = 0;
			}
			return result;
		}

		[MonoPInvokeCallback(typeof(LuaCSFunction))]
		private static int set_on_outend(IntPtr L)
		{
			int result = 0;
			if (WraperUtil.ValidIsUserdata(L, 1, string_set_on_outend) && WraperUtil.ValidIsString(L, 2, string_set_on_outend))
			{
				NGUIEnchanceScrollViewWrap nGUIEnchanceScrollViewWrap = null;
				string text = null;
				nGUIEnchanceScrollViewWrap = WraperUtil.LuaToUserdata(L, 1, string_set_on_outend, NGUIEnchanceScrollViewWrap.cache);
				text = LuaDLL.lua_tostring(L, 2);
				nGUIEnchanceScrollViewWrap.onOutEnd = text;
				result = 0;
			}
			return result;
		}

		[MonoPInvokeCallback(typeof(LuaCSFunction))]
		private static int set_on_stop_move(IntPtr L)
		{
			int result = 0;
			if (WraperUtil.ValidIsUserdata(L, 1, string_set_on_stop_move) && WraperUtil.ValidIsString(L, 2, string_set_on_stop_move))
			{
				NGUIEnchanceScrollViewWrap nGUIEnchanceScrollViewWrap = null;
				string text = null;
				nGUIEnchanceScrollViewWrap = WraperUtil.LuaToUserdata(L, 1, string_set_on_stop_move, NGUIEnchanceScrollViewWrap.cache);
				text = LuaDLL.lua_tostring(L, 2);
				nGUIEnchanceScrollViewWrap.onStopMove = text;
				result = 0;
			}
			return result;
		}

		[MonoPInvokeCallback(typeof(LuaCSFunction))]
		private static int set_on_start_move(IntPtr L)
		{
			int result = 0;
			if (WraperUtil.ValidIsUserdata(L, 1, string_set_on_start_move) && WraperUtil.ValidIsString(L, 2, string_set_on_start_move))
			{
				NGUIEnchanceScrollViewWrap nGUIEnchanceScrollViewWrap = null;
				string text = null;
				nGUIEnchanceScrollViewWrap = WraperUtil.LuaToUserdata(L, 1, string_set_on_start_move, NGUIEnchanceScrollViewWrap.cache);
				text = LuaDLL.lua_tostring(L, 2);
				nGUIEnchanceScrollViewWrap.onStartMove = text;
				result = 0;
			}
			return result;
		}

		[MonoPInvokeCallback(typeof(LuaCSFunction))]
		private static int set_index(IntPtr L)
		{
			int result = 0;
			if (WraperUtil.ValidIsUserdata(L, 1, string_set_index) && WraperUtil.ValidIsNumber(L, 2, string_set_index))
			{
				NGUIEnchanceScrollViewWrap nGUIEnchanceScrollViewWrap = null;
				nGUIEnchanceScrollViewWrap = WraperUtil.LuaToUserdata(L, 1, string_set_index, NGUIEnchanceScrollViewWrap.cache);
				int index = LuaDLL.lua_tointeger(L, 2);
				if (nGUIEnchanceScrollViewWrap != null)
				{
					nGUIEnchanceScrollViewWrap.component.set_index(index);
				}
				result = 0;
			}
			return result;
		}

		[MonoPInvokeCallback(typeof(LuaCSFunction))]
		private static int set_showIndex(IntPtr L)
		{
			int result = 0;
			if (WraperUtil.ValidIsUserdata(L, 1, string_set_showIndex) && WraperUtil.ValidIsNumber(L, 2, string_set_showIndex))
			{
				NGUIEnchanceScrollViewWrap nGUIEnchanceScrollViewWrap = null;
				nGUIEnchanceScrollViewWrap = WraperUtil.LuaToUserdata(L, 1, string_set_showIndex, NGUIEnchanceScrollViewWrap.cache);
				int showIndex = LuaDLL.lua_tointeger(L, 2);
				if (nGUIEnchanceScrollViewWrap != null)
				{
					nGUIEnchanceScrollViewWrap.component.set_showIndex(showIndex);
				}
				result = 0;
			}
			return result;
		}

		[MonoPInvokeCallback(typeof(LuaCSFunction))]
		private static int tween_to_index(IntPtr L)
		{
			int result = 0;
			if (WraperUtil.ValidIsUserdata(L, 1, string_tween_to_index) && WraperUtil.ValidIsNumber(L, 2, string_tween_to_index))
			{
				NGUIEnchanceScrollViewWrap nGUIEnchanceScrollViewWrap = null;
				nGUIEnchanceScrollViewWrap = WraperUtil.LuaToUserdata(L, 1, string_tween_to_index, NGUIEnchanceScrollViewWrap.cache);
				int index = LuaDLL.lua_tointeger(L, 2);
				if (nGUIEnchanceScrollViewWrap != null)
				{
					nGUIEnchanceScrollViewWrap.component.tweenToIndex(index);
				}
				result = 0;
			}
			return result;
		}

		[MonoPInvokeCallback(typeof(LuaCSFunction))]
		private static int refresh_list(IntPtr L)
		{
			int result = 0;
			if (WraperUtil.ValidIsUserdata(L, 1, string_refresh_list))
			{
				NGUIEnchanceScrollViewWrap nGUIEnchanceScrollViewWrap = null;
				nGUIEnchanceScrollViewWrap = WraperUtil.LuaToUserdata(L, 1, string_refresh_list, NGUIEnchanceScrollViewWrap.cache);
				if (nGUIEnchanceScrollViewWrap != null)
				{
					nGUIEnchanceScrollViewWrap.component.refresh_list();
				}
				result = 0;
			}
			return result;
		}

		[MonoPInvokeCallback(typeof(LuaCSFunction))]
		private static int get_game_object(IntPtr L)
		{
			int result = 0;
			if (WraperUtil.ValidIsUserdata(L, 1, string_get_game_object))
			{
				NGUIEnchanceScrollViewWrap nGUIEnchanceScrollViewWrap = null;
				nGUIEnchanceScrollViewWrap = WraperUtil.LuaToUserdata(L, 1, string_get_game_object, NGUIEnchanceScrollViewWrap.cache);
				AssetGameObject base_object = AssetGameObject.CreateByInstance(nGUIEnchanceScrollViewWrap.bcomponent.gameObject);
				WraperUtil.PushObject(L, base_object);
				result = 1;
			}
			return result;
		}

		[MonoPInvokeCallback(typeof(LuaCSFunction))]
		private static int clone(IntPtr L)
		{
			int result = 0;
			if (WraperUtil.ValidIsUserdata(L, 1, string_clone))
			{
				NGUIEnchanceScrollViewWrap nGUIEnchanceScrollViewWrap = null;
				nGUIEnchanceScrollViewWrap = WraperUtil.LuaToUserdata(L, 1, string_clone, NGUIEnchanceScrollViewWrap.cache);
				nGUIEnchanceScrollViewWrap.Clone(L);
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
				NGUIEnchanceScrollViewWrap nGUIEnchanceScrollViewWrap = null;
				nGUIEnchanceScrollViewWrap = WraperUtil.LuaToUserdata(L, 1, string_destroy_object, NGUIEnchanceScrollViewWrap.cache);
				nGUIEnchanceScrollViewWrap.isNeedDestroy = true;
				result = 0;
			}
			return result;
		}

		[MonoPInvokeCallback(typeof(LuaCSFunction))]
		private static int gc(IntPtr L)
		{
			NGUIEnchanceScrollViewWrap nGUIEnchanceScrollViewWrap = WraperUtil.LuaToUserdataByGc(L, 1, "gc ngui_enchancescrollview", NGUIEnchanceScrollViewWrap.cache);
			if (nGUIEnchanceScrollViewWrap != null)
			{
				nGUIEnchanceScrollViewWrap.DestroyInstance();
			}
			return 0;
		}
	}
}
