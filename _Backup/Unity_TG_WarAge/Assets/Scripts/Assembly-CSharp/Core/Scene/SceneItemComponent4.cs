using System.Collections.Generic;
using System.IO;

namespace Core.Scene
{
	public class SceneItemComponent4 : SceneSerializable
	{
		public SceneItemComponentType4 type;

		public List<SceneAsset4> assets;

		public void serial(BinaryWriter bw)
		{
			StartSerial(ref bw);
			bw.Write((byte)type);
			if (assets != null)
			{
				bw.Write(assets.Count);
				for (int i = 0; i < assets.Count; i++)
				{
					assets[i].serial(bw);
				}
			}
			else
			{
				bw.Write(0);
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
			type = (SceneItemComponentType4)br.ReadByte();
			int num2 = br.ReadInt32();
			if (num2 > 0)
			{
				assets = new List<SceneAsset4>(num2);
				for (int i = 0; i < num2; i++)
				{
					SceneAsset4 sceneAsset = new SceneAsset4();
					sceneAsset.unserial(br);
					assets.Add(sceneAsset);
				}
			}
			EndUnserial(br);
		}
	}
}
