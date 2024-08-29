using Script;
using UnityEngine;

namespace ComponentEx
{
	public class MonoHandler : MonoBehaviour
	{
		public string onStart = string.Empty;

		public string onAwake = string.Empty;

		public string onUpdate = string.Empty;

		public string onLateUpdate = string.Empty;

		public string onDestory = string.Empty;

		private void Start()
		{
			if (!(onStart == string.Empty))
			{
				ScriptManager.GetInstance().CallFunction(onStart);
			}
		}

		private void Awake()
		{
			if (!(onAwake == string.Empty))
			{
				ScriptManager.GetInstance().CallFunction(onAwake);
			}
		}

		private void Update()
		{
			if (!(onUpdate == string.Empty))
			{
				ScriptManager.GetInstance().CallFunction(onUpdate);
			}
		}

		private void LateUpdate()
		{
			if (!(onLateUpdate == string.Empty))
			{
				ScriptManager.GetInstance().CallFunction(onLateUpdate);
			}
		}

		private void OnDestory()
		{
			if (!(onDestory == string.Empty))
			{
				ScriptManager.GetInstance().CallFunction(onDestory);
			}
		}
	}
}
