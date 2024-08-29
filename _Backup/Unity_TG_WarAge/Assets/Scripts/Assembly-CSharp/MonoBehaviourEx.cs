using UnityEngine;

public class MonoBehaviourEx : MonoBehaviour
{
	public static Transform parentTransform;

	public static GameObject CreateGameObject(string name)
	{
		GameObject gameObject = null;
		gameObject = ((name == null) ? new GameObject() : new GameObject(name));
		if (parentTransform != null)
		{
			gameObject.transform.parent = parentTransform;
		}
		else
		{
			Object.DontDestroyOnLoad(gameObject);
		}
		return gameObject;
	}
}
