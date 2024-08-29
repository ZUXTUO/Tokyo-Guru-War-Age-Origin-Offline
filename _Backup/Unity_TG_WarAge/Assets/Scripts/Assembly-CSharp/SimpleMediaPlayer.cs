using System.Collections.Generic;
using Core.Resource;
using RenderHeads.Media.AVProVideo;
using Script;
using UnityEngine;

public class SimpleMediaPlayer
{
	private class PlayTask
	{
		private string m_fileName = string.Empty;

		private string m_onFinishCallback = string.Empty;

		private string m_onFirstFrameReadyCallback = string.Empty;

		private string m_onFailedCallback = string.Empty;

		private bool m_pauseOnFirstFrameReady;

		private bool m_showSkipBtn = true;

		private string m_skipBtFileName = string.Empty;

		private int m_skipBtnPosX;

		private int m_skipBtnPosY;

		public string FileName
		{
			get
			{
				return m_fileName;
			}
			set
			{
				m_fileName = value;
			}
		}

		public string OnFinishCallback
		{
			get
			{
				return m_onFinishCallback;
			}
			set
			{
				m_onFinishCallback = value;
			}
		}

		public string OnFirstFrameReadyCallback
		{
			get
			{
				return m_onFirstFrameReadyCallback;
			}
			set
			{
				m_onFirstFrameReadyCallback = value;
			}
		}

		public bool PauseOnFirstFrameReady
		{
			get
			{
				return m_pauseOnFirstFrameReady;
			}
			set
			{
				m_pauseOnFirstFrameReady = value;
			}
		}

		public string OnFailedCallback
		{
			get
			{
				return m_onFailedCallback;
			}
			set
			{
				m_onFailedCallback = value;
			}
		}

		public bool ShowSkipBtn
		{
			get
			{
				return m_showSkipBtn;
			}
			set
			{
				m_showSkipBtn = value;
			}
		}

		public string SkipBtFileName
		{
			get
			{
				return m_skipBtFileName;
			}
			set
			{
				m_skipBtFileName = value;
			}
		}

		public int SkipBtnPosX
		{
			get
			{
				return m_skipBtnPosX;
			}
			set
			{
				m_skipBtnPosX = value;
			}
		}

		public int SkipBtnPosY
		{
			get
			{
				return m_skipBtnPosY;
			}
			set
			{
				m_skipBtnPosY = value;
			}
		}
	}

	private static SimpleMediaPlayer __instance;

	private GameObject m_fooHolder;

	private MediaPlayer m_mediaPlayer;

	private MediaPlayer m_standbyMediaPlayer;

	private bool m_standbyMediaPlayerReady;

	private DisplayIMGUI m_displayOnUI;

	private LinkedList<PlayTask> m_playList = new LinkedList<PlayTask>();

	private PlayTask m_curTask;

	private PlayTask m_nextTask;

	private const bool s_mediaPlayerBugFixed = false;

	private int m_lastOnFirstFrameReadyFrame;

	private int m_lastOnFinishFrame;

	public MediaPlayer mediaPlayer
	{
		get
		{
			return m_mediaPlayer;
		}
	}

	public static SimpleMediaPlayer getInstance()
	{
		if (__instance == null)
		{
			__instance = new SimpleMediaPlayer();
		}
		return __instance;
	}

	public void Init()
	{
		if (null == m_fooHolder)
		{
			m_fooHolder = new GameObject("SimpleMediaPlayer");
			Object.DontDestroyOnLoad(m_fooHolder);
			GameObject gameObject = new GameObject("media_player");
			gameObject.AddComponent<MediaPlayer>();
			m_mediaPlayer = gameObject.GetComponent<MediaPlayer>();
			m_mediaPlayer.m_AutoOpen = false;
			m_mediaPlayer.m_AutoStart = false;
			gameObject.gameObject.transform.parent = m_fooHolder.gameObject.transform;
			gameObject = new GameObject("standby_media_player");
			gameObject.AddComponent<MediaPlayer>();
			m_standbyMediaPlayer = gameObject.GetComponent<MediaPlayer>();
			m_standbyMediaPlayer.m_AutoOpen = false;
			m_standbyMediaPlayer.m_AutoStart = false;
			gameObject.gameObject.transform.parent = m_fooHolder.gameObject.transform;
			m_fooHolder.AddComponent<DisplayIMGUI>();
			m_displayOnUI = m_fooHolder.GetComponent<DisplayIMGUI>();
			m_displayOnUI._mediaPlayer = m_mediaPlayer;
			m_displayOnUI._fullScreen = true;
			m_displayOnUI._scaleMode = ScaleMode.ScaleAndCrop;
			m_displayOnUI.enabled = false;
			m_displayOnUI.FrameDataReady4Render = false;
			m_standbyMediaPlayerReady = false;
			m_mediaPlayer.Events.AddListener(OnMediaPlayerEvent);
			m_mediaPlayer.m_Loop = false;
			m_standbyMediaPlayer.Events.AddListener(OnMediaPlayerEvent);
			m_standbyMediaPlayer.m_Loop = false;
		}
	}

	public bool Play(bool playDirectly, string fileName, string onFinishCallback, string onFailedCallback, string onFirstFrameReadyCallback, bool pauseOnFirstFrameReady, bool showSkipBtn, string skipBtFileName, int skipBtnPosX, int SkipBtnPosY)
	{
		PlayTask playTask = new PlayTask();
		playTask.FileName = fileName;
		playTask.OnFinishCallback = onFinishCallback;
		playTask.OnFirstFrameReadyCallback = onFirstFrameReadyCallback;
		playTask.PauseOnFirstFrameReady = pauseOnFirstFrameReady;
		playTask.OnFailedCallback = onFailedCallback;
		playTask.ShowSkipBtn = showSkipBtn;
		playTask.SkipBtFileName = skipBtFileName;
		playTask.SkipBtnPosX = skipBtnPosX;
		playTask.SkipBtnPosY = SkipBtnPosY;
		m_playList.AddLast(playTask);
		if (playDirectly || m_playList.Count == 1)
		{
			m_standbyMediaPlayerReady = false;
			m_standbyMediaPlayer.CloseVideo();
			PlayNext();
		}
		return true;
	}

