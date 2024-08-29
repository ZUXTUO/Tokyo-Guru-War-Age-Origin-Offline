using System;
using System.Collections.Generic;
using System.IO;
using Core.Net;
using Core.Unity;
using SUpdate.GEnum;
using SUpdate.GStruct;
using Sio;

namespace SUpdate.GNet
{
	public abstract class NUpdate : NModule
	{
		public NUpdate()
		{
			startid = 970u;
			endid = 999u;
		}

		public abstract bool device_error(Client c, MemoryStream m_, string message, string url);

		public abstract bool op_version(Client c, MemoryStream m, uint ver, uint op_count);

		public abstract bool op_return(Client c, MemoryStream m, IList<op_data> oplst);

		public abstract bool file_start(Client c, MemoryStream m, string md5code, uint file_size, uint fid);

		public abstract bool file_data(Client c, MemoryStream m, uint fid, uint pos, uint size, byte[] data);

		public abstract bool file_complete(Client c, MemoryStream m, string md5code, uint file_id, int result);

		public static bool check_op(Client c, uint device_id, uint op_id, uint ver)
		{
			Package package = c.PackageFactory.CreatePackage();
			package.MessageID = 971;
			using (MemoryStream memoryStream = new MemoryStream())
			{
				SData sData = new SData(device_id);
				sData.Serializ(memoryStream);
				SData sData2 = new SData(op_id);
				sData2.Serializ(memoryStream);
				SData sData3 = new SData(ver);
				sData3.Serializ(memoryStream);
				byte[] array = new byte[memoryStream.Length];
				Array.Copy(memoryStream.GetBuffer(), array, memoryStream.Length);
				package.Data = array;
			}
			c.Send(package);
			return true;
		}

		public static bool request(Client c, string md5code, uint did, uint pos)
		{
			Package package = c.PackageFactory.CreatePackage();
			package.MessageID = 972;
			using (MemoryStream memoryStream = new MemoryStream())
			{
				SData sData = new SData(md5code);
				sData.Serializ(memoryStream);
				SData sData2 = new SData(did);
				sData2.Serializ(memoryStream);
				SData sData3 = new SData(pos);
				sData3.Serializ(memoryStream);
				byte[] array = new byte[memoryStream.Length];
				Array.Copy(memoryStream.GetBuffer(), array, memoryStream.Length);
				package.Data = array;
			}
			if (!c.Send(package))
			{
				Debug.LogWarning("send failed!!!");
				return false;
			}
			return true;
		}

		public override bool Dispatch(Client c, Package p)
		{
			if (c != null && p != null)
			{
				using (MemoryStream memoryStream = new MemoryStream(p.Data))
				{
					switch ((NUpdatEnum)p.MessageID)
					{
					case NUpdatEnum.nupdate_device_error:
					{
						SDataBuff sDataBuff15 = new SDataBuff();
						sDataBuff15.UnSerializ(memoryStream);
						SDataBuff sDataBuff16 = new SDataBuff();
						sDataBuff16.UnSerializ(memoryStream);
						string stringValue3 = sDataBuff15.stringValue;
						string stringValue4 = sDataBuff16.stringValue;
						return device_error(c, memoryStream, stringValue3, stringValue4);
					}
					case NUpdatEnum.nupdate_op_version:
					{
						SDataBuff sDataBuff13 = new SDataBuff();
						sDataBuff13.UnSerializ(memoryStream);
						SDataBuff sDataBuff14 = new SDataBuff();
						sDataBuff14.UnSerializ(memoryStream);
						uint uintValue7 = sDataBuff13.uintValue;
						uint uintValue8 = sDataBuff14.uintValue;
						return op_version(c, memoryStream, uintValue7, uintValue8);
					}
					case NUpdatEnum.nupdate_op_return:
					{
						SDataBuff sDataBuff11 = new SDataBuff();
						sDataBuff11.UnSerializ(memoryStream);
						IList<op_data> list = new List<op_data>();
						SListReader listReader = sDataBuff11.listReader;
						if (listReader != null)
						{
							SDataBuff sDataBuff12 = new SDataBuff();
							while (listReader.Next(sDataBuff12))
							{
								op_data op_data = new op_data();
								SMapReader mapReader = sDataBuff12.mapReader;
								if (mapReader != null)
								{
									op_data.Unserial(mapReader);
								}
								list.Add(op_data);
							}
						}
						return op_return(c, memoryStream, list);
					}
					case NUpdatEnum.nupdate_file_start:
					{
						SDataBuff sDataBuff8 = new SDataBuff();
						sDataBuff8.UnSerializ(memoryStream);
						SDataBuff sDataBuff9 = new SDataBuff();
						sDataBuff9.UnSerializ(memoryStream);
						SDataBuff sDataBuff10 = new SDataBuff();
						sDataBuff10.UnSerializ(memoryStream);
						string stringValue2 = sDataBuff8.stringValue;
						uint uintValue5 = sDataBuff9.uintValue;
						uint uintValue6 = sDataBuff10.uintValue;
						return file_start(c, memoryStream, stringValue2, uintValue5, uintValue6);
					}
					case NUpdatEnum.nupdate_file_data:
					{
						SDataBuff sDataBuff4 = new SDataBuff();
						sDataBuff4.UnSerializ(memoryStream);
						SDataBuff sDataBuff5 = new SDataBuff();
						sDataBuff5.UnSerializ(memoryStream);
						SDataBuff sDataBuff6 = new SDataBuff();
						sDataBuff6.UnSerializ(memoryStream);
						SDataBuff sDataBuff7 = new SDataBuff();
						sDataBuff7.UnSerializ(memoryStream);
						uint uintValue2 = sDataBuff4.uintValue;
						uint uintValue3 = sDataBuff5.uintValue;
						uint uintValue4 = sDataBuff6.uintValue;
						byte[] byteValue = sDataBuff7.ByteValue;
						return file_data(c, memoryStream, uintValue2, uintValue3, uintValue4, byteValue);
					}
					case NUpdatEnum.nupdate_file_complete:
					{
						SDataBuff sDataBuff = new SDataBuff();
						sDataBuff.UnSerializ(memoryStream);
						SDataBuff sDataBuff2 = new SDataBuff();
						sDataBuff2.UnSerializ(memoryStream);
						SDataBuff sDataBuff3 = new SDataBuff();
						sDataBuff3.UnSerializ(memoryStream);
						string stringValue = sDataBuff.stringValue;
						uint uintValue = sDataBuff2.uintValue;
						int intValue = sDataBuff3.intValue;
						return file_complete(c, memoryStream, stringValue, uintValue, intValue);
					}
					}
				}
				return true;
			}
			return false;
		}
	}
}
