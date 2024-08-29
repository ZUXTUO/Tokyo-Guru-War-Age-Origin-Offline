using System.IO;

namespace Core.Scene
{
	public class SceneLightData4 : SceneSerializable
	{
		public int lightmapFarIndex = -1;

		public int lightmapNearIndex = -1;

		public void serial(BinaryWriter bw)
		{
			StartSerial(ref bw);
			bw.Write(lightmapFarIndex);
			bw.Write(lightmapNearIndex);
			EndSerial();
		}

		public void unserial(BinaryReader br)
		{
			int num = StartUnserial(br);
			if (num > 0)
			{
				lightmapFarIndex = br.ReadInt32();
				lightmapNearIndex = br.ReadInt32();
				EndUnserial(br);
			}
		}
	}
}
