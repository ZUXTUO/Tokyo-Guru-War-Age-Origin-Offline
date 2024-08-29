using UnityEngine;

public class cameraReset : MonoBehaviour
{
	private void OnApplicationFocus(bool pause)
	{
		Camera component = base.gameObject.GetComponent<Camera>();
		if (component != null)
		{
			component.ResetAspect();
		}
	}
}
