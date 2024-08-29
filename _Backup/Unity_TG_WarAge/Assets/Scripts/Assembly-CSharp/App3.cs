using System;
using System.Collections;
using System.Collections.Generic;
using System.Reflection;
using System.Threading;
using Core.Resource;
using Core.Timer;
using Core.Unity;
using LuaInterface;
using SHttp;
using SNet;
using SUpdate.Logic;
using Script;
using UnityEngine;
using UnityWrap;
using Wraper;

public class App3 : MonoBehaviourEx
{
	private static int s_frameCounter = 0;

	private static string go_name = "_app3";

	private static App3 instance = null;

	private static GameObject screencapture_object = null;

	private static ScreenCapture screencapture_instance = null;

	private static string lua_version = string.Empty;

	private int max_disk_space;

	private static List<string> asst_path_shareof = new List<string>();

	private static GameObject res_object_pool = null;

	private bool enableNet = true;

	private HashSet<string> net_cache_ignore_msg = new HashSet<string>();

	private string m_application_pause_call = string.Empty;

	private string m_application_pause_loop_call = string.Empty;

	private int m_pause_loop_timeout = 30;

	private int m_temp_count;

	private Thread m_BackgroundThead;

	private bool m_BackgroundThead_close;

	private float m_timeScale;

	public static bool on_pause = false;

	public static double fps;

	private int frames;

	private double lastInterval;

	private string path_grap = string.Empty;

	private ScriptManager scriptMgr;

	private LuaVM luavm;

	public string onUpdate;

	public string onFixedUpdate;

	public string onLateUpdate;

	public float gcInterval = 0.2f;

	public int gcStep = 200;

	private float prev_gc_time;

	private bool resetFlag;

	private int onBackgroundReceiveCount;

	private bool applicationPause;

	private UnityEngine.Object[] ShaderObjs;

	private Dictionary<string, Shader> ShaderList;

	private AssetBundle shaderAssetBundle;

	private static string[] WarmupShaderList = new string[29]
	{
		"DyShader/TokyoGhoul/GhoulAfterScreenEffect",
		"DyShader/TokyoGhoul/Scene/WaterWaveDistortion",
		"AA/FXAA Preset 2",
		"AA/FXAA Preset 3",
		"AA/FXAA II",
		"AA/FXAA III (Console)",
		"AA/NFAA",
		"AA/SSAA",
		"AA/DLAA",
		"DyShader/TokyoGhoul/ShockWaveDistortion",
		"Particles/Additive_PanelClip",
		string.Empty,
		string.Empty,
		"Unlit/Transparent Colored",
		"Unlit/Transparent Line",
		"Unlit/Transparent Cutout",
		"CGwell FX/Mask Additive",
		"D3/Effect/Additive",
		"cgwell/Alpha Blended",
		"Unlit/Transparent UV Mask 2Tex",
		"Particles/Additive_Layer",
		"DyShader/BlurOnly",
		"DyShader/TokyoGhoul/Scene/WaterWaveSurface",
		"DyShader/TokyoGhoul/DiffCol",
		"AngryBots/RealtimeReflectionInWaterFlow_Light",
		"FS_ShadowShader/UnlitAlphaBlend",
		"DyShader/MiniMap/Icon",
		"DyShader/MiniMap/Mask",
		"DyShader/MiniMap/Mask"
	};

	private bool ApplicationPause
	{
		get
		{
			return applicationPause;
		}
	}

	public static App3 GetInstance()
	{
		if (instance == null)
		{
			GameObject gameObject = new GameObject("_gos");
			UnityEngine.Object.DontDestroyOnLoad(gameObject);
			MonoBehaviourEx.parentTransform = gameObject.transform;
			gameObject = MonoBehaviourEx.CreateGameObject(go_name);
			instance = gameObject.AddComponent<App3>();
		}
		if (res_object_pool == null)
		{
			GameObject gameObject2 = new GameObject("res_object_pool");
			res_object_pool = gameObject2;
			UnityEngine.Object.DontDestroyOnLoad(res_object_pool);
		}
		return instance;
	}

