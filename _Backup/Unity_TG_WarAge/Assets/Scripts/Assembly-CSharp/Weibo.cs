public class Weibo
{
	public static bool CheckInstall()
	{
		bool flag = false;
		return AndroidWeibo.CheckInstall();
	}

	public static bool ShareText(string text)
	{
		bool flag = false;
		return AndroidWeibo.ShareText(text);
	}

	public static bool SharePhoto(string text, string picPath)
	{
		bool flag = false;
		return AndroidWeibo.SharePhoto(text, picPath);
	}

	public static bool ShareWeb(string text, string title, string desc, string url, string thumbPath)
	{
		bool flag = false;
		return AndroidWeibo.ShareWeb(text, title, desc, url, thumbPath);
	}
}
