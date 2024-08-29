using System;
using UnityEngine;
using Wraper;

namespace UnityWrap
{
	public class NGUILabelWrap : NGUIBase
	{
		public static AssetObjectCache<int, NGUILabelWrap> cache = new AssetObjectCache<int, NGUILabelWrap>();

		public UILabel component
		{
			get
			{
				return base._component as UILabel;
			}
		}

		public NGUILabelWrap()
		{
			lua_class_name = ngui_label_wraper.name;
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
			NGUILabelWrap base_object = NGUIWrap.Clone<NGUILabelWrap, UILabel>(this);
			WraperUtil.PushObject(L, base_object);
		}
	}
}
