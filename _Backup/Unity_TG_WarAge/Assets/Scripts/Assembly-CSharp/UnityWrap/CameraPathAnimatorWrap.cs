using Core;
using Core.Unity;
using Script;
using Wraper;

namespace UnityWrap
{
	public class CameraPathAnimatorWrap : BaseObject
	{
		public static AssetObjectCache<int, CameraPathAnimatorWrap> cache = new AssetObjectCache<int, CameraPathAnimatorWrap>();

		private string OnStartedScript;

		private string OnPausedScript;

		private string OnStoppedScript;

		private string OnFinishedScript;

		private CameraPathAnimator com;

		public CameraPathAnimator component
		{
			get
			{
				return com;
			}
		}

		public string onStarted
		{
			set
			{
				OnStartedScript = value;
				component.AnimationStartedEvent += OnAnimationStarted;
			}
		}

		public string onPaused
		{
			set
			{
				OnPausedScript = value;
				component.AnimationPausedEvent += OnAnimationPaused;
			}
		}

		public string onStopped
		{
			set
			{
				OnStoppedScript = value;
				component.AnimationStoppedEvent += OnAnimationStopped;
			}
		}

		public string onFinished
		{
			set
			{
				OnFinishedScript = value;
				component.AnimationFinishedEvent += OnAnimationFinished;
			}
		}

		public CameraPathAnimatorWrap()
		{
			lua_class_name = camera_path_animator_wraper.name;
		}

		public static CameraPathAnimatorWrap CreateInstance(CameraPathAnimator com)
		{
			if (com == null)
			{
				Debug.LogWarning("[CameraPathAnimator CreateInstance] error: camera path animator is null ");
				return null;
			}
			CameraPathAnimatorWrap cameraPathAnimatorWrap = new CameraPathAnimatorWrap();
			cameraPathAnimatorWrap.com = com;
			cache.Add(cameraPathAnimatorWrap.GetPid(), cameraPathAnimatorWrap);
			cameraPathAnimatorWrap.component.AnimationCustomEvent += cameraPathAnimatorWrap.OnCustomEvent;
			return cameraPathAnimatorWrap;
		}

		public static void DestroyInstance(CameraPathAnimatorWrap obj)
		{
			if (obj != null)
			{
				cache.Remove(obj.GetPid());
				obj.com = null;
			}
		}

		public void OnCustomEvent(string eventname)
		{
			string[] array = eventname.Split('|');
			if (array.Length >= 1)
			{
				string text = string.Empty;
				if (array.Length >= 2)
				{
					text = array[1];
				}
				ScriptManager.GetInstance().CallFunction(array[0], text);
			}
		}

		private void OnAnimationStarted()
		{
			if (OnStartedScript != null)
			{
				ScriptManager.GetInstance().CallFunction(OnStartedScript);
			}
		}

		private void OnAnimationPaused()
		{
			if (OnPausedScript != null)
			{
				ScriptManager.GetInstance().CallFunction(OnPausedScript);
			}
		}

		private void OnAnimationStopped()
		{
			if (OnStoppedScript != null)
			{
				ScriptManager.GetInstance().CallFunction(OnStoppedScript);
			}
		}

		private void OnAnimationFinished()
		{
			if (OnFinishedScript != null)
			{
				ScriptManager.GetInstance().CallFunction(OnFinishedScript);
			}
		}
	}
}
