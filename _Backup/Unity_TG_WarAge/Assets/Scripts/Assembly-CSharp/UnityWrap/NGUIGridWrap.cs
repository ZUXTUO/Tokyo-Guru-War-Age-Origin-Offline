using System;
using UnityEngine;
using Wraper;

namespace UnityWrap
{
	public class NGUIGridWrap : NGUIBase
	{
		public static AssetObjectCache<int, NGUIGridWrap> cache = new AssetObjectCache<int, NGUIGridWrap>();

		public UIGrid component
		{
			get
			{
				return base._component as UIGrid;
			}
		}

		public NGUIGridWrap()
		{
			lua_class_name = ngui_grid_wraper.name;
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
			NGUIGridWrap base_object = NGUIWrap.Clone<NGUIGridWrap, UIGrid>(this);
			WraperUtil.PushObject(L, base_object);
		}
	}
}
