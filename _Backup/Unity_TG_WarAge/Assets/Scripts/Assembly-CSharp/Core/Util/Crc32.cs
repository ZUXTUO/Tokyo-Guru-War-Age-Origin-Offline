using System;

namespace Core.Util
{
	public class Crc32
	{
		private static uint[] table;

		public static uint ComputeChecksum(byte[] bytes)
		{
			return ComputeChecksum(bytes, 0, bytes.Length);
		}

		public static uint ComputeChecksum(byte[] bytes, int startIdx, int length)
		{
			if (bytes == null)
			{
				return 0u;
			}
			length = startIdx + length;
			if (bytes.Length < length)
			{
				return 0u;
			}
			InitTable();
			uint num = uint.MaxValue;
			for (int i = startIdx; i < length; i++)
			{
				byte b = (byte)((num & 0xFFu) ^ bytes[i]);
				num = (num >> 8) ^ table[b];
			}
			return ~num;
		}

		public static byte[] ComputeChecksumBytes(byte[] bytes)
		{
			return BitConverter.GetBytes(ComputeChecksum(bytes));
		}

		public static void InitTable()
		{
			if (table != null)
			{
				return;
			}
			uint num = 3988292384u;
			table = new uint[256];
			uint num2 = 0u;
			for (uint num3 = 0u; num3 < table.Length; num3++)
			{
				num2 = num3;
				for (int num4 = 8; num4 > 0; num4--)
				{
					num2 = (((num2 & 1) != 1) ? (num2 >> 1) : ((num2 >> 1) ^ num));
				}
				table[num3] = num2;
			}
		}
	}
}
