using System;
using UnityEngine;
using Wraper;

namespace UnityWrap
{
	public class NGUISpriteWrap : NGUIBase
	{
		public static AssetObjectCache<int, NGUISpriteWrap> cache = new AssetObjectCache<int, NGUISpriteWrap>();

		public UISprite component
		{
			get
			{
				return base._component as UISprite;
			}
		}

		public NGUISpriteWrap()
		{
			lua_class_name = ngui_sprite_wraper.name;
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
			NGUISpriteWrap base_object = NGUIWrap.Clone<NGUISpriteWrap, UISprite>(this);
			WraperUtil.PushObject(L, base_object);
		}
	}
}
