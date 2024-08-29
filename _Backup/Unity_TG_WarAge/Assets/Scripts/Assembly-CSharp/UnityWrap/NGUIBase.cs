using System;
using Core;
using Core.Unity;
using Core.Util;
using LuaInterface;
using UnityEngine;

namespace UnityWrap
{
	public class NGUIBase : BaseObject
	{
		protected Component __component;

		public bool isNeedDestroy;

		public Component bcomponent
		{
			get
			{
				return _component;
			}
		}

		public UIWidget widget
		{
			get
			{
				return (!(_component is UIWidget)) ? null : (_component as UIWidget);
			}
		}

		protected Component _component
		{
			get
			{
				if (__component != null)
				{
					Utils.CheckGameObjectIsDestroyed(__component.gameObject);
				}
				return __component;
			}
			set
			{
				__component = value;
			}
		}

		public virtual void InitInstance(Component component)
		{
			_component = component;
		}

		public virtual void DestroyInstance()
		{
			if (isNeedDestroy && (bool)_component && (bool)_component.gameObject)
			{
				UnityEngine.Object.Destroy(_component.gameObject);
			}
		}

		public virtual void Clone(IntPtr L)
		{
			Core.Unity.Debug.LogError("[NGUIBase Clone] Clone is not implement yet");
			LuaDLL.lua_pushnil(L);
		}
	}
}
