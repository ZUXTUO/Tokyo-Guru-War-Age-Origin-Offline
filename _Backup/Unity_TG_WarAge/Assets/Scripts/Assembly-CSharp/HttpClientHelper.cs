using System;
using System.IO;
using System.Net;
using System.Threading;
using Core.Resource;
using Core.Unity;
using SUpdate;
using UnityEngine;

public class HttpClientHelper
{
	private const int BUFFER_SIZE = 10240;

	private const int TIMEOUT = 10000;

	private const int CONNTECTTIMEOUT = 10000;

	private int m_Id;

	private bool m_alive;

	private bool m_OPComplete;

	private string m_url;

	private string m_filePath;

	private string m_saveDirectory;

	private HttpWebRequest m_request;

	private HttpWebResponse m_reponse;

	private Stream m_responseStream;

	private byte[] m_buffer = new byte[10240];

	private MemoryStream m_fileBuffStream;

	private string m_redirectURL;

	private long m_downloadSize;

	private long m_totalSize;

	private string m_fileMd5 = string.Empty;

	private OnProgressHandler m_onProgressHandler;

	private OnErrorHandler m_onErrorHandler;

	private OnSuccHandler m_onSuccHandler;

	private OnURLRedirectHandler m_onRedirectHandler;

	private bool m_onSuccCalled;

	private bool m_onRedirectCalled;

	private HTTP_OP_STEP m_opStep = HTTP_OP_STEP.unkonw;

	private HTTP_OP_RET m_opRet = HTTP_OP_RET.unknown;

	private int m_httpStatusCode = -1;

	private string m_msg;

	private float m_updateDeltaTime;

	public HttpClientHelper(string filePath, string url, int id)
	{
		m_filePath = filePath;
		m_url = url;
		m_Id = id;
	}

	~HttpClientHelper()
	{
	}

	public void SetCallback(OnProgressHandler onProgress, OnErrorHandler onError, OnSuccHandler onSucc, OnURLRedirectHandler onRedirect)
	{
		m_onProgressHandler = onProgress;
		m_onErrorHandler = onError;
		m_onSuccHandler = onSucc;
		m_onRedirectHandler = onRedirect;
	}

	public void Start()
	{
		m_alive = true;
		m_OPComplete = false;
		m_opRet = HTTP_OP_RET.unknown;
		Uri requestUri = new Uri(m_url);
		try
		{
			m_opStep = HTTP_OP_STEP.connecting;
			m_request = (HttpWebRequest)WebRequest.Create(requestUri);
			m_request.AllowAutoRedirect = false;
			IAsyncResult asyncResult = m_request.BeginGetResponse(GetResponseCallback, this);
			ThreadPool.RegisterWaitForSingleObject(asyncResult.AsyncWaitHandle, TimeoutCallback, this, 10000, true);
		}
		catch (Exception ex)
		{
			Close(HTTP_OP_RET.failed, -1, ex.ToString());
		}
	}

	private static void TimeoutCallback(object state, bool timeOut)
	{
		HttpClientHelper httpClientHelper = (HttpClientHelper)state;
		if (timeOut)
		{
			httpClientHelper.Close(HTTP_OP_RET.time_out, 408, string.Empty);
		}
	}

	private static void GetResponseCallback(IAsyncResult ar)
	{
		HttpClientHelper httpClientHelper = (HttpClientHelper)ar.AsyncState;
		try
		{
			httpClientHelper.m_reponse = (HttpWebResponse)httpClientHelper.m_request.EndGetResponse(ar);
			HttpStatusCode statusCode = httpClientHelper.m_reponse.StatusCode;
			if (statusCode == HttpStatusCode.Found || statusCode == HttpStatusCode.Found || statusCode == HttpStatusCode.MovedPermanently || statusCode == HttpStatusCode.MovedPermanently)
			{
				httpClientHelper.m_redirectURL = httpClientHelper.m_reponse.Headers["Location"];
				httpClientHelper.Close(HTTP_OP_RET.failed, (int)statusCode, httpClientHelper.m_reponse.StatusDescription);
				return;
			}
			httpClientHelper.m_totalSize = httpClientHelper.m_reponse.ContentLength;
			httpClientHelper.m_responseStream = httpClientHelper.m_reponse.GetResponseStream();
			httpClientHelper.m_fileBuffStream = new MemoryStream();
			httpClientHelper.m_opStep = HTTP_OP_STEP.downloading;
			IAsyncResult asyncResult = httpClientHelper.m_responseStream.BeginRead(httpClientHelper.m_buffer, 0, 10240, ReadCallback, httpClientHelper);
			ThreadPool.RegisterWaitForSingleObject(asyncResult.AsyncWaitHandle, TimeoutCallback, httpClientHelper, 10000, true);
		}
		catch (WebException ex)
		{
			HttpStatusCode httpStatusCode = HttpStatusCode.BadRequest;
			if (ex.Status == WebExceptionStatus.Timeout)
			{
				httpStatusCode = HttpStatusCode.RequestTimeout;
			}
			else if (ex.Status == WebExceptionStatus.ConnectFailure)
			{
				httpStatusCode = HttpStatusCode.InternalServerError;
			}
			else
			{
				HttpWebResponse httpWebResponse = ex.Response as HttpWebResponse;
				httpStatusCode = httpWebResponse.StatusCode;
			}
			httpClientHelper.Close(HTTP_OP_RET.failed, (int)httpStatusCode, ex.ToString());
		}
		catch (Exception ex2)
		{
			httpClientHelper.Close(HTTP_OP_RET.failed, -1, ex2.ToString());
		}
	}

