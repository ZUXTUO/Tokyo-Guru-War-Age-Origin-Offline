using System;
using UnityEngine;
using Wraper;

namespace UnityWrap
{
	public class NGUIWidgetWrap : NGUIBase
	{
		public static AssetObjectCache<int, NGUIWidgetWrap> cache = new AssetObjectCache<int, NGUIWidgetWrap>();

		public UIWidget component
		{
			get
			{
				return base._component as UIWidget;
			}
		}

		public NGUIWidgetWrap()
		{
			lua_class_name = ngui_widget_wraper.name;
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
			NGUIWidgetWrap base_object = NGUIWrap.Clone<NGUIWidgetWrap, UIWidget>(this);
			WraperUtil.PushObject(L, base_object);
		}
	}
}
