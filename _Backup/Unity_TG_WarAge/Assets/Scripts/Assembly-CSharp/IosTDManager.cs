using System.Runtime.InteropServices;

public class IosTDManager
{
	[DllImport("__Internal")]
	public static extern void Submit(string type, string data);
}
