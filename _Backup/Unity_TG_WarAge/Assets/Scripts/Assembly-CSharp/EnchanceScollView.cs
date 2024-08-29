using System;
using System.Collections.Generic;
using UnityEngine;

public class EnchanceScollView : MonoBehaviour
{
	public delegate void OnInitializeItem(GameObject go, int index);

	public delegate void OnStopMove(int index);

	public delegate void OnOutStateChange(bool outState);

	public enum DragCycleGroupType
	{
		List = 0,
		NormalList = 1,
		Cycle = 2
	}

	public enum Align
	{
		Top = 0,
		Center = 1,
		Bottom = 2,
		TopBottom = 3,
		BottomTop = 4
	}

	public enum Direction
	{
		horizontalRight = 0,
		horizontalLeft = 1,
		verticallyTop = 2,
		verticallyDown = 3
	}

	private enum TweenValueType
	{
		Angle = 0,
		AngleSpeed = 1
	}

	public delegate float UserCallBack(float a);

	public delegate void UserCall();

	public enum Method
	{
		LINEAR = 0,
		EASE_IN = 1,
		EASE_OUT = 2,
		EASE_IN_OUT = 3,
		EASE_OUT_IN = 4,
		EASE_IN_BACK = 5,
		EASE_OUT_BACK = 6,
		EASE_IN_OUT_BACK = 7,
		EASE_OUT_IN_BACK = 8,
		EASE_IN_ELASTIC = 9,
		EASE_OUT_ELASTIC = 10,
		EASE_IN_OUT_ELASTIC = 11,
		EASE_IN_BOUNCE = 12,
		EASE_OUT_BOUNCE = 13,
		EASE_IN_OUT_BOUNCE = 14,
		EASE_OUT_IN_BOUNCE = 15,
		EASE_IN_TO_OUT_ELASTIC = 16
	}

	public Direction listDirection;

	public DragCycleGroupType type;

	public Align alignType = Align.Center;

	public int itemHeight = 100;

	private Transform mTrans;

	public GameObject parent;

	public GameObject baseItem;

	public GameObject dragItem;

	public bool connectBeginEnd;

	public int _raid = 300;

	public float tweenToIndexTime = 0.5f;

	public Color _fadeColor = new Color(0f, 0f, 0f);

	public int _showNum;

	public int _maxNum;

	private bool canMove = true;

	public bool enableDrag = true;

	private float showWindowWidth;

	private float itemShowWidth;

	public float brakeTime = 0.15f;

	public float dragBackTime = 0.8f;

	public float _farScale = 0.5f;

	public float _nearScale = 1f;

	public float minScaleLimit;

	public float _dragStopValue = 0.5f;

	public float _dragMult;

	public float _slideMult = 1f;

	public float _nearStopProgress = 0.8f;

	public bool mdistanceFollowScale;

	public float _offsetAngle;

	private float angleMin = float.MinValue;

	private float angleMin2 = float.MinValue;

	private float angleMax;

	private float angleSpace;

	private float angleWindow;

	private float parentWidth;

	private float parentHeight;

	private int touchDir;

	private List<Transform> itemList;

	private List<float> itemStartAngleList;

	private List<int> itemIndexList;

	public OnInitializeItem onInitializeItem;

	public OnStopMove onStopMove;

	public UserCall onStartMove;

	public UserCall onDragToEnd;

	public OnOutStateChange onOutStart;

	public OnOutStateChange onOutEnd;

	public bool isDynamicList;

	private bool needResize;

	private float _realAngle;

	private float curAngle;

	private float px;

	private float py;

	private int index;

	private float len;

	private int depth;

	private float red;

	private float green;

	private float blue;

	private float alpha;

	private Color color = default(Color);

	private float lineScale;

	private float angleShift;

	private float checkAngle;

	private int count;

	private float minLineScaleLimit;

	private Transform curItem;

	private List<EnchanceSVItem> itemESVList;

	private bool outStart;

	private bool outEnd;

	private float sAngle;

	private float sx;

	private List<Vector2> deltaList = new List<Vector2>();

	private int curIndex;

	private float disAngle;

	private float targetAngle;

	private bool isCompleteMove;

	private int curShowIndex = 1;

	private float _ct;

	private float _curTweenTime;

	private float _totalTweenTime;

	private float _angle;

	private float _startAngle;

	private float _toAngle;

	private Method _tweenMethod;

	private UserCall _updateFunc;

	private UserCall _completeFunc;

	private UserCall _nearCompleteF;

	private UserCall _nearCompleteF2;

	private TweenValueType _tweenValueType;

	private float _lastAngle;

	private float angleSpeed;

	private float angleTimeSpeed;

	private bool haveStartEnterFrame;

	private Dictionary<Method, UserCallBack> sTransitions = new Dictionary<Method, UserCallBack>();

	public int raid
	{
		get
		{
			return _raid;
		}
		set
		{
			if (_raid != value)
			{
				_raid = value;
				set_angle(_angle);
			}
		}
	}

	public int showNum
	{
		get
		{
			return _showNum;
		}
		set
		{
			if (_showNum != value)
			{
				_showNum = value;
				InitListData();
			}
		}
	}

