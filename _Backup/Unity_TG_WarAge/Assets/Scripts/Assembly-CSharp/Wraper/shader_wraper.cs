using System;
using LuaInterface;
using UnityWrap;

namespace Wraper
{
	public class shader_wraper
	{
		public static string name = "shader_object";

		public static string libname = "shader";

		private static luaL_Reg[] libfunc = new luaL_Reg[1]
		{
			new luaL_Reg("load_resource", load_resource)
		};

		private static luaL_Reg[] func = new luaL_Reg[1]
		{
			new luaL_Reg("set_enable", set_enable)
		};

		private static string string_load_resource = "shader.load_resource";

		private static string string_set_enable = "shader_object:set_enable";

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

		public static void push(IntPtr L, ShaderWrap obj)
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
		private static int load_resource(IntPtr L)
		{
			int result = 0;
			if (WraperUtil.ValidIsString(L, 1, string_load_resource))
			{
				string text = null;
				text = LuaDLL.lua_tostring(L, 1);
				WraperUtil.PushObject(L, ShaderWrap.Load(text));
				result = 1;
			}
			return result;
		}

		[MonoPInvokeCallback(typeof(LuaCSFunction))]
		private static int set_enable(IntPtr L)
		{
			int result = 0;
			if (WraperUtil.ValidIsUserdata(L, 1, string_set_enable) && WraperUtil.ValidIsBoolean(L, 2, string_set_enable))
			{
				ShaderWrap shaderWrap = null;
				bool flag = false;
				shaderWrap = WraperUtil.LuaToUserdata(L, 1, string_set_enable, ShaderWrap.cache);
				flag = LuaDLL.lua_toboolean(L, 2);
				result = 0;
			}
			return result;
		}

		[MonoPInvokeCallback(typeof(LuaCSFunction))]
		private static int gc(IntPtr L)
		{
			ShaderWrap shaderWrap = WraperUtil.LuaToUserdataByGc(L, 1, "gc shader_object", ShaderWrap.cache);
			if (shaderWrap != null)
			{
				ShaderWrap.DestroyInstance(shaderWrap);
			}
			return 0;
		}
	}
}
