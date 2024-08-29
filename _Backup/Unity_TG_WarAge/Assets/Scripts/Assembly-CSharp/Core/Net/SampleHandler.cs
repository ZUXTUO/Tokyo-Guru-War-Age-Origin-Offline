using System;
using System.Collections.Generic;

namespace Core.Net
{
	public class SampleHandler : NetHandle
	{
		private static readonly object syncLock = new object();

		private static int HEART_MESSAGE_REQUEST_ID = 0;

		private static int HEART_MESSAGE_RESPONSE_ID = 0;

		public Action OnHeartReceive;

		private LinkedList<Package> m_reciveList = new LinkedList<Package>();

		private LinkedList<Package> m_standbyReciveList = new LinkedList<Package>();

		private LinkedList<Package> m_pendingProcessList = new LinkedList<Package>();

		private LinkedList<NModule> moduleList = new LinkedList<NModule>();

		private LinkedList<Event> m_stateEventList = new LinkedList<Event>();

		private LinkedList<Event> m_standbyStateEventList = new LinkedList<Event>();

		private LinkedList<Event> m_processingEventList = new LinkedList<Event>();

		public virtual bool Init()
		{
			return true;
		}

		private static void SwapList<T>(ref T l1, ref T l2)
		{
			T val = l1;
			l1 = l2;
			l2 = val;
		}

		public bool Event(Client c, Event.Type type, int ex)
		{
			Event value = new Event(c, type, ex);
			lock (syncLock)
			{
				m_stateEventList.AddLast(value);
			}
			return true;
		}

		public int Packet(Client c, Package p)
		{
			if (p != null)
			{
				if (p.MessageID == HEART_MESSAGE_REQUEST_ID)
				{
					p.MessageID = HEART_MESSAGE_RESPONSE_ID;
					c.Send(p);
				}
				else
				{
					p.C = c;
					lock (syncLock)
					{
						m_reciveList.AddLast(p);
					}
				}
				return p.AllSize;
			}
			return 0;
		}

		public virtual string GetMessageFuncName(int mid)
		{
			return string.Empty;
		}

		private void ProcessPackageList(LinkedList<Package> packageList)
		{
			if (packageList.Count != 0)
			{
				LinkedListNode<Package> linkedListNode;
				for (linkedListNode = packageList.First; linkedListNode != packageList.Last; linkedListNode = linkedListNode.Next)
				{
					Process(linkedListNode.Value);
				}
				linkedListNode = packageList.Last;
				Process(linkedListNode.Value);
			}
		}

		private void AddPendingProcessPackage(LinkedList<Package> packageList)
		{
			LinkedListNode<Package> first = packageList.First;
			while (first != packageList.Last)
			{
				m_pendingProcessList.AddLast(first.Value);
			}
		}

		private void ProcessEventList(LinkedList<Event> eventList)
		{
			if (eventList.Count != 0)
			{
				LinkedListNode<Event> linkedListNode = eventList.First;
				Event @event = null;
				while (linkedListNode != eventList.Last)
				{
					@event = linkedListNode.Value;
					ProcessEvent(@event.CT, @event.ST, @event.ER);
					linkedListNode = linkedListNode.Next;
				}
				linkedListNode = eventList.Last;
				@event = linkedListNode.Value;
				ProcessEvent(@event.CT, @event.ST, @event.ER);
			}
		}

		public virtual void Process()
		{
			if (m_reciveList.Count != 0 || m_pendingProcessList.Count != 0)
			{
				App3 instance = App3.GetInstance();
				if (instance.get_enable_net_dispatch() && m_pendingProcessList.Count > 0)
				{
					ProcessPackageList(m_pendingProcessList);
					m_pendingProcessList.Clear();
				}
				LinkedList<Package> linkedList = null;
				if (m_reciveList.Count > 0)
				{
					lock (syncLock)
					{
						linkedList = m_reciveList;
						SwapList(ref m_reciveList, ref m_standbyReciveList);
					}
					if (instance.get_enable_net_dispatch())
					{
						ProcessPackageList(linkedList);
						linkedList.Clear();
					}
					else
					{
						Package value;
						string messageFuncName;
						for (LinkedListNode<Package> linkedListNode = linkedList.First; linkedListNode != linkedList.Last; linkedListNode = linkedListNode.Next)
						{
							value = linkedListNode.Value;
							messageFuncName = GetMessageFuncName(value.MessageID);
							if (instance.is_net_cache_ignore_msg(messageFuncName))
							{
								Process(value);
							}
							else
							{
								m_pendingProcessList.AddLast(value);
							}
						}
						value = linkedList.Last.Value;
						messageFuncName = GetMessageFuncName(value.MessageID);
						if (instance.is_net_cache_ignore_msg(messageFuncName))
						{
							Process(value);
						}
						else
						{
							m_pendingProcessList.AddLast(value);
						}
					}
					linkedList.Clear();
				}
			}
			if (m_stateEventList.Count > 0)
			{
				LinkedList<Event> linkedList2 = null;
				lock (syncLock)
				{
					linkedList2 = m_stateEventList;
					SwapList(ref m_stateEventList, ref m_standbyStateEventList);
				}
				ProcessEventList(linkedList2);
				linkedList2.Clear();
			}
		}

		public virtual void Process(Package p)
		{
			int messageID = p.MessageID;
			foreach (NModule module in moduleList)
			{
				if (module.Startid <= messageID && messageID <= module.Endid)
				{
					module.Dispatch(p.C, p);
				}
			}
		}

		public virtual bool ProcessEvent(Client c, Event.Type p, int error)
		{
			return true;
		}

		protected bool AddModule(NModule o)
		{
			if (o == null)
			{
				return false;
			}
			foreach (NModule module in moduleList)
			{
				if (module == o)
				{
					return false;
				}
			}
			moduleList.AddLast(o);
			return true;
		}
	}
}
