using System;
using System.Collections;
using System.IO;
using UnityEngine;

namespace RenderHeads.Media.AVProVideo
{
	[AddComponentMenu("AVPro Video/Media Player")]
	public class MediaPlayer : MonoBehaviour
	{
		public enum FileLocation
		{
			AbsolutePathOrURL = 0,
			RelativeToProjectFolder = 1,
			RelativeToStreamingAssetsFolder = 2,
			RelativeToDataFolder = 3,
			RelativeToPeristentDataFolder = 4
		}

		[Serializable]
		public class PlatformOptions
		{
			public bool overridePath;

			public FileLocation pathLocation = FileLocation.RelativeToStreamingAssetsFolder;

			public string path;
		}

		[Serializable]
		public class OptionsWindows : PlatformOptions
		{
			public bool forceDirectShowApi;

			public string forceAudioOutputDeviceName = string.Empty;
		}

		[Serializable]
		public class OptionsMacOSX : PlatformOptions
		{
		}

		[Serializable]
		public class OptionsIOS : PlatformOptions
		{
		}

		[Serializable]
		public class OptionsTVOS : PlatformOptions
		{
		}

		[Serializable]
		public class OptionsAndroid : PlatformOptions
		{
		}

		[Serializable]
		public class OptionsWindowsPhone : PlatformOptions
		{
		}

		[Serializable]
		public class OptionsWindowsUWP : PlatformOptions
		{
		}

		public FileLocation m_VideoLocation = FileLocation.RelativeToStreamingAssetsFolder;

		public string m_VideoPath;

		public bool m_AutoOpen = true;

		public bool m_AutoStart;

		public bool m_Loop;

		[Range(0f, 1f)]
		public float m_Volume = 1f;

		public bool m_Muted;

		[Range(-4f, 4f)]
		public float m_PlaybackRate = 1f;

		public bool m_DebugGui;

		public bool m_Persistent;

		public StereoPacking m_StereoPacking;

		public bool m_DisplayDebugStereoColorTint;

		public FilterMode m_FilterMode = FilterMode.Bilinear;

		public TextureWrapMode m_WrapMode = TextureWrapMode.Clamp;

		[Range(0f, 16f)]
		public int m_AnisoLevel;

		[SerializeField]
		private MediaPlayerEvent m_events;

		private IMediaControl m_Control;

		private IMediaProducer m_Texture;

		private IMediaInfo m_Info;

		private IMediaPlayer m_Player;

		private IDisposable m_Dispose;

		private bool m_VideoOpened;

		private bool m_AutoStartTriggered;

		private bool m_WasPlayingOnPause;

		private bool m_isRenderCoroutineRunning;

		private const float s_GuiScale = 1.5f;

		private const int s_GuiStartWidth = 10;

		private const int s_GuiWidth = 180;

		private int m_GuiPositionX = 10;

		private static bool s_GlobalStartup;

		private bool m_EventFired_ReadyToPlay;

		private bool m_EventFired_Started;

		private bool m_EventFired_FirstFrameReady;

		private bool m_EventFired_FinishedPlaying;

		private bool m_EventFired_MetaDataReady;

		public OptionsWindows _optionsWindows = new OptionsWindows();

		public OptionsMacOSX _optionsMacOSX = new OptionsMacOSX();

		public OptionsIOS _optionsIOS = new OptionsIOS();

		public OptionsTVOS _optionsTVOS = new OptionsTVOS();

		public OptionsAndroid _optionsAndroid = new OptionsAndroid();

		public OptionsWindowsPhone _optionsWindowsPhone = new OptionsWindowsPhone();

		public OptionsWindowsUWP _optionsWindowsUWP = new OptionsWindowsUWP();

		public IMediaInfo Info
		{
			get
			{
				return m_Info;
			}
		}

		public IMediaControl Control
		{
			get
			{
				return m_Control;
			}
		}

		public IMediaPlayer Player
		{
			get
			{
				return m_Player;
			}
		}

		public virtual IMediaProducer TextureProducer
		{
			get
			{
				return m_Texture;
			}
		}