	public static ScreenCapture GetScreedCaptureInstance()
	{
		if (screencapture_object == null)
		{
			GameObject gameObject = new GameObject("screencapture_object");
			screencapture_object = gameObject;
			UnityEngine.Object.DontDestroyOnLoad(screencapture_object);
			screencapture_instance = screencapture_object.AddComponent<ScreenCapture>();
		}
		return screencapture_instance;
	}

	public static int GetCurtFrame()
	{
		return s_frameCounter;
	}

	public void SetGCStep(int step)
	{
		gcStep = step;
	}

	public void OnLog(string condition, string stackTrace, LogType type)
	{
		string text = string.Format("condition:{0}\n, stackTrace:{1}\n", condition, stackTrace);
		switch (type)
		{
		case LogType.Error:
			Core.Unity.Debug.LogError(text);
			break;
		case LogType.Exception:
			Core.Unity.Debug.LogError(text);
			break;
		case LogType.Warning:
			Core.Unity.Debug.LogWarning(text);
			break;
		}
	}

	private IEnumerator LoadShader()
	{
		//string filePath = FileUtil.GetWWWReadPath("assetbundles/prefabs/shader.assetbundle");
		string filePath = "file:///" + PathManager.streamingAssetsPath() + "assetbundles/prefabs/shader.assetbundle";
		UnityEngine.Debug.Log(filePath);
		WWW www = new WWW(filePath);
		while (!www.isDone)
		{
			yield return www;
		}
		if (string.IsNullOrEmpty(www.error))
		{
			ShaderObjs = www.assetBundle.LoadAllAssets();
			ShaderList = new Dictionary<string, Shader>();
			for (int i = 0; i < ShaderObjs.Length; i++)
			{
				if (ShaderObjs[i].GetType() == typeof(Shader) && !ShaderList.ContainsKey(ShaderObjs[i].name))
				{
					ShaderList.Add(ShaderObjs[i].name, ShaderObjs[i] as Shader);
				}
			}
			for (int j = 0; j < WarmupShaderList.Length; j++)
			{
				if (!ShaderList.ContainsKey(WarmupShaderList[j]))
				{
					Shader shader = Shader.Find(WarmupShaderList[j]);
					if (shader != null)
					{
						ShaderList.Add(shader.name, shader);
					}
				}
			}
		}
		else
		{
			UnityEngine.Debug.Log("Load Shader Failed " + www.error);
		}
		shaderAssetBundle = www.assetBundle;
		www.Dispose();
		_RunScript();
	}

	public Shader FindShader(string name)
	{
		if (ShaderList == null)
		{
			return null;
		}
		if (ShaderList.ContainsKey(name))
		{
			return ShaderList[name];
		}
		Shader shader = Shader.Find(name);
		if (shader != null)
		{
			ShaderList.Add(name, shader);
		}
		return shader;
	}

	public void HotUpdateReloadShader()
	{
		if (shaderAssetBundle != null)
		{
			shaderAssetBundle.Unload(true);
		}
		StartCoroutine(ReLoadShader());
	}

	private IEnumerator ReLoadShader()
	{
		string filePath = FileUtil.GetWWWReadPath("assetbundles/prefabs/shader.assetbundle");
		WWW www = new WWW(filePath);
		while (!www.isDone)
		{
			yield return www;
		}
		if (string.IsNullOrEmpty(www.error))
		{
			ShaderObjs = www.assetBundle.LoadAllAssets();
			ShaderList = new Dictionary<string, Shader>();
			for (int i = 0; i < ShaderObjs.Length; i++)
			{
				if (ShaderObjs[i].GetType() == typeof(Shader) && !ShaderList.ContainsKey(ShaderObjs[i].name))
				{
					ShaderList.Add(ShaderObjs[i].name, ShaderObjs[i] as Shader);
				}
			}
		}
		else
		{
			UnityEngine.Debug.Log("Load Shader Failed " + www.error);
		}
		shaderAssetBundle = www.assetBundle;
		www.Dispose();
	}

