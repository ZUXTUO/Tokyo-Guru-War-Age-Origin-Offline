using System;
using System.Collections;
using System.Collections.Generic;
using System.IO;
using System.Threading;
using UnityEngine;

namespace Core.Resource
{
	public class newBundleLoader : MonoBehaviourEx
	{
		private static newBundleLoader m_instance = null;

		private static string m_go_name = "_NewBundleLoader";

		private List<NewBundleRequest> m_waitingList = new List<NewBundleRequest>();

		private List<NewBundleRequest> m_loadingList = new List<NewBundleRequest>();

		private List<NewBundleRequest> m_completeList = new List<NewBundleRequest>();

		private Dictionary<string, NewBundleRequest> m_allTask = new Dictionary<string, NewBundleRequest>();

		private List<Thread> decompressThreadList = new List<Thread>();

		private static int maxThread = Environment.ProcessorCount;

		public static string getRWPath(string path)
		{
			return Application.persistentDataPath + "/" + path;
		}

		public static newBundleLoader GetInstance()
		{
			if (m_instance == null)
			{
				GameObject gameObject = MonoBehaviourEx.CreateGameObject(m_go_name);
				m_instance = gameObject.AddComponent<newBundleLoader>();
				UnzipAssetFileOut.Instance().initThreadNum(maxThread - 1);
			}
			return m_instance;
		}

		private bool Exist(string filepath)
		{
			return m_allTask.ContainsKey(filepath);
		}

		public bool Load(string filePath, NewLoadCallback callBack)
		{
			if (Exist(filePath))
			{
				return false;
			}
			string rWPath = getRWPath(filePath);
			if (File.Exists(rWPath))
			{
				NewBundleRequest newBundleRequest = new NewBundleRequest();
				newBundleRequest.m_filepath = filePath;
				newBundleRequest.m_callback = callBack;
				newBundleRequest.m_rwFilePath = rWPath;
				m_completeList.Add(newBundleRequest);
			}
			else
			{
				string empty = string.Empty;
				empty = string.Empty;
				string zipFrom = empty + Application.streamingAssetsPath + "/" + filePath + ".zip";
				string zipTo = Application.persistentDataPath + "/" + filePath + ".zip";
				NewBundleRequest newBundleRequest = new NewBundleRequest();
				newBundleRequest.m_filepath = filePath;
				newBundleRequest.m_callback = callBack;
				newBundleRequest.m_zipFrom = zipFrom;
				newBundleRequest.m_zipTo = zipTo;
				newBundleRequest.m_rwFilePath = rWPath;
				m_allTask.Add(filePath, newBundleRequest);
				m_waitingList.Add(newBundleRequest);
				StartLoadQueue();
			}
			return true;
		}

		private void StartLoadQueue()
		{
			while (m_waitingList.Count > 0)
			{
				NewBundleRequest newBundleRequest = m_waitingList[0];
				m_waitingList.RemoveAt(0);
				m_loadingList.Add(newBundleRequest);
				int num = newBundleRequest.m_zipTo.LastIndexOf('/');
				string text = newBundleRequest.m_zipTo.Substring(newBundleRequest.m_zipTo.LastIndexOf('/') + 1, newBundleRequest.m_zipTo.Length - num - 1);
				string folderName = newBundleRequest.m_zipTo.Substring(0, num);
				newBundleRequest.folderName = folderName;
				UnzipAssetFileOut.Instance().addZipFile(newBundleRequest.m_filepath, newBundleRequest.m_filepath + ".zip", newBundleRequest.folderName);
			}
			UnzipAssetFileOut.Instance().startExecuteTask();
		}

		private IEnumerator wwwCopy(NewBundleRequest nbr)
		{
			string pathFrom = nbr.m_zipFrom;
			string pathTo = nbr.m_zipTo;
			WWW bundle = new WWW(pathFrom);
			yield return bundle;
			if (bundle.error != null)
			{
				Debug.LogError(string.Format("load asset {0} failed:{1}", pathFrom, bundle.error));
			}
			if (!Directory.Exists(nbr.folderName))
			{
				Directory.CreateDirectory(nbr.folderName);
			}
			FileStream outStream = new FileStream(pathTo, FileMode.Create);
			outStream.Write(bundle.bytes, 0, bundle.bytes.Length);
			outStream.Flush();
			outStream.Close();
			bundle.Dispose();
			Thread t = new Thread(otherThreadToDeCompress);
			t.Start(nbr);
		}

		private void otherThreadToDeCompress(object obj)
		{
			int progress = 0;
			NewBundleRequest newBundleRequest = (NewBundleRequest)obj;
			try
			{
				int num = lzip.decompress_File(newBundleRequest.m_zipTo, newBundleRequest.folderName, ref progress);
				if (File.Exists(newBundleRequest.m_zipTo))
				{
					File.Delete(newBundleRequest.m_zipTo);
				}
				if (num == 1)
				{
					m_allTask.Remove(newBundleRequest.m_filepath);
					m_loadingList.Remove(newBundleRequest);
					m_completeList.Add(newBundleRequest);
				}
				else
				{
					Debug.LogError("can't decompress " + newBundleRequest.m_zipTo);
					m_allTask.Remove(newBundleRequest.m_filepath);
					m_loadingList.Remove(newBundleRequest);
					newBundleRequest.m_callback(newBundleRequest.m_filepath, null, "can't load this file");
				}
			}
			catch (Exception message)
			{
				Debug.LogError(message);
				m_loadingList.Remove(newBundleRequest);
				newBundleRequest.m_callback(newBundleRequest.m_filepath, null, "can't load this file");
			}
		}

		private void Update()
		{
			for (string unzipCompleteFiles = UnzipAssetFileOut.Instance().getUnzipCompleteFiles(); unzipCompleteFiles != null; unzipCompleteFiles = UnzipAssetFileOut.Instance().getUnzipCompleteFiles())
			{
				if (m_allTask.ContainsKey(unzipCompleteFiles))
				{
					NewBundleRequest item = m_allTask[unzipCompleteFiles];
					m_allTask.Remove(unzipCompleteFiles);
					m_loadingList.Remove(item);
					m_completeList.Add(item);
				}
			}
			int num = 0;
			while (m_completeList.Count > 0)
			{
				NewBundleRequest newBundleRequest = m_completeList[0];
				m_completeList.RemoveAt(0);
				AssetBundle ab = AssetBundle.LoadFromFile(newBundleRequest.m_rwFilePath);
				newBundleRequest.m_callback(newBundleRequest.m_filepath, ab, string.Empty);
				num++;
				if (num == 5)
				{
					break;
				}
			}
			StartLoadQueue();
		}
	}
}