		public MediaPlayerEvent Events
		{
			get
			{
				if (m_events == null)
				{
					m_events = new MediaPlayerEvent();
				}
				return m_events;
			}
		}

		private void Awake()
		{
			if (m_Persistent)
			{
				UnityEngine.Object.DontDestroyOnLoad(base.gameObject);
			}
		}

		private void Initialise()
		{
			BaseMediaPlayer baseMediaPlayer = CreatePlatformMediaPlayer();
			if (baseMediaPlayer != null)
			{
				m_Control = baseMediaPlayer;
				m_Texture = baseMediaPlayer;
				m_Info = baseMediaPlayer;
				m_Player = baseMediaPlayer;
				m_Dispose = baseMediaPlayer;
				if (!s_GlobalStartup)
				{
					Debug.Log(string.Format("[AVProVideo] Initialising AVPro Video (script v{0} plugin v{1}) on {2}/{3} (MT {4})", "1.3.9", baseMediaPlayer.GetVersion(), SystemInfo.graphicsDeviceName, SystemInfo.graphicsDeviceVersion, SystemInfo.graphicsMultiThreaded));
					s_GlobalStartup = true;
				}
			}
		}

		private void Start()
		{
			if (m_Control == null)
			{
				Initialise();
			}
			if (m_Control != null)
			{
				if (m_AutoOpen)
				{
					OpenVideoFromFile();
				}
				StartRenderCoroutine();
			}
		}

		public bool OpenVideoFromFile(FileLocation location, string path, bool autoPlay = true)
		{
			m_VideoLocation = location;
			m_VideoPath = path;
			m_AutoStart = autoPlay;
			if (m_Control == null)
			{
				Initialise();
			}
			return OpenVideoFromFile();
		}

		private bool OpenVideoFromFile()
		{
			bool result = false;
			if (m_Control != null)
			{
				CloseVideo();
				m_VideoOpened = true;
				m_AutoStartTriggered = !m_AutoStart;
				m_EventFired_MetaDataReady = false;
				m_EventFired_ReadyToPlay = false;
				m_EventFired_Started = false;
				m_EventFired_FirstFrameReady = false;
				string platformFilePath = GetPlatformFilePath(GetPlatform(), ref m_VideoPath, ref m_VideoLocation);
				if (!string.IsNullOrEmpty(m_VideoPath))
				{
					bool flag = true;
					if (platformFilePath.Contains("://"))
					{
						flag = false;
					}
					if (false && !File.Exists(platformFilePath))
					{
						Debug.LogError("[AVProVideo] File not found: " + platformFilePath, this);
					}
					else if (!m_Control.OpenVideoFromFile(platformFilePath))
					{
						Debug.LogError("[AVProVideo] Failed to open " + platformFilePath, this);
					}
					else
					{
						SetPlaybackOptions();
						result = true;
					}
				}
				else
				{
					Debug.LogError("[AVProVideo] No file path specified", this);
				}
			}
			return result;
		}

		private void SetPlaybackOptions()
		{
			if (m_Control != null)
			{
				m_Control.SetLooping(m_Loop);
				m_Control.SetVolume(m_Volume);
				m_Control.SetPlaybackRate(m_PlaybackRate);
				m_Control.MuteAudio(m_Muted);
				m_Control.SetTextureProperties(m_FilterMode, m_WrapMode, m_AnisoLevel);
			}
		}

		public void CloseVideo()
		{
			if (m_Control != null)
			{
				if (m_events != null)
				{
					m_events.Invoke(this, MediaPlayerEvent.EventType.Closing, ErrorCode.None);
				}
				m_AutoStartTriggered = false;
				m_VideoOpened = false;
				m_EventFired_ReadyToPlay = false;
				m_EventFired_Started = false;
				m_EventFired_MetaDataReady = false;
				m_EventFired_FirstFrameReady = false;
				m_Control.CloseVideo();
			}
		}

		public void Play()
		{
			if (m_Control != null && m_Control.CanPlay())
			{
				m_Control.Play();
			}
			else
			{
				m_AutoStart = true;
			}
		}