	private static void ReadCallback(IAsyncResult asyncResult)
	{
		HttpClientHelper httpClientHelper = (HttpClientHelper)asyncResult.AsyncState;
		if (httpClientHelper.m_responseStream == null)
		{
			return;
		}
		try
		{
			int num = httpClientHelper.m_responseStream.EndRead(asyncResult);
			if (num > 0)
			{
				httpClientHelper.m_fileBuffStream.Write(httpClientHelper.m_buffer, 0, num);
				httpClientHelper.m_downloadSize += num;
				if (httpClientHelper.m_downloadSize < httpClientHelper.m_totalSize)
				{
					IAsyncResult asyncResult2 = httpClientHelper.m_responseStream.BeginRead(httpClientHelper.m_buffer, 0, 10240, ReadCallback, httpClientHelper);
					ThreadPool.RegisterWaitForSingleObject(asyncResult2.AsyncWaitHandle, TimeoutCallback, httpClientHelper, 10000, true);
				}
				else
				{
					httpClientHelper.Close(HTTP_OP_RET.succ, 200, string.Empty);
				}
			}
		}
		catch (WebException ex)
		{
			HttpWebResponse httpWebResponse = ex.Response as HttpWebResponse;
			httpClientHelper.Close(HTTP_OP_RET.failed, (int)httpWebResponse.StatusCode, ex.ToString());
		}
		catch (Exception ex2)
		{
			httpClientHelper.Close(HTTP_OP_RET.failed, -1, ex2.ToString());
		}
	}

	public void Close(HTTP_OP_RET ret, int httpCode, string msg)
	{
		m_opRet = ret;
		m_httpStatusCode = httpCode;
		m_msg = msg;
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
		m_buffer = null;
		m_OPComplete = true;
	}

	public static bool Save(MemoryStream m, string path)
	{
		if (m != null)
		{
			string writePath = FileUtil.GetWritePath(path);
			if (FileUtil.CreateFolderByFile(writePath))
			{
				try
				{
					if (File.Exists(writePath))
					{
						File.Delete(writePath);
					}
					FileStream fileStream = File.Create(writePath);
					fileStream.Write(m.GetBuffer(), System.Convert.ToInt32(m.Position), System.Convert.ToInt32(m.Length - m.Position));
					fileStream.Flush();
					fileStream.Close();
					return true;
				}
				catch (Exception ex)
				{
					Core.Unity.Debug.LogError(ex.ToString());
				}
			}
		}
		return false;
	}

	public void Update()
	{
		if (!m_alive)
		{
			return;
		}
		if (m_OPComplete)
		{
			if (m_opRet == HTTP_OP_RET.succ)
			{
				m_fileBuffStream.Position = 0L;
				string md = Utils.Md5(m_fileBuffStream);
				m_fileBuffStream.Position = 0L;
				if (!Save(m_fileBuffStream, m_filePath))
				{
					m_opRet = HTTP_OP_RET.failed;
					m_httpStatusCode = -1;
					m_msg = "Save File Failed";
					return;
				}
				if (m_onProgressHandler != null)
				{
					m_onProgressHandler(m_url, m_filePath, m_downloadSize, m_totalSize);
				}
				if (m_onSuccHandler != null)
				{
					m_onSuccHandler(m_url, m_filePath, (int)m_totalSize, md);
				}
			}
			else if (m_redirectURL != null)
			{
				if (m_onRedirectHandler != null)
				{
					m_onRedirectHandler(m_url, m_filePath, m_redirectURL, m_httpStatusCode, m_msg);
				}
			}
			else if (m_onErrorHandler != null)
			{
				m_onErrorHandler(m_url, m_filePath, m_httpStatusCode, m_msg);
			}
			m_alive = false;
		}
		else
		{
			if (m_opStep != HTTP_OP_STEP.downloading)
			{
				return;
			}
			m_updateDeltaTime += Time.deltaTime;
			if ((double)m_updateDeltaTime > 0.5)
			{
				m_updateDeltaTime = 0f;
				if (m_onProgressHandler != null)
				{
					m_onProgressHandler(m_url, m_filePath, m_downloadSize, m_totalSize);
				}
			}
		}
	}
}
