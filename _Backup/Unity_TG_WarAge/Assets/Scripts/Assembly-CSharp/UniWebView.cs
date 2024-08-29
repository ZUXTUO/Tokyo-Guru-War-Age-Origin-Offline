using System;
using System.Collections;
using Script;
using UnityEngine;

public class UniWebView : MonoBehaviour
{
	public delegate void LoadCompleteDelegate(UniWebView webView, bool success, string errorMessage);

	public delegate void LoadBeginDelegate(UniWebView webView, string loadingUrl);

	public delegate void ReceivedMessageDelegate(UniWebView webView, UniWebViewMessage message);

	public delegate void EvalJavaScriptFinishedDelegate(UniWebView webView, string result);

	public delegate bool WebViewShouldCloseDelegate(UniWebView webView);

	public delegate void ReceivedKeyCodeDelegate(UniWebView webView, int keyCode);

	public delegate UniWebViewEdgeInsets InsetsForScreenOreitationDelegate(UniWebView webView, UniWebViewOrientation orientation);

	public delegate void OnUniWebViewCloseDelegate(UniWebView webView);

	[SerializeField]
	private UniWebViewEdgeInsets _insets = new UniWebViewEdgeInsets(0, 0, 0, 0);

	public string OnApplicationPauseLuaString = string.Empty;

	public string OnReceivedKeyCodeLuaString = string.Empty;

	public string url;

	public bool loadOnStart;

	public bool autoShowWhenLoadComplete;

	private bool _backButtonEnable = true;

	private bool _bouncesEnable;

	private bool _zoomEnable;

	private string _currentGUID;

	private int _lastScreenHeight;

	public bool toolBarShow;

	public UniWebViewEdgeInsets insets
	{
		get
		{
			return _insets;
		}
		set
		{
			if (_insets != value)
			{
				ForceUpdateInsetsInternal(value);
			}
		}
	}

	public string currentUrl
	{
		get
		{
			return UniWebViewPlugin.GetCurrentUrl(base.gameObject.name);
		}
	}

	public bool backButtonEnable
	{
		get
		{
			return _backButtonEnable;
		}
		set
		{
			if (_backButtonEnable != value)
			{
				_backButtonEnable = value;
				UniWebViewPlugin.SetBackButtonEnable(base.gameObject.name, _backButtonEnable);
			}
		}
	}

	public bool bouncesEnable
	{
		get
		{
			return _bouncesEnable;
		}
		set
		{
			if (_bouncesEnable != value)
			{
				_bouncesEnable = value;
				UniWebViewPlugin.SetBounces(base.gameObject.name, _bouncesEnable);
			}
		}
	}

	public bool zoomEnable
	{
		get
		{
			return _zoomEnable;
		}
		set
		{
			if (_zoomEnable != value)
			{
				_zoomEnable = value;
				UniWebViewPlugin.SetZoomEnable(base.gameObject.name, _zoomEnable);
			}
		}
	}

	public string userAgent
	{
		get
		{
			return UniWebViewPlugin.GetUserAgent(base.gameObject.name);
		}
	}

	public event LoadCompleteDelegate OnLoadComplete;

	public event LoadBeginDelegate OnLoadBegin;

	public event ReceivedMessageDelegate OnReceivedMessage;

	public event EvalJavaScriptFinishedDelegate OnEvalJavaScriptFinished;

	public event WebViewShouldCloseDelegate OnWebViewShouldClose;

	public event ReceivedKeyCodeDelegate OnReceivedKeyCode;

	public event InsetsForScreenOreitationDelegate InsetsForScreenOreitation;

	public event OnUniWebViewCloseDelegate OnUniWebViewClose;

	private void ForceUpdateInsetsInternal(UniWebViewEdgeInsets insets)
	{
		_insets = insets;
		UniWebViewPlugin.ChangeSize(base.gameObject.name, this.insets.top, this.insets.left, this.insets.bottom, this.insets.right);
	}

	public static void SetUserAgent(string value)
	{
		UniWebViewPlugin.SetUserAgent(value);
	}

	public static void ResetUserAgent()
	{
		UniWebViewPlugin.SetUserAgent(null);
	}

	public void Load()
	{
		string text = ((!string.IsNullOrEmpty(url)) ? url.Trim() : "about:blank");
		UniWebViewPlugin.Load(base.gameObject.name, text);
	}

	public void Load(string aUrl)
	{
		url = aUrl;
		Load();
	}

	public void LoadHTMLString(string htmlString, string baseUrl)
	{
		UniWebViewPlugin.LoadHTMLString(base.gameObject.name, htmlString, baseUrl);
	}

	public void Reload()
	{
		UniWebViewPlugin.Reload(base.gameObject.name);
	}

	public void Stop()
	{
		UniWebViewPlugin.Stop(base.gameObject.name);
	}

	public void Show()
	{
		_lastScreenHeight = UniWebViewHelper.screenHeight;
		ResizeInternal();
		UniWebViewPlugin.Show(base.gameObject.name);
	}

	public void EvaluatingJavaScript(string javaScript)
	{
		UniWebViewPlugin.EvaluatingJavaScript(base.gameObject.name, javaScript);
	}

	public void AddJavaScript(string javaScript)
	{
		UniWebViewPlugin.AddJavaScript(base.gameObject.name, javaScript);
	}

	public void Hide()
	{
		UniWebViewPlugin.Dismiss(base.gameObject.name);
	}

