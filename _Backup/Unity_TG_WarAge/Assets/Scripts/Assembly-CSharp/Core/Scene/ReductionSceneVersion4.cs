using UnityEngine;

namespace Core.Scene
{
	public class ReductionSceneVersion4 : MonoBehaviour
	{
		private bool isCom;

		private void Start()
		{
			ScenePrintUtil.Log("GameObject Start $$$$$$$$ ");
		}

		private void aaa()
		{
			Transform transform = Camera.main.transform;
			transform.position = new Vector3(20f, 24f, -24f);
			transform.rotation = Quaternion.Euler(new Vector3(70f, 0f, 0f));
		}

		private void bbb()
		{
			Debug.Log("************* OnLevelDetailLoaded ***************");
			isCom = true;
		}

		private void aaaProgress(float val)
		{
		}

		private void bbbProgress(float val)
		{
		}

		private void Update()
		{
			if (!isCom)
			{
			}
		}
	}
}
