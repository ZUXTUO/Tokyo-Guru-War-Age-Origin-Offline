using System;
using System.Collections;
using System.IO;
using System.Linq;
using System.Net;
using System.Text;
using System.Threading;
using Core.Unity;
using Unity.IO.Compression;
using UnityEngine;

namespace SHttp
{
	public class HttpClient
	{
		public const int TIMEOUT = 5000;

		public const int READWRITETIMEOUT = 15000;

		public const int BUFFER_SIZE = 1024;

		public IEnumerator GetWWW(RequestState rs)
		{
			bool redirect = false;
			string redirectionURL = string.Empty;
			string reqURL2 = string.Empty;
			do
			{
				if (redirect)
				{
					reqURL2 = redirectionURL;
					redirect = false;
				}
				else
				{
					reqURL2 = rs.request.RequestUri.ToString();
				}
				if (rs.request.Method == "GET")
				{
					WWW www = new WWW(reqURL2);
					yield return www;
					if (www.error != null)
					{
						rs.errStr = www.error;
						rs.status = 404;
						UnityEngine.Debug.LogError("[HttpClient GetWWW] STATUS:" + rs.status + ",errorMessage:" + rs.errStr + ", path:" + rs.request.RequestUri.ToString());
					}
					else if (www.responseHeaders.ContainsKey("STATUS") && www.responseHeaders["STATUS"].IndexOf("302") > -1)
					{
						if (www.responseHeaders.ContainsKey("LOCATION"))
						{
							Core.Unity.Debug.LogWarning("[HttpClient GetWWW] STATUS:" + www.responseHeaders["STATUS"] + ",errorMessage:" + rs.errStr + ", path:" + rs.request.RequestUri.ToString());
							redirectionURL = www.responseHeaders["LOCATION"].ToString();
							redirect = true;
							continue;
						}
					}
					else if (www.responseHeaders.ContainsKey("STATUS") && www.responseHeaders["STATUS"].IndexOf("301") > -1)
					{
						if (www.responseHeaders.ContainsKey("LOCATION"))
						{
							Core.Unity.Debug.LogWarning("[HttpClient GetWWW] STATUS:" + www.responseHeaders["STATUS"] + ",errorMessage:" + rs.errStr + ", path:" + rs.request.RequestUri.ToString());
							redirectionURL = www.responseHeaders["LOCATION"].ToString();
							redirect = true;
							continue;
						}
					}
					else
					{
						rs.status = 200;
						if (www.responseHeaders.ContainsKey("Content-Encoding") && www.responseHeaders["Content-Encoding"] == "gzip")
						{
							rs.iszip = true;
							try
							{
								GZipStream gZipStream = new GZipStream(new MemoryStream(www.bytes), CompressionMode.Decompress, true);
								MemoryStream memoryStream = new MemoryStream();
								byte[] array = new byte[512];
								int count;
								while ((count = gZipStream.Read(array, 0, array.Length)) != 0)
								{
									memoryStream.Write(array, 0, count);
								}
								rs.bytes.AddRange(memoryStream.ToArray().Take(memoryStream.ToArray().Length));
								gZipStream.Close();
								memoryStream.Close();
							}
							catch (Exception ex)
							{
								Core.Unity.Debug.Log("www.bytes try unzip is error and is not unzip useing www.bytes." + ex);
								rs.bytes.AddRange(www.bytes.Take(www.bytes.Length));
							}
						}
						else
						{
							rs.bytes.AddRange(www.bytes.Take(www.bytes.Length));
						}
					}
					rs.finish = true;
					continue;
				}
				WWWForm form = new WWWForm();
				form.AddField("key", rs.postData);
				WWW getData = new WWW(reqURL2, form);
				yield return getData;
				if (getData.error != null)
				{
					rs.errStr = getData.error;
					rs.status = 403;
					UnityEngine.Debug.LogError("[HttpClient GetWWW] STATUS:" + rs.status + ",errorMessage" + rs.errStr + ", path:" + rs.request.RequestUri.ToString());
				}
				else if (getData.responseHeaders.ContainsKey("STATUS") && getData.responseHeaders["STATUS"].IndexOf("302") > -1)
				{
					if (getData.responseHeaders.ContainsKey("LOCATION"))
					{
						Core.Unity.Debug.LogWarning("[HttpClient GetWWW] STATUS:" + getData.responseHeaders["STATUS"] + ",errorMessage:" + rs.errStr + ", path:" + rs.request.RequestUri.ToString());
						redirectionURL = getData.responseHeaders["LOCATION"].ToString();
						redirect = true;
						continue;
					}
				}
				else if (getData.responseHeaders.ContainsKey("STATUS") && getData.responseHeaders["STATUS"].IndexOf("301") > -1)
				{
					if (getData.responseHeaders.ContainsKey("LOCATION"))
					{
						Core.Unity.Debug.LogWarning("[HttpClient GetWWW] STATUS:" + getData.responseHeaders["STATUS"] + ",errorMessage:" + rs.errStr + ", path:" + rs.request.RequestUri.ToString());
						redirectionURL = getData.responseHeaders["LOCATION"].ToString();
						redirect = true;
						continue;
					}
				}
				else
				{
					rs.status = 200;
					if (getData.responseHeaders.ContainsKey("Content-Encoding") && getData.responseHeaders["Content-Encoding"] == "gzip")
					{
						rs.iszip = true;
						try
						{
							GZipStream gZipStream2 = new GZipStream(new MemoryStream(getData.bytes), CompressionMode.Decompress, true);
							MemoryStream memoryStream2 = new MemoryStream();
							byte[] array2 = new byte[512];
							int count2;
							while ((count2 = gZipStream2.Read(array2, 0, array2.Length)) != 0)
							{
								memoryStream2.Write(array2, 0, count2);
							}
							rs.bytes.AddRange(memoryStream2.ToArray().Take(memoryStream2.ToArray().Length));
							gZipStream2.Close();
							memoryStream2.Close();
						}
						catch (Exception ex2)
						{
							Core.Unity.Debug.Log("getData.bytes try unzip is error and is not unzip useing getData.bytes." + ex2);
							rs.bytes.AddRange(getData.bytes.Take(getData.bytes.Length));
						}
					}
					else
					{
						rs.bytes.AddRange(getData.bytes.Take(getData.bytes.Length));
					}
				}
				rs.finish = true;
			}
			while (redirect);
		}

