using System;
using System.IO;
using System.Net;
using System.Net.Security;
using System.Security.Cryptography.X509Certificates;
using System.Text;
using System.Threading;
using UnityEngine;

public class HttpDownload
{
	private enum EDownloadState
	{
		EDS_UNKNOW_ERROR = -1
	}

	private const int BUFFER_SIZE = 10240;

	private const int TIMEOUT = 10000;

	private const int CONNTECTTIMEOUT = 3000;

	private const int WRITE_FILE_BUFFER_SIZE = 1048576;

	private string m_savePath;

	private string m_downloadInfoSavePath;

	private string m_url;

	private string m_saveDirectory;

	private HttpWebRequest m_request;

	private HttpWebResponse m_reponse;

	private Stream m_responseStream;

	private byte[] m_buffer = new byte[10240];

	private MemoryStream m_writeFileBuffer;

	private long m_diskFreeSpace;

	private long m_needRequestLen;

	private long m_totalResourceLen;

	private long m_hasDownloadResurceLen;

	private Stream m_fileStream;

	private bool m_autoCloseFileStream = true;

	private long m_beginPos;

	private ProgressHandler m_progressCallback;

	private DownloadResultHandler m_downloadResultCallback;

	private GameObject m_messageDealObj;

	private Mutex m_mutex = new Mutex();

	private long m_showHasDownloadSize = -1L;

	private long m_showTotalDownloadSize;

	private long m_showDownRate;

	private EDOWNLOADRESULT m_downlaodResult = EDOWNLOADRESULT.EDR_Down;

	private float m_updateDeltaTime;

	private const string TOTALSIZEKEYSTR = "TS";

	public HttpDownload(string savePath, string url)
	{
		m_savePath = savePath;
		m_downloadInfoSavePath = m_savePath + ".download";
		m_url = url;
	}

	public HttpDownload(Stream stream, string url)
	{
		m_fileStream = stream;
		m_url = url;
	}

	~HttpDownload()
	{
	}

	public void SetCallback(ProgressHandler progressCallback, DownloadResultHandler result)
	{
		m_progressCallback = progressCallback;
		m_downloadResultCallback = result;
	}

	private bool ReadDownLoadInfo(ref HttpDownloadInfo hdi)
	{
		bool result = false;
		if (File.Exists(m_downloadInfoSavePath))
		{
			try
			{
				string[] array = File.ReadAllLines(m_downloadInfoSavePath);
				string[] array2 = array;
				foreach (string text in array2)
				{
					string[] array3 = text.Split('=');
					if (array3.Length > 1 && array3[0] == "TS")
					{
						hdi.m_totalSize = long.Parse(array3[1]);
						result = true;
					}
				}
			}
			catch (Exception ex)
			{
				Debug.LogError("read download info:" + ex.ToString());
			}
		}
		return result;
	}

	private bool WriteDownloadInfo(HttpDownloadInfo hdi)
	{
		bool result = false;
		try
		{
			FileStream fileStream = File.OpenWrite(m_downloadInfoSavePath);
			fileStream.SetLength(0L);
			string s = "TS=" + hdi.m_totalSize;
			byte[] bytes = Encoding.UTF8.GetBytes(s);
			fileStream.Write(bytes, 0, bytes.Length);
			fileStream.Close();
			result = true;
		}
		catch (Exception ex)
		{
			Debug.LogError("WriteDownloadInfo " + ex.ToString());
		}
		return result;
	}

	public bool CheckValidationResult(object sender, X509Certificate certificate, X509Chain chain, SslPolicyErrors errors)
	{
		return true;
	}

