using System;
using Script;
using UnityEngine;
using Wraper;

namespace UnityWrap
{
	public class NGUIScrollViewWrap : NGUIBase
	{
		public static AssetObjectCache<int, NGUIScrollViewWrap> cache = new AssetObjectCache<int, NGUIScrollViewWrap>();

		private string onDragStartedScript;

		private string onDragFinishedScript;

		public UIScrollView component
		{
			get
			{
				return base._component as UIScrollView;
			}
		}

		public string onDragStarted
		{
			set
			{
				onDragStartedScript = value;
				if (value == null || value.Length == 0)
				{
					component.onDragStarted = null;
				}
				else
				{
					component.onDragStarted = OnDragStarted;
				}
			}
		}

		public string onDragFinished
		{
			set
			{
				onDragFinishedScript = value;
				if (value == null || value.Length == 0)
				{
					component.onDragFinished = null;
				}
				else
				{
					component.onDragFinished = OnDragFinished;
				}
			}
		}

		public NGUIScrollViewWrap()
		{
			lua_class_name = ngui_scroll_view_wraper.name;
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
			NGUIScrollViewWrap base_object = NGUIWrap.Clone<NGUIScrollViewWrap, UIScrollView>(this);
			WraperUtil.PushObject(L, base_object);
		}

		public void OnDragStarted()
		{
			if (onDragStartedScript != null)
			{
				ScriptManager.GetInstance().CallFunction(onDragStartedScript);
			}
		}

		public void OnDragFinished()
		{
			if (onDragFinishedScript != null)
			{
				ScriptManager.GetInstance().CallFunction(onDragFinishedScript);
			}
		}
	}
}