		public void Pause()
		{
			if (m_Control != null && m_Control.IsPlaying())
			{
				m_Control.Pause();
			}
		}

		public void Stop()
		{
			if (m_Control != null)
			{
				m_Control.Stop();
			}
		}

		public void Rewind(bool pause)
		{
			if (m_Control != null)
			{
				if (pause)
				{
					Pause();
				}
				m_Control.Rewind();
			}
		}

		private void Update()
		{
			if (m_Control != null)
			{
				if (m_VideoOpened && m_AutoStart && !m_AutoStartTriggered && m_Control.CanPlay())
				{
					m_AutoStartTriggered = true;
					m_Control.Play();
				}
				m_Player.Update();
				UpdateErrors();
				UpdateEvents();
			}
		}

		private void OnEnable()
		{
			if (m_Control != null && m_WasPlayingOnPause)
			{
				m_AutoStart = true;
				m_AutoStartTriggered = false;
				m_WasPlayingOnPause = false;
			}
			StartRenderCoroutine();
		}

		private void OnDisable()
		{
			if (m_Control != null && m_Control.IsPlaying())
			{
				m_WasPlayingOnPause = true;
				Pause();
			}
			StopRenderCoroutine();
		}

		private void OnDestroy()
		{
			StopRenderCoroutine();
			m_VideoOpened = false;
			if (m_Dispose != null)
			{
				m_Dispose.Dispose();
				m_Dispose = null;
			}
			m_Control = null;
			m_Texture = null;
			m_Info = null;
			m_Player = null;
		}

		private void OnApplicationQuit()
		{
			if (!s_GlobalStartup)
			{
				return;
			}
			Debug.Log("[AVProVideo] Shutdown");
			MediaPlayer[] array = Resources.FindObjectsOfTypeAll<MediaPlayer>();
			if (array != null && array.Length > 0)
			{
				for (int i = 0; i < array.Length; i++)
				{
					array[i].CloseVideo();
				}
			}
			s_GlobalStartup = false;
		}

		private void StartRenderCoroutine()
		{
			if (!m_isRenderCoroutineRunning)
			{
				m_isRenderCoroutineRunning = true;
				StartCoroutine("FinalRenderCapture");
			}
		}

		private void StopRenderCoroutine()
		{
			if (m_isRenderCoroutineRunning)
			{
				StopCoroutine("FinalRenderCapture");
				m_isRenderCoroutineRunning = false;
			}
		}

		private IEnumerator FinalRenderCapture()
		{
			while (Application.isPlaying)
			{
				yield return new WaitForEndOfFrame();
				if (base.enabled && m_Player != null)
				{
					m_Player.Render();
				}
			}
		}

		public static Platform GetPlatform()
		{
			Platform platform = Platform.Unknown;
			return Platform.Android;
		}

		public PlatformOptions GetPlatformOptions(Platform platform)
		{
			PlatformOptions platformOptions = null;
			return _optionsAndroid;
		}

		public static string GetPath(FileLocation location)
		{
			string result = string.Empty;
			switch (location)
			{
			case FileLocation.RelativeToDataFolder:
				result = Application.dataPath;
				break;
			case FileLocation.RelativeToPeristentDataFolder:
				result = Application.persistentDataPath;
				break;
			case FileLocation.RelativeToProjectFolder:
				result = Path.GetFullPath(Path.Combine(Application.dataPath, ".."));
				result = result.Replace('\\', '/');
				break;
			case FileLocation.RelativeToStreamingAssetsFolder:
				result = Application.streamingAssetsPath;
				break;
			}
			return result;
		}

		public static string GetFilePath(string path, FileLocation location)
		{
			string result = string.Empty;
			if (!string.IsNullOrEmpty(path))
			{
				switch (location)
				{
				case FileLocation.AbsolutePathOrURL:
					result = path;
					break;
				case FileLocation.RelativeToProjectFolder:
				case FileLocation.RelativeToStreamingAssetsFolder:
				case FileLocation.RelativeToDataFolder:
				case FileLocation.RelativeToPeristentDataFolder:
					result = Path.Combine(GetPath(location), path);
					break;
				}
			}
			return result;
		}

