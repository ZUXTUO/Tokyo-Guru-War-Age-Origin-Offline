using System;
using Script;
using UnityEngine;
using Wraper;

namespace UnityWrap
{
	public class NGUITweenRotationWrap : NGUIBase
	{
		public static AssetObjectCache<int, NGUITweenRotationWrap> cache = new AssetObjectCache<int, NGUITweenRotationWrap>();

		private string onFinishScript;

		public TweenRotation component
		{
			get
			{
				return base._component as TweenRotation;
			}
		}

		public string onFinish
		{
			get
			{
				return onFinishScript;
			}
			set
			{
				onFinishScript = value;
				if (value == null || value.Length == 0)
				{
					EventDelegate.Remove(component.onFinished, OnFinish);
				}
				else
				{
					EventDelegate.Add(component.onFinished, OnFinish);
				}
			}
		}

		public NGUITweenRotationWrap()
		{
			lua_class_name = ngui_tween_rotation_wraper.name;
		}

		public override void InitInstance(Component component)
		{
			base.InitInstance(component);
			cache.Add(GetPid(), this);
		}

		public override void DestroyInstance()
		{
			base.DestroyInstance();
			cache.Remove(GetPid());
		}

		public override void Clone(IntPtr L)
		{
			NGUITweenRotationWrap base_object = NGUIWrap.Clone<NGUITweenRotationWrap, TweenRotation>(this);
			WraperUtil.PushObject(L, base_object);
		}

		private void OnFinish()
		{
			if (onFinishScript != null)
			{
				AssetGameObject assetGameObject = AssetGameObject.CreateByInstance(component.gameObject);
				if (!ScriptManager.GetInstance().CallFunction(onFinishScript, assetGameObject))
				{
					assetGameObject.ClearResources();
				}
			}
		}
	}
}
