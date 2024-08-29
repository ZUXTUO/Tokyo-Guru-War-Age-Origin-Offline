using System.Collections.Generic;
using UnityEngine;

public class MiniMap : MonoBehaviour
{
	public UISprite MMFore;

	public UISprite MMBack;

	public UISprite MMMap;

	public UIPanel MMMask;

	public GameObject BtnZoomIn;

	public GameObject BtnZoomOut;

	public GameObject BtnGlobalMap;

	public GameObject BtnLock;

	public GameObject MMPlayer;

	public bool MMLockFlag;

	public GameObject MMTypeProto;

	public GameObject MMObjectProto;

	public Transform TypeContainer;

	public List<MiniMapType> MMTypes;

	public Transform ObjectContainer;

	public List<MiniMapObject> MMObjects;

	public Vector2 WinSize;

	public Vector2 SceneOrigin;

	public Vector2 SceneSize;

	public Vector2 MMOrigin;

	public Vector2 MMSizeOri;

	public float MMZoomRate;

	public Vector2 MMSize;

	public float MMZoomRateCur;

	public Vector2 MMCenter;

	public Vector2 MMRangeX;

	public Vector2 MMRangeY;

	public Vector2 ScaleS2M;

	public Vector2 ScaleM2S;

	public float MMRadius;

	public bool MMIsCircle = true;

	public bool MMRotate = true;

	public MiniMapMode Mode;

	public float StartTime;

	public Vector2 StartSize;

	public float ZoomInterval;

	public Vector2 StartPos;

	private void Awake()
	{
		MMFore = base.transform.Find("Win/Fore").GetComponent<UISprite>();
		MMBack = base.transform.Find("Win/Mask/Back").GetComponent<UISprite>();
		MMMap = base.transform.Find("Win/Mask/Map").GetComponent<UISprite>();
		MMMask = base.transform.Find("Win/Mask").GetComponent<UIPanel>();
		BtnZoomIn = base.transform.Find("Button/BtnZoomIn").gameObject;
		BtnZoomOut = base.transform.Find("Button/BtnZoomOut").gameObject;
		BtnGlobalMap = base.transform.Find("Button/BtnGlobalMap").gameObject;
		BtnLock = base.transform.Find("Button/BtnLock").gameObject;
		UIEventListener.Get(BtnZoomIn).onClick = OnBtnZoomInClick;
		UIEventListener.Get(BtnZoomOut).onClick = OnBtnZoomOutClick;
		UIEventListener.Get(BtnGlobalMap).onClick = OnBtnGlobalMapCLick;
		UIEventListener.Get(BtnLock).onClick = OnBtnLockClick;
		MMTypeProto = base.transform.Find("Proto/MiniMapType").gameObject;
		MMObjectProto = base.transform.Find("Proto/MiniMapObject").gameObject;
		MMObjects.Clear();
		MMTypes.Clear();
		TypeContainer = base.transform.Find("Types");
		for (int i = 0; i < TypeContainer.childCount; i++)
		{
			MiniMapType component = TypeContainer.GetChild(i).GetComponent<MiniMapType>();
			component.Init();
			MMTypes.Add(component);
		}
		ObjectContainer = base.transform.Find("Objects");
		for (int j = 0; j < ObjectContainer.childCount; j++)
		{
			MiniMapObject component2 = ObjectContainer.GetChild(j).GetComponent<MiniMapObject>();
			if (component2.Type.transform.name == "Player")
			{
				MMPlayer = component2.Target;
			}
			component2.Init();
			MMObjects.Add(component2);
		}
		CalMiniMapSize();
		CalMiniMapData();
		MMLockFlag = true;
		MMCenter = SceneOrigin;
		MMOrigin = Vector2.zero;
		UIEventListener.Get(MMFore.gameObject).onDragStart = OnMiniMapDragStart;
		UIEventListener.Get(MMFore.gameObject).onDrag = OnMiniMapDrag;
		UIEventListener.Get(MMFore.gameObject).onDragEnd = OnMiniMapDragEnd;
		SetWinSize(WinSize);
		SetSceneSize(SceneSize);
		SetMiniMapSize(MMSize);
	}

