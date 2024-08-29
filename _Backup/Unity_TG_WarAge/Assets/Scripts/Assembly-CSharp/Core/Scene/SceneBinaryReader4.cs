using System.IO;

namespace Core.Scene
{
	public class SceneBinaryReader4 : BinaryReader
	{
		public SceneBinaryReader4(Stream input)
			: base(input)
		{
		}

		public override int ReadInt32()
		{
			return base.ReadInt32();
		}
	}
}
