using System;
using Script;
using UnityEngine;
using Wraper;

namespace UnityWrap
{
	public class NGUIWrapListWrap : NGUIBase
	{
		public static AssetObjectCache<int, NGUIWrapListWrap> cache = new AssetObjectCache<int, NGUIWrapListWrap>();

		private string onInitializeItemScript;

		private string onItemMoveFinishScript;

		private string onMoveLastFinishScript;

		public UIWrapList component
		{
			get
			{
				return base._component as UIWrapList;
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

		public string onItemMoveFinish
		{
			get
			{
				return onItemMoveFinishScript;
			}
			set
			{
				onItemMoveFinishScript = value;
				component.onItemMoveFinish = OnItemMoveFinish;
			}
		}

		public string onMoveLastFinish
		{
			get
			{
				return onMoveLastFinishScript;
			}
			set
			{
				onMoveLastFinishScript = value;
				component.onMoveLastFinish = OnMoveLastFinish;
			}
		}

		public NGUIWrapListWrap()
		{
			lua_class_name = ngui_wrap_list_wraper.name;
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

		private void OnItemMoveFinish()
		{
			if (onItemMoveFinishScript != null)
			{
				ScriptManager.GetInstance().CallFunction(onItemMoveFinishScript);
			}
		}

		private void OnMoveLastFinish()
		{
			if (onMoveLastFinishScript != null)
			{
				ScriptManager.GetInstance().CallFunction(onMoveLastFinishScript);
			}
		}

		public override void Clone(IntPtr L)
		{
			NGUIWrapListWrap base_object = NGUIWrap.Clone<NGUIWrapListWrap, UIWrapList>(this);
			WraperUtil.PushObject(L, base_object);
		}
	}
}
