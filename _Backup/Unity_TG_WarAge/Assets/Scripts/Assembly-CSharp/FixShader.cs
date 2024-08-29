using System.Collections.Generic;
using UnityEngine;

public class FixShader
{
	private static FixShader _instance;

	private static Dictionary<string, bool> m_Material = new Dictionary<string, bool>();

	private static Dictionary<string, Shader> m_Shaders = new Dictionary<string, Shader>();

	public static FixShader GetInstance()
	{
		if (_instance == null)
		{
			_instance = new FixShader();
		}
		return _instance;
	}

	public void ReloadShader(GameObject o)
	{
		List<Material> list = new List<Material>();
		Renderer[] componentsInChildren = o.GetComponentsInChildren<Renderer>(true);
		Projector[] componentsInChildren2 = o.GetComponentsInChildren<Projector>(true);
		for (int i = 0; i < componentsInChildren.Length; i++)
		{
			if (componentsInChildren[i].sharedMaterials != null)
			{
				list.AddRange(componentsInChildren[i].sharedMaterials);
			}
		}
		for (int j = 0; j < componentsInChildren2.Length; j++)
		{
			if (componentsInChildren2[j].material != null)
			{
				list.Add(componentsInChildren2[j].material);
			}
		}
		for (int k = 0; k < list.Count; k++)
		{
			if (!(list[k] == null) && !(list[k].shader == null))
			{
				Shader shader = getShader(list[k].shader.name);
				if (shader != null)
				{
					list[k].shader = shader;
				}
			}
		}
	}

	private void FixParticleSystem(GameObject o)
	{
		ParticleSystem[] componentsInChildren = o.GetComponentsInChildren<ParticleSystem>(true);
		ParticleSystem[] array = componentsInChildren;
		foreach (ParticleSystem particleSystem in array)
		{
			Renderer component = particleSystem.GetComponent<Renderer>();
			if (null != component)
			{
				fixShader(component);
			}
			else
			{
				Debug.LogError("ParticleSystem renderer not found.");
			}
		}
	}

	private void FixMeshRenderer(GameObject o)
	{
		MeshRenderer[] componentsInChildren = o.GetComponentsInChildren<MeshRenderer>(true);
		MeshRenderer[] array = componentsInChildren;
		foreach (MeshRenderer meshRenderer in array)
		{
			Renderer component = meshRenderer.GetComponent<Renderer>();
			if (null != component)
			{
				fixShader(component);
			}
			else
			{
				Debug.LogError("MeshRenderer renderer not found.");
			}
		}
	}

	private void FixSkinnedMeshRenderer(GameObject o)
	{
		SkinnedMeshRenderer[] componentsInChildren = o.GetComponentsInChildren<SkinnedMeshRenderer>(true);
		SkinnedMeshRenderer[] array = componentsInChildren;
		foreach (SkinnedMeshRenderer skinnedMeshRenderer in array)
		{
			Renderer component = skinnedMeshRenderer.GetComponent<Renderer>();
			if (null != component)
			{
				fixShader(component);
			}
			else
			{
				Debug.LogError("SkinnedMeshRenderer renderer not found.");
			}
		}
	}

	private void fixShader(Renderer render)
	{
		if (render.sharedMaterial == null)
		{
			return;
		}
		string name = render.sharedMaterial.name;
		bool isSupported = render.sharedMaterial.shader.isSupported;
		if (m_Material.ContainsKey(name))
		{
			if (!isSupported)
			{
				Debug.LogWarning("material " + name + " has been fixed. but failed.");
			}
		}
		else if (!isSupported)
		{
			Shader shader = getShader(render.sharedMaterial.shader.name);
			if (null != shader)
			{
				render.sharedMaterial.shader = shader;
				render.sharedMaterial.enableInstancing = false;
			}
			else
			{
				Debug.LogError("fixShader local shader:" + render.sharedMaterial.shader.name + " not found.");
			}
			if (!m_Material.ContainsKey(name))
			{
				m_Material.Add(name, isSupported);
			}
		}
	}

	private Shader getShader(string name)
	{
		if (!m_Shaders.ContainsKey(name))
		{
			Shader shader = Shader.Find(name);
			m_Shaders.Add(name, shader);
			return shader;
		}
		return m_Shaders[name];
	}
}
