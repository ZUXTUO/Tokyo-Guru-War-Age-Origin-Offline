using System.Text;
using Core.Unity;

public class AndroidFreeSdk : AndroidBehaviour
{
	/*
	public const string CLASS_FREESDK_USER = "com.digitalsky.sdk.user.FreeSdkUser";

	public const string CLASS_FREESDK_PAY = "com.digitalsky.sdk.pay.FreeSdkPay";

	public const string CLASS_FREESDK_DATA = "com.digitalsky.sdk.data.FreeSdkData";

	public const string CLASS_PLUGIN_WECHAT = "com.digital.wechat.WechatSdk";

	public const string CLASS_PLUGIN_WEIBO = "com.digital.weibo.WeiboSdk";
	*/
	public static bool Login(string customVal)
	{
		/*
		byte[] bytes = Encoding.Default.GetBytes(customVal);
		customVal = Encoding.UTF8.GetString(bytes);
		return AndroidBehaviour.instance.CallStatic<bool>("com.digitalsky.sdk.user.FreeSdkUser", "login", new object[1] { customVal });
		*/
		return true;
	}

	public static bool Logout()
	{
		//return AndroidBehaviour.instance.CallStatic<bool>("com.digitalsky.sdk.user.FreeSdkUser", "logout", new object[0]);
		return true;
	}

	public static bool OpenUserCenter(int index)
	{
		//return AndroidBehaviour.instance.CallStatic<bool>("com.digitalsky.sdk.user.FreeSdkUser", "enterPlatform", new object[1] { index });
		return true;
	}

	public static bool OpenKefuWebPage()
	{
		//return AndroidBehaviour.instance.CallStatic<bool>("com.digitalsky.sdk.user.FreeSdkUser", "openKefu", new object[0]);
		return true;
	}

	public static bool ShowToolBar()
	{
		//return AndroidBehaviour.instance.CallStatic<bool>("com.digitalsky.sdk.user.FreeSdkUser", "showToolBar", new object[0]);
		return true;
	}

	public static bool HideToolBar()
	{
		//return AndroidBehaviour.instance.CallStatic<bool>("com.digitalsky.sdk.user.FreeSdkUser", "hideToolBar", new object[0]);
		return true;
	}

	public static bool SwitchAccount()
	{
		//return AndroidBehaviour.instance.CallStatic<bool>("com.digitalsky.sdk.user.FreeSdkUser", "switchAccount", new object[0]);
		return true;
	}

	public static bool Exit()
	{
		//return AndroidBehaviour.instance.CallStatic<bool>("com.digitalsky.sdk.user.FreeSdkUser", "exit", new object[0]);
		return true;
	}

	public static bool SubmitExtendInfo(string jsonValue)
	{
		//byte[] bytes = Encoding.Default.GetBytes(jsonValue);
		//jsonValue = Encoding.UTF8.GetString(bytes);
		//return AndroidBehaviour.instance.CallStatic<bool>("com.digitalsky.sdk.user.FreeSdkUser", "submitInfo", new object[1] { jsonValue });
		return true;
	}

	public static bool Pay(string channel, string jsonParam)
	{
		//byte[] bytes = Encoding.Default.GetBytes(jsonParam);
		//jsonParam = Encoding.UTF8.GetString(bytes);
		//bytes = Encoding.Default.GetBytes(channel);
		//channel = Encoding.UTF8.GetString(bytes);
		//Debug.Log("AndroidFreeSdk  Pay,channel=" + channel + ",jsonParam=" + jsonParam);
		//return AndroidBehaviour.instance.CallStatic<bool>("com.digitalsky.sdk.pay.FreeSdkPay", "pay", new object[2] { channel, jsonParam });
		return true;
	}

	public static bool submit(string jsonParam)
	{
		//byte[] bytes = Encoding.Default.GetBytes(jsonParam);
		//jsonParam = Encoding.UTF8.GetString(bytes);
		//return AndroidBehaviour.instance.CallStatic<bool>("com.digitalsky.sdk.data.FreeSdkData", "submit", new object[1] { jsonParam });
		return true;
	}

	public static bool sanalyze(string id, string jsonParam)
	{
		//byte[] bytes = Encoding.Default.GetBytes(jsonParam);
		//jsonParam = Encoding.UTF8.GetString(bytes);
		//bytes = Encoding.Default.GetBytes(id);
		//id = Encoding.UTF8.GetString(bytes);
		//return AndroidBehaviour.instance.CallStatic<bool>("com.digitalsky.sdk.data.FreeSdkData", "sanalyzeReport", new object[2] { id, jsonParam });
		return true;
	}

