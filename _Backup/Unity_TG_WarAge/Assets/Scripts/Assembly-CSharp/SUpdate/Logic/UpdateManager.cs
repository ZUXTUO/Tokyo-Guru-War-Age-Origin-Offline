using System.Collections.Generic;
using System.IO;
using Core.Net;
using Core.Unity;
using Core.Util;
using SUpdate.GNet;
using SUpdate.GStruct;
using SUpdate.Handle;
using SUpdate.Interface;

namespace SUpdate.Logic
{
	public class UpdateManager
	{
		private static UpdateManager instance = new UpdateManager();

		private Dictionary<string, List<op_data>> has_dic = new Dictionary<string, List<op_data>>();

		private int down_count;

		private Update currentUpdate;

		private GroupManager[] gropList = new GroupManager[101];

		private Dictionary<string, Update> updateCache = new Dictionary<string, Update>();

		private UpdateGroup opGroup = new UpdateGroup(100);

		private Client c;

		private int deviceid = 100;

		private IUpdate CurrentCallBack;

		private List<op_data> opFileList = new List<op_data>();

		private SUpdate.Handle.NetHandle nh = new SUpdate.Handle.NetHandle();

		private bool isInit;

		public Client C
		{
			get
			{
				return c;
			}
			set
			{
				c = value;
			}
		}

		public int DeviceId
		{
			get
			{
				return deviceid;
			}
			set
			{
				deviceid = value;
			}
		}

		public IUpdate CurrentCallBackPropety
		{
			get
			{
				return CurrentCallBack;
			}
			set
			{
				CurrentCallBack = value;
			}
		}

		private UpdateManager()
		{
		}

		public static UpdateManager GetInstance()
		{
			return instance;
		}

		public void Init()
		{
			if (!isInit)
			{
				nh.Init();
				isInit = true;
			}
		}

		internal bool DeviceError(Client c, MemoryStream m_, string message, string url)
		{
			if (CurrentCallBack != null)
			{
				CurrentCallBack.DeviceError(c, message, url);
			}
			return true;
		}

		internal bool OpVersion(Client c, MemoryStream m, uint ver, uint op_count)
		{
			if (CurrentCallBack != null)
			{
				CurrentCallBack.OpVersion(opFileList, down_count);
				has_dic.Clear();
			}
			return true;
		}

		internal bool OpReturn(Client c, MemoryStream m, IList<op_data> oplst)
		{
			for (int i = 0; i < oplst.Count; i++)
			{
				op_data op_data = oplst[i];
				if (op_data.Type == 1)
				{
					if (has_dic.ContainsKey(op_data.Path))
					{
						List<op_data> list = has_dic[op_data.Path];
						list[list.Count - 1].Type = 2;
					}
					else
					{
						has_dic[op_data.Path] = new List<op_data>();
						down_count++;
					}
					has_dic[op_data.Path].Add(op_data);
				}
				opFileList.Add(op_data);
			}
			return true;
		}

		private Update Find(string filepath)
		{
			if (filepath != null && updateCache.ContainsKey(filepath))
			{
				return updateCache[filepath];
			}
			return null;
		}

		internal bool FileStart(Client c, MemoryStream m, string md5code, uint file_size, uint fid)
		{
			if (currentUpdate != null && currentUpdate.Md5code.CompareTo(md5code) == 0)
			{
				return currentUpdate.FileStart(md5code, file_size, fid);
			}
			return false;
		}

		internal bool FileData(Client c, MemoryStream m, uint fid, uint pos, uint size, byte[] data)
		{
			if (currentUpdate != null && currentUpdate.Fid == fid)
			{
				bool flag = currentUpdate.FileData(pos, size, data);
				if (flag)
				{
					CurrentCallBack.DownProcess(currentUpdate);
					List<UpdateGroup> groupList = currentUpdate.GroupList;
					for (int i = 0; i < groupList.Count; i++)
					{
						CurrentCallBack.DownProcess(groupList[i], currentUpdate);
					}
				}
				return flag;
			}
			return false;
		}

