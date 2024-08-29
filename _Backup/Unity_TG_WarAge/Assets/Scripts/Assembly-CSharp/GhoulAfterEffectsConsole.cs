using Core.Unity;
using UnityEngine;

public class GhoulAfterEffectsConsole : MonoBehaviourEx
{
	private static string go_name = "_AfterEffectConsole";

	private static GhoulAfterEffectsConsole instance = null;

	private int lastQualityLevel = 2;

	private float frames;

	private float lastInterval;

	private float fps;

	private int ql;

	private Camera targetCam;

	private Camera[] allCam;

	private int nguilayer;

	private int guidelayer;

	private int onlyDoflayer;

	public static bool showFPS = false;

	public bool stopCheckCamera;

	private static string[] qname = new string[3] { "低", "中", "高" };

	private GameObject SceneEffect;

	public static bool showCtrl = false;

	public static int enableEffect = 1;

	private Camera uicamera;

	public static int enableDistortion = 0;

	public static int enableBloom = 1;

	[Range(0f, 10f)]
	public static float bloomFactor = 1f;

	public static float screenLuminanceThreshold = 0.5f;

	public static float screenIntensity = 2f;

	public static float blurSize = 2.5f;

	public static int blurIterations = 2;

	public static GhoulAfterEffects.BlurResolution blurresolution = GhoulAfterEffects.BlurResolution.High;

	public static GhoulAfterEffectsConsole GetInstance()
	{
		if (instance == null)
		{
			GameObject gameObject = MonoBehaviourEx.CreateGameObject(go_name);
			instance = gameObject.AddComponent<GhoulAfterEffectsConsole>();
		}
		return instance;
	}

	private void Start()
	{
		lastQualityLevel = QualitySettings.GetQualityLevel();
		nguilayer = LayerMask.NameToLayer("ngui");
		guidelayer = LayerMask.NameToLayer("guide");
		onlyDoflayer = LayerMask.NameToLayer("DynamicWater");
	}

	private void Update()
	{
		if (showFPS)
		{
			float realtimeSinceStartup = Time.realtimeSinceStartup;
			frames += 1f;
			float num = realtimeSinceStartup;
			if (num > lastInterval + 1f)
			{
				fps = frames / (num - lastInterval);
				frames = 0f;
				lastInterval = num;
			}
		}
		ql = QualitySettings.GetQualityLevel();
		Shader.SetGlobalFloat("_BloomFactor", bloomFactor);
		targetCam = null;
		GhoulAfterEffects ghoulAfterEffects = GhoulAfterEffects.GetInstance();
		if (ql > 0)
		{
			ghoulAfterEffects.enableDistortion = true;
			ghoulAfterEffects.blurResolution = blurresolution;
			ghoulAfterEffects.enableBloom = enableBloom == 1;
			ghoulAfterEffects.blurIterations = blurIterations;
			ghoulAfterEffects.intensity = screenIntensity;
			ghoulAfterEffects.threshhold = screenLuminanceThreshold;
			ghoulAfterEffects.blurSize = blurSize;
			if (!stopCheckCamera)
			{
				float num2 = -100f;
				int num3 = -1;
				allCam = Camera.allCameras;
				for (int i = 0; i < allCam.Length; i++)
				{
					if (allCam[i] != null && allCam[i].isActiveAndEnabled && allCam[i].targetTexture == null && allCam[i].gameObject.layer != nguilayer && allCam[i].gameObject.layer != guidelayer && allCam[i].name != "QTECamera" && allCam[i].depth > num2)
					{
						num2 = allCam[i].depth;
						num3 = i;
					}
				}
				if (num3 >= 0)
				{
					targetCam = allCam[num3];
				}
			}
		}
		if (!stopCheckCamera)
		{
			ghoulAfterEffects.setTargetCamera(targetCam);
			if (targetCam != null)
			{
				if (targetCam.gameObject.layer == onlyDoflayer)
				{
					ghoulAfterEffects.enableBloom = false;
				}
				else
				{
					ghoulAfterEffects.enableBloom = true;
				}
			}
		}
		if (lastQualityLevel == ql)
		{
			return;
		}
		lastQualityLevel = ql;
		if (lastQualityLevel == 0)
		{
			Shader.globalMaximumLOD = 300;
		}
		else
		{
			Shader.globalMaximumLOD = 600;
		}
		GameObject[] array = GameObject.FindGameObjectsWithTag("HighEffect");
		if (ql >= 2)
		{
			Shader.globalMaximumLOD = 900;
			for (int j = 0; j < array.Length; j++)
			{
				ReflectionFx component = array[j].GetComponent<ReflectionFx>();
				if (component != null)
				{
					component.enabled = true;
				}
				ReflectManager component2 = array[j].GetComponent<ReflectManager>();
				if (component2 != null)
				{
					component2.checkQuality();
				}
				Camera component3 = array[j].GetComponent<Camera>();
				if (component3 != null)
				{
					component3.enabled = true;
				}
				StarWarsShadow component4 = array[j].GetComponent<StarWarsShadow>();
				if (component4 != null)
				{
					component4.enabled = true;
				}
				Projector component5 = array[j].GetComponent<Projector>();
				if (component5 != null)
				{
					component5.enabled = true;
				}
			}
			return;
		}
		for (int k = 0; k < array.Length; k++)
		{
			ReflectionFx component6 = array[k].GetComponent<ReflectionFx>();
			if (component6 != null)
			{
				component6.enabled = false;
			}
			ReflectManager component7 = array[k].GetComponent<ReflectManager>();
			if (component7 != null)
			{
				component7.checkQuality();
			}
			StarWarsShadow component8 = array[k].GetComponent<StarWarsShadow>();
			if (component8 != null)
			{
				component8.enabled = false;
			}
			Camera component9 = array[k].GetComponent<Camera>();
			if (component9 != null)
			{
				component9.enabled = false;
			}
			Projector component10 = array[k].GetComponent<Projector>();
			if (component10 != null)
			{
				component10.enabled = false;
			}
		}
	}

