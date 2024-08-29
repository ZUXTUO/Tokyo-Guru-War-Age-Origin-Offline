namespace LostPolygon.DynamicWaterSystem
{
	public static class LinearWaveEqueationSolver
	{
		public const float MaxDt = 1.412f;

		public static void Solve(ref float[] field, ref float[] fieldNew, ref float[] fieldSpeed, bool[] fieldObstruction, Vector2Int gridSize, float timeDelta, float damping, out float maxValue)
		{
			maxValue = float.NegativeInfinity;
			bool flag = fieldObstruction == null;
			for (int i = 0; i < gridSize.y; i++)
			{
				int num = i * gridSize.x;
				for (int j = 0; j < gridSize.x; j++)
				{
					if (j > 0 && i > 0 && j < gridSize.x - 1 && i < gridSize.y - 1 && (flag || !fieldObstruction[num]))
					{
						float num2 = (field[num - 1] + field[num + 1] + field[num + gridSize.x] + field[num - gridSize.x]) * 0.25f - field[num];
						fieldSpeed[num] += num2 * timeDelta;
						fieldNew[num] = (field[num] + fieldSpeed[num]) * damping;
						float num3 = ((!(fieldNew[num] > 0f)) ? (0f - fieldNew[num]) : fieldNew[num]);
						if (num3 > maxValue)
						{
							maxValue = num3;
						}
					}
					num++;
				}
			}
		}
	}
}
