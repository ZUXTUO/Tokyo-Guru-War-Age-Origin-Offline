using Core;
using Core.Unity;
using UnityEngine;
using Wraper;

namespace UnityWrap
{
	public class AudioHighPassFilterWrap : BaseObject
	{
		public static AssetObjectCache<int, AudioHighPassFilterWrap> cache = new AssetObjectCache<int, AudioHighPassFilterWrap>();

		private AudioHighPassFilter com;

		public AudioHighPassFilter component
		{
			get
			{
				return com;
			}
		}

		public AudioHighPassFilterWrap()
		{
			lua_class_name = audio_high_pass_filter_wraper.name;
		}

		public static AudioHighPassFilterWrap CreateInstance(AudioHighPassFilter com)
		{
			if (com == null)
			{
				Core.Unity.Debug.LogWarning("[AudioHighPassFilterWrap CreateInstance] error: camera follow is null ");
				return null;
			}
			AudioHighPassFilterWrap audioHighPassFilterWrap = new AudioHighPassFilterWrap();
			audioHighPassFilterWrap.com = com;
			cache.Add(audioHighPassFilterWrap.GetPid(), audioHighPassFilterWrap);
			return audioHighPassFilterWrap;
		}

		public static void DestroyInstance(AudioHighPassFilterWrap obj)
		{
			if (obj != null)
			{
				cache.Remove(obj.GetPid());
				obj.com = null;
			}
		}
	}
}
