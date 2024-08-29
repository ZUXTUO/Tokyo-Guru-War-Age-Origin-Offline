using System;
using System.Collections.Generic;
using System.Diagnostics;
using System.IO;
using System.Runtime.InteropServices;
using System.Text;
using System.Threading;
using Assets._protol_test;
using Core.Resource;
using Core.Util;
using LuaInterface;
using Script;
using UnityEngine;

namespace Core.Unity
{
	public class Debug : MonoBehaviour
	{
		public enum LOG_TYPE
		{
			LT_LOG = 0,
			LT_WARN = 1,
			LT_ERROR = 2
		}

		public enum LogOpen
		{
			Nothing = 0,
			Log = 1,
			Warning = 2,
			Error = 4
		}

		public enum LogLevel
		{
			Nothing = 0,
			Lua = 1,
			Normal = 2,
			Object = 4,
			Important = 8,
			Emergy = 16,
			ALL = 31
		}

		public struct stLog
		{
			public LOG_TYPE logType;

			public string logText;
		}

		private struct stScripRecording
		{
			public int delta_time;

			public string info;
		}

		public static DebugUI debugUI = null;

		public static bool bDebug = false;

		public static bool bShowGUI = false;

		public static bool bFile = true;

		public static LogOpen logOpen;

		public static LogLevel logType;

		public static bool bWebPost = true;

		public static string httppost_url = "http://125.71.203.241:30001/ghoul_error/webpost_ghoul.php";

		public static bool IsCheckOpenDebug = true;

		private int mOpenDebugNum;

		public static bool IsCheckOpenLog = true;

		private int mOpenDebugLogNum;

		private Rect mTopLeftRect = new Rect(new Vector2(0f, Screen.height / 2), new Vector2(Screen.width / 2, Screen.height / 2));

		private Rect mTopRightRect = new Rect(new Vector2(Screen.width / 2, Screen.height / 2), new Vector2(Screen.width / 2, Screen.height / 2));

		private Rect mDownLeftRect = new Rect(new Vector2(0f, 0f), new Vector2(Screen.width / 2, Screen.height / 2));

		private Rect mDownRightRect = new Rect(new Vector2(Screen.width / 2, 0f), new Vector2(Screen.width / 2, Screen.height / 2));

		public Stopwatch stopWatch = new Stopwatch();

		public bool stopWatchEnable;

		private static Debug mInstance = null;

		public static List<stLog> mLines = new List<stLog>();

		private static int maxCount = 300;

		public static Vector2 scrollPosition = new Vector2(0f, 0f);

		private static int fontsize = 9999;

		private static int nowCount = 0;

		public static bool isShowConsole = false;

		public static bool isConsoleAuto = true;

		public static string lastErrorText = string.Empty;

		public static int unSee = 0;

		public static int unSeeError = 0;

		public static Dictionary<string, string> pList = new Dictionary<string, string>();

		public static string last_error = string.Empty;

		public static string startDate = "unset";

		private static FileStream fs = null;

		private static FileStream fs_log = null;

		private static List<stScripRecording> m_listScriptRecordingInfo = new List<stScripRecording>();

		private void Start()
		{
		}

		private void ClearUp()
		{
			mInstance = null;
			mLines.Clear();
			mLines = null;
		}

		private void OnApplicationQuit()
		{
			ClearUp();
		}

		public static Debug GetInstance()
		{
			if (mInstance == null)
			{
				GameObject gameObject = new GameObject("_Debug");
				mInstance = gameObject.AddComponent<Debug>();
				UnityEngine.Object.DontDestroyOnLoad(gameObject);
				mInstance.enabled = true;
				mInstance.gameObject.SetActive(true);
				logOpen = (LogOpen)7;
				logType = (LogLevel)9;
			}
			return mInstance;
		}

		public static void WatchStart()
		{
			if (GetInstance().stopWatchEnable)
			{
				GetInstance().stopWatch.Start();
			}
		}

		public static void WatchEnd()
		{
			if (GetInstance().stopWatchEnable)
			{
				GetInstance().stopWatch.Stop();
				TimeSpan elapsed = GetInstance().stopWatch.Elapsed;
				GetInstance().stopWatch.Reset();
			}
		}

