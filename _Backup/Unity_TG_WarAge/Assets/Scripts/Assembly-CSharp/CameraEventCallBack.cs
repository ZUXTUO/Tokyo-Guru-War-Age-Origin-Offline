using UnityEngine;

[RequireComponent(typeof(Camera))]
public class CameraEventCallBack : MonoBehaviour
{
	public delegate void OnPostRenderCall();

	public delegate void OnWillRenderCall();

	public OnPostRenderCall onPostRenderCall;

	public OnWillRenderCall onWillRenderCall;

	public bool isWillRenderCallOverDestroy;

	public bool isPostRenderCallOverDestroy;

	private void OnWillRenderObject()
	{
		if (onWillRenderCall != null)
		{
			onWillRenderCall();
		}
		if (isWillRenderCallOverDestroy)
		{
			Object.DestroyImmediate(this);
		}
	}

	private void OnPostRender()
	{
		if (onPostRenderCall != null)
		{
			onPostRenderCall();
		}
		if (isPostRenderCallOverDestroy)
		{
			Object.DestroyImmediate(this);
		}
	}
}
