using Core.Unity;
using UnityEngine;
using Wraper;

namespace UnityWrap
{
	public class NGUIFontWrap : NGUIBase
	{
		public static AssetObjectCache<int, NGUIFontWrap> cache = new AssetObjectCache<int, NGUIFontWrap>();

		protected AssetObject assetObject;

		public UIFont component
		{
			get
			{
				return base._component as UIFont;
			}
		}

		public NGUIFontWrap()
		{
			lua_class_name = ngui_font_wraper.name;
		}

		public static NGUIFontWrap CreateByAssetObject(AssetObject asset, bool save)
		{
			NGUIFontWrap nGUIFontWrap = null;
			if (asset == null)
			{
				Core.Unity.Debug.LogError("[NGUIFontWrap CreateByAssetObject] CrateByAssetObject failed. asset is nil.");
			}
			else
			{
				GameObject gameObject = (GameObject)Object.Instantiate(asset.mainAsset);
				UIFont uIFont = gameObject.GetComponent<UIFont>();
				nGUIFontWrap = new NGUIFontWrap();
				if (save)
				{
					nGUIFontWrap.assetObject = asset;
					nGUIFontWrap.assetObject.AddRef();
					asset.unloadAll = true;
				}
				else
				{
					asset.unloadAll = false;
				}
				nGUIFontWrap.InitInstance(uIFont);
				nGUIFontWrap.isNeedDestroy = true;
			}
			return nGUIFontWrap;
		}

		public static NGUIFontWrap CreateInstance(UIFont uiFont)
		{
			if (uiFont == null)
			{
				Core.Unity.Debug.LogError("[MaterialWrap CreateInstance] error: material is null ");
				return null;
			}
			NGUIFontWrap nGUIFontWrap = new NGUIFontWrap();
			nGUIFontWrap.InitInstance(uiFont);
			return nGUIFontWrap;
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
			Resources.UnloadUnusedAssets();
		}
	}
}
