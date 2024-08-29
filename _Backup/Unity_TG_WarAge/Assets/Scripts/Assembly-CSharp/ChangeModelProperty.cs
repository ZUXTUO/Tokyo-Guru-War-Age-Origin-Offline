using UnityEngine;

public class ChangeModelProperty : MonoBehaviour
{
	public SceneChangeModelProperty.PropertyType currentType;

	public bool changeType;

	private int lastChildCount;

	private void OnEnable()
	{
		SceneChangeModelProperty[] componentsInChildren = GetComponentsInChildren<SceneChangeModelProperty>();
		for (int i = 0; i < componentsInChildren.Length; i++)
		{
			if (componentsInChildren[i] != null)
			{
				componentsInChildren[i].canChangeProperty = true;
				componentsInChildren[i].type = currentType;
				componentsInChildren[i].ApplyProperty();
			}
		}
	}

	private void Update()
	{
		if (lastChildCount != base.transform.childCount)
		{
			lastChildCount = base.transform.childCount;
			SetType(currentType);
		}
		if (changeType)
		{
			changeType = false;
			SetType(currentType);
		}
	}

	public void SetType(SceneChangeModelProperty.PropertyType type)
	{
		currentType = type;
		SceneChangeModelProperty[] componentsInChildren = GetComponentsInChildren<SceneChangeModelProperty>();
		for (int i = 0; i < componentsInChildren.Length; i++)
		{
			if (componentsInChildren[i] != null)
			{
				componentsInChildren[i].canChangeProperty = true;
				componentsInChildren[i].type = currentType;
				componentsInChildren[i].ApplyProperty();
			}
		}
	}
}
