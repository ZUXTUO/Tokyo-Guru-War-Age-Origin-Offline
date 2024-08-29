using UnityEngine;

public class FixRenderOrder : MonoBehaviour
{
	private void LateUpdate()
	{
		if (!GhoulAfterEffects.isSetRenderBuffer)
		{
			GhoulAfterEffects.isSetRenderBuffer = true;
			GhoulAfterEffects.mainDisplayColorBuffer = Graphics.activeColorBuffer;
			GhoulAfterEffects.mainDisplayDepthBuffer = Graphics.activeDepthBuffer;
		}
		Camera[] allCameras = Camera.allCameras;
		foreach (Camera camera in allCameras)
		{
			if (camera != null && !camera.orthographic && camera.targetTexture == null)
			{
				camera.useOcclusionCulling = false;
				camera.SetTargetBuffers(GhoulAfterEffects.mainDisplayColorBuffer, GhoulAfterEffects.mainDisplayDepthBuffer);
			}
		}
	}
}
