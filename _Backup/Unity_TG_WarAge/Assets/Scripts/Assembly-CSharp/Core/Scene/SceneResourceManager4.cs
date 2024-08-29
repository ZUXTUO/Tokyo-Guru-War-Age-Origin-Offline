using System;
using System.Collections;
using System.Collections.Generic;
using UnityEngine;

namespace Core.Scene
{
	public class SceneResourceManager4 : MonoBehaviour, SceneResourceDownloadInterface4
	{
		private List<SceneResourceUpdate4> cacheUpdateLst = new List<SceneResourceUpdate4>();

		private Dictionary<string, SceneResourceUpdate4> cacheUpdateMap = new Dictionary<string, SceneResourceUpdate4>();

		public SceneResourceDownloadManager4 downloadMgr = new SceneResourceDownloadManager4();

		private Dictionary<string, SceneAssetBundle> loadedCacheMap = new Dictionary<string, SceneAssetBundle>();

		private bool taskRunning;

		public int maxPriority = int.MaxValue;

		public int minPriority;

		private long lastAddTaskTicks = long.MaxValue;

		private long MaxWaitTick = 10000000L;

		public SceneResourceTasksComplete OnTasksComplete;

		public SceneResourceTasksProgress OnTasksProgress;

		private static float testUseTime;

		private static SceneResourceManager4 _instance;

		private void Start()
		{
			downloadMgr.SetListener(this);
		}

		public void Clear()
		{
			ScenePrintUtil.Log("SceneResourceManager4.Clear");
			foreach (KeyValuePair<string, SceneAssetBundle> item in loadedCacheMap)
			{
				SceneAssetBundle value = item.Value;
				ScenePrintUtil.Log("clear update, mainasset:{0} refCount:{1} name:{2}", value.mainAsset.GetInstanceID(), value.refCount, value.mainAsset.name);
				value.Unload(true);
			}
			ScenePrintUtil.Log("lst:{0} map:{1} loaded:{2}", cacheUpdateLst.Count, cacheUpdateMap.Count, loadedCacheMap.Count);
			OnTasksComplete = null;
			OnTasksProgress = null;
			lastAddTaskTicks = long.MaxValue;
			loadedCacheMap.Clear();
			cacheUpdateLst.Clear();
			cacheUpdateMap.Clear();
			if (downloadMgr != null)
			{
				downloadMgr.Clear();
			}
		}

		public SceneResourceRequest4 AddLoadTask(string[] relPaths, int priority, SceneResourceCallback4 callbackO, SceneResourceCallbackData4 data = null)
		{
			if (relPaths == null || relPaths.Length == 0)
			{
				return null;
			}
			lastAddTaskTicks = DateTime.Now.Ticks;
			downloadMgr.CheckIdleStartDownload();
			UseTime useTime = new UseTime();
			bool flag = false;
			SceneResourceRequest4 sceneResourceRequest = new SceneResourceRequest4(relPaths);
			SceneResourceTaskItem4 sceneResourceTaskItem = new SceneResourceTaskItem4(sceneResourceRequest, callbackO, data);
			useTime.PrintStep(" mgr create load task 1");
			int i = 0;
			for (int num = sceneResourceRequest.relPaths.Length; i < num; i++)
			{
				UseTime useTime2 = new UseTime();
				UseTime useTime3 = new UseTime();
				string text = sceneResourceRequest.relPaths[i];
				SceneResourceUpdate4 sceneResourceUpdate = FindUpdate(text);
				if (sceneResourceUpdate != null || downloadMgr == null || !downloadMgr.CheckAndAdd(text, priority, sceneResourceTaskItem))
				{
					useTime3.PrintStep(" load task 1");
					if (sceneResourceUpdate == null)
					{
						ScenePrintUtil.Log("create new update4 path: " + text);
						sceneResourceUpdate = new SceneResourceUpdate4();
						sceneResourceUpdate.relPath = text;
						useTime3.PrintStep(" load task 2");
						AddToCache(sceneResourceUpdate, priority);
						useTime3.PrintStep(" load task 3");
					}
					else
					{
						ScenePrintUtil.Log("modify cache idx by priority. path: " + text);
						ModifyCacheIndex(sceneResourceUpdate, priority);
					}
					ScenePrintUtil.Log("create new task end, path:{0}", text);
					sceneResourceUpdate.items.Add(sceneResourceTaskItem);
					flag = true;
					useTime2.PrintStep("for end");
				}
			}
			useTime.PrintStep(" mgr create load task 8");
			if (flag)
			{
				CheckAndRunLoadUpdate();
			}
			useTime.PrintStep(" mgr create load task 9");
			return sceneResourceRequest;
		}

