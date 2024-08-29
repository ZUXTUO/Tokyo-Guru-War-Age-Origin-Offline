using System;
using Core.Audio;
using LuaInterface;
using UnityWrap;

namespace Wraper
{
	public class audio_wraper
	{
		public static string name = "audio_object";

		public static string libname = "audio";

		private static luaL_Reg[] libfunc = new luaL_Reg[9]
		{
			new luaL_Reg("load", load),
			new luaL_Reg("play_background_music", play_background_music),
			new luaL_Reg("stop_background_music", stop_background_music),
			new luaL_Reg("set_background_music_enable", set_background_music_enable),
			new luaL_Reg("set_background_music_volume", set_background_music_volume),
			new luaL_Reg("set_background_music_loop", set_background_music_loop),
			new luaL_Reg("set_music_enable", set_music_enable),
			new luaL_Reg("set_sound_effect_enable", set_sound_effect_enable),
			new luaL_Reg("get_sound_effect_enable", get_sound_effect_enable)
		};

		private static luaL_Reg[] func = new luaL_Reg[1]
		{
			new luaL_Reg("get_length", get_length)
		};

		private static string string_load = "audio.load";

		private static string string_play_background_music = "audio.play_background_music";

		private static string string_set_background_music_enable = "audio.set_background_music_enable";

		private static string string_set_background_music_volume = "audio.set_background_music_volume";

		private static string string_set_background_music_loop = "audio.set_background_music_loop";

		private static string string_set_music_enable = "audio.set_music_enable";

		private static string string_set_sound_effect_enable = "audio.set_sound_effect_enable";

		private static string string_get_length = "audio_object:get_length";

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

		public static void push(IntPtr L, AudioWrap obj)
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
		private static int load(IntPtr L)
		{
			int result = 0;
			if (WraperUtil.ValidIsString(L, 1, string_load) && WraperUtil.ValidIsString(L, 2, string_load))
			{
				string text = null;
				string text2 = null;
				text = LuaDLL.lua_tostring(L, 1);
				text2 = LuaDLL.lua_tostring(L, 2);
				AudioWrap.Load(text, text2);
				result = 0;
			}
			return result;
		}

		[MonoPInvokeCallback(typeof(LuaCSFunction))]
		private static int play_background_music(IntPtr L)
		{
			int result = 0;
			if (WraperUtil.ValidIsUserdata(L, 1, string_play_background_music))
			{
				AudioWrap audioWrap = null;
				audioWrap = WraperUtil.LuaToUserdata(L, 1, string_play_background_music, AudioWrap.cache);
				AudioController.GetInstance().PlayBackgroundMusic(audioWrap.component);
				result = 0;
			}
			return result;
		}

		[MonoPInvokeCallback(typeof(LuaCSFunction))]
		private static int stop_background_music(IntPtr L)
		{
			int num = 0;
			AudioController.GetInstance().StopBackgroundMusic();
			return 0;
		}

		[MonoPInvokeCallback(typeof(LuaCSFunction))]
		private static int set_background_music_enable(IntPtr L)
		{
			int result = 0;
			if (WraperUtil.ValidIsBoolean(L, 1, string_set_background_music_enable))
			{
				bool flag = false;
				flag = LuaDLL.lua_toboolean(L, 1);
				AudioController.GetInstance().SetBackgroundMusicEnable(flag);
				result = 0;
			}
			return result;
		}

		[MonoPInvokeCallback(typeof(LuaCSFunction))]
		private static int set_background_music_volume(IntPtr L)
		{
			int result = 0;
			if (WraperUtil.ValidIsNumber(L, 1, string_set_background_music_volume))
			{
				float num = 0f;
				num = (float)LuaDLL.lua_tonumber(L, 1);
				AudioController.GetInstance().m_music_volume = num;
				result = 0;
			}
			return result;
		}

		[MonoPInvokeCallback(typeof(LuaCSFunction))]
		private static int set_background_music_loop(IntPtr L)
		{
			int result = 0;
			if (WraperUtil.ValidIsBoolean(L, 1, string_set_background_music_loop))
			{
				bool flag = false;
				flag = LuaDLL.lua_toboolean(L, 1);
				AudioController.GetInstance().SetBackgroundMusicLoop(flag);
				result = 0;
			}
			return result;
		}

		[MonoPInvokeCallback(typeof(LuaCSFunction))]
		private static int set_music_enable(IntPtr L)
		{
			int result = 0;
			if (WraperUtil.ValidIsUserdata(L, 1, string_set_music_enable) && WraperUtil.ValidIsBoolean(L, 2, string_set_music_enable))
			{
				AssetGameObject assetGameObject = null;
				bool flag = false;
				assetGameObject = WraperUtil.LuaToUserdata(L, 1, string_set_music_enable, AssetGameObject.cache);
				flag = LuaDLL.lua_toboolean(L, 2);
				AudioController.GetInstance().SetMusicEnable(assetGameObject.gameObject, flag);
				result = 0;
			}
			return result;
		}

		[MonoPInvokeCallback(typeof(LuaCSFunction))]
		private static int set_sound_effect_enable(IntPtr L)
		{
			int result = 0;
			if (WraperUtil.ValidIsBoolean(L, 1, string_set_sound_effect_enable))
			{
				bool flag = false;
				flag = LuaDLL.lua_toboolean(L, 1);
				AudioController.GetInstance().enableSoundEffect = flag;
				result = 0;
			}
			return result;
		}

		[MonoPInvokeCallback(typeof(LuaCSFunction))]
		private static int get_sound_effect_enable(IntPtr L)
		{
			int num = 0;
			LuaDLL.lua_pushboolean(L, AudioController.GetInstance().enableSoundEffect);
			return 1;
		}

		[MonoPInvokeCallback(typeof(LuaCSFunction))]
		private static int get_length(IntPtr L)
		{
			int result = 0;
			if (WraperUtil.ValidIsUserdata(L, 1, string_get_length))
			{
				AudioWrap audioWrap = null;
				audioWrap = WraperUtil.LuaToUserdata(L, 1, string_get_length, AudioWrap.cache);
				LuaDLL.lua_pushnumber(L, audioWrap.component.length);
				result = 1;
			}
			return result;
		}

		[MonoPInvokeCallback(typeof(LuaCSFunction))]
		private static int gc(IntPtr L)
		{
			AudioWrap audioWrap = WraperUtil.LuaToUserdataByGc(L, 1, "gc audio_object", AudioWrap.cache);
			if (audioWrap != null)
			{
				AudioWrap.DestroyInstance(audioWrap);
			}
			return 0;
		}
	}
}
