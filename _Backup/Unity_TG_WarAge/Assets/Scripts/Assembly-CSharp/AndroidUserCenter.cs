using System.Text;

public class AndroidUserCenter : AndroidBehaviour
{
	public static void Init(string appId, string appKey)
	{
		//AndroidBehaviour.instance.CallStatic("com.unityplugin.UserCenter", "init", appId, appKey);
	}

	public static string GetVersion()
	{
		//return AndroidBehaviour.instance.CallStatic<string>("com.unityplugin.UserCenter", "version", new object[0]);
		return "9.9.9";
	}

	public static bool Login(string customVal)
	{
		//byte[] bytes = Encoding.Default.GetBytes(customVal);
		//customVal = Encoding.UTF8.GetString(bytes);
		//return AndroidBehaviour.instance.CallStatic<bool>("com.unityplugin.UserCenter", "login", new object[1] { customVal });
		return true;
	}

	public static bool Logout()
	{
		//return AndroidBehaviour.instance.CallStatic<bool>("com.unityplugin.UserCenter", "logout", new object[0]);
		return true;
	}

	public static bool OpenUserCenter(int index)
	{
		//return AndroidBehaviour.instance.CallStatic<bool>("com.unityplugin.UserCenter", "open_user_center", new object[1] { index });
		return true;
	}

	public static bool SwitchAccount()
	{
		//return AndroidBehaviour.instance.CallStatic<bool>("com.unityplugin.UserCenter", "switch_account", new object[0]);
		return true;
	}

	public static bool Payment(int money, string productId, string productName, string serverId, string charId, string accountId, string jsonstr)
	{
		//byte[] bytes = Encoding.Default.GetBytes(productId);
		//productId = Encoding.UTF8.GetString(bytes);
		//bytes = Encoding.Default.GetBytes(productName);
		//productName = Encoding.UTF8.GetString(bytes);
		//bytes = Encoding.Default.GetBytes(serverId);
		//serverId = Encoding.UTF8.GetString(bytes);
		//bytes = Encoding.Default.GetBytes(charId);
		//charId = Encoding.UTF8.GetString(bytes);
		//bytes = Encoding.Default.GetBytes(accountId);
		//accountId = Encoding.UTF8.GetString(bytes);
		//bytes = Encoding.Default.GetBytes(jsonstr);
		//jsonstr = Encoding.UTF8.GetString(bytes);
		//return AndroidBehaviour.instance.CallStatic<bool>("com.unityplugin.UserCenter", "payment", new object[7] { money, productId, productName, serverId, charId, accountId, jsonstr });
		return true;
	}

	public static void SubmitExtendInfo(string jsonValue)
	{
		//byte[] bytes = Encoding.Default.GetBytes(jsonValue);
		//jsonValue = Encoding.UTF8.GetString(bytes);
		//AndroidBehaviour.instance.CallStatic("com.unityplugin.UserCenter", "on_submit_extend_info", jsonValue);
	}

	public static void AddInfo(string key, string value)
	{
		//byte[] bytes = Encoding.Default.GetBytes(value);
		//value = Encoding.UTF8.GetString(bytes);
		//AndroidBehaviour.instance.CallStatic("com.unityplugin.UserCenter", "add_info", key, value);
	}

	public static void ShowToolBar()
	{
		//AndroidBehaviour.instance.CallStatic("com.unityplugin.UserCenter", "showToolBar");
	}

	public static void HideToolBar()
	{
		//AndroidBehaviour.instance.CallStatic("com.unityplugin.UserCenter", "hideToolBar");
	}

	public static void OpenCustomServiceWebPage()
	{
		//AndroidBehaviour.instance.CallStatic("com.unityplugin.UserCenter", "open_kefu_web_page");
	}

	public static string GetToolBarUrl(int index)
	{
		//return AndroidBehaviour.instance.CallStatic<string>("com.unityplugin.UserCenter", "getToolBarUrl", new object[1] { index });
		return "";
	}
}
