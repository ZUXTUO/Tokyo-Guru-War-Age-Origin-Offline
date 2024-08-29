using System;
using LuaInterface;
using UnityWrap;

namespace Wraper
{
	public class mini_map_object_wraper
	{
		public static string name = "mini_map_object_object";

		private static luaL_Reg[] func = new luaL_Reg[5]
		{
			new luaL_Reg("set_inner_atlas", set_inner_atlas),
			new luaL_Reg("set_inner_sprite", set_inner_sprite),
			new luaL_Reg("set_outer_atlas", set_outer_atlas),
			new luaL_Reg("set_outer_sprite", set_outer_sprite),
			new luaL_Reg("get_game_object", get_game_object)
		};

		private static string string_set_inner_atlas = "mini_map_object_object:set_inner_atlas";

		private static string string_set_inner_sprite = "mini_map_object_object:set_inner_sprite";

		private static string string_set_outer_atlas = "mini_map_object_object:set_outer_atlas";

		private static string string_set_outer_sprite = "mini_map_object_object:set_outer_sprite";

		private static string string_get_game_object = "mini_map_object_object:get_game_object";

		public static bool init(IntPtr L)
		{
			if (L != IntPtr.Zero)
			{
				LuaDLL.register_class(L, name, func, gc);
				return true;
			}
			return false;
		}

		public static void push(IntPtr L, MiniMapObjectWrap obj)
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
		private static int set_inner_atlas(IntPtr L)
		{
			int result = 0;
			if (WraperUtil.ValidIsUserdata(L, 1, string_set_inner_atlas) && WraperUtil.ValidIsUserdata(L, 2, string_set_inner_atlas))
			{
				MiniMapObjectWrap miniMapObjectWrap = null;
				NGUIAtlasWrap nGUIAtlasWrap = null;
				miniMapObjectWrap = WraperUtil.LuaToUserdata(L, 1, string_set_inner_atlas, MiniMapObjectWrap.cache);
				nGUIAtlasWrap = WraperUtil.LuaToUserdata(L, 2, string_set_inner_atlas, NGUIAtlasWrap.cache);
				if (miniMapObjectWrap != null && miniMapObjectWrap.component != null)
				{
					miniMapObjectWrap.component.SetInnerAtlas(nGUIAtlasWrap.component);
				}
				result = 0;
			}
			return result;
		}

		[MonoPInvokeCallback(typeof(LuaCSFunction))]
		private static int set_inner_sprite(IntPtr L)
		{
			int result = 0;
			if (WraperUtil.ValidIsUserdata(L, 1, string_set_inner_sprite) && WraperUtil.ValidIsString(L, 2, string_set_inner_sprite))
			{
				MiniMapObjectWrap miniMapObjectWrap = null;
				string text = null;
				miniMapObjectWrap = WraperUtil.LuaToUserdata(L, 1, string_set_inner_sprite, MiniMapObjectWrap.cache);
				text = LuaDLL.lua_tostring(L, 2);
				if (miniMapObjectWrap != null && miniMapObjectWrap.component != null)
				{
					miniMapObjectWrap.component.SetInnerIcon(text);
				}
				result = 0;
			}
			return result;
		}

		[MonoPInvokeCallback(typeof(LuaCSFunction))]
		private static int set_outer_atlas(IntPtr L)
		{
			int result = 0;
			if (WraperUtil.ValidIsUserdata(L, 1, string_set_outer_atlas) && WraperUtil.ValidIsUserdata(L, 2, string_set_outer_atlas))
			{
				MiniMapObjectWrap miniMapObjectWrap = null;
				NGUIAtlasWrap nGUIAtlasWrap = null;
				miniMapObjectWrap = WraperUtil.LuaToUserdata(L, 1, string_set_outer_atlas, MiniMapObjectWrap.cache);
				nGUIAtlasWrap = WraperUtil.LuaToUserdata(L, 2, string_set_outer_atlas, NGUIAtlasWrap.cache);
				if (miniMapObjectWrap != null && miniMapObjectWrap.component != null)
				{
					miniMapObjectWrap.component.SetOuterAtlas(nGUIAtlasWrap.component);
				}
				result = 0;
			}
			return result;
		}

		[MonoPInvokeCallback(typeof(LuaCSFunction))]
		private static int set_outer_sprite(IntPtr L)
		{
			int result = 0;
			if (WraperUtil.ValidIsUserdata(L, 1, string_set_outer_sprite) && WraperUtil.ValidIsString(L, 2, string_set_outer_sprite))
			{
				MiniMapObjectWrap miniMapObjectWrap = null;
				string text = null;
				miniMapObjectWrap = WraperUtil.LuaToUserdata(L, 1, string_set_outer_sprite, MiniMapObjectWrap.cache);
				text = LuaDLL.lua_tostring(L, 2);
				if (miniMapObjectWrap != null && miniMapObjectWrap.component != null)
				{
					miniMapObjectWrap.component.SetOuterIcon(text);
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
				MiniMapObjectWrap miniMapObjectWrap = null;
				miniMapObjectWrap = WraperUtil.LuaToUserdata(L, 1, string_get_game_object, MiniMapObjectWrap.cache);
				if (miniMapObjectWrap != null && miniMapObjectWrap.component != null)
				{
					AssetGameObject base_object = AssetGameObject.CreateByInstance(miniMapObjectWrap.component.gameObject);
					WraperUtil.PushObject(L, base_object);
				}
				result = 1;
			}
			return result;
		}

		[MonoPInvokeCallback(typeof(LuaCSFunction))]
		private static int gc(IntPtr L)
		{
			MiniMapObjectWrap miniMapObjectWrap = WraperUtil.LuaToUserdataByGc(L, 1, "gc mini_map_object_object", MiniMapObjectWrap.cache);
			if (miniMapObjectWrap != null)
			{
				MiniMapObjectWrap.DestroyInstance(miniMapObjectWrap);
			}
			return 0;
		}
	}
}
