using System.IO;
using System.Text;

namespace Core.Unity
{
	public class Convert
	{
		public static uint ReadUint(Stream s)
		{
			BinaryReader binaryReader = new BinaryReader(s);
			return binaryReader.ReadUInt32();
		}

		public static int ReadInt(Stream s)
		{
			BinaryReader binaryReader = new BinaryReader(s);
			return binaryReader.ReadInt32();
		}

		public static byte ReadByte(Stream s)
		{
			BinaryReader binaryReader = new BinaryReader(s);
			return binaryReader.ReadByte();
		}

		public static bool ReadBool(Stream s)
		{
			BinaryReader binaryReader = new BinaryReader(s);
			return binaryReader.ReadBoolean();
		}

		public static short ReadShort(Stream s)
		{
			BinaryReader binaryReader = new BinaryReader(s);
			return binaryReader.ReadInt16();
		}

		public static ushort ReadUShort(Stream s)
		{
			BinaryReader binaryReader = new BinaryReader(s);
			return binaryReader.ReadUInt16();
		}

		public static string ReadString(Stream s)
		{
			ushort num = ReadUShort(s);
			if (num == 0)
			{
				return string.Empty;
			}
			if ((int)num <= s.Length - s.Position)
			{
				byte[] array = new byte[num];
				s.Read(array, 0, num);
				return Encoding.UTF8.GetString(array);
			}
			return string.Empty;
		}
	}
}
