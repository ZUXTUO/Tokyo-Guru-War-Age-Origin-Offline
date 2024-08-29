using UnityEngine;

public class SetLightDir : MonoBehaviour
{
	public GameObject light;

	private Material m;

	private void Start()
	{
		m = GetComponent<Renderer>().material;
	}

	private void Update()
	{
		m.SetVector("_LightDir", new Vector4(0f - light.transform.forward.x, 0f - light.transform.forward.y, 0f - light.transform.forward.z, 0f));
	}
}
