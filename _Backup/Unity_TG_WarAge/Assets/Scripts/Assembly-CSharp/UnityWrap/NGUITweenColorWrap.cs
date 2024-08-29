using System;
using Script;
using UnityEngine;
using Wraper;

namespace UnityWrap
{
	public class NGUITweenColorWrap : NGUIBase
	{
		public static AssetObjectCache<int, NGUITweenColorWrap> cache = new AssetObjectCache<int, NGUITweenColorWrap>();

		private string onFinishScript;

		public TweenColor component
		{
			get
			{
				return base._component as TweenColor;
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

		public NGUITweenColorWrap()
		{
			lua_class_name = ngui_tween_color_wraper.name;
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
			NGUITweenColorWrap base_object = NGUIWrap.Clone<NGUITweenColorWrap, TweenColor>(this);
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
