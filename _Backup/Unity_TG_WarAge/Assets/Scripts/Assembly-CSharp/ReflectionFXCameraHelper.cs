using UnityEngine;

public class ReflectionFXCameraHelper : MonoBehaviour
{
	public GameObject cameraObj;

	private void OnEnable()
	{
		SetCamera(cameraObj);
	}

	private void OnDisable()
	{
		SetCamera(null);
	}

	public void SetCamera(GameObject go)
	{
		Camera reflectionCamera = null;
		if (null != go)
		{
			reflectionCamera = go.GetComponent<Camera>();
		}
		ReflectionFx.SetReflectionCamera(reflectionCamera);
	}
}
