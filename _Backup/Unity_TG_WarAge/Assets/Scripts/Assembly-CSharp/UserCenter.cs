using System;
using Core.Unity;
using Script;
using SimpleJSON;
using UnityEngine;

public class UserCenter : MonoBehaviourEx
{
	private static string m_name = "_UserCenter";

	private static UserCenter m_instance;

	public string m_onLoginedScript = string.Empty;

	public string m_onLogoutedScript = string.Empty;

	public string m_onPaymentedScript = string.Empty;

	public string m_onWechatshareScript = string.Empty;

	public string m_onWechatpayScript = string.Empty;

	public string m_onWeiboshareScript = string.Empty;

	private static int SDK_TYPE = 1;

	public static UserCenter GetInstance()
	{
		if (m_instance == null)
		{
			GameObject gameObject = MonoBehaviourEx.CreateGameObject(m_name);
			m_instance = gameObject.AddComponent<UserCenter>();
		}
		return m_instance;
	}

	public void Init(string appId, string appKey)
	{
		if (SDK_TYPE == 0)
		{
			AndroidUserCenter.Init(appId, appKey);
		}
	}

	public string GetVersion()
	{
		string result = string.Empty;
		if (SDK_TYPE == 0)
		{
			result = AndroidUserCenter.GetVersion();
		}
		return result;
	}

	public bool Login(string customVal)
	{
		//bool flag = false;
		//if (SDK_TYPE == 0)
		//{
		//	return AndroidUserCenter.Login(customVal);
		//}
		//return FreeSdk.GetInstance().Login(customVal);
		return true;
	}

	public bool Logout()
	{
		//bool flag = false;
		//if (SDK_TYPE == 0)
		//{
		//	return AndroidUserCenter.Logout();
		//}
		//return FreeSdk.GetInstance().Logout();
		return true;
	}

	public bool OpenUserCenter(int index)
	{
		//bool flag = false;
		//if (SDK_TYPE == 0)
		//{
		//	return AndroidUserCenter.OpenUserCenter(index);
		//}
		//return FreeSdk.GetInstance().OpenUserCenter(index);
		return true;
	}

	public bool SwitchAccount()
	{
		//bool flag = false;
		//if (SDK_TYPE == 0)
		//{
		//	return AndroidUserCenter.SwitchAccount();
		//}
		//return FreeSdk.GetInstance().SwitchAccount();
		return true;
	}

	public bool Payment(int money, string productId, string productName, string serverId, string charId, string accountId, string jsonstr)
	{
		//bool result = false;
		//Core.Unity.Debug.Log("UserCenter Payment,jsonstr=" + jsonstr);
		//if (SDK_TYPE == 0)
		//{
		//	result = AndroidUserCenter.Payment(money, productId, productName, serverId, charId, accountId, jsonstr);
		//}
		//else
		//{
		//	JSONNode jSONNode = null;
		//	try
		//	{
		//		jSONNode = JSONNode.Parse(jsonstr);
		//		result = FreeSdk.GetInstance().Pay(jSONNode["channel"].Value.ToString(), jsonstr);
		//	}
		//	catch (Exception)
		//	{
		//		Core.Unity.Debug.LogError("[UserCenter Payment] try json failed:" + jsonstr);
		//	}
		//}
		//return result;
		return true;
	}

	public bool Payment(string channel, string jsonstr)
	{
		//bool flag = false;
		//return FreeSdk.GetInstance().Pay(channel, jsonstr);
		return true;
	}

	public void SubmitExtendInfo(string jsonValue)
	{
		//if (SDK_TYPE == 0)
		//{
		//	AndroidUserCenter.SubmitExtendInfo(jsonValue);
		//}
		//else
		//{
		//	FreeSdk.GetInstance().SubmitExtendInfo(jsonValue);
		//}
	}

	public void AddInfo(string key, string value)
	{
		//if (SDK_TYPE == 0)
		//{
		//	AndroidUserCenter.AddInfo(key, value);
		//	return;
		//}
		//JSONClass jSONClass = new JSONClass();
		//jSONClass["type"] = "addInfo";
		//jSONClass[key] = value;
		//FreeSdk.GetInstance().SubmitExtendInfo(jSONClass.ToString());
	}

	public void ShowToolBar()
	{
		//if (SDK_TYPE == 0)
		//{
		//	AndroidUserCenter.ShowToolBar();
		//}
		//else
		//{
		//	FreeSdk.GetInstance().ShowToolBar();
		//}
	}

	public void HideToolBar()
	{
		//if (SDK_TYPE == 0)
		//{
		//	AndroidUserCenter.HideToolBar();
		//}
		//else
		//{
		//	FreeSdk.GetInstance().HideToolBar();
		//}
	}