		public static void Log(string format)
		{
			if (logType != 0)
			{
				ShowLog(format);
			}
		}

		public static void Log(string format, LogLevel level)
		{
			if ((level & logType) != 0)
			{
				ShowLog(format);
			}
		}

		public static void ShowLog(string format)
		{
			ProtolTestServer.GetInst().Log(LOG_TYPE.LT_LOG, format);
			if (mLines != null)
			{
				format = format.Replace("{", "[zkh]");
				format = format.Replace("}", "[ykh]");
				string text = format;
				text = text.Replace("[zkh]", "{");
				text = text.Replace("[ykh]", "}");
				text = DateTime.Now.ToLocalTime().ToString("HH:mm:ss(fff)") + ": " + text;
				if (mLines.Count > maxCount)
				{
					mLines.RemoveAt(0);
				}
				stLog stLog = default(stLog);
				stLog.logType = LOG_TYPE.LT_LOG;
				stLog.logText = text;
				WriteToFile(stLog);
				if (isConsoleAuto)
				{
					mLines.Add(stLog);
					scrollPosition.y += fontsize;
					nowCount = mLines.Count;
				}
				if (!isShowConsole)
				{
					unSee++;
				}
			}
		}

		public static void LogWarning(string format)
		{
			if ((logOpen & LogOpen.Warning) == 0)
			{
				return;
			}
			ProtolTestServer.GetInst().Log(LOG_TYPE.LT_WARN, format);
			if (mLines != null)
			{
				format = format.Replace("{", "[zkh]");
				format = format.Replace("}", "[ykh]");
				string text = format;
				text = text.Replace("[zkh]", "{");
				text = text.Replace("[ykh]", "}");
				text = DateTime.Now.ToLocalTime().ToString("HH:mm:ss(fff)") + ": " + text;
				if (mLines.Count > maxCount)
				{
					mLines.RemoveAt(0);
				}
				stLog stLog = default(stLog);
				stLog.logType = LOG_TYPE.LT_WARN;
				stLog.logText = text;
				WriteToFile(stLog);
				if (isConsoleAuto)
				{
					mLines.Add(stLog);
					scrollPosition.y += fontsize;
					nowCount = mLines.Count;
				}
				if (!isShowConsole)
				{
					unSee++;
				}
			}
		}

		public static void LogError(string error_info)
		{
			if ((logOpen & LogOpen.Error) == 0)
			{
				return;
			}
			bool flag = false;
			if (last_error.ToString() == error_info.ToString())
			{
				flag = false;
			}
			else
			{
				last_error = error_info;
				flag = true;
			}
			if (flag)
			{
				pList.Clear();
				pList = get_necessary_info();
			}
			string text = string.Empty;
			if (Thread.CurrentThread.ManagedThreadId == Main.mainThreadId && !App3.on_pause)
			{
				text = "\n" + Get_Lua_Fun("Root.get_dumptracebackex") + "\n";
			}
			if (mLines == null)
			{
				Log("mLines == null");
				return;
			}
			text = text.Replace("{", "[zkh]");
			text = text.Replace("}", "[ykh]");
			text = text.Replace("[zkh]", "{");
			text = text.Replace("[ykh]", "}");
			text = "\n\n 客户端时间：" + DateTime.Now.ToLocalTime().ToString("yyyy-mm-dd HH:mm:ss(fff)") + text;
			text = text + "\nlast call lua:" + ScriptCall.lastCallFunction;
			if (!text.Contains("[系统"))
			{
				text = text + "\n-----------------------------------C#堆栈信息---------------------------------------\n" + StackTraceUtility.ExtractStackTrace();
			}
			if (mLines.Count > maxCount)
			{
				mLines.RemoveAt(0);
			}
			stLog stLog = default(stLog);
			stLog.logType = LOG_TYPE.LT_ERROR;
			string log = (stLog.logText = error_info + text);
			WriteToFile(stLog);
			if (isConsoleAuto)
			{
				mLines.Add(stLog);
				lastErrorText = stLog.logText;
				scrollPosition.y += fontsize;
				nowCount = mLines.Count;
			}
			if (!isShowConsole)
			{
				unSee++;
				unSeeError++;
				if (unSeeError > 0)
				{
				}
				bShowGUI = true;
			}
			ProtolTestServer.GetInst().Log(LOG_TYPE.LT_ERROR, log);
			if (flag)
			{
				pList.Add("info", error_info);
				pList.Add("stack_info", text);
				pList.Add("info_type", "error");
				push_web_info("error", pList);
			}
			if (isConsoleAuto && !IsDebug())
			{
				isConsoleAuto = false;
			}
		}

