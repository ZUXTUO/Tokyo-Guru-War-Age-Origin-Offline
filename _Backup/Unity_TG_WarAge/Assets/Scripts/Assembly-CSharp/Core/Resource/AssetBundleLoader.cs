using System.Collections;
using System.Collections.Generic;
using System.Diagnostics;
using System.IO;
using System.Text;
using System.Text.RegularExpressions;
using System.Threading;
using Core.Unity;
using UnityEngine;
using UnityWrap;

namespace Core.Resource
{
	public class AssetBundleLoader : MonoBehaviourEx
	{
		private enum EAssetUncompressState
		{
			waitting = 0,
			working = 1,
			succ = 2,
			failed = 3
		}

		private class AssetUncompressTask
		{
			public EAssetUncompressState assetUnCompressState;

			public string fileName;

			public Thread workerThread;

			public int workerThreadId;

			public int unComressCode;
		}

		private class UncompressWorker
		{
			public bool quitFlag;

			public Thread thread;

			public bool working;
		}

		public class SharedAtlasInfo
		{
			public int refCount;

			public string path;

			public Object[] allObj;

			public AssetBundle ab;

			public void addRef()
			{
				refCount++;
			}

			public void delRef()
			{
				refCount--;
				if (refCount <= 0 && ab != null)
				{
					ab.Unload(false);
					if (GetInstance().sharedAtlasDic.ContainsKey(path))
					{
						GetInstance().sharedAtlasDic.Remove(path);
					}
				}
			}
		}

		private static int m_maxTaskCnt = 3;

		public static bool m_showLoadLog;

		public static bool m_enable3rdpartyCompression;

		public static bool m_enalbeSharedAtlasLoad;

		public static bool m_syncLoadUseTimeLimit = true;

		public static int m_maxLoadNumPerFrame = 8;

		public static float m_syncLoadContinueTime = 500f;

		public static bool m_useSyncLoad;

		public static bool m_useAsyncLoad = true;

		private static bool m_3rdpartyCompressionInitFlag;

		private static AssetBundleLoader m_instance;

		private static string m_go_name = "_AssertBundleLoader";

		private Queue<AssetBundleRequest> m_waitingQueue = new Queue<AssetBundleRequest>();

		private Queue<AssetBundleRequest> m_loadingQueue = new Queue<AssetBundleRequest>();

		private Dictionary<string, AssetBundleRequest> m_allTask = new Dictionary<string, AssetBundleRequest>();

		private readonly object m_UncompressOPLock = new object();

		private int m_defaultUncompressThreadCnt = 4;

		private List<UncompressWorker> m_UnCompressThreadList = new List<UncompressWorker>();

		private LinkedList<AssetUncompressTask> m_uncompressTaskList = new LinkedList<AssetUncompressTask>();

		private UncompressWorker m_OutterUncompressWorker = new UncompressWorker();

		private Dictionary<string, AssetUncompressTask> m_OutterThreadUncompressTaskList = new Dictionary<string, AssetUncompressTask>();

		public Dictionary<string, string> filePathToDepDic = new Dictionary<string, string>();

		public Dictionary<string, SharedAtlasInfo> sharedAtlasDic = new Dictionary<string, SharedAtlasInfo>();

		public Dictionary<string, string[]> depDic = new Dictionary<string, string[]>();

		public Dictionary<int, string[]> gameInsRefToSharedAtlas = new Dictionary<int, string[]>();

		private Dictionary<string, AssertLoadCallback> m_allSyncTask = new Dictionary<string, AssertLoadCallback>();

		private Queue<string> m_syncWaitingQueue = new Queue<string>();

		private Queue<string> m_syncLoadingQueue = new Queue<string>();

		public static AssetBundleLoader GetInstance()
		{
			if (m_instance == null)
			{
				GameObject gameObject = MonoBehaviourEx.CreateGameObject(m_go_name);
				m_instance = gameObject.AddComponent<AssetBundleLoader>();
				m_instance.Init();
			}
			return m_instance;
		}

		public void ShowLoadLog(bool show)
		{
			m_showLoadLog = show;
			UnzipAssetFileOut.Instance().showLog(show);
		}

		public void Enable3rdpartyCompression(bool enable)
		{
			if (!m_enable3rdpartyCompression)
			{
				m_enable3rdpartyCompression = enable;
				Init3rdpartyCompression();
			}
		}

		public void EnableSharedAtlasLoad(bool enable)
		{
			m_enalbeSharedAtlasLoad = enable;
		}

		private void Init()
		{
			Application.backgroundLoadingPriority = UnityEngine.ThreadPriority.High;
			Init3rdpartyCompression();
		}

