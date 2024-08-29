using System.Collections.Generic;
using System.IO;
using Core.Net;
using Core.Resource;
using Core.Unity;
using SUpdate.GNet;

namespace SUpdate.Logic
{
	public class Update
	{
		public class ScriptCallBack
		{
			private string processScript = string.Empty;

			private string finishScript = string.Empty;

			public string ProcessScript
			{
				get
				{
					return processScript;
				}
				set
				{
					processScript = value;
				}
			}

			public string FinishScript
			{
				get
				{
					return finishScript;
				}
				set
				{
					finishScript = value;
				}
			}
		}

		protected uint fid;

		protected uint fsize;

		protected string path = string.Empty;

		protected string md5code = string.Empty;

		protected uint current_pos;

		protected int priority;

		protected MemoryStream ms;

		protected int downTimes;

		protected int MaxDownTimes = 5;

		private int result;

		private bool isDownFile;

		private bool hasDown;

		private List<ScriptCallBack> callback = new List<ScriptCallBack>();

		private List<UpdateGroup> groupList = new List<UpdateGroup>();

		public uint Fid
		{
			get
			{
				return fid;
			}
			set
			{
				fid = value;
			}
		}

		public uint Fsize
		{
			get
			{
				return fsize;
			}
			set
			{
				fsize = value;
			}
		}

		public string Path
		{
			get
			{
				return path;
			}
			set
			{
				path = value;
			}
		}

		public string Md5code
		{
			get
			{
				return md5code;
			}
			set
			{
				md5code = value;
			}
		}

		public uint Current_pos
		{
			get
			{
				return current_pos;
			}
			set
			{
				current_pos = value;
			}
		}

		public int Priority
		{
			get
			{
				return priority;
			}
			set
			{
				priority = value;
			}
		}

		public int Result
		{
			get
			{
				return result;
			}
			set
			{
				result = value;
			}
		}

		public bool IsDownFile
		{
			get
			{
				return isDownFile;
			}
			set
			{
				isDownFile = value;
			}
		}

		public bool HasDown
		{
			get
			{
				return hasDown;
			}
			set
			{
				hasDown = value;
			}
		}

		public List<UpdateGroup> GroupList
		{
			get
			{
				return groupList;
			}
			set
			{
				groupList = value;
			}
		}

		public List<ScriptCallBack> Callback
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

		internal static Update Create(string filepath, int priority)
		{
			if (filepath != null)
			{
				Update update = new Update();
				update.path = filepath;
				update.priority = priority;
				update.md5code = Utils.Md5(filepath);
				return update;
			}
			return null;
		}

		internal bool FileData(uint pos, uint size, byte[] data)
		{
			if (ms == null)
			{
				return false;
			}
			if (current_pos != pos)
			{
				return false;
			}
			ms.Write(data, 0, data.Length);
			current_pos += (uint)data.Length;
			return true;
		}

		internal bool FileComplete(string md5code, uint file_id, int result)
		{
			if (file_id == fid && md5code == this.md5code)
			{
				isDownFile = false;
				hasDown = true;
				this.result = result;
				bool flag = PreProcess();
				if (result != 0 || ms.Length != fsize || !flag)
				{
					for (int i = 0; i < groupList.Count; i++)
					{
						groupList[i].Finish(this, result);
					}
					UpdateManager.GetInstance().UpdateComplete(this);
					groupList.Clear();
					return false;
				}
				SaveFile();
				for (int j = 0; j < groupList.Count; j++)
				{
					groupList[j].Finish(this, result);
				}
				UpdateManager.GetInstance().UpdateComplete(this);
				groupList.Clear();
			}
			return true;
		}

		private bool PreProcess()
		{
			if (ms != null)
			{
				ms.Seek(0L, SeekOrigin.Begin);
				FileHeader fileHeader = new FileHeader();
				if (fileHeader.Unserial(ms) && ms.Length - ms.Position == fileHeader.File_size)
				{
					if (fileHeader.Compress_type == 2)
					{
						MemoryStream memoryStream = new MemoryStream();
						return true;
					}
					if (fileHeader.Compress_type != 1 && fileHeader.Compress_type != 4)
					{
						return true;
					}
				}
			}
			return false;
		}

		private void SaveFile()
		{
			if (ms != null)
			{
				FileUtil.Save(ms, path);
			}
		}

		internal bool FileStart(string md5code, uint file_size, uint fid)
		{
			if (md5code == this.md5code)
			{
				if (ms == null)
				{
					ms = new MemoryStream();
					current_pos = 0u;
				}
				fsize = file_size;
				this.fid = fid;
				return true;
			}
			return false;
		}

		internal static void Remove(string path)
		{
			FileUtil.Fremove(path);
		}

		internal bool RequestStart(Client c, uint deviceid)
		{
			if (!isDownFile && !hasDown)
			{
				isDownFile = true;
				Debug.LogWarning("RequestStart 发起请求下载:" + Path);
				return NUpdate.request(c, md5code, deviceid, current_pos);
			}
			return false;
		}

		internal void StopFile()
		{
			isDownFile = false;
		}

		internal void AddCallBack(string processScript, string finishScript)
		{
			bool flag = false;
			for (int i = 0; i < callback.Count; i++)
			{
				ScriptCallBack scriptCallBack = callback[i];
				if (scriptCallBack.ProcessScript.CompareTo(processScript) == 0 && scriptCallBack.FinishScript.CompareTo(finishScript) == 0)
				{
					flag = true;
					break;
				}
			}
			if (!flag)
			{
				ScriptCallBack scriptCallBack2 = new ScriptCallBack();
				scriptCallBack2.ProcessScript = processScript;
				scriptCallBack2.FinishScript = finishScript;
				callback.Add(scriptCallBack2);
			}
		}

		internal void AddUpdateGroup(UpdateGroup ug)
		{
			if (ug != null)
			{
				if (groupList.Contains(ug))
				{
					groupList.Remove(ug);
				}
				groupList.Add(ug);
			}
		}
	}
}
