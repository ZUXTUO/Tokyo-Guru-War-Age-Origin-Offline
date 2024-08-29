using System.Collections.Generic;
using Core;
using Core.Resource;
using UnityEngine;
using Wraper;

namespace UnityWrap
{
	public class AssetObject : RefObject
	{
		public static AssetObjectCache<int, AssetObject> cache = new AssetObjectCache<int, AssetObject>();

		public static Dictionary<string, int> m_filePathMap = new Dictionary<string, int>();

		public static LinkedList<AssetObject> m_deferredReleaseAssetObjs = new LinkedList<AssetObject>();

		private static float m_lastCheckDeferredReleaseTime = Time.time;

		private static bool m_enableSyncAssetDeferredRelease = false;

		public bool unloadAll = true;

		public bool m_loadByWWW = true;

		public WWW m_refWWW;

		private bool m_inDeferredReleaseList;

		private float m_maxDeferredReleaseTime;

		public AssetBundle assetBundle;

		public Object mainAsset;

		private AudioSource audioSource;

		private string filePath = string.Empty;

		public AssetObject()
		{
			lua_class_name = asset_object_wraper.name;
			unloadAll = true;
		}

		public static bool GetEnableSyncAssetDeferredRelease()
		{
			return m_enableSyncAssetDeferredRelease;
		}

		public static void SetEnableSyncAssetDefferedRelease(bool enable)
		{
			if (enable || !m_enableSyncAssetDeferredRelease)
			{
				m_enableSyncAssetDeferredRelease = enable;
			}
		}

		public static void Update()
		{
			if (!m_enableSyncAssetDeferredRelease || (double)(Time.time - m_lastCheckDeferredReleaseTime) < 5.0)
			{
				return;
			}
			m_lastCheckDeferredReleaseTime = Time.time;
			if (m_deferredReleaseAssetObjs.Count == 0)
			{
				return;
			}
			LinkedListNode<AssetObject> linkedListNode = m_deferredReleaseAssetObjs.First;
			LinkedListNode<AssetObject> linkedListNode2 = null;
			AssetObject assetObject = null;
			while (linkedListNode != m_deferredReleaseAssetObjs.Last)
			{
				assetObject = linkedListNode.Value;
				if (assetObject.ResLoadComplete() || assetObject.IsResLoadTimeout())
				{
					linkedListNode2 = linkedListNode.Next;
					assetObject.ClearResources(true);
					m_deferredReleaseAssetObjs.Remove(linkedListNode);
					linkedListNode = linkedListNode2;
				}
				else
				{
					linkedListNode = linkedListNode.Next;
				}
			}
			assetObject = m_deferredReleaseAssetObjs.Last.Value;
			if (assetObject.ResLoadComplete() || assetObject.IsResLoadTimeout())
			{
				assetObject.ClearResources(true);
				m_deferredReleaseAssetObjs.RemoveLast();
			}
		}

		private bool ResLoadComplete()
		{
			if (null != audioSource)
			{
				return audioSource.clip.loadState == AudioDataLoadState.Loaded;
			}
			return true;
		}

		private bool IsResLoadTimeout()
		{
			bool flag = Time.time >= m_maxDeferredReleaseTime;
			if (flag)
			{
				string arg = string.Empty;
				if (m_refWWW != null && m_refWWW != null)
				{
					arg = m_refWWW.assetBundle.name;
				}
				Debug.LogWarning(string.Format("Res Load Timeout. {0}", arg));
			}
			return flag;
		}

		public override void PrePushToLua()
		{
			AddRef();
		}

		public override void PostPushToLua()
		{
			DelRef();
		}

		public static AssetObject GetByAssetFilePath(string file_path)
		{
			if (!m_filePathMap.ContainsKey(file_path))
			{
				return null;
			}
			return cache.Find(m_filePathMap[file_path]);
		}

		public static AssetObject CreateByAssetBundle(string filePath, AssetBundle ab)
		{
			if (ab == null)
			{
				return null;
			}
			AssetObject assetObject = new AssetObject();
			assetObject.Init(ab, filePath);
			assetObject.SetWWWFlag(null, false);
			return assetObject;
		}

		public static AssetObject CreateByWWW(string filePath, WWW www)
		{
			if (www == null || www.assetBundle == null)
			{
				return null;
			}
			AssetObject assetObject = new AssetObject();
			assetObject.Init(www.assetBundle, filePath);
			assetObject.SetWWWFlag(www, true);
			return assetObject;
		}

		public static void DestroyAll()
		{
			Dictionary<int, AssetObject> cacheMap = cache.cacheMap;
			foreach (AssetObject value in cacheMap.Values)
			{
				value.ClearResources(false);
			}
			cacheMap.Clear();
		}

		public void Init(AssetBundle assetB, string filePath)
		{
			assetBundle = assetB;
			mainAsset = assetB.mainAsset;
			audioSource = ((GameObject)mainAsset).GetComponent<AudioSource>();
			cache.Add(GetPid(), this);
			m_filePathMap.Add(filePath, GetPid());
			this.filePath = filePath;
		}

		public void SetWWWFlag(WWW www, bool loadByWWW)
		{
			m_refWWW = www;
			m_loadByWWW = loadByWWW;
		}

		public override void ClearResources()
		{
			if (m_enableSyncAssetDeferredRelease && IsDeferredReleaseType() && !ResLoadComplete())
			{
				MarkAsDeferredRelease();
			}
			else
			{
				ClearResources(true);
			}
		}

		public void ClearResources(bool needRemove)
		{
			if (needRemove)
			{
				cache.Remove(GetPid());
				m_filePathMap.Remove(filePath);
			}
			if (assetBundle != null)
			{
				AssetBundleLoader.GetInstance().checkDelSharedAtlasRef(assetBundle.GetInstanceID());
				assetBundle.Unload(unloadAll);
				assetBundle = null;
				mainAsset = null;
				audioSource = null;
				if (m_refWWW != null)
				{
					m_refWWW.Dispose();
					m_refWWW = null;
				}
			}
		}

		public bool IsDeferredReleaseType()
		{
			if (audioSource != null)
			{
				return true;
			}
			return false;
		}

		private void MarkAsDeferredRelease()
		{
			if (!m_inDeferredReleaseList)
			{
				m_deferredReleaseAssetObjs.AddLast(this);
				m_maxDeferredReleaseTime = Time.time + 30f;
			}
			m_inDeferredReleaseList = true;
		}
	}
}
