using System.Collections.Generic;
using UnityEngine;

public class EffectHelper : MonoBehaviour
{
	private Animator[] m_animatorList;

	private Animation[] m_animationList;

	private ParticleSystem[] m_particleList;

	private TrailRenderer[] m_TrailRendererList;

	private FxQualityCtrlHelper[] m_QualityControlList;

	private Material[] m_lightProbeEffectMats;

	private Material[] m_allSkinMats;

	private bool m_Stop;

	private void findComponents()
	{
		m_animatorList = base.gameObject.GetComponentsInChildren<Animator>();
		m_animationList = base.gameObject.GetComponentsInChildren<Animation>();
		m_particleList = base.gameObject.GetComponentsInChildren<ParticleSystem>();
		m_TrailRendererList = base.gameObject.GetComponentsInChildren<TrailRenderer>();
		m_QualityControlList = base.gameObject.GetComponentsInChildren<FxQualityCtrlHelper>();
		SkinnedMeshRenderer[] componentsInChildren = base.gameObject.GetComponentsInChildren<SkinnedMeshRenderer>();
		List<Material> list = new List<Material>();
		List<Material> list2 = new List<Material>();
		for (int i = 0; i < componentsInChildren.Length; i++)
		{
			if (componentsInChildren[i].sharedMaterial != null)
			{
				list2.Add(componentsInChildren[i].sharedMaterial);
				if (componentsInChildren[i].sharedMaterial.HasProperty("_SHfactor"))
				{
					list.Add(componentsInChildren[i].sharedMaterial);
				}
			}
		}
		if (list.Count > 0)
		{
			m_lightProbeEffectMats = list.ToArray();
		}
		if (list2.Count > 0)
		{
			m_allSkinMats = list2.ToArray();
		}
	}

	private void Awake()
	{
		findComponents();
	}

	public void SetAnimatorCullingMode(int mode)
	{
		if (m_animatorList != null)
		{
			for (int i = 0; i < m_animatorList.Length; i++)
			{
				Animator animator = m_animatorList[i];
				animator.cullingMode = (AnimatorCullingMode)mode;
			}
		}
	}

	public void Replay()
	{
		m_Stop = false;
		if (m_animatorList != null)
		{
			for (int i = 0; i < m_animatorList.Length; i++)
			{
				Animator animator = m_animatorList[i];
				animator.enabled = true;
				animator.speed = 1f;
				animator.Play(animator.GetCurrentAnimatorStateInfo(0).fullPathHash, 0, 0f);
			}
		}
		if (m_animationList != null)
		{
			for (int j = 0; j < m_animationList.Length; j++)
			{
				Animation animation = m_animationList[j];
				animation.Play();
			}
		}
		if (m_particleList != null)
		{
			for (int k = 0; k < m_particleList.Length; k++)
			{
				ParticleSystem particleSystem = m_particleList[k];
				particleSystem.playbackSpeed = 1f;
				particleSystem.Play(true);
			}
		}
		if (m_TrailRendererList == null)
		{
			return;
		}
		for (int l = 0; l < m_TrailRendererList.Length; l++)
		{
			TrailRenderer trailRenderer = m_TrailRendererList[l];
			float result = 0f;
			if (float.TryParse(trailRenderer.name, out result))
			{
				trailRenderer.time = result;
			}
			trailRenderer.enabled = true;
		}
	}

	public void SetPlaySpeed(float speed)
	{
		if (speed < 0f)
		{
			return;
		}
		if (m_animatorList != null)
		{
			for (int i = 0; i < m_animatorList.Length; i++)
			{
				Animator animator = m_animatorList[i];
				animator.speed = speed;
			}
		}
		if (m_animationList != null)
		{
			for (int j = 0; j < m_animationList.Length; j++)
			{
				Animation animation = m_animationList[j];
				animation[animation.clip.name].speed = speed;
			}
		}
		if (m_particleList != null)
		{
			for (int k = 0; k < m_particleList.Length; k++)
			{
				m_particleList[k].playbackSpeed = speed;
			}
		}
	}

	public void Stop()
	{
		if (m_Stop)
		{
			return;
		}
		m_Stop = true;
		if (m_animatorList != null)
		{
			for (int i = 0; i < m_animatorList.Length; i++)
			{
				Animator animator = m_animatorList[i];
				animator.enabled = false;
			}
		}
		if (m_particleList != null)
		{
			for (int j = 0; j < m_particleList.Length; j++)
			{
				ParticleSystem particleSystem = m_particleList[j];
				particleSystem.Stop(true);
				particleSystem.Clear();
			}
		}
		if (m_TrailRendererList != null)
		{
			for (int k = 0; k < m_TrailRendererList.Length; k++)
			{
				TrailRenderer trailRenderer = m_TrailRendererList[k];
				trailRenderer.name = trailRenderer.time.ToString();
				trailRenderer.time = 0f;
			}
		}
	}

	public void ResetEffectQuality()
	{
		if (m_QualityControlList != null)
		{
			for (int i = 0; i < m_QualityControlList.Length; i++)
			{
				m_QualityControlList[i].SetQuality();
			}
		}
	}

	public void DisableLightProbe()
	{
		if (m_lightProbeEffectMats != null)
		{
			for (int i = 0; i < m_lightProbeEffectMats.Length; i++)
			{
				m_lightProbeEffectMats[i].SetFloat("_SHfactor", 0f);
			}
		}
	}

	public void SetMaterialFloatProperty(string name, float value)
	{
		if (m_allSkinMats != null)
		{
			for (int i = 0; i < m_allSkinMats.Length; i++)
			{
				m_allSkinMats[i].SetFloat(name, value);
			}
		}
	}

	public void SetMaterialColorProperty(string name, Vector4 value)
	{
		if (m_allSkinMats != null)
		{
			for (int i = 0; i < m_allSkinMats.Length; i++)
			{
				m_allSkinMats[i].SetColor(name, value);
			}
		}
	}
}
