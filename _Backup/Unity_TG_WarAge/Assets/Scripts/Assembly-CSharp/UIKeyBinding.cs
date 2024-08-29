using UnityEngine;

[AddComponentMenu("NGUI/Interaction/Key Binding")]
public class UIKeyBinding : MonoBehaviour
{
	public enum Action
	{
		PressAndClick = 0,
		Select = 1,
		All = 2
	}

	public enum Modifier
	{
		Any = 0,
		Shift = 1,
		Control = 2,
		Alt = 3,
		None = 4
	}

	public KeyCode keyCode;

	public Modifier modifier;

	public Action action;

	private bool mIgnoreUp;

	private bool mIsInput;

	private bool mPress;

	protected virtual void Start()
	{
		UIInput component = GetComponent<UIInput>();
		mIsInput = component != null;
		if (component != null)
		{
			EventDelegate.Add(component.onSubmit, OnSubmit);
		}
	}

	protected virtual void OnSubmit()
	{
		if (UICamera.currentKey == keyCode && IsModifierActive())
		{
			mIgnoreUp = true;
		}
	}

	protected virtual bool IsModifierActive()
	{
		if (modifier == Modifier.Any)
		{
			return true;
		}
		if (modifier == Modifier.Alt)
		{
			if (Input.GetKey(KeyCode.LeftAlt) || Input.GetKey(KeyCode.RightAlt))
			{
				return true;
			}
		}
		else if (modifier == Modifier.Control)
		{
			if (Input.GetKey(KeyCode.LeftControl) || Input.GetKey(KeyCode.RightControl))
			{
				return true;
			}
		}
		else if (modifier == Modifier.Shift)
		{
			if (Input.GetKey(KeyCode.LeftShift) || Input.GetKey(KeyCode.RightShift))
			{
				return true;
			}
		}
		else if (modifier == Modifier.None)
		{
			return !Input.GetKey(KeyCode.LeftAlt) && !Input.GetKey(KeyCode.RightAlt) && !Input.GetKey(KeyCode.LeftControl) && !Input.GetKey(KeyCode.RightControl) && !Input.GetKey(KeyCode.LeftShift) && !Input.GetKey(KeyCode.RightShift);
		}
		return false;
	}

	protected virtual void Update()
	{
		if (UICamera.inputHasFocus || keyCode == KeyCode.None || !IsModifierActive())
		{
			return;
		}
		bool keyDown = Input.GetKeyDown(keyCode);
		bool keyUp = Input.GetKeyUp(keyCode);
		if (keyDown)
		{
			mPress = true;
		}
		if (action == Action.PressAndClick || action == Action.All)
		{
			if (keyDown)
			{
				UICamera.currentTouch = UICamera.controller;
				UICamera.currentScheme = UICamera.ControlScheme.Controller;
				UICamera.currentTouch.current = base.gameObject;
				OnBindingPress(true);
				UICamera.currentTouch.current = null;
			}
			if (mPress && keyUp)
			{
				UICamera.currentTouch = UICamera.controller;
				UICamera.currentScheme = UICamera.ControlScheme.Controller;
				UICamera.currentTouch.current = base.gameObject;
				OnBindingPress(false);
				OnBindingClick();
				UICamera.currentTouch.current = null;
			}
		}
		if ((action == Action.Select || action == Action.All) && keyUp)
		{
			if (mIsInput)
			{
				if (!mIgnoreUp && !UICamera.inputHasFocus && mPress)
				{
					UICamera.selectedObject = base.gameObject;
				}
				mIgnoreUp = false;
			}
			else if (mPress)
			{
				UICamera.selectedObject = base.gameObject;
			}
		}
		if (keyUp)
		{
			mPress = false;
		}
	}

	protected virtual void OnBindingPress(bool pressed)
	{
		UICamera.Notify(base.gameObject, "OnPress", pressed);
	}

	protected virtual void OnBindingClick()
	{
		UICamera.Notify(base.gameObject, "OnClick", null);
	}
}
