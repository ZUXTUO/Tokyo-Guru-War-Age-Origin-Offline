using System.IO;
using System.Security.Cryptography;
using System.Text;

namespace SUpdate
{
	public class Utils
	{
		public static string MakeMD5String(byte[] md5)
		{
			StringBuilder stringBuilder = new StringBuilder();
			for (int i = 0; i < md5.Length; i++)
			{
				stringBuilder.Append(md5[i].ToString("x2"));
			}
			return stringBuilder.ToString();
		}

		public static string Md5(string source)
		{
			MD5 mD = new MD5CryptoServiceProvider();
			byte[] md = mD.ComputeHash(Encoding.Default.GetBytes(source));
			return MakeMD5String(md);
		}

		public static string Md5(byte[] source, int offset, int count)
		{
			MD5 mD = new MD5CryptoServiceProvider();
			byte[] md = mD.ComputeHash(source, offset, count);
			return MakeMD5String(md);
		}

		public static string Md5(Stream sm)
		{
			MD5 mD = new MD5CryptoServiceProvider();
			byte[] md = mD.ComputeHash(sm);
			return MakeMD5String(md);
		}
	}
}