		private string GetPlatformFilePath(Platform platform, ref string filePath, ref FileLocation fileLocation)
		{
			string empty = string.Empty;
			if (platform != Platform.Unknown)
			{
				PlatformOptions platformOptions = GetPlatformOptions(platform);
				if (platformOptions != null && platformOptions.overridePath)
				{
					filePath = platformOptions.path;
					fileLocation = platformOptions.pathLocation;
				}
			}
			return GetFilePath(filePath, fileLocation);
		}

		public virtual BaseMediaPlayer CreatePlatformMediaPlayer()
		{
			BaseMediaPlayer baseMediaPlayer = null;
			AndroidMediaPlayer.InitialisePlatform();
			baseMediaPlayer = new AndroidMediaPlayer();
			if (baseMediaPlayer == null)
			{
				Debug.LogWarning("[AVProVideo] Not supported on this platform.  Using placeholder player!");
				baseMediaPlayer = new NullMediaPlayer();
			}
			return baseMediaPlayer;
		}

		private bool ForceWaitForNewFrame(int lastFrameCount, float timeoutMs)
		{
			bool result = false;
			DateTime now = DateTime.Now;
			int num = 0;
			while (Control != null && (DateTime.Now - now).TotalMilliseconds < (double)timeoutMs)
			{
				m_Player.Update();
				if (lastFrameCount != TextureProducer.GetTextureFrameCount())
				{
					result = true;
					break;
				}
				num++;
			}
			m_Player.Render();
			return result;
		}

		private void UpdateErrors()
		{
			ErrorCode lastError = m_Control.GetLastError();
			if (lastError != 0)
			{
				Debug.LogError("[AVProVideo] Error: " + lastError);
				if (m_events != null)
				{
					m_events.Invoke(this, MediaPlayerEvent.EventType.Error, lastError);
				}
			}
		}

		private void UpdateEvents()
		{
			if (m_events != null && m_Control != null)
			{
				if (!m_EventFired_FinishedPlaying && !m_Control.IsLooping() && m_Control.CanPlay() && m_Control.IsFinished())
				{
					m_EventFired_FinishedPlaying = true;
					m_events.Invoke(this, MediaPlayerEvent.EventType.FinishedPlaying, ErrorCode.None);
				}
				if (m_EventFired_Started && !m_Control.IsPlaying())
				{
					m_EventFired_Started = false;
				}
				if (m_EventFired_FinishedPlaying && m_Control.IsPlaying() && !m_Control.IsFinished())
				{
					m_EventFired_FinishedPlaying = false;
				}
				if (!m_EventFired_MetaDataReady && m_Control.HasMetaData())
				{
					m_EventFired_MetaDataReady = true;
					m_events.Invoke(this, MediaPlayerEvent.EventType.MetaDataReady, ErrorCode.None);
				}
				if (!m_EventFired_ReadyToPlay && !m_Control.IsPlaying() && m_Control.CanPlay())
				{
					m_EventFired_ReadyToPlay = true;
					m_events.Invoke(this, MediaPlayerEvent.EventType.ReadyToPlay, ErrorCode.None);
				}
				if (!m_EventFired_Started && m_Control.IsPlaying())
				{
					m_EventFired_Started = true;
					m_events.Invoke(this, MediaPlayerEvent.EventType.Started, ErrorCode.None);
				}
				if (m_Texture != null && !m_EventFired_FirstFrameReady && m_Control.CanPlay() && m_Texture.GetTextureFrameCount() > 0)
				{
					m_EventFired_FirstFrameReady = true;
					m_events.Invoke(this, MediaPlayerEvent.EventType.FirstFrameReady, ErrorCode.None);
				}
			}
		}

		private void OnApplicationFocus(bool focusStatus)
		{
			if (focusStatus && m_Control != null && m_WasPlayingOnPause)
			{
				m_WasPlayingOnPause = false;
				m_Control.Play();
				Debug.Log("OnApplicationFocus: playing video again");
			}
		}

