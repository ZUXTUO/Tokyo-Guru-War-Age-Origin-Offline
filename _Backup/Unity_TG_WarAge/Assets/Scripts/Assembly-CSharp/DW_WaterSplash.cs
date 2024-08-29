using UnityEngine;

[RequireComponent(typeof(BuoyancyForce))]
public class DW_WaterSplash : MonoBehaviour
{
	public ParticleSystem SplashPrefab;

	public float SplashThreshold = 3.1f;

	private DynamicWater _water;

	public void OnFluidVolumeEnter(FluidVolume eventWater)
	{
		_water = eventWater as DynamicWater;
		if (!(_water == null) && _water.PlaneCollider != null)
		{
			MakeSplash(SplashPrefab, _water.PlaneCollider.ClosestPointOnBounds(base.transform.position));
		}
	}

	public void OnFluidVolumeExit(FluidVolume eventWater)
	{
		if (_water.PlaneCollider != null)
		{
			MakeSplash(SplashPrefab, _water.PlaneCollider.ClosestPointOnBounds(base.transform.position));
		}
		_water = null;
	}

	private void MakeSplash(ParticleSystem SplashPrefab, Vector3 position)
	{
		if (!(SplashPrefab == null) && !(Mathf.Abs(GetComponent<Rigidbody>().velocity.y) < SplashThreshold))
		{
			ParticleSystem particleSystem = Object.Instantiate(SplashPrefab, position, Quaternion.Euler(-90f, 0f, 0f));
			if (particleSystem != null)
			{
				Object.Destroy(particleSystem.gameObject, particleSystem.duration);
			}
		}
	}
}
