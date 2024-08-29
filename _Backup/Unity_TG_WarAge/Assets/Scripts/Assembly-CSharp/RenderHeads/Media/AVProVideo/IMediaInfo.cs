namespace RenderHeads.Media.AVProVideo
{
	public interface IMediaInfo
	{
		float GetDurationMs();

		int GetVideoWidth();

		int GetVideoHeight();

		float GetVideoPlaybackRate();

		bool HasVideo();

		bool HasAudio();
	}
}
