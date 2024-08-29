using System.Collections.Generic;
using UnityEngine;

namespace Core.Resource
{
	public class AssetBundleRequest
	{
		public string m_filepath = string.Empty;

		public int type;

		public AssertLoadCallback m_callback;

		public AssertLoadCallback m_texcallback;

		public SharedAtlasLoadCallback m_scallback;

		public List<AssertLoadCallback> m_addedcallback;

		public List<string> m_addedrefAbPaths;

		public bool m_loadByWWW = true;

		public bool m_processed;

		public AssetBundleCreateRequest m_abcr;

		public WWW m_www;

		public AssetBundle m_assetBundle;

		public string refAbPath = string.Empty;

		public string m_msg = string.Empty;
	}
}
