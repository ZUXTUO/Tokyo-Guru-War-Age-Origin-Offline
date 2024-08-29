namespace Core.Util
{
	public class MD5Long
	{
		public ulong md51;

		public ulong md52;

		public MD5Long()
		{
		}

		public MD5Long(ulong md51, ulong md52)
		{
			this.md51 = md51;
			this.md52 = md52;
		}

		public override bool Equals(object obj)
		{
			if (!(obj is MD5Long))
			{
				return false;
			}
			MD5Long mD5Long = obj as MD5Long;
			return md51 == mD5Long.md51 && md52 == mD5Long.md52;
		}

		public override int GetHashCode()
		{
			return (md51 + md52).GetHashCode();
		}

		public static bool operator ==(MD5Long a, MD5Long b)
		{
			return a.md51 == b.md51 && a.md52 == b.md52;
		}

		public static bool operator !=(MD5Long a, MD5Long b)
		{
			return a.md51 != b.md51 || a.md52 != b.md52;
		}
	}
}
