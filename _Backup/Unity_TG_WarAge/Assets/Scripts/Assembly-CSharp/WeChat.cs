public class WeChat
{
	public static bool CheckInstall()
	{
		bool flag = false;
		return AndroidWeChat.CheckInstall();
	}

	public static bool ShareText(int scene, string text)
	{
		bool flag = false;
		return AndroidWeChat.ShareText(scene, text);
	}

	public static bool SharePhoto(int scene, string title, string desc, string picPath)
	{
		bool flag = false;
		return AndroidWeChat.SharePhoto(scene, title, desc, picPath);
	}

	public static bool ShareWeb(int scene, string title, string desc, string url, string thumbPath)
	{
		bool flag = false;
		return AndroidWeChat.ShareWeb(scene, title, desc, url, thumbPath);
	}

	public static bool pay(string order)
	{
		bool flag = false;
		return AndroidWeChat.pay(order);
	}
}
