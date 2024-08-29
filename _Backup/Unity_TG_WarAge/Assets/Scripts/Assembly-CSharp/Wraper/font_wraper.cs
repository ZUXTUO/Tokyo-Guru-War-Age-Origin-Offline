using System;
using LuaInterface;
using UnityWrap;

namespace Wraper
{
	public class font_wraper
	{
		public static string name = "font_object";

		public static string libname = "font";

		private static luaL_Reg[] libfunc = new luaL_Reg[1]
		{
			new luaL_Reg("create_by_asset", create_by_asset)
		};

		private static luaL_Reg[] func = new luaL_Reg[1]
		{
			new luaL_Reg("is_dynamic_font", is_dynamic_font)
		};

		private static string string_create_by_asset = "font.create_by_asset";

		private static string string_is_dynamic_font = "font_object:is_dynamic_font";

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

		public static void push(IntPtr L, FontWrap obj)
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
		private static int create_by_asset(IntPtr L)
		{
			int result = 0;
			if (WraperUtil.ValidIsUserdata(L, 1, string_create_by_asset) && WraperUtil.ValidIsBoolean(L, 2, string_create_by_asset))
			{
				AssetObject assetObject = null;
				bool flag = false;
				assetObject = WraperUtil.LuaToUserdata(L, 1, string_create_by_asset, AssetObject.cache);
				flag = LuaDLL.lua_toboolean(L, 2);
				FontWrap base_object = FontWrap.CreateByAssetObject(assetObject, flag);
				WraperUtil.PushObject(L, base_object);
				result = 1;
			}
			return result;
		}

		[MonoPInvokeCallback(typeof(LuaCSFunction))]
		private static int is_dynamic_font(IntPtr L)
		{
			int result = 0;
			if (WraperUtil.ValidIsUserdata(L, 1, string_is_dynamic_font))
			{
				FontWrap fontWrap = null;
				fontWrap = WraperUtil.LuaToUserdata(L, 1, string_is_dynamic_font, FontWrap.cache);
				LuaDLL.lua_pushboolean(L, fontWrap.component.dynamic);
				result = 1;
			}
			return result;
		}

		[MonoPInvokeCallback(typeof(LuaCSFunction))]
		private static int gc(IntPtr L)
		{
			FontWrap fontWrap = WraperUtil.LuaToUserdataByGc(L, 1, "gc font_object", FontWrap.cache);
			if (fontWrap != null)
			{
				fontWrap.DelRef();
			}
			return 0;
		}
	}
}
