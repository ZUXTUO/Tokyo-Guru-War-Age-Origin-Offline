using System;
using LuaInterface;
using UnityEngine;
using UnityWrap;

namespace Wraper
{
	public class matrix_wraper
	{
		public static string name = "matrix_object";

		public static string libname = "matrix";

		private static luaL_Reg[] libfunc = new luaL_Reg[1]
		{
			new luaL_Reg("get_identity", get_identity)
		};

		private static luaL_Reg[] func = new luaL_Reg[1]
		{
			new luaL_Reg("multiply_v3", multiply_v3)
		};

		private static string string_multiply_v3 = "matrix_object:multiply_v3";

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

		public static void push(IntPtr L, MatrixWrap obj)
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
		private static int get_identity(IntPtr L)
		{
			int num = 0;
			WraperUtil.PushObject(L, MatrixWrap.CreateInstance(Matrix4x4.identity));
			return 1;
		}

		[MonoPInvokeCallback(typeof(LuaCSFunction))]
		private static int multiply_v3(IntPtr L)
		{
			int result = 0;
			if (WraperUtil.ValidIsUserdata(L, 1, string_multiply_v3) && WraperUtil.ValidIsNumber(L, 2, string_multiply_v3) && WraperUtil.ValidIsNumber(L, 3, string_multiply_v3) && WraperUtil.ValidIsNumber(L, 4, string_multiply_v3))
			{
				MatrixWrap matrixWrap = null;
				float num = 0f;
				float num2 = 0f;
				float num3 = 0f;
				matrixWrap = WraperUtil.LuaToUserdata(L, 1, string_multiply_v3, MatrixWrap.cache);
				num = (float)LuaDLL.lua_tonumber(L, 2);
				num2 = (float)LuaDLL.lua_tonumber(L, 3);
				num3 = (float)LuaDLL.lua_tonumber(L, 4);
				Vector3 vector = matrixWrap.component.MultiplyVector(new Vector3(num, num2, num3));
				LuaDLL.lua_pushnumber(L, vector.x);
				LuaDLL.lua_pushnumber(L, vector.y);
				LuaDLL.lua_pushnumber(L, vector.z);
				result = 3;
			}
			return result;
		}

		[MonoPInvokeCallback(typeof(LuaCSFunction))]
		private static int gc(IntPtr L)
		{
			MatrixWrap matrixWrap = WraperUtil.LuaToUserdataByGc(L, 1, "gc matrix_object", MatrixWrap.cache);
			if (matrixWrap != null)
			{
				MatrixWrap.DestroyInstance(matrixWrap);
			}
			return 0;
		}
	}
}
