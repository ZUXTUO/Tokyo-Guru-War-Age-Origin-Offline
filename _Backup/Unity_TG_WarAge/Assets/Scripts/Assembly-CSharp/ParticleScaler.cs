using UnityEngine;

[ExecuteInEditMode]
public class ParticleScaler : MonoBehaviour
{
	public float particleScale = 1f;

	public bool alsoScaleGameobject = true;

	public bool usingScreenAdapt;

	private float prevScale;

	private void Start()
	{
		prevScale = particleScale;
	}

	private void Update()
	{
		if (usingScreenAdapt)
		{
			particleScale = (float)Screen.width / (float)Screen.height / 16f * 9f;
		}
		if (prevScale != particleScale && particleScale > 0f)
		{
			if (alsoScaleGameobject)
			{
				base.transform.localScale = new Vector3(particleScale, particleScale, particleScale);
			}
			float scaleFactor = particleScale / prevScale;
			ScaleLegacySystems(scaleFactor);
			ScaleShurikenSystems(scaleFactor);
			ScaleTrailRenderers(scaleFactor);
			prevScale = particleScale;
		}
	}

	private void ScaleShurikenSystems(float scaleFactor)
	{
		ParticleSystem[] componentsInChildren = GetComponentsInChildren<ParticleSystem>();
		ParticleSystem[] array = componentsInChildren;
		foreach (ParticleSystem particleSystem in array)
		{
			particleSystem.startSpeed *= scaleFactor;
			particleSystem.startSize *= scaleFactor;
			particleSystem.gravityModifier *= scaleFactor;
		}
	}

	private void ScaleLegacySystems(float scaleFactor)
	{
		ParticleEmitter[] componentsInChildren = GetComponentsInChildren<ParticleEmitter>();
		ParticleAnimator[] componentsInChildren2 = GetComponentsInChildren<ParticleAnimator>();
		ParticleEmitter[] array = componentsInChildren;
		foreach (ParticleEmitter particleEmitter in array)
		{
			particleEmitter.minSize *= scaleFactor;
			particleEmitter.maxSize *= scaleFactor;
			particleEmitter.worldVelocity *= scaleFactor;
			particleEmitter.localVelocity *= scaleFactor;
			particleEmitter.rndVelocity *= scaleFactor;
		}
		ParticleAnimator[] array2 = componentsInChildren2;
		foreach (ParticleAnimator particleAnimator in array2)
		{
			particleAnimator.force *= scaleFactor;
			particleAnimator.rndForce *= scaleFactor;
		}
	}

	private void ScaleTrailRenderers(float scaleFactor)
	{
		TrailRenderer[] componentsInChildren = GetComponentsInChildren<TrailRenderer>();
		TrailRenderer[] array = componentsInChildren;
		foreach (TrailRenderer trailRenderer in array)
		{
			trailRenderer.startWidth *= scaleFactor;
			trailRenderer.endWidth *= scaleFactor;
		}
	}
}
