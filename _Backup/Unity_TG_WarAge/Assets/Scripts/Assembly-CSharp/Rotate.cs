using UnityEngine;

public class Rotate : MonoBehaviour
{
	public Vector3 axis;

	public float rate;

	private void Update()
	{
		base.transform.Rotate(axis * Time.deltaTime * rate);
	}
}
