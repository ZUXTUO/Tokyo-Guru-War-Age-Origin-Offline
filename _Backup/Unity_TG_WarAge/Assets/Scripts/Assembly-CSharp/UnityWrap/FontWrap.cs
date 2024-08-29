using System.Collections.Generic;
using Core;
using Core.Unity;
using UnityEngine;
using Wraper;

namespace UnityWrap
{
	public class FontWrap : RefObject
	{
		public static AssetObjectCache<int, FontWrap> cache = new AssetObjectCache<int, FontWrap>();

		private AssetObject assetObject;

		private Font m_font;

		public Font component
		{
			get
			{
				return m_font;
			}
		}

		public FontWrap()
		{
			lua_class_name = font_wraper.name;
		}

		public override void PrePushToLua()
		{
			AddRef();
		}

		public override void PostPushToLua()
		{
			DelRef();
		}

		public static FontWrap CreateByAssetObject(AssetObject asset, bool save)
		{
			FontWrap fontWrap = null;
			if (asset == null)
			{
				Core.Unity.Debug.LogError("[NGUIFontWrap CreateByAssetObject] CrateByAssetObject failed. asset is nil.");
			}
			else
			{
				Font font = (Font)asset.mainAsset;
				fontWrap = CreateInstance(font);
				if (save)
				{
					fontWrap.assetObject = asset;
					fontWrap.assetObject.AddRef();
					asset.unloadAll = true;
				}
				else
				{
					asset.unloadAll = false;
				}
			}
			return fontWrap;
		}

		public static FontWrap CreateInstance(Font font)
		{
			if (font == null)
			{
				Core.Unity.Debug.LogError("[MaterialWrap CreateInstance] error: material is null ");
				return null;
			}
			FontWrap fontWrap = new FontWrap();
			fontWrap.m_font = font;
			cache.Add(fontWrap.GetPid(), fontWrap);
			return fontWrap;
		}

		public static void DestroyAll()
		{
			Dictionary<int, FontWrap> cacheMap = cache.cacheMap;
			foreach (FontWrap value in cacheMap.Values)
			{
				value.ClearResources(false);
			}
			cacheMap.Clear();
		}

		public override void ClearResources()
		{
			ClearResources(true);
		}

		public void ClearResources(bool needRemove)
		{
			if (needRemove)
			{
				cache.Remove(GetPid());
			}
			Object.DestroyImmediate(m_font, true);
			if (assetObject != null)
			{
				assetObject.DelRef();
				assetObject = null;
			}
		}
	}
}
