using System;
using LuaInterface;
using UnityEngine;
using UnityWrap;

namespace Wraper
{
	public class nav_mesh_obstacle_wraper
	{
		public static string name = "nav_mesh_obstacle_object";

		private static luaL_Reg[] func = new luaL_Reg[8]
		{
			new luaL_Reg("set_enable", set_enable),
			new luaL_Reg("set_height", set_height),
			new luaL_Reg("get_height", get_height),
			new luaL_Reg("set_radius", set_radius),
			new luaL_Reg("get_radius", get_radius),
			new luaL_Reg("set_velocity", set_velocity),
			new luaL_Reg("get_velocity", get_velocity),
			new luaL_Reg("set_carving", set_carving)
		};

		private static string string_set_enable = "nav_mesh_obstacle_object:set_enable";

		private static string string_set_height = "nav_mesh_obstacle_object:set_height";

		private static string string_get_height = "nav_mesh_obstacle_object:get_height";

		private static string string_set_radius = "nav_mesh_obstacle_object:set_radius";

		private static string string_get_radius = "nav_mesh_obstacle_object:get_radius";

		private static string string_set_velocity = "nav_mesh_obstacle_object:set_velocity";

		private static string string_get_velocity = "nav_mesh_obstacle_object:get_velocity";

		private static string string_set_carving = "nav_mesh_obstacle_object:set_carving";

		public static bool init(IntPtr L)
		{
			if (L != IntPtr.Zero)
			{
				LuaDLL.register_class(L, name, func, gc);
				return true;
			}
			return false;
		}

		public static void push(IntPtr L, NavMeshObstacleWrap obj)
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
		private static int set_enable(IntPtr L)
		{
			int result = 0;
			if (WraperUtil.ValidIsUserdata(L, 1, string_set_enable) && WraperUtil.ValidIsBoolean(L, 2, string_set_enable))
			{
				NavMeshObstacleWrap navMeshObstacleWrap = null;
				bool flag = false;
				navMeshObstacleWrap = WraperUtil.LuaToUserdata(L, 1, string_set_enable, NavMeshObstacleWrap.cache);
				flag = LuaDLL.lua_toboolean(L, 2);
				navMeshObstacleWrap.component.enabled = flag;
				result = 0;
			}
			return result;
		}

		[MonoPInvokeCallback(typeof(LuaCSFunction))]
		private static int set_height(IntPtr L)
		{
			int result = 0;
			if (WraperUtil.ValidIsUserdata(L, 1, string_set_height) && WraperUtil.ValidIsNumber(L, 2, string_set_height))
			{
				NavMeshObstacleWrap navMeshObstacleWrap = null;
				float num = 0f;
				navMeshObstacleWrap = WraperUtil.LuaToUserdata(L, 1, string_set_height, NavMeshObstacleWrap.cache);
				num = (float)LuaDLL.lua_tonumber(L, 2);
				navMeshObstacleWrap.component.height = num;
				result = 0;
			}
			return result;
		}

		[MonoPInvokeCallback(typeof(LuaCSFunction))]
		private static int get_height(IntPtr L)
		{
			int result = 0;
			if (WraperUtil.ValidIsUserdata(L, 1, string_get_height))
			{
				NavMeshObstacleWrap navMeshObstacleWrap = null;
				navMeshObstacleWrap = WraperUtil.LuaToUserdata(L, 1, string_get_height, NavMeshObstacleWrap.cache);
				LuaDLL.lua_pushnumber(L, navMeshObstacleWrap.component.height);
				result = 1;
			}
			return result;
		}

		[MonoPInvokeCallback(typeof(LuaCSFunction))]
		private static int set_radius(IntPtr L)
		{
			int result = 0;
			if (WraperUtil.ValidIsUserdata(L, 1, string_set_radius) && WraperUtil.ValidIsNumber(L, 2, string_set_radius))
			{
				NavMeshObstacleWrap navMeshObstacleWrap = null;
				float num = 0f;
				navMeshObstacleWrap = WraperUtil.LuaToUserdata(L, 1, string_set_radius, NavMeshObstacleWrap.cache);
				num = (float)LuaDLL.lua_tonumber(L, 2);
				navMeshObstacleWrap.component.radius = num;
				result = 0;
			}
			return result;
		}

