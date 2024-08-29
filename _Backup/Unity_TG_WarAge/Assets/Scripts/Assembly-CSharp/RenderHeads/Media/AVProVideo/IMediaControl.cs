using UnityEngine;

namespace RenderHeads.Media.AVProVideo
{
	public interface IMediaControl
	{
		bool OpenVideoFromFile(string path);

		void CloseVideo();

		void SetLooping(bool bLooping);

		bool IsLooping();

		bool HasMetaData();

		bool CanPlay();

		bool IsPlaying();

		bool IsSeeking();

		bool IsPaused();

		bool IsFinished();

		bool IsBuffering();

		void Play();

		void Pause();

		void Stop();

		void Rewind();

		void Seek(float timeMs);

		void SeekFast(float timeMs);

		float GetCurrentTimeMs();

		float GetPlaybackRate();

		void SetPlaybackRate(float rate);

		void MuteAudio(bool bMute);

		bool IsMuted();

		void SetVolume(float volume);

		float GetVolume();

		ErrorCode GetLastError();

		void SetTextureProperties(FilterMode filterMode = FilterMode.Bilinear, TextureWrapMode wrapMode = TextureWrapMode.Clamp, int anisoLevel = 1);
	}
}
