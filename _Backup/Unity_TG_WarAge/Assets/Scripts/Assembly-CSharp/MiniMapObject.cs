using UnityEngine;

public class MiniMapObject : MonoBehaviour
{
	public Transform Inner;

	public Transform Outer;

	public UISprite InnerIcon;

	public UISprite OuterIcon;

	public MiniMapType Type;

	public GameObject Target;

	public UIAtlas InnerAtlas;

	public string InnerIconName;

	public Vector2 InnerSize;

	public Color InnerColor;

	public UIAtlas OuterAtlas;

	public string OuterIconName;

	public Vector2 OuterSize;

	public Color OuterColor;

	public void Start()
	{
		Init();
	}

	public void Init()
	{
		Inner = base.transform.Find("Inner");
		Outer = base.transform.Find("Outer");
		InnerIcon = base.transform.Find("Inner/InnerIcon").GetComponent<UISprite>();
		OuterIcon = base.transform.Find("Outer/OuterIcon").GetComponent<UISprite>();
		SetInner(InnerAtlas, InnerIconName, InnerColor, InnerSize);
		SetOuter(OuterAtlas, OuterIconName, OuterColor, OuterSize);
	}

	public void SetType(MiniMapType vType)
	{
		Type = vType;
	}

	public void SetObject(GameObject vTarget)
	{
		Target = vTarget;
		SetInner(Type.InnerAtlas, Type.InnerIconName, Type.InnerColor, Type.InnerSize);
		SetOuter(Type.OuterAtlas, Type.OuterIconName, Type.OuterColor, Type.OuterSize);
	}

	public void SetObject(MiniMapType vType, GameObject vTarget)
	{
		Type = vType;
		Target = vTarget;
		SetInner(Type.InnerAtlas, Type.InnerIconName, Type.InnerColor, Type.InnerSize);
		SetOuter(Type.OuterAtlas, Type.OuterIconName, Type.OuterColor, Type.OuterSize);
	}

	public void SetObject(MiniMapType vType, GameObject vTarget, UIAtlas vInnerAtlas, string vInnerIconName, Color vInnerColor, Vector2 vInnerSize, UIAtlas vOuterAtlas, string vOuterIconName, Color vOuterColor, Vector2 vOuterSize)
	{
		Type = vType;
		Target = vTarget;
		SetInner(vInnerAtlas, vInnerIconName, vInnerColor, vInnerSize);
		SetOuter(vOuterAtlas, vOuterIconName, vOuterColor, vOuterSize);
	}

	public void SetObject(MiniMapType vType, GameObject vTarget, UIAtlas vInnerAtlas, string vInnerIconName, Color vInnerColor, UIAtlas vOuterAtlas, string vOuterIconName, Color vOuterColor)
	{
		Type = vType;
		Target = vTarget;
		SetInner(vInnerAtlas, vInnerIconName, vInnerColor, Vector2.zero);
		SetOuter(vOuterAtlas, vOuterIconName, vOuterColor, Vector2.zero);
	}

	public void SetObject(MiniMapType vType, GameObject vTarget, UIAtlas vInnerAtlas, string vInnerIconName, UIAtlas vOuterAtlas, string vOuterIconName)
	{
		Type = vType;
		Target = vTarget;
		SetInner(vInnerAtlas, vInnerIconName, new Color(1f, 1f, 1f, 1f), Vector2.zero);
		SetOuter(vOuterAtlas, vOuterIconName, new Color(1f, 1f, 1f, 1f), Vector2.zero);
	}

	public void SetInner(UIAtlas vInnerAtlas, string vInnerIconName, Color vInnerColor, Vector2 vInnerSize)
	{
		SetInnerAtlas(vInnerAtlas);
		SetInnerIcon(vInnerIconName);
		SetInnerColor(vInnerColor);
		SetInnerSize(vInnerSize);
	}

	public void SetOuter(UIAtlas vOuterAtlas, string vOuterIconName, Color vOuterColor, Vector2 vOuterSize)
	{
		SetOuterAtlas(vOuterAtlas);
		SetOuterIcon(vOuterIconName);
		SetOuterColor(vOuterColor);
		SetOuterSize(vOuterSize);
	}