	public bool Sdk_Exit()
	{
		//bool result = false;
		//if (SDK_TYPE != 0)
		//{
		//	result = FreeSdk.GetInstance().Exit();
		//}
		//return result;
		return true;
	}

	public void OpenCustomServiceWebPage()
	{
		//if (SDK_TYPE == 0)
		//{
		//	AndroidUserCenter.OpenCustomServiceWebPage();
		//}
		//else
		//{
		//	FreeSdk.GetInstance().OpenKefuWebPage();
		//}
	}

	public string GetToolBarUrl(int index)
	{
		return string.Empty;
	}

	public string getDeviceInfo(string key)
	{
		//string empty = string.Empty;
		//return FreeSdk.GetInstance().getDeviceInfo(key);
		return "";
	}

	public void SanalyzeReport(string event_id, string event_params)
	{
		//FreeSdk.GetInstance().SanalyzeReport(event_id, event_params);
	}

	public void OnLogined(string msg)
	{
		string[] array = msg.Split(new string[1] { "|@|" }, StringSplitOptions.None);
		if (array.Length == 2)
		{
			JSONNode jSONNode = null;
			try
			{
				jSONNode = JSONNode.Parse(array[1]);
			}
			catch (Exception)
			{
				Core.Unity.Debug.LogError("[UserCenter OnLogined] try json failed:" + msg);
				return;
			}
			if (!ScriptManager.GetInstance().CallFunction(m_onLoginedScript, array[0], jSONNode["msg"].Value.ToString(), jSONNode["openid"].Value.ToString(), jSONNode["token"].Value.ToString(), jSONNode["ext"].Value.ToString(), array[1]))
			{
				Core.Unity.Debug.LogError(string.Format("[UserCenter OnLogined] called, lua function failed"));
			}
		}
		else if (array.Length == 5)
		{
			if (!ScriptManager.GetInstance().CallFunction(m_onLoginedScript, array[0], array[1], array[2], array[3], array[4], string.Empty))
			{
				Core.Unity.Debug.LogError(string.Format("[UserCenter OnLogined] called, lua function failed"));
			}
		}
		else
		{
			Core.Unity.Debug.LogError("usercenter onlogined array !=2 !=5");
		}
	}

	public void OnLoginedJson(string json_msg)
	{
		if (!ScriptManager.GetInstance().CallFunction(m_onLoginedScript, json_msg))
		{
			Core.Unity.Debug.LogError(string.Format("[UserCenter OnLogined] called, lua function failed"));
		}
	}

	public void OnLoginOuted(string msg)
	{
		if (!ScriptManager.GetInstance().CallFunction(m_onLogoutedScript))
		{
			Core.Unity.Debug.LogError(string.Format("[UserCenter OnLoginOuted] called, lua function failed"));
		}
	}

	public void OnPaymented(string msg)
	{
		Core.Unity.Debug.Log("OnPaymented=" + msg);
		string[] array = msg.Split(new string[1] { "|@|" }, StringSplitOptions.None);
		if (array.Length == 2)
		{
			try
			{
				JSONNode jSONNode = JSONNode.Parse(array[1]);
				if (!ScriptManager.GetInstance().CallFunction(m_onPaymentedScript, array[0].ToString(), jSONNode["msg"].Value.ToString(), jSONNode["money"].Value.ToString(), jSONNode["orderId"].Value.ToString()))
				{
					Core.Unity.Debug.LogError(string.Format("[UserCenter OnPaymented] called, lua function failed"));
				}
				return;
			}
			catch (Exception)
			{
				Core.Unity.Debug.LogError("[UserCenter OnPaymented] try json failed:" + msg);
				return;
			}
		}
		if (array.Length == 3 && !ScriptManager.GetInstance().CallFunction(m_onPaymentedScript, array[0], array[1], array[2], array[3]))
		{
			Core.Unity.Debug.LogError(string.Format("[UserCenter OnPaymented] called, lua function failed"));
		}
	}

	public void OnPaymentedJson(string json_msg)
	{
		if (!ScriptManager.GetInstance().CallFunction(m_onPaymentedScript, json_msg))
		{
			Core.Unity.Debug.LogError(string.Format("[UserCenter OnPaymented] called, lua function failed"));
		}
	}

	public bool WechatCheck()
	{
		//bool flag = false;
		//return FreeSdk.GetInstance().WechatCheck();
		return true;
	}

	public bool WechatPay(string order)
	{
		//bool flag = false;
		//return FreeSdk.GetInstance().WechatPay(order);
		return true;
	}

