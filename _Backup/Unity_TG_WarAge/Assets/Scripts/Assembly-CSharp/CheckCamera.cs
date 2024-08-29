using UnityEngine;

public class CheckCamera : MonoBehaviour
{
	private Camera cam;

	private int mark;

	public static bool isOpen = true;

	private void Start()
	{
		cam = base.gameObject.GetComponent<Camera>();
		string[] layerNames = new string[1] { "ngui" };
		mark = LayerMask.GetMask(layerNames);
	}

	private void LateUpdate()
	{
		if (!isOpen)
		{
			return;
		}
		Camera[] allCameras = Camera.allCameras;
		bool flag = true;
		foreach (Camera camera in allCameras)
		{
			if (camera.cullingMask != mark && !(camera == cam) && camera.enabled && flag)
			{
				flag = false;
			}
		}
		if (cam.enabled != flag)
		{
			cam.enabled = flag;
		}
	}
}
