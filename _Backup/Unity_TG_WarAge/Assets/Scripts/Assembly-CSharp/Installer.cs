using System.IO;
using System.Text;
using Script;
using UnityEngine;

internal class Installer
{
	private static Installer m_instance;

	private bool hasInit;

	private HttpDownload m_download;

	private string m_downProgressCallback;

	private string m_downResultCallback;

	private string m_fileName;

	private MemoryStream m_downLoadContent;

	private static AndroidJavaClass m_installerHolder;

	public static Installer Instance()
	{
		if (m_instance == null)
		{
			m_instance = new Installer();
			m_instance.Init();
		}
		return m_instance;
	}

	public void Init()
	{
		if (!hasInit)
		{
			hasInit = true;
			instance_installer();
			string name = "_AndroidMsgReceiver";
			GameObject gameObject = GameObject.Find(name);
			if (gameObject == null)
			{
				gameObject = new GameObject("_AndroidMsgReceiver");
				gameObject.AddComponent<AndroidMessageDispatch>();
				Object.DontDestroyOnLoad(gameObject);
			}
		}
	}

	public void UnInit()
	{
	}

	private static void instance_installer()
	{
		if (m_installerHolder == null)
		{
			m_installerHolder = new AndroidJavaClass("com.digitalsky.ghoul.installer.InstallerInterface");
		}
	}

	public int StartInstaller(string path)
	{
		int num = 0;
		return m_installerHolder.CallStatic<int>("startInstaller", new object[1] { path });
	}

	public void AndroidLog(string path)
	{
		m_installerHolder.CallStatic("log", path);
	}

	public int GetVersionCode()
	{
		int num = 0;
		return m_installerHolder.CallStatic<int>("getVersionCode", new object[0]);
	}

	public string GetPackageName()
	{
		string empty = string.Empty;
		return m_installerHolder.CallStatic<string>("getPackageName", new object[0]);
	}

	public int GetSignatureHashCode()
	{
		int num = 0;
		return m_installerHolder.CallStatic<int>("getSignatureHashCode", new object[0]);
	}

	public void DownLoadFile(string url, string saveFile, string progressCallback, string retCallback)
	{
		m_downLoadContent = null;
		m_downProgressCallback = progressCallback;
		m_downResultCallback = retCallback;
		if (saveFile == null || saveFile.Equals(string.Empty))
		{
			m_downLoadContent = new MemoryStream();
			m_download = new HttpDownload(m_downLoadContent, url);
		}
		else
		{
			m_fileName = saveFile;
			m_download = new HttpDownload(saveFile, url);
		}
		m_download.SetCallback(SetProgressValue, DownloadResult);
		m_download.Start();
	}

	public void SetProgressValue(long downloadSize, long totalSize, long speed)
	{
		if (m_downProgressCallback != null && !m_downProgressCallback.Equals(string.Empty))
		{
			ScriptManager.GetInstance().CallFunction(m_downProgressCallback, downloadSize, totalSize, speed);
		}
	}

	public void DownloadResult(EDOWNLOADRESULT v)
	{
		if (m_downResultCallback != null && !m_downResultCallback.Equals(string.Empty))
		{
			string empty = string.Empty;
			empty = ((m_downLoadContent == null) ? m_fileName : Encoding.Default.GetString(m_downLoadContent.ToArray()));
			ScriptManager.GetInstance().CallFunction(m_downResultCallback, (int)v, empty);
		}
	}
}
