using Script;

namespace UnityWrap
{
	public class SceneLoaderWrap
	{
		private static SceneLoaderWrap _instance;

		public string onSceneLoaded = string.Empty;

		public string onSceneLoading = string.Empty;

		public string onSceneDetailLoaded = string.Empty;

		public string onSceneDetailLoading = string.Empty;

		public static SceneLoaderWrap GetInstance()
		{
			if (_instance == null)
			{
				_instance = new SceneLoaderWrap();
			}
			return _instance;
		}

		public void SetLoadListener(string sceneLoaded, string sceneLoading, string sceneDetailLoaded, string sceneDetailLoading)
		{
			onSceneLoaded = ((sceneLoaded == null) ? string.Empty : sceneLoaded);
			onSceneLoading = ((sceneLoading == null) ? string.Empty : sceneLoading);
			onSceneDetailLoaded = ((sceneDetailLoaded == null) ? string.Empty : sceneDetailLoaded);
			onSceneDetailLoading = ((sceneDetailLoading == null) ? string.Empty : sceneDetailLoading);
		}

		public void LoadScene(string relPath)
		{
			SceneManager5.GetInstance().LoadScene(relPath, OnSceneLoaded, OnSceneLoadedDetail, SceneBaseLoadProgress, SceneDetailLoadProgress, true);
		}

		public void OnSceneLoaded()
		{
			if (onSceneLoaded.Length > 0)
			{
				ScriptManager.GetInstance().CallFunction(onSceneLoaded);
			}
		}

		public void OnSceneLoadedDetail()
		{
			if (onSceneDetailLoaded.Length > 0)
			{
				ScriptManager.GetInstance().CallFunction(onSceneDetailLoaded);
			}
		}

		public void SceneBaseLoadProgress(float progress)
		{
			if (onSceneLoading.Length > 0)
			{
				ScriptManager.GetInstance().CallFunction(onSceneLoading, progress);
			}
		}

		public void SceneDetailLoadProgress(float progress)
		{
			if (onSceneDetailLoading.Length > 0)
			{
				ScriptManager.GetInstance().CallFunction(onSceneDetailLoading, progress);
			}
		}
	}
}