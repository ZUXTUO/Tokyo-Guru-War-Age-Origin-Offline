namespace Core.Net
{
	public class PackageFactoryEx2 : PackageFactory
	{
		public override int HeaderSize()
		{
			return PackageHeaderEx.ByteSize;
		}

		public override PackageHeader CreatePackageHeader(byte[] data, int offset, int length)
		{
			if (length >= HeaderSize())
			{
				PackageHeader packageHeader = new PackageHeaderEx2();
				if (packageHeader.Unserial(data, offset))
				{
					return packageHeader;
				}
			}
			return null;
		}

		public override Package CreatePackage()
		{
			return new PackageEx2();
		}
	}
}
