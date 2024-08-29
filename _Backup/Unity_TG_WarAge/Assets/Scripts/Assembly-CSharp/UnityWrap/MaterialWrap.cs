using System.Collections.Generic;
using Core;
using Core.Unity;
using UnityEngine;
using Wraper;

namespace UnityWrap
{
	public class MaterialWrap : RefObject
	{
		public static AssetObjectCache<int, MaterialWrap> cache = new AssetObjectCache<int, MaterialWrap>();

		private AssetObject assetObject;

		private Material m_material;

		public Material material
		{
			get
			{
				return m_material;
			}
		}

		public MaterialWrap()
		{
			lua_class_name = material_wraper.name;
		}

		public override void PrePushToLua()
		{
			AddRef();
		}

		public override void PostPushToLua()
		{
			DelRef();
		}

		public static MaterialWrap CreateByAssetObject(AssetObject asset)
		{
			MaterialWrap materialWrap = null;
			if (asset == null)
			{
				Core.Unity.Debug.LogError("[MaterialWrap CrateByAssetObject] error: asset is nil.");
			}
			else if (asset.mainAsset == null)
			{
				Core.Unity.Debug.LogError("[MaterialWrap CrateByAssetObject] error: asset.mainAsset is nil.");
			}
			else if (asset.mainAsset.GetType() != typeof(Material))
			{
				Core.Unity.Debug.LogError("[MaterialWrap CrateByAssetObject] error: asset type error:" + asset.GetType());
			}
			else
			{
				Material mat = (Material)asset.mainAsset;
				materialWrap = CreateInstance(mat);
				materialWrap.assetObject = asset;
				materialWrap.assetObject.AddRef();
			}
			return materialWrap;
		}

		public static MaterialWrap CreateInstance(Material mat)
		{
			if (mat == null)
			{
				Core.Unity.Debug.LogError("[MaterialWrap CreateInstance] error: material is null ");
				return null;
			}
			MaterialWrap materialWrap = new MaterialWrap();
			materialWrap.m_material = mat;
			cache.Add(materialWrap.GetPid(), materialWrap);
			return materialWrap;
		}

		public static void DestroyAll()
		{
			Dictionary<int, MaterialWrap> cacheMap = cache.cacheMap;
			foreach (MaterialWrap value in cacheMap.Values)
			{
				value.ClearResources(false);
			}
			cacheMap.Clear();
		}

		public override void ClearResources()
		{
			ClearResources(true);
		}

		public void ClearResources(bool needRemove)
		{
			if (needRemove)
			{
				cache.Remove(GetPid());
			}
			Object.DestroyImmediate(m_material, true);
			if (assetObject != null)
			{
				assetObject.DelRef();
				assetObject = null;
			}
		}
	}
}
