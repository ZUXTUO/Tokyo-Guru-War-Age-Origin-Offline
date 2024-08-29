using System;
using UnityEngine;
using Wraper;

namespace UnityWrap
{
	public class NGUIProgressBarWrap : NGUIBase
	{
		public static AssetObjectCache<int, NGUIProgressBarWrap> cache = new AssetObjectCache<int, NGUIProgressBarWrap>();

		public UIProgressBar component
		{
			get
			{
				return base._component as UIProgressBar;
			}
		}

		public NGUIProgressBarWrap()
		{
			lua_class_name = ngui_progress_bar_wraper.name;
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
			NGUIProgressBarWrap base_object = NGUIWrap.Clone<NGUIProgressBarWrap, UIProgressBar>(this);
			WraperUtil.PushObject(L, base_object);
		}
	}
}
