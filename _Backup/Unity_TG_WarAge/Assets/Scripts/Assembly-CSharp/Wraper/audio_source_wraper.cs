using System;
using LuaInterface;
using UnityWrap;

namespace Wraper
{
	public class audio_source_wraper
	{
		public static string name = "audio_source_object";

		private static luaL_Reg[] func = new luaL_Reg[15]
		{
			new luaL_Reg("play", play),
			new luaL_Reg("stop", stop),
			new luaL_Reg("set_volume", set_volume),
			new luaL_Reg("get_volume", get_volume),
			new luaL_Reg("set_loop", set_loop),
			new luaL_Reg("get_loop", get_loop),
			new luaL_Reg("set_mute", set_mute),
			new luaL_Reg("get_mute", get_mute),
			new luaL_Reg("get_audio_clip_length", get_audio_clip_length),
			new luaL_Reg("set_audio_clip", set_audio_clip),
			new luaL_Reg("get_audio_clip", get_audio_clip),
			new luaL_Reg("set_pan_level", set_pan_level),
			new luaL_Reg("get_pan_level", get_pan_level),
			new luaL_Reg("pause", pause),
			new luaL_Reg("unpause", unpause)
		};

		private static string string_play = "audio_source_object:play";

		private static string string_stop = "audio_source_object:stop";

		private static string string_set_volume = "audio_source_object:set_volume";

		private static string string_get_volume = "audio_source_object:get_volume";

		private static string string_set_loop = "audio_source_object:set_loop";

		private static string string_get_loop = "audio_source_object:get_loop";

		private static string string_set_mute = "audio_source_object:set_mute";

		private static string string_get_mute = "audio_source_object:get_mute";

		private static string string_get_audio_clip_length = "audio_source_object:get_audio_clip_length";

		private static string string_set_audio_clip = "audio_source_object:set_audio_clip";

		private static string string_get_audio_clip = "audio_source_object:get_audio_clip";

		private static string string_set_pan_level = "audio_source_object:set_pan_level";

		private static string string_get_pan_level = "audio_source_object:get_pan_level";

		private static string string_pause = "audio_source_object:pause";

		private static string string_unpause = "audio_source_object:unpause";

		public static bool init(IntPtr L)
		{
			if (L != IntPtr.Zero)
			{
				LuaDLL.register_class(L, name, func, gc);
				return true;
			}
			return false;
		}

		public static void push(IntPtr L, AudioSourceWrap obj)
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
		private static int play(IntPtr L)
		{
			int result = 0;
			if (WraperUtil.ValidIsUserdata(L, 1, string_play))
			{
				AudioSourceWrap audioSourceWrap = null;
				audioSourceWrap = WraperUtil.LuaToUserdata(L, 1, string_play, AudioSourceWrap.cache);
				if (audioSourceWrap.component.isActiveAndEnabled)
				{
					audioSourceWrap.component.Play();
				}
				result = 0;
			}
			return result;
		}

		[MonoPInvokeCallback(typeof(LuaCSFunction))]
		private static int stop(IntPtr L)
		{
			int result = 0;
			if (WraperUtil.ValidIsUserdata(L, 1, string_stop))
			{
				AudioSourceWrap audioSourceWrap = null;
				audioSourceWrap = WraperUtil.LuaToUserdata(L, 1, string_stop, AudioSourceWrap.cache);
				audioSourceWrap.component.Stop();
				result = 0;
			}
			return result;
		}

		[MonoPInvokeCallback(typeof(LuaCSFunction))]
		private static int set_volume(IntPtr L)
		{
			int result = 0;
			if (WraperUtil.ValidIsUserdata(L, 1, string_set_volume) && WraperUtil.ValidIsNumber(L, 2, string_set_volume))
			{
				AudioSourceWrap audioSourceWrap = null;
				float num = 0f;
				audioSourceWrap = WraperUtil.LuaToUserdata(L, 1, string_set_volume, AudioSourceWrap.cache);
				num = (float)LuaDLL.lua_tonumber(L, 2);
				audioSourceWrap.component.volume = num;
				result = 0;
			}
			return result;
		}

