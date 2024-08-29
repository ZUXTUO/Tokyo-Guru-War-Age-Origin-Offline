using System.Collections.Generic;
using System.IO;
using System.Text;

namespace Core.Scene
{
	public class SceneInfo4 : SceneSerializable
	{
		public string name = string.Empty;

		public string mainAsset = string.Empty;

		public List<string> resources = new List<string>();

		public List<string> textureNames = new List<string>();

		public SceneSkybox4 sceneSkybox = new SceneSkybox4();

		public int lightmapLoadPriority;

		public List<SceneLightData4> lightmaps = new List<SceneLightData4>();

		public List<SceneItem4> items = new List<SceneItem4>();

		public void serial(BinaryWriter bw)
		{
			StartSerial(ref bw);
			ScenePrintUtil.Log(" 1 serial :{0}", bw.BaseStream.Position);
			bw.Write(name);
			bw.Write(mainAsset);
			serialResources(bw);
			ScenePrintUtil.Log(" 2 serial :{0}", bw.BaseStream.Position);
			bw.Write(textureNames.Count);
			for (int i = 0; i < textureNames.Count; i++)
			{
				bw.Write(textureNames[i]);
			}
			ScenePrintUtil.Log(" 3 serial :{0}", bw.BaseStream.Position);
			sceneSkybox.serial(bw);
			ScenePrintUtil.Log(" 4 serial :{0}", bw.BaseStream.Position);
			bw.Write(lightmapLoadPriority);
			bw.Write(lightmaps.Count);
			for (int j = 0; j < lightmaps.Count; j++)
			{
				lightmaps[j].serial(bw);
			}
			ScenePrintUtil.Log(" 5 serial :{0}", bw.BaseStream.Position);
			bw.Write(items.Count);
			for (int k = 0; k < items.Count; k++)
			{
				items[k].serial(bw);
			}
			EndSerial();
		}

		public void unserial(BinaryReader br)
		{
			int num = (int)br.BaseStream.Position;
			int num2 = StartUnserial(br);
			if (num2 <= 0)
			{
				return;
			}
			int num3 = (int)br.BaseStream.Position - num;
			ScenePrintUtil.Log(string.Format("sceneinfo.unserial: 1 {0} {1}", num2, br.BaseStream.Position));
			if (br.BaseStream.Position - num3 < num2)
			{
				name = br.ReadString();
				mainAsset = br.ReadString();
				unserialResources(br);
			}
			ScenePrintUtil.Log(string.Format("sceneinfo.unserial: 2 {0} {1}", num2, br.BaseStream.Position));
			if (br.BaseStream.Position - num3 < num2)
			{
				int num4 = br.ReadInt32();
				textureNames = new List<string>();
				for (int i = 0; i < num4; i++)
				{
					textureNames.Add(br.ReadString());
				}
			}
			ScenePrintUtil.Log(string.Format("sceneinfo.unserial: 3 {0} {1}", num2, br.BaseStream.Position));
			if (br.BaseStream.Position - num3 < num2)
			{
				sceneSkybox.unserial(br);
			}
			ScenePrintUtil.Log(string.Format("sceneinfo.unserial: 4 {0} {1}", num2, br.BaseStream.Position));
			if (br.BaseStream.Position - num3 < num2)
			{
				lightmapLoadPriority = br.ReadInt32();
				int num5 = br.ReadInt32();
				lightmaps = new List<SceneLightData4>();
				for (int j = 0; j < num5; j++)
				{
					SceneLightData4 sceneLightData = new SceneLightData4();
					sceneLightData.unserial(br);
					lightmaps.Add(sceneLightData);
				}
			}
			ScenePrintUtil.Log(string.Format("sceneinfo.unserial: 5 {0} {1}", num2, br.BaseStream.Position));
			if (br.BaseStream.Position - num3 < num2)
			{
				int num6 = br.ReadInt32();
				ScenePrintUtil.Log("itemCount:{0}", num6);
				items = new List<SceneItem4>();
				for (int k = 0; k < num6; k++)
				{
					SceneItem4 sceneItem = new SceneItem4();
					sceneItem.unserial(br);
					items.Add(sceneItem);
				}
			}
			EndUnserial(br);
		}

		public void serialResources(BinaryWriter bw)
		{
			string text = "assetbundles/";
			string text2 = ".assetbundle";
			for (int i = 0; i < resources.Count; i++)
			{
				string text3 = resources[i];
				int num = text3.IndexOf(text);
				int num2 = text3.LastIndexOf(text2);
				if (num == 0 && num2 == text3.Length - text2.Length)
				{
					resources[i] = text3.Substring(text.Length, num2 - num - text.Length);
					continue;
				}
				return;
			}
			bw.Write(text);
			bw.Write(text2);
			bw.Write(resources.Count);
			for (int j = 0; j < resources.Count; j++)
			{
				bw.Write(resources[j]);
			}
		}

		public void unserialResources(BinaryReader br)
		{
			string empty = string.Empty;
			string empty2 = string.Empty;
			empty = br.ReadString();
			empty2 = br.ReadString();
			int num = br.ReadInt32();
			resources = new List<string>(num);
			for (int i = 0; i < num; i++)
			{
				StringBuilder stringBuilder = new StringBuilder();
				stringBuilder.Append(empty).Append(br.ReadString()).Append(empty2);
				resources.Add(stringBuilder.ToString());
			}
		}
	}
}
