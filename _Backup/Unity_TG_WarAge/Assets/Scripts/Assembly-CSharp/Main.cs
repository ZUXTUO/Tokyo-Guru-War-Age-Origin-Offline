using System.Threading;
using UnityEngine;

public class Main : MonoBehaviour
{
	private App3 app;

	private UtilWraper util;

	public static int mainThreadId;

	private void Start()
	{
		mainThreadId = Thread.CurrentThread.ManagedThreadId;
		Screen.sleepTimeout = -1;
		Object.DontDestroyOnLoad(base.gameObject);
		app = App3.GetInstance();
		app.Run();
		util = UtilWraper.GetInstance();
		util.Run();
	}

	private void Awake()
	{
		Application.targetFrameRate = 30;
	}
}