		[MonoPInvokeCallback(typeof(LuaCSFunction))]
		private static int get_volume(IntPtr L)
		{
			int result = 0;
			if (WraperUtil.ValidIsUserdata(L, 1, string_get_volume))
			{
				AudioSourceWrap audioSourceWrap = null;
				audioSourceWrap = WraperUtil.LuaToUserdata(L, 1, string_get_volume, AudioSourceWrap.cache);
				LuaDLL.lua_pushnumber(L, audioSourceWrap.component.volume);
				result = 1;
			}
			return result;
		}

		[MonoPInvokeCallback(typeof(LuaCSFunction))]
		private static int set_loop(IntPtr L)
		{
			int result = 0;
			if (WraperUtil.ValidIsUserdata(L, 1, string_set_loop) && WraperUtil.ValidIsBoolean(L, 2, string_set_loop))
			{
				AudioSourceWrap audioSourceWrap = null;
				bool flag = false;
				audioSourceWrap = WraperUtil.LuaToUserdata(L, 1, string_set_loop, AudioSourceWrap.cache);
				flag = LuaDLL.lua_toboolean(L, 2);
				audioSourceWrap.component.loop = flag;
				result = 0;
			}
			return result;
		}

		[MonoPInvokeCallback(typeof(LuaCSFunction))]
		private static int get_loop(IntPtr L)
		{
			int result = 0;
			if (WraperUtil.ValidIsUserdata(L, 1, string_get_loop))
			{
				AudioSourceWrap audioSourceWrap = null;
				audioSourceWrap = WraperUtil.LuaToUserdata(L, 1, string_get_loop, AudioSourceWrap.cache);
				LuaDLL.lua_pushboolean(L, audioSourceWrap.component.loop);
				result = 1;
			}
			return result;
		}

		[MonoPInvokeCallback(typeof(LuaCSFunction))]
		private static int set_mute(IntPtr L)
		{
			int result = 0;
			if (WraperUtil.ValidIsUserdata(L, 1, string_set_mute) && WraperUtil.ValidIsBoolean(L, 2, string_set_mute))
			{
				AudioSourceWrap audioSourceWrap = null;
				bool flag = false;
				audioSourceWrap = WraperUtil.LuaToUserdata(L, 1, string_set_mute, AudioSourceWrap.cache);
				flag = LuaDLL.lua_toboolean(L, 2);
				audioSourceWrap.component.mute = flag;
				result = 0;
			}
			return result;
		}

		[MonoPInvokeCallback(typeof(LuaCSFunction))]
		private static int get_mute(IntPtr L)
		{
			int result = 0;
			if (WraperUtil.ValidIsUserdata(L, 1, string_get_mute))
			{
				AudioSourceWrap audioSourceWrap = null;
				audioSourceWrap = WraperUtil.LuaToUserdata(L, 1, string_get_mute, AudioSourceWrap.cache);
				LuaDLL.lua_pushboolean(L, audioSourceWrap.component.mute);
				result = 1;
			}
			return result;
		}

		[MonoPInvokeCallback(typeof(LuaCSFunction))]
		private static int get_audio_clip_length(IntPtr L)
		{
			int result = 0;
			if (WraperUtil.ValidIsUserdata(L, 1, string_get_audio_clip_length))
			{
				AudioSourceWrap audioSourceWrap = null;
				audioSourceWrap = WraperUtil.LuaToUserdata(L, 1, string_get_audio_clip_length, AudioSourceWrap.cache);
				LuaDLL.lua_pushnumber(L, audioSourceWrap.component.clip.length);
				result = 1;
			}
			return result;
		}

