using System;
using UnityEngine;

[Serializable]
[AddComponentMenu("Camera-Control/Smooth Look At")]
public class SmoothLookAt : MonoBehaviour
{
	public Transform target;

	public float damping;

	public bool smooth;

	public SmoothLookAt()
	{
		damping = 6f;
		smooth = true;
	}

	public virtual void LateUpdate()
	{
		if ((bool)target)
		{
			if (smooth)
			{
				Quaternion b = Quaternion.LookRotation(target.position - transform.position);
				transform.rotation = Quaternion.Slerp(transform.rotation, b, Time.deltaTime * damping);
			}
			else
			{
				transform.LookAt(target);
				transform.localEulerAngles = new Vector3(transform.localEulerAngles.x, transform.localEulerAngles.y, 0f);
			}
		}
	}

	public virtual void Start()
	{
		if ((bool)GetComponent<Rigidbody>())
		{
			GetComponent<Rigidbody>().freezeRotation = true;
		}
	}

	public virtual void Main()
	{
	}
}
