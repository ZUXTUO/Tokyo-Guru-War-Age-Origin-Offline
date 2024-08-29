using System;
using Script;
using UnityEngine;
using Wraper;

namespace UnityWrap
{
	public class NGUIToggleWrap : NGUIBase
	{
		public static AssetObjectCache<int, NGUIToggleWrap> cache = new AssetObjectCache<int, NGUIToggleWrap>();

		private string onChangeScript;

		public UIToggle component
		{
			get
			{
				return base._component as UIToggle;
			}
		}

		public string onChange
		{
			set
			{
				onChangeScript = value;
				if (value == null || value.Length == 0)
				{
					EventDelegate.Remove(component.onChange, OnChanged);
				}
				else
				{
					EventDelegate.Add(component.onChange, OnChanged);
				}
			}
		}

		public NGUIToggleWrap()
		{
			lua_class_name = ngui_toggle_wraper.name;
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
			NGUIToggleWrap base_object = NGUIWrap.Clone<NGUIToggleWrap, UIToggle>(this);
			WraperUtil.PushObject(L, base_object);
		}

		public void SetEnable(bool enable)
		{
			if ((bool)component.UBoxCollider)
			{
				component.UBoxCollider.enabled = enable;
			}
		}

		public void OnChanged()
		{
			if (onChangeScript != null)
			{
				ScriptManager.GetInstance().CallFunction(onChangeScript, component.value, component.name);
			}
		}
	}
}