		private void Init3rdpartyCompression()
		{
			if (m_enable3rdpartyCompression)
			{
				UnzipAssetFileOut.Instance().initThreadNum(4);
				UnzipAssetFileOut.Instance().startExecuteTask();
				UnzipAssetFileOut.Instance().showLog(m_showLoadLog);
				StartupUncompressThreads();
				m_3rdpartyCompressionInitFlag = true;
			}
		}

		private void StartupUncompressThreads()
		{
			bool flag = false;
			if (1 == 0)
			{
				if (m_UnCompressThreadList.Count == 0)
				{
					int num = 0;
					while (num < m_defaultUncompressThreadCnt)
					{
						UncompressWorker uncompressWorker = new UncompressWorker();
						uncompressWorker.quitFlag = false;
						uncompressWorker.thread = new Thread(UnCompressAsset2File);
						m_UnCompressThreadList.Add(uncompressWorker);
						uncompressWorker.thread.Start(uncompressWorker);
						num++;
					}
				}
			}
			else if (m_OutterUncompressWorker.thread == null)
			{
				m_OutterUncompressWorker.quitFlag = false;
				StartCoroutine(UpdateOutterAssetBundleUncompress(m_OutterUncompressWorker));
			}
		}

		private void UnCompressAsset2File(object parm)
		{
			UncompressWorker uncompressWorker = (UncompressWorker)parm;
			while (!uncompressWorker.quitFlag)
			{
				if (m_uncompressTaskList.Count == 0)
				{
					Thread.Sleep(1);
				}
				AssetUncompressTask assetUncompressTask = null;
				lock (m_UncompressOPLock)
				{
					if (m_uncompressTaskList.Count == 0)
					{
						continue;
					}
					assetUncompressTask = m_uncompressTaskList.First.Value;
					assetUncompressTask.assetUnCompressState = EAssetUncompressState.working;
					m_uncompressTaskList.RemoveFirst();
					goto IL_0075;
				}
				IL_0075:
				string readOnlyPath = FileUtil.GetReadOnlyPath(assetUncompressTask.fileName);
				string writePath = FileUtil.GetWritePath(assetUncompressTask.fileName);
				string fileDir = string.Empty;
				string fileName = null;
				FileUtil.SeparateFileDirAndName(writePath, ref fileDir, ref fileName);
				int progress = 0;
				int num = lzip.decompress_File(readOnlyPath + ".zip", fileDir, ref progress);
				if (num == 1)
				{
					assetUncompressTask.assetUnCompressState = EAssetUncompressState.succ;
				}
				else
				{
					assetUncompressTask.assetUnCompressState = EAssetUncompressState.failed;
				}
			}
		}

		private void CheckOutterAssetBundleUnCompress(object parm)
		{
		}

		private IEnumerator UpdateOutterAssetBundleUncompress(object parm)
		{
			UncompressWorker worker = (UncompressWorker)parm;
			while (!worker.quitFlag)
			{
				EAssetUncompressState taskState2 = EAssetUncompressState.waitting;
				string fileName2 = string.Empty;
				fileName2 = UnzipAssetFileOut.Instance().getUnzipCompleteFiles();
				if (fileName2 == null || fileName2.Length == 0)
				{
					fileName2 = UnzipAssetFileOut.Instance().getUnzipFailedFiles();
					if (fileName2 == null || fileName2.Length == 0)
					{
						yield return null;
						continue;
					}
					taskState2 = EAssetUncompressState.failed;
				}
				else
				{
					taskState2 = EAssetUncompressState.succ;
				}
				AssetUncompressTask task = null;
				if (!m_OutterThreadUncompressTaskList.TryGetValue(fileName2, out task))
				{
					UnityEngine.Debug.LogError(string.Format("Pending UnZip File Not Exists:{0}", fileName2));
					yield return null;
					continue;
				}
				m_OutterThreadUncompressTaskList.Remove(fileName2);
				if (m_showLoadLog)
				{
					UnityEngine.Debug.Log("File Uncompress OK:" + fileName2);
				}
				task.assetUnCompressState = taskState2;
			}
		}

		private void FixedUpdate()
		{
			StartBatchLoad();
		}

		public static void SetMaxTaskCnt(int cnt)
		{
			if (cnt < 1)
			{
				cnt = 1;
			}
			if (cnt > 100)
			{
				cnt = 100;
			}
			m_maxTaskCnt = cnt;
		}

