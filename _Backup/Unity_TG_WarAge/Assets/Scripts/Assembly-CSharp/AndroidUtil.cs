using UnityEngine;

internal class AndroidUtil
{
	private static AndroidUtil m_instance;

	private static AndroidJavaClass m_classHolder;

	public static AndroidUtil Instance()
	{
		if (m_instance == null)
		{
			m_instance = new AndroidUtil();
			m_instance.CreateClassHolder();
			m_instance.CreateMsgReceiver();
		}
		return m_instance;
	}

	private void CreateClassHolder()
	{
		if (m_classHolder == null)
		{
			m_classHolder = new AndroidJavaClass("com.digitalsky.ghoul.AndroidUtil");
		}
	}

	private void CreateMsgReceiver()
	{
		string name = "_AndroidMsgReceiver";
		GameObject gameObject = GameObject.Find(name);
		if (gameObject == null)
		{
			gameObject = new GameObject("_AndroidMsgReceiver");
			gameObject.AddComponent<AndroidMessageDispatch>();
			Object.DontDestroyOnLoad(gameObject);
		}
	}

	public long GetPathFreeSpace(string path)
	{
		long num = 0L;
		return m_classHolder.CallStatic<long>("getPathFreeSpace", new object[1] { path });
	}

	public void ExitApp()
	{
	}
}
