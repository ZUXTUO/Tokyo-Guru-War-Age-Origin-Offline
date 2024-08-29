using System;
using Script;
using UnityEngine;
using Wraper;

namespace UnityWrap
{
	public class NGUICenterOnChildWrap : NGUIBase
	{
		public static AssetObjectCache<int, NGUICenterOnChildWrap> cache = new AssetObjectCache<int, NGUICenterOnChildWrap>();

		private string onCenterItemScript;

		public UICenterOnChild component
		{
			get
			{
				return base._component as UICenterOnChild;
			}
		}

		public string onCenterItem
		{
			get
			{
				return onCenterItemScript;
			}
			set
			{
				onCenterItemScript = value;
				component.onCenter = OnCenterItem;
			}
		}

		public NGUICenterOnChildWrap()
		{
			lua_class_name = ngui_center_child_wraper.name;
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

		private void OnCenterItem(GameObject gameObject)
		{
			if (onCenterItemScript != null)
			{
				AssetGameObject assetGameObject = AssetGameObject.CreateByInstance(gameObject);
				if (!ScriptManager.GetInstance().CallFunction(onCenterItemScript, assetGameObject))
				{
					assetGameObject.ClearResources();
				}
			}
		}

		public override void Clone(IntPtr L)
		{
			NGUICenterOnChildWrap base_object = NGUIWrap.Clone<NGUICenterOnChildWrap, UICenterOnChild>(this);
			WraperUtil.PushObject(L, base_object);
		}
	}
}
