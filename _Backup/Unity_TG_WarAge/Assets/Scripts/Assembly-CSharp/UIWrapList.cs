using System.Collections.Generic;
using UnityEngine;

public class UIWrapList : MonoBehaviour
{
	public enum Movement
	{
		Horizontal = 0,
		Vertical = 1
	}

	public delegate void OnInitializeItem(GameObject go, int wrapIndex, int realIndex);

	public delegate void OnItemMoveFinish();

	public delegate void OnMoveLastFinish();

	public Movement movement;

	public OnInitializeItem onInitializeItem;

	public OnItemMoveFinish onItemMoveFinish;

	public OnMoveLastFinish onMoveLastFinish;

	public int minIndex;

	public int maxIndex;

	public int disInterval;

	public bool mMoveAtLast;

	public bool bMoveSwitch = true;

	private float mMovePixels = 2f;

	private Transform mTrans;

	private UIPanel mPanel;

	private Vector2 mCutOut;

	private List<UIAutoAnchors> mChildren = new List<UIAutoAnchors>();

	private bool mHorizontal;

	private int moveMinIndex;

	private int moveMaxIndex;

	private float surplusDis;

	private bool isPress;

	private float reboundTime = 0.2f;

	private float surplusRebound;

	private float secondMove;

	private bool isMove;

	private bool isInit;

	private float totalMove;

	private float curMove;

	private bool isUpdateMove;

	private bool isUp = true;

	private bool isMoveOutHide;

	private static float moveDiff = 500f;

	private static float fastMoveDiff = 2000f;

	private bool fastMove;

	private void Start()
	{
		Init();
	}

	private void Init()
	{
		if (!isInit)
		{
			isInit = true;
			mTrans = base.transform;
			mPanel = NGUITools.FindInParents<UIPanel>(base.gameObject);
			mCutOut = new Vector2(mPanel.finalClipRegion.z, mPanel.finalClipRegion.w);
			if (movement == Movement.Horizontal)
			{
				mHorizontal = true;
			}
			else if (movement == Movement.Vertical)
			{
				mHorizontal = false;
			}
			SortBasedOnScrollMovement();
		}
	}

	public void SortBasedOnScrollMovement()
	{
		if (!isInit)
		{
			Init();
			return;
		}
		int num = maxIndex - minIndex;
		mChildren.Clear();
		for (int i = 0; i < mTrans.childCount; i++)
		{
			mTrans.GetChild(i).gameObject.SetActive(true);
			if (i > num)
			{
				mTrans.GetChild(i).gameObject.SetActive(false);
			}
			if (mTrans.GetChild(i).gameObject.activeSelf)
			{
				UIAutoAnchors component = mTrans.GetChild(i).GetComponent<UIAutoAnchors>();
				component.Param = i;
				mChildren.Add(component);
			}
		}
		ResetChildPositions();
	}

	private void ResetChildPositions()
	{
		int num = 0;
		int num2 = 0;
		if (mMoveAtLast)
		{
			mMoveAtLast = false;
			moveMaxIndex = maxIndex;
			moveMinIndex = moveMaxIndex - mChildren.Count + 1;
			int num3 = mChildren.Count - 1;
			int num4 = -1;
			while (num3 > num4)
			{
				UIAutoAnchors uIAutoAnchors = mChildren[num3];
				UpdateItem(uIAutoAnchors, num3, moveMinIndex + num3);
				if (!mHorizontal)
				{
					uIAutoAnchors.bottomPosition = new Vector3(0f, 0f - mCutOut.y + (float)num2, 0f);
				}
				num -= uIAutoAnchors.width + disInterval;
				num2 += uIAutoAnchors.height + disInterval;
				num3--;
			}
			return;
		}
		moveMinIndex = minIndex;
		moveMaxIndex = moveMinIndex + mChildren.Count - 1;
		int i = 0;
		for (int count = mChildren.Count; i < count; i++)
		{
			UIAutoAnchors uIAutoAnchors2 = mChildren[i];
			UpdateItem(uIAutoAnchors2, i, moveMinIndex + i);
			if (!mHorizontal)
			{
				uIAutoAnchors2.topPosition = new Vector3(0f, num2, 0f);
			}
			num += uIAutoAnchors2.width + disInterval;
			num2 -= uIAutoAnchors2.height + disInterval;
		}
	}

