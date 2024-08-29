using UnityEngine;

internal class ParticleClipItem : MonoBehaviour
{
	public enum ShaderType
	{
		普通叠加 = 0,
		遮罩叠加 = 1
	}

	public ShaderType shaderType;

	private UIPanel panel;

	private Transform mtrans;

	private Vector3[] clipRegion;

	private ParticleSystem[] pList;

	private MeshRenderer[] mList;

	private Vector3 softNess;

	private static Camera uicamera;

	private void Start()
	{
		mtrans = base.transform;
		panel = mtrans.GetComponentInParent<UIPanel>();
		if (uicamera == null)
		{
			Transform parent = panel.transform;
			while (parent.parent != null)
			{
				parent = parent.parent;
			}
			UICamera componentInChildren = parent.GetComponentInChildren<UICamera>();
			if (componentInChildren != null)
			{
				uicamera = componentInChildren.gameObject.GetComponent<Camera>();
			}
		}
		pList = mtrans.GetComponentsInChildren<ParticleSystem>();
		mList = mtrans.GetComponentsInChildren<MeshRenderer>();
		Shader shader = null;
		if (shaderType == ShaderType.普通叠加)
		{
			shader = App3.GetInstance().FindShader("Particles/Additive_PanelClip");
		}
		else if (shaderType == ShaderType.遮罩叠加)
		{
			shader = App3.GetInstance().FindShader("CGwell FX/Mask Additive Panel Clip");
		}
		ParticleSystem[] array = pList;
		foreach (ParticleSystem particleSystem in array)
		{
			Renderer component = particleSystem.GetComponent<Renderer>();
			Material[] materials = component.materials;
			Material[] array2 = materials;
			foreach (Material material in array2)
			{
				material.shader = shader;
			}
			materials = component.sharedMaterials;
			Material[] array3 = materials;
			foreach (Material material2 in array3)
			{
				material2.shader = shader;
			}
		}
		MeshRenderer[] array4 = mList;
		foreach (MeshRenderer meshRenderer in array4)
		{
			Renderer component2 = meshRenderer.GetComponent<Renderer>();
			Material[] materials2 = component2.materials;
			Material[] array5 = materials2;
			foreach (Material material3 in array5)
			{
				material3.shader = shader;
			}
			materials2 = component2.sharedMaterials;
			Material[] array6 = materials2;
			foreach (Material material4 in array6)
			{
				material4.shader = shader;
			}
		}
		Vector3[] worldCorners = panel.worldCorners;
		Vector3 vector = new Vector3(worldCorners[0].x, worldCorners[0].y, worldCorners[0].z);
		Vector3 vector2 = new Vector3(worldCorners[2].x, worldCorners[2].y, worldCorners[2].z);
		clipRegion = new Vector3[2];
		clipRegion[0] = vector;
		clipRegion[1] = vector2;
		softNess = new Vector3(panel.clipSoftness.x, panel.clipSoftness.y, 0f);
		refreshClip();
	}

	private void Update()
	{
		Vector3[] worldCorners = panel.worldCorners;
		Vector3 vector = panel.clipSoftness;
		if ((double)(clipRegion[0] - worldCorners[0]).magnitude > 0.0001 || (double)(clipRegion[1] - worldCorners[2]).magnitude > 0.0001 || (double)(vector - softNess).magnitude > 0.5)
		{
			clipRegion = worldCorners;
			Vector3 vector2 = new Vector3(worldCorners[0].x, worldCorners[0].y, worldCorners[0].z);
			Vector3 vector3 = new Vector3(worldCorners[2].x, worldCorners[2].y, worldCorners[2].z);
			clipRegion = new Vector3[2];
			clipRegion[0] = vector2;
			clipRegion[1] = vector3;
			softNess = new Vector3(vector.x, vector.y, 0f);
			refreshClip();
		}
	}

	private void refreshClip()
	{
		Vector3 position = clipRegion[0];
		Vector3 position2 = clipRegion[1];
		position = uicamera.WorldToScreenPoint(position);
		position2 = uicamera.WorldToScreenPoint(position2);
		position.x -= 1f;
		position2.x -= 1f;
		position = uicamera.ScreenToWorldPoint(position);
		position2 = uicamera.ScreenToWorldPoint(position2);
		Vector3 vector = uicamera.ScreenToWorldPoint(new Vector3(softNess.x + (float)(Screen.width / 2), softNess.y + (float)(Screen.height / 2), 0f));
		ParticleSystem[] array = pList;
		foreach (ParticleSystem particleSystem in array)
		{
			Renderer component = particleSystem.GetComponent<Renderer>();
			component.sharedMaterial.SetFloat("_MinX", position.x);
			component.sharedMaterial.SetFloat("_MinY", position.y);
			component.sharedMaterial.SetFloat("_MaxX", position2.x);
			component.sharedMaterial.SetFloat("_MaxY", position2.y);
			component.sharedMaterial.SetFloat("_SoftX", vector.x);
			component.sharedMaterial.SetFloat("_SoftY", vector.y);
		}
		MeshRenderer[] array2 = mList;
		foreach (MeshRenderer meshRenderer in array2)
		{
			Renderer component2 = meshRenderer.GetComponent<Renderer>();
			component2.sharedMaterial.SetFloat("_MinX", position.x);
			component2.sharedMaterial.SetFloat("_MinY", position.y);
			component2.sharedMaterial.SetFloat("_MaxX", position2.x);
			component2.sharedMaterial.SetFloat("_MaxY", position2.y);
			component2.sharedMaterial.SetFloat("_SoftX", vector.x);
			component2.sharedMaterial.SetFloat("_SoftY", vector.y);
		}
	}
}
