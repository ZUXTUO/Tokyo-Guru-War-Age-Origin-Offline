using UnityEngine;

namespace RenderHeads.Media.AVProVideo
{
	public interface IMediaProducer
	{
		Texture GetTexture();

		int GetTextureFrameCount();

		bool RequiresVerticalFlip();
	}
}