	public int maxNum
	{
		get
		{
			return _maxNum;
		}
		set
		{
			if (_maxNum == value)
			{
				return;
			}
			if (itemList == null)
			{
				InitListData();
			}
			_maxNum = value;
			if (type == DragCycleGroupType.NormalList)
			{
				UISprite component = baseItem.GetComponent<UISprite>();
				UISprite component2 = parent.GetComponent<UISprite>();
				float num = component.width;
				float num2 = component.height;
				float num3 = component2.width;
				float num4 = component2.height;
				parentWidth = num3;
				parentHeight = num4;
				if (listDirection == Direction.verticallyDown || listDirection == Direction.verticallyTop)
				{
					num = component.height;
					num2 = component.width;
					num3 = component2.height;
					num4 = component2.width;
				}
				showWindowWidth = num3;
				itemShowWidth = num;
				if (touchDir == 0)
				{
					_showNum = (int)Mathf.Ceil(num3 / num) + 1;
					angleSpace = 360 / _showNum;
					angleWindow = angleSpace * (num3 / num);
					float num5 = deg2rad(angleSpace);
					_raid = (int)(num / num5 * 2f);
					_offsetAngle = (0f - (num3 - num)) / (float)_raid / (float)Math.PI * 180f;
					angleMin = (0f - angleSpace) * ((float)_maxNum - num3 / num);
					if (angleMin > 0f)
					{
						angleMin = 0f;
					}
					angleMin2 = angleMin - angleSpace;
				}
			}
			else
			{
				angleMin = (0f - angleSpace) * (float)(_maxNum - 1);
				angleMin2 = angleMin - angleSpace;
			}
			angleMax = 0f;
			if (type == DragCycleGroupType.NormalList && (float)_maxNum * itemShowWidth < showWindowWidth)
			{
				set_angle(angleMax);
			}
			else if (_angle > angleMax)
			{
				targetAngle = angleMax;
				isCompleteMove = true;
				tweenAngle(0.5f, TweenValueType.Angle, targetAngle, Method.EASE_OUT, updateAngle);
			}
			else if (_angle < angleMin)
			{
				targetAngle = angleMin;
				isCompleteMove = true;
				tweenAngle(0.5f, TweenValueType.Angle, targetAngle, Method.EASE_OUT, updateAngle);
			}
			else
			{
				set_angle(_angle);
			}
			if (_maxNum <= 1)
			{
				canMove = false;
			}
			else if (type == DragCycleGroupType.NormalList && (float)_maxNum * itemShowWidth < showWindowWidth)
			{
				canMove = false;
			}
			else
			{
				canMove = true;
			}
		}
	}

	public float farScale
	{
		get
		{
			return _farScale;
		}
		set
		{
			if (_farScale != value)
			{
				_farScale = value;
				set_angle(_angle);
			}
		}
	}

	public float nearScale
	{
		get
		{
			return _nearScale;
		}
		set
		{
			if (_nearScale != value)
			{
				_nearScale = value;
				set_angle(_angle);
			}
		}
	}

	public float dragMult
	{
		get
		{
			return _dragMult;
		}
		set
		{
			if (_dragMult != value && value > -1f)
			{
				_dragMult = value;
			}
		}
	}

	public float slideMult
	{
		get
		{
			return _slideMult;
		}
		set
		{
			if (_slideMult != value && value > -1f)
			{
				_slideMult = value;
			}
		}
	}

	public bool distanceFollowScale
	{
		get
		{
			return mdistanceFollowScale;
		}
		set
		{
			if (mdistanceFollowScale != value)
			{
				mdistanceFollowScale = value;
				set_angle(_angle);
			}
		}
	}

	public float offsetAngle
	{
		get
		{
			return _offsetAngle;
		}
		set
		{
			if (_offsetAngle != value)
			{
				_offsetAngle = value;
				set_angle(_angle);
			}
		}
	}

	public void SetDynamic(bool isDynamic)
	{
		if (isDynamic != isDynamicList)
		{
			isDynamicList = isDynamic;
			tweenToIndex(curIndex, true);
		}
	}

	private void Start()
	{
		mTrans = base.transform;
		InitTweenFunctions();
		if (itemList == null)
		{
			InitListData();
		}
		set_angle(_angle);
	}

	private void InitListData()
	{
		if (dragItem == null)
		{
			UIEventListener.Get(parent.gameObject).onDragStart = onDragStart;
			UIEventListener.Get(parent.gameObject).onDrag = onDrag;
			UIEventListener.Get(parent.gameObject).onDragEnd = onDragEnd;
		}
		else
		{
			UIEventListener.Get(dragItem.gameObject).onDragStart = onDragStart;
			UIEventListener.Get(dragItem.gameObject).onDrag = onDrag;
			UIEventListener.Get(dragItem.gameObject).onDragEnd = onDragEnd;
		}
		int num = 0;
		if (itemList != null)
		{
			int num2 = itemList.Count;
			for (num = 0; num < num2; num++)
			{
				Transform transform = itemList[num];
				transform.gameObject.SetActive(false);
				transform.parent = null;
			}
		}
		itemList = new List<Transform>();
		itemStartAngleList = new List<float>();
		itemIndexList = new List<int>();
		if (type == DragCycleGroupType.NormalList)
		{
			UIWidget component = parent.GetComponent<UIWidget>();
			component.onChange = onParentSizeChange;
			UISprite component2 = baseItem.GetComponent<UISprite>();
			UISprite component3 = parent.GetComponent<UISprite>();
			float num3 = component2.width;
			float num4 = component2.height;
			float num5 = component3.width;
			float num6 = component3.height;
			parentWidth = num5;
			parentHeight = num6;
			if (listDirection == Direction.verticallyDown || listDirection == Direction.verticallyTop)
			{
				num3 = component2.height;
				num4 = component2.width;
				num5 = component3.height;
				num6 = component3.width;
			}
			showWindowWidth = num5;
			itemShowWidth = num3;
			if (touchDir == 0)
			{
				_showNum = (int)Mathf.Ceil(num5 / num3) + 1;
				angleSpace = 360 / _showNum;
				angleWindow = angleSpace * (num5 / num3);
				float num7 = deg2rad(angleSpace);
				_raid = (int)(num3 / num7 * 2f);
				_offsetAngle = (0f - (num5 - num3)) / (float)_raid / (float)Math.PI * 180f;
				angleMin = (0f - angleSpace) * ((float)_maxNum - num5 / num3);
				if (angleMin > 0f)
				{
					angleMin = 0f;
				}
				angleMin2 = angleMin - angleSpace;
			}
		}
		baseItem.gameObject.SetActive(false);
		angleSpace = 360 / _showNum;
		if (itemESVList == null)
		{
			itemESVList = new List<EnchanceSVItem>();
		}
		else
		{
			itemESVList.Clear();
		}
		for (num = 0; num < _showNum; num++)
		{
			Transform transform2 = UnityEngine.Object.Instantiate(baseItem.transform);
			EnchanceSVItem component4 = transform2.GetComponent<EnchanceSVItem>();
			if (component4 != null)
			{
				component4.init();
				itemESVList.Add(component4);
			}
			transform2.parent = parent.transform;
			GameObject gameObject = transform2.gameObject;
			UIEventListener.Get(gameObject).onDragStart = onDragStart;
			UIEventListener.Get(gameObject).onDrag = onDrag;
			UIEventListener.Get(gameObject).onDragEnd = onDragEnd;
			gameObject.SetActive(true);
			itemList.Add(transform2);
			itemStartAngleList.Add((float)num * angleSpace);
			itemIndexList.Add(-9999999);
		}
		if (type == DragCycleGroupType.Cycle)
		{
			angleMin = (0f - angleSpace) * (float)(_maxNum - 1);
			angleMax = 0f;
		}
		else
		{
			angleMax = 0f;
		}
		if (angleMin == float.MinValue)
		{
			angleMin = (0f - angleSpace) * (float)(_maxNum - 1);
			angleMin2 = angleMin - angleSpace;
		}
		if (type == DragCycleGroupType.NormalList && (float)_maxNum * itemShowWidth < showWindowWidth)
		{
			angleMin = angleMax;
			angleMin2 = angleMin - angleSpace;
		}
	}