		public bool RemoveLoadTask(SceneResourceRequest4 req)
		{
			UseTime useTime = new UseTime();
			if (req != null)
			{
				int i = 0;
				for (int num = req.relPaths.Length; i < num; i++)
				{
					string text = req.relPaths[i];
					if (cacheUpdateMap.ContainsKey(text))
					{
						SceneResourceUpdate4 sceneResourceUpdate = cacheUpdateMap[text];
						int j = 0;
						for (int count = sceneResourceUpdate.items.Count; j < count; j++)
						{
							SceneResourceTaskItem4 sceneResourceTaskItem = sceneResourceUpdate.items[j];
							if (sceneResourceTaskItem.req.Equals(req))
							{
								sceneResourceUpdate.items.Remove(sceneResourceTaskItem);
								sceneResourceTaskItem.Clear();
								ScenePrintUtil.Log("remove load task item, path: {0}, items.remaining: {1}", text, count - 1);
								break;
							}
						}
						if (sceneResourceUpdate.items.Count == 0)
						{
							RemoveFromCache(sceneResourceUpdate, text, -1);
							ScenePrintUtil.Log("remove load task, path: {0}, update.remaining: {1}", text, cacheUpdateLst.Count);
						}
					}
					else
					{
						downloadMgr.Remove(text, req);
					}
				}
				useTime.PrintStep("remove load task");
				return true;
			}
			return false;
		}

		public void OnDownloadFinish(SceneResourceUpdate4 resUpdate)
		{
			ScenePrintUtil.Log(" sceneResourceManager.OnDownloadFinish: " + resUpdate.relPath);
			AddToCache(resUpdate, resUpdate.priority);
			CheckAndRunLoadUpdate();
		}

		public void AddToRemove(SceneAssetBundle ab)
		{
			int num = ab.assetPath.LastIndexOf("/");
			string key = ab.assetPath.Substring((num != -1) ? num : 0);
			if (ab != null && loadedCacheMap.ContainsKey(key))
			{
				ScenePrintUtil.Log(" sceneResourceManager.remove: " + ab.assetPath);
				loadedCacheMap.Remove(key);
				ab.Unload(true);
			}
		}

		public void RemoveFromRemove(SceneAssetBundle ab)
		{
		}

		private void AddToCache(SceneResourceUpdate4 up, int priority)
		{
			if (!cacheUpdateMap.ContainsKey(up.relPath))
			{
				cacheUpdateMap.Add(up.relPath, up);
			}
			int num = 0;
			int num2 = up.relPath.LastIndexOf("/");
			string key = up.relPath.Substring((num2 != -1) ? num2 : 0);
			if (loadedCacheMap.ContainsKey(key))
			{
				up.priority = maxPriority;
				num = 0;
			}
			else
			{
				up.priority = priority;
				num = FindInsertIndexByPriority(priority);
			}
			cacheUpdateLst.Insert(num, up);
			ScenePrintUtil.Log("add to cache(insert:{0}) count:{1}.", num, cacheUpdateLst.Count);
		}

		private void ModifyCacheIndex(SceneResourceUpdate4 up, int priority)
		{
			if (priority > up.priority)
			{
				int num = cacheUpdateLst.LastIndexOf(up);
				cacheUpdateLst.RemoveAt(num);
				int num2 = FindInsertIndexByPriority(priority);
				cacheUpdateLst.Insert(num2, up);
				ScenePrintUtil.Log("real modify index by priority: oldIdx:{0} newIdx:{1}. oldPri:{2}, newPri:{3}", num, num2, up.priority, priority);
				up.priority = priority;
			}
		}

