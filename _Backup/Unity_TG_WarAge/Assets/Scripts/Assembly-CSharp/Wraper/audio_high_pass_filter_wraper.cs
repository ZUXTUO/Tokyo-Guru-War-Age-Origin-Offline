using System;
using LuaInterface;
using UnityWrap;

namespace Wraper
{
	public class audio_high_pass_filter_wraper
	{
		public static string name = "audio_high_pass_filter_object";

		private static luaL_Reg[] func = new luaL_Reg[2]
		{
			new luaL_Reg("set_cutoff_frequency", set_cutoff_frequency),
			new luaL_Reg("set_highpass_resonance_q", set_highpass_resonance_q)
		};

		private static string string_set_cutoff_frequency = "audio_high_pass_filter_object:set_cutoff_frequency";

		private static string string_set_highpass_resonance_q = "audio_high_pass_filter_object:set_highpass_resonance_q";

		public static bool init(IntPtr L)
		{
			if (L != IntPtr.Zero)
			{
				LuaDLL.register_class(L, name, func, gc);
				return true;
			}
			return false;
		}

		public static void push(IntPtr L, AudioHighPassFilterWrap obj)
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
		private static int set_cutoff_frequency(IntPtr L)
		{
			int result = 0;
			if (WraperUtil.ValidIsUserdata(L, 1, string_set_cutoff_frequency) && WraperUtil.ValidIsNumber(L, 2, string_set_cutoff_frequency))
			{
				AudioHighPassFilterWrap audioHighPassFilterWrap = null;
				float num = 0f;
				audioHighPassFilterWrap = WraperUtil.LuaToUserdata(L, 1, string_set_cutoff_frequency, AudioHighPassFilterWrap.cache);
				num = (float)LuaDLL.lua_tonumber(L, 2);
				if (audioHighPassFilterWrap.component != null)
				{
					audioHighPassFilterWrap.component.cutoffFrequency = num;
				}
				result = 0;
			}
			return result;
		}

		[MonoPInvokeCallback(typeof(LuaCSFunction))]
		private static int set_highpass_resonance_q(IntPtr L)
		{
			int result = 0;
			if (WraperUtil.ValidIsUserdata(L, 1, string_set_highpass_resonance_q) && WraperUtil.ValidIsNumber(L, 2, string_set_highpass_resonance_q))
			{
				AudioHighPassFilterWrap audioHighPassFilterWrap = null;
				float num = 0f;
				audioHighPassFilterWrap = WraperUtil.LuaToUserdata(L, 1, string_set_highpass_resonance_q, AudioHighPassFilterWrap.cache);
				num = (float)LuaDLL.lua_tonumber(L, 2);
				if (audioHighPassFilterWrap.component != null)
				{
					audioHighPassFilterWrap.component.highpassResonanceQ = num;
				}
				result = 0;
			}
			return result;
		}

		[MonoPInvokeCallback(typeof(LuaCSFunction))]
		private static int gc(IntPtr L)
		{
			AudioHighPassFilterWrap audioHighPassFilterWrap = WraperUtil.LuaToUserdataByGc(L, 1, "gc audio_high_pass_filter_object", AudioHighPassFilterWrap.cache);
			if (audioHighPassFilterWrap != null)
			{
				AudioHighPassFilterWrap.DestroyInstance(audioHighPassFilterWrap);
			}
			return 0;
		}
	}
}
