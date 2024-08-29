using System.Collections.Generic;
using UnityEngine;

[AddComponentMenu("NGUI/Interaction/Wrap Content")]
public class UIWrapContent : MonoBehaviour
{
	public delegate void OnInitializeItem(GameObject go, int wrapIndex, int realIndex);

	public int itemSize = 100;

	public bool cullContent = true;

	public bool cloneMode;

	public Transform baseCloneItem;

	public int minIndex;

	public int maxIndex;

	public OnInitializeItem onInitializeItem;

	private bool isWrap;

	private Transform mTrans;

	private UIPanel mPanel;

	private UIScrollView mScroll;

	private bool mHorizontal;

	private bool mFirstTime = true;

	private List<Transform> mChildren = new List<Transform>();

	private int mCloneNumber;

	private int mMaxNumber;

	private List<Transform> mCloneList = new List<Transform>();

	protected virtual void Start()
	{
		CacheScrollView();
		if (mScroll != null)
		{
			mScroll.GetComponent<UIPanel>().onClipMove = OnMove;
		}
		mFirstTime = false;
	}

	protected virtual void OnMove(UIPanel panel)
	{
		WrapContent();
	}

	public void SetBaseCloneItem(Transform item)
	{
		if (cloneMode)
		{
			baseCloneItem = item;
		}
		else
		{
			Debug.LogError("UIWrapContent: not clone mode");
		}
	}

	[ContextMenu("Sort Based on Scroll Movement")]
	public void SortBasedOnScrollMovement()
	{
		if (!CacheScrollView())
		{
			return;
		}
		int num = maxIndex - minIndex;
		mChildren.Clear();
		if (cloneMode)
		{
			if (mMaxNumber == 0)
			{
				if (mHorizontal)
				{
					mMaxNumber = (int)(mPanel.width / (float)itemSize) + 2;
				}
				else
				{
					mMaxNumber = (int)(mPanel.height / (float)itemSize) + 2;
				}
			}
			mCloneNumber = mMaxNumber;
			if (mCloneNumber > num + 1)
			{
				mCloneNumber = num + 1;
			}
			if (baseCloneItem == null && mTrans.childCount > 0)
			{
				baseCloneItem = mTrans.GetChild(0);
			}
			mTrans.GetChild(0).gameObject.SetActive(false);
			if (baseCloneItem != null)
			{
				int childCount = mCloneNumber;
				if (mTrans.childCount > mCloneNumber)
				{
					childCount = mTrans.childCount;
				}
				for (int i = 1; i <= childCount; i++)
				{
					if (i <= mCloneNumber)
					{
						if (i > mTrans.childCount - 1)
						{
							Transform transform = Object.Instantiate(baseCloneItem);
							transform.parent = mTrans;
							transform.localPosition = baseCloneItem.localPosition;
							transform.localRotation = baseCloneItem.localRotation;
							transform.localScale = baseCloneItem.localScale;
							transform.name = "child" + string.Format("{0:D2}", i);
							transform.gameObject.SetActive(true);
							mChildren.Add(transform);
						}
						else
						{
							mTrans.GetChild(i).gameObject.SetActive(true);
							mChildren.Add(mTrans.GetChild(i));
						}
					}
					else if (i < mTrans.childCount)
					{
						mTrans.GetChild(i).gameObject.SetActive(false);
					}
				}
			}
		}
		else
		{
			for (int j = 0; j < mTrans.childCount; j++)
			{
				mTrans.GetChild(j).gameObject.SetActive(true);
				if (j > num)
				{
					mTrans.GetChild(j).gameObject.SetActive(false);
				}
				if (mTrans.GetChild(j).gameObject.activeSelf)
				{
					mChildren.Add(mTrans.GetChild(j));
				}
			}
		}
		mChildren.Sort(UIGrid.SortByName);
		ResetChildPositions();
		if (cloneMode)
		{
			if (mChildren.Count < mCloneNumber)
			{
				isWrap = true;
			}
			else
			{
				isWrap = false;
			}
		}
		else if (mChildren.Count < mTrans.childCount)
		{
			isWrap = true;
		}
		else
		{
			isWrap = false;
		}
	}

	[ContextMenu("Sort Alphabetically")]
	public void SortAlphabetically()
	{
		if (CacheScrollView())
		{
			mChildren.Clear();
			for (int i = 0; i < mTrans.childCount; i++)
			{
				mChildren.Add(mTrans.GetChild(i));
			}
			mChildren.Sort(UIGrid.SortByName);
			ResetChildPositions();
		}
	}

	protected bool CacheScrollView()
	{
		mTrans = base.transform;
		mPanel = NGUITools.FindInParents<UIPanel>(base.gameObject);
		mScroll = mPanel.GetComponent<UIScrollView>();
		if (mScroll == null)
		{
			return false;
		}
		if (mScroll.movement == UIScrollView.Movement.Horizontal)
		{
			mHorizontal = true;
		}
		else
		{
			if (mScroll.movement != UIScrollView.Movement.Vertical)
			{
				return false;
			}
			mHorizontal = false;
		}
		return true;
	}

