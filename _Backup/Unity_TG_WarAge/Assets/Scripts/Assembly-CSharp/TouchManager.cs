using Script;
using UnityEngine;

public class TouchManager : MonoBehaviourEx
{
	private static string go_name = "_TouchManager";

	private static TouchManager instance;

	public string onTouchBegin;

	public string onTouchMove;

	public string onTouchEnd;

	public string onKeyDown;

	public string onKeyUp;

	public static TouchManager GetInstance()
	{
		if (instance == null)
		{
			GameObject gameObject = MonoBehaviourEx.CreateGameObject(go_name);
			instance = gameObject.AddComponent<TouchManager>();
		}
		return instance;
	}

	private void Update()
	{
		ProcessKeyBoard();
		ProcessMouse();
	}

	private void ProcessKeyBoard()
	{
		for (KeyCode keyCode = KeyCode.A; keyCode <= KeyCode.Z; keyCode++)
		{
			if (Input.GetKeyDown(keyCode))
			{
				OnKeyDown((int)keyCode);
			}
			else if (Input.GetKeyUp(keyCode))
			{
				OnKeyUp((int)keyCode);
			}
		}
	}

	private void ProcessMouse()
	{
		if (GetTouchCount() != 0)
		{
			Touch touch = Input.GetTouch(0);
			switch (touch.phase)
			{
			case TouchPhase.Began:
				OnTouchBegin(touch.position);
				break;
			case TouchPhase.Moved:
				OnTouchMove(touch.position);
				break;
			case TouchPhase.Ended:
				OnTouchEnd(touch.position);
				break;
			}
		}
	}

	public bool IsTouchUI()
	{
		int mask = LayerMask.GetMask("UI");
		Camera camera = NGUITools.FindCameraForLayer(mask);
		if (camera == null)
		{
			return false;
		}
		Ray ray = camera.ScreenPointToRay(Input.mousePosition);
		float maxDistance = camera.farClipPlane - camera.nearClipPlane;
		RaycastHit hitInfo;
		if (Physics.Raycast(ray, out hitInfo, maxDistance, mask))
		{
			return true;
		}
		return false;
	}

	public int GetTouchCount()
	{
		int result = 0;
		if (true)
		{
			result = Input.touchCount;
		}
		else if (Input.GetMouseButton(0) || Input.GetMouseButtonUp(0))
		{
			result = 1;
		}
		return result;
	}

	public void OnTouchBegin(Vector3 pos)
	{
		if (!IsTouchUI())
		{
			ScriptManager.GetInstance().CallFunction(onTouchBegin, pos.x, pos.y, pos.z);
		}
	}

	public void OnTouchMove(Vector3 pos)
	{
		if (!IsTouchUI())
		{
			ScriptManager.GetInstance().CallFunction(onTouchMove, pos.x, pos.y, pos.z);
		}
	}

	public void OnTouchEnd(Vector3 pos)
	{
		ScriptManager.GetInstance().CallFunction(onTouchEnd, pos.x, pos.y, pos.z);
	}

	public void OnKeyDown(int key)
	{
		ScriptManager.GetInstance().CallFunction(onKeyDown, key);
	}

	public void OnKeyUp(int key)
	{
		ScriptManager.GetInstance().CallFunction(onKeyUp, key);
	}
}
