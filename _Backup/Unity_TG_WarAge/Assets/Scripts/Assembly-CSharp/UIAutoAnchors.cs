using UnityEngine;

public class UIAutoAnchors : MonoBehaviour
{
	public UIPosAlignment posAligent;

	private int mParam;

	public int width
	{
		get
		{
			return Mathf.FloorToInt(NGUIMath.CalculateRelativeWidgetBounds(base.transform.parent, base.transform).size.x);
		}
	}

	public int height
	{
		get
		{
			return Mathf.FloorToInt(NGUIMath.CalculateRelativeWidgetBounds(base.transform.parent, base.transform).size.y);
		}
	}

	public Vector3 localPosition
	{
		get
		{
			return new Vector3(base.transform.localPosition.x, base.transform.localPosition.y, base.transform.localPosition.z);
		}
		set
		{
			base.transform.localPosition = value;
		}
	}

	public Vector3 topPosition
	{
		get
		{
			Bounds bounds = NGUIMath.CalculateRelativeWidgetBounds(base.transform.parent, base.transform);
			return new Vector3(base.transform.localPosition.x, bounds.max.y, base.transform.localPosition.z);
		}
		set
		{
			Vector3 vector = base.transform.localPosition;
			Bounds bounds = NGUIMath.CalculateRelativeWidgetBounds(base.transform.parent, base.transform);
			vector.y = vector.y - bounds.max.y + value.y;
			base.transform.localPosition = vector;
		}
	}

	public Vector3 bottomPosition
	{
		get
		{
			Bounds bounds = NGUIMath.CalculateRelativeWidgetBounds(base.transform.parent, base.transform);
			return new Vector3(base.transform.localPosition.x, bounds.min.y, base.transform.localPosition.z);
		}
		set
		{
			Vector3 vector = base.transform.localPosition;
			Bounds bounds = NGUIMath.CalculateRelativeWidgetBounds(base.transform.parent, base.transform);
			vector.y = vector.y - bounds.min.y + value.y;
			base.transform.localPosition = vector;
		}
	}

	public int Param
	{
		get
		{
			return mParam;
		}
		set
		{
			mParam = value;
		}
	}

	public void PosAligent()
	{
		if (posAligent != null)
		{
			posAligent.PosUpdate();
		}
	}
}
