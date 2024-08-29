public class AndroidAlipay : AndroidBehaviour
{
	public static bool CheckAccountExist()
	{
		//return AndroidBehaviour.instance.CallStatic<bool>("com.unityplugin.alipay.AlipaySDKManager", "check_account_if_exist", new object[0]);
		return true;
	}

	public static bool Pay(string jsonString, string scriptFunction)
	{
		//return AndroidBehaviour.instance.CallStatic<bool>("com.unityplugin.alipay.AlipaySDKManager", "pay", new object[2] { jsonString, scriptFunction });
		return true;
	}

	public static string GetVersion()
	{
		//return AndroidBehaviour.instance.CallStatic<string>("com.unityplugin.alipay.AlipaySDKManager", "get_version", new object[0]);
		return "9.9.9";
	}
}
