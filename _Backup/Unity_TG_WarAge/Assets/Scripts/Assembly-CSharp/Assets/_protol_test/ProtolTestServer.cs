using System;
using System.Collections.Generic;
using System.IO;
using System.Net;
using System.Net.Sockets;
using System.Text;
using System.Threading;
using Core.Net;
using Core.Unity;
using Sio;
using UnityEngine;

namespace Assets._protol_test
{
	internal class ProtolTestServer
	{
		private bool m_isStart;

		private Socket m_client;

		private Socket m_listen;

		private object receiveLock = new object();

		private const int MEM_SIZE = 1048576;

		private byte[] receiveData = new byte[1048576];

		private int currentReceivePos;

		public PackageFactory PackageFactory = new PackageFactory();

		private uint sendSeqId;

		private uint receiveSeqId;

		private uint packageKey;

		private string uploadingFilePath;

		private StringBuilder runScriptBuilder;

		private string runScriptString;

		private static readonly object runListLock = new object();

		private List<string> backRunScriptList = new List<string>();

		private List<string> frontRunScriptList = new List<string>();

		private static readonly object sendLock = new object();

		private LinkedList<Package> sendDataList = new LinkedList<Package>();

		private LinkedList<Package> frontSendList = new LinkedList<Package>();

		private byte[] sendData;

		private int sendDataPos;

		private bool isSending;

		public static ProtolTestServer m_inst = null;

		public static ProtolTestServer GetInst()
		{
			if (m_inst == null)
			{
				m_inst = new ProtolTestServer();
			}
			return m_inst;
		}

		public void Begin()
		{
			GameObject gameObject = new GameObject("_protol_test__");
			gameObject.AddComponent<ProtolTestComponent>();
			UnityEngine.Object.DontDestroyOnLoad(gameObject);
		}

		public void BeginNet()
		{
			if (m_isStart)
			{
				return;
			}
			IPAddress address = IPAddress.Parse("0.0.0.0");
			IPEndPoint local_end = new IPEndPoint(address, 8715);
			try
			{
				m_listen = new Socket(AddressFamily.InterNetwork, SocketType.Stream, ProtocolType.Tcp);
				m_listen.Bind(local_end);
				m_listen.Listen(20);
				BeginAccept();
			}
			catch (Exception ex)
			{
				UnityEngine.Debug.LogError("[protol tool] listen error:" + ex.ToString());
			}
		}

		public void StopNet()
		{
			if (m_listen != null)
			{
				m_listen.Close();
				m_listen = null;
			}
			if (m_client != null)
			{
				m_client.Close();
				m_client = null;
			}
			m_inst = null;
		}

		private void AcceptCallback(IAsyncResult iar)
		{
			try
			{
				Socket socket = (Socket)iar.AsyncState;
				m_client = socket.EndAccept(iar);
				StartRead();
			}
			catch (Exception ex)
			{
				UnityEngine.Debug.Log("[protol tool] accetp error:" + ex.ToString());
				BeginAccept();
			}
		}

		private void StartRead()
		{
			if (m_client.Connected)
			{
				m_client.BeginReceive(receiveData, currentReceivePos, receiveData.Length - currentReceivePos, SocketFlags.None, ReceiveCallBack, m_client);
			}
		}

		public void ReceiveCallBack(IAsyncResult ir)
		{
			Socket socket = (Socket)ir.AsyncState;
			try
			{
				int num = socket.EndReceive(ir);
				if (num != 0)
				{
					currentReceivePos += num;
					int num2 = 0;
					while (currentReceivePos - num2 > 0)
					{
						Package package = PackageFactory.CreatePackage(receiveData, num2, currentReceivePos - num2);
						if (package == null)
						{
							break;
						}
						num2 += package.AllSize;
						if (!package.Header.CheckSeqNum(receiveSeqId + 1))
						{
							throw new Exception(string.Format("[protol tool] error seq message {0}.", package.Header.MessageId));
						}
						receiveSeqId++;
						package.SetKey(packageKey);
						if (!package.decode())
						{
							throw new Exception(string.Format("[Client ReceiveCallBack] client decode failed, message:{0}", package.Header.MessageId));
						}
						ProcessMessage(package);
					}
					if (num2 != 0)
					{
						Array.Copy(receiveData, num2, receiveData, 0, currentReceivePos - num2);
						currentReceivePos -= num2;
					}
				}
				StartRead();
			}
			catch (Exception ex)
			{
				UnityEngine.Debug.LogError("[protol tool] recive error:" + ex.ToString());
				BeginAccept();
			}
		}

