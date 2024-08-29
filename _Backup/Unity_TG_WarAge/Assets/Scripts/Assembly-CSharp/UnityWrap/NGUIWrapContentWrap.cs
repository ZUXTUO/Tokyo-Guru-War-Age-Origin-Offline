using System;
using Script;
using UnityEngine;
using Wraper;

namespace UnityWrap
{
	public class NGUIWrapContentWrap : NGUIBase
	{
		public static AssetObjectCache<int, NGUIWrapContentWrap> cache = new AssetObjectCache<int, NGUIWrapContentWrap>();

		private string onInitializeItemScript;

		public UIWrapContent component
		{
			get
			{
				return base._component as UIWrapContent;
			}
		}

		public string onInitializeItem
		{
			get
			{
				return onInitializeItemScript;
			}
			set
			{
				onInitializeItemScript = value;
				component.onInitializeItem = OnInitializeItem;
			}
		}

		public NGUIWrapContentWrap()
		{
			lua_class_name = ngui_wrap_content_wraper.name;
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

		private void OnInitializeItem(GameObject gameObject, int wrapIndex, int realIndex)
		{
			if (onInitializeItemScript != null)
			{
				AssetGameObject assetGameObject = AssetGameObject.CreateByInstance(gameObject);
				if (!ScriptManager.GetInstance().CallFunction(onInitializeItemScript, assetGameObject, wrapIndex, realIndex))
				{
					assetGameObject.ClearResources();
				}
			}
		}

		public override void Clone(IntPtr L)
		{
			NGUIWrapContentWrap base_object = NGUIWrap.Clone<NGUIWrapContentWrap, UIWrapContent>(this);
			WraperUtil.PushObject(L, base_object);
		}
	}
}
