using Core.Util;

namespace Core.Net
{
	public class PackageEx2 : PackageEx
	{
		private uint key_;

		public PackageEx2()
		{
			header = new PackageHeaderEx2();
		}

		public override bool encode()
		{
			if (base.encode() && SSecurity.xxteaEncode(key: new uint[4]
			{
				key_,
				(uint)base.Header.MessageId,
				base.Header.GetSourceLength(),
				base.Header.GetCrcCheck()
			}, inData: base.Data))
			{
				return true;
			}
			return false;
		}

		public override bool decode()
		{
			bool result = false;
			if (SSecurity.xxteaDecode(key: new uint[4]
			{
				key_,
				(uint)base.Header.MessageId,
				base.Header.GetSourceLength(),
				base.Header.GetCrcCheck()
			}, inData: base.Data) && base.decode())
			{
				result = true;
			}
			return result;
		}

		public override void SetKey(uint inKey)
		{
			key_ = inKey;
		}
	}
}