		private void OnApplicationPause(bool pauseStatus)
		{
			if (pauseStatus)
			{
				if (m_Control != null && m_Control.IsPlaying())
				{
					m_WasPlayingOnPause = true;
					m_Control.Pause();
					Debug.Log("OnApplicationPause: pausing video");
				}
			}
			else
			{
				OnApplicationFocus(true);
			}
		}

		public Texture2D ExtractFrame(Texture2D target, float timeSeconds = -1f, bool accurateSeek = true, int timeoutMs = 1000)
		{
			Texture2D result = target;
			Texture texture = ExtractFrame(timeSeconds, accurateSeek, timeoutMs);
			if (texture != null)
			{
				result = Helper.GetReadableTexture(texture, TextureProducer.RequiresVerticalFlip(), target);
			}
			return result;
		}

		private Texture ExtractFrame(float timeSeconds = -1f, bool accurateSeek = true, int timeoutMs = 1000)
		{
			Texture result = null;
			if (m_Control != null)
			{
				if (timeSeconds >= 0f)
				{
					Pause();
					float num = timeSeconds * 1000f;
					if (TextureProducer.GetTexture() != null && m_Control.GetCurrentTimeMs() == num)
					{
						result = TextureProducer.GetTexture();
					}
					else
					{
						int textureFrameCount = TextureProducer.GetTextureFrameCount();
						if (accurateSeek)
						{
							m_Control.Seek(num);
						}
						else
						{
							m_Control.SeekFast(num);
						}
						ForceWaitForNewFrame(textureFrameCount, timeoutMs);
						result = TextureProducer.GetTexture();
					}
				}
				else
				{
					result = TextureProducer.GetTexture();
				}
			}
			return result;
		}

		public void SetGuiPositionFromVideoIndex(int index)
		{
			m_GuiPositionX = Mathf.FloorToInt(15f + (float)(180 * index) * 1.5f);
		}

		public void SetDebugGuiEnabled(bool bEnabled)
		{
			m_DebugGui = bEnabled;
		}

		private void OnGUI()
		{
			if (m_Info == null || !m_DebugGui)
			{
				return;
			}
			GUI.depth = -1;
			GUI.matrix = Matrix4x4.TRS(new Vector3(m_GuiPositionX, 10f, 0f), Quaternion.identity, new Vector3(1.5f, 1.5f, 1f));
			GUILayout.BeginVertical("box", GUILayout.MaxWidth(180f));
			GUILayout.Label(Path.GetFileName(m_VideoPath));
			GUILayout.Label("Dimensions: " + m_Info.GetVideoWidth() + " x " + m_Info.GetVideoHeight());
			GUILayout.Label("Time: " + (m_Control.GetCurrentTimeMs() * 0.001f).ToString("F1") + "s / " + (m_Info.GetDurationMs() * 0.001f).ToString("F1") + "s");
			GUILayout.Label("Rate: " + m_Info.GetVideoPlaybackRate().ToString("F2") + "Hz");
			if (TextureProducer != null && TextureProducer.GetTexture() != null)
			{
				GUILayout.BeginHorizontal();
				Rect rect = GUILayoutUtility.GetRect(32f, 32f);
				GUILayout.Space(8f);
				Rect rect2 = GUILayoutUtility.GetRect(32f, 32f);
				if (TextureProducer.RequiresVerticalFlip())
				{
					GUIUtility.ScaleAroundPivot(new Vector2(1f, -1f), new Vector2(0f, rect.y + rect.height / 2f));
				}
				GUI.DrawTexture(rect, TextureProducer.GetTexture(), ScaleMode.ScaleToFit, false);
				GUI.DrawTexture(rect2, TextureProducer.GetTexture(), ScaleMode.ScaleToFit, true);
				GUILayout.FlexibleSpace();
				GUILayout.EndHorizontal();
			}
			GUILayout.EndVertical();
		}
	}
}