	public void Start()
	{
		if (m_request != null)
		{
			return;
		}
		bool flag = true;
		m_beginPos = 0L;
		if (m_fileStream == null)
		{
			m_messageDealObj = new GameObject("httpDownload");
			HttpDownloadMessageDeal httpDownloadMessageDeal = m_messageDealObj.AddComponent<HttpDownloadMessageDeal>();
			httpDownloadMessageDeal.SetDownload(this);
			UnityEngine.Object.DontDestroyOnLoad(m_messageDealObj);
			m_saveDirectory = Path.GetDirectoryName(m_savePath);
			if (File.Exists(m_savePath))
			{
				HttpDownloadInfo hdi = new HttpDownloadInfo();
				bool flag2 = ReadDownLoadInfo(ref hdi);
				m_fileStream = File.OpenWrite(m_savePath);
				if (flag2)
				{
					if (m_fileStream.Length >= hdi.m_totalSize)
					{
						Close(EDOWNLOADRESULT.EDR_SUCCESS);
						flag = false;
					}
					else
					{
						m_beginPos = m_fileStream.Length;
						m_fileStream.Seek(m_beginPos, SeekOrigin.Current);
					}
				}
				else
				{
					m_fileStream.SetLength(0L);
					m_fileStream.Flush();
				}
			}
			else
			{
				m_fileStream = new FileStream(m_savePath, FileMode.Create);
			}
		}
		if (!flag)
		{
			return;
		}
		Uri requestUri = new Uri(m_url);
		try
		{
			ServicePointManager.ServerCertificateValidationCallback = CheckValidationResult;
			m_downlaodResult = EDOWNLOADRESULT.EDR_DOWNLOADING;
			m_request = (HttpWebRequest)WebRequest.Create(requestUri);
			m_request.AddRange((int)m_beginPos);
			Debug.Log("begin get response");
			m_diskFreeSpace = GetDiskFreeSpace();
			IAsyncResult asyncResult = m_request.BeginGetResponse(GetResponseCallback, this);
			ThreadPool.RegisterWaitForSingleObject(asyncResult.AsyncWaitHandle, TimeoutCallback, this, 3000, true);
		}
		catch (Exception ex)
		{
			Debug.Log(ex.ToString());
			Close(EDOWNLOADRESULT.EDR_CREATEREQUESTEXCEPTION);
		}
	}

	private long GetDiskFreeSpace()
	{
		long num = 0L;
		return AndroidUtil.Instance().GetPathFreeSpace(m_saveDirectory);
	}

	private static void TimeoutCallback(object state, bool timeOut)
	{
		HttpDownload httpDownload = (HttpDownload)state;
		if (timeOut)
		{
			Debug.Log("time out");
			httpDownload.Close(EDOWNLOADRESULT.EDR_TIMEOUT);
		}
	}

	private static void GetResponseCallback(IAsyncResult ar)
	{
		HttpDownload httpDownload = (HttpDownload)ar.AsyncState;
		try
		{
			httpDownload.m_reponse = (HttpWebResponse)httpDownload.m_request.EndGetResponse(ar);
			httpDownload.m_needRequestLen = httpDownload.m_reponse.ContentLength;
			if (httpDownload.m_diskFreeSpace + 10485760 > httpDownload.m_needRequestLen)
			{
				httpDownload.m_totalResourceLen = httpDownload.m_needRequestLen + httpDownload.m_beginPos;
				HttpDownloadInfo httpDownloadInfo = new HttpDownloadInfo();
				httpDownloadInfo.m_totalSize = httpDownload.m_totalResourceLen;
				httpDownload.WriteDownloadInfo(httpDownloadInfo);
				httpDownload.m_hasDownloadResurceLen = httpDownload.m_beginPos;
				httpDownload.m_responseStream = httpDownload.m_reponse.GetResponseStream();
				Debug.Log("begin read data");
				httpDownload.m_writeFileBuffer = new MemoryStream(1058816);
				IAsyncResult asyncResult = httpDownload.m_responseStream.BeginRead(httpDownload.m_buffer, 0, 10240, ReadCallback, httpDownload);
				ThreadPool.RegisterWaitForSingleObject(asyncResult.AsyncWaitHandle, TimeoutCallback, httpDownload, 10000, true);
			}
			else
			{
				Debug.Log("disk space not enough!");
				httpDownload.Close(EDOWNLOADRESULT.EDR_SPACENOTENOUGH);
			}
		}
		catch (WebException ex)
		{
			Debug.Log("GetResponseCallback WebException error:" + ex.ToString());
			if (ex.Response != null && ((HttpWebResponse)ex.Response).StatusCode == HttpStatusCode.RequestedRangeNotSatisfiable)
			{
				httpDownload.Close(EDOWNLOADRESULT.EDR_SUCCESS);
			}
			else
			{
				httpDownload.Close(EDOWNLOADRESULT.EDR_FAILED);
			}
		}
		catch (Exception ex2)
		{
			Debug.Log("GetResponseCallback Exception error:" + ex2.ToString());
			httpDownload.Close(EDOWNLOADRESULT.EDR_FAILED);
		}
	}

