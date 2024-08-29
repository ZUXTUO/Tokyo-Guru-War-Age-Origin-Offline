using System;
using System.Collections.Generic;
using System.IO;
using System.Text;
using Core.Resource;

namespace SHttp
{
	public class HttpStreamHandle : StreamHandle
	{
		public HttpStreamHandle(Stream stream)
			: base(stream)
		{
		}

		public override int Read(ref string value)
		{
			byte[] array = new byte[2];
			int num = Read(array);
			int num2 = BitConverter.ToInt16(array, 0);
			if (num <= 0)
			{
				return 0;
			}
			byte[] array2 = new byte[num2];
			num += Read(array2);
			value = Encoding.Default.GetString(array2);
			return num;
		}

		public VersionData ReadVersionData()
		{
			VersionData versionData = new VersionData();
			int num = 0;
			num = Read(ref versionData.crc);
			if (num > 0)
			{
				num = Read(ref versionData.devid);
				if (num > 0)
				{
					num = Read(ref versionData.path);
					if (num > 0)
					{
						num = Read(ref versionData.fileSize);
						if (num > 0)
						{
							num = Read(ref versionData.opType);
							if (num > 0)
							{
								num = Read(ref versionData.opId);
								if (num > 0)
								{
									return versionData;
								}
							}
						}
					}
				}
			}
			return null;
		}

		public List<VersionData> ReadVersionList()
		{
			List<VersionData> list = new List<VersionData>();
			int value = 0;
			Read(ref value);
			while (value > 0 && m_stream.Position < m_stream.Length)
			{
				VersionData versionData = ReadVersionData();
				if (versionData != null)
				{
					list.Add(versionData);
				}
				value--;
			}
			return list;
		}
	}
}
