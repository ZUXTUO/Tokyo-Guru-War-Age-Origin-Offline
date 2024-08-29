using System.Collections.Generic;
using System.IO;
using System.Text;
using Core.Resource;
using Core.Unity;
using Core.Util;
using SUpdate;

namespace UnityWrap
{
	public class HttpCheckFileHelper
	{
		private static string DataFilepath;

		private static Dictionary<MD5Long, uint> cacheData = new Dictionary<MD5Long, uint>();

		private static Dictionary<MD5Long, uint> cacheDataTmp = new Dictionary<MD5Long, uint>();

		public static void SetCacheFilepath(string filepath)
		{
			DataFilepath = filepath;
		}

		public static string GetCacheFileMD5()
		{
			Stream stream = FileHandleWrap.OpenRead(DataFilepath);
			string result = string.Empty;
			if (stream != null)
			{
				if (stream.Length > 0)
				{
					result = SUpdate.Utils.Md5(stream);
				}
				stream.Close();
			}
			return result;
		}

		public static string GetFilepathValue(string filepathKey)
		{
			LoadToCache();
			if (filepathKey != null)
			{
				MD5Long mD5Long = new MD5Long();
				Core.Util.Utils.MD5(Encoding.Default.GetBytes(filepathKey), out mD5Long.md51, out mD5Long.md52);
				if (cacheData.ContainsKey(mD5Long))
				{
					return cacheData[mD5Long].ToString();
				}
			}
			return string.Empty;
		}

		public static bool ValidAndSaveData(MemoryStream inStream)
		{
			bool result = false;
			int num = (int)inStream.Length;
			int num2 = 4;
			if (inStream.Length >= num2 * 3)
			{
				StreamHandle streamHandle = new StreamHandle(inStream);
				uint value = 0u;
				uint value2 = 0u;
				uint value3 = 0u;
				streamHandle.Read(ref value);
				streamHandle.Read(ref value2);
				streamHandle.Read(ref value3);
				if (num < value2 + num2 * 3)
				{
					Debug.LogError("[HttpCheckFileHelper] ValidAndSaveData  inDataSize and compressSize error");
				}
				else if (value == 0 && value2 == 0 && value3 == 0)
				{
					Debug.Log("inStream.Length:" + inStream.Length + ", size:0", Debug.LogLevel.Object);
					result = LoadToCache();
				}
				else
				{
					Debug.Log("inStream.Length:" + inStream.Length, Debug.LogLevel.Object);
					inStream.Position = 0L;
					FileHandleWrap fileHandleWrap = FileHandleWrap.CreateInstance(inStream);
					byte[] buffer = fileHandleWrap.ReadAll();
					FileHandleWrap.DestroyInstance(fileHandleWrap);
					MemoryStream memoryStream = new MemoryStream(buffer);
					memoryStream.Position = 0L;
					buffer = inStream.ToArray();
					MemoryStream memoryStream2 = new MemoryStream();
					memoryStream2.Write(buffer, 0, buffer.Length);
					memoryStream2.Position = 0L;
					if (FileUtil.Save(memoryStream2, DataFilepath))
					{
						ClearCache();
						result = LoadToCache();
					}
				}
			}
			else
			{
				Debug.LogError("[HttpCheckFileHelper] ValidAndSaveData  stream.Length error:" + inStream.Length);
			}
			return result;
		}

		public static bool LoadToCache()
		{
			if (cacheData.Count != 0)
			{
				return false;
			}
			Debug.Log("LoadToCache start.", Debug.LogLevel.Object);
			Stream sm = FileHandleWrap.OpenRead(DataFilepath);
			FileHandleWrap fileHandleWrap = FileHandleWrap.CreateInstance(sm);
			byte[] array = fileHandleWrap.ReadAll();
			FileHandleWrap.DestroyInstance(fileHandleWrap);
			int num = 12;
			if (array != null && array.Length > num)
			{
				cacheDataTmp.Clear();
				StreamHandle streamHandle = new StreamHandle(new MemoryStream(array));
				uint value = 0u;
				uint value2 = 0u;
				uint value3 = 0u;
				streamHandle.Read(ref value);
				streamHandle.Read(ref value2);
				streamHandle.Read(ref value3);
				uint num2 = Crc32.ComputeChecksum(array, num, array.Length - num);
				if (array.Length < value2 + num || value3 != num2)
				{
					Debug.LogError(string.Format("[http_update_path_map] unserial in_data_size and file crc error. in_data_size:{0} originalDataSize:{1} compressSize:{2} hope fileCrc:{3} real fileCrc:{4}", array.Length, value, value2, value3, num2));
					return false;
				}
				byte[] outData = null;
				uint num3 = value;
				Data.DecompressZlib(array, num, array.Length - num, out outData, num3);
				if (outData != null && num3 == value)
				{
					streamHandle = new StreamHandle(new MemoryStream(outData));
					int value4 = 0;
					streamHandle.Read(ref value4);
					while (--value4 >= 0 && streamHandle.length - streamHandle.position > 0)
					{
						MD5Long mD5Long = new MD5Long();
						value3 = 0u;
						if (streamHandle.Read(ref mD5Long.md51) != 0 && streamHandle.Read(ref mD5Long.md52) != 0 && streamHandle.Read(ref value3) != 0)
						{
							cacheDataTmp.Add(mD5Long, value3);
							continue;
						}
						Debug.LogError("[http_update_path_map] unserial pbuf->read error");
						cacheDataTmp.Clear();
						return false;
					}
					cacheData = new Dictionary<MD5Long, uint>(cacheDataTmp);
					cacheDataTmp.Clear();
					Debug.Log("LoadToCache complete. count:" + cacheData.Count, Debug.LogLevel.Object);
					return true;
				}
				Debug.LogError("[http_update_path_map] unserial decompress error");
			}
			else
			{
				Debug.LogError("[http_update_path_map] unserial in_data and in_data_size error");
			}
			return false;
		}

		public static void ClearCache()
		{
			cacheDataTmp.Clear();
			cacheData.Clear();
		}
	}
}