	private void WriteBufferToFile()
	{
		if (m_writeFileBuffer != null && m_writeFileBuffer.Length > 0)
		{
			m_fileStream.Write(m_writeFileBuffer.GetBuffer(), 0, (int)m_writeFileBuffer.Length);
			m_fileStream.Flush();
			m_writeFileBuffer.SetLength(0L);
		}
	}

	private static void ReadCallback(IAsyncResult asyncResult)
	{
		HttpDownload httpDownload = (HttpDownload)asyncResult.AsyncState;
		if (httpDownload.m_responseStream == null)
		{
			return;
		}
		try
		{
			int num = httpDownload.m_responseStream.EndRead(asyncResult);
			if (num > 0)
			{
				httpDownload.m_writeFileBuffer.Write(httpDownload.m_buffer, 0, num);
				if (httpDownload.m_writeFileBuffer.Length >= 1048576)
				{
					httpDownload.WriteBufferToFile();
				}
				httpDownload.m_needRequestLen -= num;
				httpDownload.m_hasDownloadResurceLen += num;
				if (httpDownload.m_progressCallback != null)
				{
					httpDownload.m_mutex.WaitOne();
					httpDownload.m_showHasDownloadSize = httpDownload.m_hasDownloadResurceLen;
					httpDownload.m_showTotalDownloadSize = httpDownload.m_totalResourceLen;
					httpDownload.m_mutex.ReleaseMutex();
				}
				if (httpDownload.m_needRequestLen > 0)
				{
					IAsyncResult asyncResult2 = httpDownload.m_responseStream.BeginRead(httpDownload.m_buffer, 0, 10240, ReadCallback, httpDownload);
					ThreadPool.RegisterWaitForSingleObject(asyncResult2.AsyncWaitHandle, TimeoutCallback, httpDownload, 10000, true);
				}
				else
				{
					Debug.Log("DownLoad End.");
					httpDownload.Close(EDOWNLOADRESULT.EDR_SUCCESS);
				}
			}
			else
			{
				Debug.Log("DownLoad failed.");
				httpDownload.Close(EDOWNLOADRESULT.EDR_FAILED);
			}
		}
		catch (Exception ex)
		{
			Debug.Log("ReadCallback Exception error:" + ex.ToString());
			httpDownload.Close(EDOWNLOADRESULT.EDR_FAILED);
		}
	}

	public void Close(EDOWNLOADRESULT ret)
	{
		if (m_writeFileBuffer != null)
		{
			WriteBufferToFile();
			m_writeFileBuffer.Close();
			m_writeFileBuffer = null;
		}
		if (m_downloadResultCallback != null)
		{
			m_mutex.WaitOne();
			m_downlaodResult = ret;
			m_mutex.ReleaseMutex();
		}
		if (m_fileStream != null && m_autoCloseFileStream)
		{
			m_fileStream.Close();
			m_fileStream = null;
		}
		if (m_responseStream != null)
		{
			m_responseStream.Close();
			m_responseStream = null;
		}
		if (m_reponse != null)
		{
			m_reponse.Close();
			m_reponse = null;
		}
		if (m_request != null)
		{
			m_request.Abort();
			m_request = null;
		}
	}

	public void Update()
	{
		m_updateDeltaTime += Time.deltaTime;
		if ((double)m_updateDeltaTime > 0.3)
		{
			m_updateDeltaTime = 0f;
			if (m_showHasDownloadSize > 0)
			{
				m_progressCallback(m_showHasDownloadSize, m_showTotalDownloadSize, m_showDownRate);
				m_showHasDownloadSize = -1L;
			}
			if (m_downlaodResult != EDOWNLOADRESULT.EDR_DOWNLOADING && m_downlaodResult != EDOWNLOADRESULT.EDR_Down)
			{
				m_downloadResultCallback(m_downlaodResult);
				UnityEngine.Object.Destroy(m_messageDealObj);
			}
		}
	}
}
