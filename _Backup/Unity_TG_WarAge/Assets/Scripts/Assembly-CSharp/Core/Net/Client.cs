using System;
using System.Collections.Generic;
using System.IO;
using System.Net;
using System.Net.Sockets;
using System.Runtime.InteropServices;
using System.Text.RegularExpressions;
using Core.Unity;
using Core.Util;
using SNet;
using Sio;

namespace Core.Net
{
	public class Client
	{
		private static int CLIENT_KEY_MESSAGE_REQUEST_ID = 2;

		private static int CLIENT_KEY_MESSAGE_RESPONSE_ID = 3;

		private NetHandle handle;

		public PackageFactory PackageFactory = new PackageFactory();

		private int socketID;

		private Socket c;

		private byte[] sendData;

		private int sendDataPos;

		private const int MEM_SIZE = 1048576;

		private byte[] receiveData = new byte[1048576];

		private int currentReceivePos;

		private bool isSend;

		private object sendlock = new object();

		private bool isReceive;

		private object receiveLock = new object();

		private LinkedList<Package> sendDataList = new LinkedList<Package>();

		private uint sendSeqId;

		private uint receiveSeqId;

		public bool IsNeedExchangeKey;

		private bool isExchenagedKey;

		private uint packageKey;

		private uint nextSendPackageExtData;

		private string dispatchFunc;

		public NetHandle Handle
		{
			get
			{
				return handle;
			}
			set
			{
				handle = value;
			}
		}

		public int SocketID
		{
			get
			{
				return socketID;
			}
		}

		public bool isConnected
		{
			get
			{
				if (c != null)
				{
					return c.Connected;
				}
				return false;
			}
		}

		public uint NextSendPackageExtData
		{
			get
			{
				return nextSendPackageExtData;
			}
			set
			{
				nextSendPackageExtData = value;
			}
		}

		public string DispatchFunc
		{
			get
			{
				return dispatchFunc;
			}
			set
			{
				dispatchFunc = value;
			}
		}

		[DllImport("__Internal")]
		private static extern string getIPv6(string host, string port);

		public string GetIPv6(string host, string port)
		{
			return host + "&&ipv4";
		}

		public void getIPType(string serverIp, string serverPorts, out string newServerIp, out AddressFamily ipType)
		{
			ipType = AddressFamily.InterNetwork;
			newServerIp = serverIp;
			try
			{
				string iPv = GetIPv6(serverIp, serverPorts);
				if (string.IsNullOrEmpty(iPv))
				{
					return;
				}
				string[] array = Regex.Split(iPv, "&&");
				if (array != null && array.Length >= 2)
				{
					string text = array[1];
					if (text == "ipv6")
					{
						newServerIp = array[0];
						ipType = AddressFamily.InterNetworkV6;
					}
				}
			}
			catch (Exception ex)
			{
				Debug.LogError("GetIPv6 error:" + ex);
			}
		}

		public bool Send(Package p)
		{
			if (p != null)
			{
				p.Header.SetSeqNum(++sendSeqId);
				try
				{
					lock (sendlock)
					{
						sendDataList.AddLast(p);
					}
					StartWrite();
				}
				catch (Exception ex)
				{
					Debug.LogError("SendException:" + ex);
				}
				return true;
			}
			return false;
		}

		public bool Connect(string ip, int port)
		{
			if (c != null)
			{
				Close();
			}
			try
			{
				string newServerIp = string.Empty;
				AddressFamily ipType = AddressFamily.InterNetwork;
				getIPType(ip, port.ToString(), out newServerIp, out ipType);
				if (!string.IsNullOrEmpty(newServerIp))
				{
					ip = newServerIp;
				}
				c = new Socket(ipType, SocketType.Stream, ProtocolType.Tcp);
				socketID = Utils.GenID();
				c.NoDelay = true;
				IPEndPoint remoteEP = new IPEndPoint(IPAddress.Parse(ip), port);
				c.Connect(remoteEP);
				if (c.Connected)
				{
					return true;
				}
			}
			catch (Exception ex)
			{
				Debug.LogError("[Client Connect] ConnectException:" + ex);
				return false;
			}
			return true;
		}

		public bool AsycConnect(string ip, int port)
		{
			if (c != null)
			{
				Close();
			}
			try
			{
				string newServerIp = string.Empty;
				AddressFamily ipType = AddressFamily.InterNetwork;
				getIPType(ip, port.ToString(), out newServerIp, out ipType);
				if (!string.IsNullOrEmpty(newServerIp))
				{
					ip = newServerIp;
				}
				c = new Socket(ipType, SocketType.Stream, ProtocolType.Tcp);
				socketID = Utils.GenID();
				c.NoDelay = true;
				IPEndPoint end_point = new IPEndPoint(IPAddress.Parse(ip), port);
				c.BeginConnect(end_point, ConnectCallBack, c);
			}
			catch (Exception ex)
			{
				Debug.LogError("[Client AsycConnect] AsycConnectException:" + ex);
			}
			return true;
		}

