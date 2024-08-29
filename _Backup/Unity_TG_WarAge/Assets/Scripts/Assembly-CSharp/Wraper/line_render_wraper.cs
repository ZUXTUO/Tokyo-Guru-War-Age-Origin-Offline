using System;
using LuaInterface;
using UnityEngine;
using UnityWrap;

namespace Wraper
{
	public class line_render_wraper
	{
		public static string name = "line_render_object";

		private static luaL_Reg[] func = new luaL_Reg[4]
		{
			new luaL_Reg("set_vertex_number", set_vertex_number),
			new luaL_Reg("set_vertex", set_vertex),
			new luaL_Reg("set_colors", set_colors),
			new luaL_Reg("set_width", set_width)
		};

		private static string string_set_vertex_number = "line_render_object:set_vertex_number";

		private static string string_set_vertex = "line_render_object:set_vertex";

		private static string string_set_colors = "line_render_object:set_colors";

		private static string string_set_width = "line_render_object:set_width";

		public static bool init(IntPtr L)
		{
			if (L != IntPtr.Zero)
			{
				LuaDLL.register_class(L, name, func, gc);
				return true;
			}
			return false;
		}

		public static void push(IntPtr L, LineRenderWrap obj)
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
		private static int set_vertex_number(IntPtr L)
		{
			int result = 0;
			if (WraperUtil.ValidIsUserdata(L, 1, string_set_vertex_number) && WraperUtil.ValidIsNumber(L, 2, string_set_vertex_number))
			{
				LineRenderWrap lineRenderWrap = null;
				int num = 0;
				lineRenderWrap = WraperUtil.LuaToUserdata(L, 1, string_set_vertex_number, LineRenderWrap.cache);
				num = (int)LuaDLL.lua_tonumber(L, 2);
				if (lineRenderWrap != null)
				{
					lineRenderWrap.component.SetVertexCount(num);
				}
				result = 0;
			}
			return result;
		}

		[MonoPInvokeCallback(typeof(LuaCSFunction))]
		private static int set_vertex(IntPtr L)
		{
			int result = 0;
			if (WraperUtil.ValidIsUserdata(L, 1, string_set_vertex) && WraperUtil.ValidIsNumber(L, 2, string_set_vertex) && WraperUtil.ValidIsNumber(L, 3, string_set_vertex) && WraperUtil.ValidIsNumber(L, 4, string_set_vertex) && WraperUtil.ValidIsNumber(L, 5, string_set_vertex))
			{
				LineRenderWrap lineRenderWrap = null;
				int num = 0;
				float num2 = 0f;
				float num3 = 0f;
				float num4 = 0f;
				lineRenderWrap = WraperUtil.LuaToUserdata(L, 1, string_set_vertex, LineRenderWrap.cache);
				num = (int)LuaDLL.lua_tonumber(L, 2);
				num2 = (float)LuaDLL.lua_tonumber(L, 3);
				num3 = (float)LuaDLL.lua_tonumber(L, 4);
				num4 = (float)LuaDLL.lua_tonumber(L, 5);
				if (lineRenderWrap != null)
				{
					lineRenderWrap.component.SetPosition(num, new Vector3(num2, num3, num4));
				}
				result = 0;
			}
			return result;
		}

		[MonoPInvokeCallback(typeof(LuaCSFunction))]
		private static int set_colors(IntPtr L)
		{
			int result = 0;
			if (WraperUtil.ValidIsUserdata(L, 1, string_set_colors) && WraperUtil.ValidIsNumber(L, 2, string_set_colors) && WraperUtil.ValidIsNumber(L, 3, string_set_colors) && WraperUtil.ValidIsNumber(L, 4, string_set_colors) && WraperUtil.ValidIsNumber(L, 5, string_set_colors) && WraperUtil.ValidIsNumber(L, 6, string_set_colors) && WraperUtil.ValidIsNumber(L, 7, string_set_colors) && WraperUtil.ValidIsNumber(L, 8, string_set_colors) && WraperUtil.ValidIsNumber(L, 9, string_set_colors))
			{
				LineRenderWrap lineRenderWrap = null;
				float num = 0f;
				float num2 = 0f;
				float num3 = 0f;
				float num4 = 0f;
				float num5 = 0f;
				float num6 = 0f;
				float num7 = 0f;
				float num8 = 0f;
				lineRenderWrap = WraperUtil.LuaToUserdata(L, 1, string_set_colors, LineRenderWrap.cache);
				num = (float)LuaDLL.lua_tonumber(L, 2);
				num2 = (float)LuaDLL.lua_tonumber(L, 3);
				num3 = (float)LuaDLL.lua_tonumber(L, 4);
				num4 = (float)LuaDLL.lua_tonumber(L, 5);
				num5 = (float)LuaDLL.lua_tonumber(L, 6);
				num6 = (float)LuaDLL.lua_tonumber(L, 7);
				num7 = (float)LuaDLL.lua_tonumber(L, 8);
				num8 = (float)LuaDLL.lua_tonumber(L, 9);
				if (lineRenderWrap != null)
				{
					lineRenderWrap.component.SetColors(new Color(num, num2, num3, num4), new Color(num5, num6, num7, num8));
				}
				result = 0;
			}
			return result;
		}

		[MonoPInvokeCallback(typeof(LuaCSFunction))]
		private static int set_width(IntPtr L)
		{
			int result = 0;
			if (WraperUtil.ValidIsUserdata(L, 1, string_set_width) && WraperUtil.ValidIsNumber(L, 2, string_set_width) && WraperUtil.ValidIsNumber(L, 3, string_set_width))
			{
				LineRenderWrap lineRenderWrap = null;
				float num = 0f;
				float num2 = 0f;
				lineRenderWrap = WraperUtil.LuaToUserdata(L, 1, string_set_width, LineRenderWrap.cache);
				num = (float)LuaDLL.lua_tonumber(L, 2);
				num2 = (float)LuaDLL.lua_tonumber(L, 3);
				if (lineRenderWrap != null)
				{
					lineRenderWrap.component.SetWidth(num, num2);
				}
				result = 0;
			}
			return result;
		}

		[MonoPInvokeCallback(typeof(LuaCSFunction))]
		private static int gc(IntPtr L)
		{
			LineRenderWrap lineRenderWrap = WraperUtil.LuaToUserdataByGc(L, 1, "gc line_render_object", LineRenderWrap.cache);
			if (lineRenderWrap != null)
			{
				LineRenderWrap.DestroyInstance(lineRenderWrap);
			}
			return 0;
		}
	}
}
