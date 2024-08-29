using UnityEngine;

namespace LostPolygon.DynamicWaterSystem
{
	public struct Vector2Int
	{
		public int x;

		public int y;

		public Vector2Int(int x, int y)
		{
			this.x = x;
			this.y = y;
		}

		public Vector2Int(Vector2 value)
		{
			x = (int)value.x;
			y = (int)value.y;
		}

		public static implicit operator Vector2Int(Vector2 value)
		{
			return new Vector2Int((int)value.x, (int)value.y);
		}

		public override string ToString()
		{
			return "{" + x + ", " + y + "}";
		}
	}
}
