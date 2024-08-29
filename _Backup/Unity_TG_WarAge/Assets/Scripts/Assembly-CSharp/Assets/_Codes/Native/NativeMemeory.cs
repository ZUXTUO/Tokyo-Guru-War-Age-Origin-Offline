using System;
using System.Runtime.InteropServices;

namespace Assets._Codes.Native
{
	internal class NativeMemeory
	{
		private const string LIBGAME = "game";

		[DllImport("game")]
		public static extern int free_memory(IntPtr ptr);
	}
}
