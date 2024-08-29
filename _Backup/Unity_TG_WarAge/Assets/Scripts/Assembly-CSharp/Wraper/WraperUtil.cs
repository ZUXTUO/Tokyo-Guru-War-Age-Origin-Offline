using System;
using Core;
using Core.Unity;
using LuaInterface;
using UnityEngine;
using UnityEngine.AI;
using UnityWrap;

namespace Wraper
{
	public class WraperUtil
	{
		public static bool ValidArgumentNum(IntPtr L, int expectedNum, string function)
		{
			if (LuaDLL.lua_gettop(L) != expectedNum)
			{
				string message = string.Format("error {0} expected {1} args, got {2}", function, expectedNum, LuaDLL.lua_gettop(L));
				LuaDLL.luaL_error(L, message);
				return false;
			}
			return true;
		}

		public static bool ValidArgumentNum(IntPtr L, int expectedNumMin, int expectedNumMax, string function)
		{
			if (LuaDLL.lua_gettop(L) < expectedNumMin || LuaDLL.lua_gettop(L) > expectedNumMax)
			{
				string message = string.Format("error {0} expected {1}..{2} args, got {3}", function, expectedNumMin, expectedNumMax, LuaDLL.lua_gettop(L));
				LuaDLL.luaL_error(L, message);
				return false;
			}
			return true;
		}

		public static bool ValidIsLString(IntPtr L, int index, string function)
		{
			return ValidIsString(L, index, function);
		}

		public static bool ValidIsLStringOrNil(IntPtr L, int index, string function)
		{
			return ValidIsStringOrNil(L, index, function);
		}

		public static bool ValidIsString(IntPtr L, int index, string function)
		{
			if (LuaDLL.lua_type(L, index) != LuaTypes.LUA_TSTRING)
			{
				string message = string.Format("error {0} (args {1}), expected {2} got {3}", function, index, "string", LuaDLL.lua_type(L, index));
				LuaDLL.luaL_error(L, message);
				return false;
			}
			return true;
		}

		public static bool ValidIsStringOrNil(IntPtr L, int index, string function)
		{
			if (LuaDLL.lua_type(L, index) != LuaTypes.LUA_TSTRING && LuaDLL.lua_type(L, index) != 0)
			{
				string message = string.Format("error {0} (args {1}), expected {2} got {3}", function, index, "string", LuaDLL.lua_type(L, index));
				LuaDLL.luaL_error(L, message);
				return false;
			}
			return true;
		}

		public static bool ValidIsNumber(IntPtr L, int index, string function)
		{
			if (!LuaDLL.lua_isnumber(L, index))
			{
				string message = string.Format("error {0} (args {1}), expected {2} got {3}", function, index, "number", LuaDLL.lua_type(L, index));
				LuaDLL.luaL_error(L, message);
				return false;
			}
			return true;
		}

		public static bool ValidIsBoolean(IntPtr L, int index, string function)
		{
			if (!LuaDLL.lua_isboolean(L, index))
			{
				string message = string.Format("error {0} (args {1}), expected {2} got {3}", function, index, "boolean", LuaDLL.lua_type(L, index));
				LuaDLL.luaL_error(L, message);
				return false;
			}
			return true;
		}

		public static bool ValidIsTable(IntPtr L, int index, string function)
		{
			if (!LuaDLL.lua_isboolean(L, index))
			{
				string message = string.Format("error {0} (args {1}), expected {2} got {3}", function, index, "table", LuaDLL.lua_type(L, index));
				LuaDLL.luaL_error(L, message);
				return false;
			}
			return true;
		}

		public static bool ValidIsUserdata(IntPtr L, int index, string function)
		{
			if (LuaDLL.lua_type(L, index) != LuaTypes.LUA_TUSERDATA)
			{
				string message = string.Format("error {0} (args {1}), expected {2} got {3}", function, index, "userdata", LuaDLL.lua_type(L, index));
				LuaDLL.luaL_error(L, message);
				return false;
			}
			return true;
		}

		public static bool ValidIsUserdataOrNil(IntPtr L, int index, string function)
		{
			if (LuaDLL.lua_type(L, index) != LuaTypes.LUA_TUSERDATA)
			{
				if (LuaDLL.lua_type(L, index) == LuaTypes.LUA_TNIL)
				{
					return true;
				}
				string message = string.Format("error {0} (args {1}), expected {2} got {3}", function, index, "userdata", LuaDLL.lua_type(L, index));
				LuaDLL.luaL_error(L, message);
				return false;
			}
			return true;
		}

		public static T LuaToUserdata<T>(IntPtr L, int index, string function, AssetObjectCache<int, T> cache)
		{
			int num = LuaDLL.use_lua_touserdata_int(L, index);
			T val = cache.Find(num);
			if (val == null)
			{
				string message = string.Format("error {0} (args {1}, expected {2} got nil. pid:{3})", function, index, typeof(T), num);
				LuaDLL.luaL_error(L, message);
			}
			return val;
		}

