using System.Runtime.InteropServices;

public struct SpayStruct
{
	public double price;

	[MarshalAs(UnmanagedType.LPStr)]
	public string title;
}
