using UnityEngine;

public class UIDragListView : MonoBehaviour
{
	public UIWrapList testView;

	private Transform mTrans;

	private bool mAutoFind;

	private bool mStarted;

	private void OnEnable()
	{
		mTrans = base.transform;
		if (mStarted && (mAutoFind || testView == null))
		{
			FindTestView();
		}
	}

	private void Start()
	{
		mStarted = true;
		FindTestView();
	}

	private void OnDrag(Vector2 delta)
	{
		if ((bool)testView && NGUITools.GetActive(this) && testView.bMoveSwitch)
		{
			testView.Drag(delta);
		}
	}

	private void OnPress(bool pressed)
	{
		if ((bool)testView && NGUITools.GetActive(this))
		{
			testView.Press(pressed);
		}
	}

	private void FindTestView()
	{
		UIWrapList uIWrapList = NGUITools.FindInParents<UIWrapList>(mTrans);
		if (uIWrapList == null)
		{
			uIWrapList = GetComponent<UIWrapList>();
		}
		if (testView == null || (mAutoFind && uIWrapList != testView))
		{
			testView = uIWrapList;
			mAutoFind = true;
		}
		else if (testView == uIWrapList)
		{
			mAutoFind = true;
		}
	}
}
