namespace LostPolygon.DynamicWaterSystem
{
	public interface IDynamicWaterSettings : IDynamicWaterFluidVolumeSettings, IDynamicWaterFieldState
	{
		Vector2Int GridSize { get; }

		float NodeSize { get; }

		DynamicWaterSolver Solver { get; }

		bool CalculateNormals { get; }

		bool UseFakeNormals { get; }

		bool NormalizeFakeNormals { get; }

		bool SetTangents { get; }

		bool UseObstructions { get; }

		int MaxResolution();

		float MaxSpeed();
	}
}