	private void onParentSizeChange()
	{
		needResize = true;
	}

	private void toResize()
	{
		if (itemList == null || type != DragCycleGroupType.NormalList)
		{
			return;
		}
		UISprite component = baseItem.GetComponent<UISprite>();
		UISprite component2 = parent.GetComponent<UISprite>();
		float num = component.width;
		float num2 = component.height;
		float num3 = component2.width;
		float num4 = component2.height;
		if (num3 == parentWidth && num4 == parentHeight)
		{
			return;
		}
		parentWidth = num3;
		parentHeight = num4;
		if (listDirection == Direction.verticallyDown || listDirection == Direction.verticallyTop)
		{
			num = component.height;
			num2 = component.width;
			num3 = component2.height;
			num4 = component2.width;
		}
		showWindowWidth = num3;
		itemShowWidth = num;
		if (touchDir == 0)
		{
			_showNum = (int)Mathf.Ceil(num3 / num) + 1;
			angleSpace = 360 / _showNum;
			angleWindow = angleSpace * (num3 / num);
			float num5 = deg2rad(angleSpace);
			_raid = (int)(num / num5 * 2f);
			_offsetAngle = (0f - (num3 - num)) / (float)_raid / (float)Math.PI * 180f;
			angleMin = (0f - angleSpace) * ((float)_maxNum - num3 / num);
			angleMin2 = angleMin - angleSpace;
		}
		int num6 = 0;
		angleMax = 0f;
		int num7 = itemList.Count;
		int num8 = Mathf.Max(_showNum, num7);
		if (itemESVList == null)
		{
			itemESVList = new List<EnchanceSVItem>();
		}
		else
		{
			itemESVList.Clear();
		}
		for (num6 = 0; num6 < num8; num6++)
		{
			if (num6 >= num7)
			{
				Transform transform = UnityEngine.Object.Instantiate(baseItem.transform);
				EnchanceSVItem component3 = transform.GetComponent<EnchanceSVItem>();
				if (component3 != null)
				{
					component3.init();
					itemESVList.Add(component3);
				}
				transform.parent = parent.transform;
				GameObject gameObject = transform.gameObject;
				UIEventListener.Get(gameObject).onDragStart = onDragStart;
				UIEventListener.Get(gameObject).onDrag = onDrag;
				UIEventListener.Get(gameObject).onDragEnd = onDragEnd;
				gameObject.SetActive(true);
				itemList.Add(transform);
				itemStartAngleList.Add((float)num6 * angleSpace);
				itemIndexList.Add(-9999999);
			}
			else if (num6 >= _showNum)
			{
				itemList[num6].gameObject.SetActive(false);
			}
			else
			{
				itemList[num6].gameObject.SetActive(true);
				itemStartAngleList[num6] = (float)num6 * angleSpace;
				itemIndexList[num6] = -9999999;
			}
		}
		set_showIndex(curShowIndex);
	}

	private float deg2rad(float a)
	{
		return mod(a, 360f) / 360f * 2f * (float)Math.PI;
	}

	private float mod(float a, float b)
	{
		if (a < 0f)
		{
			return a % b + b;
		}
		return a % b;
	}

