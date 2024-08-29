using System;
using System.Collections.Generic;
using System.IO;
using System.Text;
using Core.Resource;
using Core.Unity;
using Core.Util;
using LuaInterface;
using SHttp;
using SUpdate.Logic;
using Script;

namespace UnityWrap
{
	public class HttpUpdateClientWrap
	{
		public static string OnCheckOpSuccessStr = string.Empty;

		public static string OnCheckOpErrorStr = string.Empty;

		public static string OnCheckFileSuccessStr = string.Empty;

		public static string OnCheckFileErrorStr = string.Empty;

		public static void CheckFile(string uri, string savePath)
		{
			HttpCheckFileHelper.SetCacheFilepath(savePath);
			string cacheFileMD = HttpCheckFileHelper.GetCacheFileMD5();
			string url = uri;
			if (cacheFileMD.Length != 0)
			{
				url = uri + "&md5=" + cacheFileMD;
			}
			DownloadInfo downloadInfo = new DownloadInfo();
			downloadInfo.uri = uri;
			downloadInfo.filePath = savePath;
			downloadInfo.fileSavePath = savePath;
			downloadInfo.onDownSuccessStr = string.Empty;
			downloadInfo.onDownErrorStr = string.Empty;
			downloadInfo.url = url;
			HttpRequestManager.GetInstance().Get(downloadInfo.url, OnCheckFileSuccess, OnCheckFileError, null, downloadInfo);
		}

		public static string GetCheckFileValue(string filepathKey)
		{
			return HttpCheckFileHelper.GetFilepathValue(filepathKey);
		}

		public static void OnCheckFileSuccess(RequestState req)
		{
			DownloadInfo downloadInfo = (DownloadInfo)req.userData;
			MemoryStream inStream = new MemoryStream(req.bytes.ToArray());
			if (HttpCheckFileHelper.ValidAndSaveData(inStream))
			{
				ScriptCall scriptCall = ScriptCall.Create(OnCheckFileSuccessStr);
				if (scriptCall != null && scriptCall.Start())
				{
					LuaDLL.lua_newtable(scriptCall.L);
					scriptCall.lua_settable("uri", downloadInfo.uri);
					scriptCall.lua_settable("url", downloadInfo.url);
					scriptCall.lua_settable("filePath", downloadInfo.filePath);
					scriptCall.lua_settable("savePath", downloadInfo.fileSavePath);
					scriptCall.lua_settable("result", 0.0);
					scriptCall.Finish(1);
				}
			}
			else
			{
				ScriptCall scriptCall2 = ScriptCall.Create(OnCheckFileErrorStr);
				if (scriptCall2 != null && scriptCall2.Start())
				{
					LuaDLL.lua_newtable(scriptCall2.L);
					scriptCall2.lua_settable("uri", downloadInfo.uri);
					scriptCall2.lua_settable("url", downloadInfo.url);
					scriptCall2.lua_settable("filePath", downloadInfo.filePath);
					scriptCall2.lua_settable("savePath", downloadInfo.fileSavePath);
					scriptCall2.lua_settable("result", -1.0);
					scriptCall2.Finish(1);
				}
			}
		}

		public static void OnCheckFileError(RequestState req)
		{
			DownloadInfo downloadInfo = (DownloadInfo)req.userData;
			ScriptCall scriptCall = ScriptCall.Create(OnCheckFileErrorStr);
			if (scriptCall != null && scriptCall.Start())
			{
				LuaDLL.lua_newtable(scriptCall.L);
				scriptCall.lua_settable("path", downloadInfo.uri);
				scriptCall.lua_settable("err_code", req.status);
				scriptCall.lua_settable("err_str", req.errStr);
				scriptCall.Finish(1);
			}
		}

		public static void CheckOp(string uri)
		{
			DownloadInfo downloadInfo = new DownloadInfo();
			downloadInfo.uri = uri;
			downloadInfo.filePath = string.Empty;
			downloadInfo.onDownSuccessStr = string.Empty;
			downloadInfo.onDownErrorStr = string.Empty;
			downloadInfo.url = uri;
			HttpRequestManager.GetInstance().Get(uri, OnCheckOpSuccess, OnCheckOpError, null, downloadInfo);
		}