		private void StartBatchLoad()
		{
			if (m_loadingQueue.Count < m_maxTaskCnt && m_waitingQueue.Count != 0)
			{
				while (m_waitingQueue.Count > 0 && m_loadingQueue.Count < m_maxTaskCnt)
				{
					AssetBundleRequest assetBundleRequest = m_waitingQueue.Dequeue();
					m_loadingQueue.Enqueue(assetBundleRequest);
					LoadImp(assetBundleRequest);
				}
			}
		}

		public void PrintSharedAtlasUsing()
		{
			string text = "SharedAtlasBingUsing:\n";
			foreach (SharedAtlasInfo value in sharedAtlasDic.Values)
			{
				string text2 = text;
				text = text2 + "refCount:" + value.refCount + " path: " + value.path + "\n";
			}
			UnityEngine.Debug.LogError(text);
		}

		private string getDepPath(string filePath)
		{
			if (filePathToDepDic.ContainsKey(filePath))
			{
				return filePathToDepDic[filePath];
			}
			string text = Path.GetDirectoryName(filePath) + "/" + Path.GetFileNameWithoutExtension(filePath);
			filePathToDepDic.Add(filePath, text);
			return text;
		}

		private void checkSharedAtlas(string filePath, string depFilePath, AssertLoadCallback lastCallback)
		{
			string depPath = getDepPath(filePath);
			if (!depDic.ContainsKey(depPath))
			{
				byte[] bytes = ResourceManager.GetInstance().LoadResourceByWWW(depFilePath);
				string @string = Encoding.Default.GetString(bytes);
				string[] array = @string.Split('|');
				List<string> list = new List<string>();
				for (int i = 0; i < array.Length; i++)
				{
					if (array[i] != string.Empty)
					{
						array[i] = Regex.Replace(array[i], "[\\n\\r]", string.Empty);
						list.Add(array[i]);
					}
				}
				depDic.Add(depPath, list.ToArray());
			}
			bool flag = true;
			string[] array2 = depDic[depPath];
			List<string> list2 = new List<string>();
			for (int j = 0; j < array2.Length; j++)
			{
				if (!sharedAtlasDic.ContainsKey(array2[j]))
				{
					flag = false;
					list2.Add(array2[j]);
				}
				else if (sharedAtlasDic[array2[j]].ab.mainAsset == null)
				{
					flag = false;
					sharedAtlasDic[array2[j]].ab.Unload(false);
					sharedAtlasDic.Remove(array2[j]);
					list2.Add(array2[j]);
				}
			}
			if (!flag)
			{
				for (int k = 0; k < list2.Count; k++)
				{
					if (k == list2.Count - 1)
					{
						LoadSharedAtlas(list2[k], SharedAtlasLoadCallback, filePath, lastCallback);
					}
					else
					{
						LoadSharedAtlas(list2[k], SharedAtlasLoadCallback, string.Empty, lastCallback);
					}
				}
			}
			else
			{
				AssetBundleRequest assetBundleRequest = new AssetBundleRequest();
				assetBundleRequest.m_filepath = filePath;
				assetBundleRequest.m_callback = lastCallback;
				m_waitingQueue.Enqueue(assetBundleRequest);
				m_allTask.Add(filePath, assetBundleRequest);
				StartBatchLoad();
			}
		}

		private void SharedAtlasLoadCallback(string filePath, bool loadByWWW, WWW www, AssetBundle bundle, string refAbpath, AssertLoadCallback lastCallback, string err_msg)
		{
			if (!sharedAtlasDic.ContainsKey(filePath))
			{
				SharedAtlasInfo sharedAtlasInfo = new SharedAtlasInfo();
				sharedAtlasInfo.ab = bundle;
				if (bundle != null)
				{
					Object mainAsset = bundle.mainAsset;
				}
				sharedAtlasInfo.path = filePath;
				sharedAtlasDic.Add(sharedAtlasInfo.path, sharedAtlasInfo);
			}
			if (refAbpath != string.Empty)
			{
				AssetBundleRequest assetBundleRequest = new AssetBundleRequest();
				assetBundleRequest.m_filepath = refAbpath;
				assetBundleRequest.m_callback = lastCallback;
				m_waitingQueue.Enqueue(assetBundleRequest);
				m_allTask.Add(refAbpath, assetBundleRequest);
				StartBatchLoad();
			}
		}