	public void Update()
	{
		if (Mode == MiniMapMode.Normal)
		{
			if (MMLockFlag)
			{
				if (MMPlayer == null)
				{
					return;
				}
				MMCenter = GetXZ(MMPlayer.transform.position);
			}
			UpdateMinimap();
		}
		if (Mode == MiniMapMode.ZoomIn)
		{
			MMZoomRateCur = Mathf.Lerp(MMZoomRate, MMZoomRate * 2f, (Time.time - StartTime) / ZoomInterval);
			CalMiniMapSize(MMSizeOri, MMZoomRateCur);
			CalMiniMapData();
			UpdateMinimap();
			if (MMZoomRateCur == MMZoomRate * 2f)
			{
				MMZoomRate = MMZoomRateCur;
				Mode = MiniMapMode.Normal;
			}
		}
		if (Mode == MiniMapMode.ZoomOut)
		{
			MMZoomRateCur = Mathf.Lerp(MMZoomRate, MMZoomRate / 2f, (Time.time - StartTime) / ZoomInterval);
			CalMiniMapSize(MMSizeOri, MMZoomRateCur);
			CalMiniMapData();
			UpdateMinimap();
			if (MMZoomRateCur == MMZoomRate / 2f)
			{
				MMZoomRate = MMZoomRateCur;
				Mode = MiniMapMode.Normal;
			}
		}
		if (Mode == MiniMapMode.GlobalMap)
		{
			MMZoomRateCur = Mathf.Lerp(MMZoomRate, 1f, (Time.time - StartTime) / ZoomInterval);
			CalMiniMapSize(MMSizeOri, MMZoomRateCur);
			CalMiniMapData();
			UpdateMinimap();
			if (MMZoomRateCur == 1f)
			{
				MMZoomRate = MMZoomRateCur;
				Mode = MiniMapMode.Normal;
			}
		}
		if (Mode == MiniMapMode.Lock)
		{
			MMCenter = Vector2.Lerp(MMCenter, GetXZ(MMPlayer.transform.position), (Time.time - StartTime) / ZoomInterval);
			UpdateMinimap();
			if (Time.time - StartTime >= ZoomInterval)
			{
				MMCenter = GetXZ(MMPlayer.transform.position);
				Mode = MiniMapMode.Normal;
			}
		}
	}

	public void UpdateMinimap()
	{
		UpdateMap();
		UpdateIcon();
	}

	public void UpdateMap()
	{
		MMOrigin = Vector2.Scale(MMCenter - SceneOrigin, ScaleS2M);
		MMOrigin.x = Mathf.Clamp(MMOrigin.x, MMRangeX.x, MMRangeX.y);
		MMOrigin.y = Mathf.Clamp(MMOrigin.y, MMRangeY.x, MMRangeY.y);
		MMMap.transform.localPosition = new Vector3(0f - MMOrigin.x, 0f - MMOrigin.y, 0f);
	}

