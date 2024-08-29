using System.Collections.Generic;
using Core.Net;

namespace SUpdate.Logic
{
	public class UpdateGroup
	{
		private List<Update> UpdateList = new List<Update>();

		private GroupManager groupManager;

		private Update.ScriptCallBack callback = new Update.ScriptCallBack();

		private int priority;

		private int finishCount;

		private int errorCount;

		public Update.ScriptCallBack Callback
		{
			get
			{
				return callback;
			}
			set
			{
				callback = value;
			}
		}

		public int FinishCount
		{
			get
			{
				return finishCount;
			}
			set
			{
				finishCount = value;
			}
		}

		public int ErrorCount
		{
			get
			{
				return errorCount;
			}
			set
			{
				errorCount = value;
			}
		}

		public int AllCount
		{
			get
			{
				return UpdateList.Count;
			}
		}

		public UpdateGroup(int p)
		{
			priority = p;
		}

		public UpdateGroup(int p, GroupManager g)
		{
			priority = p;
			groupManager = g;
		}

		internal void Add(Update au)
		{
			if (au != null)
			{
				au.AddUpdateGroup(this);
				if (UpdateList.Contains(au))
				{
					UpdateList.Remove(au);
				}
				UpdateList.Add(au);
				if (UpdateList.Count == 1 && groupManager != null)
				{
					groupManager.Add(this);
				}
			}
		}

		internal Update NextRequest(Client c, uint deviceid)
		{
			if (UpdateList.Count != 0)
			{
				for (int i = 0; i < UpdateList.Count; i++)
				{
					Update update = UpdateList[i];
					if (!update.IsDownFile && !update.HasDown && update.RequestStart(c, deviceid))
					{
						return update;
					}
				}
			}
			return null;
		}

		internal void ExitUpate(Update update)
		{
			if (UpdateList.Contains(update))
			{
				UpdateList.Remove(update);
			}
			if (UpdateList.Count == 0 && groupManager != null)
			{
				groupManager.Exit(this);
			}
		}

		internal void AddCallBack(string processScript, string finishScript)
		{
			if (processScript != null)
			{
				callback.ProcessScript = processScript;
			}
			if (finishScript != null)
			{
				callback.FinishScript = finishScript;
			}
		}

		internal void Finish(Update update, int result)
		{
			bool flag = false;
			for (int i = 0; i < UpdateList.Count; i++)
			{
				Update update2 = UpdateList[i];
				if (update2 == update)
				{
					flag = true;
					finishCount++;
					if (result != 0)
					{
						errorCount++;
					}
					break;
				}
			}
			if (flag)
			{
				UpdateManager.GetInstance().DownFinish(this, update, result);
				UpdateList.Remove(update);
			}
		}
	}
}
