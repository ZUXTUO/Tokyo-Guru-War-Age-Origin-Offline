using UnityEngine;

public class RealTimeParticle : MonoBehaviour
{
	private ParticleSystem[] _particles;

	private float _deltaTime;

	private float _timeAtLastFrame;

	private void Awake()
	{
		_particles = GetComponentsInChildren<ParticleSystem>();
	}

	private void OnEnable()
	{
		_timeAtLastFrame = Time.realtimeSinceStartup;
	}

	private void Update()
	{
		if (_particles == null)
		{
			return;
		}
		_deltaTime = Time.realtimeSinceStartup - _timeAtLastFrame;
		_timeAtLastFrame = Time.realtimeSinceStartup;
		if (!((double)Mathf.Abs(Time.timeScale) < 1E-06))
		{
			return;
		}
		for (int i = 0; i < _particles.Length; i++)
		{
			ParticleSystem particleSystem = _particles[i];
			if (particleSystem != null)
			{
				particleSystem.Simulate(_deltaTime, false, false);
				particleSystem.Play();
			}
		}
	}
}
