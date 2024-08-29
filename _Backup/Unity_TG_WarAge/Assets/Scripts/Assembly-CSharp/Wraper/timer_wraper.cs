using System;
using Core.Timer;
using LuaInterface;

namespace Wraper
{
	public class timer_wraper
	{
		public static string libname = "timer";

		private static luaL_Reg[] libfunc = new luaL_Reg[7]
		{
			new luaL_Reg("create", create),
			new luaL_Reg("create_by_type", create_by_type),
			new luaL_Reg("stop", stop),
			new luaL_Reg("pause", pause),
			new luaL_Reg("resume", resume),
			new luaL_Reg("pause_all", pause_all),
			new luaL_Reg("resume_all", resume_all)
		};

		private static string string_create = "timer.create";

		private static string string_create_by_type = "timer.create_by_type";

		private static string string_stop = "timer.stop";

		private static string string_pause = "timer.pause";

		private static string string_resume = "timer.resume";

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
		private static int create(IntPtr L)
		{
			int result = 0;
			if (WraperUtil.ValidIsString(L, 1, string_create) && WraperUtil.ValidIsNumber(L, 2, string_create) && WraperUtil.ValidIsNumber(L, 3, string_create))
			{
				string text = null;
				float num = 0f;
				int num2 = 0;
				bool bpause = false;
				text = LuaDLL.lua_tostring(L, 1);
				num = (float)LuaDLL.lua_tonumber(L, 2);
				num2 = (int)LuaDLL.lua_tonumber(L, 3);
				if (LuaDLL.lua_isboolean(L, 4))
				{
					bpause = LuaDLL.lua_toboolean(L, 4);
				}
				int num3 = TimerManager.GetInstance().Create(text, num / 1000f, num2, 1, bpause);
				LuaDLL.lua_pushnumber(L, num3);
				result = 1;
			}
			return result;
		}

		[MonoPInvokeCallback(typeof(LuaCSFunction))]
		private static int create_by_type(IntPtr L)
		{
			int result = 0;
			if (WraperUtil.ValidIsString(L, 1, string_create_by_type) && WraperUtil.ValidIsNumber(L, 2, string_create_by_type) && WraperUtil.ValidIsNumber(L, 3, string_create_by_type) && WraperUtil.ValidIsNumber(L, 4, string_create_by_type))
			{
				string text = null;
				float num = 0f;
				int num2 = 0;
				int num3 = 0;
				bool bpause = false;
				text = LuaDLL.lua_tostring(L, 1);
				num = (float)LuaDLL.lua_tonumber(L, 2);
				num2 = (int)LuaDLL.lua_tonumber(L, 3);
				num3 = (int)LuaDLL.lua_tonumber(L, 4);
				if (LuaDLL.lua_isboolean(L, 4))
				{
					bpause = LuaDLL.lua_toboolean(L, 5);
				}
				int num4 = TimerManager.GetInstance().Create(text, num, num2, num3, bpause);
				LuaDLL.lua_pushnumber(L, num4);
				result = 1;
			}
			return result;
		}

		[MonoPInvokeCallback(typeof(LuaCSFunction))]
		private static int stop(IntPtr L)
		{
			int result = 0;
			if (WraperUtil.ValidIsNumber(L, 1, string_stop))
			{
				int num = 0;
				num = (int)LuaDLL.lua_tonumber(L, 1);
				TimerManager.GetInstance().Remove(num);
				result = 0;
			}
			return result;
		}

		[MonoPInvokeCallback(typeof(LuaCSFunction))]
		private static int pause(IntPtr L)
		{
			int result = 0;
			if (WraperUtil.ValidIsNumber(L, 1, string_pause))
			{
				int num = 0;
				num = (int)LuaDLL.lua_tonumber(L, 1);
				TimerManager.GetInstance().Pause(num, true);
				result = 0;
			}
			return result;
		}

		[MonoPInvokeCallback(typeof(LuaCSFunction))]
		private static int resume(IntPtr L)
		{
			int result = 0;
			if (WraperUtil.ValidIsNumber(L, 1, string_resume))
			{
				int num = 0;
				num = (int)LuaDLL.lua_tonumber(L, 1);
				TimerManager.GetInstance().Pause(num, false);
				result = 0;
			}
			return result;
		}

		[MonoPInvokeCallback(typeof(LuaCSFunction))]
		private static int pause_all(IntPtr L)
		{
			int num = 0;
			TimerManager.GetInstance().Pause(true);
			return 0;
		}

		[MonoPInvokeCallback(typeof(LuaCSFunction))]
		private static int resume_all(IntPtr L)
		{
			int num = 0;
			TimerManager.GetInstance().Pause(false);
			return 0;
		}
	}
}