	public void CleanCache()
	{
		UniWebViewPlugin.CleanCache(base.gameObject.name);
	}

	public void CleanCookie(string key = null)
	{
		UniWebViewPlugin.CleanCookie(base.gameObject.name, key);
	}

	public void SetTransparentBackground(bool transparent = true)
	{
		UniWebViewPlugin.TransparentBackground(base.gameObject.name, transparent);
	}

	public void ShowToolBar(bool animate)
	{
	}

	public void HideToolBar(bool animate)
	{
	}

	public void SetShowSpinnerWhenLoading(bool show)
	{
		UniWebViewPlugin.SetSpinnerShowWhenLoading(base.gameObject.name, show);
	}

	public void SetSpinnerLabelText(string text)
	{
		UniWebViewPlugin.SetSpinnerText(base.gameObject.name, text);
	}

	public void SetUseWideViewPort(bool use)
	{
		UniWebViewPlugin.SetUseWideViewPort(base.gameObject.name, use);
	}

	public void GoBack()
	{
		UniWebViewPlugin.GoBack(base.gameObject.name);
	}

	public void GoForward()
	{
		UniWebViewPlugin.GoForward(base.gameObject.name);
	}

	public void AddUrlScheme(string scheme)
	{
		UniWebViewPlugin.AddUrlScheme(base.gameObject.name, scheme);
	}

	public void RemoveUrlScheme(string scheme)
	{
		UniWebViewPlugin.RemoveUrlScheme(base.gameObject.name, scheme);
	}

	private bool OrientationChanged()
	{
		int screenHeight = UniWebViewHelper.screenHeight;
		if (_lastScreenHeight != screenHeight)
		{
			_lastScreenHeight = screenHeight;
			return true;
		}
		return false;
	}

	private void ResizeInternal()
	{
		int screenHeight = UniWebViewHelper.screenHeight;
		int screenWidth = UniWebViewHelper.screenWidth;
		UniWebViewEdgeInsets uniWebViewEdgeInsets = insets;
		if (this.InsetsForScreenOreitation != null)
		{
			UniWebViewOrientation orientation = ((screenHeight < screenWidth) ? UniWebViewOrientation.LandScape : UniWebViewOrientation.Portrait);
			uniWebViewEdgeInsets = this.InsetsForScreenOreitation(this, orientation);
		}
		ForceUpdateInsetsInternal(uniWebViewEdgeInsets);
	}

	private void LoadComplete(string message)
	{
		bool flag = string.Equals(message, string.Empty);
		bool flag2 = this.OnLoadComplete != null;
		if (flag)
		{
			if (flag2)
			{
				this.OnLoadComplete(this, true, null);
			}
			if (autoShowWhenLoadComplete)
			{
				Show();
			}
			return;
		}
		Debug.LogWarning("Web page load failed: " + base.gameObject.name + "; url: " + url + "; error:" + message);
		if (flag2)
		{
			this.OnLoadComplete(this, false, message);
		}
	}

	private void LoadBegin(string url)
	{
		Debug.Log("Begin to load: " + url);
		if (this.OnLoadBegin != null)
		{
			this.OnLoadBegin(this, url);
		}
	}

	private void ReceivedMessage(string rawMessage)
	{
		UniWebViewMessage message = new UniWebViewMessage(rawMessage);
		if (this.OnReceivedMessage != null)
		{
			this.OnReceivedMessage(this, message);
		}
	}

	private void WebViewDone(string message)
	{
		bool flag = true;
		if (this.OnWebViewShouldClose != null)
		{
			flag = this.OnWebViewShouldClose(this);
		}
		if (flag)
		{
			Hide();
			UnityEngine.Object.Destroy(this);
		}
	}

	private void WebViewKeyDown(string message)
	{
		int keyCode = Convert.ToInt32(message);
		if (this.OnReceivedKeyCode != null)
		{
			this.OnReceivedKeyCode(this, keyCode);
		}
	}

	private void EvalJavaScriptFinished(string result)
	{
		if (this.OnEvalJavaScriptFinished != null)
		{
			this.OnEvalJavaScriptFinished(this, result);
		}
	}

	private IEnumerator LoadFromJarPackage(string jarFilePath)
	{
		WWW stream = new WWW(jarFilePath);
		yield return stream;
		if (stream.error != null)
		{
			if (this.OnLoadComplete != null)
			{
				this.OnLoadComplete(this, false, stream.error);
			}
		}
		else
		{
			LoadHTMLString(stream.text, string.Empty);
		}
	}

	private void Awake()
	{
		_currentGUID = Guid.NewGuid().ToString();
		base.gameObject.name = base.gameObject.name + _currentGUID;
		UniWebViewPlugin.Init(base.gameObject.name, insets.top, insets.left, insets.bottom, insets.right);
		_lastScreenHeight = UniWebViewHelper.screenHeight;
	}

	private void Start()
	{
		if (loadOnStart)
		{
			Load();
		}
	}

	private void OnDestroy()
	{
		UniWebViewPlugin.Destroy(base.gameObject.name);
		base.gameObject.name = base.gameObject.name.Replace(_currentGUID, string.Empty);
	}

	private void Update()
	{
		if (OrientationChanged())
		{
			ResizeInternal();
		}
	}

	private void OnApplicationPause(bool pause)
	{
		if (pause)
		{
			ScriptCall scriptCall = ScriptCall.Create(OnApplicationPauseLuaString);
			if (scriptCall.Start())
			{
				scriptCall.Finish(0);
			}
		}
	}
}