	private void OnGUIXXX()
	{
		GUILayout.BeginHorizontal();
		GUILayout.Label(string.Empty, GUILayout.Width(300f));
		if (GUILayout.Button("打印UI队列"))
		{
			string empty = string.Empty;
			GameObject gameObject = GameObject.Find("uiroot");
			empty = GetAllChild(gameObject.transform, string.Empty);
			Core.Unity.Debug.Log(empty);
		}
		GUILayout.EndHorizontal();
	}

	private string GetAllChild(Transform t, string pre)
	{
		int childCount = t.GetChildCount();
		pre += "  ";
		string text = string.Empty;
		for (int i = 0; i < childCount; i++)
		{
			Transform child = t.GetChild(i);
			text = ((child.GetChildCount() <= 0) ? (text + "\n" + pre + child.name + ":" + child.gameObject.activeInHierarchy) : (text + "\n" + pre + child.name + ":" + child.gameObject.activeInHierarchy + GetAllChild(child, pre)));
		}
		return text;
	}

	private void OnGUI()
	{
		if (!showFPS)
		{
			return;
		}
		int qualityLevel = QualitySettings.GetQualityLevel();
		if (GUI.Button(new Rect(10f, Screen.height - 50, 200f, 50f), qname[qualityLevel] + fps.ToString("f1")))
		{
			showCtrl = !showCtrl;
		}
		if (!showCtrl)
		{
			return;
		}
		if (GUI.Button(new Rect(10f, Screen.height - 110, 200f, 50f), "抗锯齿：" + GhoulAfterEffects.GetInstance().AAenabled))
		{
			GhoulAfterEffects.GetInstance().AAenabled = !GhoulAfterEffects.GetInstance().AAenabled;
		}
		if (GUI.Button(new Rect(10f, Screen.height - 170, 200f, 50f), "切换特效质量"))
		{
			qualityLevel = ((qualityLevel < 2) ? (qualityLevel + 1) : 0);
			QualitySettings.SetQualityLevel(qualityLevel);
		}
		GUILayout.BeginVertical();
		GUILayoutOption[] options = new GUILayoutOption[4]
		{
			GUILayout.Width(Screen.width / 3),
			GUILayout.Height(Screen.height / 16),
			GUILayout.ExpandWidth(true),
			GUILayout.ExpandHeight(true)
		};
		GUILayoutOption[] options2 = new GUILayoutOption[4]
		{
			GUILayout.Width(Screen.width / 3),
			GUILayout.Height(Screen.height / 16),
			GUILayout.ExpandWidth(true),
			GUILayout.ExpandHeight(true)
		};
		GUIStyle gUIStyle = new GUIStyle();
		gUIStyle.fontSize = (int)((float)Screen.width / 40f);
		gUIStyle.normal.background = GUI.skin.textField.normal.background;
		gUIStyle.normal.textColor = Color.white;
		GUIStyle gUIStyle2 = new GUIStyle();
		gUIStyle2.fontSize = (int)((float)Screen.width / 40f);
		gUIStyle2.fontStyle = FontStyle.BoldAndItalic;
		gUIStyle2.normal.textColor = Color.white;
		GUILayout.TextField(string.Empty, gUIStyle2, options);
		GUILayout.TextField(string.Empty, gUIStyle2, options);
		GUILayout.TextField(string.Empty, gUIStyle2, options);
		GUILayout.TextField("Bloom强度" + screenIntensity.ToString("f2"), gUIStyle, options);
		screenIntensity = GUILayout.HorizontalSlider(screenIntensity, 0f, 5f, options2);
		GUILayout.TextField("Bloom阈值" + screenLuminanceThreshold.ToString("f2"), gUIStyle, options);
		screenLuminanceThreshold = GUILayout.HorizontalSlider(screenLuminanceThreshold, 0f, 1.5f, options2);
		GUILayout.TextField("模糊采样间距" + blurSize.ToString("f2"), gUIStyle, options);
		blurSize = GUILayout.HorizontalSlider(blurSize, 0.25f, 10f, options2);
		GUILayout.TextField("角色泛光全局强度" + bloomFactor.ToString("f2"), gUIStyle, options);
		bloomFactor = GUILayout.HorizontalSlider(bloomFactor, 0f, 2f, options2);
		GUILayout.EndVertical();
		for (int i = 0; i < Camera.allCameras.Length; i++)
		{
			GhoulAfterEffects component = Camera.allCameras[i].GetComponent<GhoulAfterEffects>();
			if (component != null)
			{
				component.blurSize = blurSize;
				component.blurIterations = blurIterations;
				component.intensity = screenIntensity;
				component.threshhold = screenLuminanceThreshold;
			}
		}
	}
}
