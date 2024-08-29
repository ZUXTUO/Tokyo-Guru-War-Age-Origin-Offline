using Script;
using UnityEngine;
using UnityWrap;

namespace ComponentEx
{
	public class TriggerHandler : MonoBehaviour
	{
		public string onTriggerEnter = string.Empty;

		public string onTriggerStay = string.Empty;

		public string onTriggerExit = string.Empty;

		private void Awake()
		{
			if (!base.gameObject.GetComponent<Rigidbody>())
			{
				Rigidbody rigidbody = base.gameObject.AddComponent<Rigidbody>();
				rigidbody.useGravity = false;
			}
			if ((bool)base.gameObject.GetComponent<Collider>())
			{
				base.gameObject.GetComponent<Collider>().isTrigger = true;
			}
		}

		private void OnTriggerEnter(Collider other)
		{
			if (!(onTriggerEnter == string.Empty))
			{
				AssetGameObject assetGameObject = AssetGameObject.CreateByInstance(other.gameObject);
				AssetGameObject assetGameObject2 = AssetGameObject.CreateByInstance(base.gameObject);
				if (!ScriptManager.GetInstance().CallFunction(onTriggerEnter, assetGameObject, assetGameObject2))
				{
					assetGameObject.ClearResources();
					assetGameObject2.ClearResources();
				}
			}
		}

		private void OnTriggerStay(Collider other)
		{
			if (!(onTriggerStay == string.Empty))
			{
				AssetGameObject assetGameObject = AssetGameObject.CreateByInstance(other.gameObject);
				AssetGameObject assetGameObject2 = AssetGameObject.CreateByInstance(base.gameObject);
				if (!ScriptManager.GetInstance().CallFunction(onTriggerStay, assetGameObject, assetGameObject2))
				{
					assetGameObject.ClearResources();
					assetGameObject2.ClearResources();
				}
			}
		}

		private void OnTriggerExit(Collider other)
		{
			if (!(onTriggerExit == string.Empty))
			{
				AssetGameObject assetGameObject = AssetGameObject.CreateByInstance(other.gameObject);
				AssetGameObject assetGameObject2 = AssetGameObject.CreateByInstance(base.gameObject);
				if (!ScriptManager.GetInstance().CallFunction(onTriggerExit, assetGameObject, assetGameObject2))
				{
					assetGameObject.ClearResources();
					assetGameObject2.ClearResources();
				}
			}
		}
	}
}
