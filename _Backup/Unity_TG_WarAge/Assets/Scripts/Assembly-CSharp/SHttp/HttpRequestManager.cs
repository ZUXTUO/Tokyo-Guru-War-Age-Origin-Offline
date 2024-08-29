using System;
using System.Collections.Generic;
using System.Net;
using Core.Unity;
using UnityEngine;

namespace SHttp
{
	public class HttpRequestManager : MonoBehaviourEx
	{
		private static HttpRequestManager m_instance;

		private static string m_go_name = "_HttpRequestManager";

		private Queue<RequestState> m_req_queue = new Queue<RequestState>();

		private List<RequestState> m_req_sent = new List<RequestState>();

		public static HttpRequestManager GetInstance()
		{
			if (m_instance == null)
			{
				GameObject gameObject = MonoBehaviourEx.CreateGameObject(m_go_name);
				m_instance = gameObject.AddComponent<HttpRequestManager>();
			}
			return m_instance;
		}

		public void Get(string uri, SuccessCallback suCallback, ErrorCallback erCallback, DowningCallback doingCallback, object userData)
		{
			RequestState requestState = new RequestState();
			requestState.request = null;
			requestState.successCallback = suCallback;
			requestState.errorCallback = erCallback;
			requestState.downingCallback = doingCallback;
			requestState.userData = userData;
			try
			{
				Uri requestUri = new Uri(uri);
				HttpWebRequest httpWebRequest = (HttpWebRequest)WebRequest.Create(requestUri);
				httpWebRequest.Method = "GET";
				requestState.request = httpWebRequest;
				Queue(requestState);
			}
			catch (Exception)
			{
				requestState.status = 404;
				requestState.errorCallback(requestState);
			}
		}

		public void Post(string uri, string postData, SuccessCallback suCallback, ErrorCallback erCallback, DowningCallback doingCallback, object userData)
		{
			RequestState requestState = new RequestState();
			requestState.request = null;
			requestState.successCallback = suCallback;
			requestState.errorCallback = erCallback;
			requestState.downingCallback = doingCallback;
			requestState.postData = postData;
			requestState.userData = userData;
			try
			{
				Uri requestUri = new Uri(uri);
				HttpWebRequest httpWebRequest = (HttpWebRequest)WebRequest.Create(requestUri);
				httpWebRequest.Method = "POST";
				httpWebRequest.ContentType = "application/x-www-form-urlencoded";
				requestState.request = httpWebRequest;
				Queue(requestState);
			}
			catch (Exception)
			{
				requestState.status = 404;
				requestState.errorCallback(requestState);
			}
		}

		public void Queue(RequestState rs)
		{
			try
			{
				m_req_queue.Enqueue(rs);
			}
			catch (Exception ex)
			{
				Core.Unity.Debug.LogError(ex.ToString());
				throw ex;
			}
		}

		public RequestState DeQueue()
		{
			return m_req_queue.Dequeue();
		}

		public void AddSentRequest(RequestState req)
		{
			m_req_sent.Add(req);
		}

		public RequestState GetFinishRequest()
		{
			RequestState result = null;
			for (int i = 0; i < m_req_sent.Count; i++)
			{
				if (m_req_sent[i].finish)
				{
					result = m_req_sent[i];
					m_req_sent.RemoveAt(i);
					break;
				}
			}
			return result;
		}

		public void HandleDowningRequests()
		{
			for (int i = 0; i < m_req_sent.Count; i++)
			{
				if (m_req_sent[i].downSize > 0)
				{
					m_req_sent[i].downingCallback(m_req_sent[i], m_req_sent[i].downSize, m_req_sent[i].bytes.Count, m_req_sent[i].response.ContentLength);
					m_req_sent[i].downSize = 0;
				}
			}
		}

		public void HandleFinishRequest(RequestState rs)
		{
			if (rs.status == 200)
			{
				rs.successCallback(rs);
			}
			else
			{
				rs.errorCallback(rs);
			}
		}

		private void FixedUpdate()
		{
			if (m_req_queue.Count > 0 && m_req_sent.Count < 6)
			{
				RequestState requestState = DeQueue();
				if (requestState == null)
				{
					return;
				}
				if (true)
				{
					StartCoroutine(new HttpClient().GetWWW(requestState));
				}
				else if (requestState.request.Method == "GET")
				{
					new HttpClient().Get(requestState);
				}
				else if (requestState.request.Method == "POST")
				{
					new HttpClient().Post(requestState);
				}
				AddSentRequest(requestState);
			}
			if (m_req_sent.Count > 0)
			{
				HandleDowningRequests();
				RequestState finishRequest = GetFinishRequest();
				if (finishRequest != null)
				{
					HandleFinishRequest(finishRequest);
				}
			}
		}
	}
}
