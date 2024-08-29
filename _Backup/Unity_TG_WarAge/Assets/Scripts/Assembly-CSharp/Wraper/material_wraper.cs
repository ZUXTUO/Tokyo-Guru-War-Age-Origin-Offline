using System;
using LuaInterface;
using UnityEngine;
using UnityWrap;

namespace Wraper
{
	public class material_wraper
	{
		public static string name = "material_object";

		public static string libname = "material";

		private static luaL_Reg[] libfunc = new luaL_Reg[1]
		{
			new luaL_Reg("create", create)
		};

		private static luaL_Reg[] func = new luaL_Reg[3]
		{
			new luaL_Reg("set_color", set_color),
			new luaL_Reg("set_texture", set_texture),
			new luaL_Reg("set_matrix", set_matrix)
		};

		private static string string_create = "material.create";

		private static string string_set_color = "material_object:set_color";

		private static string string_set_texture = "material_object:set_texture";

		private static string string_set_matrix = "material_object:set_matrix";

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
		private static int create(IntPtr L)
		{
			int result = 0;
			if (WraperUtil.ValidIsUserdata(L, 1, string_create))
			{
				AssetObject assetObject = null;
				assetObject = WraperUtil.LuaToUserdata(L, 1, string_create, AssetObject.cache);
				MaterialWrap base_object = MaterialWrap.CreateByAssetObject(assetObject);
				WraperUtil.PushObject(L, base_object);
				result = 1;
			}
			return result;
		}

		[MonoPInvokeCallback(typeof(LuaCSFunction))]
		private static int set_color(IntPtr L)
		{
			int result = 0;
			if (WraperUtil.ValidIsUserdata(L, 1, string_set_color) && WraperUtil.ValidIsString(L, 2, string_set_color) && WraperUtil.ValidIsNumber(L, 3, string_set_color) && WraperUtil.ValidIsNumber(L, 4, string_set_color) && WraperUtil.ValidIsNumber(L, 5, string_set_color) && WraperUtil.ValidIsNumber(L, 6, string_set_color))
			{
				MaterialWrap materialWrap = null;
				string text = null;
				float num = 0f;
				float num2 = 0f;
				float num3 = 0f;
				float num4 = 0f;
				materialWrap = WraperUtil.LuaToUserdata(L, 1, string_set_color, MaterialWrap.cache);
				text = LuaDLL.lua_tostring(L, 2);
				num = (float)LuaDLL.lua_tonumber(L, 3);
				num2 = (float)LuaDLL.lua_tonumber(L, 4);
				num3 = (float)LuaDLL.lua_tonumber(L, 5);
				num4 = (float)LuaDLL.lua_tonumber(L, 6);
				materialWrap.material.SetColor(text, new Color(num, num2, num3, num4));
				result = 0;
			}
			return result;
		}

		[MonoPInvokeCallback(typeof(LuaCSFunction))]
		private static int set_texture(IntPtr L)
		{
			int result = 0;
			if (WraperUtil.ValidIsUserdata(L, 1, string_set_texture) && WraperUtil.ValidIsString(L, 2, string_set_texture) && WraperUtil.ValidIsUserdata(L, 3, string_set_texture))
			{
				MaterialWrap materialWrap = null;
				string text = null;
				TextureWrap textureWrap = null;
				materialWrap = WraperUtil.LuaToUserdata(L, 1, string_set_texture, MaterialWrap.cache);
				text = LuaDLL.lua_tostring(L, 2);
				textureWrap = WraperUtil.LuaToUserdata(L, 3, string_set_texture, TextureWrap.cache);
				materialWrap.material.SetTexture(text, textureWrap.component);
				result = 0;
			}
			return result;
		}

		[MonoPInvokeCallback(typeof(LuaCSFunction))]
		private static int set_matrix(IntPtr L)
		{
			int result = 0;
			if (WraperUtil.ValidIsUserdata(L, 1, string_set_matrix) && WraperUtil.ValidIsString(L, 2, string_set_matrix) && WraperUtil.ValidIsUserdata(L, 3, string_set_matrix))
			{
				MaterialWrap materialWrap = null;
				string text = null;
				MatrixWrap matrixWrap = null;
				materialWrap = WraperUtil.LuaToUserdata(L, 1, string_set_matrix, MaterialWrap.cache);
				text = LuaDLL.lua_tostring(L, 2);
				matrixWrap = WraperUtil.LuaToUserdata(L, 3, string_set_matrix, MatrixWrap.cache);
				materialWrap.material.SetMatrix(text, matrixWrap.component);
				result = 0;
			}
			return result;
		}

		[MonoPInvokeCallback(typeof(LuaCSFunction))]
		private static int gc(IntPtr L)
		{
			MaterialWrap materialWrap = WraperUtil.LuaToUserdataByGc(L, 1, "gc material_object", MaterialWrap.cache);
			if (materialWrap != null)
			{
				materialWrap.DelRef();
			}
			return 0;
		}
	}
}
