using System;
using LuaInterface;
using UnityWrap;

namespace Wraper
{
	public class asset_object_wraper
	{
		public static string name = "asset_object_object";

		public static string libname = "asset_object";

		private static luaL_Reg[] libfunc = new luaL_Reg[2]
		{
			new luaL_Reg("destroy_all", destroy_all),
			new luaL_Reg("set_enable_sync_asset_deferred_release", set_enable_sync_asset_deferred_release)
		};

		private static luaL_Reg[] func = new luaL_Reg[3]
		{
			new luaL_Reg("instance_game_object", instance_game_object),
			new luaL_Reg("load_all", load_all),
			new luaL_Reg("clear", clear)
		};

		private static string string_instance_game_object = "asset_object_object:instance_game_object";

		private static string string_set_enable_sync_asset_deferred_release = "asset_loader.set_enable_sync_asset_deferred_release";

		private static string string_load_all = "asset_object_object:load_all";

		private static string string_clear = "asset_object_object:clear";

		public static bool init(IntPtr L)
		{
			if (L != IntPtr.Zero)
			{
				LuaDLL.register_class(L, name, func, gc);
				LuaDLL.register_lib(L, libname, libfunc, 0);
				return true;
			}
			return false;
		}

		public static void push(IntPtr L, AssetObject obj)
		{
			if (obj == null)
			{
				LuaDLL.lua_pushnil(L);
				return;
			}
			obj.AddRef();
			LuaDLL.use_lua_newuserdata_ex(L, 4, obj.GetPid());
			LuaDLL.lua_getfield(L, LuaIndexes.LUA_REGISTRYINDEX, name);
			LuaDLL.lua_setmetatable(L, -2);
		}

		[MonoPInvokeCallback(typeof(LuaCSFunction))]
		private static int destroy_all(IntPtr L)
		{
			int num = 0;
			AssetObject.DestroyAll();
			return 0;
		}

		[MonoPInvokeCallback(typeof(LuaCSFunction))]
		private static int set_enable_sync_asset_deferred_release(IntPtr L)
		{
			int result = 0;
			if (WraperUtil.ValidIsBoolean(L, 1, string_set_enable_sync_asset_deferred_release))
			{
				bool enableSyncAssetDefferedRelease = LuaDLL.lua_toboolean(L, 1);
				AssetObject.SetEnableSyncAssetDefferedRelease(enableSyncAssetDefferedRelease);
				result = 0;
			}
			return result;
		}

		[MonoPInvokeCallback(typeof(LuaCSFunction))]
		private static int instance_game_object(IntPtr L)
		{
			int result = 0;
			if (WraperUtil.ValidIsUserdata(L, 1, string_instance_game_object))
			{
				AssetObject assetObject = null;
				assetObject = WraperUtil.LuaToUserdata(L, 1, string_instance_game_object, AssetObject.cache);
				AssetGameObject base_object = AssetGameObject.CreateByAssetObject(assetObject, true);
				WraperUtil.PushObject(L, base_object);
				result = 1;
			}
			return result;
		}

		[MonoPInvokeCallback(typeof(LuaCSFunction))]
		private static int load_all(IntPtr L)
		{
			int result = 0;
			if (WraperUtil.ValidIsUserdata(L, 1, string_load_all))
			{
				AssetObject assetObject = null;
				assetObject = WraperUtil.LuaToUserdata(L, 1, string_load_all, AssetObject.cache);
				assetObject.assetBundle.LoadAllAssets();
				result = 0;
			}
			return result;
		}

		[MonoPInvokeCallback(typeof(LuaCSFunction))]
		private static int clear(IntPtr L)
		{
			int result = 0;
			if (WraperUtil.ValidIsUserdata(L, 1, string_clear))
			{
				AssetObject assetObject = null;
				assetObject = WraperUtil.LuaToUserdata(L, 1, string_clear, AssetObject.cache);
				assetObject.ClearResources();
				result = 0;
			}
			return result;
		}

		[MonoPInvokeCallback(typeof(LuaCSFunction))]
		private static int gc(IntPtr L)
		{
			AssetObject assetObject = WraperUtil.LuaToUserdataByGc(L, 1, "gc asset_object_object", AssetObject.cache, false);
			if (assetObject != null)
			{
				assetObject.DelRef();
			}
			return 0;
		}
	}
}
