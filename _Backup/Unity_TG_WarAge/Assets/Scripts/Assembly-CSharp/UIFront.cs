using UnityEngine;

[AddComponentMenu("NGUI/Interaction/Front")]
public class UIFront : MonoBehaviour
{
	public UIWidget widgetInFrontOf;

	private void Awake()
	{
	}

	private void LateUpdate()
	{
		if (!(widgetInFrontOf != null) || !(widgetInFrontOf.drawCall != null))
		{
			return;
		}
		int renderQueue = widgetInFrontOf.drawCall.renderQueue + 1;
		Renderer[] componentsInChildren = GetComponentsInChildren<Renderer>();
		for (int i = 0; i < componentsInChildren.Length; i++)
		{
			Material[] materials = componentsInChildren[i].materials;
			foreach (Material material in materials)
			{
				material.renderQueue = renderQueue;
			}
		}
	}
}
