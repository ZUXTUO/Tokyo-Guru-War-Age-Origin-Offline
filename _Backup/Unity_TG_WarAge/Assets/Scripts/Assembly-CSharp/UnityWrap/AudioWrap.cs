using Core;
using Core.Resource;
using Core.Unity;
using Script;
using UnityEngine;
using Wraper;

namespace UnityWrap
{
	public class AudioWrap : BaseObject
	{
		public static AssetObjectCache<int, AudioWrap> cache = new AssetObjectCache<int, AudioWrap>();

		private static string mCallbackScript = string.Empty;

		private AudioClip mAudio;

		public AudioClip component
		{
			get
			{
				return mAudio;
			}
		}

		public AudioWrap()
		{
			lua_class_name = audio_wraper.name;
		}

		public static void Load(string filepath, string callback)
		{
			mCallbackScript = callback;
			if (!AssetBundleLoader.GetInstance().Load(filepath, LoadCallback))
			{
				OnLoadCallbackImp(filepath, null, "[AudioWrap Load] The same file to be load");
			}
		}

		private static void LoadCallback(string filepath, bool loadByWWW, WWW www, AssetBundle assetBundle, string err_msg)
		{
			AudioClip audioClip = null;
			audioClip = ((!loadByWWW) ? AssertFactory.CreateAudioClip(filepath, assetBundle) : AssertFactory.CreateAudioClip(www));
			AudioWrap audioObject = CreateInstance(audioClip);
			OnLoadCallbackImp(filepath, audioObject, err_msg);
		}

		private static void OnLoadCallbackImp(string filepath, AudioWrap audioObject, string err_msg)
		{
			int num = -1;
			if (audioObject != null)
			{
				num = audioObject.GetPid();
			}
			ScriptManager.GetInstance().CallFunction(mCallbackScript, num, filepath, audioObject, err_msg);
		}

		public static AudioWrap CreateInstance(AudioClip com)
		{
			if (com == null)
			{
				Core.Unity.Debug.LogError("[AudioWrap CreateInstance] error: audio is null ");
				return null;
			}
			AudioWrap audioWrap = new AudioWrap();
			audioWrap.mAudio = com;
			cache.Add(audioWrap.GetPid(), audioWrap);
			return audioWrap;
		}

		public static void DestroyInstance(AudioWrap obj)
		{
			if (obj != null)
			{
				cache.Remove(obj.GetPid());
				if (obj.mAudio != null)
				{
					Object.DestroyImmediate(obj.mAudio, true);
					obj.mAudio = null;
				}
			}
		}
	}
}