		public static void OnCheckOpSuccess(RequestState req)
		{
			MemoryStream reveiveStream = new MemoryStream(req.bytes.ToArray());
			List<VersionData> list = new List<VersionData>();
			Stream stream = UnCompressStream(reveiveStream);
			if (stream != null)
			{
				HttpStreamHandle httpStreamHandle = new HttpStreamHandle(stream);
				list = httpStreamHandle.ReadVersionList();
			}
			ScriptCall scriptCall = ScriptCall.Create(OnCheckOpSuccessStr);
			if (scriptCall != null && scriptCall.Start())
			{
				int num = 0;
				LuaDLL.lua_newtable(scriptCall.L);
				int tableIndex = LuaDLL.lua_gettop(scriptCall.L);
				for (int i = 0; i < list.Count; i++)
				{
					VersionData versionData = list[i];
					LuaDLL.lua_newtable(scriptCall.L);
					scriptCall.lua_settable("oid", versionData.opId);
					scriptCall.lua_settable("path", versionData.path);
					scriptCall.lua_settable("fsize", versionData.fileSize);
					scriptCall.lua_settable("type", versionData.opType);
					LuaDLL.lua_rawseti(scriptCall.L, tableIndex, i + 1);
					num += versionData.fileSize;
				}
				scriptCall.lua_settable("all_fsize", num);
				scriptCall.Finish(1);
			}
		}

		public static void OnCheckOpError(RequestState req)
		{
			DownloadInfo downloadInfo = (DownloadInfo)req.userData;
			ScriptCall scriptCall = ScriptCall.Create(OnCheckOpErrorStr);
			if (scriptCall != null && scriptCall.Start())
			{
				LuaDLL.lua_newtable(scriptCall.L);
				scriptCall.lua_settable("path", downloadInfo.uri);
				scriptCall.lua_settable("err_code", req.status);
				scriptCall.lua_settable("err_str", req.errStr);
				scriptCall.Finish(1);
			}
		}

		public static Stream UnCompressStream(Stream reveiveStream)
		{
			StreamHandle streamHandle = new StreamHandle(reveiveStream);
			int value = 0;
			streamHandle.Read(ref value);
			if (value <= 0)
			{
				return null;
			}
			return streamHandle.UnCompressStream();
		}

		public static void AddDown(string uri, int devId, string filePath, string onSuccessStr, string onErrorStr)
		{
			DownloadInfo downloadInfo = new DownloadInfo();
			downloadInfo.uri = uri;
			downloadInfo.filePath = filePath;
			downloadInfo.onDownSuccessStr = onSuccessStr;
			downloadInfo.onDownErrorStr = onErrorStr;
			downloadInfo.url = uri + devId + "/" + filePath;
			HttpRequestManager.GetInstance().Get(downloadInfo.url, OnDownloadSuccess, OnDownloadError, null, downloadInfo);
		}

		public static void OnDownloadSuccess(RequestState req)
		{
			DownloadInfo downloadInfo = (DownloadInfo)req.userData;
			bool flag = false;
			long num = 0L;
			bool flag2 = true;
			string text = string.Empty;
			MemoryStream memoryStream = new MemoryStream();
			memoryStream.Write(req.bytes.ToArray(), 0, req.bytes.Count);
			memoryStream.Position = 0L;
			req.bytes.Clear();
			try
			{
				if (!PreProcess(memoryStream))
				{
					flag2 = false;
					text = "[HttpUpdateClientWrap OnDownloadSuccess] PreProcess header failed";
				}
			}
			catch (Exception ex)
			{
				flag2 = false;
				text = ex.ToString();
				Debug.LogError("[HttpUpdateClientWrap OnDownloadSuccess] Exception: " + text);
			}
			if (flag2)
			{
				num = memoryStream.Length;
				flag = FileUtil.Save(memoryStream, downloadInfo.filePath);
				memoryStream.Close();
				ScriptCall scriptCall = ScriptCall.Create(downloadInfo.onDownSuccessStr);
				if (scriptCall != null && scriptCall.Start())
				{
					LuaDLL.lua_newtable(scriptCall.L);
					scriptCall.lua_settable("path", downloadInfo.filePath);
					scriptCall.lua_settable("fsize", num);
					scriptCall.lua_settable("result", flag);
					scriptCall.Finish(1);
				}
			}
			else
			{
				ScriptCall scriptCall2 = ScriptCall.Create(downloadInfo.onDownErrorStr);
				if (scriptCall2 != null && scriptCall2.Start())
				{
					LuaDLL.lua_newtable(scriptCall2.L);
					scriptCall2.lua_settable("path", downloadInfo.filePath);
					scriptCall2.lua_settable("err_code", req.status);
					scriptCall2.lua_settable("err_str", text);
					scriptCall2.Finish(1);
				}
			}
		}

