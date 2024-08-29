public class AndroidSanalyze : AndroidBehaviour
{
	public static void ShowToast(string message, bool isLong)
	{
		//AndroidBehaviour.instance.CallStatic("com.unityplugin.UnityAndroidSanalyze", "ShowToast", message, isLong);
	}

	public static void OnEvent(string eventId, string eventParams)
	{
		//AndroidBehaviour.instance.CallStatic("com.unityplugin.UnityAndroidSanalyze", "OnEvent", eventId, eventParams);
	}

	public static string GetDeviceInfoByKey(string key)
	{
		//return AndroidBehaviour.instance.CallStatic<string>("com.unityplugin.UnityAndroidSanalyze", "GetDeviceInfoByKey", new object[1] { key });
		return "";
	}
}
