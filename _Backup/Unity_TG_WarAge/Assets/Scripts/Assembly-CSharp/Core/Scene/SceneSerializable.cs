using System.IO;

namespace Core.Scene
{
	public class SceneSerializable
	{
		protected MemoryStream tmpMemoryStream;

		protected BinaryWriter srcBinaryWrite;

		protected long startPos;

		protected int dataLen;

		public void StartSerial(ref BinaryWriter bw)
		{
			srcBinaryWrite = bw;
			tmpMemoryStream = new MemoryStream();
			bw = new BinaryWriter(tmpMemoryStream);
		}

		public void EndSerial()
		{
			byte[] buffer = tmpMemoryStream.GetBuffer();
			int num = (int)tmpMemoryStream.Position;
			srcBinaryWrite.Write(num);
			srcBinaryWrite.Write(buffer, 0, num);
		}

		public int StartUnserial(BinaryReader br)
		{
			dataLen = br.ReadInt32();
			startPos = br.BaseStream.Position;
			return dataLen;
		}

		public void EndUnserial(BinaryReader br)
		{
			br.BaseStream.Position = dataLen + startPos;
		}
	}
}