		public static void OnDownloadError(RequestState req)
		{
			DownloadInfo downloadInfo = (DownloadInfo)req.userData;
			ScriptCall scriptCall = ScriptCall.Create(downloadInfo.onDownErrorStr);
			if (scriptCall != null && scriptCall.Start())
			{
				LuaDLL.lua_newtable(scriptCall.L);
				scriptCall.lua_settable("path", downloadInfo.filePath);
				scriptCall.lua_settable("err_code", req.status);
				scriptCall.lua_settable("err_str", req.errStr);
				scriptCall.Finish(1);
			}
		}

		private static bool PreProcess(MemoryStream ms)
		{
			if (ms != null)
			{
				ms.Seek(0L, SeekOrigin.Begin);
				FileHeader fileHeader = new FileHeader();
				if (fileHeader.Unserial(ms) && ms.Length - ms.Position == fileHeader.File_size)
				{
					if (fileHeader.Compress_type == 2)
					{
						return true;
					}
					if (fileHeader.Compress_type != 1 && fileHeader.Compress_type != 4)
					{
						return true;
					}
				}
			}
			return false;
		}

		private static MemoryStream PreProcessEx(MemoryStream ms, ref string errMsg)
		{
			if (ms != null)
			{
				MemoryStream memoryStream = null;
				ms.Seek(0L, SeekOrigin.Begin);
				FileHeader fileHeader = new FileHeader();
				if (fileHeader.Unserial(ms) && ms.Length - ms.Position == fileHeader.File_size)
				{
					uint num = Crc32.ComputeChecksum(ms.GetBuffer(), (int)ms.Position, (int)(ms.Length - ms.Position));
					if (num != fileHeader.File_crc)
					{
						errMsg = "crc check failed.";
						return null;
					}
					if (fileHeader.Compress_type == 2)
					{
						memoryStream = new MemoryStream();
						byte[] outData = new byte[fileHeader.Original_file_size];
						uint outDataRefLen = (uint)outData.Length;
						if (Data.DecompressZlib(ms.GetBuffer(), (int)ms.Position, (int)fileHeader.File_size, out outData, outDataRefLen))
						{
							memoryStream.Write(outData, 0, outData.Length);
						}
						else
						{
							errMsg = " DecompressZlib failed.";
							memoryStream = null;
						}
					}
					else if (fileHeader.Compress_type == 1)
					{
						errMsg = " ENCRYPT_COMPRESS_7Z is not supported yet.";
					}
					else if (fileHeader.Compress_type == 4)
					{
						errMsg = " ENCRYPT_COMPRESS_7Z is not supported yet.";
					}
					else
					{
						memoryStream = new MemoryStream();
						memoryStream.Write(ms.GetBuffer(), (int)ms.Position, (int)(ms.Length - ms.Position));
					}
					if (memoryStream != null)
					{
						memoryStream.Position = 0L;
						return memoryStream;
					}
				}
			}
			return null;
		}

		public static void Down(string uri, string filePath, string filesavepath, string onSuccessStr, string onErrorStr, string onDowning)
		{
			DownloadInfo downloadInfo = new DownloadInfo();
			downloadInfo.uri = uri;
			downloadInfo.filePath = filePath;
			downloadInfo.fileSavePath = filesavepath;
			downloadInfo.onDownSuccessStr = onSuccessStr;
			downloadInfo.onDownErrorStr = onErrorStr;
			downloadInfo.onDowningStr = onDowning;
			downloadInfo.url = uri;
			HttpRequestManager.GetInstance().Get(downloadInfo.url, OnDownSuccess, OnDownError, OnDowning, downloadInfo);
		}

