using System;
using UnityEngine.Events;

namespace RenderHeads.Media.AVProVideo
{
	[Serializable]
	public class MediaPlayerEvent : UnityEvent<MediaPlayer, MediaPlayerEvent.EventType, ErrorCode>
	{
		public enum EventType
		{
			MetaDataReady = 0,
			ReadyToPlay = 1,
			Started = 2,
			FirstFrameReady = 3,
			FinishedPlaying = 4,
			Closing = 5,
			Error = 6
		}
	}
}
