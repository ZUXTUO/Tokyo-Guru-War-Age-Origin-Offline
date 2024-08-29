using UnityEngine;

namespace RenderHeads.Media.AVProVideo
{
	public static class Helper
	{
		public const string ScriptVersion = "1.3.9";

		public static string GetName(Platform platform)
		{
			string text = "Unknown";
			return platform.ToString();
		}

		public static string[] GetPlatformNames()
		{
			return new string[7]
			{
				GetName(Platform.Windows),
				GetName(Platform.MacOSX),
				GetName(Platform.iOS),
				GetName(Platform.tvOS),
				GetName(Platform.Android),
				GetName(Platform.WindowsPhone),
				GetName(Platform.WindowsUWP)
			};
		}

		public static string GetTimeString(float totalSeconds)
		{
			int num = Mathf.FloorToInt(totalSeconds / 3600f);
			float num2 = (float)num * 60f * 60f;
			int num3 = Mathf.FloorToInt((totalSeconds - num2) / 60f);
			num2 += (float)num3 * 60f;
			int num4 = Mathf.RoundToInt(totalSeconds - num2);
			string text = num3.ToString("00") + ":" + num4.ToString("00");
			if (num > 0)
			{
				text = num + ":" + text;
			}
			return text;
		}

		public static void SetupStereoMaterial(Material material, StereoPacking packing, bool displayDebugTinting)
		{
			material.DisableKeyword("STEREO_TOP_BOTTOM");
			material.DisableKeyword("STEREO_LEFT_RIGHT");
			material.DisableKeyword("MONOSCOPIC");
			switch (packing)
			{
			case StereoPacking.TopBottom:
				material.EnableKeyword("STEREO_TOP_BOTTOM");
				break;
			case StereoPacking.LeftRight:
				material.EnableKeyword("STEREO_LEFT_RIGHT");
				break;
			}
			material.DisableKeyword("STEREO_DEBUG_OFF");
			material.DisableKeyword("STEREO_DEBUG");
			if (displayDebugTinting)
			{
				material.EnableKeyword("STEREO_DEBUG");
			}
		}

		public static Texture2D GetReadableTexture(Texture inputTexture, bool requiresVerticalFlip, Texture2D targetTexture)
		{
			Texture2D texture2D = targetTexture;
			RenderTexture active = RenderTexture.active;
			RenderTexture temporary = RenderTexture.GetTemporary(inputTexture.width, inputTexture.height, 0, RenderTextureFormat.ARGB32);
			if (!requiresVerticalFlip)
			{
				Graphics.Blit(inputTexture, temporary);
			}
			else
			{
				GL.PushMatrix();
				RenderTexture.active = temporary;
				GL.LoadPixelMatrix(0f, temporary.width, 0f, temporary.height);
				Rect sourceRect = new Rect(0f, 0f, 1f, 1f);
				Rect screenRect = new Rect(0f, -1f, temporary.width, temporary.height);
				Graphics.DrawTexture(screenRect, inputTexture, sourceRect, 0, 0, 0, 0);
				GL.PopMatrix();
				GL.InvalidateState();
			}
			if (texture2D == null)
			{
				texture2D = new Texture2D(inputTexture.width, inputTexture.height, TextureFormat.ARGB32, false);
			}
			RenderTexture.active = temporary;
			texture2D.ReadPixels(new Rect(0f, 0f, inputTexture.width, inputTexture.height), 0, 0, false);
			texture2D.Apply(false, false);
			RenderTexture.ReleaseTemporary(temporary);
			RenderTexture.active = active;
			return texture2D;
		}
	}
}
