using System.IO;
using zlib;

namespace Core.Util
{
	public class Data
	{
		public static bool CompressZlib(byte[] inData, out byte[] outData)
		{
			MemoryStream memoryStream = new MemoryStream();
			ZOutputStream zOutputStream = new ZOutputStream(memoryStream, -1);
			zOutputStream.Write(inData, 0, inData.Length);
			zOutputStream.Flush();
			zOutputStream.finish();
			outData = memoryStream.ToArray();
			return true;
		}

		public static bool DecompressZlib(byte[] inData, out byte[] outData, uint outDataRefLen)
		{
			return DecompressZlib(inData, 0, inData.Length, out outData, outDataRefLen);
		}

		public static bool DecompressZlib(byte[] inData, int startIndex, int length, out byte[] outData, uint outDataRefLen)
		{
			if (inData.Length < startIndex + length)
			{
				outData = null;
				return false;
			}
			MemoryStream memoryStream = new MemoryStream();
			ZOutputStream zOutputStream = new ZOutputStream(memoryStream);
			zOutputStream.Write(inData, startIndex, length);
			zOutputStream.Flush();
			zOutputStream.finish();
			outData = memoryStream.ToArray();
			if (memoryStream.Length != outDataRefLen)
			{
				outData = null;
				return false;
			}
			return true;
		}
	}
}
