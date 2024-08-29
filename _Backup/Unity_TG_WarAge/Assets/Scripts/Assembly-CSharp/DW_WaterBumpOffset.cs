using UnityEngine;

public class DW_WaterBumpOffset : MonoBehaviour
{
	public Vector2 waveSpeed;

	public float waveScale;

	private float t;

	private Material mat;

	private Vector2 offsetClamped;

	private Vector3 scale;

	private Matrix4x4 scrollMatrix;

	private void Start()
	{
		mat = GetComponent<Renderer>().sharedMaterial;
	}

	private void Update()
	{
		t = Time.time / 20f;
		Vector4 vector = waveSpeed * (t * waveScale);
		offsetClamped.x = Mathf.Repeat(vector.x, 1f);
		offsetClamped.y = Mathf.Repeat(vector.y, 1f);
		mat.SetTextureOffset("_BumpMap", offsetClamped);
		scale.x = 1f / waveScale;
		scale.y = 1f / waveScale;
		scale.z = 1f;
	}
}
