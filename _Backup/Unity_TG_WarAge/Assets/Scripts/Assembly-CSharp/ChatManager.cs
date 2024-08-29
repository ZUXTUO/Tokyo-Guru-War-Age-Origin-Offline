using System.Collections;
using System.Collections.Generic;
using UnityEngine;

[AddComponentMenu("NGUI/Examples/Chat Manager")]
public class ChatManager : MonoBehaviour
{
	public static ChatManager instance;

	public string[] chatMessages;

	public LookAtTarget cameraLookAt;

	private List<ChatParticipant> mParticipants = new List<ChatParticipant>();

	private int mCurrentChatter;

	private int mCurrentMessage;

	private bool mDisplay;

	private void Awake()
	{
		instance = this;
	}

	private void OnDestroy()
	{
		instance = null;
	}

	public void AddParticipant(ChatParticipant participant)
	{
		mParticipants.Add(participant);
	}

	private void Update()
	{
		if (!mDisplay && chatMessages != null)
		{
			StartCoroutine(ProgressChat());
		}
	}

	private IEnumerator ProgressChat()
	{
		mDisplay = true;
		HUDText ct = mParticipants[mCurrentChatter].hudText;
		if (ct != null)
		{
			ct.Add(chatMessages[mCurrentMessage].Replace("\\n", "\n"), Color.white, 2f);
			cameraLookAt.target = mParticipants[mCurrentChatter].lookAt;
		}
		yield return new WaitForSeconds(4f);
		mCurrentChatter++;
		mCurrentMessage++;
		if (mCurrentChatter >= mParticipants.Count)
		{
			mCurrentChatter = 0;
		}
		if (mCurrentMessage >= chatMessages.Length)
		{
			mCurrentMessage = 0;
			yield return new WaitForSeconds(5f);
		}
		mDisplay = false;
	}
}