		public void ProcessMessage(Package p)
		{
			switch ((ndebug_mgr_enum)p.MessageID)
			{
			case ndebug_mgr_enum.ndebug_mgr_run_script:
				RunScriptMsg(p);
				break;
			case ndebug_mgr_enum.ndebug_mgr_req_upload_fid:
				BeginUploadFile(p);
				break;
			case ndebug_mgr_enum.ndebug_mgr_req_upload_data:
				UploadFileData(p);
				break;
			case ndebug_mgr_enum.ndebug_mgr_req_upload_complete:
				UploadFileComplete(p);
				break;
			case ndebug_mgr_enum.ndebug_mgr_set_fps:
			case ndebug_mgr_enum.ndebug_mgr_set_show_image_bounding:
				break;
			}
		}

		public List<string> GetAllRunScriptList()
		{
			if (frontRunScriptList.Count <= 0)
			{
				lock (runListLock)
				{
					List<string> list = frontRunScriptList;
					frontRunScriptList = backRunScriptList;
					backRunScriptList = frontRunScriptList;
				}
			}
			return frontRunScriptList;
		}

		public void RunScriptMsg(Package p)
		{
			MemoryStream ms = new MemoryStream(p.Data);
			SDataBuff sDataBuff = new SDataBuff();
			sDataBuff.UnSerializ(ms);
			if (runScriptString != null && runScriptString.Length > 0)
			{
				lock (runListLock)
				{
					backRunScriptList.Add(runScriptString);
				}
			}
		}

		public void BeginUploadFile(Package p)
		{
			MemoryStream ms = new MemoryStream(p.Data);
			SDataBuff sDataBuff = new SDataBuff();
			sDataBuff.UnSerializ(ms);
			string stringValue = sDataBuff.stringValue;
			sDataBuff.UnSerializ(ms);
			int intValue = sDataBuff.intValue;
			runScriptBuilder = new StringBuilder();
			uploadingFilePath = stringValue;
			RepBeginUploadFile(stringValue, intValue);
		}

		public void UploadFileData(Package p)
		{
			MemoryStream ms = new MemoryStream(p.Data);
			SDataBuff sDataBuff = new SDataBuff();
			sDataBuff.UnSerializ(ms);
			int intValue = sDataBuff.intValue;
			sDataBuff.UnSerializ(ms);
			int intValue2 = sDataBuff.intValue;
			sDataBuff.UnSerializ(ms);
			int intValue3 = sDataBuff.intValue;
			sDataBuff.UnSerializ(ms);
			byte[] byteValue = sDataBuff.ByteValue;
			runScriptBuilder.Append(Encoding.ASCII.GetString(byteValue));
			ResUploadFileData(intValue, intValue3);
		}

		public void ResUploadFileData(int fileid, int acceptSize)
		{
			Package package = PackageFactory.CreatePackage();
			package.MessageID = 200014;
			MemoryStream memoryStream = new MemoryStream();
			SData sData = new SData(fileid);
			sData.Serializ(memoryStream);
			sData = new SData(acceptSize);
			sData.Serializ(memoryStream);
			byte[] array = new byte[memoryStream.Length];
			Array.Copy(memoryStream.GetBuffer(), array, memoryStream.Length);
			package.Data = array;
			Send(package);
		}

		public void UploadFileComplete(Package p)
		{
			MemoryStream ms = new MemoryStream(p.Data);
			SDataBuff sDataBuff = new SDataBuff();
			sDataBuff.UnSerializ(ms);
			int intValue = sDataBuff.intValue;
			runScriptString = runScriptBuilder.ToString();
			ResUploadFileComplete(intValue, 1);
		}

		public void ResUploadFileComplete(int fileid, int result)
		{
			Package package = PackageFactory.CreatePackage();
			package.MessageID = 200015;
			MemoryStream memoryStream = new MemoryStream();
			SData sData = new SData(fileid);
			sData.Serializ(memoryStream);
			sData = new SData(result);
			sData.Serializ(memoryStream);
			byte[] array = new byte[memoryStream.Length];
			Array.Copy(memoryStream.GetBuffer(), array, memoryStream.Length);
			package.Data = array;
			Send(package);
		}