	private void set_angle(float a, bool needPrint = false)
	{
		_realAngle = a;
		count = itemList.Count;
		minLineScaleLimit = (minScaleLimit - _farScale) / (_nearScale - _farScale);
		if (type == DragCycleGroupType.Cycle)
		{
			for (int i = 0; i < count; i++)
			{
				curItem = itemList[i];
				curAngle = itemStartAngleList[i] + a;
				px = (float)_raid * Mathf.Sin(deg2rad(curAngle));
				float num = (_nearScale - _farScale) * (1f + Mathf.Cos(deg2rad(curAngle))) / 2f + _farScale;
				float num2 = (num - _farScale) / (_nearScale - _farScale);
				red = num2 * (1f - _fadeColor.r) + _fadeColor.r;
				green = num2 * (1f - _fadeColor.g) + _fadeColor.g;
				blue = num2 * (1f - _fadeColor.b) + _fadeColor.b;
				alpha = num2 * (1f - _fadeColor.a) + _fadeColor.a;
				color.r = red;
				color.g = green;
				color.b = blue;
				color.a = alpha;
				depth = (int)(Mathf.Floor(num / 0.01f) * 500f);
				if (itemESVList.Count != 0)
				{
					itemESVList[i].set_color(color);
					itemESVList[i].set_depth(depth);
				}
				py = 0f;
				if (px != 0f)
				{
					switch (alignType)
					{
					case Align.Top:
						py = (float)(-itemHeight / 2) * num + (float)(itemHeight / 2);
						break;
					case Align.Bottom:
						py = (float)(itemHeight / 2) * num - (float)(itemHeight / 2);
						break;
					case Align.TopBottom:
						py = px / Mathf.Abs(px) * ((float)(itemHeight / 2) * num - (float)(itemHeight / 2));
						break;
					case Align.BottomTop:
						py = (0f - px / Mathf.Abs(px)) * ((float)(itemHeight / 2) * num - (float)(itemHeight / 2));
						break;
					}
				}
				if (num < minScaleLimit)
				{
					num = minScaleLimit;
				}
				curItem.localScale = new Vector3(num, num, num);
				switch (listDirection)
				{
				case Direction.horizontalRight:
					curItem.localPosition = new Vector3(px, py, 0f);
					break;
				case Direction.verticallyTop:
					curItem.localPosition = new Vector3(py, px, 0f);
					break;
				case Direction.horizontalLeft:
					curItem.localPosition = new Vector3(0f - px, py, 0f);
					break;
				case Direction.verticallyDown:
					curItem.localPosition = new Vector3(py, 0f - px, 0f);
					break;
				}
				curItem.gameObject.SetActive(true);
				if (onInitializeItem != null)
				{
					onInitializeItem(curItem.gameObject, 0);
				}
			}
		}
		else if (type == DragCycleGroupType.List)
		{
			if ((isDynamicList && _realAngle <= angleMin2) || (!isDynamicList && _realAngle <= angleMin))
			{
				if (!outEnd)
				{
					outEnd = true;
					if (onOutEnd != null)
					{
						onOutEnd(true);
					}
				}
			}
			else if (outEnd)
			{
				outEnd = false;
				if (onOutEnd != null)
				{
					onOutEnd(false);
				}
			}
			if (_realAngle >= angleMax)
			{
				if (!outStart)
				{
					outStart = true;
					if (onOutStart != null)
					{
						onOutStart(true);
					}
				}
			}
			else if (outStart)
			{
				outStart = false;
				if (onOutStart != null)
				{
					onOutStart(false);
				}
			}
			for (int j = 0; j < count; j++)
			{
				curItem = itemList[j];
				int num3 = itemIndexList[j];
				curAngle = itemStartAngleList[j] + a;
				len = (float)_raid * deg2rad(curAngle + _offsetAngle);
				if (len < (float)Math.PI * (float)_raid)
				{
					px = len / 2f;
				}
				else
				{
					px = (0f - ((float)Math.PI * (float)_raid * 2f - len)) / 2f;
				}
				index = -(int)Mathf.Floor((curAngle + _offsetAngle + 180f) / 360f) * _showNum + j + 1;
				angleShift = 180f - _offsetAngle;
				checkAngle = mod(curAngle, 360f);
				if (checkAngle >= angleShift)
				{
					lineScale = (checkAngle - angleShift) / (360f - angleShift);
				}
				else
				{
					lineScale = (angleShift - checkAngle) / angleShift;
				}
				float num4 = (_nearScale - _farScale) * lineScale + _farScale;
				if (!mdistanceFollowScale)
				{
					px = px / ((float)Math.PI * (float)_raid) * (float)_raid * 2f;
				}
				else if (px > 0f)
				{
					px = (float)_raid - Mathf.Pow(lineScale, 1.5f) * (float)_raid;
				}
				else
				{
					px = 0f - ((float)_raid - Mathf.Pow(lineScale, 1.5f) * (float)_raid);
				}
				depth = (int)(Mathf.Floor(lineScale / 0.01f) * 500f);
				if (num4 < minScaleLimit)
				{
					num4 = minScaleLimit;
				}
				if (lineScale < minLineScaleLimit)
				{
					lineScale = minLineScaleLimit;
				}
				red = lineScale + _fadeColor.r;
				green = lineScale + _fadeColor.g;
				blue = lineScale + _fadeColor.b;
				alpha = lineScale + _fadeColor.a;
				color.r = red;
				color.g = green;
				color.b = blue;
				color.a = alpha;
				if (itemESVList.Count != 0)
				{
					itemESVList[j].set_color(color);
					itemESVList[j].set_depth(depth);
				}
				curItem.localScale = new Vector3(num4, num4, num4);
				py = 0f;
				if (px != 0f)
				{
					switch (alignType)
					{
					case Align.Top:
						py = (float)(-itemHeight / 2) * num4 + (float)(itemHeight / 2);
						break;
					case Align.Bottom:
						py = (float)(itemHeight / 2) * num4 - (float)(itemHeight / 2);
						break;
					case Align.TopBottom:
						py = px / Mathf.Abs(px) * ((float)(itemHeight / 2) * num4 - (float)(itemHeight / 2));
						break;
					case Align.BottomTop:
						py = (0f - px / Mathf.Abs(px)) * ((float)(itemHeight / 2) * num4 - (float)(itemHeight / 2));
						break;
					}
				}
				switch (listDirection)
				{
				case Direction.horizontalRight:
					curItem.localPosition = new Vector3(px, py, 0f);
					break;
				case Direction.verticallyTop:
					curItem.localPosition = new Vector3(py, px, 0f);
					break;
				case Direction.horizontalLeft:
					curItem.localPosition = new Vector3(0f - px, py, 0f);
					break;
				case Direction.verticallyDown:
					curItem.localPosition = new Vector3(py, 0f - px, 0f);
					break;
				}
				if (connectBeginEnd)
				{
					int num5 = (int)mod(index, _maxNum);
					if (num5 == 0)
					{
						index = _maxNum;
					}
					else
					{
						index = num5;
					}
				}
				else if (index < 1 || index > _maxNum)
				{
					if (!isDynamicList || index != _maxNum + 1)
					{
						curItem.localScale = new Vector3(0f, 0f, 0f);
						curItem.localPosition = new Vector3(-99999f, 0f, 0f);
					}
				}
				else
				{
					curItem.localScale = new Vector3(num4, num4, num4);
				}
				if (num3 == index)
				{
					continue;
				}
				itemIndexList[j] = index;
				if (onInitializeItem != null)
				{
					if (isDynamicList && index > 0 && index <= _maxNum + 1)
					{
						onInitializeItem(curItem.gameObject, index);
					}
					else if (!isDynamicList && index > 0 && index <= _maxNum)
					{
						onInitializeItem(curItem.gameObject, index);
					}
				}
			}
		}
		else
		{
			if (type != DragCycleGroupType.NormalList)
			{
				return;
			}
			if ((isDynamicList && _realAngle <= angleMin2) || (!isDynamicList && _realAngle <= angleMin))
			{
				if (!outEnd)
				{
					outEnd = true;
					if (onOutEnd != null)
					{
						onOutEnd(true);
					}
				}
			}
			else if (outEnd)
			{
				outEnd = false;
				if (onOutEnd != null)
				{
					onOutEnd(false);
				}
			}
			if (_realAngle >= angleMax)
			{
				if (!outStart)
				{
					outStart = true;
					if (onOutStart != null)
					{
						onOutStart(true);
					}
				}
			}
			else if (outStart)
			{
				outStart = false;
				if (onOutStart != null)
				{
					onOutStart(false);
				}
			}
			for (int k = 0; k < count; k++)
			{
				curItem = itemList[k];
				float num6 = itemStartAngleList[k];
				int num7 = itemIndexList[k];
				curAngle = num6 + a;
				len = (float)_raid * deg2rad(curAngle + _offsetAngle);
				if (len < (float)Math.PI * (float)_raid)
				{
					px = len / 2f;
				}
				else
				{
					px = (0f - ((float)Math.PI * (float)_raid * 2f - len)) / 2f;
				}
				index = -(int)Mathf.Floor((curAngle + _offsetAngle + 180f) / 360f) * _showNum + k + 1;
				switch (listDirection)
				{
				case Direction.horizontalRight:
					curItem.localPosition = new Vector3(px, 0f, 0f);
					break;
				case Direction.verticallyTop:
					curItem.localPosition = new Vector3(0f, px, 0f);
					break;
				case Direction.horizontalLeft:
					curItem.localPosition = new Vector3(0f - px, 0f, 0f);
					break;
				case Direction.verticallyDown:
					curItem.localPosition = new Vector3(0f, 0f - px, 0f);
					break;
				}
				if (connectBeginEnd)
				{
					int num8 = (int)mod(index, _maxNum);
					if (num8 == 0)
					{
						index = _maxNum;
					}
					else
					{
						index = num8;
					}
					curItem.localScale = new Vector3(1f, 1f, 1f);
				}
				else if (index < 1 || index > _maxNum)
				{
					if (!isDynamicList || index != _maxNum + 1)
					{
						curItem.localScale = new Vector3(0f, 0f, 0f);
						curItem.localPosition = new Vector3(-99999f, 0f, 0f);
					}
				}
				else
				{
					curItem.localScale = new Vector3(1f, 1f, 1f);
				}
				if (num7 == index)
				{
					continue;
				}
				itemIndexList[k] = index;
				if (onInitializeItem != null)
				{
					if (isDynamicList && index > 0 && index <= _maxNum + 1)
					{
						onInitializeItem(curItem.gameObject, index);
					}
					else if (!isDynamicList && index > 0 && index <= _maxNum)
					{
						onInitializeItem(curItem.gameObject, index);
					}
				}
			}
		}
	}

