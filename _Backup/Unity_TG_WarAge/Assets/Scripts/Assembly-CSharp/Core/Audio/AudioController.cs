using UnityEngine;

namespace Core.Audio
{
	public class AudioController : MonoBehaviourEx
	{
		private static string m_go_name = "_AudioController";

		private static string m_first_music_name = "_FirstAudio";

		private static string m_second_music_name = "_SecondAudio";

		private static AudioController m_instance;

		private GameObject m_target;

		private AudioSource m_first_audio;

		private AudioSource m_second_audio;

		public float m_music_fade_speed = 1f;

		public float m_music_volume = 0.6f;

		private bool m_enable_sound_effect = true;

		public bool enableSoundEffect
		{
			get
			{
				return m_enable_sound_effect;
			}
			set
			{
				m_enable_sound_effect = value;
				if (m_enable_sound_effect)
				{
					NGUITools.soundVolume = 1f;
				}
				else
				{
					NGUITools.soundVolume = 0f;
				}
			}
		}

		public static AudioController GetInstance()
		{
			if (m_instance == null)
			{
				GameObject gameObject = MonoBehaviourEx.CreateGameObject(m_go_name);
				m_instance = gameObject.AddComponent<AudioController>();
			}
			return m_instance;
		}

		private void Awake()
		{
			base.gameObject.AddComponent<AudioListener>();
			GameObject gameObject = new GameObject(m_first_music_name);
			GameObject gameObject2 = new GameObject(m_second_music_name);
			gameObject.transform.parent = base.gameObject.transform;
			gameObject2.transform.parent = base.gameObject.transform;
			m_first_audio = gameObject.AddComponent<AudioSource>();
			m_second_audio = gameObject2.AddComponent<AudioSource>();
			m_first_audio.loop = true;
			m_second_audio.loop = true;
			m_first_audio.volume = 0f;
			m_second_audio.volume = 0f;
		}

		private void LateUpdate()
		{
			if (m_target != null)
			{
				base.gameObject.transform.position = m_target.transform.position;
				base.gameObject.transform.rotation = m_target.transform.rotation;
			}
			BackgroundMusicFading();
		}

		public void SetListenerTarget(GameObject target)
		{
			m_target = target;
		}

		public void PlayBackgroundMusic(AudioClip clip)
		{
			m_second_audio.volume = m_first_audio.volume;
			m_second_audio.clip = m_first_audio.clip;
			m_second_audio.Play();
			m_first_audio.volume = 0f;
			m_first_audio.clip = clip;
			m_first_audio.Play();
		}

		public void StopBackgroundMusic()
		{
			m_second_audio.Stop();
			m_first_audio.Stop();
		}

		private void BackgroundMusicFading()
		{
			if (m_first_audio.isPlaying)
			{
				m_first_audio.volume = Mathf.Lerp(m_first_audio.volume, m_music_volume, m_music_fade_speed * Time.deltaTime);
			}
			if (m_second_audio.isPlaying)
			{
				m_second_audio.volume = Mathf.Lerp(m_second_audio.volume, 0f, m_music_fade_speed * Time.deltaTime);
			}
		}

		public void SetBackgroundMusicEnable(bool enable)
		{
			m_first_audio.mute = enable;
			m_second_audio.mute = enable;
		}

		public void SetBackgroundMusicLoop(bool loop)
		{
			m_first_audio.loop = loop;
			m_second_audio.loop = loop;
		}

		public void SetMusicEnable(GameObject target, bool enable)
		{
			if (!target)
			{
				return;
			}
			foreach (Transform item in target.transform)
			{
				if ((bool)item.gameObject)
				{
					AudioSource component = item.GetComponent<AudioSource>();
					if ((bool)component)
					{
						component.mute = enable;
					}
					SetMusicEnable(item.gameObject, enable);
				}
			}
		}
	}
}