	public void WrapContent(Vector2 delta, bool checkFirstDrag)
	{
		if (mChildren.Count <= 0 || mHorizontal)
		{
			return;
		}
		if (checkFirstDrag && mChildren[0].topPosition.y <= 0f && mChildren[mChildren.Count - 1].bottomPosition.y >= 0f - mCutOut.y)
		{
			isMove = false;
			return;
		}
		isMove = true;
		float num = delta.y * mMovePixels;
		if (num > 0f)
		{
			int i = 0;
			for (int count = mChildren.Count; i < count; i++)
			{
				UIAutoAnchors uIAutoAnchors = mChildren[i];
				uIAutoAnchors.localPosition = new Vector3(uIAutoAnchors.localPosition.x, uIAutoAnchors.localPosition.y + num, uIAutoAnchors.localPosition.z);
			}
			while (moveMaxIndex + 1 <= maxIndex)
			{
				UIAutoAnchors uIAutoAnchors2 = mChildren[0];
				if (uIAutoAnchors2.bottomPosition.y >= 0f)
				{
					moveMinIndex++;
					moveMaxIndex++;
					UpdateItem(uIAutoAnchors2, 0, moveMaxIndex);
					UIAutoAnchors uIAutoAnchors3 = mChildren[mChildren.Count - 1];
					Vector3 bottomPosition = uIAutoAnchors3.bottomPosition;
					bottomPosition.y -= disInterval;
					uIAutoAnchors2.topPosition = bottomPosition;
					if (isMoveOutHide)
					{
						uIAutoAnchors2.gameObject.SetActive(false);
					}
					mChildren.Remove(uIAutoAnchors2);
					mChildren.Add(uIAutoAnchors2);
					continue;
				}
				break;
			}
			return;
		}
		int j = 0;
		for (int count2 = mChildren.Count; j < count2; j++)
		{
			UIAutoAnchors uIAutoAnchors4 = mChildren[j];
			uIAutoAnchors4.localPosition = new Vector3(uIAutoAnchors4.localPosition.x, uIAutoAnchors4.localPosition.y + num, uIAutoAnchors4.localPosition.z);
		}
		while (moveMinIndex - 1 >= minIndex)
		{
			UIAutoAnchors uIAutoAnchors5 = mChildren[mChildren.Count - 1];
			if (uIAutoAnchors5.topPosition.y <= 0f - mCutOut.y)
			{
				moveMinIndex--;
				moveMaxIndex--;
				UpdateItem(uIAutoAnchors5, 0, moveMinIndex);
				UIAutoAnchors uIAutoAnchors6 = mChildren[0];
				Vector3 topPosition = uIAutoAnchors6.topPosition;
				topPosition.y += disInterval;
				uIAutoAnchors5.bottomPosition = topPosition;
				if (isMoveOutHide)
				{
					uIAutoAnchors5.gameObject.SetActive(false);
				}
				mChildren.Remove(uIAutoAnchors5);
				mChildren.Insert(0, uIAutoAnchors5);
				continue;
			}
			break;
		}
	}

	protected virtual void UpdateItem(UIAutoAnchors item, int index, int realIndex)
	{
		if (onInitializeItem != null)
		{
			onInitializeItem(item.gameObject, item.Param, realIndex);
		}
		item.PosAligent();
	}

	public void Drag(Vector2 delta, bool checkFirstDrag = true)
	{
		WrapContent(delta, checkFirstDrag);
	}

	public void DragItem(GameObject obj, bool up)
	{
		int indexByGameObject = GetIndexByGameObject(obj);
		if (indexByGameObject < mChildren.Count && indexByGameObject >= 0)
		{
			totalMove = mChildren[indexByGameObject].height + disInterval;
			curMove = 0f;
			isUpdateMove = true;
			isUp = up;
			isMoveOutHide = true;
		}
	}

