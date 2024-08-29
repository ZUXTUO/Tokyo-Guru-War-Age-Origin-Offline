using System;
using Core.Resource;
using Core.Unity;
using Core.Util;
using LuaInterface;
using UnityWrap;

namespace Wraper
{
	public class asset_loader_wraper
	{
		public static string name = "asset_loader_object";

		public static string libname = "asset_loader";

		private static luaL_Reg[] libfunc = new luaL_Reg[8]
		{
			new luaL_Reg("get_default", get_default),
			new luaL_Reg("create", create),
			new luaL_Reg("destroy_all", destroy_all),
			new luaL_Reg("set_max_parallel_cnt", set_max_parallel_cnt),
			new luaL_Reg("show_load_log", show_load_log),
			new luaL_Reg("enable_3rdparty_compression", enable_3rdparty_compression),
			new luaL_Reg("enable_shared_atlas_load", enable_shared_atlas_load),
			new luaL_Reg("set_load_type", set_load_type)
		};

		private static luaL_Reg[] func = new luaL_Reg[3]
		{
			new luaL_Reg("get_pid", get_pid),
			new luaL_Reg("set_callback", set_callback),
			new luaL_Reg("load", load)
		};

		private static string string_create = "asset_loader.create";

		private static string string_set_max_parallel_cnt = "asset_loader.set_max_parallel_cnt";

		private static string string_show_load_log = "asset_loader.show_load_log";

		private static string string_enable_3rdparty_compression = "asset_loader.enable_3rdparty_compression";

		private static string string_enable_shared_atlas_load = "asset_loader.enable_shared_atlas_load";

		private static string string_get_pid = "asset_loader_object:get_pid";

		private static string string_set_callback = "asset_loader_object:set_callback";

		private static string string_set_load_type = "asset_loader_object:set_load_type";

		private static string string_load = "asset_loader_object:load";

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

		public static void push(IntPtr L, AssetLoader obj)
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
		private static int get_default(IntPtr L)
		{
			int num = 0;
			WraperUtil.PushObject(L, AssetLoader.GetDefault());
			return 1;
		}

		[MonoPInvokeCallback(typeof(LuaCSFunction))]
		private static int create(IntPtr L)
		{
			int result = 0;
			if (WraperUtil.ValidIsString(L, 1, string_create))
			{
				string text = null;
				text = LuaDLL.lua_tostring(L, 1);
				WraperUtil.PushObject(L, AssetLoader.InstanceAssetLoader(text));
				result = 1;
			}
			return result;
		}

		[MonoPInvokeCallback(typeof(LuaCSFunction))]
		private static int destroy_all(IntPtr L)
		{
			int num = 0;
			AssetLoader.DestroyAll();
			return 0;
		}

		[MonoPInvokeCallback(typeof(LuaCSFunction))]
		private static int set_max_parallel_cnt(IntPtr L)
		{
			int result = 0;
			if (WraperUtil.ValidIsNumber(L, 1, string_set_max_parallel_cnt))
			{
				int maxTaskCnt = (int)LuaDLL.lua_tonumber(L, 1);
				AssetBundleLoader.SetMaxTaskCnt(maxTaskCnt);
				result = 0;
			}
			return result;
		}

		[MonoPInvokeCallback(typeof(LuaCSFunction))]
		private static int show_load_log(IntPtr L)
		{
			int result = 0;
			if (WraperUtil.ValidIsBoolean(L, 1, string_show_load_log))
			{
				bool show = LuaDLL.lua_toboolean(L, 1);
				AssetBundleLoader.GetInstance().ShowLoadLog(show);
				result = 0;
			}
			return result;
		}

		[MonoPInvokeCallback(typeof(LuaCSFunction))]
		private static int enable_3rdparty_compression(IntPtr L)
		{
			int result = 0;
			if (WraperUtil.ValidIsBoolean(L, 1, string_enable_3rdparty_compression))
			{
				bool enable = LuaDLL.lua_toboolean(L, 1);
				AssetBundleLoader.GetInstance().Enable3rdpartyCompression(enable);
				result = 0;
			}
			return result;
		}