	private void ResetChildPositions()
	{
		int i = 0;
		for (int count = mChildren.Count; i < count; i++)
		{
			Transform transform = mChildren[i];
			transform.localPosition = ((!mHorizontal) ? new Vector3(0f, -i * itemSize, 0f) : new Vector3(i * itemSize, 0f, 0f));
			UpdateItem(transform, i);
		}
	}

	public void WrapContent()
	{
		if (isWrap)
		{
			return;
		}
		float num = (float)(itemSize * mChildren.Count) * 0.5f;
		Vector3[] worldCorners = mPanel.worldCorners;
		for (int i = 0; i < 4; i++)
		{
			Vector3 position = worldCorners[i];
			position = mTrans.InverseTransformPoint(position);
			worldCorners[i] = position;
		}
		Vector3 vector = Vector3.Lerp(worldCorners[0], worldCorners[2], 0.5f);
		bool flag = true;
		float num2 = num * 2f;
		if (mHorizontal)
		{
			float num3 = worldCorners[0].x - (float)itemSize;
			float num4 = worldCorners[2].x + (float)itemSize;
			int j = 0;
			for (int count = mChildren.Count; j < count; j++)
			{
				Transform transform = mChildren[j];
				float num5 = transform.localPosition.x - vector.x;
				if (num5 < 0f - num)
				{
					Vector3 localPosition = transform.localPosition;
					localPosition.x += num2;
					num5 = localPosition.x - vector.x;
					int num6 = Mathf.RoundToInt(localPosition.x / (float)itemSize);
					if (minIndex == maxIndex || (minIndex <= num6 && num6 <= maxIndex))
					{
						transform.localPosition = localPosition;
						UpdateItem(transform, j);
					}
					else
					{
						flag = false;
					}
				}
				else if (num5 > num)
				{
					Vector3 localPosition2 = transform.localPosition;
					localPosition2.x -= num2;
					num5 = localPosition2.x - vector.x;
					int num7 = Mathf.RoundToInt(localPosition2.x / (float)itemSize);
					if (minIndex == maxIndex || (minIndex <= num7 && num7 <= maxIndex))
					{
						transform.localPosition = localPosition2;
						UpdateItem(transform, j);
					}
					else
					{
						flag = false;
					}
				}
				else if (mFirstTime)
				{
					UpdateItem(transform, j);
				}
				if (cullContent)
				{
					num5 += mPanel.clipOffset.x - mTrans.localPosition.x;
					if (!UICamera.IsPressed(transform.gameObject))
					{
						NGUITools.SetActive(transform.gameObject, num5 > num3 && num5 < num4, false);
					}
				}
			}
		}
		else
		{
			float num8 = worldCorners[0].y - (float)itemSize;
			float num9 = worldCorners[2].y + (float)itemSize;
			int k = 0;
			for (int count2 = mChildren.Count; k < count2; k++)
			{
				Transform transform2 = mChildren[k];
				float num10 = transform2.localPosition.y - vector.y;
				if (num10 < 0f - num)
				{
					Vector3 localPosition3 = transform2.localPosition;
					localPosition3.y += num2;
					num10 = localPosition3.y - vector.y;
					int num11 = Mathf.RoundToInt(localPosition3.y / (float)itemSize);
					if (minIndex == maxIndex || (minIndex <= num11 && num11 <= maxIndex))
					{
						transform2.localPosition = localPosition3;
						UpdateItem(transform2, k);
					}
					else
					{
						flag = false;
					}
				}
				else if (num10 > num)
				{
					Vector3 localPosition4 = transform2.localPosition;
					localPosition4.y -= num2;
					num10 = localPosition4.y - vector.y;
					int num12 = Mathf.RoundToInt(localPosition4.y / (float)itemSize);
					if (minIndex == maxIndex || (minIndex <= num12 && num12 <= maxIndex))
					{
						transform2.localPosition = localPosition4;
						UpdateItem(transform2, k);
					}
					else
					{
						flag = false;
					}
				}
				else if (mFirstTime)
				{
					UpdateItem(transform2, k);
				}
				if (cullContent)
				{
					num10 += mPanel.clipOffset.y - mTrans.localPosition.y;
					if (!UICamera.IsPressed(transform2.gameObject))
					{
						NGUITools.SetActive(transform2.gameObject, num10 > num8 && num10 < num9, false);
					}
				}
			}
		}
		mScroll.restrictWithinPanel = !flag;
	}

	private void OnValidate()
	{
		if (maxIndex < minIndex)
		{
			maxIndex = minIndex;
		}
		if (minIndex > maxIndex)
		{
			maxIndex = minIndex;
		}
	}

	protected virtual void UpdateItem(Transform item, int index)
	{
		if (onInitializeItem != null)
		{
			int realIndex = ((mScroll.movement != UIScrollView.Movement.Vertical) ? Mathf.RoundToInt(item.localPosition.x / (float)itemSize) : Mathf.RoundToInt(item.localPosition.y / (float)itemSize));
			onInitializeItem(item.gameObject, index, realIndex);
		}
	}
}
