using UnityEngine;

internal class NGUIManager : MonoBehaviourEx
{
	private static string go_name = "_NGUIManager";

	private static NGUIManager instance;

	public static bool bShowGUI;

	public static NGUIManager GetInstance()
	{
		if (instance == null)
		{
			GameObject gameObject = MonoBehaviourEx.CreateGameObject(go_name);
			instance = gameObject.AddComponent<NGUIManager>();
		}
		return instance;
	}

	public int Load(string name)
	{
		string url = "file:///" + Application.dataPath + "/../ngui/" + name + ".assetbundle";
		WWW wWW = new WWW(url);
		Object.Instantiate(wWW.assetBundle.mainAsset);
		return 0;
	}
}
