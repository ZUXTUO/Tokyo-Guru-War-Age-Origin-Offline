using System.Collections.Generic;
using Core;
using UnityEngine;

namespace UnityWrap
{
	public class LightmapSettingsWrap : BaseObject
	{
		public static AssetObjectCache<int, LightmapSettingsWrap> cache = new AssetObjectCache<int, LightmapSettingsWrap>();

		public static List<Texture2D> addTextures = new List<Texture2D>();

		public static void ReplaceTextures()
		{
			if (addTextures.Count > 0)
			{
				LightmapData[] array = new LightmapData[addTextures.Count];
				for (int i = 0; i < array.Length; i++)
				{
					array[i].lightmapColor = addTextures[i];
				}
				LightmapSettings.lightmaps = array;
				addTextures.Clear();
			}
		}
	}
}