	public void UpdateIcon()
	{
		Vector2 vector2 = default(Vector2);
		Vector2 vector3 = default(Vector2);
		for (int i = 0; i < MMObjects.Count; i++)
		{
			MiniMapObject miniMapObject = MMObjects[i];
			Vector2 vector = Vector2.Scale(GetXZ(miniMapObject.Target.transform.position) - SceneOrigin, ScaleS2M) - MMOrigin;
			if (MMIsCircle)
			{
				if (Vector2.Dot(vector, vector) <= MMRadius * MMRadius)
				{
					miniMapObject.Inner.gameObject.SetActive(true);
					miniMapObject.Outer.gameObject.SetActive(false);
					miniMapObject.Inner.localPosition = vector;
					if (MMRotate)
					{
						miniMapObject.Inner.eulerAngles = new Vector3(0f, 0f, 0f - miniMapObject.Target.transform.eulerAngles.y);
					}
					continue;
				}
				miniMapObject.Inner.gameObject.SetActive(false);
				miniMapObject.Outer.gameObject.SetActive(true);
				vector2.x = vector.x * MMRadius / vector.magnitude;
				vector2.y = vector.y * MMRadius / vector.magnitude;
				miniMapObject.Outer.localPosition = vector2;
				if (MMRotate)
				{
					miniMapObject.Outer.eulerAngles = new Vector3(0f, 0f, 0f - miniMapObject.Target.transform.eulerAngles.y);
				}
				continue;
			}
			bool flag = true;
			if (vector.x > 0f && vector.x > MMMask.baseClipRegion.z / 2f && Mathf.Abs(vector.x) > Mathf.Abs(vector.y))
			{
				vector3.x = MMMask.baseClipRegion.z / 2f;
				float y = vector.y * vector3.x / vector.x;
				vector3.y = y;
				flag = false;
			}
			else if (vector.y > 0f && vector.y > MMMask.baseClipRegion.w / 2f && Mathf.Abs(vector.y) > Mathf.Abs(vector.x))
			{
				vector3.y = MMMask.baseClipRegion.w / 2f;
				float x = vector.x * vector3.y / vector.y;
				vector3.x = x;
				flag = false;
			}
			else if (vector.x < 0f && vector.x < (0f - MMMask.baseClipRegion.z) / 2f && Mathf.Abs(vector.x) > Mathf.Abs(vector.y))
			{
				vector3.x = (0f - MMMask.baseClipRegion.z) / 2f;
				vector3.y = vector.y * vector3.x / vector.x;
				flag = false;
			}
			else if (vector.y < 0f && vector.y < (0f - MMMask.baseClipRegion.w) / 2f && Mathf.Abs(vector.y) > Mathf.Abs(vector.x))
			{
				vector3.y = (0f - MMMask.baseClipRegion.w) / 2f;
				vector3.x = vector.x * vector3.y / vector.y;
				flag = false;
			}
			else
			{
				vector3 = vector;
				flag = true;
			}
			if (flag)
			{
				miniMapObject.Inner.gameObject.SetActive(true);
				miniMapObject.Outer.gameObject.SetActive(false);
				miniMapObject.Inner.localPosition = vector3;
				if (MMRotate)
				{
					miniMapObject.Inner.eulerAngles = new Vector3(0f, 0f, 0f - miniMapObject.Target.transform.eulerAngles.y);
				}
			}
			else
			{
				miniMapObject.Inner.gameObject.SetActive(false);
				miniMapObject.Outer.gameObject.SetActive(true);
				miniMapObject.Outer.localPosition = vector3;
				if (MMRotate)
				{
					miniMapObject.Outer.eulerAngles = new Vector3(0f, 0f, 0f - miniMapObject.Target.transform.eulerAngles.y);
				}
			}
		}
	}

	public void OnBtnZoomInClick(GameObject vGO)
	{
		if (Mode == MiniMapMode.Normal && !(MMZoomRate >= 8f))
		{
			StartTime = Time.time;
			Mode = MiniMapMode.ZoomIn;
		}
	}

	public void OnBtnZoomOutClick(GameObject vGO)
	{
		if (Mode == MiniMapMode.Normal && !(MMSizeOri.x * MMZoomRate / 2f < WinSize.x) && !(MMSizeOri.y * MMZoomRate / 2f < WinSize.y) && !((double)MMZoomRate <= 0.125))
		{
			StartTime = Time.time;
			Mode = MiniMapMode.ZoomOut;
		}
	}

	public void OnBtnGlobalMapCLick(GameObject vGO)
	{
		if (Mode == MiniMapMode.Normal && MMZoomRate != 1f)
		{
			StartTime = Time.time;
			Mode = MiniMapMode.GlobalMap;
		}
	}

	public void OnBtnLockClick(GameObject vGO)
	{
		if (Mode == MiniMapMode.Normal)
		{
			MMLockFlag = !MMLockFlag;
			if (MMLockFlag)
			{
				StartTime = Time.time;
				Mode = MiniMapMode.Lock;
			}
		}
	}

	public void OnMiniMapDragStart(GameObject vGO)
	{
		if (Mode == MiniMapMode.Normal && !MMLockFlag)
		{
			Mode = MiniMapMode.Drag;
			StartPos = GetXY(Input.mousePosition - MMMap.transform.localPosition);
		}
	}

	public void OnMiniMapDrag(GameObject vGO, Vector2 vPos)
	{
		if (!MMLockFlag)
		{
			MMCenter = Vector2.Scale(StartPos - GetXY(Input.mousePosition), ScaleM2S) + SceneOrigin;
			UpdateMap();
			UpdateIcon();
		}
	}

