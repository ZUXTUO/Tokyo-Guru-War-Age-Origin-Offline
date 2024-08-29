using System.Collections.Generic;
using UnityEngine;

public class EffectTrigger : MonoBehaviour
{
	public List<ParticleSystem> particleSystems;

	public Animator animator;

	public string stateName;

	private void Start()
	{
		for (int i = 0; i < particleSystems.Count; i++)
		{
			particleSystems[i].Stop(true);
		}
	}

	private void OnTriggerEnter(Collider other)
	{
		Debug.Log("[EffectTrigger OnTriggerEnter]");
		for (int i = 0; i < particleSystems.Count; i++)
		{
			particleSystems[i].Play(true);
		}
		if ((bool)animator)
		{
			animator.Play(stateName);
		}
	}
}
