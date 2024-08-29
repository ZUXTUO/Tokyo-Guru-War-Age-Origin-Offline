using UnityEngine;

namespace LostPolygon.DynamicWaterSystem
{
	public interface IDynamicWaterFluidVolumeSettings : IDynamicWaterFieldState
	{
		Vector2 Size { get; set; }

		float Density { get; }

		BoxCollider Collider { get; }

		void CreateSplash(Vector3 center, float radius, float force);
	}
}
