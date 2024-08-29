using System;
using UnityEngine;
using Wraper;

namespace UnityWrap
{
	public class NGUISpriteAnimationWrap : NGUIBase
	{
		public static AssetObjectCache<int, NGUISpriteAnimationWrap> cache = new AssetObjectCache<int, NGUISpriteAnimationWrap>();

		private string onFinishScript;

		public UISpriteAnimation component
		{
			get
			{
				return base._component as UISpriteAnimation;
			}
		}

		public NGUISpriteAnimationWrap()
		{
			lua_class_name = ngui_sprite_animation_wraper.name;
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
			NGUISpriteAnimationWrap base_object = NGUIWrap.Clone<NGUISpriteAnimationWrap, UISpriteAnimation>(this);
			WraperUtil.PushObject(L, base_object);
		}
	}
}
