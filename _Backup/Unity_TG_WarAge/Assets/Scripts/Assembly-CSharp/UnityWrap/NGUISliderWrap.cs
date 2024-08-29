using System;
using Script;
using UnityEngine;
using Wraper;

namespace UnityWrap
{
	public class NGUISliderWrap : NGUIBase
	{
		public static AssetObjectCache<int, NGUISliderWrap> cache = new AssetObjectCache<int, NGUISliderWrap>();

		private string onChangeScript;

		public UISlider component
		{
			get
			{
				return base._component as UISlider;
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

		public NGUISliderWrap()
		{
			lua_class_name = ngui_slider_wraper.name;
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
			NGUISliderWrap base_object = NGUIWrap.Clone<NGUISliderWrap, UISlider>(this);
			WraperUtil.PushObject(L, base_object);
		}

		public void OnChanged()
		{
			if (onChangeScript != null)
			{
				ScriptManager.GetInstance().CallFunction(onChangeScript, component.value);
			}
		}
	}
}
