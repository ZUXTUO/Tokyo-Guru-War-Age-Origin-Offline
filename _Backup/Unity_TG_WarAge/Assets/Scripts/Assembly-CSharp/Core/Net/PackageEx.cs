using Core.Unity;
using Core.Util;

namespace Core.Net
{
	public class PackageEx : Package
	{
		private bool isEncode;

		private bool isDecode;

		public PackageEx()
		{
			header = new PackageHeaderEx();
		}

		public override bool encode()
		{
			while (!isEncode)
			{
				isEncode = true;
				if (base.Data == null)
				{
					break;
				}
				uint num = (uint)base.Data.Length;
				byte[] array = null;
				uint num2 = Crc32.ComputeChecksum(base.Data);
				base.Header.SetCrcCheck(num2);
				header.SetCrcCheck2(num2);
				string empty = string.Empty;
			}
			return true;
		}

		public override bool decode()
		{
			if (!isDecode)
			{
				isDecode = true;
				uint num = Crc32.ComputeChecksum(base.Data);
				if (base.Header.GetCrcCheck() == num)
				{
					if (base.Data != null && base.Data.Length > 0 && base.Header.GetCompressType() == 1)
					{
						byte[] outData = null;
						if (!Core.Util.Data.DecompressZlib(base.Data, out outData, base.Header.GetSourceLength()))
						{
							Debug.LogError("UncompressZlib failed");
							goto IL_009a;
						}
						base.Data = outData;
					}
					return true;
				}
			}
			goto IL_009a;
			IL_009a:
			return false;
		}
	}
}
