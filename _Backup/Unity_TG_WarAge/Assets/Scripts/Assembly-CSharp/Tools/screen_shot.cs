using System.Collections;
using UnityEngine;

namespace Tools
{
	public class screen_shot : MonoBehaviour
	{
		public static screen_shot ss;

		public void Init()
		{
			ss = this;
		}

		public void StartScreenShot(Camera camera, Rect rect, UITexture text)
		{
			StartCoroutine(CaptureCamera(camera, rect, text));
		}

		private IEnumerator CaptureCamera(Camera camera, Rect rect, UITexture imgPath)
		{
			RenderTexture rt = (camera.targetTexture = new RenderTexture((int)rect.width, (int)rect.height, 24));
			camera.Render();
			yield return new WaitForEndOfFrame();
			RenderTexture.active = rt;
			Texture2D screenShot = new Texture2D((int)rect.width, (int)rect.height, TextureFormat.RGB24, false);
			screenShot.ReadPixels(rect, 0, 0);
			screenShot.Apply();
			camera.targetTexture = null;
			RenderTexture.active = null;
			Object.Destroy(rt);
			yield return new WaitForEndOfFrame();
			imgPath.mainTexture = screenShot;
			imgPath.mainTexture.wrapMode = TextureWrapMode.Clamp;
			imgPath.gameObject.SetActive(true);
		}
	}
}
