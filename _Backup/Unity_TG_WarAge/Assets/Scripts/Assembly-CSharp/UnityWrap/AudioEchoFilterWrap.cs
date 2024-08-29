using Core;
using Core.Unity;
using UnityEngine;
using Wraper;

namespace UnityWrap
{
	public class AudioEchoFilterWrap : BaseObject
	{
		public static AssetObjectCache<int, AudioEchoFilterWrap> cache = new AssetObjectCache<int, AudioEchoFilterWrap>();

		private AudioEchoFilter com;

		public AudioEchoFilter component
		{
			get
			{
				return com;
			}
		}

		public AudioEchoFilterWrap()
		{
			lua_class_name = audio_echo_filter_wraper.name;
		}

		public static AudioEchoFilterWrap CreateInstance(AudioEchoFilter com)
		{
			if (com == null)
			{
				Core.Unity.Debug.LogWarning("[AudioSourceWrap CreateInstance] error: audio source is null ");
				return null;
			}
			AudioEchoFilterWrap audioEchoFilterWrap = new AudioEchoFilterWrap();
			audioEchoFilterWrap.com = com;
			cache.Add(audioEchoFilterWrap.GetPid(), audioEchoFilterWrap);
			return audioEchoFilterWrap;
		}

		public static void DestroyInstance(AudioEchoFilterWrap obj)
		{
			if (obj != null)
			{
				cache.Remove(obj.GetPid());
				obj.com = null;
			}
		}
	}
}