		[MonoPInvokeCallback(typeof(LuaCSFunction))]
		private static int get_radius(IntPtr L)
		{
			int result = 0;
			if (WraperUtil.ValidIsUserdata(L, 1, string_get_radius))
			{
				NavMeshObstacleWrap navMeshObstacleWrap = null;
				navMeshObstacleWrap = WraperUtil.LuaToUserdata(L, 1, string_get_radius, NavMeshObstacleWrap.cache);
				LuaDLL.lua_pushnumber(L, navMeshObstacleWrap.component.radius);
				result = 1;
			}
			return result;
		}

		[MonoPInvokeCallback(typeof(LuaCSFunction))]
		private static int set_velocity(IntPtr L)
		{
			int result = 0;
			if (WraperUtil.ValidIsUserdata(L, 1, string_set_velocity) && WraperUtil.ValidIsNumber(L, 2, string_set_velocity) && WraperUtil.ValidIsNumber(L, 3, string_set_velocity) && WraperUtil.ValidIsNumber(L, 4, string_set_velocity))
			{
				NavMeshObstacleWrap navMeshObstacleWrap = null;
				float num = 0f;
				float num2 = 0f;
				float num3 = 0f;
				navMeshObstacleWrap = WraperUtil.LuaToUserdata(L, 1, string_set_velocity, NavMeshObstacleWrap.cache);
				num = (float)LuaDLL.lua_tonumber(L, 2);
				num2 = (float)LuaDLL.lua_tonumber(L, 3);
				num3 = (float)LuaDLL.lua_tonumber(L, 4);
				navMeshObstacleWrap.component.velocity = new Vector3(num, num2, num3);
				result = 0;
			}
			return result;
		}

		[MonoPInvokeCallback(typeof(LuaCSFunction))]
		private static int get_velocity(IntPtr L)
		{
			int result = 0;
			if (WraperUtil.ValidIsUserdata(L, 1, string_get_velocity))
			{
				NavMeshObstacleWrap navMeshObstacleWrap = null;
				navMeshObstacleWrap = WraperUtil.LuaToUserdata(L, 1, string_get_velocity, NavMeshObstacleWrap.cache);
				LuaDLL.lua_pushnumber(L, navMeshObstacleWrap.component.velocity.x);
				LuaDLL.lua_pushnumber(L, navMeshObstacleWrap.component.velocity.y);
				LuaDLL.lua_pushnumber(L, navMeshObstacleWrap.component.velocity.z);
				result = 3;
			}
			return result;
		}

		[MonoPInvokeCallback(typeof(LuaCSFunction))]
		private static int gc(IntPtr L)
		{
			NavMeshObstacleWrap navMeshObstacleWrap = WraperUtil.LuaToUserdataByGc(L, 1, "gc nav_mesh_obstacle_object", NavMeshObstacleWrap.cache);
			if (navMeshObstacleWrap != null)
			{
				NavMeshObstacleWrap.DestroyInstance(navMeshObstacleWrap);
			}
			return 0;
		}

		[MonoPInvokeCallback(typeof(LuaCSFunction))]
		private static int set_carving(IntPtr L)
		{
			int result = 0;
			if (WraperUtil.ValidIsUserdata(L, 1, string_set_carving) && WraperUtil.ValidIsBoolean(L, 2, string_set_carving))
			{
				NavMeshObstacleWrap navMeshObstacleWrap = null;
				navMeshObstacleWrap = WraperUtil.LuaToUserdata(L, 1, string_set_carving, NavMeshObstacleWrap.cache);
				bool carving = LuaDLL.lua_toboolean(L, 2);
				navMeshObstacleWrap.component.carving = carving;
				result = 0;
			}
			return result;
		}
	}
}