	public void Run()
	{
		Application.logMessageReceived += OnLog;
		if (InitScript())
		{
			Core.Unity.Debug.GetInstance();
			FileUtil.SetReadOnlyDirectory(Application.streamingAssetsPath + "/");
			FileUtil.SetWriteDirectory(Application.persistentDataPath + "/");
			if (FileUtil.FileExist("gray.txt", FileUtil.DirectoryType.WritePath))
			{
				path_grap = "gray/";
			}
			else
			{
				path_grap = string.Empty;
			}
			FileUtil.InitAndroidFileSet();
			TouchManager.GetInstance();
			TimerManager.GetInstance();
			NModuleManager.GetInstance().Pprocess = net_process.GetInstance();
			AssetBundleLoader.GetInstance();
			HttpRequestManager.GetInstance();
			GhoulAfterEffectsConsole.GetInstance();
			GhoulAfterEffects.GetInstance();
			lastInterval = Time.realtimeSinceStartup;
			StartCoroutine(LoadShader());
		}
	}

	public string GetGrayPath()
	{
		return path_grap;
	}

	private void _RunScript()
	{
		if (FileUtil.FileExist("logic/e.lc", FileUtil.DirectoryType.ReadPath))
		{
			StartRun("logic/e.lc");
		}
		else
		{
			StartRun("logic/e.lua");
		}
		ScriptManager.GetInstance().InitErrorFunc();
	}

	private void StartRun(string filepath)
	{
		ScriptManager.GetInstance().Run(filepath);
	}

	public void Quit()
	{
		CloseBackgroundThead();
		Application.Quit();
	}

	public void Set_Max_Disk_Space(int num)
	{
		if (num > 0)
		{
			max_disk_space = num;
			Caching.maximumAvailableDiskSpace = 1048576 * max_disk_space;
		}
	}

	public void Set_Lua_Version(string ver)
	{
		lua_version = ver;
	}

	public string Get_Lua_Version()
	{
		return lua_version;
	}

	public void Set_asst_path_shareof(string str_path)
	{
		asst_path_shareof.Clear();
		bool flag = true;
		int num = 0;
		do
		{
			num++;
			if (num > 100)
			{
				asst_path_shareof.Clear();
				flag = false;
				Core.Unity.Debug.LogError("Set_asst_path_indexof is error, do is MAX > 100!");
				break;
			}
			int num2 = -1;
			num2 = str_path.IndexOf("@");
			if (num2 > -1)
			{
				string item = str_path.Substring(0, num2);
				asst_path_shareof.Add(item);
				str_path = str_path.Remove(0, num2 + 1);
			}
			else
			{
				asst_path_shareof.Add(str_path);
				flag = false;
			}
		}
		while (flag);
	}

	public bool Check_path_is_shareof(string path)
	{
		for (int i = 0; i < asst_path_shareof.Count; i++)
		{
			if (path.IndexOf(asst_path_shareof[i]) > 0)
			{
				return true;
			}
		}
		return false;
	}

	public void SetOnApplicationPauseCall(string func)
	{
		m_application_pause_call = func;
	}

	public void SetOnApplicationPauseLoopCall(string func)
	{
		m_application_pause_loop_call = func;
	}

	public void SetPauseLoopCallTimeOut(int second)
	{
		m_pause_loop_timeout = second;
	}

	private static List<Type> GetClasses(string nameSpace)
	{
		Assembly executingAssembly = Assembly.GetExecutingAssembly();
		List<Type> list = new List<Type>();
		Type[] types = executingAssembly.GetTypes();
		foreach (Type type in types)
		{
			if (type.Namespace == nameSpace)
			{
				list.Add(type);
			}
		}
		return list;
	}

