using System.IO;

namespace Core.Scene
{
	public class SceneBinaryWriter4 : BinaryWriter
	{
		public SceneBinaryWriter4(Stream output)
			: base(output)
		{
		}

		public override void Write(int value)
		{
			base.Write(value);
		}
	}
}
