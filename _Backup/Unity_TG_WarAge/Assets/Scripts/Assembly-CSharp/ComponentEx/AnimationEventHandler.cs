using Script;
using UnityEngine;
using UnityWrap;

namespace ComponentEx
{
	public class AnimationEventHandler : MonoBehaviour
	{
		public string m_Customize = string.Empty;

		public void OnAnimationEvent(string str)
		{
			string[] array = str.Split('|');
			if (array.Length >= 1)
			{
				string function = array[0];
				string text = string.Empty;
				if (array.Length >= 2)
				{
					text = array[1];
				}
				AssetGameObject assetGameObject = AssetGameObject.CreateByInstance(base.gameObject);
				if (!ScriptManager.GetInstance().CallFunction(function, assetGameObject, text))
				{
					assetGameObject.ClearResources();
				}
			}
		}

		public void OnAnimationEventCustomize()
		{
			string[] array = m_Customize.Split('|');
			if (array.Length >= 1)
			{
				string function = array[0];
				string text = string.Empty;
				if (array.Length >= 2)
				{
					text = array[1];
				}
				AssetGameObject assetGameObject = AssetGameObject.CreateByInstance(base.gameObject);
				if (!ScriptManager.GetInstance().CallFunction(function, assetGameObject, text))
				{
					assetGameObject.ClearResources();
				}
			}
		}
	}
}
