using System;
using Core.Unity;
using LuaInterface;
using Script;
using UnityEngine;
using Wraper;

namespace UnityWrap
{
	public class NGUIButtonWrap : NGUIBase
	{
		public enum ButtonEvent
		{
			Default = 1
		}

		public static AssetObjectCache<int, NGUIButtonWrap> cache = new AssetObjectCache<int, NGUIButtonWrap>();

		public static int globalEventLevel = 1;

		public string eventStringValue;

		public float eventFloatValue;

		private int m_eventLevel;

		private string onClickScript;

		public UIButton component
		{
			get
			{
				return base._component as UIButton;
			}
		}

		public string onClick
		{
			get
			{
				return onClickScript;
			}
			set
			{
				onClickScript = value;
				if (value != null && value.Length != 0)
				{
					EventDelegate.Add(component.onClick, OnButtonClick);
				}
			}
		}

		public int eventLevel
		{
			set
			{
				m_eventLevel = value;
			}
		}

		public NGUIButtonWrap()
		{
			lua_class_name = ngui_button_wraper.name;
			m_eventLevel = 1;
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
			NGUIButtonWrap base_object = NGUIWrap.Clone<NGUIButtonWrap, UIButton>(this);
			WraperUtil.PushObject(L, base_object);
		}

		private void OnButtonClick()
		{
			if ((m_eventLevel & globalEventLevel) == 0)
			{
				return;
			}
			ScriptCall scriptCall = ScriptCall.Create(onClick);
			if (scriptCall != null && scriptCall.Start())
			{
				LuaDLL.lua_newtable(scriptCall.L);
				scriptCall.lua_settable("pid", GetPid());
				scriptCall.lua_settable("string_value", eventStringValue);
				scriptCall.lua_settable("float_value", eventFloatValue);
				AssetGameObject value = null;
				if ((bool)component && (bool)component.gameObject)
				{
					value = AssetGameObject.CreateByInstance(component.gameObject);
				}
				else
				{
					Core.Unity.Debug.LogError("[NGUIButtonWrap OnButtonClick] UIBotton is null");
				}
				scriptCall.lua_settable("game_object", value);
				scriptCall.Finish(1);
			}
		}

		public void ResetOnClick()
		{
			component.onClick.Clear();
		}
	}
}
