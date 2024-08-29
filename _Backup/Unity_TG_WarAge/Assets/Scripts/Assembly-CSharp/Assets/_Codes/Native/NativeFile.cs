using System;
using System.Runtime.InteropServices;

namespace Assets._Codes.Native
{
	internal class NativeFile
	{
		public enum OPEN_FILE_OPTION
		{
			raw = 0,
			try_decode = 1
		}

		private const string LIBGAME = "game";

		[DllImport("game")]
		public static extern int load_file_in_apk_2_mem(string fileName, ref IntPtr memBuff, ref int buffLen, ref int dataOffset, int options);

		[DllImport("game")]
		public static extern int load_file_2_mem(string fileName, ref IntPtr memBuff, ref int buffLen, ref int dataOffset, int options);

		[DllImport("game")]
		public static extern int free_last_file_mem();
	}
}