		public void RepBeginUploadFile(string path, int size)
		{
			Package package = PackageFactory.CreatePackage();
			package.MessageID = 200013;
			MemoryStream memoryStream = new MemoryStream();
			SData sData = new SData(path);
			sData.Serializ(memoryStream);
			sData = new SData(100);
			sData.Serializ(memoryStream);
			byte[] array = new byte[memoryStream.Length];
			Array.Copy(memoryStream.GetBuffer(), array, memoryStream.Length);
			package.Data = array;
			Send(package);
		}

		public bool Send(Package p)
		{
			lock (sendLock)
			{
				sendDataList.AddLast(p);
			}
			StartWrite();
			return true;
		}

		public bool SendList(ref LinkedList<Package> list)
		{
			bool flag = false;
			lock (sendLock)
			{
				if (sendDataList.Count < 10)
				{
					if (sendDataList.Count == 0)
					{
						LinkedList<Package> linkedList = sendDataList;
						sendDataList = list;
						list = linkedList;
					}
					else
					{
						LinkedListNode<Package> linkedListNode = sendDataList.Last;
						do
						{
							list.AddFirst(linkedListNode.Value);
							linkedListNode = linkedListNode.Previous;
						}
						while (linkedListNode != null);
						sendDataList.Clear();
						LinkedList<Package> linkedList2 = sendDataList;
						sendDataList = list;
						list = linkedList2;
					}
					flag = true;
				}
			}
			if (flag)
			{
				StartWrite();
			}
			return flag;
		}

		private void StartWrite()
		{
			if (isSending)
			{
				return;
			}
			try
			{
				Package package = null;
				lock (sendLock)
				{
					if (sendDataList.Count > 0)
					{
						package = sendDataList.First.Value;
						sendDataList.RemoveFirst();
					}
				}
				if (package != null)
				{
					sendData = null;
					sendDataPos = 0;
					package.Header.SetSeqNum(++sendSeqId);
					package.SetKey(packageKey);
					sendData = package.GetBytes();
					isSending = true;
					m_client.BeginSend(sendData, sendDataPos, sendData.Length - sendDataPos, SocketFlags.None, SendCallBack, m_client);
				}
			}
			catch (Exception ex)
			{
				UnityEngine.Debug.LogError("[protol tool]SendException:" + ex);
				BeginAccept();
			}
		}

		public void SendCallBack(IAsyncResult ir)
		{
			Socket socket = (Socket)ir.AsyncState;
			try
			{
				int num = socket.EndSend(ir);
				if (num > 0)
				{
					sendDataPos += num;
					if (sendDataPos < sendData.Length)
					{
						socket.BeginSend(sendData, sendDataPos, sendData.Length - sendDataPos, SocketFlags.None, SendCallBack, socket);
						return;
					}
					isSending = false;
					StartWrite();
				}
				else
				{
					new Exception("send data size == 0");
				}
			}
			catch (Exception ex)
			{
				UnityEngine.Debug.LogError("[protol tool]SendCallbackException:" + ex);
				BeginAccept();
			}
		}

		public void BeginAccept()
		{
			if (m_client != null)
			{
				m_client.Close();
				m_client = null;
			}
			currentReceivePos = 0;
			isSending = false;
			m_listen.BeginAccept(AcceptCallback, m_listen);
		}

		public void Log(Core.Unity.Debug.LOG_TYPE type, string log)
		{
			if (m_client != null && Thread.CurrentThread.ManagedThreadId == 1)
			{
				Package package = PackageFactory.CreatePackage();
				ndebug_mgr_enum messageID = ndebug_mgr_enum.ndebug_mgr_on_print_log;
				switch (type)
				{
				case Core.Unity.Debug.LOG_TYPE.LT_WARN:
					messageID = ndebug_mgr_enum.ndebug_mgr_on_print_warning;
					break;
				case Core.Unity.Debug.LOG_TYPE.LT_ERROR:
					messageID = ndebug_mgr_enum.ndebug_mgr_on_print_error;
					break;
				}
				package.MessageID = (int)messageID;
				MemoryStream memoryStream = new MemoryStream();
				SData sData = new SData(log);
				sData.Serializ(memoryStream);
				byte[] array = new byte[memoryStream.Length];
				Array.Copy(memoryStream.GetBuffer(), array, memoryStream.Length);
				package.Data = array;
				frontSendList.AddLast(package);
			}
		}

		public void SendAllFrontPackage()
		{
			SendList(ref frontSendList);
		}
	}
}
