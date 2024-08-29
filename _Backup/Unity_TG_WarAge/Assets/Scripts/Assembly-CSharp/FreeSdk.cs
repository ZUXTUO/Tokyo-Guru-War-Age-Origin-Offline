using System;
using Core.Unity;
using UnityEngine;

public class FreeSdk : MonoBehaviour
{
	/*
	public delegate void UserDelegate(int state, string data);

	public delegate void PayDelegate(int state, string data);

	private static string m_name = "_FreeSdk";

	private static FreeSdk m_instance;

	private UserDelegate m_onUserCallback;

	private PayDelegate m_onPayCallback;

	public static FreeSdk GetInstance()
	{
		if (m_instance == null)
		{
			GameObject gameObject = new GameObject(m_name);
			m_instance = gameObject.AddComponent<FreeSdk>();
		}
		return m_instance;
	}

	public void SetOnUser(UserDelegate callback)
	{
		m_onUserCallback = callback;
	}

	public void SetOnPay(PayDelegate callback)
	{
		m_onPayCallback = callback;
	}

	private void OnUser(string msg)
	{
		string[] array = msg.Split(new string[1] { "|@|" }, StringSplitOptions.None);
		if (array.Length >= 2 && m_onUserCallback != null)
		{
			m_onUserCallback(int.Parse(array[0]), array[1]);
		}
	}

	private void OnPaymented(string msg)
	{
		string[] array = msg.Split(new string[1] { "|@|" }, StringSplitOptions.None);
		if (array.Length >= 2 && m_onPayCallback != null)
		{
			m_onPayCallback(int.Parse(array[0]), array[1]);
		}
	}

	public bool Login(string customVal)
	{
		bool flag = false;
		return AndroidFreeSdk.Login(customVal);
	}

	public bool Logout()
	{
		bool flag = false;
		return AndroidFreeSdk.Logout();
	}

	public bool OpenUserCenter(int index)
	{
		bool flag = false;
		return AndroidFreeSdk.OpenUserCenter(index);
	}

	public void OpenKefuWebPage()
	{
		AndroidFreeSdk.OpenKefuWebPage();
	}

	public bool ShowToolBar()
	{
		bool flag = false;
		return AndroidFreeSdk.ShowToolBar();
	}

	public bool HideToolBar()
	{
		bool flag = false;
		return AndroidFreeSdk.HideToolBar();
	}

	public bool SwitchAccount()
	{
		bool flag = false;
		return AndroidFreeSdk.SwitchAccount();
	}

	public bool Pay(string param)
	{
		return Pay(string.Empty, param);
	}

	public bool Pay(string channel, string param)
	{
		bool flag = false;
		Core.Unity.Debug.Log("freesdk pay,channel=" + channel + ",param=" + param);
		return AndroidFreeSdk.Pay(channel, param);
	}

	public void SubmitExtendInfo(string jsonValue)
	{
		AndroidFreeSdk.SubmitExtendInfo(jsonValue);
	}

	public bool Exit()
	{
		bool flag = false;
		return AndroidFreeSdk.Exit();
	}

	public bool SanalyzeReport(string id, string jsonParam)
	{
		bool flag = false;
		return AndroidFreeSdk.sanalyze(id, jsonParam);
	}

	public bool DataSubmit(string jsonParam)
	{
		bool flag = false;
		return AndroidFreeSdk.submit(jsonParam);
	}

	public string getDeviceInfo(string id)
	{
		string empty = string.Empty;
		return AndroidFreeSdk.getDeviceInfo(id);
	}

	public bool WechatCheck()
	{
		bool flag = false;
		return AndroidFreeSdk.WechatCheck();
	}

	public bool WechatPay(string order)
	{
		bool flag = false;
		return AndroidFreeSdk.WechatPay(order);
	}

	public bool WechatShareText(int scene, string text)
	{
		bool flag = false;
		return AndroidFreeSdk.WechatShareText(scene, text);
	}

	public bool WechatSharePhoto(int scene, string title, string desc, string picPath)
	{
		bool flag = false;
		return AndroidFreeSdk.WechatSharePhoto(scene, title, desc, picPath);
	}

	public bool WechatShareWeb(int scene, string title, string desc, string url, string thumbPath)
	{
		bool flag = false;
		return AndroidFreeSdk.WechatShareWeb(scene, title, desc, url, thumbPath);
	}

	public bool WeiboCheck()
	{
		bool flag = false;
		return AndroidFreeSdk.WeiboCheck();
	}

	public bool WeiboShareText(string text)
	{
		bool flag = false;
		return AndroidFreeSdk.WeiboShareText(text);
	}

	public bool WeiboSharePhoto(string text, string picPath)
	{
		bool flag = false;
		return AndroidFreeSdk.WeiboSharePhoto(text, picPath);
	}

	public bool WeiboShareWeb(string text, string title, string desc, string url, string thumbPath)
	{
		bool flag = false;
		return AndroidFreeSdk.WeiboShareWeb(text, title, desc, url, thumbPath);
	}
	*/
}
