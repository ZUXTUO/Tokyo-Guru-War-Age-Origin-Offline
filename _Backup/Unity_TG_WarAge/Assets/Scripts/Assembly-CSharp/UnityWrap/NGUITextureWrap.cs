using System;
using UnityEngine;
using Wraper;

namespace UnityWrap
{
	public class NGUITextureWrap : NGUIBase
	{
		public static AssetObjectCache<int, NGUITextureWrap> cache = new AssetObjectCache<int, NGUITextureWrap>();

		public UITexture component
		{
			get
			{
				return base._component as UITexture;
			}
		}

		public NGUITextureWrap()
		{
			lua_class_name = ngui_texture_wraper.name;
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
			NGUITextureWrap base_object = NGUIWrap.Clone<NGUITextureWrap, UITexture>(this);
			WraperUtil.PushObject(L, base_object);
		}
	}
}
