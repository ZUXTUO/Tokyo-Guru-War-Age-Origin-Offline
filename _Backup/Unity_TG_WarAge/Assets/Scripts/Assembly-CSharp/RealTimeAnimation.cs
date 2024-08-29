using UnityEngine;

public class RealTimeAnimation : MonoBehaviour
{
	private float _deltaTime;

	private float _timeAtLastFrame;

	private Animation[] _anims;

	private AnimationState[] animstates;

	private void Awake()
	{
		_anims = GetComponentsInChildren<Animation>();
		animstates = new AnimationState[_anims.Length];
	}

	private void OnEnable()
	{
		_timeAtLastFrame = Time.realtimeSinceStartup;
	}

	private void Update()
	{
		if (_anims == null)
		{
			return;
		}
		_deltaTime = Time.realtimeSinceStartup - _timeAtLastFrame;
		_timeAtLastFrame = Time.realtimeSinceStartup;
		if (!((double)Mathf.Abs(Time.timeScale) < 1E-06))
		{
			return;
		}
		for (int i = 0; i < _anims.Length; i++)
		{
			Animation animation = _anims[i];
			if (animation != null && animation.isPlaying)
			{
				AnimationState animationState = animstates[i];
				if (animationState == null && animation.clip != null)
				{
					animationState = animation[animation.clip.name];
					animstates[i] = animationState;
				}
				if (animationState != null)
				{
					animationState.time += _deltaTime;
					animation.Sample();
				}
			}
		}
	}
}
