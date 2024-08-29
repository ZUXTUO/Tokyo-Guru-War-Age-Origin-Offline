using System;
using LuaInterface;
using UnityEngine;
using UnityEngine.AI;
using UnityWrap;

namespace Wraper
{
	public class nav_mesh_agent_wraper
	{
		public static string name = "nav_mesh_agent_object";

		private static luaL_Reg[] func = new luaL_Reg[32]
		{
			new luaL_Reg("set_enable", set_enable),
			new luaL_Reg("get_enable", get_enable),
			new luaL_Reg("set_destination", set_destination),
			new luaL_Reg("set_speed", set_speed),
			new luaL_Reg("get_speed", get_speed),
			new luaL_Reg("set_angular_speed", set_angular_speed),
			new luaL_Reg("get_angular_speed", get_angular_speed),
			new luaL_Reg("set_acceleration", set_acceleration),
			new luaL_Reg("get_acceleration", get_acceleration),
			new luaL_Reg("get_velocity", get_velocity),
			new luaL_Reg("stop", stop),
			new luaL_Reg("resume", resume),
			new luaL_Reg("calculate_path", calculate_path),
			new luaL_Reg("get_path_pending", get_path_pending),
			new luaL_Reg("set_update_position", set_update_position),
			new luaL_Reg("get_update_position", get_update_position),
			new luaL_Reg("set_update_rotation", set_update_rotation),
			new luaL_Reg("get_update_rotation", get_update_rotation),
			new luaL_Reg("set_next_position", set_next_position),
			new luaL_Reg("get_next_position", get_next_position),
			new luaL_Reg("reset_path", reset_path),
			new luaL_Reg("find_closest_edge", find_closest_edge),
			new luaL_Reg("get_radius", get_radius),
			new luaL_Reg("set_radius", set_radius),
			new luaL_Reg("set_area_mask", set_area_mask),
			new luaL_Reg("get_area_mask", get_area_mask),
			new luaL_Reg("ray_cast", ray_cast),
			new luaL_Reg("get_path", get_path),
			new luaL_Reg("set_auto_braking", set_auto_braking),
			new luaL_Reg("get_auto_braking", get_auto_braking),
			new luaL_Reg("set_obstacle_avoidance_type", set_obstacle_avoidance_type),
			new luaL_Reg("get_obstacle_avoidance_type", get_obstacle_avoidance_type)
		};

		private static string string_set_enable = "nav_mesh_agent_object:set_enable";

		private static string string_get_enable = "nav_mesh_agent_object:get_enable";

		private static string string_set_destination = "nav_mesh_agent_object:set_destination";

		private static string string_set_speed = "nav_mesh_agent_object:set_speed";

		private static string string_get_speed = "nav_mesh_agent_object:get_speed";

		private static string string_set_angular_speed = "nav_mesh_agent_object:set_angular_speed";

		private static string string_get_angular_speed = "nav_mesh_agent_object:get_angular_speed";

		private static string string_set_acceleration = "nav_mesh_agent_object:set_acceleration";

		private static string string_get_acceleration = "nav_mesh_agent_object:get_acceleration";

		private static string string_get_velocity = "nav_mesh_agent_object:get_velocity";

		private static string string_stop = "nav_mesh_agent_object:stop";

		private static string string_resume = "nav_mesh_agent_object:resume";

		private static string string_calculate_path = "nav_mesh_agent_object:calculate_path";

		private static string string_get_path_pending = "nav_mesh_agent_object:get_path_pending";

		private static string string_set_update_position = "nav_mesh_agent_object:set_update_position";

		private static string string_get_update_position = "nav_mesh_agent_object:get_update_position";

		private static string string_set_update_rotation = "nav_mesh_agent_object:set_update_rotation";

		private static string string_get_update_rotation = "nav_mesh_agent_object:get_update_rotation";

		private static string string_set_next_position = "nav_mesh_agent_object:set_next_position";

		private static string string_get_next_position = "nav_mesh_agent_object:get_next_position";

		private static string string_reset_path = "nav_mesh_agent_object:reset_path";

		private static string string_find_closest_edge = "nav_mesh_agent_object:find_closest_edge";

		private static string string_get_radius = "nav_mesh_agent_object:get_radius";

