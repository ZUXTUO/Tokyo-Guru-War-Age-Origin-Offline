using UnityEngine;

public class SceneManager5 : MonoBehaviour
{
	public delegate void SceneHandlerVoid();

	public delegate void SceneHandlerFloat(float val);

	private static bool m_isSceneLoadOK = true;

	private static SceneLoader m_sceneLoder;

	private SceneHandlerVoid OnBaseLoaded;

	private SceneHandlerVoid OnDetailLoaded;

	public SceneHandlerFloat OnBaseProgress;

	private SceneHandlerFloat OnDetailProgress;

	private static SceneManager5 m_instance;

	public static SceneLoader GetLoader()
	{
		if (m_sceneLoder == null)
		{
			m_sceneLoder = GetInstance().gameObject.GetComponent<SceneLoader>();
			if (m_sceneLoder == null)
			{
				m_sceneLoder = SceneLoader.Init(GetInstance().gameObject);
			}
		}
		return m_sceneLoder;
	}

	private string GetMainScenePath(string scenepath)
	{
		int num = scenepath.LastIndexOf('/') + 1;
		string text = scenepath.Substring(0, num);
		string text2 = scenepath.Substring(num);
		return text + "_sma_" + text2;
	}

	private string GetShareScenePath(string scenepath)
	{
		int length = scenepath.LastIndexOf('/') + 1;
		string text = scenepath.Substring(0, length);
		return text + "share_asset.assetbundle";
	}

	private string GetShareBPath(string scenepath)
	{
		int length = scenepath.LastIndexOf('/') + 1;
		string text = scenepath.Substring(0, length);
		return text + "share.b";
	}

	public bool LoadScene(string relScenePath, SceneHandlerVoid baseLoadedCal, SceneHandlerVoid detailLoadedCal, SceneHandlerFloat baseProgressCal, SceneHandlerFloat detailProgressCal, bool isAsyncMainAsset)
	{
		if (!m_isSceneLoadOK)
		{
			Debug.LogWarning(string.Format("[SceneManager5 LoadScene] the last scene {0} has not load complete!!! {1} force to ignored!!", relScenePath, relScenePath));
			return false;
		}
		m_isSceneLoadOK = false;
		OnBaseLoaded = baseLoadedCal;
		OnDetailLoaded = detailLoadedCal;
		OnBaseProgress = baseProgressCal;
		OnDetailProgress = detailProgressCal;
		string mainScenePath = GetMainScenePath(relScenePath);
		string shareScenePath = GetShareScenePath(relScenePath);
		GetLoader().LoadScene(relScenePath, mainScenePath, shareScenePath);
		return true;
	}

	public void OnLevelBaseLoaded()
	{
		m_isSceneLoadOK = true;
		if (OnBaseLoaded != null)
		{
			OnBaseLoaded();
		}
	}

	public void OnLevelDetailLoaded()
	{
		if (OnDetailLoaded != null)
		{
			OnDetailLoaded();
		}
	}

	public void OnLevelBaseProgress(float val)
	{
		if (OnBaseProgress != null)
		{
			OnBaseProgress(val);
		}
	}

	public void OnLevelDetailProgress(float val)
	{
		if (OnDetailProgress != null)
		{
			OnDetailProgress(val);
		}
	}

	public static void Init(GameObject go)
	{
		if (m_instance == null && go != null)
		{
			m_instance = go.AddComponent<SceneManager5>();
			Object.DontDestroyOnLoad(go);
		}
	}

	public static SceneManager5 GetInstance()
	{
		if (m_instance == null)
		{
			GameObject gameObject = new GameObject("_SceneManager5");
			m_instance = gameObject.AddComponent<SceneManager5>();
		}
		return m_instance;
	}
}
