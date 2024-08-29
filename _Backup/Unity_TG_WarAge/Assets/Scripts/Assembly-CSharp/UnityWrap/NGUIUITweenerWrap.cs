using System;
using Script;
using UnityEngine;
using Wraper;

namespace UnityWrap
{
	public class NGUIUITweenerWrap : NGUIBase
	{
		public static AssetObjectCache<int, NGUIUITweenerWrap> cache = new AssetObjectCache<int, NGUIUITweenerWrap>();

		private string onFinishScript;

		public UITweener component
		{
			get
			{
				return base._component as UITweener;
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

		public NGUIUITweenerWrap()
		{
			lua_class_name = ngui_uitweener_wraper.name;
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

		public override void Clone(IntPtr L)
		{
			NGUIUITweenerWrap base_object = NGUIWrap.Clone<NGUIUITweenerWrap, UITweener>(this);
			WraperUtil.PushObject(L, base_object);
		}
	}
}
