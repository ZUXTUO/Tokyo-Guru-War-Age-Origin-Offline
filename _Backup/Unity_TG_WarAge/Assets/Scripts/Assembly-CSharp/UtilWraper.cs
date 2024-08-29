using System.Collections;
using System.Collections.Generic;
using System.Text;
using Script;
using UnityEngine;
using UnityEngine.Networking;

public class UtilWraper : MonoBehaviourEx
{
	private static string go_name = "_util";

	private static UtilWraper instance;

	private bool isRefreshPanel;

	private bool isUnloading;

	public static UtilWraper GetInstance()
	{
		if (instance == null)
		{
			GameObject gameObject = new GameObject("_gosutil");
			Object.DontDestroyOnLoad(gameObject);
			MonoBehaviourEx.parentTransform = gameObject.transform;
			gameObject = MonoBehaviourEx.CreateGameObject(go_name);
			instance = gameObject.AddComponent<UtilWraper>();
		}
		return instance;
	}

	public void Run()
	{
	}

	private IEnumerator RefreshAllPanel()
	{
		if (isRefreshPanel)
		{
			yield return 0;
		}
		isRefreshPanel = true;
		UIPanel[] panels = Object.FindObjectsOfType<UIPanel>();
		for (int i = 0; i < panels.Length; i++)
		{
			panels[i].Refresh();
		}
		yield return 0;
		isRefreshPanel = false;
	}

	private IEnumerator UnloadUnusedAssets()
	{
		if (isUnloading)
		{
			yield return null;
		}
		isUnloading = true;
		yield return Resources.UnloadUnusedAssets();
		isUnloading = false;
	}

	public void AsyncRefreshAllPanel()
	{
		StartCoroutine(RefreshAllPanel());
	}

	public void AsyncUnloadUnusedAssets()
	{
		StartCoroutine(UnloadUnusedAssets());
	}

	public void AsyncPost(string uri, string postData, string error_callback, string succ_callback)
	{
		StartCoroutine(Post(uri, postData, error_callback, succ_callback));
	}

	public void AsyncPost(string uri, Dictionary<string, string> formFields, string error_callback, string succ_callback)
	{
		StartCoroutine(Post(uri, formFields, error_callback, succ_callback));
	}

	public void AsyncPost(string uri, WWWForm formData, string error_callback, string succ_callback)
	{
		StartCoroutine(Post(uri, formData, error_callback, succ_callback));
	}

	public IEnumerator Post(string uri, string postData, string error_callback, string succ_callback)
	{
		UnityWebRequest s = new UnityWebRequest(uri, "POST");
		s.uploadHandler = new UploadHandlerRaw(Encoding.UTF8.GetBytes(postData));
		s.uploadHandler.contentType = "application/x-www-form-urlencoded";
		s.downloadHandler = new DownloadHandlerBuffer();
		yield return s.Send();
		UnityWebRequestCallBack(s, error_callback, succ_callback);
	}

	public IEnumerator Post(string uri, Dictionary<string, string> formFields, string error_callback, string succ_callback)
	{
		using (UnityWebRequest webRequest = UnityWebRequest.Post(uri, formFields))
		{
			yield return webRequest.Send();
			UnityWebRequestCallBack(webRequest, error_callback, succ_callback);
		}
	}

	public IEnumerator Post(string uri, WWWForm formData, string error_callback, string succ_callback)
	{
		using (UnityWebRequest webRequest = UnityWebRequest.Post(uri, formData))
		{
			yield return webRequest.Send();
			UnityWebRequestCallBack(webRequest, error_callback, succ_callback);
		}
	}

	private void UnityWebRequestCallBack(UnityWebRequest webRequest, string error_callback, string succ_callback)
	{
		if (webRequest == null)
		{
			return;
		}
		if (webRequest.isError)
		{
			if (!string.IsNullOrEmpty(error_callback))
			{
				ScriptManager.GetInstance().CallFunction(error_callback, webRequest.error);
			}
		}
		else if (!string.IsNullOrEmpty(succ_callback))
		{
			DownloadHandler downloadHandler = webRequest.downloadHandler;
			ScriptManager.GetInstance().CallFunction(succ_callback, downloadHandler.text);
		}
		webRequest.Dispose();
	}

	public void AsyncPlayerMp4(string path, Color _color, FullScreenMovieControlMode type)
	{
		StartCoroutine(PlayerMp4(path, _color, type));
	}

	public IEnumerator PlayerMp4(string path, Color _color, FullScreenMovieControlMode type)
	{
		Handheld.PlayFullScreenMovie(path, _color, type);
		yield return true;
	}
}