		public static void push_web_info(string type, Dictionary<string, string> pList)
		{
			if ((Thread.CurrentThread.ManagedThreadId == Main.mainThreadId || App3.on_pause) && bWebPost && type != string.Empty && httppost_url != string.Empty)
			{
				AssetBundleLoader.GetInstance().send_http_info(httppost_url, type, pList);
			}
		}

		public static Dictionary<string, string> get_necessary_info()
		{
			Dictionary<string, string> dictionary = new Dictionary<string, string>();
			string deviceUniqueIdentifier = SystemInfo.deviceUniqueIdentifier;
			dictionary.Add("device_id", deviceUniqueIdentifier);
			string empty = string.Empty;
			empty = SystemInfo.deviceName;
			if (Thread.CurrentThread.ManagedThreadId == 1)
			{
				empty = UserCenter.GetInstance().getDeviceInfo("device_name");
			}
			dictionary.Add("device_name", empty);
			string value = Get_Lua_Fun("Root.get_account_id");
			dictionary.Add("account_id", value);
			string value2 = Get_Lua_Fun("Root.get_player_id");
			dictionary.Add("player_id", value2);
			string value3 = Get_Lua_Fun("Root.get_player_name");
			dictionary.Add("player_name", value3);
			string value4 = Get_Lua_Fun("Root.get_package_version");
			dictionary.Add("package_version", value4);
			string value5 = Get_Lua_Fun("Root.get_res_version");
			dictionary.Add("res_version", value5);
			string text = "\n";
			text = text + "设备名字：" + empty + "\n";
			text = text + "操作系统：" + SystemInfo.operatingSystem + "\n";
			text = text + "网络2WIFI：" + (int)Application.internetReachability + "\n";
			text = text + "分辨率：" + Screen.width + "x" + Screen.height + "\n";
			text = text + "内存：" + SystemInfo.systemMemorySize + "\n";
			text = text + "显存：" + SystemInfo.graphicsMemorySize + "\n";
			text = text + "游戏运行时间：" + Time.realtimeSinceStartup.ToString("f1") + "\n";
			text = text + "显卡：" + SystemInfo.graphicsDeviceName + "\n";
			text = text + "显卡版本：" + SystemInfo.graphicsDeviceVersion + "\n";
			text = text + "Shader版本：" + SystemInfo.graphicsShaderLevel + "\n";
			text = text + "CPU架构：" + SystemInfo.processorType + "\n";
			text = text + "CPU核心数：" + SystemInfo.processorCount + "\n";
			text = text + "ip：" + Network.player.ipAddress + "\n";
			text = text + "持久保存路径：" + Application.persistentDataPath + "\n";
			text = text + "内部资源路径：" + Application.streamingAssetsPath + "\n";
			dictionary.Add("necessary_info", text);
			return dictionary;
		}

		private static void ShowSlowAction()
		{
			GUIStyle box = GUI.skin.box;
			box.richText = true;
			box.alignment = TextAnchor.MiddleLeft;
			box.fontSize = 20;
			GUILayout.Space(5f);
			GUILayout.BeginHorizontal();
			Time.timeScale = GUILayout.HorizontalSlider(Time.timeScale, 0f, 2f, GUILayout.Width(500f));
			GUILayout.Label("TimeScale：" + Time.timeScale, box);
			GUILayout.EndHorizontal();
		}

		private void Update()
		{
			CheckOpenState();
			if (bDebug)
			{
				if (null == debugUI)
				{
					base.gameObject.AddComponent<DebugUI>();
					debugUI = GetComponent<DebugUI>();
				}
			}
			else if (null != debugUI)
			{
				debugUI.enabled = false;
			}
		}