		public static T LuaToUserdataOrNil<T>(IntPtr L, int index, string function, AssetObjectCache<int, T> cache)
		{
			if (LuaDLL.lua_type(L, index) == LuaTypes.LUA_TNIL)
			{
				return default(T);
			}
			return LuaToUserdata(L, index, function, cache);
		}

		public static T LuaToUserdataByGc<T>(IntPtr L, int index, string function, AssetObjectCache<int, T> cache, bool checkExists = true)
		{
			int num = LuaDLL.use_lua_touserdata_int(L, index);
			T val = cache.Find(num);
			if (checkExists && val == null)
			{
				string format = string.Format("error {0} (args {1}, expected {2} got nil. pid:{3})", function, index, typeof(T), num);
				Core.Unity.Debug.LogWarning(format);
			}
			return val;
		}

		public static bool ValidUserdataRight(IntPtr L, int index, object obj, string function)
		{
			return ValidUserdataRight(L, obj != null, index, function);
		}

		public static bool ValidUserdataRight(IntPtr L, int index, UnityEngine.Object obj, string function)
		{
			return ValidUserdataRight(L, obj != null, index, function);
		}

		public static bool ValidUserdataRight(IntPtr L, bool isExist, int index, string function)
		{
			if (!isExist)
			{
				string message = string.Format("error {0} (args {1}, expected userdata got nil)", function, index);
				LuaDLL.luaL_error(L, message);
				return false;
			}
			return true;
		}

		public static void Push(IntPtr L, ref RaycastHit[] hits)
		{
			LuaDLL.lua_newtable(L);
			int tableIndex = LuaDLL.lua_gettop(L);
			for (int i = 0; i < hits.Length; i++)
			{
				RaycastHit hitInfo = hits[i];
				Push(L, hitInfo);
				LuaDLL.lua_rawseti(L, tableIndex, i + 1);
			}
		}

		public static void Push(IntPtr L, RaycastHit hitInfo)
		{
			LuaDLL.lua_newtable(L);
			AssetGameObject value = AssetGameObject.CreateByInstance(hitInfo.collider.gameObject);
			LuaSetTable(L, "game_object", value);
			LuaDLL.lua_pushstring(L, "normal");
			LuaDLL.lua_newtable(L);
			LuaSetTable(L, "x", hitInfo.normal.x);
			LuaSetTable(L, "y", hitInfo.normal.y);
			LuaSetTable(L, "z", hitInfo.normal.z);
			LuaDLL.lua_settable(L, -3);
			LuaSetTable(L, "x", hitInfo.point.x);
			LuaSetTable(L, "y", hitInfo.point.y);
			LuaSetTable(L, "z", hitInfo.point.z);
			if (hitInfo.collider != null)
			{
				LuaSetTable(L, "name", hitInfo.collider.name);
			}
		}

		public static void Push(IntPtr L, AnimatorStateInfo stateInfo)
		{
			LuaDLL.lua_newtable(L);
			LuaSetTable(L, "length", stateInfo.length);
			LuaSetTable(L, "loop", stateInfo.loop);
			LuaSetTable(L, "name_hash", stateInfo.nameHash);
			LuaSetTable(L, "short_name_hash", stateInfo.shortNameHash);
			LuaSetTable(L, "normalized_time", stateInfo.normalizedTime);
		}

		public static void Push(IntPtr L, NavMeshPath pathInfo)
		{
			LuaDLL.lua_newtable(L);
			int tableIndex = LuaDLL.lua_gettop(L);
			for (int i = 0; i < pathInfo.corners.Length; i++)
			{
				Vector3 vector = pathInfo.corners[i];
				LuaDLL.lua_newtable(L);
				LuaSetTable(L, "x", vector.x);
				LuaSetTable(L, "y", vector.y);
				LuaSetTable(L, "z", vector.z);
				LuaDLL.lua_rawseti(L, tableIndex, i + 1);
			}
		}

		public static void Push(IntPtr L, Vector3[] points)
		{
			LuaDLL.lua_newtable(L);
			int tableIndex = LuaDLL.lua_gettop(L);
			for (int i = 0; i < points.Length; i++)
			{
				Vector3 vector = points[i];
				LuaDLL.lua_newtable(L);
				LuaSetTable(L, "x", vector.x);
				LuaSetTable(L, "y", vector.y);
				LuaSetTable(L, "z", vector.z);
				LuaDLL.lua_rawseti(L, tableIndex, i + 1);
			}
		}

