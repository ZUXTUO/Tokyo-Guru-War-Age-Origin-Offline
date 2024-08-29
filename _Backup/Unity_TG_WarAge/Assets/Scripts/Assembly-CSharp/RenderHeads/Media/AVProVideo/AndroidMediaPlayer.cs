using System;
using System.Runtime.InteropServices;
using UnityEngine;

namespace RenderHeads.Media.AVProVideo
{
	public class AndroidMediaPlayer : BaseMediaPlayer
	{
		private enum AVPPluginEvent
		{
			Nop = 0,
			PlayerSetup = 1,
			PlayerUpdate = 2
		}

		private static AndroidJavaObject s_ActivityContext;

		private static bool s_bInitialised;

		private static string s_Version = "Plug-in not yet initialised";

		private static IntPtr _nativeFunction_RenderEvent;

		private AndroidJavaObject m_Video;

		private Texture2D m_Texture;

		private int m_TextureHandle;

		private float m_DurationMs;

		private int m_Width;

		private int m_Height;

		private int m_iPlayerIndex = -1;

		public AndroidMediaPlayer()
		{
			m_Video = new AndroidJavaObject("com.RenderHeads.AVProVideo.AVProMobileVideo");
			if (m_Video != null)
			{
				m_Video.Call("Initialise", s_ActivityContext);
				m_iPlayerIndex = m_Video.Call<int>("GetPlayerIndex", new object[0]);
				IssuePluginEvent(AVPPluginEvent.PlayerSetup, m_iPlayerIndex);
			}
		}

		[DllImport("AVProLocal")]
		private static extern IntPtr GetRenderEventFunc();

		public static void InitialisePlatform()
		{
			if (s_ActivityContext == null)
			{
				AndroidJavaClass androidJavaClass = new AndroidJavaClass("com.unity3d.player.UnityPlayer");
				if (androidJavaClass != null)
				{
					s_ActivityContext = androidJavaClass.GetStatic<AndroidJavaObject>("currentActivity");
				}
			}
			if (!s_bInitialised)
			{
				s_bInitialised = true;
				AndroidJavaObject androidJavaObject = new AndroidJavaObject("com.RenderHeads.AVProVideo.AVProMobileVideo");
				if (androidJavaObject != null)
				{
					s_Version = androidJavaObject.CallStatic<string>("GetPluginVersion", new object[0]);
					_nativeFunction_RenderEvent = GetRenderEventFunc();
				}
			}
		}

		private static void IssuePluginEvent(AVPPluginEvent type, int param)
		{
			int num = 0x5D5AC000 | ((int)type << 8);
			if (type == AVPPluginEvent.PlayerSetup || type == AVPPluginEvent.PlayerUpdate)
			{
				num |= param & 0xFF;
			}
			GL.IssuePluginEvent(_nativeFunction_RenderEvent, num);
		}

		public override string GetVersion()
		{
			return s_Version;
		}

		public override bool OpenVideoFromFile(string path)
		{
			bool result = false;
			if (m_Video != null)
			{
				m_DurationMs = 0f;
				m_Width = 0;
				m_Height = 0;
				Debug.Log("OpenVideoFromFile videoFilename: " + path);
				result = m_Video.Call<bool>("OpenVideoFromFile", new object[1] { path });
			}
			return result;
		}

		public override void CloseVideo()
		{
			if (m_Texture != null)
			{
				UnityEngine.Object.Destroy(m_Texture);
				m_Texture = null;
			}
			m_TextureHandle = 0;
			m_DurationMs = 0f;
			m_Width = 0;
			m_Height = 0;
			m_Video.Call("CloseVideo");
		}

		public override void SetLooping(bool bLooping)
		{
			if (m_Video != null)
			{
				m_Video.Call("SetLooping", bLooping);
			}
		}

		public override bool IsLooping()
		{
			bool result = false;
			if (m_Video != null)
			{
				result = m_Video.Call<bool>("IsLooping", new object[0]);
			}
			return result;
		}

		public override bool HasVideo()
		{
			bool result = false;
			if (m_Video != null)
			{
				result = m_Video.Call<bool>("HasVideo", new object[0]);
			}
			return result;
		}

		public override bool HasAudio()
		{
			bool result = false;
			if (m_Video != null)
			{
				result = m_Video.Call<bool>("HasAudio", new object[0]);
			}
			return result;
		}

		public override bool HasMetaData()
		{
			bool result = false;
			if (m_DurationMs > 0f)
			{
				result = true;
				if (HasVideo())
				{
					result = m_Width > 0 && m_Height > 0;
				}
			}
			return result;
		}

		public override bool CanPlay()
		{
			bool result = false;
			if (m_Video != null)
			{
				result = m_Video.Call<bool>("CanPlay", new object[0]);
			}
			return result;
		}

		public override void Play()
		{
			if (m_Video != null)
			{
				m_Video.Call("Play");
			}
		}

		public override void Pause()
		{
			if (m_Video != null)
			{
				m_Video.Call("Pause");
			}
		}

		public override void Stop()
		{
			if (m_Video != null)
			{
				m_Video.Call("Pause");
			}
		}

