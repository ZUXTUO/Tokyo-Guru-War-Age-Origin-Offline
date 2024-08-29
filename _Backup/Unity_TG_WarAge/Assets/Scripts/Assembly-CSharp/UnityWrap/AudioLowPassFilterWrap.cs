using Core;
using Core.Unity;
using UnityEngine;
using Wraper;

namespace UnityWrap
{
	public class AudioLowPassFilterWrap : BaseObject
	{
		public static AssetObjectCache<int, AudioLowPassFilterWrap> cache = new AssetObjectCache<int, AudioLowPassFilterWrap>();

		private AudioLowPassFilter com;

		public AudioLowPassFilter component
		{
			get
			{
				return com;
			}
		}

		public AudioLowPassFilterWrap()
		{
			lua_class_name = audio_low_pass_filter_wraper.name;
		}

		public static AudioLowPassFilterWrap CreateInstance(AudioLowPassFilter com)
		{
			if (com == null)
			{
				Core.Unity.Debug.LogWarning("[AudioLowPassFilterWrap CreateInstance] error: camera follow is null ");
				return null;
			}
			AudioLowPassFilterWrap audioLowPassFilterWrap = new AudioLowPassFilterWrap();
			audioLowPassFilterWrap.com = com;
			cache.Add(audioLowPassFilterWrap.GetPid(), audioLowPassFilterWrap);
			return audioLowPassFilterWrap;
		}

		public static void DestroyInstance(AudioLowPassFilterWrap obj)
		{
			if (obj != null)
			{
				cache.Remove(obj.GetPid());
				obj.com = null;
			}
		}
	}
}
