using System;
using System.Collections.Generic;
using UnityEngine;

namespace YunvaIM
{
	public static class EventListenerManager
	{
		private static Dictionary<ProtocolEnum, Delegate> mProtocolEventTable = new Dictionary<ProtocolEnum, Delegate>();

		public static void AddListener(ProtocolEnum protocolEnum, Callback<object> kHandler)
		{
			lock (mProtocolEventTable)
			{
				if (!mProtocolEventTable.ContainsKey(protocolEnum))
				{
					mProtocolEventTable.Add(protocolEnum, null);
				}
				mProtocolEventTable[protocolEnum] = (Callback<object>)Delegate.Combine((Callback<object>)mProtocolEventTable[protocolEnum], kHandler);
			}
		}

		public static void RemoveListener(ProtocolEnum protocolEnum, Callback<object> kHandler)
		{
			lock (mProtocolEventTable)
			{
				if (mProtocolEventTable.ContainsKey(protocolEnum))
				{
					mProtocolEventTable[protocolEnum] = (Callback<object>)Delegate.Remove((Callback<object>)mProtocolEventTable[protocolEnum], kHandler);
					if ((object)mProtocolEventTable[protocolEnum] == null)
					{
						mProtocolEventTable.Remove(protocolEnum);
					}
				}
			}
		}

		public static void Invoke(ProtocolEnum protocolEnum, object arg1)
		{
			try
			{
				Delegate value;
				if (mProtocolEventTable.TryGetValue(protocolEnum, out value))
				{
					Callback<object> callback = (Callback<object>)value;
					if (callback != null)
					{
						callback(arg1);
					}
				}
			}
			catch (Exception exception)
			{
				Debug.LogException(exception);
			}
		}

		public static void UnInit()
		{
			mProtocolEventTable.Clear();
		}
	}
}
