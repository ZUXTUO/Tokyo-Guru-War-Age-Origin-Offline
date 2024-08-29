using UnityEngine;

[ExecuteInEditMode]
[RequireComponent(typeof(Camera))]
public class PostEffectsBase : MonoBehaviour
{
	protected void CheckResources()
	{
		if (!CheckSupport())
		{
			NotSupported();
		}
	}

	protected bool CheckSupport()
	{
		if (!SystemInfo.supportsImageEffects || !SystemInfo.supportsRenderTextures)
		{
			Debug.LogWarning("This platform does not support image effects or render textures.");
			return false;
		}
		return true;
	}

	protected void NotSupported()
	{
		base.enabled = false;
	}

	protected void Start()
	{
		CheckResources();
	}

	protected Material CheckShaderAndCreateMaterial(Shader shader, Material material)
	{
		if (shader == null)
		{
			return null;
		}
		if (shader.isSupported && (bool)material && material.shader == shader)
		{
			return material;
		}
		if (!shader.isSupported)
		{
			return null;
		}
		material = new Material(shader);
		material.hideFlags = HideFlags.DontSave;
		if ((bool)material)
		{
			return material;
		}
		return null;
	}
}
