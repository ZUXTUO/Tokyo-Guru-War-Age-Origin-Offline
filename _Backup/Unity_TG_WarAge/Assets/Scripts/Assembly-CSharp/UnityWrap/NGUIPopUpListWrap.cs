using Script;
using UnityEngine;
using Wraper;

namespace UnityWrap
{
	public class NGUIPopUpListWrap : NGUIBase
	{
		public static AssetObjectCache<int, NGUIPopUpListWrap> cache = new AssetObjectCache<int, NGUIPopUpListWrap>();

		private string onSelectChangeScript;

		public UIPopupList component
		{
			get
			{
				return base._component as UIPopupList;
			}
		}

		public string onSelectChange
		{
			set
			{
				onSelectChangeScript = value;
				if (value == null || value.Length == 0)
				{
					EventDelegate.Remove(component.onChange, OnSelectionChange);
				}
				else
				{
					EventDelegate.Add(component.onChange, OnSelectionChange);
				}
			}
		}

		public NGUIPopUpListWrap()
		{
			lua_class_name = ngui_popup_list_wraper.name;
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

		public void OnSelectionChange()
		{
			if (onSelectChangeScript != null)
			{
				char[] trimChars = new char[5] { ',', '.', ' ', '\r', '\n' };
				ScriptManager.GetInstance().CallFunction(onSelectChangeScript, component.value.Trim(trimChars));
			}
		}
	}
}
