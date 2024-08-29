using Core;
using Core.Unity;
using UnityEngine;
using Wraper;

namespace UnityWrap
{
	public class RenderTextureWrap : BaseObject
	{
		public static AssetObjectCache<int, RenderTextureWrap> cache = new AssetObjectCache<int, RenderTextureWrap>();

		private RenderTexture mRenderTexture;

		private bool isDestory = true;

		public RenderTexture component
		{
			get
			{
				return mRenderTexture;
			}
		}

		public RenderTextureWrap()
		{
			lua_class_name = render_texture_wraper.name;
		}

		public static RenderTextureWrap CreateInstance(RenderTexture com)
		{
			if (com == null)
			{
				Core.Unity.Debug.LogWarning("[RenderTextureWrap CreateInstance] error: render texture is null ");
				return null;
			}
			RenderTextureWrap renderTextureWrap = new RenderTextureWrap();
			renderTextureWrap.mRenderTexture = com;
			cache.Add(renderTextureWrap.GetPid(), renderTextureWrap);
			return renderTextureWrap;
		}

		public static RenderTextureWrap Create(int width, int height, int depth, int format = 7)
		{
			RenderTextureWrap renderTextureWrap = new RenderTextureWrap();
			renderTextureWrap.mRenderTexture = new RenderTexture(width, height, depth, (RenderTextureFormat)format);
			renderTextureWrap.mRenderTexture.Create();
			cache.Add(renderTextureWrap.GetPid(), renderTextureWrap);
			return renderTextureWrap;
		}

		public static void DestroyInstance(RenderTextureWrap obj)
		{
			if (obj == null)
			{
				return;
			}
			cache.Remove(obj.GetPid());
			if (!(obj.mRenderTexture != null))
			{
				return;
			}
			Camera[] allCameras = Camera.allCameras;
			for (int i = 0; i < allCameras.Length; i++)
			{
				if (allCameras[i].targetTexture == obj.mRenderTexture)
				{
					allCameras[i].targetTexture = null;
					break;
				}
			}
			obj.mRenderTexture.Release();
			obj.mRenderTexture = null;
		}
	}
}
