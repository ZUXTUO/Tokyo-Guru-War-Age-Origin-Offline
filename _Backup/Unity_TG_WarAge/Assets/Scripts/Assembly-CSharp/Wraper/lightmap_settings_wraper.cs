using System;
using LuaInterface;
using UnityEngine;
using UnityWrap;

namespace Wraper
{
	public class lightmap_settings_wraper
	{
		public static string libname = "lightmap_settings";

		private static luaL_Reg[] libfunc = new luaL_Reg[2]
		{
			new luaL_Reg("replace_textures", replace_textures),
			new luaL_Reg("add_texture", add_texture)
		};

		private static string string_add_texture = "lightmap_settings.add_texture";

		public static bool init(IntPtr L)
		{
			if (L != IntPtr.Zero)
			{
				LuaDLL.register_lib(L, libname, libfunc, 0);
				return true;
			}
			return false;
		}

		[MonoPInvokeCallback(typeof(LuaCSFunction))]
		private static int replace_textures(IntPtr L)
		{
			int num = 0;
			LightmapSettingsWrap.ReplaceTextures();
			return 0;
		}

		[MonoPInvokeCallback(typeof(LuaCSFunction))]
		private static int add_texture(IntPtr L)
		{
			int result = 0;
			if (WraperUtil.ValidIsUserdata(L, 1, string_add_texture))
			{
				TextureWrap textureWrap = null;
				textureWrap = WraperUtil.LuaToUserdata(L, 1, string_add_texture, TextureWrap.cache);
				LightmapSettingsWrap.addTextures.Add((Texture2D)textureWrap.component);
				result = 0;
			}
			return result;
		}
	}
}
