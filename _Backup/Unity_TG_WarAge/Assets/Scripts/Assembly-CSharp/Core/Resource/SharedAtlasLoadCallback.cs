using UnityEngine;

namespace Core.Resource
{
	public delegate void SharedAtlasLoadCallback(string filePath, bool loadByWWW, WWW www, AssetBundle bundle, string abPath, AssertLoadCallback lastCallback, string errMsg);
}