	public void onDragStart(GameObject go)
	{
		if (enableDrag)
		{
			isCompleteMove = false;
			px = UICamera.currentTouch.pos.x;
			py = UICamera.currentTouch.pos.y;
			if (onStartMove != null && canMove)
			{
				onStartMove();
			}
			sAngle = _realAngle;
			switch (listDirection)
			{
			case Direction.horizontalRight:
				sx = px;
				break;
			case Direction.verticallyTop:
				sx = py;
				break;
			case Direction.horizontalLeft:
				sx = px;
				break;
			case Direction.verticallyDown:
				sx = py;
				break;
			}
			deltaList.RemoveRange(0, deltaList.Count);
		}
	}

	private void setExtendDragValue(Vector2 delta)
	{
		int num = deltaList.Count;
		if (num > 1)
		{
			deltaList.RemoveAt(0);
			deltaList.Add(new Vector2(delta.x, RealTime.time));
		}
		else
		{
			deltaList.Add(new Vector2(delta.x, RealTime.time));
		}
	}

	private float getExtendDragSpeed()
	{
		int num = deltaList.Count;
		float num2 = 0f;
		float num3 = 1E-08f;
		for (int i = 1; i < num; i++)
		{
			num2 += deltaList[i].x;
			num3 += deltaList[i].y - deltaList[0].y;
		}
		return num2 / num3 / 16f;
	}

	public void onDrag(GameObject go, Vector2 delta)
	{
		if (!enableDrag)
		{
			return;
		}
		isCompleteMove = true;
		if (canMove)
		{
			px = UICamera.currentTouch.pos.x;
			py = UICamera.currentTouch.pos.y;
			disAngle = 0f;
			switch (listDirection)
			{
			case Direction.horizontalRight:
				disAngle = (px - sx) / (float)_raid / (float)Math.PI * 180f * (1f + _dragMult) * 2.35f;
				break;
			case Direction.verticallyTop:
				disAngle = (py - sx) / (float)_raid / (float)Math.PI * 180f * (1f + _dragMult) * 2.35f;
				break;
			case Direction.horizontalLeft:
				disAngle = (0f - (px - sx)) / (float)_raid / (float)Math.PI * 180f * (1f + _dragMult) * 2.35f;
				break;
			case Direction.verticallyDown:
				disAngle = (0f - (py - sx)) / (float)_raid / (float)Math.PI * 180f * (1f + _dragMult) * 2.35f;
				break;
			}
			targetAngle = 0f;
			if (connectBeginEnd)
			{
				targetAngle = disAngle + sAngle;
			}
			else if ((!isDynamicList && sAngle + disAngle < angleMin) || (isDynamicList && sAngle + disAngle < angleMin2))
			{
				targetAngle = ((!isDynamicList) ? (angleMin + (sAngle + disAngle - angleMin) * _dragStopValue) : (angleMin2 + (sAngle + disAngle - angleMin2) * _dragStopValue));
			}
			else if (sAngle + disAngle > angleMax)
			{
				targetAngle = angleMax + (sAngle + disAngle - angleMax) * _dragStopValue;
			}
			else
			{
				targetAngle = disAngle + sAngle;
			}
			tweenAngle(0.1f, TweenValueType.Angle, targetAngle, Method.EASE_OUT, updateAngle);
		}
	}

