using UnityEngine;

namespace Core.Resource
{
	public delegate void AssertLoadCallback(string filePath, bool loadByWWW, WWW www, AssetBundle bundle, string errMsg);
}