		public void checkAddSharedAtlasRef(AssetObject checkObj, AssetGameObject addObj)
		{
			if (!m_enalbeSharedAtlasLoad)
			{
				return;
			}
			int instanceID = checkObj.assetBundle.GetInstanceID();
			int pid = addObj.GetPid();
			if (gameInsRefToSharedAtlas.ContainsKey(pid) || !gameInsRefToSharedAtlas.ContainsKey(instanceID))
			{
				return;
			}
			string[] array = gameInsRefToSharedAtlas[instanceID];
			for (int i = 0; i < array.Length; i++)
			{
				if (sharedAtlasDic.ContainsKey(array[i]))
				{
					sharedAtlasDic[array[i]].addRef();
				}
			}
			gameInsRefToSharedAtlas.Add(pid, array);
		}

		public void checkAddSharedAtlasRef(AssetGameObject checkObj, AssetGameObject addObj)
		{
			if (!m_enalbeSharedAtlasLoad)
			{
				return;
			}
			int pid = checkObj.GetPid();
			int pid2 = addObj.GetPid();
			if (gameInsRefToSharedAtlas.ContainsKey(pid2) || !gameInsRefToSharedAtlas.ContainsKey(pid))
			{
				return;
			}
			string[] array = gameInsRefToSharedAtlas[pid];
			for (int i = 0; i < array.Length; i++)
			{
				if (sharedAtlasDic.ContainsKey(array[i]))
				{
					sharedAtlasDic[array[i]].addRef();
				}
			}
			gameInsRefToSharedAtlas.Add(pid2, array);
		}

		public void checkDelSharedAtlasRef(int abInsID)
		{
			if (!m_enalbeSharedAtlasLoad || !gameInsRefToSharedAtlas.ContainsKey(abInsID))
			{
				return;
			}
			string[] array = gameInsRefToSharedAtlas[abInsID];
			for (int i = 0; i < array.Length; i++)
			{
				if (sharedAtlasDic.ContainsKey(array[i]))
				{
					sharedAtlasDic[array[i]].delRef();
				}
			}
			gameInsRefToSharedAtlas.Remove(abInsID);
		}

		public bool Load(string filepath, AssertLoadCallback callback)
		{
			if (m_useSyncLoad)
			{
				return LoadSync(filepath, callback);
			}
			return LoadAsync(filepath, callback);
		}

		public bool LoadAsync(string filepath, AssertLoadCallback callback)
		{
			if (Exist(filepath))
			{
				AssetBundleRequest assetBundleRequest = m_allTask[filepath];
				if (assetBundleRequest.type == 2 && assetBundleRequest.m_texcallback == null)
				{
					assetBundleRequest.m_texcallback = callback;
					return true;
				}
				return false;
			}
			bool flag = false;
			if (Path.GetExtension(filepath) == ".assetbundle" && m_enalbeSharedAtlasLoad)
			{
				string text = Path.GetDirectoryName(filepath) + "/" + Path.GetFileNameWithoutExtension(filepath) + ".dependencies";
				string filePathGrayAll = FileUtil.GetFilePathGrayAll(text);
				if (filePathGrayAll != string.Empty)
				{
					checkSharedAtlas(filepath, text, callback);
				}
				else
				{
					flag = true;
				}
			}
			else
			{
				flag = true;
			}
			if (flag)
			{
				AssetBundleRequest assetBundleRequest2 = new AssetBundleRequest();
				assetBundleRequest2.m_filepath = filepath;
				assetBundleRequest2.m_callback = callback;
				m_waitingQueue.Enqueue(assetBundleRequest2);
				m_allTask.Add(filepath, assetBundleRequest2);
				StartBatchLoad();
			}
			return true;
		}

		public bool LoadSync(string filepath, AssertLoadCallback callback)
		{
			if (ExistSync(filepath))
			{
				return false;
			}
			m_allSyncTask.Add(filepath, callback);
			m_syncWaitingQueue.Enqueue(filepath);
			return true;
		}

		private bool ExistSync(string filePath)
		{
			if (m_allSyncTask.ContainsKey(filePath))
			{
				return true;
			}
			return false;
		}

		private void LateUpdate()
		{
			if (m_allSyncTask.Count <= 0)
			{
				return;
			}
			if (!m_syncLoadUseTimeLimit)
			{
				int num = 0;
				do
				{
					num++;
					string item = m_syncWaitingQueue.Dequeue();
					m_syncLoadingQueue.Enqueue(item);
				}
				while (m_syncWaitingQueue.Count > 0 && num <= m_maxLoadNumPerFrame);
			}
			StartCoroutine(loadSync());
		}