		private void CheckOpenState()
		{
			Vector2 point = Vector2.zero;
			if (Input.touchCount <= 0)
			{
				return;
			}
			Touch touch = Input.GetTouch(0);
			if (touch.phase != 0)
			{
				return;
			}
			point = new Vector2(touch.position.x, touch.position.y);
			if (IsCheckOpenDebug)
			{
				switch (mOpenDebugLogNum)
				{
				case 0:
					if (mDownRightRect.Contains(point))
					{
						mOpenDebugLogNum = 1;
					}
					break;
				case 1:
					if (mDownLeftRect.Contains(point))
					{
						mOpenDebugLogNum = 2;
					}
					else
					{
						mOpenDebugLogNum = 0;
					}
					break;
				case 2:
					if (mTopRightRect.Contains(point))
					{
						mOpenDebugLogNum = 3;
					}
					else
					{
						mOpenDebugLogNum = 0;
					}
					break;
				case 3:
					if (mTopLeftRect.Contains(point))
					{
						Log("<color=#E00000ff> Debug GUI Open!!!!! </color>");
					}
					IsCheckOpenDebug = false;
					bDebug = !bDebug;
					break;
				}
			}
			if (!IsCheckOpenLog)
			{
				return;
			}
			switch (mOpenDebugNum)
			{
			case 0:
				if (mTopLeftRect.Contains(point))
				{
					mOpenDebugNum = 1;
				}
				break;
			case 1:
				if (mTopRightRect.Contains(point))
				{
					mOpenDebugNum = 2;
				}
				else
				{
					mOpenDebugNum = 0;
				}
				break;
			case 2:
				if (mDownLeftRect.Contains(point))
				{
					mOpenDebugNum = 3;
				}
				else
				{
					mOpenDebugNum = 0;
				}
				break;
			case 3:
				if (mDownRightRect.Contains(point))
				{
					Log("<color=#E00000ff> Debug All Log Is Close!!!!!  </color>");
				}
				IsCheckOpenLog = false;
				logType = LogLevel.Nothing;
				logOpen = LogOpen.Nothing;
				break;
			}
		}

		public static string Get_Lua_Fun(string lua_fun)
		{
			string result = string.Empty;
			int pushcount = 0;
			try
			{
				int num = LuaVM.GetInstance().lua_gettop();
				if (LuaVM.GetInstance().Lua_GetFunction(lua_fun, ref pushcount))
				{
					int num2 = LuaVM.GetInstance().lua_pcall(0, 1, num);
					result = LuaVM.GetInstance().lua_tostring(-1);
				}
				LuaVM.GetInstance().lua_settop(num);
			}
			catch (Exception)
			{
				Log("lua func is nill:" + lua_fun);
			}
			return result;
		}

		private static void WriteToFile(stLog stlog)
		{
			if (Thread.CurrentThread.ManagedThreadId != 1 || !bFile)
			{
				return;
			}
			if (Application.platform == RuntimePlatform.WindowsEditor || Application.platform == RuntimePlatform.WindowsPlayer || Application.platform == RuntimePlatform.OSXEditor)
			{
				byte[] array = null;
				if (fs == null)
				{
					DateTime dateObject = Utils.GetDateObject(Utils.GetTimeSeconds());
					startDate = string.Format("{0:yyyy-MM-dd_HH-mm-ss}", dateObject);
					string path = "debug_log[" + startDate + "].txt";
					fs = new FileStream(path, FileMode.Create, FileAccess.Write);
					array = Encoding.UTF8.GetBytes("===================================start game=============================\n");
					fs.Write(array, 0, array.Length);
				}
				array = Encoding.UTF8.GetBytes(stlog.logText + "\n");
				fs.Write(array, 0, array.Length);
				fs.Flush();
			}
			DateTime dateObject2 = Utils.GetDateObject(Utils.GetTimeSeconds());
			startDate = string.Empty;
			startDate = string.Format("{0:yyyy-MM-dd}", dateObject2);
			string writePath = FileUtil.GetWritePath(string.Empty);
			if (!Directory.Exists(writePath))
			{
				Directory.CreateDirectory(writePath);
			}
			string filepath = "debug_log.txt";
			string writePath2 = FileUtil.GetWritePath(filepath);
			byte[] array2 = null;
			if (fs_log == null)
			{
				fs_log = new FileStream(writePath2, FileMode.Create, FileAccess.Write);
				array2 = Encoding.UTF8.GetBytes("===================================start game=============================\n");
				fs_log.Write(array2, 0, array2.Length);
			}
			array2 = Encoding.UTF8.GetBytes(stlog.logText + "\n");
			fs_log.Write(array2, 0, array2.Length);
			fs_log.Flush();
		}

