using UnityEngine;

public class MirrorCam : MonoBehaviour
{
	private Camera cam;

	private void Start()
	{
		cam = base.transform.GetComponent<Camera>();
		if (cam == null)
		{
			Debug.LogError("Need Camera");
			Object.Destroy(this);
		}
	}

	private void OnPreRender()
	{
		GL.invertCulling = true;
	}

	private void OnPostRender()
	{
		GL.invertCulling = false;
	}
}