	public void SetInnerAtlas(UIAtlas vInnerAtlas)
	{
		if (vInnerAtlas == null)
		{
			Debug.Log("MiniMapObject SetInnerAtlas : Atlas Null.");
		}
		else
		{
			InnerAtlas = vInnerAtlas;
		}
	}

	public void SetOuterAtlas(UIAtlas vOuterAtlas)
	{
		if (vOuterAtlas == null)
		{
			Debug.Log("MiniMapObject SetOuterAtlas : Atlas Null.");
		}
		else
		{
			OuterAtlas = vOuterAtlas;
		}
	}

	public void SetInnerIcon(string vIconName)
	{
		InnerIconName = vIconName;
		if (InnerIconName == string.Empty)
		{
			if (Type == null)
			{
				Debug.Log("MiniMapObject SetInnerIcon : Property Type Null.");
				return;
			}
			if (Type.InnerIconName == string.Empty)
			{
				InnerIconName = "Icon_" + Type.transform.name + "_Inner";
			}
			else
			{
				InnerIconName = Type.InnerIconName;
			}
		}
		InnerIcon.spriteName = InnerIconName;
	}

	public void SetOuterIcon(string vIconName)
	{
		OuterIconName = vIconName;
		if (OuterIconName == string.Empty)
		{
			if (Type == null)
			{
				Debug.Log("MiniMapObject SetOuterIcon : Property Type Null.");
				return;
			}
			if (Type.OuterIconName == string.Empty)
			{
				OuterIconName = "Icon_" + Type.transform.name + "_Outer";
			}
			else
			{
				OuterIconName = Type.OuterIconName;
			}
		}
		OuterIcon.spriteName = OuterIconName;
	}

	public void SetInnerSize(Vector2 vInnerSize)
	{
		InnerSize = vInnerSize;
		if (InnerSize.x <= 0f || InnerSize.y <= 0f)
		{
			if (Type == null)
			{
				Debug.Log("MiniMap SetInnerSize: Type Null");
			}
			else if (Type.InnerSize.x <= 0f || Type.InnerSize.y <= 0f)
			{
				InnerSize.x = 0f;
				InnerSize.y = 0f;
				InnerIcon.MakePixelPerfect();
			}
			else
			{
				InnerSize = Type.InnerSize;
				InnerIcon.width = (int)InnerSize.x;
				InnerIcon.height = (int)InnerSize.y;
			}
		}
		else
		{
			InnerIcon.width = (int)InnerSize.x;
			InnerIcon.height = (int)InnerSize.y;
		}
	}

	public void SetOuterSize(Vector2 vOuterSize)
	{
		OuterSize = vOuterSize;
		if (OuterSize.x <= 0f || OuterSize.y <= 0f)
		{
			if (Type == null)
			{
				Debug.Log("MiniMap SetOuterSize: Type Null");
			}
			else if (Type.OuterSize.x <= 0f || Type.OuterSize.y <= 0f)
			{
				OuterSize.x = 0f;
				OuterSize.y = 0f;
				OuterIcon.MakePixelPerfect();
			}
			else
			{
				OuterSize = Type.OuterSize;
				OuterIcon.width = (int)OuterSize.x;
				OuterIcon.height = (int)OuterSize.y;
			}
		}
		else
		{
			OuterIcon.width = (int)OuterSize.x;
			OuterIcon.height = (int)OuterSize.y;
		}
	}

	public void SetInnerColor(Color vInnerColor)
	{
		InnerColor = vInnerColor;
		if (InnerColor == new Color(0f, 0f, 0f, 0f))
		{
			if (Type == null)
			{
				Debug.Log("MiniMap SetInnerColor: Type Null");
				return;
			}
			InnerColor = Type.InnerColor;
		}
		InnerColor.a = 1f;
		InnerIcon.color = InnerColor;
	}

	public void SetOuterColor(Color vOuterColor)
	{
		OuterColor = vOuterColor;
		if (OuterColor == new Color(0f, 0f, 0f, 0f))
		{
			if (Type == null)
			{
				Debug.Log("MiniMap SetOuterColor: Type Null");
				return;
			}
			OuterColor = Type.OuterColor;
		}
		OuterColor.a = 1f;
		OuterIcon.color = OuterColor;
	}

	public void SetRadius(float vRadius)
	{
		OuterIcon.transform.localPosition = new Vector3(0f, vRadius, 0f);
	}
}
