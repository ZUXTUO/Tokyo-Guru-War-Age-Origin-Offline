using System.Collections.Generic;
using Script;
using UnityEngine;

public class AndroidMessageDispatch : MonoBehaviour
{
	public void OnMessage(string param)
	{
		Installer.Instance().AndroidLog(param);
		List<string> list = new List<string>(param.Split('|'));
		if (list.Count > 0)
		{
			string function = list[0];
			list.RemoveAt(0);
			ScriptManager.GetInstance().CallFunction(function, list.ToArray());
		}
	}
}