	public void OnMiniMapDragEnd(GameObject vGO)
	{
		if (!MMLockFlag)
		{
			Mode = MiniMapMode.Normal;
		}
	}

	public void SetMinimapParams(Vector2 vWinSize, Vector2 vSceneOrigin, Vector2 vSceneSize, Vector2 vMMSizeOri, float vMMZoomRate)
	{
		SetWinSize(vWinSize);
		SetSceneOrigin(vSceneOrigin);
		SetSceneSize(vSceneSize);
		SetMiniMapSize(vMMSizeOri);
		SetMiniMapZoomRate(vMMZoomRate);
	}

	public void SetWinSize(Vector2 vWinSize)
	{
		if (vWinSize.x <= 0f)
		{
			Debug.LogError("Minimap SetWinSize : WinWidth <= 0");
			return;
		}
		if (vWinSize.y <= 0f)
		{
			Debug.LogError("Minimap SetWinSize : WinHeight <= 0");
			return;
		}
		WinSize = vWinSize;
		MMFore.width = (int)WinSize.x;
		MMFore.height = (int)WinSize.y;
		MMBack.width = (int)WinSize.x;
		MMBack.height = (int)WinSize.y;
		MMMask.baseClipRegion = new Vector4(0f, 0f, WinSize.x, WinSize.y);
	}

	public void SetSceneOrigin(Vector2 vSceneOrigin)
	{
		SceneOrigin = vSceneOrigin;
	}

	public void SetSceneSize(Vector2 vSceneSize)
	{
		if (vSceneSize.x <= 0f)
		{
			Debug.LogError("Minimap SetSceneSize:SceneWidth <= 0");
			return;
		}
		if (vSceneSize.y <= 0f)
		{
			Debug.LogError("Minimap SetSceneSize:SceneHeight <= 0");
			return;
		}
		SceneSize = vSceneSize;
		CalScale();
	}

	public void SetMiniMapSize(Vector2 vMMSizeOri)
	{
		MMSizeOri = vMMSizeOri;
		if (MMSizeOri.x <= 0f)
		{
			MMSizeOri.x = MMMap.mainTexture.width;
		}
		if (MMSizeOri.y <= 0f)
		{
			MMSizeOri.y = MMMap.mainTexture.height;
		}
		CalMiniMapSize();
		CalMiniMapData();
	}

	public void SetMiniMapZoomRate(float vMMZoomRate)
	{
		if (vMMZoomRate <= 0f)
		{
			Debug.Log("MiniMap SetMiniMapZoomRate : MMZoomRate <= 0");
			return;
		}
		MMZoomRate = vMMZoomRate;
		CalMiniMapData();
		CalMiniMapData();
	}

	private void CalMiniMapSize()
	{
		MMSize = MMSizeOri * MMZoomRate;
	}

	private void CalMiniMapSize(Vector2 vMMSizeOri, float vMMZoomRate)
	{
		MMSize = vMMSizeOri * vMMZoomRate;
	}

	public void CalMiniMapData()
	{
		MMMap.width = (int)MMSize.x;
		MMMap.height = (int)MMSize.y;
		MMRangeX = new Vector2((0f - (MMSize.x - WinSize.x)) / 2f, (MMSize.x - WinSize.x) / 2f);
		MMRangeY = new Vector2((0f - (MMSize.y - WinSize.y)) / 2f, (MMSize.y - WinSize.y) / 2f);
		CalScale();
	}

	public void CalScale()
	{
		ScaleS2M = new Vector2(MMSize.x / SceneSize.x, MMSize.y / SceneSize.y);
		ScaleM2S = new Vector2(SceneSize.x / MMSize.x, SceneSize.y / MMSize.y);
	}

	public void SetAtlas(UIAtlas vAtlas)
	{
		if (vAtlas == null)
		{
			Debug.Log("MiniMap SetAtlas : Atlas Null.");
			return;
		}
		MMFore.atlas = vAtlas;
		MMBack.atlas = vAtlas;
		MMMap.atlas = vAtlas;
	}

	public void SetFore(string vFore)
	{
		if (vFore == string.Empty)
		{
			MMFore.spriteName = "Fore";
		}
		else
		{
			MMFore.spriteName = vFore;
		}
	}

