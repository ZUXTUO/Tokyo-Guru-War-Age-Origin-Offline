using System;
using Script;
using UnityEngine;
using Wraper;

namespace UnityWrap
{
	public class NGUIBezierPathSplineWrap : NGUIBase
	{
		public static AssetObjectCache<int, NGUIBezierPathSplineWrap> cache = new AssetObjectCache<int, NGUIBezierPathSplineWrap>();

		private string onShowEndCallScript;

		private string onSwitchEndCallScript;

		public string onShowEndCall
		{
			get
			{
				return onShowEndCallScript;
			}
			set
			{
				if (value != string.Empty)
				{
					onShowEndCallScript = value;
					component.tweenShowEndCall = OnShowEnd;
				}
				else
				{
					onShowEndCallScript = null;
					component.tweenShowEndCall = null;
				}
			}
		}

		public string onSwitchEndCall
		{
			get
			{
				return onSwitchEndCallScript;
			}
			set
			{
				if (value != string.Empty)
				{
					onSwitchEndCallScript = value;
					component.tweenSwitchEndCall = OnSwitchEnd;
				}
				else
				{
					onSwitchEndCallScript = null;
					component.tweenSwitchEndCall = null;
				}
			}
		}

		public BezierPathSpline component
		{
			get
			{
				return base._component as BezierPathSpline;
			}
		}

		public NGUIBezierPathSplineWrap()
		{
			lua_class_name = ngui_bezierpathspline_wraper.name;
		}

		private void OnShowEnd(int index)
		{
			if (onShowEndCallScript != null && ScriptManager.GetInstance().CallFunction(onShowEndCallScript, index))
			{
			}
		}

		private void OnSwitchEnd(int index)
		{
			if (onSwitchEndCallScript != null && ScriptManager.GetInstance().CallFunction(onSwitchEndCallScript, index))
			{
			}
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
			NGUIBezierPathSplineWrap base_object = NGUIWrap.Clone<NGUIBezierPathSplineWrap, BezierPathSpline>(this);
			WraperUtil.PushObject(L, base_object);
		}
	}
}
