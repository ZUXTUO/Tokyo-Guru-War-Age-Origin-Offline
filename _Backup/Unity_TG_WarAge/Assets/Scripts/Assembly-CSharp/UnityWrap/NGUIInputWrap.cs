using System;
using Script;
using UnityEngine;
using Wraper;

namespace UnityWrap
{
	public class NGUIInputWrap : NGUIBase
	{
		public static AssetObjectCache<int, NGUIInputWrap> cache = new AssetObjectCache<int, NGUIInputWrap>();

		private string onChangeScript;

		private string onSubmitScript;

		public UIInput component
		{
			get
			{
				return base._component as UIInput;
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

		public string onSubmit
		{
			set
			{
				onSubmitScript = value;
				if (value == null || value.Length == 0)
				{
					EventDelegate.Remove(component.onSubmit, OnSubmit);
				}
				else
				{
					EventDelegate.Add(component.onSubmit, OnSubmit);
				}
			}
		}

		public NGUIInputWrap()
		{
			lua_class_name = ngui_input_wraper.name;
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
			NGUIInputWrap base_object = NGUIWrap.Clone<NGUIInputWrap, UIInput>(this);
			WraperUtil.PushObject(L, base_object);
		}

		public void OnChanged()
		{
			if (onChangeScript != null)
			{
				ScriptManager.GetInstance().CallFunction(onChangeScript, component.value);
			}
		}

		public void OnSubmit()
		{
			if (onSubmitScript != null)
			{
				ScriptManager.GetInstance().CallFunction(onSubmitScript, component.value);
			}
		}
	}
}