	public void SetBack(string vBack)
	{
		if (vBack == string.Empty)
		{
			MMBack.spriteName = "Back";
		}
		else
		{
			MMBack.spriteName = vBack;
		}
	}

	public void SetMap(string vMap)
	{
		if (vMap == string.Empty)
		{
			MMMap.spriteName = "Map";
		}
		else
		{
			MMMap.spriteName = vMap;
		}
	}

	public void SetMask(Texture2D vMask)
	{
		if (vMask == null)
		{
			Debug.LogError("Minimap SetMask:Mask Null.");
		}
		else
		{
			MMMask.clipTexture = vMask;
		}
	}

	public void SetRadius(float vRadius)
	{
		MMRadius = vRadius;
		foreach (MiniMapObject mMObject in MMObjects)
		{
			mMObject.OuterIcon.transform.localPosition = new Vector3(0f, vRadius, 0f);
		}
	}

	public void SetMiniMapPlyaer(MiniMapObject vMMObject)
	{
		MMPlayer = vMMObject.Target;
	}

	public void SetMiniMapPlyaer(int vIndex)
	{
		MMPlayer = MMObjects[vIndex].gameObject;
	}

	public void ClearType()
	{
		for (int i = MMTypes.Count; i <= 3; i++)
		{
			DelObject(MMTypes[i]);
			MMTypes.RemoveAt(i);
		}
	}

	public MiniMapType AddType(string vTypeName)
	{
		GameObject gameObject = Object.Instantiate(MMTypeProto);
		MiniMapType component = gameObject.GetComponent<MiniMapType>();
		component.transform.name = vTypeName;
		component.transform.parent = TypeContainer;
		component.transform.localPosition = Vector3.zero;
		component.transform.localEulerAngles = Vector3.zero;
		component.transform.localScale = Vector3.one;
		component.Init();
		MMTypes.Add(component);
		return component;
	}

	public MiniMapType GetType(string vTypeName)
	{
		for (int i = 0; i < MMTypes.Count; i++)
		{
			if (MMTypes[i].transform.name == vTypeName)
			{
				return MMTypes[i];
			}
		}
		return null;
	}

	public void DelType(int vIndex)
	{
		DelObject(MMTypes[vIndex]);
		MMTypes.RemoveAt(vIndex);
	}

	public void DelType(MiniMapType vMMType)
	{
		DelObject(vMMType);
		MMTypes.Remove(vMMType);
	}

	public void ClearObject()
	{
		MMObjects.Clear();
	}

	public MiniMapObject AddObject(string vObjectName, out GameObject go)
	{
		MiniMapObject component = (go = Object.Instantiate(MMObjectProto)).GetComponent<MiniMapObject>();
		component.transform.name = vObjectName;
		component.transform.parent = ObjectContainer;
		component.transform.localPosition = Vector3.zero;
		component.transform.localEulerAngles = Vector3.zero;
		component.transform.localScale = Vector3.one;
		component.Init();
		MMObjects.Add(component);
		return component;
	}

	public void DelObject(int vIndex)
	{
		if (vIndex < MMObjects.Count)
		{
			MiniMapObject miniMapObject = MMObjects[vIndex];
			MMObjects.RemoveAt(vIndex);
			Object.DestroyImmediate(miniMapObject.gameObject);
		}
	}

	public void DelObject(MiniMapObject vMMObject)
	{
		MMObjects.Remove(vMMObject);
		Object.DestroyImmediate(vMMObject.gameObject);
	}

	public void DelObject(MiniMapType vType)
	{
		for (int num = MMObjects.Count - 1; num >= 0; num--)
		{
			if (MMObjects[num].Type == vType)
			{
				DelObject(num);
			}
		}
	}

	public void SetObject(MiniMapObject vMMObject, GameObject target, string typeName)
	{
		MiniMapType type = GetType(typeName);
		vMMObject.SetObject(type, target);
	}

	public Vector2 GetXY(Vector3 vSource)
	{
		return new Vector2(vSource.x, vSource.y);
	}

	public Vector2 GetXZ(Vector3 vSource)
	{
		return new Vector2(vSource.x, vSource.z);
	}
}
