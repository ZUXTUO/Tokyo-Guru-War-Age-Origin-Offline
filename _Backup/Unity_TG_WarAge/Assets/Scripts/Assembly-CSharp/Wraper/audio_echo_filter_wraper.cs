using System;
using LuaInterface;
using UnityWrap;

namespace Wraper
{
	public class audio_echo_filter_wraper
	{
		public static string name = "audio_echo_filter_object";

		private static luaL_Reg[] func = new luaL_Reg[5]
		{
			new luaL_Reg("set_active", set_active),
			new luaL_Reg("set_delay", set_delay),
			new luaL_Reg("set_decayRatio", set_decayRatio),
			new luaL_Reg("set_dryMix", set_dryMix),
			new luaL_Reg("set_wetMix", set_wetMix)
		};

		private static string string_set_active = "audio_echo_filter_object:set_active";

		private static string string_set_delay = "audio_echo_filter_object:set_delay";

		private static string string_set_decayRatio = "audio_echo_filter_object:set_decayRatio";

		private static string string_set_dryMix = "audio_echo_filter_object:set_dryMix";

		private static string string_set_wetMix = "audio_echo_filter_object:set_wetMix";

		public static bool init(IntPtr L)
		{
			if (L != IntPtr.Zero)
			{
				LuaDLL.register_class(L, name, func, gc);
				return true;
			}
			return false;
		}

		public static void push(IntPtr L, AudioEchoFilterWrap obj)
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
		private static int set_active(IntPtr L)
		{
			int result = 0;
			if (WraperUtil.ValidIsUserdata(L, 1, string_set_active) && WraperUtil.ValidIsBoolean(L, 2, string_set_active))
			{
				AudioEchoFilterWrap audioEchoFilterWrap = null;
				bool flag = false;
				audioEchoFilterWrap = WraperUtil.LuaToUserdata(L, 1, string_set_active, AudioEchoFilterWrap.cache);
				flag = LuaDLL.lua_toboolean(L, 2);
				audioEchoFilterWrap.component.enabled = flag;
				result = 0;
			}
			return result;
		}

		[MonoPInvokeCallback(typeof(LuaCSFunction))]
		private static int set_delay(IntPtr L)
		{
			int result = 0;
			if (WraperUtil.ValidIsUserdata(L, 1, string_set_delay) && WraperUtil.ValidIsNumber(L, 2, string_set_delay))
			{
				AudioEchoFilterWrap audioEchoFilterWrap = null;
				float num = 500f;
				audioEchoFilterWrap = WraperUtil.LuaToUserdata(L, 1, string_set_delay, AudioEchoFilterWrap.cache);
				num = (float)LuaDLL.lua_tonumber(L, 2);
				audioEchoFilterWrap.component.delay = num;
				result = 0;
			}
			return result;
		}

		[MonoPInvokeCallback(typeof(LuaCSFunction))]
		private static int set_decayRatio(IntPtr L)
		{
			int result = 0;
			if (WraperUtil.ValidIsUserdata(L, 1, string_set_decayRatio) && WraperUtil.ValidIsNumber(L, 2, string_set_decayRatio))
			{
				AudioEchoFilterWrap audioEchoFilterWrap = null;
				float num = 0.5f;
				audioEchoFilterWrap = WraperUtil.LuaToUserdata(L, 1, string_set_decayRatio, AudioEchoFilterWrap.cache);
				num = (float)LuaDLL.lua_tonumber(L, 2);
				audioEchoFilterWrap.component.decayRatio = num;
				result = 0;
			}
			return result;
		}

		[MonoPInvokeCallback(typeof(LuaCSFunction))]
		private static int set_dryMix(IntPtr L)
		{
			int result = 0;
			if (WraperUtil.ValidIsUserdata(L, 1, string_set_dryMix) && WraperUtil.ValidIsNumber(L, 2, string_set_dryMix))
			{
				AudioEchoFilterWrap audioEchoFilterWrap = null;
				float num = 1f;
				audioEchoFilterWrap = WraperUtil.LuaToUserdata(L, 1, string_set_dryMix, AudioEchoFilterWrap.cache);
				num = (float)LuaDLL.lua_tonumber(L, 2);
				audioEchoFilterWrap.component.dryMix = num;
				result = 0;
			}
			return result;
		}

		[MonoPInvokeCallback(typeof(LuaCSFunction))]
		private static int set_wetMix(IntPtr L)
		{
			int result = 0;
			if (WraperUtil.ValidIsUserdata(L, 1, string_set_wetMix) && WraperUtil.ValidIsNumber(L, 2, string_set_wetMix))
			{
				AudioEchoFilterWrap audioEchoFilterWrap = null;
				float num = 1f;
				audioEchoFilterWrap = WraperUtil.LuaToUserdata(L, 1, string_set_wetMix, AudioEchoFilterWrap.cache);
				num = (float)LuaDLL.lua_tonumber(L, 2);
				audioEchoFilterWrap.component.wetMix = num;
				result = 0;
			}
			return result;
		}

		[MonoPInvokeCallback(typeof(LuaCSFunction))]
		private static int gc(IntPtr L)
		{
			AudioEchoFilterWrap audioEchoFilterWrap = WraperUtil.LuaToUserdataByGc(L, 1, "gc audio_echo_filter_object", AudioEchoFilterWrap.cache);
			if (audioEchoFilterWrap != null)
			{
				AudioEchoFilterWrap.DestroyInstance(audioEchoFilterWrap);
			}
			return 0;
		}
	}
}
