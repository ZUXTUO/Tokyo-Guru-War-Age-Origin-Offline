using System.Collections;
using Core.Resource;
using UnityEngine;

namespace RenderHeads.Media.AVProVideo
{
	[AddComponentMenu("AVPro Video/Display IMGUI")]
	[ExecuteInEditMode]
	public class DisplayIMGUI : MonoBehaviour
	{
		private bool m_frameDataReady4Render;

		public MediaPlayer _mediaPlayer;

		public bool _displayInEditor = true;

		public ScaleMode _scaleMode = ScaleMode.ScaleToFit;

		public Color _color = Color.white;

		public bool _alphaBlend;

		public bool _fullScreen = true;

		public int _depth;

		public float _x;

		public float _y;

		public float _width = 1f;

		public float _height = 1f;

		public bool m_showSkipBtn;

		public string m_skipBtFileName;

		public Texture2D m_skipButtonTexture;

		public Texture2D m_skipButtonTexture_verticalFlip;

		public Rect m_skipButtonPos = default(Rect);

		public Rect m_skipButtonPos_verticalFlip = default(Rect);

		private bool m_activeSkipBtn;

		private GUIStyle style;

		private GUIStyleState style_state;

		public bool FrameDataReady4Render
		{
			get
			{
				return m_frameDataReady4Render;
			}
			set
			{
				m_frameDataReady4Render = value;
			}
		}

		public bool renderOnUI
		{
			get
			{
				return m_frameDataReady4Render;
			}
			set
			{
				m_frameDataReady4Render = value;
			}
		}

		public void Start()
		{
			m_skipButtonPos.Set(20f, 20f, 50f, 50f);
			m_skipButtonPos_verticalFlip.Set(Screen.width - 20, Screen.height - 20 - 50, 50f, 50f);
		}

		private void OnLoadSkipBtnCallBack(string filePath, bool loadByWWW, WWW www, AssetBundle bundle, string err_msg)
		{
			if (err_msg != null && err_msg.Length != 0)
			{
				Debug.LogError("failed to load file:" + filePath + www.error);
				return;
			}
			AssetBundle assetBundle = bundle;
			if (loadByWWW)
			{
				assetBundle = www.assetBundle;
			}
			m_skipButtonTexture = assetBundle.mainAsset as Texture2D;
			m_skipButtonPos.width = m_skipButtonTexture.width;
			m_skipButtonPos.height = m_skipButtonTexture.height;
			m_skipButtonPos.x = (float)Screen.width - m_skipButtonPos.width - 20f;
			m_skipButtonPos.y = 0f;
			m_skipButtonPos_verticalFlip.width = m_skipButtonPos.width;
			m_skipButtonPos_verticalFlip.height = m_skipButtonPos.height;
			m_skipButtonPos_verticalFlip.x = m_skipButtonPos.x;
			m_skipButtonPos_verticalFlip.y = (float)Screen.height - m_skipButtonPos.y - m_skipButtonPos.height;
			int width = m_skipButtonTexture.width;
			int height = m_skipButtonTexture.height;
			m_skipButtonTexture_verticalFlip = new Texture2D(width, height);
			for (int i = 0; i < height; i++)
			{
				m_skipButtonTexture_verticalFlip.SetPixels(0, i, width, 1, m_skipButtonTexture.GetPixels(0, height - i - 1, width, 1));
			}
			m_skipButtonTexture_verticalFlip.Apply();
			assetBundle.Unload(false);
			if (www != null)
			{
				www.Dispose();
			}
		}

		public void SetSkipBtn(bool showSkipBtn, string imageFileName, int posX, int posY)
		{
			m_showSkipBtn = showSkipBtn;
			m_activeSkipBtn = false;
			if (m_showSkipBtn)
			{
				m_skipButtonPos.Set(posX, posY, 40f, 20f);
				if (imageFileName != null && imageFileName.Length > 0)
				{
					AssetBundleLoader.GetInstance().Load(imageFileName, OnLoadSkipBtnCallBack);
				}
			}
		}

		private IEnumerator LoadSkipBtnImage(string fileName)
		{
			if (fileName != null && fileName.Length > 0)
			{
				string path = FileUtil.GetWWWReadPath(fileName);
				WWW www = new WWW(path);
				while (!www.isDone)
				{
					yield return www;
				}
				if (www.error == null)
				{
					m_skipButtonTexture = www.assetBundle.mainAsset as Texture2D;
					m_skipButtonPos.width = m_skipButtonTexture.width;
					m_skipButtonPos.height = m_skipButtonTexture.height;
					m_skipButtonPos.x = (float)Screen.width - m_skipButtonPos.width - 20f;
					m_skipButtonPos.y = 20f;
					www.assetBundle.Unload(false);
				}
				else
				{
					Debug.LogError("failed to load file:" + fileName + www.error);
				}
			}
		}

		public void OnGUI()
		{
			if (!m_frameDataReady4Render || _mediaPlayer == null || !_displayInEditor)
			{
				return;
			}
			bool flag = false;
			if (_mediaPlayer.Info != null && !_mediaPlayer.Info.HasVideo())
			{
				return;
			}
			Texture texture = null;
			if (_mediaPlayer.TextureProducer != null && _mediaPlayer.TextureProducer.GetTexture() != null)
			{
				texture = _mediaPlayer.TextureProducer.GetTexture();
				flag = _mediaPlayer.TextureProducer.RequiresVerticalFlip();
			}
			if (texture == null)
			{
				return;
			}
			if (!_alphaBlend || _color.a > 0f)
			{
				GUI.depth = _depth;
				GUI.color = _color;
				Rect rect = GetRect();
				if (flag)
				{
					GUIUtility.ScaleAroundPivot(new Vector2(1f, -1f), new Vector2(0f, rect.y + rect.height / 2f));
				}
				GUI.DrawTexture(rect, texture, _scaleMode, _alphaBlend);
			}
			if (!m_showSkipBtn)
			{
				return;
			}
			if (!m_activeSkipBtn && Input.GetMouseButtonUp(0))
			{
				m_activeSkipBtn = true;
			}
			if (!m_activeSkipBtn)
			{
				return;
			}
			bool flag2 = false;
			Texture2D texture2D = null;
			Rect skipButtonPos = m_skipButtonPos;
			if (flag)
			{
				texture2D = m_skipButtonTexture_verticalFlip;
				skipButtonPos = m_skipButtonPos_verticalFlip;
			}
			else
			{
				texture2D = m_skipButtonTexture;
				skipButtonPos = m_skipButtonPos;
			}
			if ((bool)texture2D)
			{
				if (style == null)
				{
					style = new GUIStyle();
					style_state = new GUIStyleState
					{
						background = texture2D
					};
					style.normal = style_state;
					style.active = style_state;
				}
				if (GUI.Button(skipButtonPos, string.Empty, style))
				{
					flag2 = true;
				}
			}
			else if (GUI.Button(skipButtonPos, "Skip"))
			{
				flag2 = true;
			}
			if (flag2)
			{
				base.enabled = false;
				SimpleMediaPlayer.getInstance().Close();
			}
		}

		public Rect GetRect()
		{
			return (!_fullScreen) ? new Rect(_x * (float)(Screen.width - 1), _y * (float)(Screen.height - 1), _width * (float)Screen.width, _height * (float)Screen.height) : new Rect(0f, 0f, Screen.width, Screen.height);
		}
	}
}
