using UnityEngine;

public class TDManager : MonoBehaviourEx
{
	private static string m_name = "_TDManager";

	private static TDManager m_instance;

	public static TDManager GetInstance()
	{
		if (m_instance == null)
		{
			GameObject gameObject = MonoBehaviourEx.CreateGameObject(m_name);
			m_instance = gameObject.AddComponent<TDManager>();
		}
		return m_instance;
	}

	public bool Submit(string type, string data)
	{
		bool flag = false;
		return AndroidTDManager.Submit(type, data);
	}
}
