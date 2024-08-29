using Script;
using UnityEngine;
using UnityWrap;

public class OnCameraTrigger : MonoBehaviour
{
	public GameObject eventTarget;

	private string enterCallback;

	private void Start()
	{
		enterCallback = "OnEnterCamera";
	}

	private void OnTriggerEnter(Collider other)
	{
		NotifyEvent2Lua(other);
	}

	private void NotifyEvent2Lua(Collider other)
	{
		string function = "g_OnCameraDirChange";
		AssetGameObject assetGameObject = AssetGameObject.CreateByInstance(base.gameObject);
		Vector3 forward = base.gameObject.transform.forward;
		Quaternion rotation = base.gameObject.transform.rotation;
		Vector3 forward2 = base.gameObject.transform.forward;
		ScriptManager.GetInstance().CallFunction(function, other.gameObject.name, forward2.x, forward2.y, forward2.z, rotation.eulerAngles.y);
	}
}
