using System.IO;
using LuaInterface;
using Script;
using UnityEngine;

public class SimpleHttpManager
{
	private int m_workerSerNum;

	private static SimpleHttpManager m_instance;

	private bool hasInit;

	private HttpClientHelper m_httpWorker;

	private string m_onProgressCallback;

	private string m_onErrorCallback;

	private string m_onSuccCallback;

	private string m_onRedirectCallback;

	private string m_fileName;

	private MemoryStream m_downLoadContent;

	private GameObject m_loopCheckHelper;

	public static SimpleHttpManager GetInstance()
	{
		if (m_instance == null)
		{
			m_instance = new SimpleHttpManager();
			m_instance.InitOnce();
		}
		return m_instance;
	}

	public void InitOnce()
	{
		m_loopCheckHelper = new GameObject("__SimpleHttpManagerLoopHelper__");
		LoopCheckHelper loopCheckHelper = m_loopCheckHelper.AddComponent<LoopCheckHelper>();
		loopCheckHelper.SetTarget(this);
		Object.DontDestroyOnLoad(m_loopCheckHelper);
		m_loopCheckHelper.SetActive(false);
	}

	public bool DownLoadFile(string url, string saveFile, string progressCallback, string succCallback, string errorCallBack, string redirectCallback)
	{
		bool result = m_httpWorker != null;
		m_downLoadContent = null;
		m_onProgressCallback = progressCallback;
		m_onSuccCallback = succCallback;
		m_onErrorCallback = errorCallBack;
		m_onRedirectCallback = redirectCallback;
		m_fileName = saveFile;
		m_httpWorker = new HttpClientHelper(saveFile, url, ++m_workerSerNum);
		m_loopCheckHelper.SetActive(true);
		m_httpWorker.SetCallback(OnProgress, OnError, OnSucc, OnReidrect);
		m_httpWorker.Start();
		return result;
	}

	public void OnProgress(string url, string filePath, long size, long totalSize)
	{
		if (m_onProgressCallback != null)
		{
			ScriptCall scriptCall = ScriptCall.Create(m_onProgressCallback);
			if (scriptCall != null && scriptCall.Start())
			{
				LuaDLL.lua_newtable(scriptCall.L);
				scriptCall.lua_settable("url", url);
				scriptCall.lua_settable("path", filePath);
				scriptCall.lua_settable("down", size);
				scriptCall.lua_settable("current", size);
				scriptCall.lua_settable("total", totalSize);
				scriptCall.Finish(1);
			}
		}
	}

	public void OnError(string url, string filePath, int code, string msg)
	{
		m_httpWorker = null;
		m_loopCheckHelper.SetActive(false);
		if (m_onErrorCallback != null)
		{
			ScriptCall scriptCall = ScriptCall.Create(m_onErrorCallback);
			if (scriptCall != null && scriptCall.Start())
			{
				LuaDLL.lua_newtable(scriptCall.L);
				scriptCall.lua_settable("url", url);
				scriptCall.lua_settable("path", filePath);
				scriptCall.lua_settable("err_code", code);
				scriptCall.lua_settable("err_str", msg);
				scriptCall.Finish(1);
			}
		}
	}

	public void OnSucc(string url, string filePath, int size, string md5)
	{
		m_httpWorker = null;
		m_loopCheckHelper.SetActive(false);
		ScriptCall scriptCall = ScriptCall.Create(m_onSuccCallback);
		if (scriptCall != null && scriptCall.Start())
		{
			LuaDLL.lua_newtable(scriptCall.L);
			scriptCall.lua_settable("path", filePath);
			scriptCall.lua_settable("fsize", size);
			scriptCall.lua_settable("md5", md5);
			scriptCall.lua_settable("result", "true");
			scriptCall.Finish(1);
		}
	}

	public void OnReidrect(string url, string filePath, string newUrl, int code, string msg)
	{
		m_httpWorker = null;
		m_loopCheckHelper.SetActive(false);
		ScriptCall scriptCall = ScriptCall.Create(m_onRedirectCallback);
		if (scriptCall != null && scriptCall.Start())
		{
			LuaDLL.lua_newtable(scriptCall.L);
			scriptCall.lua_settable("url", url);
			scriptCall.lua_settable("path", filePath);
			scriptCall.lua_settable("new_url", newUrl);
			scriptCall.lua_settable("err_code", code);
			scriptCall.lua_settable("err_str", msg);
			scriptCall.Finish(1);
		}
	}

	public void Update()
	{
		if (m_httpWorker != null)
		{
			m_httpWorker.Update();
		}
	}
}