		public void ConnectCallBack(IAsyncResult ir)
		{
			sendData = null;
			sendDataPos = 0;
			Array.Clear(receiveData, 0, 1048576);
			currentReceivePos = 0;
			isSend = false;
			isReceive = false;
			sendDataList = new LinkedList<Package>();
			Socket socket = (Socket)ir.AsyncState;
			try
			{
				socket.EndConnect(ir);
				StartRead();
				StartWrite();
				if (!IsNeedExchangeKey)
				{
					if (handle != null)
					{
						handle.Event(this, Event.Type.CONNECT);
					}
				}
				else if (IsNeedExchangeKey && !isExchenagedKey)
				{
					SendExchangeKey();
				}
			}
			catch (Exception ex)
			{
				Debug.LogError("[Client ConnectCallBack] ConnectCallBackException:" + ex);
				if (handle != null)
				{
					handle.Event(this, Event.Type.ERROR, System.Convert.ToInt32(NetError.NETERROR_CONNECTION));
				}
				Close();
			}
		}

		private void SendExchangeKey()
		{
			Package package = PackageFactory.CreatePackage();
			package.MessageID = CLIENT_KEY_MESSAGE_REQUEST_ID;
			Send(package);
		}

		public void Close()
		{
			lock (receiveLock)
			{
				if (c != null && c.Connected)
				{
					c.Disconnect(false);
					c.Close();
					if (handle != null)
					{
						handle.Event(this, Event.Type.CLOSE);
					}
				}
			}
		}

		private void StartRead()
		{
			lock (receiveLock)
			{
				if (!isReceive && c.Connected)
				{
					isReceive = true;
					c.BeginReceive(receiveData, currentReceivePos, receiveData.Length - currentReceivePos, SocketFlags.None, ReceiveCallBack, c);
				}
			}
		}

		public void ReceiveCallBack(IAsyncResult ir)
		{
			Socket socket = (Socket)ir.AsyncState;
			try
			{
				lock (receiveLock)
				{
					isReceive = false;
					if (!socket.Connected)
					{
						return;
					}
					int num = socket.EndReceive(ir);
					if (num != 0)
					{
						currentReceivePos += num;
						if (handle != null)
						{
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
									throw new Exception(string.Format("[Client ReceiveCallBack] error seq message {0}.", package.Header.MessageId));
								}
								package.SetKey(packageKey);
								if (!package.decode())
								{
									throw new Exception(string.Format("[Client ReceiveCallBack] client decode failed, message:{0}", package.Header.MessageId));
								}
								receiveSeqId++;
								if (package.Header.MessageId == CLIENT_KEY_MESSAGE_RESPONSE_ID)
								{
									SData sData = new SData();
									sData.UnSerializ(new MemoryStream(package.Data));
									packageKey = sData.uintValue;
									handle.Event(this, Event.Type.CONNECT);
									break;
								}
								if (package.Header.MessageId == 0 && NModuleManager.GetInstance() != null && NModuleManager.GetInstance().OnHeartReceive != null)
								{
									NModuleManager.GetInstance().OnHeartReceive();
								}
								handle.Packet(this, package);
							}
							if (num2 != 0)
							{
								Array.Copy(receiveData, num2, receiveData, 0, currentReceivePos - num2);
								currentReceivePos -= num2;
							}
						}
						StartRead();
					}
					else if (handle != null)
					{
						handle.Event(this, Event.Type.CLOSE, System.Convert.ToInt32(NetError.NETERROR_RECEIVE));
						Close();
					}
				}
			}
			catch (Exception)
			{
				if (handle != null)
				{
					handle.Event(this, Event.Type.ERROR, System.Convert.ToInt32(NetError.NETERROR_RECEIVE));
					Close();
				}
			}
		}

		private void StartWrite()
		{
			lock (sendlock)
			{
				try
				{
					if (!isSend && sendDataList.Count != 0 && c.Connected)
					{
						isSend = true;
						sendData = null;
						do
						{
							if (sendDataList.First != null)
							{
								Package value = sendDataList.First.Value;
								sendDataList.RemoveFirst();
								value.SetKey(packageKey);
								value.encode();
								sendData = value.GetBytes();
								break;
							}
						}
						while (sendDataList.Count != 0);
						sendDataPos = 0;
						if (sendData != null)
						{
							c.BeginSend(sendData, sendDataPos, sendData.Length - sendDataPos, SocketFlags.None, SendCallBack, c);
						}
					}
					int num = 123;
				}
				catch (Exception ex)
				{
					Debug.LogError("[Client StartWrite] 消息发送异常:" + ex);
					if (handle != null)
					{
						handle.Event(this, Event.Type.ERROR, System.Convert.ToInt32(NetError.NETERROR_SEND));
					}
					Close();
				}
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
					lock (sendlock)
					{
						isSend = false;
						sendData = null;
					}
					StartWrite();
				}
				else
				{
					Debug.LogError("[Client SendCallBack] 消息发送异常, bytesSend = 0");
					if (handle != null)
					{
						handle.Event(this, Event.Type.ERROR, System.Convert.ToInt32(NetError.NETERROR_SEND));
						Close();
					}
				}
			}
			catch (Exception ex)
			{
				Debug.LogError("[Client SendCallBack] 消息发送异常:" + ex);
				if (handle != null)
				{
					handle.Event(this, Event.Type.ERROR, System.Convert.ToInt32(NetError.NETERROR_SEND));
					Close();
				}
			}
		}
	}
}
