using System.Collections.Generic;

namespace Core.Scene
{
	public class SceneResourceDownloadManager4
	{
		private SceneResourceDownloadAdapter4 downloadAdapter;

		private List<SceneResourceUpdate4> downloadLst = new List<SceneResourceUpdate4>();

		private SceneResourceUpdate4 currentDownload;

		private List<string> idleDownloadFiles = new List<string>();

		private string idleCurrentDownloadFile;

		public int downloadPriority = 1;

		public int idleDownloadPriority;

		private SceneResourceDownloadInterface4 downloadListener;

		public void SetAdapter(SceneResourceDownloadAdapter4 adap)
		{
			downloadAdapter = adap;
			adap.downloadManager = this;
		}

		public void SetListener(SceneResourceDownloadInterface4 downList)
		{
			downloadListener = downList;
		}

		public void SetIdleDownloadFiles(List<string> fs)
		{
			idleDownloadFiles.Clear();
			idleCurrentDownloadFile = null;
			int i = 0;
			for (int count = fs.Count; i < count; i++)
			{
				if (!ResourceManager4.FileExists(fs[i]))
				{
					idleDownloadFiles.Add(fs[i]);
					ScenePrintUtil.Log("downloadMgr idlePaths:{0}", fs[i]);
				}
			}
		}

		public void Clear()
		{
			downloadLst.Clear();
			currentDownload = null;
			idleDownloadFiles.Clear();
			idleCurrentDownloadFile = null;
		}

		public bool CheckAndAdd(string relPath, int priority, SceneResourceTaskItem4 task)
		{
			ScenePrintUtil.Log("downloadMgr CheckAndAdd path:{0}", relPath);
			if (downloadAdapter != null && relPath.Length > 0 && !ResourceManager4.FileExists(relPath))
			{
				if (!CheckAndAddToTask(relPath, priority, task))
				{
					SceneResourceUpdate4 sceneResourceUpdate = new SceneResourceUpdate4();
					sceneResourceUpdate.relPath = relPath;
					sceneResourceUpdate.items.Add(task);
					AddToDownloadLst(sceneResourceUpdate, priority);
					CheckStartDownload();
				}
				return true;
			}
			return false;
		}

		public bool Remove(string relPath, SceneResourceRequest4 req)
		{
			if (downloadAdapter != null)
			{
				int outIndex = -1;
				SceneResourceUpdate4 sceneResourceUpdate = FindUpdate(relPath, ref outIndex);
				if (sceneResourceUpdate != null)
				{
					int i = 0;
					for (int count = sceneResourceUpdate.items.Count; i < count; i++)
					{
						SceneResourceTaskItem4 sceneResourceTaskItem = sceneResourceUpdate.items[i];
						if (sceneResourceTaskItem.req.Equals(req))
						{
							sceneResourceUpdate.items.Remove(sceneResourceTaskItem);
							sceneResourceTaskItem.Clear();
							ScenePrintUtil.Log("downloadMgr Remove path: {0}, items.remaining: {1}", relPath, count - 1);
							break;
						}
					}
					if (sceneResourceUpdate.items.Count == 0)
					{
						RemoveUpdate(relPath, outIndex);
					}
					return true;
				}
			}
			return false;
		}

		public void OnDownloadFinish(string relativePath, bool isSuccess)
		{
			ScenePrintUtil.Log("downloadMgr OnDownloadFinish path:{0}, remaining:{1}", relativePath, downloadLst.Count);
			if (currentDownload != null && currentDownload.relPath.Equals(relativePath))
			{
				if (downloadListener != null)
				{
					downloadListener.OnDownloadFinish(currentDownload);
				}
				currentDownload = null;
			}
			CheckStartDownload();
			if (idleCurrentDownloadFile != null && idleCurrentDownloadFile.Equals(relativePath))
			{
				idleCurrentDownloadFile = null;
			}
			CheckIdleStartDownload();
		}

