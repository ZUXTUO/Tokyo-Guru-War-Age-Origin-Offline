using System.Collections.Generic;
using System.IO;
using UnityEngine;

namespace Core.Scene
{
	public class SceneItem4 : SceneSerializable
	{
		public float posX;

		public float posY;

		public float posZ;

		public string nameKey = string.Empty;

		public int priority;

		public SceneItemType4 type;

		public GameObject go;

		public List<SceneItemComponent4> nodes = new List<SceneItemComponent4>();

		public void serial(BinaryWriter bw)
		{
			StartSerial(ref bw);
			bw.Write(posX);
			bw.Write(posY);
			bw.Write(posZ);
			bw.Write(nameKey);
			bw.Write((byte)type);
			bw.Write(priority);
			if (nodes != null)
			{
				bw.Write(nodes.Count);
				for (int i = 0; i < nodes.Count; i++)
				{
					nodes[i].serial(bw);
				}
			}
			else
			{
				bw.Write(0);
			}
			ScenePrintUtil.Log("serial SceneItem4 go:{0}, pos:{1} {2} {3}, src_pos:{4} {5} {6}", go.name, posX, posY, posZ, go.transform.localPosition.x, go.transform.localPosition.y, go.transform.localPosition.z);
			EndSerial();
		}

		public void unserial(BinaryReader br)
		{
			int num = StartUnserial(br);
			if (num <= 0)
			{
				return;
			}
			posX = br.ReadSingle();
			posY = br.ReadSingle();
			posZ = br.ReadSingle();
			nameKey = br.ReadString();
			type = (SceneItemType4)br.ReadByte();
			priority = br.ReadInt32();
			int num2 = br.ReadInt32();
			if (num2 > 0)
			{
				nodes = new List<SceneItemComponent4>(num2);
				for (int i = 0; i < num2; i++)
				{
					SceneItemComponent4 sceneItemComponent = new SceneItemComponent4();
					sceneItemComponent.unserial(br);
					nodes.Add(sceneItemComponent);
				}
			}
			EndUnserial(br);
		}
	}
}