		private IEnumerator loadSync()
		{
			yield return new WaitForEndOfFrame();
			if (m_syncLoadUseTimeLimit)
			{
				Stopwatch stopwatch = new Stopwatch();
				stopwatch.Start();
				do
				{
					string text = m_syncWaitingQueue.Dequeue();
					bool flag = false;
					AssertLoadCallback assertLoadCallback = m_allSyncTask[text];
					m_allSyncTask.Remove(text);
					if (Path.GetExtension(text) == ".assetbundle" && m_enalbeSharedAtlasLoad)
					{
						string text2 = Path.GetDirectoryName(text) + "/" + Path.GetFileNameWithoutExtension(text) + ".dependencies";
						string filePathGrayAll = FileUtil.GetFilePathGrayAll(text2);
						if (filePathGrayAll != string.Empty)
						{
							AssetBundle bundle = checkSharedAtlasSync(text, text2);
							assertLoadCallback(text, false, null, bundle, string.Empty);
						}
						else
						{
							flag = true;
						}
					}
					else
					{
						flag = true;
					}
					if (flag)
					{
						AssetBundle bundle2 = ResourceManager.GetInstance().LoadAssetBundleFromFile(text);
						assertLoadCallback(text, false, null, bundle2, string.Empty);
					}
				}
				while (m_syncWaitingQueue.Count > 0 && (float)stopwatch.ElapsedMilliseconds < m_syncLoadContinueTime);
				yield break;
			}
			do
			{
				string text3 = m_syncLoadingQueue.Dequeue();
				bool flag2 = false;
				AssertLoadCallback assertLoadCallback2 = m_allSyncTask[text3];
				m_allSyncTask.Remove(text3);
				if (Path.GetExtension(text3) == ".assetbundle" && m_enalbeSharedAtlasLoad)
				{
					string text4 = Path.GetDirectoryName(text3) + "/" + Path.GetFileNameWithoutExtension(text3) + ".dependencies";
					string filePathGrayAll2 = FileUtil.GetFilePathGrayAll(text4);
					if (filePathGrayAll2 != string.Empty)
					{
						AssetBundle bundle3 = checkSharedAtlasSync(text3, text4);
						assertLoadCallback2(text3, false, null, bundle3, string.Empty);
					}
					else
					{
						flag2 = true;
					}
				}
				else
				{
					flag2 = true;
				}
				if (flag2)
				{
					AssetBundle bundle4 = ResourceManager.GetInstance().LoadAssetBundleFromFile(text3);
					assertLoadCallback2(text3, false, null, bundle4, string.Empty);
				}
			}
			while (m_syncLoadingQueue.Count > 0);
		}

		private AssetBundle checkSharedAtlasSync(string filePath, string depFilePath)
		{
			string depPath = getDepPath(filePath);
			if (!depDic.ContainsKey(depPath))
			{
				byte[] bytes = ResourceManager.GetInstance().LoadResourceByWWW(depFilePath);
				string @string = Encoding.Default.GetString(bytes);
				string[] array = @string.Split('|');
				List<string> list = new List<string>();
				for (int i = 0; i < array.Length; i++)
				{
					if (array[i] != string.Empty)
					{
						array[i] = Regex.Replace(array[i], "[\\n\\r]", string.Empty);
						list.Add(array[i]);
					}
				}
				depDic.Add(depPath, list.ToArray());
			}
			bool flag = true;
			string[] array2 = depDic[depPath];
			List<string> list2 = new List<string>();
			for (int j = 0; j < array2.Length; j++)
			{
				if (!sharedAtlasDic.ContainsKey(array2[j]))
				{
					flag = false;
					list2.Add(array2[j]);
				}
				else if (sharedAtlasDic[array2[j]].ab.mainAsset == null)
				{
					flag = false;
					sharedAtlasDic[array2[j]].ab.Unload(false);
					sharedAtlasDic.Remove(array2[j]);
					list2.Add(array2[j]);
				}
			}
			if (!flag)
			{
				string text = filePath.Substring(0, filePath.IndexOf("/prefabs/")) + "/prefabs/shared_atlas/";
				for (int k = 0; k < list2.Count; k++)
				{
					AssetBundle assetBundle = ResourceManager.GetInstance().LoadAssetBundleFromFile(list2[k]);
					if (assetBundle != null && !sharedAtlasDic.ContainsKey(list2[k]))
					{
						SharedAtlasInfo sharedAtlasInfo = new SharedAtlasInfo();
						sharedAtlasInfo.ab = assetBundle;
						sharedAtlasInfo.path = list2[k];
						sharedAtlasDic.Add(sharedAtlasInfo.path, sharedAtlasInfo);
					}
				}
			}
			AssetBundle assetBundle2 = ResourceManager.GetInstance().LoadAssetBundleFromFile(filePath);
			if (depDic.ContainsKey(depPath))
			{
				string[] array3 = depDic[depPath];
				for (int l = 0; l < array3.Length; l++)
				{
					if (sharedAtlasDic.ContainsKey(array3[l]))
					{
						sharedAtlasDic[array3[l]].addRef();
					}
				}
				if (assetBundle2 != null)
				{
					gameInsRefToSharedAtlas.Add(assetBundle2.GetInstanceID(), array3);
				}
			}
			return assetBundle2;
		}

