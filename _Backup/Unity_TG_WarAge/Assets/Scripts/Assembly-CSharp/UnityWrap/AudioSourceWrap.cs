using Core;
using Core.Unity;
using UnityEngine;
using Wraper;

namespace UnityWrap
{
	public class AudioSourceWrap : BaseObject
	{
		public static AssetObjectCache<int, AudioSourceWrap> cache = new AssetObjectCache<int, AudioSourceWrap>();

		private AudioSource com;

		public AudioSource component
		{
			get
			{
				return com;
			}
		}

		public AudioSourceWrap()
		{
			lua_class_name = audio_source_wraper.name;
		}

		public static AudioSourceWrap CreateInstance(AudioSource com)
		{
			if (com == null)
			{
				Core.Unity.Debug.LogWarning("[AudioSourceWrap CreateInstance] error: audio source is null ");
				return null;
			}
			AudioSourceWrap audioSourceWrap = new AudioSourceWrap();
			audioSourceWrap.com = com;
			cache.Add(audioSourceWrap.GetPid(), audioSourceWrap);
			return audioSourceWrap;
		}

		public static void DestroyInstance(AudioSourceWrap obj)
		{
			if (obj != null)
			{
				cache.Remove(obj.GetPid());
				obj.com = null;
			}
		}
	}
}