	public void onDragEnd(GameObject go)
	{
		if (!enableDrag)
		{
			return;
		}
		isCompleteMove = false;
		if (!canMove)
		{
			return;
		}
		px = UICamera.currentTouch.pos.x;
		py = UICamera.currentTouch.pos.y;
		disAngle = 0f;
		switch (listDirection)
		{
		case Direction.horizontalRight:
			disAngle = (px - sx) / (float)_raid / (float)Math.PI * 180f * (1f + _dragMult) * 2.35f;
			break;
		case Direction.verticallyTop:
			disAngle = (py - sx) / (float)_raid / (float)Math.PI * 180f * (1f + _dragMult) * 2.35f;
			break;
		case Direction.horizontalLeft:
			disAngle = (0f - (px - sx)) / (float)_raid / (float)Math.PI * 180f * (1f + _dragMult) * 2.35f;
			break;
		case Direction.verticallyDown:
			disAngle = (0f - (py - sx)) / (float)_raid / (float)Math.PI * 180f * (1f + _dragMult) * 2.35f;
			break;
		}
		targetAngle = disAngle + sAngle + angleTimeSpeed * (1f + _dragMult) * _slideMult;
		curIndex = 0;
		if (connectBeginEnd)
		{
			if (disAngle < 0f)
			{
				targetAngle = Mathf.Floor(targetAngle / angleSpace) * angleSpace;
			}
			else
			{
				targetAngle = Mathf.Ceil(targetAngle / angleSpace) * angleSpace;
			}
			curIndex = (int)Mathf.Floor((0f - targetAngle) / angleSpace + 1f);
		}
		else
		{
			if ((!isDynamicList && targetAngle <= angleMax && targetAngle >= angleMin) || (isDynamicList && targetAngle <= angleMax && targetAngle >= angleMin2))
			{
				if (disAngle < 0f)
				{
					targetAngle = Mathf.Floor(targetAngle / angleSpace) * angleSpace;
				}
				else
				{
					targetAngle = Mathf.Ceil(targetAngle / angleSpace) * angleSpace;
				}
			}
			float num = targetAngle;
			if ((!isDynamicList && targetAngle < angleMin) || (isDynamicList && targetAngle < angleMin2))
			{
				num = ((!isDynamicList) ? angleMin : angleMin2);
			}
			else if (targetAngle > angleMax)
			{
				num = angleMax;
			}
			curIndex = (int)Mathf.Floor((0f - num) / angleSpace + 1f);
		}
		float time = Mathf.Abs(_angle - targetAngle) / 360f + 0.2f;
		if (connectBeginEnd)
		{
			int num2 = (int)mod(curIndex, _maxNum);
			if (num2 == 0)
			{
				curIndex = _maxNum;
			}
			else
			{
				curIndex = num2;
			}
			tweenAngle(time, TweenValueType.Angle, targetAngle, Method.EASE_OUT, updateAngle, resetCurAngle, nearComplete);
		}
		else if (_angle > angleMax || (!isDynamicList && _angle < angleMin) || (isDynamicList && _angle < angleMin2))
		{
			moveComplete();
			_nearCompleteF = nearComplete;
		}
		else
		{
			tweenAngle(time, TweenValueType.Angle, targetAngle, Method.EASE_OUT, updateAngle, moveComplete, nearComplete);
		}
	}

	private void updateAngle()
	{
		float angle = _angle;
		set_angle(angle);
	}

	private void nearComplete()
	{
		if (onStopMove != null)
		{
			if (type == DragCycleGroupType.NormalList)
			{
				onStopMove(Mathf.RoundToInt((0f - _realAngle) / angleSpace) + 1);
			}
			else
			{
				onStopMove(curIndex);
			}
		}
	}

	private void moveComplete()
	{
		float num = 2.1474836E+09f;
		if (type == DragCycleGroupType.NormalList && (float)_maxNum * itemShowWidth < showWindowWidth)
		{
			isCompleteMove = true;
			num = angleMax;
			tweenAngle(dragBackTime, TweenValueType.Angle, num, Method.EASE_OUT, updateAngle);
			return;
		}
		if (_angle > angleMax)
		{
			num = angleMax;
		}
		if ((!isDynamicList && _angle < angleMin) || (isDynamicList && _angle < angleMin2))
		{
			num = ((!isDynamicList) ? angleMin : angleMin2);
		}
		if (num != 2.1474836E+09f)
		{
			isCompleteMove = true;
			_angle = _realAngle;
			tweenAngle(dragBackTime, TweenValueType.Angle, num, Method.EASE_OUT, updateAngle);
		}
	}

	private void resetCurAngle()
	{
		float num = angleMax - angleMin + angleSpace;
		_realAngle %= num;
		if (_realAngle > 0f)
		{
			_realAngle -= num;
		}
		_angle = _realAngle;
	}

	public void set_index(int index)
	{
		if (itemList == null)
		{
			InitListData();
		}
		if (index > _maxNum)
		{
			index = _maxNum;
		}
		targetAngle = (0f - angleSpace) * (float)(index - 1);
		if (targetAngle < angleMin)
		{
			targetAngle = angleMin;
		}
		if (targetAngle > angleMax)
		{
			targetAngle = angleMax;
		}
		set_angle(targetAngle);
		_angle = targetAngle;
		haveStartEnterFrame = false;
	}

	public void set_showIndex(int index)
	{
		curShowIndex = index;
		if (itemList == null)
		{
			InitListData();
		}
		if (index > _maxNum)
		{
			index = _maxNum;
		}
		if (index < _showNum - 1)
		{
			index = 1;
		}
		else if (index == _showNum - 1)
		{
			index = 2;
		}
		else if (index > _showNum - 1 && index < _maxNum)
		{
			index = index - (_showNum - 1) + 2;
		}
		targetAngle = (0f - angleSpace) * (float)(index - 1);
		if (targetAngle < angleMin)
		{
			targetAngle = angleMin;
		}
		if (targetAngle > angleMax)
		{
			targetAngle = angleMax;
		}
		set_angle(targetAngle);
		_angle = targetAngle;
		haveStartEnterFrame = false;
		refresh_list();
	}

	public void refresh_list()
	{
		if (itemList == null)
		{
			InitListData();
		}
		int num = itemIndexList.Count;
		for (int i = 0; i < num; i++)
		{
			itemIndexList[i] = -999999999;
		}
		set_angle(_angle);
	}

	public void tweenToIndex(int index, bool moveslow = false)
	{
		if (index > _maxNum)
		{
			index = _maxNum;
		}
		if (connectBeginEnd)
		{
			resetCurAngle();
			float num = (0f - angleSpace) * (float)(index - maxNum - 1);
			float num2 = (0f - angleSpace) * (float)(index - 1);
			float num3 = (0f - angleSpace) * (float)(index + maxNum - 1);
			float num4 = Mathf.Abs(num - _realAngle);
			float num5 = Mathf.Abs(num2 - _realAngle);
			float num6 = Mathf.Abs(num3 - _realAngle);
			curIndex = (int)Mathf.Floor((0f - num2) / angleSpace + 1f);
			if (num4 <= num5 && num4 <= num6)
			{
				float time = num4 / 360f * tweenToIndexTime;
				tweenAngle(time, TweenValueType.Angle, num, Method.EASE_IN_OUT, updateAngle, null, nearComplete);
			}
			else if (num5 <= num4 && num5 <= num6)
			{
				float time2 = num5 / 360f * tweenToIndexTime;
				tweenAngle(time2, TweenValueType.Angle, num2, Method.EASE_IN_OUT, updateAngle, null, nearComplete);
			}
			else if (num6 <= num4 && num6 <= num5)
			{
				float time3 = num6 / 360f * tweenToIndexTime;
				tweenAngle(time3, TweenValueType.Angle, num3, Method.EASE_IN_OUT, updateAngle, null, nearComplete);
			}
		}
		else
		{
			targetAngle = (0f - angleSpace) * (float)(index - 1);
			if (targetAngle < angleMin)
			{
				targetAngle = angleMin;
			}
			if (targetAngle > angleMax)
			{
				targetAngle = angleMax;
			}
			curIndex = (int)Mathf.Floor((0f - targetAngle) / angleSpace + 1f);
			float time4 = Mathf.Abs(_angle - targetAngle) / 360f * tweenToIndexTime;
			if (moveslow)
			{
				tweenAngle(0.75f, TweenValueType.Angle, targetAngle, Method.EASE_OUT, updateAngle, null, nearComplete);
			}
			else
			{
				tweenAngle(time4, TweenValueType.Angle, targetAngle, Method.EASE_IN_OUT, updateAngle, null, nearComplete);
			}
		}
	}