		private bool LoadSharedAtlas(string filepath, SharedAtlasLoadCallback callback, string refAbPath, AssertLoadCallback lastCallback)
		{
			if (Exist(filepath))
			{
				AssetBundleRequest assetBundleRequest = m_allTask[filepath];
				if (assetBundleRequest.type == 0)
				{
					assetBundleRequest.type = 2;
					assetBundleRequest.m_texcallback = assetBundleRequest.m_callback;
					assetBundleRequest.m_scallback = callback;
					assetBundleRequest.m_callback = lastCallback;
					assetBundleRequest.refAbPath = refAbPath;
				}
				if (assetBundleRequest.m_addedcallback != null)
				{
					assetBundleRequest.m_addedcallback.Add(lastCallback);
					assetBundleRequest.m_addedrefAbPaths.Add(refAbPath);
				}
				else
				{
					assetBundleRequest.m_addedcallback = new List<AssertLoadCallback>();
					assetBundleRequest.m_addedrefAbPaths = new List<string>();
					assetBundleRequest.m_addedcallback.Add(lastCallback);
					assetBundleRequest.m_addedrefAbPaths.Add(refAbPath);
				}
				return false;
			}
			AssetBundleRequest assetBundleRequest2 = new AssetBundleRequest();
			assetBundleRequest2.type = 2;
			assetBundleRequest2.m_filepath = filepath;
			assetBundleRequest2.m_callback = lastCallback;
			assetBundleRequest2.m_scallback = callback;
			assetBundleRequest2.refAbPath = refAbPath;
			m_waitingQueue.Enqueue(assetBundleRequest2);
			m_allTask.Add(filepath, assetBundleRequest2);
			StartBatchLoad();
			return true;
		}

		private void LoadImp(AssetBundleRequest req)
		{
			StartCoroutine(StartLoadAsset(req));
		}

