using System;
using UnityEngine;

[Serializable]
[RequireComponent(typeof(Camera))]
[ExecuteInEditMode]
[AddComponentMenu("Image Effects/Noise/Noise And Grain (Filmic)")]
public class NoiseAndGrain : PostEffectsBase
{
	public float intensityMultiplier;

	public float generalIntensity;

	public float blackIntensity;

	public float whiteIntensity;

	public float midGrey;

	public bool dx11Grain;

	public float softness;

	public bool monochrome;

	public Vector3 intensities;

	public Vector3 tiling;

	public float monochromeTiling;

	public FilterMode filterMode;

	public Texture2D noiseTexture;

	public Shader noiseShader;

	private Material noiseMaterial;

	public Shader dx11NoiseShader;

	private Material dx11NoiseMaterial;

	[NonSerialized]
	private static float TILE_AMOUNT = 64f;

	public NoiseAndGrain()
	{
		intensityMultiplier = 0.25f;
		generalIntensity = 0.5f;
		blackIntensity = 1f;
		whiteIntensity = 1f;
		midGrey = 0.2f;
		intensities = new Vector3(1f, 1f, 1f);
		tiling = new Vector3(64f, 64f, 64f);
		monochromeTiling = 64f;
		filterMode = FilterMode.Bilinear;
	}

	public override bool CheckResources()
	{
		CheckSupport(false);
		noiseMaterial = CheckShaderAndCreateMaterial(noiseShader, noiseMaterial);
		if (dx11Grain && supportDX11)
		{
			dx11NoiseMaterial = CheckShaderAndCreateMaterial(dx11NoiseShader, dx11NoiseMaterial);
		}
		if (!isSupported)
		{
			ReportAutoDisable();
		}
		return isSupported;
	}

	public virtual void OnRenderImage(RenderTexture source, RenderTexture destination)
	{
		if (!CheckResources() || null == noiseTexture)
		{
			Graphics.Blit(source, destination);
			if (null == noiseTexture)
			{
				Debug.LogWarning("Noise & Grain effect failing as noise texture is not assigned. please assign.", transform);
			}
			return;
		}
		softness = Mathf.Clamp(softness, 0f, 0.99f);
		if (dx11Grain && supportDX11)
		{
			dx11NoiseMaterial.SetFloat("_DX11NoiseTime", Time.frameCount);
			dx11NoiseMaterial.SetTexture("_NoiseTex", noiseTexture);
			dx11NoiseMaterial.SetVector("_NoisePerChannel", (!monochrome) ? intensities : Vector3.one);
			dx11NoiseMaterial.SetVector("_MidGrey", new Vector3(midGrey, 1f / (1f - midGrey), -1f / midGrey));
			dx11NoiseMaterial.SetVector("_NoiseAmount", new Vector3(generalIntensity, blackIntensity, whiteIntensity) * intensityMultiplier);
			if (!(softness <= Mathf.Epsilon))
			{
				RenderTexture temporary = RenderTexture.GetTemporary((int)((float)source.width * (1f - softness)), (int)((float)source.height * (1f - softness)));
				DrawNoiseQuadGrid(source, temporary, dx11NoiseMaterial, noiseTexture, (!monochrome) ? 2 : 3);
				dx11NoiseMaterial.SetTexture("_NoiseTex", temporary);
				Graphics.Blit(source, destination, dx11NoiseMaterial, 4);
				RenderTexture.ReleaseTemporary(temporary);
			}
			else
			{
				DrawNoiseQuadGrid(source, destination, dx11NoiseMaterial, noiseTexture, monochrome ? 1 : 0);
			}
			return;
		}
		if ((bool)noiseTexture)
		{
			noiseTexture.wrapMode = TextureWrapMode.Repeat;
			noiseTexture.filterMode = filterMode;
		}
		noiseMaterial.SetTexture("_NoiseTex", noiseTexture);
		noiseMaterial.SetVector("_NoisePerChannel", (!monochrome) ? intensities : Vector3.one);
		noiseMaterial.SetVector("_NoiseTilingPerChannel", (!monochrome) ? tiling : (Vector3.one * monochromeTiling));
		noiseMaterial.SetVector("_MidGrey", new Vector3(midGrey, 1f / (1f - midGrey), -1f / midGrey));
		noiseMaterial.SetVector("_NoiseAmount", new Vector3(generalIntensity, blackIntensity, whiteIntensity) * intensityMultiplier);
		if (!(softness <= Mathf.Epsilon))
		{
			RenderTexture temporary2 = RenderTexture.GetTemporary((int)((float)source.width * (1f - softness)), (int)((float)source.height * (1f - softness)));
			DrawNoiseQuadGrid(source, temporary2, noiseMaterial, noiseTexture, 2);
			noiseMaterial.SetTexture("_NoiseTex", temporary2);
			Graphics.Blit(source, destination, noiseMaterial, 1);
			RenderTexture.ReleaseTemporary(temporary2);
		}
		else
		{
			DrawNoiseQuadGrid(source, destination, noiseMaterial, noiseTexture, 0);
		}
	}

	public static void DrawNoiseQuadGrid(RenderTexture source, RenderTexture dest, Material fxMaterial, Texture2D noise, int passNr)
	{
		RenderTexture.active = dest;
		float num = (float)noise.width * 1f;
		float num2 = 1f * (float)source.width / TILE_AMOUNT;
		fxMaterial.SetTexture("_MainTex", source);
		GL.PushMatrix();
		GL.LoadOrtho();
		float num3 = 1f * (float)source.width / (1f * (float)source.height);
		float num4 = 1f / num2;
		float num5 = num4 * num3;
		float num6 = num / ((float)noise.width * 1f);
		fxMaterial.SetPass(passNr);
		GL.Begin(7);
		for (float num7 = 0f; num7 < 1f; num7 += num4)
		{
			for (float num8 = 0f; num8 < 1f; num8 += num5)
			{
				float num9 = UnityEngine.Random.Range(0f, 1f);
				float num10 = UnityEngine.Random.Range(0f, 1f);
				num9 = Mathf.Floor(num9 * num) / num;
				num10 = Mathf.Floor(num10 * num) / num;
				float num11 = 1f / num;
				GL.MultiTexCoord2(0, num9, num10);
				GL.MultiTexCoord2(1, 0f, 0f);
				GL.Vertex3(num7, num8, 0.1f);
				GL.MultiTexCoord2(0, num9 + num6 * num11, num10);
				GL.MultiTexCoord2(1, 1f, 0f);
				GL.Vertex3(num7 + num4, num8, 0.1f);
				GL.MultiTexCoord2(0, num9 + num6 * num11, num10 + num6 * num11);
				GL.MultiTexCoord2(1, 1f, 1f);
				GL.Vertex3(num7 + num4, num8 + num5, 0.1f);
				GL.MultiTexCoord2(0, num9, num10 + num6 * num11);
				GL.MultiTexCoord2(1, 0f, 1f);
				GL.Vertex3(num7, num8 + num5, 0.1f);
			}
		}
		GL.End();
		GL.PopMatrix();
	}

	public override void Main()
	{
	}
}
