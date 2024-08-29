using System;
using System.Collections.Generic;
using Core.Unity;
using UnityEngine;
using Wraper;

namespace UnityWrap
{
	public class NGUIAtlasWrap : NGUIBase
	{
		public static AssetObjectCache<int, NGUIAtlasWrap> cache = new AssetObjectCache<int, NGUIAtlasWrap>();

		protected AssetObject assetObject;

		public static List<Texture2D> addTextures = new List<Texture2D>();

		public UIAtlas component
		{
			get
			{
				return base._component as UIAtlas;
			}
		}

		public NGUIAtlasWrap()
		{
			lua_class_name = ngui_atlas_wraper.name;
		}

		public static NGUIAtlasWrap CreateByAssetObject(AssetObject asset, bool save)
		{
			NGUIAtlasWrap nGUIAtlasWrap = null;
			if (asset == null)
			{
				Core.Unity.Debug.LogError("[NGUIAtlasWrap CreateByAssetObject] CrateByAssetObject failed. asset is nil.");
			}
			else
			{
				GameObject gameObject = (GameObject)UnityEngine.Object.Instantiate(asset.mainAsset);
				UIAtlas uIAtlas = gameObject.GetComponent<UIAtlas>();
				nGUIAtlasWrap = new NGUIAtlasWrap();
				if (save)
				{
					nGUIAtlasWrap.assetObject = asset;
					nGUIAtlasWrap.assetObject.AddRef();
					asset.unloadAll = true;
				}
				else
				{
					asset.unloadAll = false;
				}
				nGUIAtlasWrap.InitInstance(uIAtlas);
				nGUIAtlasWrap.isNeedDestroy = true;
			}
			return nGUIAtlasWrap;
		}

		public static NGUIAtlasWrap CreateByTextures(int size, string shaderName = "Diffuse")
		{
			NGUIAtlasWrap nGUIAtlasWrap = null;
			if (addTextures.Count > 0)
			{
				List<UISpriteData> list = new List<UISpriteData>();
				Texture2D texture2D = new Texture2D(size, size);
				Rect[] array = texture2D.PackTextures(addTextures.ToArray(), 0, size);
				for (int i = 0; i < array.Length; i++)
				{
					UISpriteData uISpriteData = new UISpriteData();
					uISpriteData.name = addTextures[i].name;
					list.Add(uISpriteData);
					Rect rect = NGUIMath.ConvertToPixels(array[i], texture2D.width, texture2D.height, true);
					uISpriteData.SetRect((int)rect.x, (int)rect.y, (int)rect.width, (int)rect.height);
				}
				Shader shader = Shader.Find(shaderName);
				if (shader == null)
				{
					shader = Shader.Find("Diffuse");
				}
				Material material = new Material(shader);
				material.mainTexture = texture2D;
				nGUIAtlasWrap = new NGUIAtlasWrap();
				GameObject gameObject = new GameObject();
				UIAtlas uIAtlas = gameObject.AddComponent<UIAtlas>();
				uIAtlas.spriteList = list;
				uIAtlas.spriteMaterial = material;
				nGUIAtlasWrap.InitInstance(uIAtlas);
				nGUIAtlasWrap.isNeedDestroy = true;
			}
			addTextures.Clear();
			return nGUIAtlasWrap;
		}

		public override void InitInstance(Component component)
		{
			base.InitInstance(component);
			cache.Add(GetPid(), this);
		}

		public override void DestroyInstance()
		{
			base.DestroyInstance();
			cache.Remove(GetPid());
			if (assetObject != null)
			{
				assetObject.DelRef();
				assetObject = null;
			}
			else
			{
				Resources.UnloadAsset(component.spriteMaterial.mainTexture);
				Resources.UnloadAsset(component.spriteMaterial);
				Resources.UnloadUnusedAssets();
			}
		}

		public override void Clone(IntPtr L)
		{
			NGUIAtlasWrap base_object = NGUIWrap.Clone<NGUIAtlasWrap, UIAtlas>(this);
			WraperUtil.PushObject(L, base_object);
		}
	}
}