		public static void Push(IntPtr L, Payment[] payments)
		{
			LuaDLL.lua_newtable(L);
			int tableIndex = LuaDLL.lua_gettop(L);
			for (int i = 0; i < payments.Length; i++)
			{
				LuaDLL.lua_newtable(L);
				LuaSetTable(L, "id", payments[i].id);
				LuaSetTable(L, "key", payments[i].key);
				LuaSetTable(L, "receipt", payments[i].receipt);
				LuaSetTable(L, "state", payments[i].state);
				LuaSetTable(L, "errorCode", payments[i].errorCode);
				LuaSetTable(L, "errorInfo", payments[i].errorInfo);
				LuaSetTable(L, "productId", payments[i].productId);
				LuaSetTable(L, "productQuantity", payments[i].productQuantity);
				LuaDLL.lua_rawseti(L, tableIndex, i + 1);
			}
		}

		public static void Push(IntPtr L, SpayProduct[] spayProducts)
		{
			LuaDLL.lua_newtable(L);
			int tableIndex = LuaDLL.lua_gettop(L);
			for (int i = 0; i < spayProducts.Length; i++)
			{
				LuaDLL.lua_newtable(L);
				LuaSetTable(L, "identifier", spayProducts[i].identifier);
				LuaSetTable(L, "description", spayProducts[i].description);
				LuaSetTable(L, "title", spayProducts[i].title);
				LuaSetTable(L, "currency_unit", spayProducts[i].currency_unit);
				LuaSetTable(L, "price", spayProducts[i].price);
				LuaDLL.lua_rawseti(L, tableIndex, i + 1);
			}
		}

		public static void PushObject(IntPtr L, BaseInterface base_object)
		{
			if (base_object == null)
			{
				LuaDLL.lua_pushnil(L);
				return;
			}
			base_object.PrePushToLua();
			LuaDLL.use_lua_newuserdata_ex(L, 4, base_object.GetPid());
			LuaDLL.lua_getfield(L, LuaIndexes.LUA_REGISTRYINDEX, base_object.GetLuaClassName());
			LuaDLL.lua_setmetatable(L, -2);
			base_object.PostPushToLua();
		}

		public static void PushObjects(IntPtr L, BaseInterface[] base_objects)
		{
			if (base_objects == null || base_objects.Length == 0)
			{
				LuaDLL.lua_pushnil(L);
				return;
			}
			LuaDLL.lua_newtable(L);
			int tableIndex = LuaDLL.lua_gettop(L);
			for (int i = 0; i < base_objects.Length; i++)
			{
				PushObject(L, base_objects[i]);
				LuaDLL.lua_rawseti(L, tableIndex, i + 1);
			}
		}

		public static void PushObjects(IntPtr L, int count, BaseInterface[] base_objects)
		{
			if (base_objects == null || base_objects.Length == 0)
			{
				LuaDLL.lua_pushnil(L);
				return;
			}
			LuaDLL.lua_newtable(L);
			int tableIndex = LuaDLL.lua_gettop(L);
			for (int i = 0; i < count; i++)
			{
				PushObject(L, base_objects[i]);
				LuaDLL.lua_rawseti(L, tableIndex, i + 1);
			}
		}

		public static void PushStringArray(IntPtr L, string[] array)
		{
			if (array == null || array.Length <= 0)
			{
				LuaDLL.lua_pushnil(L);
				return;
			}
			int num = LuaDLL.lua_gettop(L);
			LuaDLL.lua_newtable(L);
			for (int i = 0; i < array.Length; i++)
			{
				LuaSetTable(L, i.ToString(), array[i]);
			}
		}

		public static void PushIntArray(IntPtr L, int[] array)
		{
			if (array == null || array.Length <= 0)
			{
				LuaDLL.lua_pushnil(L);
				return;
			}
			int num = LuaDLL.lua_gettop(L);
			LuaDLL.lua_newtable(L);
			for (int i = 0; i < array.Length; i++)
			{
				LuaSetTable(L, i, array[i]);
			}
		}

		public static void LuaSetTable(IntPtr luaState, int key, int value)
		{
			LuaDLL.lua_pushnumber(luaState, key);
			LuaDLL.lua_pushnumber(luaState, value);
			LuaDLL.lua_settable(luaState, -3);
		}

		public static void LuaSetTable(IntPtr luaState, string key, string value)
		{
			LuaDLL.lua_pushstring(luaState, key);
			LuaDLL.lua_pushstring(luaState, value);
			LuaDLL.lua_settable(luaState, -3);
		}

		public static void LuaSetTable(IntPtr luaState, string key, double value)
		{
			LuaDLL.lua_pushstring(luaState, key);
			LuaDLL.lua_pushnumber(luaState, value);
			LuaDLL.lua_settable(luaState, -3);
		}

		public static void LuaSetTable(IntPtr luaState, string key, bool value)
		{
			LuaDLL.lua_pushstring(luaState, key);
			LuaDLL.lua_pushboolean(luaState, value);
			LuaDLL.lua_settable(luaState, -3);
		}

		public static void LuaSetTable(IntPtr luaState, string key, BaseInterface value)
		{
			LuaDLL.lua_pushstring(luaState, key);
			PushObject(luaState, value);
			LuaDLL.lua_settable(luaState, -3);
		}
	}
}