	public void tweenToNear(int index, bool isBottom = false)
	{
		if (index > _maxNum)
		{
			index = _maxNum;
		}
		targetAngle = (0f - angleSpace) * (float)(index - 1);
		if (isBottom)
		{
			targetAngle = targetAngle + angleWindow - angleSpace;
		}
		if (targetAngle < angleMin)
		{
			targetAngle = angleMin;
		}
		if (targetAngle > angleMax)
		{
			targetAngle = angleMax;
		}
		tweenAngle(0.3f, TweenValueType.Angle, targetAngle, Method.EASE_IN_OUT, updateAngle, null, nearComplete);
	}

	public void fullDisplayItem(int index)
	{
		Debug.Log("fullDisplayItem : " + index);
		UISprite uISprite = null;
		for (int i = 0; i < itemIndexList.Count; i++)
		{
			if (itemIndexList[i] == index)
			{
				uISprite = itemList[i].GetComponent<UISprite>();
				break;
			}
		}
		if (!(uISprite != null))
		{
			return;
		}
		UISprite component = parent.GetComponent<UISprite>();
		if (!(component != null))
		{
			return;
		}
		if (listDirection == Direction.verticallyDown || listDirection == Direction.verticallyTop)
		{
			if ((float)(component.height / 2) < uISprite.transform.localPosition.y + (float)(uISprite.height / 2))
			{
				if (listDirection == Direction.verticallyDown)
				{
					tweenToNear(index);
				}
				else
				{
					tweenToNear(index, true);
				}
			}
			else if (uISprite.transform.localPosition.y - (float)(uISprite.height / 2) < (float)(-component.height / 2))
			{
				if (listDirection == Direction.verticallyDown)
				{
					tweenToNear(index, true);
				}
				else
				{
					tweenToNear(index);
				}
			}
		}
		else if ((float)(component.width / 2) < uISprite.transform.localPosition.x + (float)(uISprite.width / 2))
		{
			if (listDirection == Direction.horizontalRight)
			{
				tweenToNear(index);
			}
			else
			{
				tweenToNear(index, true);
			}
		}
		else if (uISprite.transform.localPosition.x - (float)(uISprite.width / 2) < (float)(-component.width / 2))
		{
			if (listDirection == Direction.horizontalRight)
			{
				tweenToNear(index, true);
			}
			else
			{
				tweenToNear(index);
			}
		}
	}

	private void Update()
	{
		if (needResize)
		{
			toResize();
			needResize = false;
		}
		if (haveStartEnterFrame)
		{
			tweenUpdate();
		}
	}

	private void tweenAngle(float time, TweenValueType tweenValueType, float toAngle, Method tweenMethod, UserCall updateF, UserCall completeF = null, UserCall nearCompleteF = null)
	{
		_totalTweenTime = time;
		_toAngle = toAngle;
		_startAngle = _angle;
		_tweenMethod = tweenMethod;
		_updateFunc = updateF;
		_completeFunc = completeF;
		_curTweenTime = 0f;
		_nearCompleteF = nearCompleteF;
		_tweenValueType = tweenValueType;
		if (!haveStartEnterFrame)
		{
			_ct = RealTime.time;
			haveStartEnterFrame = true;
		}
	}

	private void tweenUpdate()
	{
		float time = RealTime.time;
		float num = time - _ct;
		if (num == 0f)
		{
			num = 0.001f;
		}
		_ct = time;
		_curTweenTime += num;
		if (_totalTweenTime - _curTweenTime > 0f)
		{
			float a = _curTweenTime / _totalTweenTime;
			UserCallBack value;
			sTransitions.TryGetValue(_tweenMethod, out value);
			float num2 = 0f;
			num2 = value(a);
			if (num2 > _nearStopProgress && _nearCompleteF != null)
			{
				_nearCompleteF();
				_nearCompleteF2 = _nearCompleteF;
				_nearCompleteF = null;
			}
			if (_tweenValueType == TweenValueType.Angle)
			{
				_lastAngle = _angle;
				_angle = execute(_startAngle, _toAngle, num2);
				angleSpeed = _angle - _lastAngle;
				angleTimeSpeed = angleSpeed / num;
				if (!connectBeginEnd)
				{
					if (_angle > angleMax && !isCompleteMove)
					{
						_curTweenTime = 0f;
						_totalTweenTime = brakeTime;
						_toAngle = 0f;
						_startAngle = angleSpeed;
						_updateFunc = speedDownAngleChangeUpdate;
						_tweenValueType = TweenValueType.AngleSpeed;
						isCompleteMove = true;
						_tweenMethod = Method.LINEAR;
					}
					if (!isDynamicList && _angle < angleMin && !isCompleteMove)
					{
						_curTweenTime = 0f;
						_totalTweenTime = brakeTime;
						_toAngle = 0f;
						_startAngle = angleSpeed;
						_updateFunc = speedDownAngleChangeUpdate;
						_tweenValueType = TweenValueType.AngleSpeed;
						isCompleteMove = true;
						_tweenMethod = Method.LINEAR;
					}
					if (isDynamicList && _angle < angleMin2 && !isCompleteMove)
					{
						_curTweenTime = 0f;
						_totalTweenTime = brakeTime;
						_toAngle = 0f;
						_startAngle = angleSpeed;
						_updateFunc = speedDownAngleChangeUpdate;
						_tweenValueType = TweenValueType.AngleSpeed;
						isCompleteMove = true;
						_tweenMethod = Method.LINEAR;
					}
				}
			}
			else if (_tweenValueType == TweenValueType.AngleSpeed)
			{
				angleSpeed = execute(_startAngle, _toAngle, num2);
				angleTimeSpeed = angleSpeed / num;
			}
			if (_updateFunc != null)
			{
				_updateFunc();
			}
		}
		else if (_totalTweenTime - _curTweenTime <= 0f)
		{
			float a2 = 1f;
			haveStartEnterFrame = false;
			UserCallBack value2;
			sTransitions.TryGetValue(_tweenMethod, out value2);
			if (value2 == null)
			{
				value2 = linear;
			}
			float progress = value2(a2);
			if (_tweenValueType == TweenValueType.Angle)
			{
				_angle = execute(_startAngle, _toAngle, progress);
			}
			else if (_tweenValueType == TweenValueType.AngleSpeed)
			{
				angleSpeed = execute(_startAngle, _toAngle, progress);
				angleTimeSpeed = angleSpeed / num;
			}
			if (_updateFunc != null)
			{
				_updateFunc();
			}
			if (_nearCompleteF != null)
			{
				_nearCompleteF();
				_nearCompleteF = null;
			}
			if (_nearCompleteF2 != null)
			{
				_nearCompleteF2();
				_nearCompleteF2 = null;
			}
			if (_completeFunc != null)
			{
				_completeFunc();
			}
		}
	}

