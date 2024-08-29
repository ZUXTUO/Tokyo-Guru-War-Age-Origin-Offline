using UnityEngine;

public class AndroidWeibo
{
	public static string CLASS_WECHAT = "com.digital.weibo.WeiboSdk";

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

	public static bool ShareText(string text)
	{
		return callJava<bool>("shareText", new object[1] { text });
	}

	public static bool SharePhoto(string text, string picPath)
	{
		return callJava<bool>("sharePhoto", new object[2] { text, picPath });
	}

	public static bool ShareWeb(string text, string title, string desc, string url, string thumbPath)
	{
		return callJava<bool>("shareWeb", new object[5] { text, title, desc, url, thumbPath });
	}
}
