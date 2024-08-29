using Core.Audio;
using UnityEngine;

public class SoundHandler : MonoBehaviour
{
	private AudioSource m_audioSource;

	private void Awake()
	{
		m_audioSource = base.gameObject.GetComponent<AudioSource>();
		if (m_audioSource == null)
		{
			m_audioSource = base.gameObject.AddComponent<AudioSource>();
		}
		m_audioSource.enabled = AudioController.GetInstance().enableSoundEffect;
	}

	private void Start()
	{
	}

	private void Update()
	{
		if ((bool)m_audioSource && m_audioSource.enabled != AudioController.GetInstance().enableSoundEffect)
		{
			m_audioSource.enabled = AudioController.GetInstance().enableSoundEffect;
		}
	}
}
