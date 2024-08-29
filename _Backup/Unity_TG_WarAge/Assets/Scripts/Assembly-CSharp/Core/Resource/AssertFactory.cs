using Core.Unity;
using Core.Util;
using UnityEngine;

namespace Core.Resource
{
	public class AssertFactory
	{
		public static AudioClip CreateAudioClip(string filePath, AssetBundle ab)
		{
			if (ab == null || ab.mainAsset == null)
			{
				return null;
			}
			AudioClip result = ab.mainAsset as AudioClip;
			ab.Unload(false);
			return result;
		}

		public static AudioClip CreateAudioClip(WWW www)
		{
			if (www.error != null)
			{
				return null;
			}
			string text = www.url.Substring(www.url.LastIndexOf('.') + 1);
			AudioClip audioClip = null;
			if (text == "assetbundle")
			{
				if (www.assetBundle == null)
				{
					return null;
				}
				string fileNameByPath = Utils.GetFileNameByPath(www.url);
				audioClip = www.assetBundle.LoadAsset<AudioClip>(fileNameByPath);
				www.assetBundle.Unload(false);
			}
			else
			{
				audioClip = www.GetAudioClip();
			}
			return audioClip;
		}

		public static Texture2D CreateTexture(string filePath, AssetBundle ab)
		{
			if (ab == null || ab.mainAsset == null)
			{
				UnityEngine.Debug.LogError("assetbundle name : " + filePath + " is null");
				return null;
			}
			Texture2D result = ab.mainAsset as Texture2D;
			if (!AssetBundleLoader.GetInstance().sharedAtlasDic.ContainsKey(filePath))
			{
				ab.Unload(false);
			}
			return result;
		}

		public static Texture2D CreateTexture(WWW www, string filePath)
		{
			if (www.error != null)
			{
				return null;
			}
			string text = www.url.Substring(www.url.LastIndexOf('.') + 1);
			Texture2D texture2D = null;
			if (text == "assetbundle")
			{
				if (www.assetBundle == null)
				{
					return null;
				}
				texture2D = www.assetBundle.mainAsset as Texture2D;
				if (!AssetBundleLoader.GetInstance().sharedAtlasDic.ContainsKey(filePath))
				{
					www.assetBundle.Unload(false);
				}
			}
			else
			{
				texture2D = www.texture;
			}
			return texture2D;
		}

		public static RuntimeAnimatorController CreateanController(string filePath, AssetBundle ab)
		{
			if (null == ab && null != ab.mainAsset)
			{
				return null;
			}
			RuntimeAnimatorController result = ab.mainAsset as RuntimeAnimatorController;
			ab.Unload(false);
			return result;
		}

		public static RuntimeAnimatorController CreateanController(WWW www)
		{
			if (www.error != null)
			{
				return null;
			}
			string text = www.url.Substring(www.url.LastIndexOf('.') + 1);
			RuntimeAnimatorController result = null;
			if (text == "assetbundle")
			{
				if (www.assetBundle == null)
				{
					return null;
				}
				result = www.assetBundle.mainAsset as RuntimeAnimatorController;
				www.assetBundle.Unload(false);
			}
			else
			{
				Core.Unity.Debug.LogWarning("动画文件后缀名必需是assetbundle:" + www.url);
			}
			return result;
		}
	}
}
