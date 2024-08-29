using System;
using LuaInterface;
using UnityEngine;
using UnityWrap;

namespace Wraper
{
	public class ngui_bezierpathspline_wraper
	{
		public static string name = "ngui_bezierpathspline";

		private static luaL_Reg[] func = new luaL_Reg[10]
		{
			new luaL_Reg("set_active", set_active),
			new luaL_Reg("set_updatechange", set_updatechange),
			new luaL_Reg("set_showindex", set_showindex),
			new luaL_Reg("set_switchindex", set_switchindex),
			new luaL_Reg("tween_to_showindex", tween_to_showindex),
			new luaL_Reg("tween_to_switchindex", tween_to_switchindex),
			new luaL_Reg("get_key_point", get_key_point),
			new luaL_Reg("drawline", drawline),
			new luaL_Reg("set_show_end_call", set_show_end_call),
			new luaL_Reg("set_switch_end_call", set_switch_end_call)
		};

		private static string string_set_active = "ngui_bezierpathspline:set_active";

		private static string string_set_updatechange = "ngui_bezierpathspline:set_updatechange";

		private static string string_set_showindex = "ngui_bezierpathspline:set_showindex";

		private static string string_set_switchindex = "ngui_bezierpathspline:set_switchindex";

		private static string string_tween_to_showindex = "ngui_bezierpathspline:tween_to_showindex";

		private static string string_tween_to_switchindex = "ngui_bezierpathspline:tween_to_switchindex";

		private static string string_drawline = "ngui_bezierpathspline:drawline";

		private static string string_set_show_end_call = "ngui_bezierpathspline:set_show_end_call";

		private static string string_set_switch_end_call = "ngui_bezierpathspline:set_switch_end_call";

		public static bool init(IntPtr L)
		{
			if (L != IntPtr.Zero)
			{
				LuaDLL.register_class(L, name, func, gc);
				return true;
			}
			return false;
		}

		public static void push(IntPtr L, MaterialWrap obj)
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
		private static int set_active(IntPtr L)
		{
			int result = 0;
			if (WraperUtil.ValidIsUserdata(L, 1, string_set_active) && WraperUtil.ValidIsBoolean(L, 2, string_set_active))
			{
				NGUIBezierPathSplineWrap nGUIBezierPathSplineWrap = null;
				bool flag = false;
				nGUIBezierPathSplineWrap = WraperUtil.LuaToUserdata(L, 1, string_set_active, NGUIBezierPathSplineWrap.cache);
				flag = LuaDLL.lua_toboolean(L, 2);
				nGUIBezierPathSplineWrap.bcomponent.gameObject.SetActive(flag);
				result = 0;
			}
			return result;
		}

		[MonoPInvokeCallback(typeof(LuaCSFunction))]
		private static int set_updatechange(IntPtr L)
		{
			int result = 0;
			if (WraperUtil.ValidIsUserdata(L, 1, string_set_updatechange) && WraperUtil.ValidIsBoolean(L, 2, string_set_updatechange))
			{
				NGUIBezierPathSplineWrap nGUIBezierPathSplineWrap = WraperUtil.LuaToUserdata(L, 1, string_set_updatechange, NGUIBezierPathSplineWrap.cache);
				bool updateChange = LuaDLL.lua_toboolean(L, 2);
				if (nGUIBezierPathSplineWrap != null)
				{
					nGUIBezierPathSplineWrap.component.updateChange = updateChange;
				}
				result = 0;
			}
			return result;
		}

		[MonoPInvokeCallback(typeof(LuaCSFunction))]
		private static int set_showindex(IntPtr L)
		{
			int result = 0;
			if (WraperUtil.ValidIsUserdata(L, 1, string_set_showindex) && WraperUtil.ValidIsNumber(L, 2, string_set_showindex))
			{
				NGUIBezierPathSplineWrap nGUIBezierPathSplineWrap = WraperUtil.LuaToUserdata(L, 1, string_set_showindex, NGUIBezierPathSplineWrap.cache);
				int showIndex = (int)LuaDLL.lua_tonumber(L, 2);
				if (nGUIBezierPathSplineWrap != null)
				{
					nGUIBezierPathSplineWrap.component.SetShowIndex(showIndex);
				}
				result = 0;
			}
			return result;
		}

		[MonoPInvokeCallback(typeof(LuaCSFunction))]
		private static int set_switchindex(IntPtr L)
		{
			int result = 0;
			if (WraperUtil.ValidIsUserdata(L, 1, string_set_switchindex) && WraperUtil.ValidIsNumber(L, 2, string_set_switchindex))
			{
				NGUIBezierPathSplineWrap nGUIBezierPathSplineWrap = WraperUtil.LuaToUserdata(L, 1, string_set_switchindex, NGUIBezierPathSplineWrap.cache);
				int switchIndex = (int)LuaDLL.lua_tonumber(L, 2);
				if (nGUIBezierPathSplineWrap != null)
				{
					nGUIBezierPathSplineWrap.component.SetSwitchIndex(switchIndex);
				}
				result = 0;
			}
			return result;
		}

		[MonoPInvokeCallback(typeof(LuaCSFunction))]
		private static int tween_to_showindex(IntPtr L)
		{
			int result = 0;
			if (WraperUtil.ValidIsUserdata(L, 1, string_tween_to_showindex) && WraperUtil.ValidIsNumber(L, 2, string_tween_to_showindex) && WraperUtil.ValidIsNumber(L, 3, string_tween_to_showindex))
			{
				NGUIBezierPathSplineWrap nGUIBezierPathSplineWrap = WraperUtil.LuaToUserdata(L, 1, string_tween_to_showindex, NGUIBezierPathSplineWrap.cache);
				int index = (int)LuaDLL.lua_tonumber(L, 2);
				float time = (float)LuaDLL.lua_tonumber(L, 3);
				if (nGUIBezierPathSplineWrap != null)
				{
					nGUIBezierPathSplineWrap.component.TweenToShowIndex(index, time);
				}
				result = 0;
			}
			return result;
		}