	private void speedDownAngleChangeUpdate()
	{
		_angle += angleSpeed;
		set_angle(_angle);
	}

	private float execute(float startVar, float endVar, float progress)
	{
		return startVar + progress * (endVar - startVar);
	}

	protected void InitTweenFunctions()
	{
		sTransitions.Add(Method.LINEAR, linear);
		sTransitions.Add(Method.EASE_IN, easeIn);
		sTransitions.Add(Method.EASE_OUT, easeOut);
		sTransitions.Add(Method.EASE_IN_OUT, easeInOut);
		sTransitions.Add(Method.EASE_OUT_IN, easeOutIn);
		sTransitions.Add(Method.EASE_IN_OUT_BACK, easeInOutBack);
		sTransitions.Add(Method.EASE_OUT_IN_BACK, easeOutInBack);
		sTransitions.Add(Method.EASE_IN_ELASTIC, easeInElastic);
		sTransitions.Add(Method.EASE_OUT_ELASTIC, easeOutElastic);
		sTransitions.Add(Method.EASE_IN_OUT_ELASTIC, easeInOutElastic);
		sTransitions.Add(Method.EASE_IN_BOUNCE, easeInBounce);
		sTransitions.Add(Method.EASE_OUT_BOUNCE, easeOutBounce);
		sTransitions.Add(Method.EASE_IN_OUT_BOUNCE, easeInOutBounce);
		sTransitions.Add(Method.EASE_OUT_IN_BOUNCE, easeOutInBounce);
		sTransitions.Add(Method.EASE_IN_TO_OUT_ELASTIC, easeInToOutElastic);
	}

	private float linear(float ratio)
	{
		return ratio;
	}

	private float easeIn(float ratio)
	{
		return ratio * ratio * ratio;
	}

	private float easeOut(float ratio)
	{
		float num = ratio - 1f;
		return num * num * num + 1f;
	}

	private float easeInOut(float ratio)
	{
		return easeCombined(easeIn, easeOut, ratio);
	}

	private float easeOutIn(float ratio)
	{
		return easeCombined(easeOut, easeIn, ratio);
	}

	private float easeInBack(float ratio)
	{
		float num = 1.70158f;
		return Mathf.Pow(ratio, 2f) * ((num + 1f) * ratio - num);
	}

	private float easeOutBack(float ratio)
	{
		float num = ratio - 1f;
		float num2 = 1.70158f;
		return Mathf.Pow(num, 2f) * ((num2 + 1f) * num + num2) + 1f;
	}

	private float easeInOutBack(float ratio)
	{
		return easeCombined(easeInBack, easeOutBack, ratio);
	}

	private float easeOutInBack(float ratio)
	{
		return easeCombined(easeOutBack, easeInBack, ratio);
	}

	private float easeInToOutElastic(float ratio)
	{
		return easeCombined(easeIn, easeOutElastic, ratio);
	}

	private float easeInElastic(float ratio)
	{
		if (ratio == 0f || ratio == 1f)
		{
			return ratio;
		}
		float num = 0.3f;
		float num2 = num / 4f;
		float num3 = ratio - 1f;
		return -1f * Mathf.Pow(2f, 10f * num3) * Mathf.Sin((num3 - num2) * ((float)Math.PI * 2f) / num);
	}

	private float easeOutElastic(float ratio)
	{
		if (ratio == 0f || ratio == 1f)
		{
			return ratio;
		}
		float num = 0.3f;
		float num2 = num / 4f;
		return Mathf.Pow(2f, -10f * ratio) * Mathf.Sin((ratio - num2) * ((float)Math.PI * 2f) / num) + 1f;
	}

	private float easeInOutElastic(float ratio)
	{
		return easeCombined(easeInElastic, easeOutElastic, ratio);
	}

	private float easeOutInElastic(float ratio)
	{
		return easeCombined(easeOutElastic, easeInElastic, ratio);
	}

	private float easeInBounce(float ratio)
	{
		return 1f - easeOutBounce(1f - ratio);
	}

	private float easeOutBounce(float ratio)
	{
		float num = 7.5625f;
		float num2 = 2.75f;
		if (ratio < 1f / num2)
		{
			return num * Mathf.Pow(ratio, 2f);
		}
		if (ratio < 2f / num2)
		{
			ratio -= 1.5f / num2;
			return num * Mathf.Pow(ratio, 2f) + 0.75f;
		}
		if ((double)ratio < 2.5 / (double)num2)
		{
			ratio -= 2.25f / num2;
			return num * Mathf.Pow(ratio, 2f) + 0.9375f;
		}
		ratio -= 2.625f / num2;
		return num * Mathf.Pow(ratio, 2f) + 63f / 64f;
	}

	private float easeInOutBounce(float ratio)
	{
		return easeCombined(easeInBounce, easeOutBounce, ratio);
	}

	private float easeOutInBounce(float ratio)
	{
		return easeCombined(easeOutBounce, easeInBounce, ratio);
	}

	private float easeCombined(UserCallBack startFunc, UserCallBack endFunc, float ratio)
	{
		if ((double)ratio < 0.5)
		{
			return 0.5f * startFunc(ratio * 2f);
		}
		return 0.5f * endFunc((ratio - 0.5f) * 2f) + 0.5f;
	}
}
