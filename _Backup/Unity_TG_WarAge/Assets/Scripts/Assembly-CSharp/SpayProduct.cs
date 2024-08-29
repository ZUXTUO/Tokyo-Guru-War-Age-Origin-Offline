using System.Runtime.InteropServices;

public struct SpayProduct
{
	[MarshalAs(UnmanagedType.LPStr)]
	public string identifier;

	[MarshalAs(UnmanagedType.LPStr)]
	public string description;

	[MarshalAs(UnmanagedType.LPStr)]
	public string title;

	[MarshalAs(UnmanagedType.LPStr)]
	public string currency_unit;

	public double price;
}
