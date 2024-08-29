using UnityEngine;

public class CameraRenderEventCallBack : MonoBehaviour
{
	public delegate void CameraRenderEventCall();

	public CameraRenderEventCall preRenderCall;

	public CameraRenderEventCall postRenderCall;

	public CameraRenderEventCall preCullCall;

	private void OnPreCull()
	{
		if (preCullCall != null)
		{
			preCullCall();
		}
	}

	private void OnPreRender()
	{
		if (preRenderCall != null)
		{
			preRenderCall();
		}
	}

	private void OnPostRender()
	{
		if (postRenderCall != null)
		{
			postRenderCall();
		}
	}
}