		private void OnRequestProcessedCallBack(AssetBundleRequest req)
		{
			StartBatchLoad();
			req.m_processed = true;
			while (m_loadingQueue.Count > 0)
			{
				AssetBundleRequest assetBundleRequest = m_loadingQueue.Peek();
				if (!assetBundleRequest.m_processed)
				{
					break;
				}
				m_loadingQueue.Dequeue();
				m_allTask.Remove(assetBundleRequest.m_filepath);
				if (assetBundleRequest.type == 0)
				{
					string depPath = getDepPath(assetBundleRequest.m_filepath);
					if (depDic.ContainsKey(depPath))
					{
						string[] array = depDic[depPath];
						for (int i = 0; i < array.Length; i++)
						{
							if (sharedAtlasDic.ContainsKey(array[i]))
							{
								sharedAtlasDic[array[i]].addRef();
							}
						}
						if (assetBundleRequest.m_loadByWWW)
						{
							if (assetBundleRequest.m_www.assetBundle != null)
							{
								gameInsRefToSharedAtlas.Add(assetBundleRequest.m_www.assetBundle.GetInstanceID(), array);
							}
							else
							{
								Core.Unity.Debug.LogError("加载出的是空的");
							}
						}
						else if (assetBundleRequest.m_abcr.assetBundle != null)
						{
							gameInsRefToSharedAtlas.Add(assetBundleRequest.m_abcr.assetBundle.GetInstanceID(), array);
						}
						else
						{
							gameInsRefToSharedAtlas.Add(assetBundleRequest.m_assetBundle.GetInstanceID(), array);
						}
					}
					if (assetBundleRequest.m_loadByWWW)
					{
						assetBundleRequest.m_callback(assetBundleRequest.m_filepath, assetBundleRequest.m_loadByWWW, assetBundleRequest.m_www, assetBundleRequest.m_assetBundle, assetBundleRequest.m_msg);
					}
					else
					{
						assetBundleRequest.m_callback(assetBundleRequest.m_filepath, assetBundleRequest.m_loadByWWW, assetBundleRequest.m_www, (!(assetBundleRequest.m_assetBundle == null)) ? assetBundleRequest.m_assetBundle : assetBundleRequest.m_abcr.assetBundle, assetBundleRequest.m_msg);
					}
				}
				else
				{
					if (assetBundleRequest.type != 2)
					{
						continue;
					}
					if (assetBundleRequest.m_loadByWWW)
					{
						assetBundleRequest.m_scallback(assetBundleRequest.m_filepath, assetBundleRequest.m_loadByWWW, assetBundleRequest.m_www, assetBundleRequest.m_www.assetBundle, assetBundleRequest.refAbPath, assetBundleRequest.m_callback, assetBundleRequest.m_msg);
						if (assetBundleRequest.m_texcallback != null)
						{
							assetBundleRequest.m_texcallback(assetBundleRequest.m_filepath, assetBundleRequest.m_loadByWWW, assetBundleRequest.m_www, (!(assetBundleRequest.m_assetBundle == null)) ? assetBundleRequest.m_assetBundle : assetBundleRequest.m_abcr.assetBundle, assetBundleRequest.m_msg);
						}
					}
					else
					{
						assetBundleRequest.m_scallback(assetBundleRequest.m_filepath, assetBundleRequest.m_loadByWWW, assetBundleRequest.m_www, (!(assetBundleRequest.m_assetBundle == null)) ? assetBundleRequest.m_assetBundle : assetBundleRequest.m_abcr.assetBundle, assetBundleRequest.refAbPath, assetBundleRequest.m_callback, assetBundleRequest.m_msg);
						if (assetBundleRequest.m_texcallback != null)
						{
							assetBundleRequest.m_texcallback(assetBundleRequest.m_filepath, assetBundleRequest.m_loadByWWW, assetBundleRequest.m_www, (!(assetBundleRequest.m_assetBundle == null)) ? assetBundleRequest.m_assetBundle : assetBundleRequest.m_abcr.assetBundle, assetBundleRequest.m_msg);
						}
					}
					if (assetBundleRequest.m_addedrefAbPaths == null)
					{
						continue;
					}
					for (int j = 0; j < assetBundleRequest.m_addedrefAbPaths.Count; j++)
					{
						if (assetBundleRequest.m_loadByWWW)
						{
							assetBundleRequest.m_scallback(assetBundleRequest.m_filepath, assetBundleRequest.m_loadByWWW, assetBundleRequest.m_www, assetBundleRequest.m_www.assetBundle, assetBundleRequest.m_addedrefAbPaths[j], assetBundleRequest.m_addedcallback[j], assetBundleRequest.m_msg);
						}
						else
						{
							assetBundleRequest.m_scallback(assetBundleRequest.m_filepath, assetBundleRequest.m_loadByWWW, assetBundleRequest.m_www, (!(assetBundleRequest.m_assetBundle == null)) ? assetBundleRequest.m_assetBundle : assetBundleRequest.m_abcr.assetBundle, assetBundleRequest.m_addedrefAbPaths[j], assetBundleRequest.m_addedcallback[j], assetBundleRequest.m_msg);
						}
					}
				}
			}
		}

		private bool Exist(string filepath)
		{
			return m_allTask.ContainsKey(filepath);
		}

