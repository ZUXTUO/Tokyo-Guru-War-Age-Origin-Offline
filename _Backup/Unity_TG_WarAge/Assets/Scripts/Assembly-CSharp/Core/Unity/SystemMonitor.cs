using LuaInterface;
using UnityEngine;
using UnityEngine.Profiling;

namespace Core.Unity
{
	public class SystemMonitor : MonoBehaviour
	{
		private static SystemMonitor mInstance;

		private double updateInterval = 0.5;

		private double lastInterval;

		private int frames;

		public double fps;

		private double perFrames;

		private double perFramesTime;

		private double lowestFrames = 99.0;

		private float lastCalTime;

		public bool isShowSys;

		public float usedTime;

		public Resolution[] resolutions;

		private string ping_speed = string.Empty;

		public static SystemMonitor Instance()
		{
			if (mInstance == null)
			{
				GameObject gameObject = new GameObject("SystemMonitor");
				mInstance = gameObject.AddComponent<SystemMonitor>();
				Object.DontDestroyOnLoad(gameObject);
			}
			return mInstance;
		}

		public void SetPingSpeed(string speed_str)
		{
			ping_speed = speed_str;
		}

		private void Start()
		{
			resolutions = Screen.resolutions;
			float realtimeSinceStartup = Time.realtimeSinceStartup;
			lastInterval = realtimeSinceStartup;
			frames = 0;
			perFramesTime = realtimeSinceStartup;
		}

		private void Update()
		{
			LuaVM instance = LuaVM.GetInstance();
			usedTime = (float)instance.usedTime / 10000f;
			instance.usedTime = 0L;
			float realtimeSinceStartup = Time.realtimeSinceStartup;
			perFrames = (double)realtimeSinceStartup - perFramesTime;
			perFramesTime = realtimeSinceStartup;
			frames++;
			double num = realtimeSinceStartup;
			if (num > lastInterval + updateInterval)
			{
				fps = (double)frames / (num - lastInterval);
				frames = 0;
				lastInterval = num;
			}
		}

		private void OnGUI()
		{
			if (!Debug.bShowGUI)
			{
				return;
			}
			GUILayout.BeginHorizontal();
			string text = "Off";
			if (!isShowSys)
			{
				text = "On";
			}
			if (GUILayout.Button(text, GUILayout.Width(50f), GUILayout.Height(50f)))
			{
				isShowSys = !isShowSys;
			}
			GUIStyle box = GUI.skin.box;
			box.richText = true;
			box.alignment = TextAnchor.MiddleLeft;
			box.fontSize = 14;
			if (isShowSys)
			{
				GUI.Label(new Rect(0f, -300f, 500f, 1500f), ping_speed);
				string empty = string.Empty;
				empty += string.Format("分辨率:<color=#00ffffff>{0}x{1}</color>,", Screen.width, Screen.height);
				empty += string.Format("内存:<color=#00ffffff>{0}</color>,", SystemInfo.systemMemorySize);
				empty += string.Format("显存:<color=#00ffffff>{0}</color>,", SystemInfo.graphicsMemorySize);
				empty += string.Format("deltaTime:<color=#00ffffff>{0}</color>,", Time.deltaTime.ToString("f4"));
				empty += string.Format("游戏运行时间:<color=#00ffffff>{0}</color>,", Time.realtimeSinceStartup.ToString("f1"));
				float num = 0f;
				float num2 = 0f;
				string empty2 = string.Empty;
				empty += string.Format("设备唯一id:<color=#ff00ffff>{0}</color>\n", SystemInfo.deviceUniqueIdentifier);
				empty += string.Format("显卡:<color=#ffff00ff>{0}</color>,", SystemInfo.graphicsDeviceName);
				empty += string.Format("显卡版本:<color=#ffff00ff>{0}</color>,", SystemInfo.graphicsDeviceVersion);
				empty += string.Format("Shader版本:<color=#ffff00ff>{0}</color>\n", SystemInfo.graphicsShaderLevel);
				empty += string.Format("操作系统:<color=#3ca5acff>{0}</color>\n", SystemInfo.operatingSystem);
				empty += string.Format("CPU架构:<color=#3b9fe5ff>{0}</color>,", SystemInfo.processorType);
				empty += string.Format("CPU核心数:<color=#3b9fe5ff>{0}</color>\n", SystemInfo.processorCount);
				empty += string.Format("持久保存路径:<color=#8b7decff>{0}</color>\n", Application.persistentDataPath);
				empty += string.Format("内部资源路径:<color=#8b7decff>{0}</color>\n", Application.streamingAssetsPath);
				empty += string.Format("ip:<color=#96aa2a>{0}</color>,", Network.player.ipAddress);
				empty += string.Format("model:<color=#96aa2a>{0}</color>,", SystemInfo.deviceModel);
				empty += string.Format("name:<color=#96aa2a>{0}</color>,", SystemInfo.deviceName);
				empty += string.Format("type:<color=#96aa2a>{0}</color>,", SystemInfo.deviceType);
				int num3 = 0;
				int num4 = 0;
				Object[] array = Resources.FindObjectsOfTypeAll(typeof(Object));
				Object[] array2 = array;
				foreach (Object o in array2)
				{
					num3 += Profiler.GetRuntimeMemorySize(o);
					num4++;
				}
				empty += string.Format("\n对象数量:<color=#6F60D0>{0}</color>,", num4);
				empty += string.Format("内存占用:<color=#87ba66>{0:F2}MB</color>,", (float)num3 / 1024f / 1024f);
				uint monoHeapSize = Profiler.GetMonoHeapSize();
				empty += string.Format("分配Mono堆:<color=#87ba66>{0:F2}MB</color>,", (float)monoHeapSize / 1024f / 1024f);
				uint monoUsedSize = Profiler.GetMonoUsedSize();
				empty += string.Format("Mono使用内存:<color=#87ba66>{0:F2}MB</color>,", (float)monoUsedSize / 1024f / 1024f);
				GUILayout.TextField(empty, box);
			}
			box.fontSize = 20;
			float realtimeSinceStartup = Time.realtimeSinceStartup;
			if (realtimeSinceStartup - lastCalTime > 10f)
			{
				lastCalTime = realtimeSinceStartup;
				lowestFrames = 99.0;
			}
			if (fps < lowestFrames)
			{
				lowestFrames = fps;
				lastCalTime = realtimeSinceStartup;
			}
			GUILayout.TextField(string.Format("FPS:<color=#00ffffff>{0}</color>(<color=#ff0000ff>{1}</color>)", fps.ToString("f2"), lowestFrames.ToString("f2")), box);
			box.fontSize = 14;
			GUILayout.EndHorizontal();
		}
	}
}
