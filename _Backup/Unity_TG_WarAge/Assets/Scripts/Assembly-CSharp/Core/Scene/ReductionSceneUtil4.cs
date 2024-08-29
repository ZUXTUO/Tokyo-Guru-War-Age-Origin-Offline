using System.Collections.Generic;
using UnityEngine;

namespace Core.Scene
{
	public class ReductionSceneUtil4
	{
		public static GameObject FindGameObjectByItem(SceneItem4 item, GameObject[] gos)
		{
			GameObject result = null;
			Vector3 zero = Vector3.zero;
			for (int i = 0; i < gos.Length; i++)
			{
				zero = gos[i].transform.position;
				if (zero.x == item.posX && zero.y == item.posY && zero.z == item.posZ && (item.nameKey.Length == 0 || item.nameKey.Equals(gos[i].name)))
				{
					result = gos[i];
					break;
				}
			}
			return result;
		}

		public static GameObject FindRootGameObject(GameObject go)
		{
			Transform parent = go.transform.parent;
			while (parent != null)
			{
				go = parent.gameObject;
				parent = go.transform.parent;
			}
			return go;
		}

		public static SceneItem4 BinarySearch(SceneItem4[] items, GameObject go)
		{
			int out_idx = 0;
			return BinarySearch(items, go, out out_idx);
		}

		public static SceneItem4 BinarySearch(SceneItem4[] items, GameObject go, out int out_idx)
		{
			Vector3 position = go.transform.position;
			int num = 0;
			int num2 = items.Length - 1;
			int num3 = 0;
			while (num <= num2)
			{
				num3 = (num + num2) / 2;
				SceneItem4 sceneItem = items[num3];
				if (position.x < sceneItem.posX || (position.x == sceneItem.posX && position.y < sceneItem.posY) || (position.x == sceneItem.posX && position.y == sceneItem.posY && position.z < sceneItem.posZ))
				{
					num2 = num3 - 1;
					continue;
				}
				if (position.x > sceneItem.posX || position.y > sceneItem.posY || position.z > sceneItem.posZ)
				{
					num = num3 + 1;
					continue;
				}
				if (sceneItem.nameKey.Length == 0 || sceneItem.nameKey.Equals(go.name))
				{
					out_idx = num3;
					return sceneItem;
				}
				int num4 = 0;
				int num5 = items.Length;
				for (int num6 = num3 - 1; num6 >= 0; num6--)
				{
					SceneItem4 sceneItem2 = items[num6];
					if (sceneItem2.posX != position.x || sceneItem2.posY != position.y || sceneItem2.posZ != position.z)
					{
						num4 = num6 + 1;
						break;
					}
				}
				for (int i = num3 + 1; i < items.Length; i++)
				{
					SceneItem4 sceneItem3 = items[i];
					if (sceneItem3.posX != position.x || sceneItem3.posY != position.y || sceneItem3.posZ != position.z)
					{
						num5 = i - 1;
						break;
					}
				}
				for (int j = num4; j <= num5; j++)
				{
					if (items[j].nameKey.Equals(go.name))
					{
						out_idx = j;
						return items[j];
					}
				}
				break;
			}
			out_idx = -1;
			return null;
		}

		public static SceneResourceRequest4 CreateLoadTask(int pri, SceneAsset4 asset, Material material, List<string> resources, SceneResourceManager4 resMgr, SceneResourceCallback4 callback)
		{
			UseTime useTime = new UseTime();
			ScenePrintUtil.Log("CreateLoadTask enter");
			SceneResourceRequest4 result = null;
			if (asset != null && asset.dependencies != null && material != null && asset.Type.Equals(SceneAssetType4.Material))
			{
				useTime.PrintStep(" util create load task 1");
				ScenePrintUtil.Log(" CreateLoadTask " + asset.dependencies.Count);
				int count = asset.dependencies.Count;
				string[] array = new string[count];
				for (int i = 0; i < count; i++)
				{
					array[i] = string.Empty;
					SceneAsset4 sceneAsset = asset.dependencies[i];
					if (sceneAsset != null && sceneAsset.Type.Equals(SceneAssetType4.Texture) && sceneAsset.Index >= 0 && sceneAsset.Index < resources.Count)
					{
						array[i] = resources[sceneAsset.Index];
					}
					useTime.PrintStep(" util create load task 2");
				}
				result = resMgr.AddLoadTask(array, pri, callback, new SceneResourceCallbackData4(0, material, asset.dependencies));
				useTime.PrintStep(" util create load task 3");
			}
			return result;
		}
	}
}
