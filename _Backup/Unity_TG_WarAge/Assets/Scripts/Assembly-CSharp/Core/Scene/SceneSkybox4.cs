using System.IO;

namespace Core.Scene
{
	public class SceneSkybox4 : SceneSerializable
	{
		public SceneAsset4 textureAsset;

		public void serial(BinaryWriter bw)
		{
			StartSerial(ref bw);
			if (textureAsset != null)
			{
				bw.Write(true);
				textureAsset.serial(bw);
			}
			else
			{
				bw.Write(false);
			}
			EndSerial();
		}

		public void unserial(BinaryReader br)
		{
			int num = StartUnserial(br);
			if (num > 0)
			{
				bool flag = false;
				flag = br.ReadBoolean();
				textureAsset = null;
				if (flag)
				{
					textureAsset = new SceneAsset4();
					textureAsset.unserial(br);
				}
				EndUnserial(br);
			}
		}
	}
}
