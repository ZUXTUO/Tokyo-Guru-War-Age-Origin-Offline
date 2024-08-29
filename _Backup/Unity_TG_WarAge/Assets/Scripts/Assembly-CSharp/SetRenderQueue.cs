using UnityEngine;

[ExecuteInEditMode]
public class SetRenderQueue : MonoBehaviour
{
	public int mRendererQueue;

	private void Start()
	{
		Renderer[] componentsInChildren = GetComponentsInChildren<Renderer>();
		if (componentsInChildren == null || componentsInChildren.Length <= 0)
		{
			return;
		}
		foreach (Renderer renderer in componentsInChildren)
		{
			if (!(renderer != null) || renderer.sharedMaterials == null || renderer.sharedMaterials.Length <= 0)
			{
				continue;
			}
			for (int j = 0; j < renderer.sharedMaterials.Length; j++)
			{
				Material material = renderer.sharedMaterials[j];
				if (null != material)
				{
					material.renderQueue = material.shader.renderQueue + mRendererQueue;
				}
			}
		}
	}
}
