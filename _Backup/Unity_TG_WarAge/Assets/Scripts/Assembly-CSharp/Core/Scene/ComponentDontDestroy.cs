using UnityEngine;

namespace Core.Scene
{
	public class ComponentDontDestroy : MonoBehaviour
	{
		private void Start()
		{
			Object.DontDestroyOnLoad(base.gameObject);
		}
	}
}
