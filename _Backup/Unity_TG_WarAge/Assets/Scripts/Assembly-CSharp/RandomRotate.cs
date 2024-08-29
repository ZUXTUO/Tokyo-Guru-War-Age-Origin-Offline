using UnityEngine;

public class RandomRotate : MonoBehaviour
{
	[Range(0f, 360f)]
	public int max_x_angle = 360;

	[Range(0f, 360f)]
	public int max_y_angle = 360;

	[Range(0f, 360f)]
	public int max_z_angle = 360;

	private void Awake()
	{
		int num = Random.Range(0, max_x_angle);
		int num2 = Random.Range(0, max_y_angle);
		int num3 = Random.Range(0, max_z_angle);
		base.gameObject.transform.Rotate(num, num2, num3);
	}
}