	private bool InitScript()
	{
		if (scriptMgr == null)
		{
			scriptMgr = ScriptManager.GetInstance();
			luavm = scriptMgr.GetVM();
		}
		List<Type> classes = GetClasses("Wraper");
		foreach (Type item in classes)
		{
			MethodInfo method = item.GetMethod("init");
			if (method != null)
			{
				luavm.AddInit((LuaVM.InitFunction)Delegate.CreateDelegate(typeof(LuaVM.InitFunction), method));
			}
		}
		if (!luavm.Init())
		{
			Core.Unity.Debug.LogError("error:init wrap false");
			return false;
		}
		scriptMgr.InitL(luavm.GetLuaState());
		return true;
	}

	public void ResetScript()
	{
		resetFlag = true;
	}

	private void Update()
	{
		s_frameCounter++;
		if (Time.time - prev_gc_time > gcInterval)
		{
			prev_gc_time = Time.time;
			scriptMgr.CallGC(gcStep);
		}
		scriptMgr.CallFunction(onUpdate, Time.deltaTime);
		NModuleManager.GetInstance().Process();
		UpdateManager.GetInstance().update();
		AssetObject.Update();
		if (resetFlag)
		{
			luavm.Close();
			resetFlag = false;
			Run();
		}
		frames++;
		double num = Time.realtimeSinceStartup;
		if (num > lastInterval + 0.5)
		{
			fps = (double)frames / (num - lastInterval);
			frames = 0;
			lastInterval = num;
		}
	}

	private void OnApplicationFocus(bool pause)
	{
	}

	private void OnApplicationPause(bool pause)
	{
		on_pause = pause;
		if (!pause)
		{
			Application.targetFrameRate = 30;
			Time.timeScale = m_timeScale;
		}
		CloseBackgroundThead();
		m_temp_count = 0;
		if (pause)
		{
			Application.targetFrameRate = 1;
			m_timeScale = Time.timeScale;
			Time.timeScale = 0f;
			m_BackgroundThead_close = false;
			m_BackgroundThead = new Thread(PauseCall);
			m_BackgroundThead.Start();
			UnityEngine.Debug.Log("= Pause is true=");
		}
		if (!string.IsNullOrEmpty(m_application_pause_call) && scriptMgr != null)
		{
			scriptMgr.CallFunction(m_application_pause_call, pause);
		}
	}

	private void PauseCall()
	{
		while (!m_BackgroundThead_close)
		{
			Thread.Sleep(1000);
			if (!string.IsNullOrEmpty(m_application_pause_loop_call))
			{
				bool flag = scriptMgr.CallFunction(m_application_pause_loop_call);
			}
			if (m_temp_count >= m_pause_loop_timeout)
			{
				CloseBackgroundThead();
			}
			m_temp_count++;
		}
	}

	public void CloseBackgroundThead()
	{
		if (m_BackgroundThead != null)
		{
			m_BackgroundThead_close = true;
			try
			{
				m_BackgroundThead.Abort();
			}
			catch (Exception)
			{
			}
			m_BackgroundThead = null;
		}
	}

	private void FixedUpdate()
	{
		scriptMgr.CallFunction(onFixedUpdate, Time.fixedDeltaTime);
	}

	private void LateUpdate()
	{
		scriptMgr.CallFunction(onLateUpdate, Time.deltaTime);
	}

	public void opt_enable_net_dispatch(bool open)
	{
		enableNet = open;
	}

	public bool get_enable_net_dispatch()
	{
		return enableNet;
	}

	public void add_net_cache_ignore_msg(string funcName)
	{
		net_cache_ignore_msg.Add(funcName);
	}

	public bool is_net_cache_ignore_msg(string funcName)
	{
		return net_cache_ignore_msg.Contains(funcName);
	}
}
