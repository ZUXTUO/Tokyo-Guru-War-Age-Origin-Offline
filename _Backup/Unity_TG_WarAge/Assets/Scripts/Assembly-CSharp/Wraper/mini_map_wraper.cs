using System;
using LuaInterface;
using UnityEngine;
using UnityWrap;

namespace Wraper
{
	public class mini_map_wraper
	{
		public static string name = "mini_map_object";

		private static luaL_Reg[] func = new luaL_Reg[9]
		{
			new luaL_Reg("set_rotate", set_rotate),
			new luaL_Reg("set_win_size", set_win_size),
			new luaL_Reg("set_scene_size", set_scene_size),
			new luaL_Reg("set_scene_origin", set_scene_origin),
			new luaL_Reg("set_mini_map_size", set_mini_map_size),
			new luaL_Reg("add_object", add_object),
			new luaL_Reg("delete_object", delete_object),
			new luaL_Reg("set_object", set_object),
			new luaL_Reg("set_mini_map_player", set_mini_map_player)
		};

		private static string string_set_rotate = "mini_map_object:set_rotate";

		private static string string_set_win_size = "mini_map_object:set_win_size";

		private static string string_set_scene_size = "mini_map_object:set_scene_size";

		private static string string_set_scene_origin = "mini_map_object:set_scene_origin";

		private static string string_set_mini_map_size = "mini_map_object:set_mini_map_size";

		private static string string_add_object = "mini_map_object:add_object";

		private static string string_delete_object = "mini_map_object:delete_object";

		private static string string_set_object = "mini_map_object:set_object";

		private static string string_set_mini_map_player = "mini_map_object:set_mini_map_player";

		public static bool init(IntPtr L)
		{
			if (L != IntPtr.Zero)
			{
				LuaDLL.register_class(L, name, func, gc);
				return true;
			}
			return false;
		}

		public static void push(IntPtr L, MiniMapWrap obj)
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
		private static int set_rotate(IntPtr L)
		{
			int result = 0;
			if (WraperUtil.ValidIsUserdata(L, 1, string_set_rotate) && WraperUtil.ValidIsBoolean(L, 2, string_set_rotate))
			{
				MiniMapWrap miniMapWrap = null;
				bool flag = false;
				miniMapWrap = WraperUtil.LuaToUserdata(L, 1, string_set_rotate, MiniMapWrap.cache);
				flag = LuaDLL.lua_toboolean(L, 2);
				if (miniMapWrap != null && miniMapWrap.component != null)
				{
					miniMapWrap.component.MMRotate = flag;
				}
				result = 0;
			}
			return result;
		}

		[MonoPInvokeCallback(typeof(LuaCSFunction))]
		private static int set_win_size(IntPtr L)
		{
			int result = 0;
			if (WraperUtil.ValidIsUserdata(L, 1, string_set_win_size) && WraperUtil.ValidIsNumber(L, 2, string_set_win_size) && WraperUtil.ValidIsNumber(L, 3, string_set_win_size))
			{
				MiniMapWrap miniMapWrap = null;
				int num = 0;
				int num2 = 0;
				miniMapWrap = WraperUtil.LuaToUserdata(L, 1, string_set_win_size, MiniMapWrap.cache);
				num = (int)LuaDLL.lua_tonumber(L, 2);
				num2 = (int)LuaDLL.lua_tonumber(L, 3);
				if (miniMapWrap != null && miniMapWrap.component != null)
				{
					miniMapWrap.component.SetWinSize(new Vector2(num, num2));
				}
				result = 0;
			}
			return result;
		}

		[MonoPInvokeCallback(typeof(LuaCSFunction))]
		private static int set_scene_size(IntPtr L)
		{
			int result = 0;
			if (WraperUtil.ValidIsUserdata(L, 1, string_set_scene_size) && WraperUtil.ValidIsNumber(L, 2, string_set_scene_size) && WraperUtil.ValidIsNumber(L, 3, string_set_scene_size))
			{
				MiniMapWrap miniMapWrap = null;
				int num = 0;
				int num2 = 0;
				miniMapWrap = WraperUtil.LuaToUserdata(L, 1, string_set_scene_size, MiniMapWrap.cache);
				num = (int)LuaDLL.lua_tonumber(L, 2);
				num2 = (int)LuaDLL.lua_tonumber(L, 3);
				if (miniMapWrap != null && miniMapWrap.component != null)
				{
					miniMapWrap.component.SetSceneSize(new Vector2(num, num2));
				}
				result = 0;
			}
			return result;
		}

		[MonoPInvokeCallback(typeof(LuaCSFunction))]
		private static int set_scene_origin(IntPtr L)
		{
			int result = 0;
			if (WraperUtil.ValidIsUserdata(L, 1, string_set_scene_origin) && WraperUtil.ValidIsNumber(L, 2, string_set_scene_origin) && WraperUtil.ValidIsNumber(L, 3, string_set_scene_origin))
			{
				MiniMapWrap miniMapWrap = null;
				int num = 0;
				int num2 = 0;
				miniMapWrap = WraperUtil.LuaToUserdata(L, 1, string_set_scene_origin, MiniMapWrap.cache);
				num = (int)LuaDLL.lua_tonumber(L, 2);
				num2 = (int)LuaDLL.lua_tonumber(L, 3);
				if (miniMapWrap != null && miniMapWrap.component != null)
				{
					miniMapWrap.component.SceneOrigin = new Vector2(num, num2);
				}
				result = 0;
			}
			return result;
		}

