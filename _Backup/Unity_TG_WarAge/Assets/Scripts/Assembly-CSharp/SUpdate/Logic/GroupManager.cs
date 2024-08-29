using System.Collections.Generic;
using Core.Net;

namespace SUpdate.Logic
{
	public class GroupManager
	{
		private int priority;

		private List<UpdateGroup> updateGroupList = new List<UpdateGroup>();

		public GroupManager(int p)
		{
			priority = p;
		}

		public void Add(UpdateGroup ug)
		{
			if (ug != null)
			{
				if (updateGroupList.Contains(ug))
				{
					updateGroupList.Remove(ug);
				}
				updateGroupList.Add(ug);
			}
		}

		public Update NextRequest(Client c, uint deviceid)
		{
			if (updateGroupList.Count != 0)
			{
				do
				{
					Update update = updateGroupList[0].NextRequest(c, deviceid);
					if (update == null)
					{
						updateGroupList.RemoveAt(0);
						continue;
					}
					return update;
				}
				while (updateGroupList.Count != 0);
			}
			return null;
		}

		public bool Exit(UpdateGroup up)
		{
			if (up != null && updateGroupList.Contains(up))
			{
				updateGroupList.Remove(up);
			}
			return true;
		}
	}
}
