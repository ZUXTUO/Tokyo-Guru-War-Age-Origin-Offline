using System;
using System.Collections.Generic;
using Core;
using Core.Unity;
using LuaInterface;
using Wraper;

namespace Script
{
	internal class ScriptCall
	{
		private static List<ScriptCall> objectCache = new List<ScriptCall>();

		public static string lastCallFunction = string.Empty;

		private int luaTopIndex;

		private bool isFunction;

		private string function;

		private bool isRunning;

		private IntPtr luaState = IntPtr.Zero;

		public IntPtr L
		{
			get
			{
				return luaState;
			}
		}

		private ScriptCall(string callFunction)
		{
			function = callFunction;
		}

		public static ScriptCall Create(string callFunction)
		{
			ScriptCall result = null;
			if (callFunction == null || callFunction.Length == 0)
			{
				return result;
			}
			if (objectCache.Count > 0)
			{
				result = objectCache[objectCache.Count - 1];
				objectCache.RemoveAt(objectCache.Count - 1);
				result.function = callFunction;
			}
			else
			{
				result = new ScriptCall(callFunction);
			}
			lastCallFunction = callFunction;
			return result;
		}

		private static void AddToCache(ScriptCall inst)
		{
			objectCache.Add(inst);
		}

		public static int GetUnuseCount()
		{
			return objectCache.Count;
		}

		~ScriptCall()
		{
			if (isRunning)
			{
				Debug.LogWarning(string.Format("~~~~~~~~~~~ ScriptCall. isFinish==false, function:{0}", function));
			}
		}

		public bool Start()
		{
			if (isRunning)
			{
				return false;
			}
			LuaVM vM = ScriptManager.GetInstance().GetVM();
			luaState = vM.GetLuaState();
			if (luaState == IntPtr.Zero)
			{
				return false;
			}
			isRunning = true;
			luaTopIndex = LuaDLL.lua_gettop(luaState);
			isFunction = false;
			int pushcount = 0;
			isFunction = vM.Lua_GetFunction(function, ref pushcount);
			return isFunction;
		}

		public void Finish(int argsCount)
		{
			if (luaState == IntPtr.Zero)
			{
				return;
			}
			if (isRunning)
			{
				isRunning = false;
				if (!isFunction)
				{
					ScriptManager.GetInstance().ShowScriptError("GetFunction failed, it is not function:" + function);
				}
				else
				{
					if (LuaDLL.lua_pcall(luaState, argsCount, 0, 0) != 0)
					{
						string errorInfo = LuaDLL.lua_tostring(luaState, -1);
						ScriptManager.GetInstance().ShowScriptError(errorInfo);
					}
					LuaDLL.lua_settop(luaState, luaTopIndex);
				}
			}
			AddToCache(this);
		}

		public int FinishResult(int argsCount)
		{
			int result = 0;
			if (luaState == IntPtr.Zero)
			{
				return result;
			}
			if (isRunning)
			{
				isRunning = false;
				if (!isFunction)
				{
					ScriptManager.GetInstance().ShowScriptError("GetFunction failed, it is not function:" + function);
				}
				else
				{
					if (LuaDLL.lua_pcall(luaState, argsCount, 1, 0) != 0)
					{
						string errorInfo = LuaDLL.lua_tostring(luaState, -1);
						ScriptManager.GetInstance().ShowScriptError(errorInfo);
					}
					result = (int)LuaDLL.lua_tonumber(luaState, -1);
					LuaDLL.lua_settop(luaState, luaTopIndex);
				}
			}
			AddToCache(this);
			return result;
		}

		public void PushBoolean(bool param)
		{
			LuaDLL.lua_pushboolean(luaState, param);
		}

		public void PushString(string param)
		{
			LuaDLL.lua_pushstring(luaState, param);
		}

		public void PushNumber(double param)
		{
			LuaDLL.lua_pushnumber(luaState, param);
		}

		public void PushInt(int param)
		{
			LuaDLL.lua_pushnumber(luaState, param);
		}

		public void PushObject(BaseInterface baseObject)
		{
			WraperUtil.PushObject(luaState, baseObject);
		}

		public int PushValues(params object[] values)
		{
			for (int i = 0; i < values.Length; i++)
			{
				if (values[i] == null)
				{
					BaseInterface baseObject = null;
					PushObject(baseObject);
				}
				else if (values[i].GetType() == typeof(float) || values[i].GetType() == typeof(double))
				{
					PushNumber(System.Convert.ToDouble(values[i]));
				}
				else if (values[i].GetType() == typeof(int))
				{
					PushInt(System.Convert.ToInt32(values[i]));
				}
				else if (values[i].GetType() == typeof(string))
				{
					PushString(System.Convert.ToString(values[i]));
				}
				else if (values[i].GetType() == typeof(bool))
				{
					PushBoolean(System.Convert.ToBoolean(values[i]));
				}
				else
				{
					PushObject((BaseInterface)values[i]);
				}
			}
			return values.Length;
		}

		public void PushTable(Dictionary<string, object> table)
		{
			foreach (KeyValuePair<string, object> item in table)
			{
				string key = item.Key;
				if (item.Value.GetType() == typeof(float) || item.Value.GetType() == typeof(double))
				{
					WraperUtil.LuaSetTable(luaState, item.Key, System.Convert.ToDouble(item.Value));
				}
				else if (item.Value.GetType() == typeof(uint) || item.Value.GetType() == typeof(int))
				{
					WraperUtil.LuaSetTable(luaState, item.Key, System.Convert.ToDouble(item.Value));
				}
				else if (item.Value.GetType() == typeof(string))
				{
					WraperUtil.LuaSetTable(luaState, item.Key, System.Convert.ToString(item.Value));
				}
				else if (item.Value.GetType() == typeof(bool))
				{
					WraperUtil.LuaSetTable(luaState, item.Key, System.Convert.ToBoolean(item.Value));
				}
				else
				{
					WraperUtil.LuaSetTable(luaState, item.Key, (BaseInterface)item.Value);
				}
			}
		}

		public void lua_settable(string key, string value)
		{
			WraperUtil.LuaSetTable(luaState, key, value);
		}

		public void lua_settable(string key, double value)
		{
			WraperUtil.LuaSetTable(luaState, key, value);
		}

		public void lua_settable(string key, bool value)
		{
			WraperUtil.LuaSetTable(luaState, key, value);
		}

		public void lua_settable(string key, BaseInterface value)
		{
			WraperUtil.LuaSetTable(luaState, key, value);
		}
	}
}
