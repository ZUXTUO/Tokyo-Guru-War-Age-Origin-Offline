using System;
using Script;
using UnityEngine;
using Wraper;

namespace UnityWrap
{
	public class NGUIPanelWrap : NGUIBase
	{
		public static AssetObjectCache<int, NGUIPanelWrap> cache = new AssetObjectCache<int, NGUIPanelWrap>();

		private string onResizeScript;

		public UIPanel component
		{
			get
			{
				return base._component as UIPanel;
			}
		}

		public string onResize
		{
			get
			{
				return onResizeScript;
			}
			set
			{
				onResizeScript = value;
				component.onResize = OnResize;
			}
		}

		public NGUIPanelWrap()
		{
			lua_class_name = ngui_panel_wraper.name;
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
			NGUIPanelWrap base_object = NGUIWrap.Clone<NGUIPanelWrap, UIPanel>(this);
			WraperUtil.PushObject(L, base_object);
		}

		private void OnResize()
		{
			if (onResizeScript != null)
			{
				ScriptManager.GetInstance().CallFunction(onResizeScript);
			}
		}
	}
}