		public override void Rewind()
		{
			Seek(0f);
		}

		public override void Seek(float timeMs)
		{
			if (m_Video != null)
			{
				m_Video.Call("Seek", Mathf.FloorToInt(timeMs));
			}
		}

		public override void SeekFast(float timeMs)
		{
			if (m_Video != null)
			{
				m_Video.Call("Seek", Mathf.FloorToInt(timeMs));
			}
		}

		public override float GetCurrentTimeMs()
		{
			float result = 0f;
			if (m_Video != null)
			{
				result = m_Video.Call<long>("GetCurrentTimeMs", new object[0]);
			}
			return result;
		}

		public override void SetPlaybackRate(float rate)
		{
		}

		public override float GetPlaybackRate()
		{
			return 1f;
		}

		public override float GetDurationMs()
		{
			return m_DurationMs;
		}

		public override int GetVideoWidth()
		{
			return m_Width;
		}

		public override int GetVideoHeight()
		{
			return m_Height;
		}

		public override float GetVideoPlaybackRate()
		{
			float result = 0f;
			if (m_Video != null)
			{
				result = m_Video.Call<float>("GetPlaybackRate", new object[0]);
			}
			return result;
		}

		public override bool IsSeeking()
		{
			bool result = false;
			if (m_Video != null)
			{
				result = m_Video.Call<bool>("IsSeeking", new object[0]);
			}
			return result;
		}

		public override bool IsPlaying()
		{
			bool result = false;
			if (m_Video != null)
			{
				result = m_Video.Call<bool>("IsPlaying", new object[0]);
			}
			return result;
		}

		public override bool IsPaused()
		{
			bool result = false;
			if (m_Video != null)
			{
				result = m_Video.Call<bool>("IsPaused", new object[0]);
			}
			return result;
		}

		public override bool IsFinished()
		{
			bool result = false;
			if (m_Video != null)
			{
				result = m_Video.Call<bool>("IsFinished", new object[0]);
			}
			return result;
		}

		public override bool IsBuffering()
		{
			return false;
		}

		public override Texture GetTexture()
		{
			return m_Texture;
		}

		public override int GetTextureFrameCount()
		{
			int result = 0;
			if (m_Video != null)
			{
				result = m_Video.Call<int>("GetFrameCount", new object[0]);
			}
			return result;
		}

		public override bool RequiresVerticalFlip()
		{
			return false;
		}

		public override void MuteAudio(bool bMuted)
		{
			if (m_Video != null)
			{
				m_Video.Call("MuteAudio", bMuted);
			}
		}

		public override bool IsMuted()
		{
			bool result = false;
			if (m_Video != null)
			{
				result = m_Video.Call<bool>("IsMuted", new object[0]);
			}
			return result;
		}

		public override void SetVolume(float volume)
		{
			if (m_Video != null)
			{
				m_Video.Call("SetVolume", volume);
			}
		}

		public override float GetVolume()
		{
			float result = 0f;
			if (m_Video != null)
			{
				result = m_Video.Call<float>("GetVolume", new object[0]);
			}
			return result;
		}

		public override void Render()
		{
			if (m_Video == null)
			{
				return;
			}
			GL.InvalidateState();
			IssuePluginEvent(AVPPluginEvent.PlayerUpdate, m_iPlayerIndex);
			GL.InvalidateState();
			if (m_Texture != null)
			{
				int num = m_Video.Call<int>("GetWidth", new object[0]);
				int num2 = m_Video.Call<int>("GetHeight", new object[0]);
				if (num != m_Width || num2 != m_Height)
				{
					m_Texture = null;
					m_TextureHandle = 0;
				}
			}
			int num3 = m_Video.Call<int>("GetTextureHandle", new object[0]);
			if (num3 > 0 && num3 != m_TextureHandle)
			{
				int num4 = m_Video.Call<int>("GetWidth", new object[0]);
				int num5 = m_Video.Call<int>("GetHeight", new object[0]);
				if (Mathf.Max(num4, num5) > SystemInfo.maxTextureSize)
				{
					m_Width = num4;
					m_Height = num5;
					m_TextureHandle = num3;
					Debug.LogError("[AVProVideo] Video dimensions larger than maxTextureSize");
				}
				else if (num4 > 0 && num5 > 0)
				{
					m_Width = num4;
					m_Height = num5;
					m_TextureHandle = num3;
					m_Texture = Texture2D.CreateExternalTexture(m_Width, m_Height, TextureFormat.RGBA32, false, false, new IntPtr(num3));
					if (m_Texture != null)
					{
						ApplyTextureProperties(m_Texture);
					}
					Debug.Log("Texture ID: " + num3);
				}
			}
			if (m_DurationMs == 0f)
			{
				m_DurationMs = m_Video.Call<long>("GetDurationMs", new object[0]);
			}
		}

		public override void Update()
		{
		}

		public override void Dispose()
		{
			if (m_Video != null)
			{
				m_Video.Call("Deinitialise");
				m_Video.Dispose();
				m_Video = null;
			}
			if (m_Texture != null)
			{
				UnityEngine.Object.Destroy(m_Texture);
				m_Texture = null;
			}
		}
	}
}
