using System;

namespace Core.Net
{
	public class PackageFactory
	{
		public virtual int HeaderSize()
		{
			return PackageHeader.ByteSize;
		}

		public virtual PackageHeader CreatePackageHeader(byte[] data, int offset, int length)
		{
			if (length >= HeaderSize())
			{
				PackageHeader packageHeader = new PackageHeader();
				if (packageHeader.Unserial(data, offset))
				{
					return packageHeader;
				}
			}
			return null;
		}

		public virtual Package CreatePackage()
		{
			return new Package();
		}

		public Package CreatePackage(byte[] data, int offset, int length)
		{
			if (data.Length >= offset + length)
			{
				PackageHeader packageHeader = CreatePackageHeader(data, offset, length);
				if (packageHeader != null && length - HeaderSize() >= packageHeader.Length)
				{
					int length2 = packageHeader.Length;
					Package package = CreatePackage();
					package.Header = packageHeader;
					package.Data = new byte[length2];
					Array.Copy(data, offset + HeaderSize(), package.Data, 0, packageHeader.Length);
					return package;
				}
			}
			return null;
		}
	}
}