		internal bool FileComplete(Client c, MemoryStream m, string md5code, uint file_id, int result)
		{
			if (currentUpdate != null && currentUpdate.Fid == file_id)
			{
				if (currentUpdate != null)
				{
					RemoveUpdate(currentUpdate.Path);
				}
				bool result2 = currentUpdate.FileComplete(md5code, file_id, result);
				currentUpdate = null;
				NextRequest();
				return result2;
			}
			uint num = 0u;
			if (currentUpdate != null)
			{
				num = currentUpdate.Fid;
				string path = currentUpdate.Path;
				string md5code2 = currentUpdate.Md5code;
			}
			else
			{
				Debug.LogError("fileserver发生错误,服务器和数据库数据不对应!");
			}
			NextRequest();
			return false;
		}

		private void NextRequest()
		{
			if (currentUpdate != null)
			{
				currentUpdate.StopFile();
			}
			if (opGroup != null)
			{
				currentUpdate = opGroup.NextRequest(c, (uint)deviceid);
				if (currentUpdate != null)
				{
					return;
				}
				currentUpdate = null;
			}
			for (int num = 100; num >= 0; num--)
			{
				if (gropList[num] != null)
				{
					currentUpdate = gropList[num].NextRequest(c, (uint)deviceid);
					if (currentUpdate != null)
					{
						break;
					}
					currentUpdate = null;
				}
			}
		}

		public void CheckOp(int operid, int verid)
		{
			if (c != null)
			{
				opFileList.Clear();
				NUpdate.check_op(c, (uint)deviceid, (uint)operid, (uint)verid);
			}
		}

		internal void Error(Client c, int errortype)
		{
			if (CurrentCallBack != null)
			{
				CurrentCallBack.Error(c, errortype);
			}
		}

		internal void Close(Client c)
		{
			if (CurrentCallBack != null)
			{
				CurrentCallBack.Close(c);
			}
		}

		internal void Connection(Client c)
		{
			if (CurrentCallBack != null)
			{
				CurrentCallBack.Connection(c);
			}
			NextRequest();
		}

		public void AddDown(string filepath, string processScript, string finishScript, int priority)
		{
			List<string> list = new List<string>();
			list.Add(filepath);
			List<string> fileList = list;
			AddDownGroup(fileList, processScript, finishScript, priority);
		}

		private void AddUpdate(string filepath, Update un)
		{
			if (un != null && filepath.Length != 0)
			{
				updateCache.Add(filepath, un);
			}
		}

		public void RemoveUpdate(string filepath)
		{
			if (updateCache.ContainsKey(filepath))
			{
				updateCache.Remove(filepath);
			}
		}

		public void AsycConnection(string ip, int port)
		{
			if (c == null)
			{
				c = NetManager.GetInstance().CreateClient(nh);
			}
			c.AsycConnect(ip, port);
		}

		public void CloseConnection()
		{
			if (c != null)
			{
				c.Close();
			}
		}

		public void update()
		{
			nh.Process();
		}

		public void AddDownGroup(List<string> fileList, string processScript, string finishScript, int priority)
		{
			if (priority > 100)
			{
				priority = 100;
			}
			if (priority < 0)
			{
				priority = 0;
			}
			GroupManager groupManager = null;
			if (gropList[priority] == null)
			{
				groupManager = (gropList[priority] = new GroupManager(priority));
			}
			UpdateGroup updateGroup = new UpdateGroup(priority);
			updateGroup.AddCallBack(processScript, finishScript);
			for (int i = 0; i < fileList.Count; i++)
			{
				AddDown(updateGroup, fileList[i], priority);
			}
			gropList[priority].Add(updateGroup);
			if (currentUpdate == null || currentUpdate.Priority < priority)
			{
				NextRequest();
			}
		}

		private void AddDown(UpdateGroup ug, string filePath, int priority)
		{
			if (Core.Util.Utils.StringContainUpper(filePath))
			{
				Debug.LogWarning("请求下载的路径中有大写:" + filePath);
			}
			if (ug != null)
			{
				Update update = Find(filePath);
				if (update == null)
				{
					update = Update.Create(filePath, priority);
					AddUpdate(filePath, update);
				}
				update.AddUpdateGroup(ug);
				ug.Add(update);
			}
		}

		internal void UpdateComplete(Update update)
		{
			if (update != null && CurrentCallBack != null)
			{
				CurrentCallBack.DownFinish(update);
			}
		}

		internal void DownFinish(UpdateGroup updateGroup, Update update, int result)
		{
			if (update != null && updateGroup != null && CurrentCallBack != null)
			{
				CurrentCallBack.DownFinish(updateGroup, update, result);
			}
		}
	}
}