		[MonoPInvokeCallback(typeof(LuaCSFunction))]
		private static int set_mini_map_size(IntPtr L)
		{
			int result = 0;
			if (WraperUtil.ValidIsUserdata(L, 1, string_set_mini_map_size) && WraperUtil.ValidIsNumber(L, 2, string_set_mini_map_size) && WraperUtil.ValidIsNumber(L, 3, string_set_mini_map_size))
			{
				MiniMapWrap miniMapWrap = null;
				int num = 0;
				int num2 = 0;
				miniMapWrap = WraperUtil.LuaToUserdata(L, 1, string_set_mini_map_size, MiniMapWrap.cache);
				num = (int)LuaDLL.lua_tonumber(L, 2);
				num2 = (int)LuaDLL.lua_tonumber(L, 3);
				if (miniMapWrap != null && miniMapWrap.component != null)
				{
					miniMapWrap.component.SetMiniMapSize(new Vector2(num, num2));
				}
				result = 0;
			}
			return result;
		}

		[MonoPInvokeCallback(typeof(LuaCSFunction))]
		private static int add_object(IntPtr L)
		{
			int result = 0;
			if (WraperUtil.ValidIsUserdata(L, 1, string_add_object) && WraperUtil.ValidIsString(L, 2, string_add_object))
			{
				MiniMapWrap miniMapWrap = null;
				string text = null;
				miniMapWrap = WraperUtil.LuaToUserdata(L, 1, string_add_object, MiniMapWrap.cache);
				text = LuaDLL.lua_tostring(L, 2);
				if (miniMapWrap != null && miniMapWrap.component != null)
				{
					GameObject go;
					MiniMapObject com = miniMapWrap.component.AddObject(text, out go);
					AssetGameObject base_object = AssetGameObject.CreateByInstance(go);
					WraperUtil.PushObject(L, base_object);
					WraperUtil.PushObject(L, MiniMapObjectWrap.CreateInstance(com));
				}
				result = 2;
			}
			return result;
		}

		[MonoPInvokeCallback(typeof(LuaCSFunction))]
		private static int delete_object(IntPtr L)
		{
			int result = 0;
			if (WraperUtil.ValidIsUserdata(L, 1, string_delete_object) && WraperUtil.ValidIsUserdata(L, 2, string_delete_object))
			{
				MiniMapWrap miniMapWrap = null;
				MiniMapObjectWrap miniMapObjectWrap = null;
				miniMapWrap = WraperUtil.LuaToUserdata(L, 1, string_delete_object, MiniMapWrap.cache);
				miniMapObjectWrap = WraperUtil.LuaToUserdata(L, 2, string_delete_object, MiniMapObjectWrap.cache);
				if (miniMapWrap != null && miniMapWrap.component != null)
				{
					miniMapWrap.component.DelObject(miniMapObjectWrap.component);
				}
				result = 0;
			}
			return result;
		}

		[MonoPInvokeCallback(typeof(LuaCSFunction))]
		private static int set_object(IntPtr L)
		{
			int result = 0;
			if (WraperUtil.ValidIsUserdata(L, 1, string_set_object) && WraperUtil.ValidIsUserdata(L, 2, string_set_object) && WraperUtil.ValidIsUserdata(L, 3, string_set_object) && WraperUtil.ValidIsString(L, 4, string_set_object))
			{
				MiniMapWrap miniMapWrap = null;
				MiniMapObjectWrap miniMapObjectWrap = null;
				AssetGameObject assetGameObject = null;
				string text = null;
				miniMapWrap = WraperUtil.LuaToUserdata(L, 1, string_set_object, MiniMapWrap.cache);
				miniMapObjectWrap = WraperUtil.LuaToUserdata(L, 2, string_set_object, MiniMapObjectWrap.cache);
				assetGameObject = WraperUtil.LuaToUserdata(L, 3, string_set_object, AssetGameObject.cache);
				text = LuaDLL.lua_tostring(L, 4);
				if (miniMapWrap != null && miniMapWrap.component != null)
				{
					miniMapWrap.component.SetObject(miniMapObjectWrap.component, assetGameObject.gameObject, text);
				}
				result = 0;
			}
			return result;
		}

		[MonoPInvokeCallback(typeof(LuaCSFunction))]
		private static int set_mini_map_player(IntPtr L)
		{
			int result = 0;
			if (WraperUtil.ValidIsUserdata(L, 1, string_set_mini_map_player) && WraperUtil.ValidIsUserdata(L, 2, string_set_mini_map_player))
			{
				MiniMapWrap miniMapWrap = null;
				MiniMapObjectWrap miniMapObjectWrap = null;
				miniMapWrap = WraperUtil.LuaToUserdata(L, 1, string_set_mini_map_player, MiniMapWrap.cache);
				miniMapObjectWrap = WraperUtil.LuaToUserdata(L, 2, string_set_mini_map_player, MiniMapObjectWrap.cache);
				if (miniMapWrap != null && miniMapWrap.component != null)
				{
					miniMapWrap.component.SetMiniMapPlyaer(miniMapObjectWrap.component);
				}
				result = 0;
			}
			return result;
		}

		[MonoPInvokeCallback(typeof(LuaCSFunction))]
		private static int gc(IntPtr L)
		{
			MiniMapWrap miniMapWrap = WraperUtil.LuaToUserdataByGc(L, 1, "gc mini_map_object", MiniMapWrap.cache);
			if (miniMapWrap != null)
			{
				MiniMapWrap.DestroyInstance(miniMapWrap);
			}
			return 0;
		}
	}
}