	public void AlignPreItem(GameObject obj, bool up)
	{
		int indexByGameObject = GetIndexByGameObject(obj);
		if (indexByGameObject >= mChildren.Count || indexByGameObject < 0 || !mChildren[indexByGameObject].gameObject.activeSelf)
		{
			return;
		}
		if (up)
		{
			int num = indexByGameObject - 1;
			if (num < 0)
			{
				num = mChildren.Count - 1;
			}
			Vector3 bottomPosition = mChildren[num].bottomPosition;
			bottomPosition.y -= disInterval;
			mChildren[indexByGameObject].topPosition = bottomPosition;
		}
		else
		{
			int num2 = indexByGameObject + 1;
			if (num2 >= mChildren.Count)
			{
				num2 = 0;
			}
			Vector3 topPosition = mChildren[num2].topPosition;
			topPosition.y += disInterval;
			mChildren[indexByGameObject].bottomPosition = topPosition;
		}
	}

	public void FastMove()
	{
		isMoveOutHide = false;
		isUpdateMove = true;
		curMove = 0f;
		totalMove = 0f;
		fastMove = true;
	}

	private int GetIndexByGameObject(GameObject obj)
	{
		for (int i = 0; i < mChildren.Count; i++)
		{
			if (mChildren[i].gameObject == obj)
			{
				return i;
			}
		}
		return -1;
	}

	public void Press(bool pressed)
	{
		if (!pressed && isPress != pressed && isMove)
		{
			if (moveMinIndex - 1 < minIndex)
			{
				UIAutoAnchors uIAutoAnchors = mChildren[0];
				Vector3 localPosition = mChildren[0].transform.localPosition;
				if (!mHorizontal)
				{
					Vector3 topPosition = uIAutoAnchors.topPosition;
					if (topPosition.y < 0f)
					{
						surplusDis = 0f - topPosition.y;
					}
				}
			}
			if (moveMaxIndex + 1 > maxIndex)
			{
				UIAutoAnchors uIAutoAnchors2 = mChildren[mChildren.Count - 1];
				if (!mHorizontal)
				{
					Vector3 bottomPosition = uIAutoAnchors2.bottomPosition;
					if (bottomPosition.y > 0f - mCutOut.y)
					{
						surplusDis = 0f - mCutOut.y - bottomPosition.y;
					}
				}
			}
			if (surplusDis < -1E-06f || surplusDis > 1E-06f)
			{
				secondMove = surplusDis / reboundTime;
				surplusRebound = reboundTime;
			}
		}
		isPress = pressed;
	}

	private void Update()
	{
		if (!isUpdateMove)
		{
			return;
		}
		float num = 0f;
		if (fastMove)
		{
			num = fastMoveDiff * Time.deltaTime;
		}
		else
		{
			num = moveDiff * Time.deltaTime;
			if (curMove + num >= totalMove)
			{
				isUpdateMove = false;
				num = totalMove - curMove;
			}
			curMove += num;
		}
		if (!isUp)
		{
			num = 0f - num;
		}
		num /= mMovePixels;
		Drag(new Vector2(0f, num), false);
		if (fastMove && IsNotMove())
		{
			fastMove = false;
			isUpdateMove = false;
			if (onMoveLastFinish != null)
			{
				onMoveLastFinish();
			}
		}
		else if (!isUpdateMove)
		{
			isMoveOutHide = false;
			if (onItemMoveFinish != null)
			{
				onItemMoveFinish();
			}
		}
	}

	private void LateUpdate()
	{
		if (isPress || !(surplusRebound > 0f))
		{
			return;
		}
		float deltaTime = Time.deltaTime;
		if (surplusRebound - Time.deltaTime < 0f)
		{
			deltaTime = surplusRebound;
			surplusDis = 0f;
		}
		surplusRebound -= Time.deltaTime;
		float num = deltaTime * secondMove;
		if (!mHorizontal)
		{
			int i = 0;
			for (int count = mChildren.Count; i < count; i++)
			{
				UIAutoAnchors uIAutoAnchors = mChildren[i];
				uIAutoAnchors.localPosition = new Vector3(uIAutoAnchors.localPosition.x, uIAutoAnchors.localPosition.y + num, uIAutoAnchors.localPosition.z);
			}
		}
	}

	private bool IsNotMove()
	{
		if (isUp)
		{
			return mChildren[mChildren.Count - 1].bottomPosition.y >= 0f - mCutOut.y;
		}
		return mChildren[0].topPosition.y <= 0f;
	}

	public bool IsBottom()
	{
		return moveMaxIndex + 1 > maxIndex;
	}

	public bool IsTop()
	{
		return moveMinIndex - 1 < minIndex;
	}
}
