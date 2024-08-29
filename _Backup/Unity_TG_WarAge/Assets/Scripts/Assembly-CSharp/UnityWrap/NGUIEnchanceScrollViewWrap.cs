using System;
using Script;
using UnityEngine;
using Wraper;

namespace UnityWrap
{
	public class NGUIEnchanceScrollViewWrap : NGUIBase
	{
		public static AssetObjectCache<int, NGUIEnchanceScrollViewWrap> cache = new AssetObjectCache<int, NGUIEnchanceScrollViewWrap>();

		private string onInitializeItemScript;

		private string onStopMoveScript;

		private string onStartMoveScript;

		private string onOutStartScript;

		private string onOutEndScript;

		public EnchanceScollView component
		{
			get
			{
				return base._component as EnchanceScollView;
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

		public string onStopMove
		{
			get
			{
				return onStopMoveScript;
			}
			set
			{
				onStopMoveScript = value;
				component.onStopMove = OnStopMove;
			}
		}

		public string onStartMove
		{
			get
			{
				return onStartMoveScript;
			}
			set
			{
				onStartMoveScript = value;
				component.onStartMove = OnStartMove;
			}
		}

		public string onOutStart
		{
			get
			{
				return onOutStartScript;
			}
			set
			{
				onOutStartScript = value;
				component.onOutStart = OnOutStart;
			}
		}

		public string onOutEnd
		{
			get
			{
				return onOutEndScript;
			}
			set
			{
				onOutEndScript = value;
				component.onOutEnd = OnOutEnd;
			}
		}

		public int raid
		{
			get
			{
				return component._raid;
			}
			set
			{
				if (component._raid != value)
				{
					component.raid = value;
				}
			}
		}

		public int showNum
		{
			get
			{
				return component._showNum;
			}
			set
			{
				if (component._showNum != value)
				{
					component.showNum = value;
				}
			}
		}

		public int maxNum
		{
			get
			{
				return component._maxNum;
			}
			set
			{
				if (component._maxNum != value)
				{
					component.maxNum = value;
				}
			}
		}

		public float farScale
		{
			get
			{
				return component._farScale;
			}
			set
			{
				if (component._farScale != value)
				{
					component.farScale = value;
				}
			}
		}

		public float nearScale
		{
			get
			{
				return component._nearScale;
			}
			set
			{
				if (component._nearScale != value)
				{
					component.nearScale = value;
				}
			}
		}

		public float offsetAngle
		{
			get
			{
				return component._offsetAngle;
			}
			set
			{
				if (component._offsetAngle != value)
				{
					component.offsetAngle = value;
				}
			}
		}

		public float dragMult
		{
			get
			{
				return component._dragMult;
			}
			set
			{
				if (component._dragMult != value)
				{
					component.dragMult = value;
				}
			}
		}

		public bool distanceFollowScale
		{
			get
			{
				return component.mdistanceFollowScale;
			}
			set
			{
				if (component.mdistanceFollowScale != value)
				{
					component.distanceFollowScale = value;
				}
			}
		}

		public float nearStopProgress
		{
			get
			{
				return component._nearStopProgress;
			}
			set
			{
				if (component._nearStopProgress != value && value >= 0f && value <= 1f)
				{
					component._nearStopProgress = value;
				}
			}
		}

		public NGUIEnchanceScrollViewWrap()
		{
			lua_class_name = ngui_enchancescrollview_wraper.name;
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

		private void OnInitializeItem(GameObject gameObject, int index)
		{
			if (onInitializeItemScript != null)
			{
				AssetGameObject assetGameObject = AssetGameObject.CreateByInstance(gameObject);
				if (!ScriptManager.GetInstance().CallFunction(onInitializeItemScript, assetGameObject, index))
				{
					assetGameObject.ClearResources();
				}
			}
		}

		private void OnStopMove(int index)
		{
			if (onStopMoveScript != null && ScriptManager.GetInstance().CallFunction(onStopMoveScript, index))
			{
			}
		}

		private void OnStartMove()
		{
			if (onStartMoveScript != null && ScriptManager.GetInstance().CallFunction(onStartMoveScript))
			{
			}
		}

		private void OnOutStart(bool outStart)
		{
			if (onOutStartScript != null && ScriptManager.GetInstance().CallFunction(onOutStartScript, outStart))
			{
			}
		}

		private void OnOutEnd(bool outEnd)
		{
			if (onOutEndScript != null && ScriptManager.GetInstance().CallFunction(onOutEndScript, outEnd))
			{
			}
		}

		public override void Clone(IntPtr L)
		{
			NGUIEnchanceScrollViewWrap base_object = NGUIWrap.Clone<NGUIEnchanceScrollViewWrap, EnchanceScollView>(this);
			WraperUtil.PushObject(L, base_object);
		}
	}
}