		private static string string_set_radius = "nav_mesh_agent_object:set_radius";

		private static string string_set_area_mask = "nav_mesh_agent_object:set_area_mask";

		private static string string_get_area_mask = "nav_mesh_agent_object:get_area_mask";

		private static string string_ray_cast = "nav_mesh_agent_object:ray_cast";

		private static string string_get_path = "nav_mesh_agent_object:get_path";

		private static string string_set_auto_braking = "nav_mesh_agent_object:set_auto_braking";

		private static string string_get_auto_braking = "nav_mesh_agent_object:get_auto_braking";

		private static string string_set_obstacle_avoidance_type = "nav_mesh_agent_object:set_obstacle_avoidance_type";

		private static string string_get_obstacle_avoidance_type = "nav_mesh_agent_object:get_obstacle_avoidance_type";

		public static bool init(IntPtr L)
		{
			if (L != IntPtr.Zero)
			{
				LuaDLL.register_class(L, name, func, gc);
				return true;
			}
			return false;
		}

		public static void push(IntPtr L, NavMeshAgentWrap obj)
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
				NavMeshAgentWrap navMeshAgentWrap = null;
				bool flag = false;
				navMeshAgentWrap = WraperUtil.LuaToUserdata(L, 1, string_set_enable, NavMeshAgentWrap.cache);
				flag = LuaDLL.lua_toboolean(L, 2);
				navMeshAgentWrap.component.enabled = flag;
				result = 0;
			}
			return result;
		}

		[MonoPInvokeCallback(typeof(LuaCSFunction))]
		private static int get_enable(IntPtr L)
		{
			int result = 0;
			if (WraperUtil.ValidIsUserdata(L, 1, string_get_enable))
			{
				NavMeshAgentWrap navMeshAgentWrap = null;
				navMeshAgentWrap = WraperUtil.LuaToUserdata(L, 1, string_get_enable, NavMeshAgentWrap.cache);
				LuaDLL.lua_pushboolean(L, navMeshAgentWrap.component.enabled);
				result = 1;
			}
			return result;
		}

		[MonoPInvokeCallback(typeof(LuaCSFunction))]
		private static int set_destination(IntPtr L)
		{
			int result = 0;
			if (WraperUtil.ValidIsUserdata(L, 1, string_set_destination) && WraperUtil.ValidIsNumber(L, 2, string_set_destination) && WraperUtil.ValidIsNumber(L, 3, string_set_destination) && WraperUtil.ValidIsNumber(L, 4, string_set_destination))
			{
				NavMeshAgentWrap navMeshAgentWrap = null;
				float num = 0f;
				float num2 = 0f;
				float num3 = 0f;
				navMeshAgentWrap = WraperUtil.LuaToUserdata(L, 1, string_set_destination, NavMeshAgentWrap.cache);
				num = (float)LuaDLL.lua_tonumber(L, 2);
				num2 = (float)LuaDLL.lua_tonumber(L, 3);
				num3 = (float)LuaDLL.lua_tonumber(L, 4);
				navMeshAgentWrap.component.SetDestination(new Vector3(num, num2, num3));
				result = 0;
			}
			return result;
		}

		[MonoPInvokeCallback(typeof(LuaCSFunction))]
		private static int set_speed(IntPtr L)
		{
			int result = 0;
			if (WraperUtil.ValidIsUserdata(L, 1, string_set_speed) && WraperUtil.ValidIsNumber(L, 2, string_set_speed))
			{
				NavMeshAgentWrap navMeshAgentWrap = null;
				float num = 0f;
				navMeshAgentWrap = WraperUtil.LuaToUserdata(L, 1, string_set_speed, NavMeshAgentWrap.cache);
				num = (float)LuaDLL.lua_tonumber(L, 2);
				navMeshAgentWrap.component.speed = num;
				result = 0;
			}
			return result;
		}

		[MonoPInvokeCallback(typeof(LuaCSFunction))]
		private static int get_speed(IntPtr L)
		{
			int result = 0;
			if (WraperUtil.ValidIsUserdata(L, 1, string_get_speed))
			{
				NavMeshAgentWrap navMeshAgentWrap = null;
				navMeshAgentWrap = WraperUtil.LuaToUserdata(L, 1, string_get_speed, NavMeshAgentWrap.cache);
				LuaDLL.lua_pushnumber(L, navMeshAgentWrap.component.speed);
				result = 1;
			}
			return result;
		}

		[MonoPInvokeCallback(typeof(LuaCSFunction))]
		private static int set_angular_speed(IntPtr L)
		{
			int result = 0;
			if (WraperUtil.ValidIsUserdata(L, 1, string_set_angular_speed) && WraperUtil.ValidIsNumber(L, 2, string_set_angular_speed))
			{
				NavMeshAgentWrap navMeshAgentWrap = null;
				float num = 0f;
				navMeshAgentWrap = WraperUtil.LuaToUserdata(L, 1, string_set_angular_speed, NavMeshAgentWrap.cache);
				num = (float)LuaDLL.lua_tonumber(L, 2);
				navMeshAgentWrap.component.angularSpeed = num;
				result = 0;
			}
			return result;
		}

		[MonoPInvokeCallback(typeof(LuaCSFunction))]
		private static int get_angular_speed(IntPtr L)
		{
			int result = 0;
			if (WraperUtil.ValidIsUserdata(L, 1, string_get_angular_speed))
			{
				NavMeshAgentWrap navMeshAgentWrap = null;
				navMeshAgentWrap = WraperUtil.LuaToUserdata(L, 1, string_get_angular_speed, NavMeshAgentWrap.cache);
				LuaDLL.lua_pushnumber(L, navMeshAgentWrap.component.angularSpeed);
				result = 1;
			}
			return result;
		}

		[MonoPInvokeCallback(typeof(LuaCSFunction))]
		private static int set_acceleration(IntPtr L)
		{
			int result = 0;
			if (WraperUtil.ValidIsUserdata(L, 1, string_set_acceleration) && WraperUtil.ValidIsNumber(L, 2, string_set_acceleration))
			{
				NavMeshAgentWrap navMeshAgentWrap = null;
				float num = 0f;
				navMeshAgentWrap = WraperUtil.LuaToUserdata(L, 1, string_set_acceleration, NavMeshAgentWrap.cache);
				num = (float)LuaDLL.lua_tonumber(L, 2);
				navMeshAgentWrap.component.acceleration = num;
				result = 0;
			}
			return result;
		}

		[MonoPInvokeCallback(typeof(LuaCSFunction))]
		private static int get_acceleration(IntPtr L)
		{
			int result = 0;
			if (WraperUtil.ValidIsUserdata(L, 1, string_get_acceleration))
			{
				NavMeshAgentWrap navMeshAgentWrap = null;
				navMeshAgentWrap = WraperUtil.LuaToUserdata(L, 1, string_get_acceleration, NavMeshAgentWrap.cache);
				LuaDLL.lua_pushnumber(L, navMeshAgentWrap.component.acceleration);
				result = 1;
			}
			return result;
		}

		[MonoPInvokeCallback(typeof(LuaCSFunction))]
		private static int get_velocity(IntPtr L)
		{
			int result = 0;
			if (WraperUtil.ValidIsUserdata(L, 1, string_get_velocity))
			{
				NavMeshAgentWrap navMeshAgentWrap = null;
				navMeshAgentWrap = WraperUtil.LuaToUserdata(L, 1, string_get_velocity, NavMeshAgentWrap.cache);
				LuaDLL.lua_pushnumber(L, navMeshAgentWrap.component.velocity.x);
				LuaDLL.lua_pushnumber(L, navMeshAgentWrap.component.velocity.y);
				LuaDLL.lua_pushnumber(L, navMeshAgentWrap.component.velocity.z);
				result = 3;
			}
			return result;
		}

		[MonoPInvokeCallback(typeof(LuaCSFunction))]
		private static int stop(IntPtr L)
		{
			int result = 0;
			if (WraperUtil.ValidIsUserdata(L, 1, string_stop) && WraperUtil.ValidIsBoolean(L, 2, string_stop))
			{
				NavMeshAgentWrap navMeshAgentWrap = null;
				bool flag = false;
				navMeshAgentWrap = WraperUtil.LuaToUserdata(L, 1, string_stop, NavMeshAgentWrap.cache);
				flag = LuaDLL.lua_toboolean(L, 2);
				navMeshAgentWrap.component.Stop(flag);
				result = 0;
			}
			return result;
		}

		[MonoPInvokeCallback(typeof(LuaCSFunction))]
		private static int resume(IntPtr L)
		{
			int result = 0;
			if (WraperUtil.ValidIsUserdata(L, 1, string_resume))
			{
				NavMeshAgentWrap navMeshAgentWrap = null;
				navMeshAgentWrap = WraperUtil.LuaToUserdata(L, 1, string_resume, NavMeshAgentWrap.cache);
				navMeshAgentWrap.component.Resume();
				result = 0;
			}
			return result;
		}

		[MonoPInvokeCallback(typeof(LuaCSFunction))]
		private static int calculate_path(IntPtr L)
		{
			int result = 0;
			if (WraperUtil.ValidIsUserdata(L, 1, string_calculate_path) && WraperUtil.ValidIsNumber(L, 2, string_calculate_path) && WraperUtil.ValidIsNumber(L, 3, string_calculate_path) && WraperUtil.ValidIsNumber(L, 4, string_calculate_path))
			{
				NavMeshAgentWrap navMeshAgentWrap = null;
				float num = 0f;
				float num2 = 0f;
				float num3 = 0f;
				navMeshAgentWrap = WraperUtil.LuaToUserdata(L, 1, string_calculate_path, NavMeshAgentWrap.cache);
				num = (float)LuaDLL.lua_tonumber(L, 2);
				num2 = (float)LuaDLL.lua_tonumber(L, 3);
				num3 = (float)LuaDLL.lua_tonumber(L, 4);
				NavMeshPath navMeshPath = new NavMeshPath();
				if (navMeshAgentWrap.component.CalculatePath(new Vector3(num, num2, num3), navMeshPath))
				{
					WraperUtil.Push(L, navMeshPath);
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
		private static int get_path_pending(IntPtr L)
		{
			int result = 0;
			if (WraperUtil.ValidIsUserdata(L, 1, string_get_path_pending))
			{
				NavMeshAgentWrap navMeshAgentWrap = null;
				navMeshAgentWrap = WraperUtil.LuaToUserdata(L, 1, string_get_path_pending, NavMeshAgentWrap.cache);
				LuaDLL.lua_pushboolean(L, navMeshAgentWrap.component.pathPending);
				result = 1;
			}
			return result;
		}

		[MonoPInvokeCallback(typeof(LuaCSFunction))]
		private static int set_update_position(IntPtr L)
		{
			int result = 0;
			if (WraperUtil.ValidIsUserdata(L, 1, string_set_update_position) && WraperUtil.ValidIsBoolean(L, 2, string_set_update_position))
			{
				NavMeshAgentWrap navMeshAgentWrap = null;
				bool flag = false;
				navMeshAgentWrap = WraperUtil.LuaToUserdata(L, 1, string_set_update_position, NavMeshAgentWrap.cache);
				flag = LuaDLL.lua_toboolean(L, 2);
				navMeshAgentWrap.component.updatePosition = flag;
				result = 0;
			}
			return result;
		}

		[MonoPInvokeCallback(typeof(LuaCSFunction))]
		private static int get_update_position(IntPtr L)
		{
			int result = 0;
			if (WraperUtil.ValidIsUserdata(L, 1, string_get_update_position))
			{
				NavMeshAgentWrap navMeshAgentWrap = null;
				navMeshAgentWrap = WraperUtil.LuaToUserdata(L, 1, string_get_update_position, NavMeshAgentWrap.cache);
				LuaDLL.lua_pushboolean(L, navMeshAgentWrap.component.updatePosition);
				result = 1;
			}
			return result;
		}

		[MonoPInvokeCallback(typeof(LuaCSFunction))]
		private static int set_update_rotation(IntPtr L)
		{
			int result = 0;
			if (WraperUtil.ValidIsUserdata(L, 1, string_set_update_rotation) && WraperUtil.ValidIsBoolean(L, 2, string_set_update_rotation))
			{
				NavMeshAgentWrap navMeshAgentWrap = null;
				bool flag = false;
				navMeshAgentWrap = WraperUtil.LuaToUserdata(L, 1, string_set_update_rotation, NavMeshAgentWrap.cache);
				flag = LuaDLL.lua_toboolean(L, 2);
				navMeshAgentWrap.component.updateRotation = flag;
				result = 0;
			}
			return result;
		}

		[MonoPInvokeCallback(typeof(LuaCSFunction))]
		private static int get_update_rotation(IntPtr L)
		{
			int result = 0;
			if (WraperUtil.ValidIsUserdata(L, 1, string_get_update_rotation))
			{
				NavMeshAgentWrap navMeshAgentWrap = null;
				navMeshAgentWrap = WraperUtil.LuaToUserdata(L, 1, string_get_update_rotation, NavMeshAgentWrap.cache);
				LuaDLL.lua_pushboolean(L, navMeshAgentWrap.component.updateRotation);
				result = 1;
			}
			return result;
		}

		[MonoPInvokeCallback(typeof(LuaCSFunction))]
		private static int set_next_position(IntPtr L)
		{
			int result = 0;
			if (WraperUtil.ValidIsUserdata(L, 1, string_set_next_position) && WraperUtil.ValidIsNumber(L, 2, string_set_next_position) && WraperUtil.ValidIsNumber(L, 3, string_set_next_position) && WraperUtil.ValidIsNumber(L, 4, string_set_next_position))
			{
				NavMeshAgentWrap navMeshAgentWrap = null;
				float num = 0f;
				float num2 = 0f;
				float num3 = 0f;
				navMeshAgentWrap = WraperUtil.LuaToUserdata(L, 1, string_set_next_position, NavMeshAgentWrap.cache);
				num = (float)LuaDLL.lua_tonumber(L, 2);
				num2 = (float)LuaDLL.lua_tonumber(L, 3);
				num3 = (float)LuaDLL.lua_tonumber(L, 4);
				navMeshAgentWrap.component.nextPosition = new Vector3(num, num2, num3);
				result = 0;
			}
			return result;
		}

		[MonoPInvokeCallback(typeof(LuaCSFunction))]
		private static int get_next_position(IntPtr L)
		{
			int result = 0;
			if (WraperUtil.ValidIsUserdata(L, 1, string_get_next_position))
			{
				NavMeshAgentWrap navMeshAgentWrap = null;
				navMeshAgentWrap = WraperUtil.LuaToUserdata(L, 1, string_get_next_position, NavMeshAgentWrap.cache);
				LuaDLL.lua_pushnumber(L, navMeshAgentWrap.component.nextPosition.x);
				LuaDLL.lua_pushnumber(L, navMeshAgentWrap.component.nextPosition.y);
				LuaDLL.lua_pushnumber(L, navMeshAgentWrap.component.nextPosition.z);
				result = 3;
			}
			return result;
		}

		[MonoPInvokeCallback(typeof(LuaCSFunction))]
		private static int reset_path(IntPtr L)
		{
			int result = 0;
			if (WraperUtil.ValidIsUserdata(L, 1, string_reset_path))
			{
				NavMeshAgentWrap navMeshAgentWrap = null;
				navMeshAgentWrap = WraperUtil.LuaToUserdata(L, 1, string_reset_path, NavMeshAgentWrap.cache);
				navMeshAgentWrap.component.ResetPath();
				result = 0;
			}
			return result;
		}

		[MonoPInvokeCallback(typeof(LuaCSFunction))]
		private static int find_closest_edge(IntPtr L)
		{
			int result = 0;
			if (WraperUtil.ValidIsUserdata(L, 1, string_find_closest_edge))
			{
				NavMeshAgentWrap navMeshAgentWrap = null;
				navMeshAgentWrap = WraperUtil.LuaToUserdata(L, 1, string_find_closest_edge, NavMeshAgentWrap.cache);
				NavMeshHit hit;
				navMeshAgentWrap.component.FindClosestEdge(out hit);
				LuaDLL.lua_pushnumber(L, hit.position.x);
				LuaDLL.lua_pushnumber(L, hit.position.y);
				LuaDLL.lua_pushnumber(L, hit.position.z);
				result = 3;
			}
			return result;
		}

		[MonoPInvokeCallback(typeof(LuaCSFunction))]
		private static int get_radius(IntPtr L)
		{
			int result = 0;
			if (WraperUtil.ValidIsUserdata(L, 1, string_get_radius))
			{
				NavMeshAgentWrap navMeshAgentWrap = null;
				navMeshAgentWrap = WraperUtil.LuaToUserdata(L, 1, string_get_radius, NavMeshAgentWrap.cache);
				LuaDLL.lua_pushnumber(L, navMeshAgentWrap.component.radius);
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
				NavMeshAgentWrap navMeshAgentWrap = null;
				float num = 0f;
				navMeshAgentWrap = WraperUtil.LuaToUserdata(L, 1, string_set_radius, NavMeshAgentWrap.cache);
				num = (float)LuaDLL.lua_tonumber(L, 2);
				navMeshAgentWrap.component.radius = num;
				result = 0;
			}
			return result;
		}

		[MonoPInvokeCallback(typeof(LuaCSFunction))]
		private static int set_area_mask(IntPtr L)
		{
			int result = 0;
			if (WraperUtil.ValidIsUserdata(L, 1, string_set_area_mask) && WraperUtil.ValidIsNumber(L, 2, string_set_area_mask))
			{
				NavMeshAgentWrap navMeshAgentWrap = null;
				int num = 0;
				navMeshAgentWrap = WraperUtil.LuaToUserdata(L, 1, string_set_area_mask, NavMeshAgentWrap.cache);
				num = (int)LuaDLL.lua_tonumber(L, 2);
				navMeshAgentWrap.component.areaMask = num;
				result = 0;
			}
			return result;
		}

		[MonoPInvokeCallback(typeof(LuaCSFunction))]
		private static int get_area_mask(IntPtr L)
		{
			int result = 0;
			if (WraperUtil.ValidIsUserdata(L, 1, string_get_area_mask))
			{
				NavMeshAgentWrap navMeshAgentWrap = null;
				navMeshAgentWrap = WraperUtil.LuaToUserdata(L, 1, string_get_radius, NavMeshAgentWrap.cache);
				LuaDLL.lua_pushnumber(L, navMeshAgentWrap.component.areaMask);
				result = 1;
			}
			return result;
		}

		[MonoPInvokeCallback(typeof(LuaCSFunction))]
		private static int ray_cast(IntPtr L)
		{
			int result = 0;
			if (WraperUtil.ValidIsUserdata(L, 1, string_ray_cast) && WraperUtil.ValidIsNumber(L, 2, string_ray_cast) && WraperUtil.ValidIsNumber(L, 3, string_ray_cast) && WraperUtil.ValidIsNumber(L, 4, string_ray_cast) && WraperUtil.ValidIsNumber(L, 5, string_ray_cast) && WraperUtil.ValidIsNumber(L, 6, string_ray_cast) && WraperUtil.ValidIsNumber(L, 7, string_ray_cast) && WraperUtil.ValidIsNumber(L, 8, string_ray_cast))
			{
				Vector3 sourcePosition = default(Vector3);
				sourcePosition.x = (float)LuaDLL.lua_tonumber(L, 2);
				sourcePosition.y = (float)LuaDLL.lua_tonumber(L, 3);
				sourcePosition.z = (float)LuaDLL.lua_tonumber(L, 4);
				Vector3 targetPosition = default(Vector3);
				targetPosition.x = (float)LuaDLL.lua_tonumber(L, 5);
				targetPosition.y = (float)LuaDLL.lua_tonumber(L, 6);
				targetPosition.z = (float)LuaDLL.lua_tonumber(L, 7);
				int areaMask = (int)LuaDLL.lua_tonumber(L, 8);
				NavMeshAgentWrap navMeshAgentWrap = null;
				navMeshAgentWrap = WraperUtil.LuaToUserdata(L, 1, string_ray_cast, NavMeshAgentWrap.cache);
				NavMeshHit hit;
				bool flag = NavMesh.Raycast(sourcePosition, targetPosition, out hit, areaMask);
				if (!flag)
				{
					LuaDLL.lua_pushboolean(L, flag);
					LuaDLL.lua_pushnumber(L, targetPosition.x);
					LuaDLL.lua_pushnumber(L, targetPosition.y);
					LuaDLL.lua_pushnumber(L, targetPosition.z);
				}
				else
				{
					LuaDLL.lua_pushboolean(L, flag);
					LuaDLL.lua_pushnumber(L, hit.position.x);
					LuaDLL.lua_pushnumber(L, hit.position.y);
					LuaDLL.lua_pushnumber(L, hit.position.z);
				}
				result = 4;
			}
			return result;
		}

		[MonoPInvokeCallback(typeof(LuaCSFunction))]
		private static int get_path(IntPtr L)
		{
			int result = 0;
			if (WraperUtil.ValidIsUserdata(L, 1, string_get_area_mask))
			{
				NavMeshAgentWrap navMeshAgentWrap = null;
				navMeshAgentWrap = WraperUtil.LuaToUserdata(L, 1, string_get_radius, NavMeshAgentWrap.cache);
				WraperUtil.Push(L, navMeshAgentWrap.component.path);
				result = 1;
			}
			return result;
		}

		[MonoPInvokeCallback(typeof(LuaCSFunction))]
		private static int set_auto_braking(IntPtr L)
		{
			int result = 0;
			if (WraperUtil.ValidIsUserdata(L, 1, string_set_auto_braking) && WraperUtil.ValidIsBoolean(L, 2, string_set_auto_braking))
			{
				NavMeshAgentWrap navMeshAgentWrap = null;
				navMeshAgentWrap = WraperUtil.LuaToUserdata(L, 1, string_set_auto_braking, NavMeshAgentWrap.cache);
				bool autoBraking = LuaDLL.lua_toboolean(L, 2);
				navMeshAgentWrap.component.autoBraking = autoBraking;
			}
			return result;
		}

		[MonoPInvokeCallback(typeof(LuaCSFunction))]
		private static int get_auto_braking(IntPtr L)
		{
			int result = 0;
			if (WraperUtil.ValidIsUserdata(L, 1, string_get_auto_braking))
			{
				NavMeshAgentWrap navMeshAgentWrap = null;
				navMeshAgentWrap = WraperUtil.LuaToUserdata(L, 1, string_get_auto_braking, NavMeshAgentWrap.cache);
				LuaDLL.lua_pushboolean(L, navMeshAgentWrap.component.autoBraking);
				result = 1;
			}
			return result;
		}

		[MonoPInvokeCallback(typeof(LuaCSFunction))]
		private static int set_obstacle_avoidance_type(IntPtr L)
		{
			int result = 0;
			if (WraperUtil.ValidIsUserdata(L, 1, string_set_obstacle_avoidance_type) && WraperUtil.ValidIsNumber(L, 2, string_set_obstacle_avoidance_type))
			{
				NavMeshAgentWrap navMeshAgentWrap = null;
				navMeshAgentWrap = WraperUtil.LuaToUserdata(L, 1, string_set_auto_braking, NavMeshAgentWrap.cache);
				int num = (int)LuaDLL.lua_tonumber(L, 2);
				num %= 5;
				navMeshAgentWrap.component.obstacleAvoidanceType = (ObstacleAvoidanceType)num;
			}
			return result;
		}

		[MonoPInvokeCallback(typeof(LuaCSFunction))]
		private static int get_obstacle_avoidance_type(IntPtr L)
		{
			int result = 0;
			if (WraperUtil.ValidIsUserdata(L, 1, string_get_obstacle_avoidance_type))
			{
				NavMeshAgentWrap navMeshAgentWrap = null;
				navMeshAgentWrap = WraperUtil.LuaToUserdata(L, 1, string_get_obstacle_avoidance_type, NavMeshAgentWrap.cache);
				LuaDLL.lua_pushnumber(L, (double)navMeshAgentWrap.component.obstacleAvoidanceType);
				result = 1;
			}
			return result;
		}

		[MonoPInvokeCallback(typeof(LuaCSFunction))]
		private static int gc(IntPtr L)
		{
			NavMeshAgentWrap navMeshAgentWrap = WraperUtil.LuaToUserdataByGc(L, 1, "gc nav_mesh_agent_object", NavMeshAgentWrap.cache);
			if (navMeshAgentWrap != null)
			{
				NavMeshAgentWrap.DestroyInstance(navMeshAgentWrap);
			}
			return 0;
		}
	}
}
