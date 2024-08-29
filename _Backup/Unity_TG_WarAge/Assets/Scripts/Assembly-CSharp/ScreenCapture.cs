using System;
using System.Collections;
using System.IO;
using Core.Resource;
using LuaInterface;
using Script;
using UnityEngine;

public class ScreenCapture : MonoBehaviour
{
	private bool is_useing;

	private string m_onOkCallBack = string.Empty;

	private string m_serverPath = string.Empty;

	private int m_type;

	private static int tempFileCount;

	private void OnGUI()
	{
	}

	private void Update()
	{
	}

	public bool StartCapture(string path, string callback, int type)
	{
		if (is_useing)
		{
			return false;
		}
		m_serverPath = path;
		m_onOkCallBack = callback;
		m_type = type;
		if (m_serverPath != string.Empty)
		{
			switch (type)
			{
			case 1:
				SaveScreenshot(CaptureMethod.AppCapture_Asynch, FileUtil.GetWritePath(path));
				break;
			case 3:
				SaveScreenshot(CaptureMethod.ReadPixels_Asynch, FileUtil.GetWritePath(path));
				break;
			case 5:
				SaveScreenshot(CaptureMethod.RenderToTex_Asynch, FileUtil.GetWritePath(path));
				break;
			}
			is_useing = true;
		}
		return true;
	}

	public void SaveScreenshot(CaptureMethod method, string filePath)
	{
		switch (method)
		{
		case CaptureMethod.AppCapture_Asynch:
			Application.CaptureScreenshot(filePath);
			lua_call_back(filePath);
			break;
		case CaptureMethod.AppCapture_Synch:
		{
			Texture2D screenshot3 = GetScreenshot(CaptureMethod.AppCapture_Synch);
			byte[] bytes3 = screenshot3.EncodeToPNG();
			File.WriteAllBytes(filePath, bytes3);
			break;
		}
		case CaptureMethod.ReadPixels_Asynch:
			StartCoroutine(SaveScreenshot_ReadPixelsAsynch(filePath));
			break;
		case CaptureMethod.ReadPixels_Synch:
		{
			Texture2D screenshot2 = GetScreenshot(CaptureMethod.ReadPixels_Synch);
			byte[] bytes2 = screenshot2.EncodeToPNG();
			File.WriteAllBytes(filePath, bytes2);
			UnityEngine.Object.DestroyObject(screenshot2);
			break;
		}
		case CaptureMethod.RenderToTex_Asynch:
			StartCoroutine(SaveScreenshot_RenderToTexAsynch(filePath));
			break;
		default:
		{
			Texture2D screenshot = GetScreenshot(CaptureMethod.RenderToTex_Synch);
			byte[] bytes = screenshot.EncodeToPNG();
			File.WriteAllBytes(filePath, bytes);
			break;
		}
		}
	}

	private void lua_call_back(string filePath)
	{
		if (m_onOkCallBack != string.Empty)
		{
			ScriptCall scriptCall = ScriptCall.Create(m_onOkCallBack);
			if (scriptCall != null && scriptCall.Start())
			{
				LuaDLL.lua_newtable(scriptCall.L);
				scriptCall.lua_settable("path", filePath);
				scriptCall.Finish(1);
			}
			m_onOkCallBack = string.Empty;
		}
		is_useing = false;
	}

	private IEnumerator SaveScreenshot_ReadPixelsAsynch(string filePath)
	{
		yield return new WaitForEndOfFrame();
		Texture2D texture = new Texture2D(Screen.width, Screen.height, TextureFormat.RGB24, false);
		texture.ReadPixels(new Rect(0f, 0f, Screen.width, Screen.height), 0, 0);
		yield return 0;
		byte[] bytes = texture.EncodeToPNG();
		File.WriteAllBytes(filePath, bytes);
		UnityEngine.Object.DestroyObject(texture);
		lua_call_back(filePath);
	}

	private IEnumerator SaveScreenshot_RenderToTexAsynch(string filePath)
	{
		yield return new WaitForEndOfFrame();
		RenderTexture rt = new RenderTexture(Screen.width, Screen.height, 24);
		Texture2D screenShot = new Texture2D(Screen.width, Screen.height, TextureFormat.RGB24, false);
		Camera[] allCameras = Camera.allCameras;
		foreach (Camera camera in allCameras)
		{
			camera.targetTexture = rt;
			camera.Render();
			camera.targetTexture = null;
		}
		RenderTexture.active = rt;
		screenShot.ReadPixels(new Rect(0f, 0f, Screen.width, Screen.height), 0, 0);
		Camera.main.targetTexture = null;
		RenderTexture.active = null;
		UnityEngine.Object.Destroy(rt);
		yield return 0;
		byte[] bytes = screenShot.EncodeToPNG();
		File.WriteAllBytes(filePath, bytes);
		lua_call_back(filePath);
	}

	public Texture2D GetScreenshot(CaptureMethod method)
	{
		switch (method)
		{
		case CaptureMethod.AppCapture_Synch:
		{
			string text = Environment.GetEnvironmentVariable("TEMP") + "/screenshotBuffer" + tempFileCount + ".png";
			tempFileCount++;
			Application.CaptureScreenshot(text);
			WWW wWW = new WWW("file://" + text.Replace(Path.DirectorySeparatorChar.ToString(), "/"));
			Texture2D texture2D3 = new Texture2D(Screen.width, Screen.height, TextureFormat.RGB24, false);
			while (!wWW.isDone)
			{
			}
			wWW.LoadImageIntoTexture(texture2D3);
			File.Delete(text);
			return texture2D3;
		}
		case CaptureMethod.ReadPixels_Synch:
		{
			Texture2D texture2D2 = new Texture2D(Screen.width, Screen.height, TextureFormat.RGB24, false);
			texture2D2.ReadPixels(new Rect(0f, 0f, Screen.width, Screen.height), 0, 0);
			return texture2D2;
		}
		case CaptureMethod.RenderToTex_Synch:
		{
			RenderTexture renderTexture = new RenderTexture(Screen.width, Screen.height, 24);
			Texture2D texture2D = new Texture2D(Screen.width, Screen.height, TextureFormat.RGB24, false);
			Camera[] allCameras = Camera.allCameras;
			foreach (Camera camera in allCameras)
			{
				camera.targetTexture = renderTexture;
				camera.Render();
				camera.targetTexture = null;
			}
			RenderTexture.active = renderTexture;
			texture2D.ReadPixels(new Rect(0f, 0f, Screen.width, Screen.height), 0, 0);
			Camera.main.targetTexture = null;
			RenderTexture.active = null;
			UnityEngine.Object.Destroy(renderTexture);
			return texture2D;
		}
		default:
			return null;
		}
	}
}
