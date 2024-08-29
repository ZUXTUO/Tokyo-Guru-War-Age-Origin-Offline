using Core;
using Core.Resource;
using Core.Unity;
using Script;
using UnityEngine;
using Wraper;

namespace UnityWrap
{
	public class TextureWrap : BaseObject
	{
		public static AssetObjectCache<int, TextureWrap> cache = new AssetObjectCache<int, TextureWrap>();

		private static string mCallbackScript = string.Empty;

		private Texture mTexture;

		private bool isDestory = true;

		public Texture component
		{
			get
			{
				return mTexture;
			}
		}

		public TextureWrap()
		{
			lua_class_name = texture_wraper.name;
		}

		public static TextureWrap Load(string filepath)
		{
			Texture texture = Resources.Load(filepath, typeof(Texture)) as Texture;
			if (texture == null)
			{
				Core.Unity.Debug.LogError(string.Format("[TextureWrap Load] error: Resources.Load( {0} ) get null texture", filepath));
				return null;
			}
			return CreateInstance(texture);
		}

		public static TextureWrap Create(int width, int height)
		{
			return CreateInstance(new Texture2D(width, height));
		}

		public static void Load(string filepath, string callback)
		{
			mCallbackScript = callback;
			if (AssetBundleLoader.GetInstance().sharedAtlasDic.ContainsKey(filepath))
			{
				AssetBundle ab = AssetBundleLoader.GetInstance().sharedAtlasDic[filepath].ab;
				if (ab != null && ab.mainAsset != null)
				{
					LoadCallback(filepath, false, null, ab, null);
					return;
				}
				if (ab != null)
				{
					ab.Unload(false);
				}
				AssetBundleLoader.GetInstance().sharedAtlasDic.Remove(filepath);
				if (!AssetBundleLoader.GetInstance().Load(filepath, LoadCallback))
				{
					OnLoadCallbackImp(filepath, null, "[TextureWrap Load] The same file to be load");
				}
			}
			else if (!AssetBundleLoader.GetInstance().Load(filepath, LoadCallback))
			{
				OnLoadCallbackImp(filepath, null, "[TextureWrap Load] The same file to be load");
			}
		}

		private static void LoadCallback(string filepath, bool loadByWWW, WWW www, AssetBundle assetBundle, string err_msg)
		{
			string text = filepath.Substring(filepath.LastIndexOf('/') + 1);
			Texture2D texture2D = null;
			texture2D = ((!loadByWWW) ? AssertFactory.CreateTexture(filepath, assetBundle) : AssertFactory.CreateTexture(www, filepath));
			if (texture2D != null)
			{
				texture2D.name = text.Substring(0, text.LastIndexOf('.'));
				texture2D.wrapMode = TextureWrapMode.Clamp;
			}
			TextureWrap textureObject = CreateInstance(texture2D);
			OnLoadCallbackImp(filepath, textureObject, err_msg);
		}

		private static void OnLoadCallbackImp(string filepath, TextureWrap textureObject, string err_msg)
		{
			int num = -1;
			if (textureObject != null)
			{
				num = textureObject.GetPid();
			}
			ScriptManager.GetInstance().CallFunction(mCallbackScript, num, filepath, textureObject, err_msg);
		}

		public static TextureWrap CreateInstance(Texture com, bool destory = true)
		{
			if (com == null)
			{
				Core.Unity.Debug.LogError("[TextureWrap CreateInstance] error: texture is null ");
				return null;
			}
			TextureWrap textureWrap = new TextureWrap();
			textureWrap.mTexture = com;
			textureWrap.isDestory = destory;
			cache.Add(textureWrap.GetPid(), textureWrap);
			return textureWrap;
		}

		public static void DestroyInstance(TextureWrap obj)
		{
			if (obj != null)
			{
				cache.Remove(obj.GetPid());
				if (obj.mTexture != null && obj.isDestory)
				{
					Object.DestroyImmediate(obj.mTexture, true);
					obj.mTexture = null;
				}
			}
		}
	}
}
