using UnityEngine;

namespace ComponentEx
{
	public class CameraFollow : MonoBehaviour
	{
		public float yAngle;

		public float xAngle;

		public float zDistance;

		public GameObject target;

		private void Update()
		{
			if (target != null)
			{
				Quaternion quaternion = Quaternion.Euler(yAngle, xAngle, 0f);
				base.gameObject.transform.position = target.transform.position + quaternion * new Vector3(0f, 0f, zDistance);
				base.gameObject.transform.LookAt(target.transform);
			}
		}
	}
}