	private void SwapMediaPlayer()
	{
		MediaPlayer standbyMediaPlayer = m_mediaPlayer;
		m_mediaPlayer = m_standbyMediaPlayer;
		m_standbyMediaPlayer = standbyMediaPlayer;
		m_displayOnUI._mediaPlayer = m_mediaPlayer;
	}

	private void PlayNext()
	{
		if (m_playList.Count == 0)
		{
			return;
		}
		PlayTask value = m_playList.First.Value;
		if (!m_displayOnUI.enabled)
		{
			m_displayOnUI.enabled = true;
		}
		m_displayOnUI.SetSkipBtn(value.ShowSkipBtn, value.SkipBtFileName, value.SkipBtnPosX, value.SkipBtnPosY);
		if (m_standbyMediaPlayerReady)
		{
			SwapMediaPlayer();
			m_standbyMediaPlayerReady = false;
			if (!value.PauseOnFirstFrameReady || value.OnFirstFrameReadyCallback == null || value.OnFirstFrameReadyCallback.Length == 0)
			{
				Resume();
			}
			else
			{
				PreloadNextVideo();
			}
		}
		else
		{
			LoadVideo(value, m_mediaPlayer);
		}
	}

	private bool LoadVideo(PlayTask pt, MediaPlayer mp)
	{
		string wWWReadPath = FileUtil.GetWWWReadPath(pt.FileName);
		MediaPlayer.FileLocation location = MediaPlayer.FileLocation.AbsolutePathOrURL;
		if (!mp.OpenVideoFromFile(location, wWWReadPath))
		{
			Debug.LogWarning("media_player: can't play video " + pt.FileName);
			ScriptManager.GetInstance().CallFunction(pt.OnFailedCallback, pt.FileName);
			return false;
		}
		return true;
	}

	public void Puase()
	{
		if (null != m_mediaPlayer)
		{
			m_mediaPlayer.Pause();
		}
	}

	public void Resume()
	{
		if (null != m_displayOnUI && null != m_mediaPlayer)
		{
			m_displayOnUI.FrameDataReady4Render = true;
			m_mediaPlayer.Play();
		}
	}

	public void Close()
	{
		OnFinishPlay();
	}

	public void OnMediaPlayerEvent(MediaPlayer mp, MediaPlayerEvent.EventType et, ErrorCode errorCode)
	{
		Debug.Log(string.Format("media_player mp:{0}, event: {1}, code: {2}, frame:{3}", mp.GetHashCode(), et, errorCode, App3.GetCurtFrame()));
		switch (et)
		{
		case MediaPlayerEvent.EventType.ReadyToPlay:
			break;
		case MediaPlayerEvent.EventType.Started:
			break;
		case MediaPlayerEvent.EventType.FirstFrameReady:
			OnFirstFrameReady(mp);
			break;
		case MediaPlayerEvent.EventType.MetaDataReady:
			break;
		case MediaPlayerEvent.EventType.FinishedPlaying:
			OnFinishPlay();
			break;
		}
	}

	private void PreloadNextVideo()
	{
		if (m_playList.Count >= 2)
		{
			PlayTask value = m_playList.First.Next.Value;
			LoadVideo(value, m_standbyMediaPlayer);
		}
	}

	public void OnFirstFrameReady(MediaPlayer mp)
	{
		if (m_lastOnFirstFrameReadyFrame == App3.GetCurtFrame())
		{
			return;
		}
		m_lastOnFirstFrameReadyFrame = App3.GetCurtFrame();
		if (m_playList.Count == 0)
		{
			return;
		}
		m_displayOnUI.FrameDataReady4Render = true;
		if (mp == m_standbyMediaPlayer)
		{
			m_standbyMediaPlayerReady = true;
			m_standbyMediaPlayer.Pause();
			return;
		}
		PlayTask value = m_playList.First.Value;
		PreloadNextVideo();
		bool flag = value.OnFirstFrameReadyCallback != null && value.OnFirstFrameReadyCallback.Length > 0;
		if (value.PauseOnFirstFrameReady && flag)
		{
			m_mediaPlayer.Pause();
		}
		else
		{
			m_displayOnUI.FrameDataReady4Render = true;
		}
		if (flag)
		{
			ScriptManager.GetInstance().CallFunction(value.OnFirstFrameReadyCallback, value.FileName);
		}
	}

	public void OnFinishPlay()
	{
		if (m_lastOnFinishFrame != App3.GetCurtFrame())
		{
			m_lastOnFinishFrame = App3.GetCurtFrame();
			PlayTask value = m_playList.First.Value;
			m_playList.RemoveFirst();
			m_mediaPlayer.CloseVideo();
			m_displayOnUI.FrameDataReady4Render = false;
			PlayNext();
			if (value.OnFinishCallback != null && value.OnFinishCallback.Length > 0)
			{
				ScriptManager.GetInstance().CallFunction(value.OnFinishCallback, value.FileName);
			}
		}
	}

	public void Destory()
	{
		if (null != m_fooHolder)
		{
			Object.Destroy(m_fooHolder);
			m_fooHolder = null;
		}
	}
}