	public void OnWechatshareCallback(string msg)
	{
		string[] array = msg.Split(new string[1] { "|@|" }, StringSplitOptions.None);
		if (!ScriptManager.GetInstance().CallFunction(m_onWechatshareScript, array[0], array[1]))
		{
			Core.Unity.Debug.LogError(string.Format("[UserCenter OnWechatshareCallback] called, lua function failed"));
		}
	}

	public void OnWechatpayCallback(string msg)
	{
		string[] array = msg.Split(new string[1] { "|@|" }, StringSplitOptions.None);
		if (!ScriptManager.GetInstance().CallFunction(m_onWechatpayScript, array[0], array[1]))
		{
			Core.Unity.Debug.LogError(string.Format("[UserCenter m_onWechatpayScript] called, lua function failed"));
		}
	}

	public bool WechatShare(string msg)
	{
		//bool result = false;
		//int num = 0;
		//string empty = string.Empty;
		//string empty2 = string.Empty;
		//string empty3 = string.Empty;
		//string empty4 = string.Empty;
		//string empty5 = string.Empty;
		//string empty6 = string.Empty;
		//try
		//{
		//	JSONNode jSONNode = JSONNode.Parse(msg);
		//	if (jSONNode.Count == 2)
		//	{
		//		num = jSONNode["scene"].AsInt;
		//		empty = jSONNode["text"].Value.ToString();
		//		result = FreeSdk.GetInstance().WechatShareText(num, empty);
		//	}
		//	else if (jSONNode.Count == 4)
		//	{
		//		num = jSONNode["scene"].AsInt;
		//		empty2 = jSONNode["title"].Value.ToString();
		//		empty3 = jSONNode["desc"].Value.ToString();
		//		empty4 = jSONNode["picPath"].Value.ToString();
		//		result = FreeSdk.GetInstance().WechatSharePhoto(num, empty2, empty3, empty4);
		//	}
		//	else if (jSONNode.Count == 5)
		//	{
		//		num = jSONNode["scene"].AsInt;
		//		empty2 = jSONNode["title"].Value.ToString();
		//		empty3 = jSONNode["desc"].Value.ToString();
		//		empty5 = jSONNode["url"].Value.ToString();
		//		string text = jSONNode["thumbPath"].Value.ToString();
		//		empty6 = ((!(text == "nill")) ? text : string.Empty);
		//		result = FreeSdk.GetInstance().WechatShareWeb(num, empty2, empty3, empty5, empty6);
		//	}
		//}
		//catch (Exception)
		//{
		//	Core.Unity.Debug.LogError("[UserCenter WechatShare] try json failed:" + msg);
		//}
		//return result;
		return true;
	}

	public bool WeiboCheck()
	{
		//bool flag = false;
		//return FreeSdk.GetInstance().WeiboCheck();
		return true;
	}

	public void weibo_shareCallback(string msg)
	{
		string[] array = msg.Split(new string[1] { "|@|" }, StringSplitOptions.None);
		if (!ScriptManager.GetInstance().CallFunction(m_onWeiboshareScript, array[0], array[1]))
		{
			Core.Unity.Debug.LogError(string.Format("[UserCenter m_onWechatpayScript] called, lua function failed"));
		}
	}

	public bool WeiboShare(string msg)
	{
		//bool result = false;
		//string empty = string.Empty;
		//string empty2 = string.Empty;
		//string empty3 = string.Empty;
		//string empty4 = string.Empty;
		//string empty5 = string.Empty;
		//string empty6 = string.Empty;
		//try
		//{
		//	JSONNode jSONNode = JSONNode.Parse(msg);
		//	if (jSONNode.Count == 1)
		//	{
		//		empty = jSONNode["text"].Value.ToString();
		//		result = FreeSdk.GetInstance().WeiboShareText(empty);
		//	}
		//	else if (jSONNode.Count == 2)
		//	{
		//		empty = jSONNode["text"].Value.ToString();
		//		empty2 = jSONNode["picPath"].Value.ToString();
		//		result = FreeSdk.GetInstance().WeiboSharePhoto(empty, empty2);
		//	}
		//	else if (jSONNode.Count == 5)
		//	{
		//		empty = jSONNode["text"].Value.ToString();
		//		empty3 = jSONNode["title"].Value.ToString();
		//		empty4 = jSONNode["desc"].Value.ToString();
		//		empty5 = jSONNode["url"].Value.ToString();
		//		string text = jSONNode["thumbPath"].Value.ToString();
		//		empty6 = ((!(text == "nill")) ? text : string.Empty);
		//		result = FreeSdk.GetInstance().WeiboShareWeb(empty, empty3, empty4, empty5, empty6);
		//	}
		//}
		//catch (Exception)
		//{
		//	Core.Unity.Debug.LogError("[UserCenter WeiboShare] try json failed:" + msg);
		//}
		//return result;
		return true;
	}
}
