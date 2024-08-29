using UnityEngine;

namespace LostPolygon.DynamicWaterSystem
{
	public struct Vector3Int
	{
		public int x;

		public int y;

		public int z;

		public Vector3Int(int x, int y, int z)
		{
			this.x = x;
			this.y = y;
			this.z = z;
		}

		public static implicit operator Vector3Int(Vector3 value)
		{
			return new Vector3Int(Mathf.RoundToInt(value.x), Mathf.RoundToInt(value.y), Mathf.RoundToInt(value.z));
		}

		public override string ToString()
		{
			return "{" + x + ", " + y + ", " + z + "}";
		}
	}
}