		[MonoPInvokeCallback(typeof(LuaCSFunction))]
		private static int enable_shared_atlas_load(IntPtr L)
		{
			int result = 0;
			if (WraperUtil.ValidIsBoolean(L, 1, string_enable_shared_atlas_load))
			{
				bool enable = LuaDLL.lua_toboolean(L, 1);
				AssetBundleLoader.GetInstance().EnableSharedAtlasLoad(enable);
				result = 0;
			}
			return result;
		}

		[MonoPInvokeCallback(typeof(LuaCSFunction))]
		private static int set_load_type(IntPtr L)
		{
			int result = 0;
			if (WraperUtil.ValidIsNumber(L, 1, string_set_load_type))
			{
				switch ((int)LuaDLL.lua_tonumber(L, 1))
				{
				case 0:
					AssetBundleLoader.m_useSyncLoad = false;
					AssetBundleLoader.m_useAsyncLoad = false;
					break;
				case 1:
					AssetBundleLoader.m_useSyncLoad = false;
					AssetBundleLoader.m_useAsyncLoad = true;
					break;
				case 2:
					AssetBundleLoader.m_useSyncLoad = true;
					AssetBundleLoader.m_useAsyncLoad = false;
					break;
				}
				result = 0;
			}
			return result;
		}

		[MonoPInvokeCallback(typeof(LuaCSFunction))]
		private static int get_pid(IntPtr L)
		{
			int result = 0;
			if (WraperUtil.ValidIsUserdata(L, 1, string_get_pid))
			{
				AssetLoader assetLoader = null;
				assetLoader = WraperUtil.LuaToUserdata(L, 1, string_get_pid, AssetLoader.cache);
				if (assetLoader != null)
				{
					LuaDLL.lua_pushnumber(L, assetLoader.GetPid());
				}
				result = 1;
			}
			return result;
		}

		[MonoPInvokeCallback(typeof(LuaCSFunction))]
		private static int set_callback(IntPtr L)
		{
			int result = 0;
			if (WraperUtil.ValidIsUserdata(L, 1, string_set_callback) && WraperUtil.ValidIsString(L, 2, string_set_callback))
			{
				AssetLoader assetLoader = null;
				string text = null;
				assetLoader = WraperUtil.LuaToUserdata(L, 1, string_set_callback, AssetLoader.cache);
				text = LuaDLL.lua_tostring(L, 2);
				if (assetLoader != null)
				{
					assetLoader.SetCallback(text);
				}
				result = 0;
			}
			return result;
		}

		[MonoPInvokeCallback(typeof(LuaCSFunction))]
		private static int load(IntPtr L)
		{
			int result = 0;
			if (WraperUtil.ValidIsUserdata(L, 1, string_load) && WraperUtil.ValidIsString(L, 2, string_load))
			{
				AssetLoader assetLoader = null;
				string text = null;
				assetLoader = WraperUtil.LuaToUserdata(L, 1, string_load, AssetLoader.cache);
				text = LuaDLL.lua_tostring(L, 2);
				if (assetLoader != null)
				{
					if (Utils.StringContainUpper(text))
					{
						Debug.LogWarning("加载的路径中有大写:" + text);
					}
					assetLoader.Load(text);
				}
				result = 0;
			}
			return result;
		}

		[MonoPInvokeCallback(typeof(LuaCSFunction))]
		private static int gc(IntPtr L)
		{
			AssetLoader assetLoader = WraperUtil.LuaToUserdataByGc(L, 1, "gc asset_loader_object", AssetLoader.cache);
			if (assetLoader != null && assetLoader.GetPid() != AssetLoader.GetDefault().GetPid())
			{
				AssetLoader.DestroyAssetLoader(assetLoader);
			}
			return 0;
		}
	}
}