		[MonoPInvokeCallback(typeof(LuaCSFunction))]
		private static int set_audio_clip(IntPtr L)
		{
			int result = 0;
			if (WraperUtil.ValidIsUserdata(L, 1, string_set_audio_clip) && WraperUtil.ValidIsUserdata(L, 2, string_set_audio_clip))
			{
				AudioSourceWrap audioSourceWrap = null;
				AudioWrap audioWrap = null;
				audioSourceWrap = WraperUtil.LuaToUserdata(L, 1, string_set_audio_clip, AudioSourceWrap.cache);
				audioWrap = WraperUtil.LuaToUserdata(L, 2, string_set_audio_clip, AudioWrap.cache);
				audioSourceWrap.component.clip = audioWrap.component;
				result = 0;
			}
			return result;
		}

		[MonoPInvokeCallback(typeof(LuaCSFunction))]
		private static int get_audio_clip(IntPtr L)
		{
			int result = 0;
			if (WraperUtil.ValidIsUserdata(L, 1, string_get_audio_clip))
			{
				AudioSourceWrap audioSourceWrap = null;
				audioSourceWrap = WraperUtil.LuaToUserdata(L, 1, string_get_audio_clip, AudioSourceWrap.cache);
				WraperUtil.PushObject(L, AudioWrap.CreateInstance(audioSourceWrap.component.clip));
				result = 1;
			}
			return result;
		}

		[MonoPInvokeCallback(typeof(LuaCSFunction))]
		private static int set_pan_level(IntPtr L)
		{
			int result = 0;
			if (WraperUtil.ValidIsUserdata(L, 1, string_set_pan_level) && WraperUtil.ValidIsNumber(L, 2, string_set_pan_level))
			{
				AudioSourceWrap audioSourceWrap = null;
				float num = 0f;
				audioSourceWrap = WraperUtil.LuaToUserdata(L, 1, string_set_pan_level, AudioSourceWrap.cache);
				num = (float)LuaDLL.lua_tonumber(L, 2);
				audioSourceWrap.component.spatialBlend = num;
				result = 0;
			}
			return result;
		}

		[MonoPInvokeCallback(typeof(LuaCSFunction))]
		private static int get_pan_level(IntPtr L)
		{
			int result = 0;
			if (WraperUtil.ValidIsUserdata(L, 1, string_get_pan_level) && WraperUtil.ValidIsNumber(L, 2, string_get_pan_level))
			{
				AudioSourceWrap audioSourceWrap = null;
				float num = 0f;
				audioSourceWrap = WraperUtil.LuaToUserdata(L, 1, string_get_pan_level, AudioSourceWrap.cache);
				num = (float)LuaDLL.lua_tonumber(L, 2);
				LuaDLL.lua_pushnumber(L, audioSourceWrap.component.spatialBlend);
				result = 1;
			}
			return result;
		}

		[MonoPInvokeCallback(typeof(LuaCSFunction))]
		private static int pause(IntPtr L)
		{
			int result = 0;
			if (WraperUtil.ValidIsUserdata(L, 1, string_pause))
			{
				AudioSourceWrap audioSourceWrap = null;
				audioSourceWrap = WraperUtil.LuaToUserdata(L, 1, string_pause, AudioSourceWrap.cache);
				audioSourceWrap.component.Pause();
				result = 0;
			}
			return result;
		}

		[MonoPInvokeCallback(typeof(LuaCSFunction))]
		private static int unpause(IntPtr L)
		{
			int result = 0;
			if (WraperUtil.ValidIsUserdata(L, 1, string_unpause))
			{
				AudioSourceWrap audioSourceWrap = null;
				audioSourceWrap = WraperUtil.LuaToUserdata(L, 1, string_unpause, AudioSourceWrap.cache);
				audioSourceWrap.component.UnPause();
				result = 0;
			}
			return result;
		}

		[MonoPInvokeCallback(typeof(LuaCSFunction))]
		private static int gc(IntPtr L)
		{
			AudioSourceWrap audioSourceWrap = WraperUtil.LuaToUserdataByGc(L, 1, "gc audio_source_object", AudioSourceWrap.cache);
			if (audioSourceWrap != null)
			{
				AudioSourceWrap.DestroyInstance(audioSourceWrap);
			}
			return 0;
		}
	}
}
