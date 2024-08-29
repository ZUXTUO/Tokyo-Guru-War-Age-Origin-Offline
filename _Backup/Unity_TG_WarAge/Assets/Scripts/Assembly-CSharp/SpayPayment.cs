using System.Runtime.InteropServices;

public struct SpayPayment
{
	[MarshalAs(UnmanagedType.LPStr)]
	public string product_identifier;

	public int quantity;
}