		private int FindInsertIndexByPriority(int pri)
		{
			int result = cacheUpdateLst.Count;
			int num = cacheUpdateLst.Count - 1;
			while (num >= 0 && cacheUpdateLst[num].priority < pri)
			{
				result = num;
				num--;
			}
			return result;
		}

		private bool RemoveFromCache(SceneResourceUpdate4 up, string relPath, int idx)
		{
			cacheUpdateMap.Remove(relPath);
			if (idx >= 0)
			{
				cacheUpdateLst.RemoveAt(idx);
			}
			else
			{
				cacheUpdateLst.Remove(up);
			}
			return true;
		}

		private SceneResourceUpdate4 FindUpdate(string relativePath)
		{
			if (relativePath != null && cacheUpdateMap.ContainsKey(relativePath))
			{
				return cacheUpdateMap[relativePath];
			}
			return null;
		}

		private void CheckAndRunLoadUpdate()
		{
			if (!taskRunning && cacheUpdateLst.Count > 0)
			{
				StartCoroutine(LoadUpdate());
			}
		}

		private void Update()
		{
			if (OnTasksComplete != null && DateTime.Now.Ticks - lastAddTaskTicks > MaxWaitTick && cacheUpdateLst.Count == 0 && OnTasksComplete != null)
			{
				OnTasksComplete();
			}
		}

