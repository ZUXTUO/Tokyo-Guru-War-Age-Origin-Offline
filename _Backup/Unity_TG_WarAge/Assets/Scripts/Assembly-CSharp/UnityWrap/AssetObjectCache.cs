using System.Collections.Generic;

namespace UnityWrap
{
	public class AssetObjectCache<K, T>
	{
		public Dictionary<K, T> cacheMap = new Dictionary<K, T>();

		public T Find(K id)
		{
			if (cacheMap.ContainsKey(id))
			{
				return cacheMap[id];
			}
			return default(T);
		}

		public void Add(K id, T obj)
		{
			Remove(id);
			cacheMap.Add(id, obj);
		}

		public bool Remove(K id)
		{
			return cacheMap.Remove(id);
		}
	}
}
