namespace Core.Util
{
	public class SSecurity
	{
		private static void btea(uint[] v, int n, uint[] key)
		{
			if (n > 1)
			{
				uint num = (uint)(6 + 52 / n);
				uint num2 = 0u;
				uint num3 = v[n - 1];
				do
				{
					num2 += 2654435769u;
					uint num4 = (num2 >> 2) & 3u;
					uint num5;
					uint num6;
					for (num5 = 0u; num5 < n - 1; num5++)
					{
						num6 = v[num5 + 1];
						num3 = (v[num5] += (((num3 >> 5) ^ (num6 << 2)) + ((num6 >> 3) ^ (num3 << 4))) ^ ((num2 ^ num6) + (key[(num5 & 3) ^ num4] ^ num3)));
					}
					num6 = v[0];
					num3 = (v[n - 1] += (((num3 >> 5) ^ (num6 << 2)) + ((num6 >> 3) ^ (num3 << 4))) ^ ((num2 ^ num6) + (key[(num5 & 3) ^ num4] ^ num3)));
				}
				while (--num != 0);
			}
			else
			{
				if (n >= -1)
				{
					return;
				}
				n = -n;
				uint num = (uint)(6 + 52 / n);
				uint num2 = num * 2654435769u;
				uint num6 = v[0];
				do
				{
					uint num4 = (num2 >> 2) & 3u;
					uint num5;
					uint num3;
					for (num5 = (uint)(n - 1); num5 != 0; num5--)
					{
						num3 = v[num5 - 1];
						num6 = (v[num5] -= (((num3 >> 5) ^ (num6 << 2)) + ((num6 >> 3) ^ (num3 << 4))) ^ ((num2 ^ num6) + (key[(num5 & 3) ^ num4] ^ num3)));
					}
					num3 = v[n - 1];
					num6 = (v[0] -= (((num3 >> 5) ^ (num6 << 2)) + ((num6 >> 3) ^ (num3 << 4))) ^ ((num2 ^ num6) + (key[(num5 & 3) ^ num4] ^ num3)));
					num2 -= 2654435769u;
				}
				while (--num != 0);
			}
		}

		private static uint[] ToUIntArray(byte[] inData)
		{
			uint[] array = new uint[inData.Length >> 2];
			int i = 0;
			for (int num = array.Length << 2; i < num; i++)
			{
				array[i >> 2] |= (uint)(inData[i] << ((i & 3) << 3));
			}
			return array;
		}

		public static bool xxteaEncode(byte[] inData, uint[] key)
		{
			if (inData == null || inData.Length >> 2 <= 1)
			{
				return true;
			}
			uint[] array = ToUIntArray(inData);
			btea(array, array.Length, key);
			int num = 0;
			int i = 0;
			for (int num2 = array.Length; i < num2; i++)
			{
				num = i << 2;
				inData[num] = (byte)((array[i] >> 0) & 0xFFu);
				inData[num + 1] = (byte)((array[i] >> 8) & 0xFFu);
				inData[num + 2] = (byte)((array[i] >> 16) & 0xFFu);
				inData[num + 3] = (byte)((array[i] >> 24) & 0xFFu);
			}
			return true;
		}

		public static bool xxteaDecode(byte[] inData, uint[] key)
		{
			if (inData == null || inData.Length >> 2 <= 1)
			{
				return true;
			}
			uint[] array = ToUIntArray(inData);
			btea(array, -array.Length, key);
			int num = 0;
			int i = 0;
			for (int num2 = array.Length; i < num2; i++)
			{
				num = i << 2;
				inData[num] = (byte)((array[i] >> 0) & 0xFFu);
				inData[num + 1] = (byte)((array[i] >> 8) & 0xFFu);
				inData[num + 2] = (byte)((array[i] >> 16) & 0xFFu);
				inData[num + 3] = (byte)((array[i] >> 24) & 0xFFu);
			}
			return true;
		}
	}
}
