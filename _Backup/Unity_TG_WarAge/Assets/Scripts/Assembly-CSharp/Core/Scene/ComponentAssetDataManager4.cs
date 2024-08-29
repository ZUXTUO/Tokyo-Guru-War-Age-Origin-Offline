using System.Collections.Generic;
using UnityEngine;

namespace Core.Scene
{
	public class ComponentAssetDataManager4
	{
		public static bool StopItemVisibleTask = false;

		private static Dictionary<Material, ComponentAssetData4> cache = new Dictionary<Material, ComponentAssetData4>();

		public static void Clear()
		{
			ScenePrintUtil.Log("ComponentAssetDataManager4.Clear");
			foreach (KeyValuePair<Material, ComponentAssetData4> item in cache)
			{
				ScenePrintUtil.Log("material:{0}, dataRefCount:{1}", item.Key, item.Value.refCount);
			}
			cache.Clear();
		}

		public static void Add(Material id, GameObject go)
		{
			if (cache.ContainsKey(id))
			{
				ComponentAssetData4 componentAssetData = cache[id];
				componentAssetData.refCount++;
				ScenePrintUtil.Log("component add materialName:{0} goID{1}, refCount:{2}", id.name, go.GetInstanceID(), componentAssetData.refCount);
			}
		}

		public static void Add(Material id, ComponentAssetData4 val, GameObject go)
		{
			ScenePrintUtil.Log("component add materialName:{0} goID{1}, refCount:{2}", id.name, go.GetInstanceID(), val.refCount);
			cache.Add(id, val);
		}

		public static bool Contains(Material id)
		{
			return cache.ContainsKey(id);
		}

		public static ComponentAssetData4 Remove(Material id, GameObject go)
		{
			if (cache.ContainsKey(id))
			{
				ComponentAssetData4 componentAssetData = cache[id];
				componentAssetData.refCount--;
				ScenePrintUtil.Log("component remove materialName:{0} goID:{1} refCount:{2}, totalRemaining:{3}", id.name, go.GetInstanceID(), componentAssetData.refCount, cache.Count);
				if (componentAssetData.refCount == 0)
				{
					cache.Remove(id);
					return componentAssetData;
				}
			}
			return null;
		}
	}
}