		public void CheckStartDownload()
		{
			if (downloadAdapter != null && currentDownload == null)
			{
				currentDownload = GetAndRemovePreferred();
				if (currentDownload != null)
				{
					ScenePrintUtil.Log("downloadMgr StartDownload 1");
					downloadAdapter.StartDownload(currentDownload.relPath, downloadPriority);
				}
			}
		}

		public void CheckIdleStartDownload()
		{
			if (idleDownloadFiles.Count <= 0 || downloadAdapter == null || currentDownload != null || idleCurrentDownloadFile != null)
			{
				return;
			}
			ScenePrintUtil.Log("downloadMgr CheckIdleStartDownload");
			for (int num = idleDownloadFiles.Count - 1; num >= 0; num--)
			{
				string relPath = idleDownloadFiles[num];
				idleDownloadFiles.RemoveAt(num);
				if (!ResourceManager4.FileExists(relPath))
				{
					idleCurrentDownloadFile = relPath;
					break;
				}
			}
			if (idleCurrentDownloadFile != null)
			{
				ScenePrintUtil.Log("downloadMgr StartDownload 2");
				downloadAdapter.StartDownload(idleCurrentDownloadFile, idleDownloadPriority);
			}
		}

		private bool CheckAndAddToTask(string relPath, int priority, SceneResourceTaskItem4 task)
		{
			SceneResourceUpdate4 sceneResourceUpdate = ExistInDownloadLst(relPath);
			if (sceneResourceUpdate != null)
			{
				sceneResourceUpdate.items.Add(task);
				ModifyDownloadLst(sceneResourceUpdate, priority);
				return true;
			}
			return false;
		}

		private SceneResourceUpdate4 ExistInDownloadLst(string relPath)
		{
			int i = 0;
			for (int count = downloadLst.Count; i < count; i++)
			{
				if (downloadLst[i].relPath.Equals(relPath))
				{
					return downloadLst[i];
				}
			}
			return null;
		}

		private SceneResourceUpdate4 GetAndRemovePreferred()
		{
			SceneResourceUpdate4 result = null;
			if (downloadLst.Count > 0)
			{
				int num = int.MinValue;
				int index = 0;
				int i = 1;
				for (int count = downloadLst.Count; i < count; i++)
				{
					if (downloadLst[i].priority > num)
					{
						num = downloadLst[i].priority;
						index = i;
					}
				}
				result = downloadLst[index];
				downloadLst.RemoveAt(index);
			}
			return result;
		}

		private SceneResourceUpdate4 FindUpdate(string relPath, ref int outIndex)
		{
			SceneResourceUpdate4 result = null;
			int i = 0;
			for (int count = downloadLst.Count; i < count; i++)
			{
				if (downloadLst[i].relPath.Equals(relPath))
				{
					result = downloadLst[i];
					outIndex = i;
					break;
				}
			}
			return result;
		}

		private void RemoveUpdate(string relPath, int index)
		{
			if (index > 0 && index < downloadLst.Count)
			{
				if (downloadLst[index].relPath.Equals(relPath))
				{
					downloadLst.RemoveAt(index);
					ScenePrintUtil.Log("downloadMgr RemoveUpdate path:{0}, remaining: {1}", relPath, downloadLst.Count);
				}
				return;
			}
			int i = 0;
			for (int count = downloadLst.Count; i < count; i++)
			{
				if (downloadLst[i].relPath.Equals(relPath))
				{
					downloadLst.RemoveAt(i);
					ScenePrintUtil.Log("downloadMgr RemoveUpdate2 path:{0}, remaining: {1}", relPath, downloadLst.Count);
					break;
				}
			}
		}

		private void AddToDownloadLst(SceneResourceUpdate4 up, int priority)
		{
			up.priority = priority;
			downloadLst.Add(up);
		}

		private void ModifyDownloadLst(SceneResourceUpdate4 up, int priority)
		{
			if (priority > up.priority)
			{
				up.priority = priority;
			}
		}
	}
}
