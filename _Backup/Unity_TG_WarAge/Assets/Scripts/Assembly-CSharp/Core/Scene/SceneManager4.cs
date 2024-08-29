using UnityEngine;

namespace Core.Scene
{
	public class SceneManager4 : MonoBehaviourEx
	{
		public SceneTouchEventHandler OnTouch;

		private SceneHandlerVoid OnBaseLoaded;

		private SceneHandlerVoid OnDetailLoaded;

		private SceneHandlerFloat OnBaseProgress;

		private SceneHandlerFloat OnDetailProgress;

		private static string go_name = "_SceneManager4";

		private static SceneManager4 instance;

		public void SetDownloadAdapter(SceneResourceDownloadAdapter4 adap)
		{
			SceneResourceManager4.GetInstance().downloadMgr.SetAdapter(adap);
		}

		public void SetDownloadPriority(int mainPriority, int idlePriority)
		{
			SceneResourceManager4.GetInstance().downloadMgr.downloadPriority = mainPriority;
			SceneResourceManager4.GetInstance().downloadMgr.idleDownloadPriority = idlePriority;
		}

		public bool LoadScene(string relScenePath, SceneHandlerVoid baseLoadedCal, SceneHandlerVoid detailLoadedCal, SceneHandlerFloat baseProgressCal, SceneHandlerFloat detailProgressCal, bool isAsyncMainAsset)
		{
			ScenePrintUtil.LogStart("ReductionSceneVersion4.log");
			ScenePrintUtil.Log("load scene: {0}", relScenePath);
			Clear();
			OnBaseLoaded = baseLoadedCal;
			OnDetailLoaded = detailLoadedCal;
			OnBaseProgress = baseProgressCal;
			OnDetailProgress = detailProgressCal;
			return SceneInfoManager4.GetInstance().StartLoadMainAsset(relScenePath, OnLevelBaseLoaded, OnLevelDetailLoaded, OnLevelBaseProgress, OnLevelDetailProgress, isAsyncMainAsset);
		}

		public void SetDisableItemReduction(bool isDisable)
		{
			ComponentAssetDataManager4.StopItemVisibleTask = isDisable;
		}

		public bool GetDisableItemReduction()
		{
			return ComponentAssetDataManager4.StopItemVisibleTask;
		}

		public void OnLevelBaseLoaded()
		{
			ScenePrintUtil.Log("==============OnLevelBaseLoaded scene level is loaded:");
			if (OnBaseLoaded != null)
			{
				OnBaseLoaded();
			}
		}

		public void OnLevelDetailLoaded()
		{
			ScenePrintUtil.Log("==============OnLevelDetailLoaded scene level is loaded:");
			if (OnDetailLoaded != null)
			{
				OnDetailLoaded();
			}
		}

		public void OnLevelBaseProgress(float val)
		{
			ScenePrintUtil.Log(string.Format("==============OnLevelBaseProgress :{0}", val));
			if (OnBaseProgress != null)
			{
				OnBaseProgress(val);
			}
		}

		public void OnLevelDetailProgress(float val)
		{
			ScenePrintUtil.Log(string.Format("==============OnLevelDetailProgress :{0}", val));
			if (OnDetailProgress != null)
			{
				OnDetailProgress(val);
			}
		}

		private void OnApplicationQuit()
		{
			ScenePrintUtil.Log("SceneManager -> on application quit");
			Clear();
			ScenePrintUtil.LogFinish();
		}

		public void Clear()
		{
			SceneInfoManager4.GetInstance().Clear();
			SceneResourceManager4.GetInstance().Clear();
			ComponentAssetDataManager4.Clear();
		}

		public void CallTouch(Vector3 p)
		{
			if (OnTouch != null)
			{
				OnTouch(p);
			}
		}

		public static SceneManager4 GetInstance()
		{
			if (instance == null)
			{
				GameObject gameObject = MonoBehaviourEx.CreateGameObject(go_name);
				instance = gameObject.AddComponent<SceneManager4>();
				SceneResourceManager4.Init(gameObject);
				SceneInfoManager4.Init(gameObject);
			}
			return instance;
		}
	}
}
