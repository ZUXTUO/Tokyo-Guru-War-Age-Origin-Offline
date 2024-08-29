using UnityEngine;

namespace Core.Scene
{
	public class SceneAssetBundle
	{
		private AssetBundle assetbundle;

		private Object _mainAsset;

		private int _refCount = 1;

		private string _assetPath;

		private bool inRemove;

		public Object mainAsset
		{
			get
			{
				return _mainAsset;
			}
		}

		public int refCount
		{
			get
			{
				return _refCount;
			}
		}

		public string assetPath
		{
			get
			{
				return _assetPath;
			}
		}

		public SceneAssetBundle(string path, AssetBundle _ab, Object assetObj)
		{
			_assetPath = path;
			assetbundle = _ab;
			_mainAsset = assetObj;
		}

		public void Retain()
		{
			if (_refCount == 1 && inRemove)
			{
				inRemove = false;
				SceneResourceManager4.GetInstance().RemoveFromRemove(this);
			}
			_refCount++;
			ScenePrintUtil.Log("refCount++ {0} mainAsset:{1} {2}", _refCount, (_mainAsset != null) ? _mainAsset.GetInstanceID() : 0, _mainAsset);
		}

		public void Release()
		{
			_refCount--;
			ScenePrintUtil.Log("refCount-- {0} mainAsset:{1} {2}", _refCount, (_mainAsset != null) ? _mainAsset.GetInstanceID() : 0, _mainAsset);
			if (_refCount == 1)
			{
				inRemove = true;
				SceneResourceManager4.GetInstance().AddToRemove(this);
			}
		}

		public void Unload(bool unloadAllLoadedObjects)
		{
			assetbundle.Unload(unloadAllLoadedObjects);
		}
	}
}
