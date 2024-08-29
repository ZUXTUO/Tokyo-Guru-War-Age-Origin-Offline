using System.Runtime.InteropServices;

public struct SpayTransaction
{
	[MarshalAs(UnmanagedType.LPStr)]
	public string key;

	[MarshalAs(UnmanagedType.LPStr)]
	public string identifier;

	[MarshalAs(UnmanagedType.LPStr)]
	public string receipt;

	[MarshalAs(UnmanagedType.LPStr)]
	public string error_info;

	public int error_code;

	public int state;

	public int date;

	[MarshalAs(UnmanagedType.LPStr)]
	public string product_identifier;

	public int quantity;
}