		public void Get(RequestState rs)
		{
			try
			{
				HttpWebRequest request = rs.request;
				request.Timeout = 5000;
				request.ReadWriteTimeout = 15000;
				IAsyncResult asyncResult = request.BeginGetResponse(RespCallback, rs);
				ThreadPool.RegisterWaitForSingleObject(asyncResult.AsyncWaitHandle, TimeoutCallback, rs, 15000, true);
			}
			catch (Exception ex)
			{
				rs.errStr = ex.ToString();
				rs.status = 400;
				rs.finish = true;
			}
		}

		public void Post(RequestState rs)
		{
			try
			{
				HttpWebRequest request = rs.request;
				request.Timeout = 5000;
				request.ReadWriteTimeout = 15000;
				IAsyncResult asyncResult = request.BeginGetRequestStream(GetRequestStreamCallback, rs);
			}
			catch (Exception ex)
			{
				UnityEngine.Debug.LogError("[HttpClient Post] Exception: " + ex.ToString());
				rs.errStr = ex.ToString();
				rs.status = 400;
				rs.finish = true;
			}
		}

		private void GetRequestStreamCallback(IAsyncResult ar)
		{
			RequestState requestState = (RequestState)ar.AsyncState;
			try
			{
				Stream stream = requestState.request.EndGetRequestStream(ar);
				StringBuilder stringBuilder = new StringBuilder();
				stringBuilder.AppendFormat("{0}={1}", "post", requestState.postData);
				byte[] bytes = Encoding.UTF8.GetBytes(stringBuilder.ToString());
				stream.Write(bytes, 0, bytes.Length);
				stream.Close();
				IAsyncResult asyncResult = requestState.request.BeginGetResponse(RespCallback, requestState);
				ThreadPool.RegisterWaitForSingleObject(asyncResult.AsyncWaitHandle, TimeoutCallback, requestState, 15000, true);
			}
			catch (Exception ex)
			{
				UnityEngine.Debug.LogError("[HttpClient GetRequestStreamCallback] Exception: " + ex.ToString());
				requestState.errStr = ex.ToString();
				requestState.status = 400;
				requestState.finish = true;
			}
		}

		private void TimeoutCallback(object state, bool timedOut)
		{
			RequestState requestState = state as RequestState;
			if (timedOut && requestState != null)
			{
				requestState.timeOut = true;
				requestState.request.Abort();
			}
		}

		private void RespCallback(IAsyncResult ar)
		{
			RequestState requestState = (RequestState)ar.AsyncState;
			HttpWebRequest request = requestState.request;
			HttpWebResponse httpWebResponse = null;
			try
			{
				Stream responseStream = (requestState.response = (HttpWebResponse)request.EndGetResponse(ar)).GetResponseStream();
				IAsyncResult asyncResult = responseStream.BeginRead(requestState.buffer, 0, 1024, ReadCallBack, requestState);
			}
			catch (WebException ex)
			{
				if (requestState.timeOut)
				{
					requestState.status = 408;
				}
				else if (ex.Status == WebExceptionStatus.Timeout)
				{
					requestState.status = 408;
				}
				else if (ex.Status == WebExceptionStatus.ConnectFailure)
				{
					requestState.status = 500;
				}
				else
				{
					HttpWebResponse httpWebResponse2 = ex.Response as HttpWebResponse;
					requestState.status = (int)httpWebResponse2.StatusCode;
				}
				requestState.errStr = ex.ToString();
				requestState.finish = true;
				UnityEngine.Debug.LogError("[HttpClient RespCallback] Exception: " + requestState.errStr);
			}
		}

		private void BeginRead(RequestState rs)
		{
			Stream responseStream = rs.response.GetResponseStream();
			IAsyncResult asyncResult = responseStream.BeginRead(rs.buffer, 0, 1024, ReadCallBack, rs);
		}

		private void ReadCallBack(IAsyncResult asyncResult)
		{
			RequestState requestState = (RequestState)asyncResult.AsyncState;
			Stream responseStream = requestState.response.GetResponseStream();
			try
			{
				int num = responseStream.EndRead(asyncResult);
				if (num > 0)
				{
					requestState.bytes.AddRange(requestState.buffer.Take(num));
					if (requestState.downingCallback != null)
					{
						requestState.downSize += num;
					}
					IAsyncResult asyncResult2 = responseStream.BeginRead(requestState.buffer, 0, 1024, ReadCallBack, requestState);
				}
				else
				{
					requestState.status = (int)requestState.response.StatusCode;
					requestState.finish = true;
				}
			}
			catch (WebException ex)
			{
				HttpWebResponse httpWebResponse = ex.Response as HttpWebResponse;
				requestState.status = (int)httpWebResponse.StatusCode;
				requestState.errStr = ex.ToString();
				requestState.finish = true;
				UnityEngine.Debug.LogError("[HttpClient ReadCallBack] Exception: " + requestState.errStr);
			}
		}
	}
}
