using UnityEngine;

public class GhoulCallAfterEffect : MonoBehaviour
{
	[Range(0f, 1.5f)]
	public float threshhold = 0.5f;

	[Range(0f, 5f)]
	public float intensity = 2f;

	[Range(0.25f, 5.5f)]
	public float blurSize = 5f;

	[Range(1f, 4f)]
	public int blurIterations = 2;

	private void Start()
	{
		Camera component = GetComponent<Camera>();
		if (component == null)
		{
			base.enabled = false;
			return;
		}
		GhoulAfterEffects component2 = GetComponent<GhoulAfterEffects>();
		if (component2 != null)
		{
			Object.Destroy(component2);
		}
		component2 = base.gameObject.AddComponent<GhoulAfterEffects>();
		component2.enabled = true;
		component2.enableDistortion = true;
		component2.enableBloom = true;
		component2.threshhold = threshhold;
		component2.intensity = intensity;
		component2.blurSize = blurSize;
		component2.blurIterations = blurIterations;
	}
}
