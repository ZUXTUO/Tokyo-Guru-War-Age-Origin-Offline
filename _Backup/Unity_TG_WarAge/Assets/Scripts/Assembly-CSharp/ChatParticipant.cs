using UnityEngine;

[AddComponentMenu("NGUI/Examples/Chat Participant")]
public class ChatParticipant : MonoBehaviour
{
	public GameObject prefab;

	public Transform lookAt;

	private HUDText mText;

	public HUDText hudText
	{
		get
		{
			return mText;
		}
	}

	private void Start()
	{
		if (HUDRoot.go == null)
		{
			Object.Destroy(this);
			return;
		}
		GameObject gameObject = NGUITools.AddChild(HUDRoot.go, prefab);
		mText = gameObject.GetComponentInChildren<HUDText>();
		gameObject.AddComponent<UIFollowTarget>().target = base.transform;
		if (ChatManager.instance != null)
		{
			ChatManager.instance.AddParticipant(this);
		}
	}
}