		public static void OnDownSuccess(RequestState req)
		{
			DownloadInfo downloadInfo = (DownloadInfo)req.userData;
			bool flag = false;
			long num = 0L;
			MemoryStream memoryStream = new MemoryStream();
			memoryStream.Write(req.bytes.ToArray(), 0, req.bytes.Count);
			memoryStream.Position = 0L;
			req.bytes.Clear();
			bool flag2 = true;
			string empty = string.Empty;
			MemoryStream memoryStream2 = null;
			string value = "0000000000000000";
			try
			{
				string errMsg = string.Empty;
				memoryStream2 = PreProcessEx(memoryStream, ref errMsg);
				if (memoryStream2 == null)
				{
					flag2 = false;
					empty = "[HttpUpdateClientWrap OnDownSuccess] PreProcess header failed: " + errMsg;
					req.errStr += empty;
				}
			}
			catch (Exception ex)
			{
				flag2 = false;
				empty = ex.ToString();
				req.errStr += empty;
				Debug.LogError("[HttpUpdateClientWrap OnDownSuccess] Exception: " + empty);
			}
			if (flag2)
			{
				memoryStream2.Position = 0L;
				num = memoryStream2.Length;
				flag = FileUtil.Save(memoryStream2, downloadInfo.fileSavePath);
				memoryStream2.Close();
				ScriptCall scriptCall = ScriptCall.Create(downloadInfo.onDownSuccessStr);
				if (scriptCall != null && scriptCall.Start())
				{
					LuaDLL.lua_newtable(scriptCall.L);
					scriptCall.lua_settable("path", downloadInfo.filePath);
					scriptCall.lua_settable("savepath", downloadInfo.fileSavePath);
					scriptCall.lua_settable("fsize", num);
					scriptCall.lua_settable("result", flag);
					scriptCall.lua_settable("md5", value);
					scriptCall.Finish(1);
				}
			}
			else
			{
				OnDownError(req);
			}
		}

		public static void OnDowning(RequestState req, int down, long current, long total)
		{
			DownloadInfo downloadInfo = (DownloadInfo)req.userData;
			ScriptCall scriptCall = ScriptCall.Create(downloadInfo.onDowningStr);
			if (scriptCall != null && scriptCall.Start())
			{
				LuaDLL.lua_newtable(scriptCall.L);
				scriptCall.lua_settable("path", downloadInfo.filePath);
				scriptCall.lua_settable("current", current);
				scriptCall.lua_settable("total", total);
				scriptCall.lua_settable("down", down);
				scriptCall.Finish(1);
			}
		}

		public static void OnDownError(RequestState req)
		{
			DownloadInfo downloadInfo = (DownloadInfo)req.userData;
			ScriptCall scriptCall = ScriptCall.Create(downloadInfo.onDownErrorStr);
			if (scriptCall != null && scriptCall.Start())
			{
				LuaDLL.lua_newtable(scriptCall.L);
				scriptCall.lua_settable("path", downloadInfo.filePath);
				scriptCall.lua_settable("err_code", req.status);
				scriptCall.lua_settable("err_str", req.errStr);
				scriptCall.Finish(1);
			}
		}

		public static void Request(string uri, string filePath, string onSuccessStr, string onErrorStr, string postData = "")
		{
			DownloadInfo downloadInfo = new DownloadInfo();
			downloadInfo.uri = uri;
			downloadInfo.filePath = filePath;
			downloadInfo.onDownSuccessStr = onSuccessStr;
			downloadInfo.onDownErrorStr = onErrorStr;
			downloadInfo.url = uri + filePath;
			if (postData != string.Empty)
			{
				HttpRequestManager.GetInstance().Post(downloadInfo.url, postData, OnRequestSuccess, OnRequestError, null, downloadInfo);
			}
			else
			{
				HttpRequestManager.GetInstance().Get(downloadInfo.url, OnRequestSuccess, OnRequestError, null, downloadInfo);
			}
		}

		public static void OnRequestSuccess(RequestState req)
		{
			DownloadInfo downloadInfo = (DownloadInfo)req.userData;
			MemoryStream memoryStream = new MemoryStream(req.bytes.ToArray());
			long length = memoryStream.Length;
			StreamReader streamReader = new StreamReader(memoryStream, Encoding.UTF8);
			string value = streamReader.ReadToEnd();
			ScriptCall scriptCall = ScriptCall.Create(downloadInfo.onDownSuccessStr);
			if (scriptCall != null && scriptCall.Start())
			{
				LuaDLL.lua_newtable(scriptCall.L);
				scriptCall.lua_settable("path", downloadInfo.filePath);
				scriptCall.lua_settable("fsize", length);
				scriptCall.lua_settable("result", value);
				scriptCall.Finish(1);
			}
		}

		public static void OnRequestError(RequestState req)
		{
			DownloadInfo downloadInfo = (DownloadInfo)req.userData;
			ScriptCall scriptCall = ScriptCall.Create(downloadInfo.onDownErrorStr);
			if (scriptCall != null && scriptCall.Start())
			{
				LuaDLL.lua_newtable(scriptCall.L);
				scriptCall.lua_settable("path", downloadInfo.filePath);
				scriptCall.lua_settable("err_code", req.status);
				scriptCall.lua_settable("err_str", req.errStr);
				scriptCall.Finish(1);
			}
		}
	}
}
