using UnityEngine;

public class AndroidWeChat
{
	public static string CLASS_WECHAT = "com.digital.wechat.WechatSdk";

	private static T callJava<T>(string apiName, params object[] args)
	{
		using (AndroidJavaClass androidJavaClass = new AndroidJavaClass(CLASS_WECHAT))
		{
			if (androidJavaClass != null)
			{
				return androidJavaClass.CallStatic<T>(apiName, args);
			}
			return default(T);
		}
	}

	public static bool CheckInstall()
	{
		return callJava<bool>("checkInstall", new object[0]);
	}

	public static bool ShareText(int scene, string text)
	{
		return callJava<bool>("shareText", new object[2] { scene, text });
	}

	public static bool SharePhoto(int scene, string title, string desc, string picPath)
	{
		return callJava<bool>("sharePhoto", new object[4] { scene, title, desc, picPath });
	}

	public static bool ShareWeb(int scene, string title, string desc, string url, string thumbPath)
	{
		return callJava<bool>("shareWeb", new object[5] { scene, title, desc, url, thumbPath });
	}

	public static bool pay(string order)
	{
		return callJava<bool>("pay", new object[1] { order });
	}
}
