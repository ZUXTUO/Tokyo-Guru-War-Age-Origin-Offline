using System;
using System.Collections.Generic;
using Assets._Codes.Native;
using Core.Resource;
using Core.Unity;
using LuaInterface;
using UnityEngine;
using Wraper;

namespace Script
{
	internal class ScriptManager
	{
		private static ScriptManager instance;

		private LuaVM luavm;

		private IntPtr L = IntPtr.Zero;

		private int errorFunc;

		private ScriptManager()
		{
		}

		public static ScriptManager GetInstance()
		{
			if (instance == null)
			{
				instance = new ScriptManager();
				instance.luavm = LuaVM.GetInstance();
			}
			return instance;
		}

		public void InitL(IntPtr intPt)
		{
			L = intPt;
		}

		public void InitErrorFunc()
		{
			int newTop = LuaDLL.lua_gettop(L);
			LuaDLL.lua_getglobal(L, "gcallerr");
			if (LuaDLL.lua_type(L, -1) == LuaTypes.LUA_TFUNCTION)
			{
				errorFunc = LuaDLL.lua_gettop(L);
			}
			else
			{
				LuaDLL.lua_settop(L, newTop);
			}
		}

		public int GetErrorFunc()
		{
			return errorFunc;
		}

		private IntPtr IntPtrOffset(IntPtr ptr, int offset)
		{
			if (IntPtr.Size == 4)
			{
				return (IntPtr)(ptr.ToInt32() + offset);
			}
			return (IntPtr)(ptr.ToInt64() + offset);
		}

		public void Run(string filePath)
		{
			//bool flag = false;
			//bool flag2 = false;
			//flag = true;
			byte[] array = null;
			IntPtr memBuff = IntPtr.Zero;
			int buffLen = 0;
			int dataOffset = 0;
			//int num = 0;
			//if (flag)
			//{
			//	bool flag3 = true;
			//	string filePathGrayWrite = FileUtil.GetFilePathGrayWrite(filePath);
			//	if (filePathGrayWrite != string.Empty)
			//	{
			//		flag3 = false;
			//	}
			//	if (!flag3)
			//	{
			//		string resourceFullPath = ResourceManager.GetInstance().GetResourceFullPath(filePath);
			//		//num = NativeFile.load_file_2_mem(resourceFullPath, ref memBuff, ref buffLen, ref dataOffset, 1);
			//	}
			//	else
			//	{
			//		//num = NativeFile.load_file_in_apk_2_mem(filePath, ref memBuff, ref buffLen, ref dataOffset, 1);
			//	}
			//}
			//else if (flag2)
			//{
			//	string resourceFullPath2 = ResourceManager.GetInstance().GetResourceFullPath(filePath);
			//	//num = NativeFile.load_file_2_mem(resourceFullPath2, ref memBuff, ref buffLen, ref dataOffset, 1);
			//}
			//else
			//{
			//	array = ResourceManager.GetInstance().LoadResource(filePath);
			//}
			array = ResourceManager.GetInstance().LoadResource(filePath);
			//if (num != 0)
			//{
			//	UnityEngine.Debug.LogError(string.Format("open native file : {0} failed : {1}", filePath, num));
			//}
			int num2 = -1;
			if (memBuff != IntPtr.Zero)
			{
				num2 = LuaVM.GetInstance().luaL_loadbuffer(IntPtrOffset(memBuff, dataOffset), buffLen - dataOffset, filePath);
				NativeMemeory.free_memory(memBuff);
			}
			else if (array != null)
			{
				num2 = LuaVM.GetInstance().luaL_loadbuffer(array, array.Length, filePath);
			}
			if (num2 == 0)
			{
				num2 = LuaDLL.lua_pcall(L, 0, 0, 0);
				return;
			}
			string arg = LuaDLL.lua_tostring(L, -1);
			LuaDLL.lua_pop(L, 1);
			ShowScriptError(string.Format("load script error file:{0}, ret:{1}, info:{2}", filePath, (LuaStatus)num2, arg));
		}

		public void ShowScriptError(string errorInfo)
		{
			Core.Unity.Debug.LogError(errorInfo);
		}

		public LuaVM GetVM()
		{
			return luavm;
		}

		public bool CallFunction(string function)
		{
			ScriptCall scriptCall = ScriptCall.Create(function);
			if (scriptCall == null)
			{
				return false;
			}
			if (scriptCall.Start())
			{
				scriptCall.Finish(0);
				return true;
			}
			return false;
		}

		public bool CallFunction(string function, float x)
		{
			ScriptCall scriptCall = ScriptCall.Create(function);
			if (scriptCall == null)
			{
				return false;
			}
			if (scriptCall.Start())
			{
				scriptCall.PushNumber(x);
				scriptCall.Finish(1);
				return true;
			}
			return false;
		}

		public bool CallFunction(string function, float x, float y)
		{
			ScriptCall scriptCall = ScriptCall.Create(function);
			if (scriptCall == null)
			{
				return false;
			}
			if (scriptCall.Start())
			{
				scriptCall.PushNumber(x);
				scriptCall.PushNumber(y);
				scriptCall.Finish(2);
				return true;
			}
			return false;
		}

		public bool CallFunction(string function, float x, float y, float z)
		{
			ScriptCall scriptCall = ScriptCall.Create(function);
			if (scriptCall == null)
			{
				return false;
			}
			if (scriptCall.Start())
			{
				scriptCall.PushNumber(x);
				scriptCall.PushNumber(y);
				scriptCall.PushNumber(z);
				scriptCall.Finish(3);
				return true;
			}
			return false;
		}

		public bool CallFunction(string function, params object[] values)
		{
			ScriptCall scriptCall = ScriptCall.Create(function);
			if (scriptCall == null)
			{
				return false;
			}
			if (scriptCall.Start())
			{
				int argsCount = scriptCall.PushValues(values);
				scriptCall.Finish(argsCount);
				return true;
			}
			return false;
		}

		public bool CallFunction(string function, Dictionary<string, object> table)
		{
			ScriptCall scriptCall = ScriptCall.Create(function);
			if (scriptCall == null)
			{
				return false;
			}
			if (scriptCall.Start())
			{
				LuaDLL.lua_newtable(scriptCall.L);
				scriptCall.PushTable(table);
				scriptCall.Finish(1);
				return true;
			}
			return false;
		}

		public bool CallFunction(string function, List<Payment> payments)
		{
			ScriptCall scriptCall = ScriptCall.Create(function);
			if (scriptCall != null && scriptCall.Start())
			{
				WraperUtil.Push(scriptCall.L, payments.ToArray());
				scriptCall.Finish(1);
				return true;
			}
			return false;
		}

		public void CallGC(int data)
		{
			if (luavm.IsActive())
			{
				LuaDLL.lua_gc(luavm.GetLuaState(), LuaGCOptions.LUA_GCSTEP, data);
			}
		}
	}
}
