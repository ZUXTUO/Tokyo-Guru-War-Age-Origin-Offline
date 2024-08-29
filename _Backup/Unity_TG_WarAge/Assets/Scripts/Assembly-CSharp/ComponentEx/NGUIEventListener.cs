using Script;
using UnityEngine;
using UnityWrap;

namespace ComponentEx
{
	public class NGUIEventListener : MonoBehaviour
	{
		private UIEventListener listener;

		public bool stopPropagation;

		[SerializeField]
		private string monOnStrvalue = string.Empty;

		[SerializeField]
		private string monClickScript;

		[SerializeField]
		private string monPressScript;

		[SerializeField]
		private string monDragStartScript;

		[SerializeField]
		private string monDragScript;

		[SerializeField]
		private string monDragEndScript;

		public UIEventListener eventListener
		{
			get
			{
				if (listener == null)
				{
					listener = base.gameObject.AddComponent<UIEventListener>();
				}
				return listener;
			}
		}

		public string setOnStrvalue
		{
			get
			{
				return monOnStrvalue;
			}
			set
			{
				monOnStrvalue = value;
			}
		}

		public string onClickScript
		{
			get
			{
				return monClickScript;
			}
			set
			{
				monClickScript = value;
				SetOnClick();
			}
		}

		public string onPressScript
		{
			get
			{
				return monPressScript;
			}
			set
			{
				monPressScript = value;
				SetOnPress();
			}
		}

		public string onDragStartScript
		{
			get
			{
				return monDragStartScript;
			}
			set
			{
				monDragStartScript = value;
				SetOnDragStart();
			}
		}

		public string onDragScript
		{
			get
			{
				return monDragScript;
			}
			set
			{
				monDragScript = value;
				SetOnDrag();
			}
		}

		public string onDragEndScript
		{
			get
			{
				return monDragEndScript;
			}
			set
			{
				monDragEndScript = value;
				SetOnDragEnd();
			}
		}

		private void Awake()
		{
			if (listener == null)
			{
				listener = base.gameObject.AddComponent<UIEventListener>();
			}
			if (onClickScript != null)
			{
				SetOnClick();
			}
			if (onPressScript != null)
			{
				SetOnPress();
			}
			if (onDragStartScript != null)
			{
				SetOnDragStart();
			}
			if (onDragScript != null)
			{
				SetOnDrag();
			}
			if (onDragEndScript != null)
			{
				SetOnDragEnd();
			}
		}

		public void SetOnClick()
		{
			eventListener.onClick = OnNGUIClick;
		}

		public void SetOnPress()
		{
			eventListener.onPress = OnNGUIPress;
		}

		public void SetOnDragStart()
		{
			eventListener.onDragStart = OnNGUIDragStart;
		}

		public void SetOnDrag()
		{
			eventListener.onDrag = OnNGUIDragMove;
		}

		public void SetOnDragEnd()
		{
			eventListener.onDragEnd = OnNGUIDragEnd;
		}

		private void OnNGUIClick(GameObject go)
		{
			stopPropagation = false;
			AssetGameObject assetGameObject = AssetGameObject.CreateByInstance(go);
			if (!ScriptManager.GetInstance().CallFunction(onClickScript, go.name, UICamera.currentTouch.pos.x, UICamera.currentTouch.pos.y, assetGameObject, monOnStrvalue))
			{
				assetGameObject.ClearResources();
			}
			Transform parent = go.transform.parent;
			if (parent != null && !stopPropagation)
			{
				parent.gameObject.SendMessage("OnClick", null, SendMessageOptions.DontRequireReceiver);
			}
		}

		private void OnNGUIPress(GameObject go, bool state)
		{
			stopPropagation = false;
			AssetGameObject assetGameObject = AssetGameObject.CreateByInstance(go);
			if (!ScriptManager.GetInstance().CallFunction(onPressScript, go.name, state, UICamera.currentTouch.pos.x, UICamera.currentTouch.pos.y, assetGameObject, UICamera.currentTouchID))
			{
				assetGameObject.ClearResources();
			}
			Transform parent = go.transform.parent;
			if (parent != null && !stopPropagation)
			{
				parent.gameObject.SendMessage("OnPress", state, SendMessageOptions.DontRequireReceiver);
			}
		}

		private void OnNGUIDragStart(GameObject go)
		{
			stopPropagation = false;
			AssetGameObject assetGameObject = AssetGameObject.CreateByInstance(go);
			if (!ScriptManager.GetInstance().CallFunction(onDragStartScript, go.name, UICamera.currentTouch.pos.x, UICamera.currentTouch.pos.y, assetGameObject))
			{
				assetGameObject.ClearResources();
			}
			Transform parent = go.transform.parent;
			if (parent != null && !stopPropagation)
			{
				parent.gameObject.SendMessage("OnDragStart", null, SendMessageOptions.DontRequireReceiver);
			}
		}

		private void OnNGUIDragMove(GameObject go, Vector2 delta)
		{
			stopPropagation = false;
			AssetGameObject assetGameObject = AssetGameObject.CreateByInstance(go);
			if (!ScriptManager.GetInstance().CallFunction(onDragScript, go.name, UICamera.currentTouch.pos.x, UICamera.currentTouch.pos.y, assetGameObject, UICamera.currentTouchID))
			{
				assetGameObject.ClearResources();
			}
			Transform parent = go.transform.parent;
			if (parent != null && !stopPropagation)
			{
				parent.gameObject.SendMessage("OnDrag", delta, SendMessageOptions.DontRequireReceiver);
			}
		}

		private void OnNGUIDragEnd(GameObject go)
		{
			stopPropagation = false;
			AssetGameObject assetGameObject = AssetGameObject.CreateByInstance(go);
			if (!ScriptManager.GetInstance().CallFunction(onDragEndScript, go.name, UICamera.currentTouch.pos.x, UICamera.currentTouch.pos.y, assetGameObject))
			{
				assetGameObject.ClearResources();
			}
			Transform parent = go.transform.parent;
			if (parent != null && !stopPropagation)
			{
				parent.gameObject.SendMessage("OnDragEnd", null, SendMessageOptions.DontRequireReceiver);
			}
		}

		public void StopPropagation()
		{
			stopPropagation = true;
		}

		public void ResetPropagation()
		{
			stopPropagation = false;
		}
	}
}
