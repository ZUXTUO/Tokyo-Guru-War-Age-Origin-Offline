using Core.Unity;
using Script;
using UnityEngine;

public class Alipay : MonoBehaviourEx
{
	private static string m_name = "_Alipay";

	private static Alipay m_instance;

	public string m_onPaymentedScript = string.Empty;

	public static Alipay GetInstance()
	{
		if (m_instance == null)
		{
			GameObject gameObject = MonoBehaviourEx.CreateGameObject(m_name);
			m_instance = gameObject.AddComponent<Alipay>();
		}
		return m_instance;
	}

	public bool CheckAccountExist()
	{
		bool flag = false;
		return AndroidAlipay.CheckAccountExist();
	}

	public bool Pay(string jsonString, string scriptFunction)
	{
		bool flag = false;
		m_onPaymentedScript = scriptFunction;
		return AndroidAlipay.Pay(jsonString, "_Alipay|OnPaymented");
	}

	public string GetVersion()
	{
		string empty = string.Empty;
		return AndroidAlipay.GetVersion();
	}

	public void OnPaymented(string msg)
	{
		if (!ScriptManager.GetInstance().CallFunction(m_onPaymentedScript, msg))
		{
			Core.Unity.Debug.LogError(string.Format("[Alipay OnPaymented] called, lua function failed"));
		}
	}
}
