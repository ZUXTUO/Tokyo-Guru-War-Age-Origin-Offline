using System.Collections.Generic;
using Assets._protol_test;
using Core.Unity;
using LuaInterface;
using UnityEngine;

public class ProtolTestComponent : MonoBehaviour
{
	private ProtolTestServer pts = ProtolTestServer.GetInst();

	private LuaVM luaVM;

	private void Start()
	{
		pts.BeginNet();
		luaVM = LuaVM.GetInstance();
	}

	private void Update()
	{
		List<string> allRunScriptList = pts.GetAllRunScriptList();
		foreach (string item in allRunScriptList)
		{
			int num = -1;
			num = luaVM.luaL_loadstring(item);
			if (num == 0)
			{
				num = LuaDLL.lua_pcall(luaVM.GetLuaState(), 0, 0, 0);
			}
			if (num != 0)
			{
				string arg = LuaDLL.lua_tostring(luaVM.GetLuaState(), -1);
				LuaDLL.lua_pop(luaVM.GetLuaState(), 1);
				Core.Unity.Debug.LogError(string.Format("{0} {1}\nscript:\n{2}", (LuaStatus)num, arg, item));
			}
		}
		allRunScriptList.Clear();
		pts.SendAllFrontPackage();
	}

	private void OnDestroy()
	{
		pts.StopNet();
	}
}
