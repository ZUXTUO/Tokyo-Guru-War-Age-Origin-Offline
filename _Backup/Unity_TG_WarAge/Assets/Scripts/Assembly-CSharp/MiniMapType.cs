using UnityEngine;

public class MiniMapType : MonoBehaviour
{
	public UIAtlas InnerAtlas;

	public string InnerIconName;

	public Vector2 InnerSize;

	public Color InnerColor;

	public UIAtlas OuterAtlas;

	public string OuterIconName;

	public Vector2 OuterSize;

	public Color OuterColor;

	public void Init()
	{
		SetInner(InnerAtlas, InnerIconName, InnerColor, InnerSize);
		SetOuter(OuterAtlas, OuterIconName, OuterColor, OuterSize);
	}

	public void SetType(UIAtlas vInnerAtlas, string vInnerIconName, Color vInnerColor, Vector2 vInnerSize, UIAtlas vOuterAtlas, string vOuterIconName, Color vOuterColor, Vector2 vOuterSize)
	{
		SetInner(vInnerAtlas, vInnerIconName, vInnerColor, vInnerSize);
		SetOuter(vOuterAtlas, vOuterIconName, vOuterColor, vOuterSize);
	}

	public void SetType(UIAtlas vInnerAtlas, string vInnerIconName, Color vInnerColor, UIAtlas vOuterAtlas, string vOuterIconName, Color vOuterColor)
	{
		SetInner(vInnerAtlas, vInnerIconName, vInnerColor, Vector2.zero);
		SetOuter(vOuterAtlas, vOuterIconName, vOuterColor, Vector2.zero);
	}

	public void SetType(UIAtlas vInnerAtlas, string vInnerIconName, UIAtlas vOuterAtlas, string vOuterIconName)
	{
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
			Debug.Log("MiniMapType SetInnerAtlas : Atlas Null.");
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
			Debug.Log("MiniMapType SetOuterAtlas : Atlas Null.");
		}
		else
		{
			OuterAtlas = vOuterAtlas;
		}
	}

	public void SetInnerIcon(string vInnerIconName)
	{
		InnerIconName = vInnerIconName;
		if (InnerIconName == string.Empty)
		{
			InnerIconName = "Icon_" + base.transform.name + "_Inner";
		}
		InnerIconName = vInnerIconName;
	}

	public void SetOuterIcon(string vOuterIconName)
	{
		OuterIconName = vOuterIconName;
		if (OuterIconName == string.Empty)
		{
			OuterIconName = "Icon_" + base.transform.name + "_Outer";
		}
		OuterIconName = vOuterIconName;
	}

	public void SetInnerSize(Vector2 vInnerSize)
	{
		InnerSize = vInnerSize;
		if (InnerSize.x <= 0f || InnerSize.y <= 0f)
		{
			InnerSize = Vector2.zero;
		}
		else
		{
			InnerSize = vInnerSize;
		}
	}

	public void SetOuterSize(Vector2 vOuterSize)
	{
		OuterSize = vOuterSize;
		if (OuterSize.x <= 0f || OuterSize.y <= 0f)
		{
			OuterSize = Vector2.zero;
		}
		else
		{
			OuterSize = vOuterSize;
		}
	}

	public void SetInnerColor(Color vInnerColor)
	{
		InnerColor = vInnerColor;
	}

	public void SetOuterColor(Color vOuterColor)
	{
		OuterColor = vOuterColor;
	}
}
