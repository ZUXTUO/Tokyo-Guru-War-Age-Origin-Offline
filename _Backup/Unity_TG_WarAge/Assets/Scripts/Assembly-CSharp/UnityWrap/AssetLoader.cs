using System.Collections.Generic;
using Core;
using Core.Resource;
using Script;
using UnityEngine;
using Wraper;

namespace UnityWrap
{
	public class AssetLoader : MonoObject
	{
		private static string defName = "_AssetLoader";

		private static AssetLoader defInstance = null;

		public static AssetObjectCache<int, AssetLoader> cache = new AssetObjectCache<int, AssetLoader>();

		private List<AssertRequest> mRequestList = new List<AssertRequest>();

		private string mLoadScript;

		private GameObject unityProxyGO;

		public AssetLoader()
		{
			lua_class_name = asset_loader_wraper.name;
		}

		public static AssetLoader GetDefault()
		{
			if (defInstance == null)
			{
				defInstance = InstanceAssetLoader(defName);
			}
			return defInstance;
		}

		public static AssetLoader InstanceAssetLoader(string name)
		{
			GameObject gameObject = MonoObject.CreateGameObject(name);
			AssetLoader assetLoader = gameObject.AddComponent<AssetLoader>();
			assetLoader.unityProxyGO = gameObject;
			cache.Add(assetLoader.GetPid(), assetLoader);
			return assetLoader;
		}

		public static void DestroyAssetLoader(AssetLoader loader, bool needRemove = true)
		{
			if (loader != null)
			{
				if (needRemove)
				{
					cache.Remove(loader.GetPid());
				}
				loader.Clear();
				Object.Destroy(loader.unityProxyGO);
				loader.unityProxyGO = null;
			}
		}

		public static void DestroyAll()
		{
			Dictionary<int, AssetLoader> cacheMap = cache.cacheMap;
			foreach (AssetLoader value in cacheMap.Values)
			{
				DestroyAssetLoader(value, false);
			}
			cacheMap.Clear();
		}

		public string GetName()
		{
			return (!(unityProxyGO != null)) ? null : unityProxyGO.name;
		}

		public void Clear()
		{
			if (!(unityProxyGO != null))
			{
			}
		}

		public void SetCallback(string callback)
		{
			mLoadScript = ((callback == null) ? string.Empty : callback);
		}

		public void Load(string filePath)
		{
			AssetObject byAssetFilePath = AssetObject.GetByAssetFilePath(filePath);
			if (byAssetFilePath != null)
			{
				byAssetFilePath.AddRef();
				OnLoadCallbackImp(filePath, mLoadScript, byAssetFilePath, string.Empty);
			}
			else if (AssetBundleLoader.GetInstance().sharedAtlasDic.ContainsKey(filePath))
			{
				AssetBundle ab = AssetBundleLoader.GetInstance().sharedAtlasDic[filePath].ab;
				byAssetFilePath = AssetObject.CreateByAssetBundle(filePath, ab);
				byAssetFilePath.AddRef();
				OnLoadCallbackImp(filePath, mLoadScript, byAssetFilePath, string.Empty);
			}
			else
			{
				AssertRequest assertRequest = new AssertRequest();
				assertRequest.filePath = filePath;
				assertRequest.callbackScript = mLoadScript;
				mRequestList.Add(assertRequest);
				AssetBundleLoader.GetInstance().Load(filePath, LoadCallback);
			}
		}

		private void LoadCallback(string filePath, bool loadByWWW, WWW www, AssetBundle bundle, string err_msg)
		{
			AssetObject assetObject = null;
			assetObject = ((!loadByWWW) ? AssetObject.CreateByAssetBundle(filePath, bundle) : AssetObject.CreateByWWW(filePath, www));
			for (int num = mRequestList.Count - 1; num >= 0; num--)
			{
				if (mRequestList[num].filePath == filePath)
				{
					if (assetObject != null)
					{
						assetObject.AddRef();
					}
					OnLoadCallbackImp(mRequestList[num].filePath, mRequestList[num].callbackScript, assetObject, err_msg);
					mRequestList.RemoveAt(num);
				}
			}
			if (assetObject != null)
			{
				assetObject.DelRef();
			}
		}

		private void OnLoadCallbackImp(string filepath, string callbackScript, AssetObject assetObject, string err_msg)
		{
			ScriptManager.GetInstance().CallFunction(callbackScript, GetPid(), filepath, assetObject, err_msg);
		}
	}
}