		public static void WriteScriptRecording(int delta_time, string szInfo)
		{
			stScripRecording item = default(stScripRecording);
			item.delta_time = delta_time;
			item.info = szInfo;
			m_listScriptRecordingInfo.Add(item);
		}

		private void OnDestroy()
		{
			if (fs != null)
			{
				byte[] bytes = Encoding.UTF8.GetBytes("===================================end game=============================\n\n\n\n\n");
				fs.Write(bytes, 0, bytes.Length);
				fs.Flush();
				fs.Close();
			}
			if (m_listScriptRecordingInfo.Count > 0)
			{
				DateTime dateObject = Utils.GetDateObject(Utils.GetTimeSeconds());
				string text = string.Format("{0:yyyy-MM-dd_HH-mm-ss}", dateObject);
				string path = "script_recording[" + text + "].lua";
				FileStream fileStream = new FileStream(path, FileMode.Create, FileAccess.Write);
				byte[] array = null;
				if (fileStream != null)
				{
					int i = 0;
					int count = m_listScriptRecordingInfo.Count;
					string s = string.Format("glog(\"script recording start\")\n");
					array = Encoding.UTF8.GetBytes(s);
					fileStream.Write(array, 0, array.Length);
					s = string.Format("step_log = function(a)end\n");
					array = Encoding.UTF8.GetBytes(s);
					fileStream.Write(array, 0, array.Length);
					for (; i < count; i++)
					{
						string s2 = string.Format("function cb{0}()\n", i + 1);
						array = Encoding.UTF8.GetBytes(s2);
						fileStream.Write(array, 0, array.Length);
						array = Encoding.UTF8.GetBytes("    " + m_listScriptRecordingInfo[i].info);
						fileStream.Write(array, 0, array.Length);
						s = string.Format("    step_log(tostring(client_id)..\" finish cb{0}\")\n", i + 1);
						array = Encoding.UTF8.GetBytes(s);
						fileStream.Write(array, 0, array.Length);
						if (i < count - 1)
						{
							s = string.Format("    gnet.sleep(1, {0}, cb{1})\n", m_listScriptRecordingInfo[i + 1].delta_time, i + 2);
							array = Encoding.UTF8.GetBytes(s);
							fileStream.Write(array, 0, array.Length);
						}
						else
						{
							s = string.Format("    glog(\"script recording over\")\n");
							array = Encoding.UTF8.GetBytes(s);
							fileStream.Write(array, 0, array.Length);
						}
						array = Encoding.UTF8.GetBytes("end\n");
						fileStream.Write(array, 0, array.Length);
					}
					s = string.Format("gnet.sleep(1, {0}, cb1)\n", m_listScriptRecordingInfo[0].delta_time);
					array = Encoding.UTF8.GetBytes(s);
					fileStream.Write(array, 0, array.Length);
					fileStream.Flush();
					fileStream.Close();
				}
			}
			if (fs_log != null)
			{
				byte[] bytes2 = Encoding.UTF8.GetBytes("===================================end game=============================\n\n\n\n\n");
				fs_log.Write(bytes2, 0, bytes2.Length);
				fs_log.Flush();
				fs_log.Close();
			}
		}

		[DllImport("__Internal")]
		private static extern int GetFreeMemory();

		[DllImport("__Internal")]
		private static extern int GetUsedMemory();

		[DllImport("__Internal")]
		private static extern int GetActiveMemory();

		[DllImport("__Internal")]
		private static extern int GetWireMemory();

		[DllImport("__Internal")]
		private static extern int GetInactiveMemory();

		public static int PluginGetFreeMemory()
		{
			return 0;
		}

		public static int PluginGetUsedMemory()
		{
			return 0;
		}

		public static int PluginGetActiveMemory()
		{
			return 0;
		}

		public static int PluginGetWireMemory()
		{
			return 0;
		}

		public static int PluginGetInactiveMemory()
		{
			return 0;
		}

		public static bool IsDebug()
		{
			return false;
		}
	}
}
