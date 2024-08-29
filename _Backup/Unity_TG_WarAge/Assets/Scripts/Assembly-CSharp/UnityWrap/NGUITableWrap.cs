using System;
using UnityEngine;
using Wraper;

namespace UnityWrap
{
	public class NGUITableWrap : NGUIBase
	{
		public static AssetObjectCache<int, NGUITableWrap> cache = new AssetObjectCache<int, NGUITableWrap>();

		public UITable component
		{
			get
			{
				return base._component as UITable;
			}
		}

		public NGUITableWrap()
		{
			lua_class_name = ngui_table_wraper.name;
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
			NGUITableWrap base_object = NGUIWrap.Clone<NGUITableWrap, UITable>(this);
			WraperUtil.PushObject(L, base_object);
		}
	}
}
