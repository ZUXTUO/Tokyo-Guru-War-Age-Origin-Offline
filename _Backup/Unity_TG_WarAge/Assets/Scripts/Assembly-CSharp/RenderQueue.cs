using System.Collections.Generic;
using UnityEngine;

internal class RenderQueue : MonoBehaviour
{
	private List<Material> effect_materials;

	public int effect_count;

	public int base_renderqueue = 2999;

	public GameObject target_spirite;

	public int renderQueue_offset;

	public int final_render_queue;

	public string sortLayerName = "Default";

	public bool excute_once;

	private UISprite spite;

	private UITexture texture;

	public void Start()
	{
		if (target_spirite == null)
		{
			base.enabled = false;
			return;
		}
		spite = target_spirite.GetComponent<UISprite>();
		if (spite != null)
		{
			if (spite.drawCall != null)
			{
				base_renderqueue = spite.drawCall.finalRenderQueue;
			}
		}
		else
		{
			texture = target_spirite.GetComponent<UITexture>();
			if (texture != null)
			{
				base_renderqueue = texture.shader.renderQueue;
			}
		}
		Sort();
	}

	public void LateUpdate()
	{
		int num = 0;
		if (!excute_once)
		{
			if (spite != null)
			{
				if (spite.drawCall != null)
				{
					num = spite.drawCall.finalRenderQueue;
				}
			}
			else if (texture != null)
			{
				num = texture.shader.renderQueue;
			}
			if (num != base_renderqueue)
			{
				base_renderqueue = num;
			}
			Sort();
		}
		else if (excute_once)
		{
			base.enabled = false;
		}
	}

	public void Sort()
	{
		if (effect_materials == null)
		{
			effect_materials = new List<Material>();
		}
		int num = effect_materials.Count;
		if (num == 0 || num != effect_count)
		{
			Renderer[] componentsInChildren = base.gameObject.transform.GetComponentsInChildren<Renderer>();
			for (int i = 0; i < componentsInChildren.Length; i++)
			{
				componentsInChildren[i].sortingLayerName = sortLayerName;
				effect_materials.AddRange(componentsInChildren[i].materials);
			}
			num = (effect_count = effect_materials.Count);
		}
		if (num <= 0 || base_renderqueue == 0)
		{
			return;
		}
		final_render_queue = base_renderqueue + renderQueue_offset;
		for (int j = 0; j < num; j++)
		{
			Material material = effect_materials[j];
			if (material.renderQueue != final_render_queue)
			{
				material.renderQueue = final_render_queue;
			}
		}
	}
}