		[MonoPInvokeCallback(typeof(LuaCSFunction))]
		private static int tween_to_switchindex(IntPtr L)
		{
			int result = 0;
			if (WraperUtil.ValidIsUserdata(L, 1, string_tween_to_switchindex) && WraperUtil.ValidIsNumber(L, 2, string_tween_to_switchindex) && WraperUtil.ValidIsNumber(L, 3, string_tween_to_switchindex))
			{
				NGUIBezierPathSplineWrap nGUIBezierPathSplineWrap = WraperUtil.LuaToUserdata(L, 1, string_tween_to_switchindex, NGUIBezierPathSplineWrap.cache);
				int index = (int)LuaDLL.lua_tonumber(L, 2);
				float time = (float)LuaDLL.lua_tonumber(L, 3);
				if (nGUIBezierPathSplineWrap != null)
				{
					nGUIBezierPathSplineWrap.component.TweenToSwitchIndex(index, time);
				}
				result = 0;
			}
			return result;
		}

		[MonoPInvokeCallback(typeof(LuaCSFunction))]
		private static int get_key_point(IntPtr L)
		{
			int result = 0;
			if (WraperUtil.ValidIsUserdata(L, 1, string_tween_to_switchindex))
			{
				NGUIBezierPathSplineWrap nGUIBezierPathSplineWrap = WraperUtil.LuaToUserdata(L, 1, string_tween_to_switchindex, NGUIBezierPathSplineWrap.cache);
				if (nGUIBezierPathSplineWrap != null)
				{
					BezierPathSpline component = nGUIBezierPathSplineWrap.component;
					int count = component.lines.Count;
					Vector3[] array = new Vector3[count + 1];
					for (int i = 0; i < count; i++)
					{
						if (component.transform.parent != null)
						{
							array[i] = component.transform.parent.worldToLocalMatrix.MultiplyPoint(component.lines[i].keyStart);
							if (i == count - 1)
							{
								array[i + 1] = component.transform.parent.worldToLocalMatrix.MultiplyPoint(component.lines[i].keyEnd);
							}
						}
						else
						{
							array[i] = component.transform.worldToLocalMatrix.MultiplyPoint(component.lines[i].keyStart);
							if (i == count - 1)
							{
								array[i + 1] = component.transform.worldToLocalMatrix.MultiplyPoint(component.lines[i].keyEnd);
							}
						}
					}
					WraperUtil.Push(L, array);
					result = 1;
				}
			}
			return result;
		}

		[MonoPInvokeCallback(typeof(LuaCSFunction))]
		private static int drawline(IntPtr L)
		{
			int result = 0;
			if (WraperUtil.ValidIsUserdata(L, 1, string_drawline))
			{
				NGUIBezierPathSplineWrap nGUIBezierPathSplineWrap = WraperUtil.LuaToUserdata(L, 1, string_drawline, NGUIBezierPathSplineWrap.cache);
				if (nGUIBezierPathSplineWrap != null)
				{
					nGUIBezierPathSplineWrap.component.DrawCurve();
				}
				result = 0;
			}
			return result;
		}

		[MonoPInvokeCallback(typeof(LuaCSFunction))]
		private static int set_show_end_call(IntPtr L)
		{
			int result = 0;
			if (WraperUtil.ValidIsUserdata(L, 1, string_set_show_end_call) && WraperUtil.ValidIsString(L, 2, string_set_show_end_call))
			{
				NGUIBezierPathSplineWrap nGUIBezierPathSplineWrap = WraperUtil.LuaToUserdata(L, 1, string_set_show_end_call, NGUIBezierPathSplineWrap.cache);
				if (nGUIBezierPathSplineWrap != null)
				{
					string onShowEndCall = LuaDLL.lua_tostring(L, 2);
					nGUIBezierPathSplineWrap.onShowEndCall = onShowEndCall;
				}
				result = 0;
			}
			return result;
		}

		[MonoPInvokeCallback(typeof(LuaCSFunction))]
		private static int set_switch_end_call(IntPtr L)
		{
			int result = 0;
			if (WraperUtil.ValidIsUserdata(L, 1, string_set_switch_end_call) && WraperUtil.ValidIsString(L, 2, string_set_switch_end_call))
			{
				NGUIBezierPathSplineWrap nGUIBezierPathSplineWrap = WraperUtil.LuaToUserdata(L, 1, string_set_switch_end_call, NGUIBezierPathSplineWrap.cache);
				if (nGUIBezierPathSplineWrap != null)
				{
					string onSwitchEndCall = LuaDLL.lua_tostring(L, 2);
					nGUIBezierPathSplineWrap.onSwitchEndCall = onSwitchEndCall;
				}
				result = 0;
			}
			return result;
		}

		[MonoPInvokeCallback(typeof(LuaCSFunction))]
		private static int gc(IntPtr L)
		{
			NGUIBezierPathSplineWrap nGUIBezierPathSplineWrap = WraperUtil.LuaToUserdataByGc(L, 1, "gc ngui_bezierpathspline", NGUIBezierPathSplineWrap.cache);
			if (nGUIBezierPathSplineWrap != null)
			{
				nGUIBezierPathSplineWrap.DestroyInstance();
			}
			return 0;
		}
	}
}
