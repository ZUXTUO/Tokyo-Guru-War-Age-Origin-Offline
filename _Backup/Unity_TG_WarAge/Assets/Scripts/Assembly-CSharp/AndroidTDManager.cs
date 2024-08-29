public class AndroidTDManager : AndroidBehaviour
{
	public static bool Submit(string type, string data)
	{
		//return AndroidBehaviour.instance.CallStatic<bool>("com.digitalsky.sdk.data.FreeSdkData", "submit", new object[2] { type, data });
		return true;
	}
}
