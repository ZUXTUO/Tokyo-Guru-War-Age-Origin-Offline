using System;
using UnityEngine;
using UnityEngine.Profiling;

namespace Core.Unity
{
	public class DebugUI : MonoBehaviour
	{
		private bool IsSlow;

		private bool bScale;

		private int memoryLabelWidth = 400;

		private string ping_speed = string.Empty;

		private int xPos = 400;

		private int yPos = 300;

		private int wValue = 60;

		private int hValue = 60;

		private int consoleButtonWidth = 120;

		private int ConsoleButtonHeight = 50;

		private int scrollButtonWidth = 60;

		private int scrollButoonHeight = 60;

		private bool bShowTex;

		private int iShowIndex;

		private GUISkin myGuiSkin;

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

		private void OnGUI()
		{
			if (!Debug.bDebug)
			{
				return;
			}
			int num = Debug.PluginGetFreeMemory();
			int num2 = Debug.PluginGetActiveMemory();
			int num3 = Debug.PluginGetWireMemory();
			int num4 = Debug.PluginGetInactiveMemory();
			if (GUI.Button(new Rect(0f, NGUITools.screenSize.y - 170f, 45f, 100f), "D\ne\nb\nu\ng"))
			{
				Debug.bShowGUI = !Debug.bShowGUI;
			}
			GUI.Label(new Rect(0f, NGUITools.screenSize.y - 230f, memoryLabelWidth, 25f), ping_speed);
			if (!Debug.bShowGUI)
			{
				SystemMonitor.Instance().enabled = false;
				return;
			}
			if (!SystemMonitor.Instance().enabled)
			{
				SystemMonitor.Instance().enabled = true;
			}
			if (myGuiSkin == null)
			{
				myGuiSkin = (GUISkin)Resources.Load("myGUISkin");
			}
			GUI.skin = myGuiSkin;
			if (Debug.isShowConsole)
			{
				Debug.unSee = 0;
				Debug.unSeeError = 0;
			}
			string text = "Console";
			if (Debug.unSee > 0)
			{
				string text2 = text;
				text = text2 + " (" + Debug.unSee + ")";
			}
			if (Debug.unSeeError > 0)
			{
				string text2 = text;
				text = text2 + " (" + Debug.unSeeError + ")";
			}
			int num5 = 155;
			if (SystemMonitor.Instance().isShowSys)
			{
				GUILayout.Space(160f);
				num5 = 155 + scrollButtonWidth;
			}
			else
			{
				GUILayout.Space(50f);
				num5 = 155 - scrollButoonHeight;
			}
			GUILayout.BeginHorizontal();
			if (!SystemMonitor.Instance().isShowSys)
			{
				if (GUILayout.Button(text, GUILayout.Width(consoleButtonWidth), GUILayout.Height(ConsoleButtonHeight)))
				{
					Debug.isShowConsole = !Debug.isShowConsole;
				}
				if (GUILayout.Button("output(" + Debug.isConsoleAuto + ")", GUILayout.Width(consoleButtonWidth), GUILayout.Height(ConsoleButtonHeight)))
				{
					Debug.isConsoleAuto = !Debug.isConsoleAuto;
				}
				if (GUILayout.Button("慢动作", GUILayout.Width(consoleButtonWidth), GUILayout.Height(ConsoleButtonHeight)))
				{
					IsSlow = !IsSlow;
				}
				if (GUILayout.Button("used tex", GUILayout.Width(consoleButtonWidth), GUILayout.Height(ConsoleButtonHeight)))
				{
					bShowTex = !bShowTex;
					iShowIndex = 0;
				}
			}
			GUILayout.EndHorizontal();
			int num6 = 500;
			int num7 = 50;
			if (bShowTex && !SystemMonitor.Instance().isShowSys)
			{
				UnityEngine.Object[] array = Resources.FindObjectsOfTypeAll(typeof(UnityEngine.Object));
				Texture2D[] array2 = (Texture2D[])Resources.FindObjectsOfTypeAll(typeof(Texture2D));
				if (GUI.Button(new Rect(num6, num7, 50f, 50f), "<<"))
				{
					iShowIndex--;
					if (iShowIndex < 0)
					{
						iShowIndex = array2.Length;
					}
				}
				num6 += 50;
				if (GUI.Button(new Rect(num6 + 15, num7, 50f, 50f), ">>"))
				{
					iShowIndex++;
					if (iShowIndex > array2.Length)
					{
						iShowIndex = 0;
					}
				}
				num6 += 50;
				int num8 = 0;
				float num9 = 0f;
				GUIStyle box = GUI.skin.box;
				box.richText = true;
				box.alignment = TextAnchor.MiddleLeft;
				box.fontSize = 20;
				foreach (Texture texture in array2)
				{
					num8++;
					float num10 = (float)Profiler.GetRuntimeMemorySize(texture) / 1024f / 1024f;
					num9 += num10;
					if (num8 == iShowIndex)
					{
						string text3 = string.Empty;
						string text4 = string.Empty;
						if (num10 > 1f)
						{
							text3 = "<color=#ff0000ff>";
							text4 = "</color>";
						}
						GUI.Label(new Rect(num6 - 500, num7 + 60, 1150f, 30f), text3 + "(" + num8 + "/" + array2.Length + ")tex size: " + num10.ToString("f4") + " MB ,name: " + texture.name + text4 + "(" + texture.width + "x" + texture.height + ")", box);
						GUI.DrawTexture(new Rect(num6 - 500, num7 + 110, texture.width, texture.height), texture);
					}
				}
				GUI.Label(new Rect(num6 + 40, num7 + 10, 600f, 30f), "Run time All Memory: " + num9.ToString("f2") + "M", box);
			}
			if (Debug.isShowConsole && !SystemMonitor.Instance().isShowSys)
			{
				if (GUI.RepeatButton(new Rect(xPos, yPos, wValue, hValue), "拉"))
				{
					bScale = true;
				}
				if (Input.GetMouseButtonUp(0))
				{
					bScale = false;
				}
				if (bScale)
				{
					Vector3 mousePosition = Input.mousePosition;
					xPos = (int)mousePosition.x - wValue;
					yPos = (int)((float)Screen.height - mousePosition.y) - hValue;
					GUILayout.Box("拉伸中...", GUILayout.Width(xPos + scrollButtonWidth), GUILayout.Height(yPos - num5));
				}
				else
				{
					Debug.scrollPosition = GUILayout.BeginScrollView(Debug.scrollPosition, GUILayout.Width(xPos + scrollButtonWidth), GUILayout.Height(yPos - num5));
					int j = 0;
					for (int count = Debug.mLines.Count; j < count; j++)
					{
						string logText = Debug.mLines[j].logText;
						GUIStyle box2 = GUI.skin.box;
						box2.richText = true;
						box2.alignment = TextAnchor.MiddleLeft;
						switch (Debug.mLines[j].logType)
						{
						case Debug.LOG_TYPE.LT_LOG:
							box2.normal.textColor = Color.white;
							box2.fontSize = 18;
							break;
						case Debug.LOG_TYPE.LT_WARN:
							box2.normal.textColor = Color.yellow;
							box2.fontSize = 20;
							break;
						case Debug.LOG_TYPE.LT_ERROR:
							box2.normal.textColor = new Color(1f, 0.1f, 0.2f);
							box2.fontSize = 22;
							break;
						}
						try
						{
							if (Application.platform == RuntimePlatform.WindowsEditor || Application.platform == RuntimePlatform.WindowsPlayer)
							{
								GUILayout.TextField(Debug.mLines[j].logText, box2);
							}
							else
							{
								GUILayout.Label(Debug.mLines[j].logText, box2);
							}
						}
						catch (Exception)
						{
						}
					}
					GUILayout.EndScrollView();
				}
			}
			if (IsSlow && !SystemMonitor.Instance().isShowSys)
			{
				ShowSlowAction();
			}
		}
	}
}
