using UnityEngine;

public class ShowFPS : MonoBehaviour
{
	public bool isShowFps = true;

	public float f_UpdateInterval = 0.5f;

	private float f_LastInterval;

	private int i_Frames;

	private float f_Fps;

	private GUIStyle m_FPSUIStyle;

	private void Awake()
	{
	}

	private void Start()
	{
		f_LastInterval = Time.realtimeSinceStartup;
		i_Frames = 0;
		m_FPSUIStyle = new GUIStyle();
		m_FPSUIStyle.fontSize = 50;
		m_FPSUIStyle.fontStyle = FontStyle.Bold;
		m_FPSUIStyle.normal.textColor = new Color(1f, 1f, 1f, 1f);
	}

	private void OnGUI()
	{
		if (isShowFps)
		{
			GUI.Label(new Rect(10f, 150f, 200f, 200f), "FPS:" + f_Fps.ToString("f2"), m_FPSUIStyle);
		}
	}

	private void Update()
	{
		i_Frames++;
		if (Time.realtimeSinceStartup > f_LastInterval + f_UpdateInterval)
		{
			f_Fps = (float)i_Frames / (Time.realtimeSinceStartup - f_LastInterval);
			i_Frames = 0;
			f_LastInterval = Time.realtimeSinceStartup;
		}
	}
}