	public static string getDeviceInfo(string id)
	{
		//byte[] bytes = Encoding.Default.GetBytes(id);
		//id = Encoding.UTF8.GetString(bytes);
		//return AndroidBehaviour.instance.CallStatic<string>("com.digitalsky.sdk.data.FreeSdkData", "getDeviceInfo", new object[1] { id });
		return "";
	}

	public static bool WechatCheck()
	{
		//return AndroidBehaviour.instance.CallStatic<bool>("com.digital.wechat.WechatSdk", "checkInstall", new object[0]);
		return true;
	}

	public static bool WechatPay(string jsonParam)
	{
		//byte[] bytes = Encoding.Default.GetBytes(jsonParam);
		//jsonParam = Encoding.UTF8.GetString(bytes);
		//return AndroidBehaviour.instance.CallStatic<bool>("com.digital.wechat.WechatSdk", "pay", new object[1] { jsonParam });
		return true;
	}

	public static bool WechatShareText(int scene, string text)
	{
		//byte[] bytes = Encoding.Default.GetBytes(text);
		//text = Encoding.UTF8.GetString(bytes);
		//return AndroidBehaviour.instance.CallStatic<bool>("com.digital.wechat.WechatSdk", "shareText", new object[2] { scene, text });
		return true;
	}

	public static bool WechatSharePhoto(int scene, string title, string desc, string picPath)
	{
		//byte[] bytes = Encoding.Default.GetBytes(title);
		//title = Encoding.UTF8.GetString(bytes);
		//bytes = Encoding.Default.GetBytes(desc);
		//desc = Encoding.UTF8.GetString(bytes);
		//bytes = Encoding.Default.GetBytes(picPath);
		//picPath = Encoding.UTF8.GetString(bytes);
		//return AndroidBehaviour.instance.CallStatic<bool>("com.digital.wechat.WechatSdk", "sharePhoto", new object[4] { scene, title, desc, picPath });
		return true;
	}

	public static bool WechatShareWeb(int scene, string title, string desc, string url, string thumbPath)
	{
		//byte[] bytes = Encoding.Default.GetBytes(title);
		//title = Encoding.UTF8.GetString(bytes);
		//bytes = Encoding.Default.GetBytes(desc);
		//desc = Encoding.UTF8.GetString(bytes);
		//bytes = Encoding.Default.GetBytes(url);
		//url = Encoding.UTF8.GetString(bytes);
		//bytes = Encoding.Default.GetBytes(thumbPath);
		//thumbPath = Encoding.UTF8.GetString(bytes);
		//return AndroidBehaviour.instance.CallStatic<bool>("com.digital.wechat.WechatSdk", "shareWeb", new object[5] { scene, title, desc, url, thumbPath });
		return true;
	}

	public static bool WeiboCheck()
	{
		//return AndroidBehaviour.instance.CallStatic<bool>("com.digital.weibo.WeiboSdk", "checkInstall", new object[0]);
		return true;
	}

	public static bool WeiboShareText(string text)
	{
		//byte[] bytes = Encoding.Default.GetBytes(text);
		//text = Encoding.UTF8.GetString(bytes);
		//return AndroidBehaviour.instance.CallStatic<bool>("com.digital.weibo.WeiboSdk", "shareText", new object[1] { text });
		return true;
	}

	public static bool WeiboSharePhoto(string text, string picPath)
	{
		//byte[] bytes = Encoding.Default.GetBytes(text);
		//text = Encoding.UTF8.GetString(bytes);
		//bytes = Encoding.Default.GetBytes(picPath);
		//picPath = Encoding.UTF8.GetString(bytes);
		//return AndroidBehaviour.instance.CallStatic<bool>("com.digital.weibo.WeiboSdk", "sharePhoto", new object[2] { text, picPath });
		return true;
	}

	public static bool WeiboShareWeb(string text, string title, string desc, string url, string thumbPath)
	{
		//byte[] bytes = Encoding.Default.GetBytes(text);
		//text = Encoding.UTF8.GetString(bytes);
		//bytes = Encoding.Default.GetBytes(title);
		//title = Encoding.UTF8.GetString(bytes);
		//bytes = Encoding.Default.GetBytes(desc);
		//desc = Encoding.UTF8.GetString(bytes);
		//bytes = Encoding.Default.GetBytes(url);
		//url = Encoding.UTF8.GetString(bytes);
		//bytes = Encoding.Default.GetBytes(thumbPath);
		//thumbPath = Encoding.UTF8.GetString(bytes);
		//return AndroidBehaviour.instance.CallStatic<bool>("com.digital.weibo.WeiboSdk", "shareWeb", new object[5] { text, title, desc, url, thumbPath });
		return true;
	}
}