		private IEnumerator StartLoadAsset(AssetBundleRequest request)
		{
			bool loadComplete = false;
			int leftTryTimes = 5;
			string wwwpath4 = string.Empty;
			while (!loadComplete && leftTryTimes-- > 0)
			{
				if (m_useAsyncLoad)
				{
					wwwpath4 = FileUtil.GetAssetBundlePath(request.m_filepath);
				}
				else
				{
					wwwpath4 = FileUtil.GetWWWReadPath(request.m_filepath);
				}
				bool needUncompress = false;
				if (m_enable3rdpartyCompression && !FileUtil.FileExist(request.m_filepath, FileUtil.DirectoryType.WritePath))
				{
					needUncompress = (FileUtil.FileExist(request.m_filepath + ".zip", FileUtil.DirectoryType.ReadPath) ? true : false);
				}
				if (needUncompress)
				{
					AssetUncompressTask task = new AssetUncompressTask
					{
						assetUnCompressState = EAssetUncompressState.waitting,
						fileName = request.m_filepath
					};
					bool outter_extract_thread2 = false;
					outter_extract_thread2 = true;
					string destFileName3 = null;
					if (!outter_extract_thread2)
					{
						lock (m_UncompressOPLock)
						{
							m_uncompressTaskList.AddLast(task);
						}
					}
					else
					{
						m_OutterThreadUncompressTaskList.Add(task.fileName, task);
						destFileName3 = FileUtil.GetWriteDir() + "/" + task.fileName;
						int length = destFileName3.LastIndexOf('/');
						string outputDirectorys = destFileName3.Substring(0, length);
						UnzipAssetFileOut.Instance().addZipFile(task.fileName, task.fileName + ".zip", outputDirectorys);
					}
					while (task.assetUnCompressState != EAssetUncompressState.succ && task.assetUnCompressState != EAssetUncompressState.failed)
					{
						yield return null;
					}
					if (task.assetUnCompressState != EAssetUncompressState.failed)
					{
						destFileName3 = string.Format("{0}/{1}", FileUtil.GetWriteDir(), task.fileName);
						if (m_showLoadLog)
						{
							UnityEngine.Debug.Log(string.Format("File:{0} Uncompress complete, try load from :{1}!", task.fileName, destFileName3));
						}
						request.m_assetBundle = AssetBundle.LoadFromFile(destFileName3);
						if (null == request.m_assetBundle)
						{
							request.m_msg = string.Format("LoadFromFile failed, file not exists : {0}", destFileName3);
						}
						if (m_showLoadLog)
						{
							UnityEngine.Debug.Log("load succ: " + destFileName3);
						}
						loadComplete = true;
						request.m_loadByWWW = false;
						request.m_abcr = null;
						request.m_www = null;
						OnRequestProcessedCallBack(request);
					}
				}
				else
				{
					string error_code = null;
					if (m_useAsyncLoad)
					{
						request.m_loadByWWW = false;
						wwwpath4 = FileUtil.GetAssetBundlePath(request.m_filepath);
						request.m_abcr = AssetBundle.LoadFromFileAsync(wwwpath4);
						yield return request.m_abcr;
					}
					else
					{
						request.m_loadByWWW = true;
						wwwpath4 = FileUtil.GetWWWReadPath(request.m_filepath);
						request.m_www = new WWW(wwwpath4);
						yield return request.m_www;
						error_code = request.m_www.error;
					}
					if (error_code != null)
					{
						loadComplete = true;
						request.m_abcr = null;
						request.m_msg = error_code;
						Core.Unity.Debug.LogError("[AssertBundleLoader StartLoadAsset] errorMessage:" + request.m_msg + ", path:" + wwwpath4);
					}
					else if (!m_useAsyncLoad && null == request.m_www.assetBundle)
					{
						Core.Unity.Debug.LogError(string.Format("Reload File:{0}[{1}/{2}].", request.m_filepath, 5 - leftTryTimes, 5));
						request.m_www = null;
					}
					else if (m_useAsyncLoad && null == request.m_abcr.assetBundle)
					{
						Core.Unity.Debug.LogError(string.Format("Reload File:{0}[{1}/{2}].", request.m_filepath, 5 - leftTryTimes, 5));
						request.m_abcr = null;
					}
					else
					{
						loadComplete = true;
						request.m_msg = string.Empty;
					}
					if (loadComplete)
					{
						OnRequestProcessedCallBack(request);
					}
				}
			}
		}

		private void OnGUIXX()
		{
			GUILayout.BeginHorizontal();
			GUILayout.Label(string.Empty, GUILayout.Width(400f));
			GUILayout.BeginVertical();
			if (GUILayout.Button("打印ShaderAtlas", GUILayout.Height(50f)))
			{
				PrintSharedAtlasUsing();
			}
			if (m_useSyncLoad)
			{
				if (GUILayout.Button("切换为异步加载", GUILayout.Height(50f)))
				{
					m_useSyncLoad = false;
				}
			}
			else if (GUILayout.Button("切换为同步加载", GUILayout.Height(50f)))
			{
				m_useSyncLoad = true;
			}
			GUILayout.Label("同步加载持续：" + m_syncLoadContinueTime + " ms");
			m_syncLoadContinueTime = (int)GUILayout.HorizontalSlider(m_syncLoadContinueTime, 0f, 10000f, GUILayout.Width(500f), GUILayout.Height(50f));
			GUILayout.EndVertical();
			GUILayout.EndHorizontal();
		}

		public void send_http_info(string url, string type, Dictionary<string, string> pList)
		{
			if (Application.internetReachability != 0)
			{
				StartCoroutine(http_post_info(url, type, pList));
			}
		}

		private IEnumerator http_post_info(string url, string type, Dictionary<string, string> pList)
		{
			WWWForm form = new WWWForm();
			form.AddField("type", type);
			foreach (KeyValuePair<string, string> p in pList)
			{
				form.AddField(p.Key, p.Value);
			}
			WWW getData = new WWW(url, form);
			yield return getData;
			if (getData.error != null)
			{
			}
			getData.Dispose();
		}
	}
}
