using System.Collections.Generic;
using System.IO;
using UnityEngine;

namespace Core.Scene
{
	public class SceneAsset4 : SceneSerializable
	{
		public int Key;

		public SceneAssetType4 Type;

		public int Index;

		public List<SceneAsset4> dependencies;

		public object sObj;

		public Object uObj;

		public void serial(BinaryWriter bw)
		{
			StartSerial(ref bw);
			bw.Write(Key);
			bw.Write((byte)Type);
			bw.Write(Index);
			bw.Write((dependencies != null) ? dependencies.Count : 0);
			if (dependencies != null)
			{
				for (int i = 0; i < dependencies.Count; i++)
				{
					dependencies[i].serial(bw);
				}
			}
			EndSerial();
		}

		public void unserial(BinaryReader br)
		{
			int num = StartUnserial(br);
			if (num <= 0)
			{
				return;
			}
			Key = br.ReadInt32();
			Type = (SceneAssetType4)br.ReadByte();
			Index = br.ReadInt32();
			int num2 = br.ReadInt32();
			if (num2 > 0)
			{
				dependencies = new List<SceneAsset4>(num2);
				for (int i = 0; i < num2; i++)
				{
					SceneAsset4 sceneAsset = new SceneAsset4();
					sceneAsset.unserial(br);
					dependencies.Add(sceneAsset);
				}
			}
			EndUnserial(br);
		}
	}
}
