using UnityEngine;

internal class AndroidAssetsLoader
{
	private static AndroidJavaClass m_AssetLoaderClass;

	public static byte[] LoadAssetEx(string fileName)
	{
		if (m_AssetLoaderClass == null)
		{
			m_AssetLoaderClass = new AndroidJavaClass("com.digitalsky.ghoul.reader.AssetReaderEx");
			if (m_AssetLoaderClass == null)
			{
				m_AssetLoaderClass = new AndroidJavaClass("com/digitalsky/ghoul/reader/AssetReaderEx");
			}
		}
		if (m_AssetLoaderClass == null)
		{
			return null;
		}
		return m_AssetLoaderClass.CallStatic<byte[]>("Load", new object[1] { fileName });
	}
}
