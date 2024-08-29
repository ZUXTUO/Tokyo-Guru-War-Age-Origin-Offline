using System;
using System.Collections;
using System.Collections.Generic;
using System.Runtime.InteropServices;
using System.Text;
using AOT;
using UnityEngine;

namespace YunvaIM
{
	[StructLayout(LayoutKind.Auto)]
	public class YunVaImInterface : MonoSingleton<YunVaImInterface>
	{
		public class MyQueue
		{
			private Queue<InvokeEventClass> myQueue;

			private object _lock;

			public MyQueue()
			{
				myQueue = new Queue<InvokeEventClass>();
				_lock = new object();
			}

			public void Enqueue(InvokeEventClass item)
			{
				lock (_lock)
				{
					myQueue.Enqueue(item);
				}
			}

			public bool GetData(Queue<InvokeEventClass> outQ)
			{
				lock (_lock)
				{
					int count = myQueue.Count;
					if (count == 0)
					{
						return false;
					}
					for (int i = 0; i < count; i++)
					{
						InvokeEventClass item = myQueue.Dequeue();
						outQ.Enqueue(item);
					}
					return true;
				}
			}
		}

		private YvCallBack yvCallBack;

		public static MyQueue eventQueue = new MyQueue();

		private Queue<InvokeEventClass> tmpQ = new Queue<InvokeEventClass>();

		public override void Init()
		{
			base.Init();
			if (yvCallBack == null)
			{
				yvCallBack = CallBack;
			}
			UnityEngine.Object.DontDestroyOnLoad(this);
		}

		public static uint yvpacket_get_nested_parser(uint parser)
		{
			return yvpacket_get_parser_object(parser);
		}

		public static int parser_get_integer(uint parser, int cmdId, int index = 0)
		{
			return parser_get_integer(parser, (byte)cmdId, index);
		}

		public static IntPtr parser_get_string(uint parser, int cmdId, int index = 0)
		{
			return parser_get_string(parser, (byte)cmdId, index);
		}

		public static bool parser_is_empty(uint parser, int cmdId, int index = 0)
		{
			return parser_is_empty(parser, (byte)cmdId, index);
		}

		public static void parser_get_object(uint parser, int cmdId, uint obj, int index = 0)
		{
			parser_get_object(parser, (byte)cmdId, obj, index);
		}

		public static byte parser_get_uint8(uint parser, int cmdId, int index = 0)
		{
			return parser_get_uint8(parser, (byte)cmdId, index);
		}

		public static uint parser_get_uint32(uint parser, int cmdId, int index = 0)
		{
			return (uint)parser_get_integer(parser, (byte)cmdId, index);
		}

		public int InitSDK(uint context, uint appid, string path, bool isTest, bool oversea)
		{
			return YVIM_Init(CallBack, context, appid, path, isTest, oversea);
		}

		public void ReleaseSDK()
		{
			YVIM_Release();
		}

		public int YV_SendCmd(CmdChannel type, uint cmdid, uint parser)
		{
			return YVIM_SendCmd(type, cmdid, parser);
		}

		public uint YVpacket_get_parser()
		{
			return yvpacket_get_parser();
		}

		public void YVparser_set_object(uint parser, byte cmdId, uint value)
		{
			parser_set_object(parser, cmdId, value);
		}

		public void YVparser_set_uint8(uint parser, byte cmdId, int value)
		{
			parser_set_uint8(parser, cmdId, value);
		}

		public void YVparser_set_integer(uint parser, byte cmdId, int value)
		{
			parser_set_integer(parser, cmdId, value);
		}

		public void YVparser_set_string(uint parser, byte cmdId, string value)
		{
			parser_set_string(parser, cmdId, value);
		}

		public void YVparser_set_string(uint parser, byte cmdId, IntPtr value)
		{
			parser_set_string(parser, cmdId, value);
		}

		public void YVparser_set_buffer(uint parser, byte cmdId, IntPtr value, int len)
		{
			parser_set_buffer(parser, cmdId, value, len);
		}

		[MonoPInvokeCallback(typeof(YvCallBack))]
		public static void CallBack(CmdChannel type, uint cmdid, uint parser, uint context)
		{
			ArrayList arrayList = new ArrayList();
			string text = type.ToString() + "; " + (ProtocolEnum)cmdid;
			Debug.Log("====Unity==== callback:" + text);
			YunvaMsgBase.GetMsg(cmdid, parser);
		}

		public static string IntPtrToString(IntPtr intptr, bool isVR = false)
		{
			int num = 0;
			byte b;
			do
			{
				b = Marshal.ReadByte(intptr, num);
				num++;
			}
			while (b != 0);
			byte[] array = new byte[num - 1];
			Marshal.Copy(intptr, array, 0, num - 1);
			return Encoding.UTF8.GetString(array);
		}

		private void Update()
		{
			if (eventQueue.GetData(tmpQ))
			{
				while (tmpQ.Count > 0)
				{
					InvokeEventClass invokeEventClass = tmpQ.Dequeue();
					EventListenerManager.Invoke(invokeEventClass.eventType, invokeEventClass.dataObj);
				}
			}
		}

		private void OnApplicationQuit()
		{
		}

		[DllImport("YvImSdk")]
		private static extern int YVIM_Init(YvCallBack callback, uint context, uint appid, string path, bool test, bool oversea);

		[DllImport("YvImSdk")]
		private static extern void YVIM_Release();

		[DllImport("YvImSdk")]
		private static extern int YVIM_SendCmd(CmdChannel type, uint cmdid, uint parser);

		[DllImport("YvImSdk")]
		private static extern uint yvpacket_get_parser();

		[DllImport("YvImSdk")]
		private static extern uint yvpacket_get_parser_object(uint parser);

		[DllImport("YvImSdk")]
		private static extern void parser_set_object(uint parser, byte cmdId, uint value);

		[DllImport("YvImSdk")]
		private static extern void parser_set_uint8(uint parser, byte cmdId, int value);

		[DllImport("YvImSdk")]
		private static extern void parser_set_integer(uint parser, byte cmdId, int value);

		[DllImport("YvImSdk")]
		private static extern void parser_set_string(uint parser, byte cmdId, string value);

		[DllImport("YvImSdk")]
		public static extern void parser_set_string(uint parser, byte cmdId, IntPtr value);

		[DllImport("YvImSdk")]
		private static extern void parser_set_buffer(uint parser, byte cmdId, IntPtr value, int len);

		[DllImport("YvImSdk")]
		private static extern void parser_get_object(uint parser, byte cmdId, uint obj, int index);

		[DllImport("YvImSdk")]
		private static extern byte parser_get_uint8(uint parser, byte cmdId, int index);

		[DllImport("YvImSdk")]
		private static extern int parser_get_integer(uint parser, byte cmdId, int index);

		[DllImport("YvImSdk")]
		private static extern IntPtr parser_get_string(uint parser, byte cmdId, int index);

		[DllImport("YvImSdk")]
		private static extern bool parser_is_empty(uint parser, byte cmdId, int index);
	}
}
