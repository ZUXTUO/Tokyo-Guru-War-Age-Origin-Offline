using System;
using Script;
using UnityEngine;
using Wraper;

namespace UnityWrap
{
	public class NGUITweenPositionWrap : NGUIBase
	{
		public static AssetObjectCache<int, NGUITweenPositionWrap> cache = new AssetObjectCache<int, NGUITweenPositionWrap>();

		private string onFinishScript;

		public TweenPosition component
		{
			get
			{
				return base._component as TweenPosition;
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

		public NGUITweenPositionWrap()
		{
			lua_class_name = ngui_tween_position_wraper.name;
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
			NGUITweenPositionWrap base_object = NGUIWrap.Clone<NGUITweenPositionWrap, TweenPosition>(this);
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