		private IEnumerator LoadUpdate()
		{
			taskRunning = true;
			while (cacheUpdateLst.Count > 0)
			{
				ScenePrintUtil.Log(" SceneResourceManager4.LoadUpdate--------. count:{0}", cacheUpdateLst.Count);
				SceneResourceUpdate4 curTask = cacheUpdateLst[0];
				SceneAssetBundle assetBundle = null;
				string relPath = curTask.relPath;
				ScenePrintUtil.Log("load update path : " + ((relPath == null && relPath.Length != 0) ? "null" : relPath) + ", remaining count: " + cacheUpdateLst.Count);
				bool checkTaskEq = false;
				int taskAtIndex = -1;
				int nameKeyIdx = relPath.LastIndexOf("/");
				string nameKey = relPath.Substring((nameKeyIdx != -1) ? nameKeyIdx : 0);
				if (loadedCacheMap.ContainsKey(nameKey))
				{
					assetBundle = loadedCacheMap[nameKey];
					ScenePrintUtil.Log("assetbundle get from cachemap: {0}, key:{1}", assetBundle, nameKey);
				}
				else if (ResourceManager4.FileExists(relPath))
				{
					long t0 = DateTime.Now.Ticks;
					ScenePrintUtil.Log(" start new www, path:{0}", relPath);
					WWW localWWW = new WWW(ResourceManager4.GetWWWPath(relPath));
					ScenePrintUtil.Log(" start new www2, path:{0}", relPath);
					yield return localWWW;
					ScenePrintUtil.Log(" start new www3, path:{0}", relPath);
					if (localWWW.error == null)
					{
						AssetBundle assetBundle2 = localWWW.assetBundle;
						int num = relPath.LastIndexOf("/");
						int num2 = relPath.LastIndexOf(".");
						string text = relPath.Substring(num + 1, num2 - num - 1);
						checkTaskEq = true;
						taskAtIndex = ((cacheUpdateLst.Count <= 0) ? (-1) : cacheUpdateLst.IndexOf(curTask));
						bool flag = loadedCacheMap.ContainsKey(nameKey);
						ScenePrintUtil.Log("assetname:{0}, namekey:{1}, isexist:{2}, taskatindex:{3}", text, nameKey, flag, taskAtIndex);
						if (taskAtIndex != -1 && !flag)
						{
							assetBundle = new SceneAssetBundle(relPath, assetBundle2, assetBundle2.mainAsset);
							loadedCacheMap.Add(nameKey, assetBundle);
							ScenePrintUtil.Log("assetbundle add to cachemap: {0}, namekey:{1}", assetBundle, nameKey);
							testUseTime += (float)(DateTime.Now.Ticks - t0) / 10000f;
							ScenePrintUtil.Log("loadedCacheMap.Count:{0}, use time: {1}, totalUseTime:{2}", loadedCacheMap.Count, (float)(DateTime.Now.Ticks - t0) / 10000f, testUseTime);
						}
						else
						{
							ScenePrintUtil.Log("destroy 0:{0} 1:{1} 2:{2} ", relPath, taskAtIndex, !flag);
							assetBundle2.Unload(true);
						}
					}
					else
					{
						ScenePrintUtil.Log("[error]: " + localWWW.error);
					}
				}
				else
				{
					ScenePrintUtil.Log("update file not exist: {0}", relPath);
				}
				if (!checkTaskEq)
				{
					checkTaskEq = true;
					taskAtIndex = ((cacheUpdateLst.Count <= 0) ? (-1) : cacheUpdateLst.IndexOf(curTask));
				}
				ScenePrintUtil.Log("load update path:{0}, remaining:{1}, taskExist:{2}, currAssetBundle:{3}", (relPath == null && relPath.Length != 0) ? "null" : relPath, cacheUpdateLst.Count, taskAtIndex, assetBundle);
				ScenePrintUtil.Log("info {0} width:{1}", (assetBundle != null) ? assetBundle.mainAsset.GetInstanceID() : 0, (assetBundle != null) ? (assetBundle.mainAsset as Texture).width : (-1));
				if (checkTaskEq && taskAtIndex != -1)
				{
					ScenePrintUtil.Log("load update remove at 0");
					RemoveFromCache(curTask, relPath, taskAtIndex);
					int i = 0;
					for (int count = curTask.items.Count; i < count; i++)
					{
						ScenePrintUtil.Log("for task.items " + i + " / " + curTask.items.Count);
						SceneResourceTaskItem4 sceneResourceTaskItem = curTask.items[i];
						if (sceneResourceTaskItem == null || sceneResourceTaskItem.callbackObj == null)
						{
							continue;
						}
						if (sceneResourceTaskItem.unfinishPaths != null)
						{
							int num3 = SceneUtil4.IndexOf(sceneResourceTaskItem.sourcePaths, relPath);
							if (num3 == -1)
							{
								ScenePrintUtil.Log("[error]: task.sourcePaths.FindIndex failed: curRelPath: " + relPath);
								int j = 0;
								for (int num4 = sceneResourceTaskItem.sourcePaths.Length; j < num4; j++)
								{
									ScenePrintUtil.Log("    -> task.sourcePaths: " + ((sceneResourceTaskItem.sourcePaths[j] == null) ? "null" : sceneResourceTaskItem.sourcePaths[j]));
								}
							}
							else
							{
								sceneResourceTaskItem.unfinishPaths.Remove(relPath);
								sceneResourceTaskItem.SetFinishBundles(num3, assetBundle);
							}
						}
						ScenePrintUtil.Log("check callback, remaining: " + ((sceneResourceTaskItem.unfinishPaths == null) ? (-1) : sceneResourceTaskItem.unfinishPaths.Count));
						if (sceneResourceTaskItem.unfinishPaths != null && sceneResourceTaskItem.unfinishPaths.Count == 0)
						{
							ScenePrintUtil.Log("callback");
							UseTime useTime = new UseTime();
							sceneResourceTaskItem.callbackObj.OnLoaded(sceneResourceTaskItem.finishBundles, sceneResourceTaskItem.data);
							useTime.PrintStep("callback");
						}
					}
					if (OnTasksProgress != null)
					{
						OnTasksProgress((float)loadedCacheMap.Count * 1f / (float)(loadedCacheMap.Count + cacheUpdateLst.Count));
					}
					if (cacheUpdateLst.Count == 0 && OnTasksComplete != null)
					{
						OnTasksComplete();
					}
				}
				ScenePrintUtil.Log("load update complete item remaining: " + cacheUpdateLst.Count);
				yield return 0;
			}
			taskRunning = false;
			ScenePrintUtil.Log("load update end");
			CheckAndRunLoadUpdate();
		}

		public static void Init(GameObject go)
		{
			if (_instance == null && go != null)
			{
				_instance = go.AddComponent<SceneResourceManager4>();
				UnityEngine.Object.DontDestroyOnLoad(go);
			}
		}

		public static SceneResourceManager4 GetInstance()
		{
			return _instance;
		}
	}
}
