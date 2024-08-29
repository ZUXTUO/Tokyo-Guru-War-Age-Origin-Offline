using System.Collections.Generic;
using Script;
using UnityEngine;
using UnityEngine.Rendering;

public class GhoulAfterEffects : MonoBehaviourEx
{
	public enum AAMode
	{
		FXAA2 = 0,
		FXAA3Console = 1,
		FXAA1PresetA = 2,
		FXAA1PresetB = 3,
		NFAA = 4,
		SSAA = 5,
		DLAA = 6
	}

	public enum BlurResolution
	{
		Low = 0,
		High = 1
	}

	public enum Resolution
	{
		Low = 0,
		Medium = 1,
		High = 2
	}

	public enum BlurType
	{
		Standard = 0,
		Sgx = 1
	}

	public bool AAenabled;

	public AAMode mode = AAMode.FXAA3Console;

	public bool showGeneratedNormals;

	public float offsetScale = 0.2f;

	public float blurRadius = 18f;

	public float edgeThresholdMin = 0.05f;

	public float edgeThreshold = 0.2f;

	public float edgeSharpness = 4f;

	public bool dlaaSharp;

	public Shader ssaaShader;

	private Material ssaa;

	public Shader dlaaShader;

	private Material dlaa;

	public Shader nfaaShader;

	private Material nfaa;

	public Shader shaderFXAAPreset2;

	private Material materialFXAAPreset2;

	public Shader shaderFXAAPreset3;

	private Material materialFXAAPreset3;

	public Shader shaderFXAAII;

	private Material materialFXAAII;

	public Shader shaderFXAAIII;

	private Material materialFXAAIII;

	private static string go_name = "_AfterEffect";

	private static GhoulAfterEffects instance;

	[Range(0f, 1.5f)]
	public float threshhold = 0.5f;

	[Range(0f, 5f)]
	public float intensity = 2f;

	[Range(0.25f, 10f)]
	public float blurSize = 2.5f;

	public BlurResolution blurResolution = BlurResolution.High;

	public Resolution resolution = Resolution.High;

	[Range(1f, 4f)]
	public int blurIterations = 2;

	public BlurType blurType = BlurType.Sgx;

	public Shader ghoulAfterEffctShader;

	public Shader waterDistortionShader;

	public Material ghoulAfterEffectMaterial;

	public Transform DofTarget;

	public float DofDistance;

	public Vector3 viewPos;

	public bool upsideDown = true;

	public static RenderBuffer mainDisplayColorBuffer;

	public static RenderBuffer mainDisplayDepthBuffer;

	public static bool isSetRenderBuffer;

	public string onCameraChangeScript;

	private StarWarsShadow sws;

	public Camera targetCam;

	private LayerMask playerLayerMask;

	private int backCullMask;

	private int normalCullMask;

	private int fontCullMask;

	[Range(0f, 1f)]
	public float focusDepth = 1f;

	public float focusDistance = 10f;

	private bool lastEnableDistortion;

	public RenderTexture distortionRT;

	public bool enableBloom = true;

	public bool enableDistortion;

	public bool enableDOF;

	public bool enableBackgroundBlur;

	private CommandBuffer distortionCommand;

	private List<Material> storedShockMatList;

	private List<Material> usedShockMatList;

	private List<Material> storedWaterMatList;

	private List<Material> usedWaterMatList;

	public RenderTexture colorRT;

	public RenderTexture depthRT;

	public RenderTexture backgroundBlurRT;

	public GameObject backgroundCamObj;

	private Camera backgroundCam;

	private Color distortionClearColor = new Color(0.5f, 0.5f, 0.5f, 0.5f);

	private Animator DofTargetAnim;

	public Material material
	{
		get
		{
			if (ghoulAfterEffectMaterial == null)
			{
				ghoulAfterEffectMaterial = new Material(ghoulAfterEffctShader);
			}
			return ghoulAfterEffectMaterial;
		}
	}

	private Material CurrentAAMaterial()
	{
		Material material = null;
		switch (mode)
		{
		case AAMode.FXAA3Console:
			return materialFXAAIII;
		case AAMode.FXAA2:
			return materialFXAAII;
		case AAMode.FXAA1PresetA:
			return materialFXAAPreset2;
		case AAMode.FXAA1PresetB:
			return materialFXAAPreset3;
		case AAMode.NFAA:
			return nfaa;
		case AAMode.SSAA:
			return ssaa;
		case AAMode.DLAA:
			return dlaa;
		default:
			return null;
		}
	}

	private bool CheckSupport()
	{
		if (!SystemInfo.supportsImageEffects || !SystemInfo.supportsRenderTextures)
		{
			Debug.LogWarning("This platform does not support image effects or render textures.");
			return false;
		}
		return true;
	}

	protected Material CheckShaderAndCreateMaterial(Shader shader, Material material)
	{
		if (shader == null)
		{
			return null;
		}
		if (shader.isSupported && (bool)material && material.shader == shader)
		{
			return material;
		}
		if (!shader.isSupported)
		{
			return null;
		}
		material = new Material(shader);
		material.hideFlags = HideFlags.DontSave;
		if ((bool)material)
		{
			return material;
		}
		return null;
	}

	private void AARenderImage(RenderTexture source, RenderTexture destination)
	{
		if (mode == AAMode.FXAA3Console && materialFXAAIII != null)
		{
			materialFXAAIII.SetFloat("_EdgeThresholdMin", edgeThresholdMin);
			materialFXAAIII.SetFloat("_EdgeThreshold", edgeThreshold);
			materialFXAAIII.SetFloat("_EdgeSharpness", edgeSharpness);
			Graphics.Blit(source, destination, materialFXAAIII);
		}
		else if (mode == AAMode.FXAA1PresetB && materialFXAAPreset3 != null)
		{
			Graphics.Blit(source, destination, materialFXAAPreset3);
		}
		else if (mode == AAMode.FXAA1PresetA && materialFXAAPreset2 != null)
		{
			source.anisoLevel = 4;
			Graphics.Blit(source, destination, materialFXAAPreset2);
			source.anisoLevel = 0;
		}
		else if (mode == AAMode.FXAA2 && materialFXAAII != null)
		{
			Graphics.Blit(source, destination, materialFXAAII);
		}
		else if (mode == AAMode.SSAA && ssaa != null)
		{
			Graphics.Blit(source, destination, ssaa);
		}
		else if (mode == AAMode.DLAA && dlaa != null)
		{
			source.anisoLevel = 0;
			RenderTexture temporary = RenderTexture.GetTemporary(source.width, source.height);
			Graphics.Blit(source, temporary, dlaa, 0);
			Graphics.Blit(temporary, destination, dlaa, (!dlaaSharp) ? 1 : 2);
			RenderTexture.ReleaseTemporary(temporary);
		}
		else if (mode == AAMode.NFAA && nfaa != null)
		{
			source.anisoLevel = 0;
			nfaa.SetFloat("_OffsetScale", offsetScale);
			nfaa.SetFloat("_BlurRadius", blurRadius);
			Graphics.Blit(source, destination, nfaa, showGeneratedNormals ? 1 : 0);
		}
		else
		{
			Graphics.Blit(source, destination);
		}
	}

	public static GhoulAfterEffects GetInstance()
	{
		if (instance == null)
		{
			GameObject gameObject = MonoBehaviourEx.CreateGameObject(go_name);
			instance = gameObject.AddComponent<GhoulAfterEffects>();
		}
		return instance;
	}

	public void setTargetCamera(Camera cam)
	{
		if (cam != null)
		{
			if (targetCam != cam)
			{
				CameraRenderEventCallBack component;
				if (targetCam != null)
				{
					component = targetCam.gameObject.GetComponent<CameraRenderEventCallBack>();
					Object.Destroy(component);
				}
				targetCam = cam;
				Bloom component2 = targetCam.GetComponent<Bloom>();
				if (component2 != null)
				{
					Object.DestroyImmediate(component2);
				}
				if (onCameraChangeScript != null && targetCam.transform.parent != null)
				{
					string text = targetCam.transform.parent.name + "/" + targetCam.name;
					ScriptManager.GetInstance().CallFunction(onCameraChangeScript, text);
				}
				component = targetCam.gameObject.AddComponent<CameraRenderEventCallBack>();
				component.preRenderCall = OnCameraPreRender;
				component.postRenderCall = OnCameraPostRender;
				component.preCullCall = OnCameraPreCull;
				base.enabled = true;
				Init();
			}
		}
		else
		{
			if (targetCam != null)
			{
				CameraRenderEventCallBack component = targetCam.gameObject.GetComponent<CameraRenderEventCallBack>();
				Object.Destroy(component);
			}
			targetCam = null;
			base.enabled = false;
		}
	}

	private void Update()
	{
		if (sws != null)
		{
			int qualityLevel = QualitySettings.GetQualityLevel();
			if (qualityLevel == 2)
			{
				if (!sws.gameObject.activeInHierarchy)
				{
					sws.gameObject.SetActive(true);
				}
				if (!sws.enabled)
				{
					sws.enabled = true;
				}
			}
		}
		int num = (int)((resolution == Resolution.High) ? ((float)Screen.width) : ((resolution != Resolution.Medium) ? ((float)Screen.width * 0.5f) : ((float)Screen.width * 0.75f)));
		int num2 = (int)((resolution == Resolution.High) ? ((float)Screen.height) : ((resolution != Resolution.Medium) ? ((float)Screen.height * 0.5f) : ((float)Screen.height * 0.75f)));
		if (enableBackgroundBlur)
		{
			if (backgroundBlurRT == null)
			{
				backgroundBlurRT = new RenderTexture(num / 4, num2 / 4, 24);
				backgroundCamObj = new GameObject("backgroundCamObj");
				backgroundCam = backgroundCamObj.AddComponent<Camera>();
			}
			if (backgroundCamObj != null)
			{
				backgroundCam.CopyFrom(targetCam);
				backgroundCam.cullingMask = backCullMask;
				backgroundCam.allowHDR = false;
				backgroundCam.allowMSAA = false;
				backgroundCam.useOcclusionCulling = false;
				backgroundCam.backgroundColor = Color.black;
				backgroundCam.clearFlags = CameraClearFlags.Color;
				backgroundCam.targetTexture = backgroundBlurRT;
				backgroundCam.depth = targetCam.depth - 1f;
				backgroundCamObj.transform.parent = targetCam.transform.parent;
				backgroundCamObj.transform.position = targetCam.transform.position;
				backgroundCamObj.transform.rotation = targetCam.transform.rotation;
				backgroundCamObj.transform.localScale = base.transform.transform.localScale;
			}
		}
		else if (backgroundBlurRT != null)
		{
			backgroundBlurRT.Release();
			backgroundBlurRT = null;
			Object.DestroyImmediate(backgroundCam);
			Object.DestroyImmediate(backgroundCamObj);
			backgroundCam = null;
			backgroundCamObj = null;
		}
	}

	private void Init()
	{
		if (!isSetRenderBuffer)
		{
			mainDisplayColorBuffer = Graphics.activeColorBuffer;
			mainDisplayDepthBuffer = Graphics.activeDepthBuffer;
			isSetRenderBuffer = true;
		}
		else
		{
			targetCam.clearFlags = CameraClearFlags.Color;
			targetCam.backgroundColor = Color.clear;
			targetCam.allowHDR = false;
			QualitySettings.antiAliasing = 0;
			if (targetCam.name == "fightCamera")
			{
				sws = targetCam.GetComponentInChildren<StarWarsShadow>();
			}
		}
		playerLayerMask = LayerMask.NameToLayer("player");
		LayerMask layerMask = LayerMask.NameToLayer("ngui");
		LayerMask layerMask2 = LayerMask.NameToLayer("guide");
		LayerMask layerMask3 = LayerMask.NameToLayer("ui3d");
		LayerMask layerMask4 = LayerMask.NameToLayer("QTE");
		LayerMask layerMask5 = LayerMask.NameToLayer("camera");
		backCullMask = -1;
		backCullMask &= ~(1 << (int)playerLayerMask);
		backCullMask &= ~(1 << (int)layerMask);
		backCullMask &= ~(1 << (int)layerMask2);
		backCullMask &= ~(1 << (int)layerMask4);
		backCullMask &= ~(1 << (int)layerMask5);
		fontCullMask = 1 << (int)playerLayerMask;
		normalCullMask = backCullMask;
		normalCullMask |= 1 << (int)playerLayerMask;
		if (ghoulAfterEffctShader == null)
		{
			ghoulAfterEffctShader = App3.GetInstance().FindShader("DyShader/TokyoGhoul/GhoulAfterScreenEffect");
		}
		if (waterDistortionShader == null)
		{
			waterDistortionShader = App3.GetInstance().FindShader("DyShader/TokyoGhoul/Scene/WaterWaveDistortion");
		}
		if (shaderFXAAPreset2 == null)
		{
			shaderFXAAPreset2 = App3.GetInstance().FindShader("AA/FXAA Preset 2");
		}
		if (shaderFXAAPreset3 == null)
		{
			shaderFXAAPreset3 = App3.GetInstance().FindShader("AA/FXAA Preset 3");
		}
		if (shaderFXAAII == null)
		{
			shaderFXAAII = App3.GetInstance().FindShader("AA/FXAA II");
		}
		if (shaderFXAAIII == null)
		{
			shaderFXAAIII = App3.GetInstance().FindShader("AA/FXAA III (Console)");
		}
		if (nfaaShader == null)
		{
			nfaaShader = App3.GetInstance().FindShader("AA/NFAA");
		}
		if (ssaaShader == null)
		{
			ssaaShader = App3.GetInstance().FindShader("AA/SSAA");
		}
		if (dlaaShader == null)
		{
			dlaaShader = App3.GetInstance().FindShader("AA/DLAA");
		}
		materialFXAAPreset2 = CheckShaderAndCreateMaterial(shaderFXAAPreset2, materialFXAAPreset2);
		materialFXAAPreset3 = CheckShaderAndCreateMaterial(shaderFXAAPreset3, materialFXAAPreset3);
		materialFXAAII = CheckShaderAndCreateMaterial(shaderFXAAII, materialFXAAII);
		materialFXAAIII = CheckShaderAndCreateMaterial(shaderFXAAIII, materialFXAAIII);
		nfaa = CheckShaderAndCreateMaterial(nfaaShader, nfaa);
		ssaa = CheckShaderAndCreateMaterial(ssaaShader, ssaa);
		dlaa = CheckShaderAndCreateMaterial(dlaaShader, dlaa);
	}

	private Material getMaterialShockWave()
	{
		if (storedShockMatList == null)
		{
			storedShockMatList = new List<Material>();
		}
		Material result;
		if (storedShockMatList.Count == 0)
		{
			Shader shader = null;
			shader = App3.GetInstance().FindShader("DyShader/TokyoGhoul/ShockWaveDistortion");
			result = new Material(shader);
		}
		else
		{
			result = storedShockMatList[0];
			storedShockMatList.RemoveAt(0);
		}
		return result;
	}

	private Material getMaterialWaterWave()
	{
		if (storedWaterMatList == null)
		{
			storedWaterMatList = new List<Material>();
		}
		Material result;
		if (storedWaterMatList.Count == 0)
		{
			result = new Material(waterDistortionShader);
		}
		else
		{
			result = storedWaterMatList[0];
			storedWaterMatList.RemoveAt(0);
		}
		return result;
	}

	private void Destroy()
	{
		if (isSetRenderBuffer)
		{
			Graphics.SetRenderTarget(mainDisplayColorBuffer, mainDisplayDepthBuffer);
			if (targetCam != null)
			{
				targetCam.SetTargetBuffers(mainDisplayColorBuffer, mainDisplayDepthBuffer);
			}
		}
		if (colorRT != null)
		{
			if (RenderTexture.active == colorRT)
			{
				RenderTexture.active = null;
			}
			RenderTexture.ReleaseTemporary(colorRT);
			colorRT = null;
		}
		if (depthRT != null)
		{
			if (RenderTexture.active == depthRT)
			{
				RenderTexture.active = null;
			}
			RenderTexture.ReleaseTemporary(depthRT);
			depthRT = null;
		}
		if (targetCam != null)
		{
			CameraRenderEventCallBack component = targetCam.GetComponent<CameraRenderEventCallBack>();
			if (component != null)
			{
				Object.Destroy(component);
			}
			targetCam.RemoveAllCommandBuffers();
		}
		if (distortionCommand != null)
		{
			distortionCommand.Release();
			distortionCommand = null;
		}
	}

	private void OnEnable()
	{
		if (base.transform.name != go_name)
		{
			Object.Destroy(this);
			return;
		}
		Init();
		distortionCommand = new CommandBuffer();
		distortionCommand.name = "Draw DistortionMask";
		storedShockMatList = new List<Material>();
		usedShockMatList = new List<Material>();
		storedWaterMatList = new List<Material>();
		usedWaterMatList = new List<Material>();
	}

	private void OnDisable()
	{
		if (isSetRenderBuffer)
		{
			Graphics.SetRenderTarget(mainDisplayColorBuffer, mainDisplayDepthBuffer);
			if (targetCam != null)
			{
				targetCam.SetTargetBuffers(mainDisplayColorBuffer, mainDisplayDepthBuffer);
			}
		}
		if (targetCam != null)
		{
			CameraRenderEventCallBack component = targetCam.GetComponent<CameraRenderEventCallBack>();
			if (component != null)
			{
				Object.Destroy(component);
			}
			targetCam.RemoveAllCommandBuffers();
		}
		if (colorRT != null)
		{
			if (RenderTexture.active == colorRT)
			{
				RenderTexture.active = null;
			}
			RenderTexture.ReleaseTemporary(colorRT);
			colorRT = null;
		}
		if (depthRT != null)
		{
			if (RenderTexture.active == depthRT)
			{
				RenderTexture.active = null;
			}
			RenderTexture.ReleaseTemporary(depthRT);
			depthRT = null;
		}
		targetCam = null;
		if (distortionCommand != null)
		{
			distortionCommand.Clear();
			distortionCommand.Release();
			distortionCommand = null;
		}
		Shader.SetGlobalTexture("_DepthTexture", null);
		if (storedShockMatList != null)
		{
			storedShockMatList.RemoveRange(0, storedShockMatList.Count);
		}
		if (usedShockMatList != null)
		{
			usedShockMatList.RemoveRange(0, storedShockMatList.Count);
		}
		if (storedWaterMatList != null)
		{
			storedWaterMatList.RemoveRange(0, storedShockMatList.Count);
		}
		if (usedWaterMatList != null)
		{
			usedWaterMatList.RemoveRange(0, storedShockMatList.Count);
		}
		storedShockMatList = null;
		usedShockMatList = null;
		storedWaterMatList = null;
		usedWaterMatList = null;
	}

	private bool haveWave()
	{
		return enableDistortion && distortionRT != null;
	}

	private void OnCameraPreCull()
	{
		if (DofTarget != null && DofTarget.gameObject.activeInHierarchy)
		{
			if (DofTargetAnim == null || DofTargetAnim.name != DofTarget.name)
			{
				DofTargetAnim = DofTarget.GetComponent<Animator>();
				Renderer[] componentsInChildren = DofTarget.GetComponentsInChildren<Renderer>();
				for (int i = 0; i < componentsInChildren.Length; i++)
				{
					componentsInChildren[i].gameObject.layer = playerLayerMask;
				}
			}
			enableBackgroundBlur = true;
		}
		else
		{
			if (DofTargetAnim != null)
			{
				DofTargetAnim = null;
			}
			enableBackgroundBlur = false;
		}
		if (enableBackgroundBlur)
		{
			if (DofTarget.gameObject.layer != (int)playerLayerMask)
			{
				DofTarget.gameObject.layer = playerLayerMask;
				for (int j = 0; j < DofTarget.childCount; j++)
				{
					Transform child = DofTarget.GetChild(j);
					child.gameObject.layer = playerLayerMask;
				}
			}
			targetCam.cullingMask = fontCullMask;
		}
		else
		{
			targetCam.cullingMask = normalCullMask;
		}
	}

	private void OnCameraPreRender()
	{
		if (!base.enabled)
		{
			return;
		}
		if (!isSetRenderBuffer)
		{
			mainDisplayColorBuffer = Graphics.activeColorBuffer;
			mainDisplayDepthBuffer = Graphics.activeDepthBuffer;
			isSetRenderBuffer = true;
		}
		if (material == null)
		{
			return;
		}
		int num = (int)((resolution == Resolution.High) ? ((float)Screen.width) : ((resolution != Resolution.Medium) ? ((float)Screen.width * 0.5f) : ((float)Screen.width * 0.75f)));
		int num2 = (int)((resolution == Resolution.High) ? ((float)Screen.height) : ((resolution != Resolution.Medium) ? ((float)Screen.height * 0.5f) : ((float)Screen.height * 0.75f)));
		colorRT = RenderTexture.GetTemporary(num, num2, 0);
		colorRT.filterMode = FilterMode.Bilinear;
		depthRT = RenderTexture.GetTemporary(num, num2, 24, RenderTextureFormat.Depth);
		depthRT.filterMode = FilterMode.Bilinear;
		depthRT.SetGlobalShaderProperty("_GhoulDepthTexture");
		targetCam.SetTargetBuffers(colorRT.colorBuffer, depthRT.depthBuffer);
		targetCam.RemoveAllCommandBuffers();
		if (enableBackgroundBlur && backgroundBlurRT != null)
		{
			targetCam.clearFlags = CameraClearFlags.Depth;
			RenderTexture temporary = RenderTexture.GetTemporary(backgroundBlurRT.width, backgroundBlurRT.height, 0);
			ghoulAfterEffectMaterial.SetVector("_Parameter", new Vector4(2f, 0f, 0f, 0f));
			Graphics.Blit(backgroundBlurRT, temporary, ghoulAfterEffectMaterial, 14);
			Graphics.Blit(temporary, backgroundBlurRT, ghoulAfterEffectMaterial, 15);
			Graphics.Blit(backgroundBlurRT, temporary, ghoulAfterEffectMaterial, 14);
			Graphics.Blit(temporary, backgroundBlurRT, ghoulAfterEffectMaterial, 15);
			Graphics.Blit(backgroundBlurRT, colorRT);
			RenderTexture.ReleaseTemporary(temporary);
		}
		else
		{
			targetCam.clearFlags = CameraClearFlags.Color;
		}
		if (enableDistortion)
		{
			if (distortionCommand == null)
			{
				distortionCommand = new CommandBuffer();
				distortionCommand.name = "Draw DistortionMask";
			}
			distortionCommand.Clear();
			GameObject[] array = GameObject.FindGameObjectsWithTag("ShockWave");
			GameObject[] array2 = GameObject.FindGameObjectsWithTag("WaterWave");
			if (array.Length == 0 && array2.Length == 0)
			{
				if (distortionRT != null)
				{
					distortionRT.Release();
					distortionRT = null;
				}
				return;
			}
			if (distortionRT == null)
			{
				distortionRT = new RenderTexture(num / 4, num2 / 4, 0);
				distortionRT.filterMode = FilterMode.Bilinear;
				ghoulAfterEffectMaterial.SetTexture("_DistortionMask", distortionRT);
			}
			if (distortionRT.width != num / 4)
			{
				distortionRT.Release();
				distortionRT = new RenderTexture(num / 4, num2 / 4, 0);
			}
			distortionCommand.SetRenderTarget(distortionRT);
			distortionCommand.ClearRenderTarget(false, true, distortionClearColor);
			for (int i = 0; i < array.Length; i++)
			{
				Renderer component = array[i].GetComponent<Renderer>();
				if (component.isVisible)
				{
					Material materialShockWave = getMaterialShockWave();
					usedShockMatList.Add(materialShockWave);
					materialShockWave.CopyPropertiesFromMaterial(component.material);
					distortionCommand.DrawRenderer(component, materialShockWave);
				}
			}
			for (int j = 0; j < array2.Length; j++)
			{
				Renderer component2 = array2[j].GetComponent<Renderer>();
				if (component2.isVisible)
				{
					Material materialShockWave = getMaterialWaterWave();
					usedWaterMatList.Add(materialShockWave);
					materialShockWave.CopyPropertiesFromMaterial(component2.material);
					distortionCommand.DrawRenderer(component2, materialShockWave);
				}
			}
			targetCam.AddCommandBuffer(CameraEvent.BeforeForwardAlpha, distortionCommand);
		}
		else if (distortionRT != null)
		{
			distortionRT.Release();
			distortionRT = null;
		}
	}

	private bool haveBloom()
	{
		return intensity > 0f && enableBloom;
	}

	public void OnCameraPostRender()
	{
		if (!isSetRenderBuffer)
		{
			mainDisplayColorBuffer = Graphics.activeColorBuffer;
			mainDisplayDepthBuffer = Graphics.activeDepthBuffer;
			isSetRenderBuffer = true;
		}
		if (material == null)
		{
			Graphics.SetRenderTarget(mainDisplayColorBuffer, mainDisplayDepthBuffer);
			Graphics.Blit(colorRT, RenderTexture.active);
			targetCam.SetTargetBuffers(mainDisplayColorBuffer, mainDisplayDepthBuffer);
			if (colorRT != null)
			{
				if (RenderTexture.active == colorRT)
				{
					RenderTexture.active = null;
				}
				RenderTexture.ReleaseTemporary(colorRT);
				colorRT = null;
			}
			if (depthRT != null)
			{
				if (RenderTexture.active == depthRT)
				{
					RenderTexture.active = null;
				}
				RenderTexture.ReleaseTemporary(depthRT);
				depthRT = null;
			}
			return;
		}
		if (!haveBloom())
		{
			if (haveWave())
			{
				ghoulAfterEffectMaterial.SetTexture("_DistortionMask", distortionRT);
				if (enableDOF)
				{
					int width = colorRT.width / 4;
					int height = colorRT.height / 4;
					RenderTexture renderTexture = RenderTexture.GetTemporary(width, height, 0, colorRT.format);
					Graphics.Blit(colorRT, renderTexture, ghoulAfterEffectMaterial, 9);
					ghoulAfterEffectMaterial.SetInt("_UpsideDown", upsideDown ? 1 : 0);
					for (int i = 0; i < 2; i++)
					{
						ghoulAfterEffectMaterial.SetVector("_Parameter", new Vector4(1f + (float)i * 1f, 0f, threshhold, intensity));
						RenderTexture temporary = RenderTexture.GetTemporary(width, height, 0, colorRT.format);
						temporary.filterMode = FilterMode.Bilinear;
						Graphics.Blit(renderTexture, temporary, ghoulAfterEffectMaterial, 14);
						RenderTexture.ReleaseTemporary(renderTexture);
						renderTexture = temporary;
						temporary = RenderTexture.GetTemporary(width, height, 0, colorRT.format);
						temporary.filterMode = FilterMode.Bilinear;
						Graphics.Blit(renderTexture, temporary, ghoulAfterEffectMaterial, 15);
						RenderTexture.ReleaseTemporary(renderTexture);
						renderTexture = temporary;
					}
					ghoulAfterEffectMaterial.SetTexture("_BlurMainTex", renderTexture);
					ghoulAfterEffectMaterial.SetFloat("_FocusDepth", focusDepth);
					ghoulAfterEffectMaterial.SetFloat("_FocusDistance", focusDistance);
					if (AAenabled)
					{
						RenderTexture temporary2 = RenderTexture.GetTemporary(colorRT.width, colorRT.height);
						AARenderImage(colorRT, temporary2);
						Graphics.SetRenderTarget(mainDisplayColorBuffer, mainDisplayDepthBuffer);
						Graphics.Blit(temporary2, RenderTexture.active, ghoulAfterEffectMaterial, 11);
						RenderTexture.ReleaseTemporary(temporary2);
					}
					else
					{
						Graphics.SetRenderTarget(mainDisplayColorBuffer, mainDisplayDepthBuffer);
						Graphics.Blit(colorRT, RenderTexture.active, ghoulAfterEffectMaterial, 11);
					}
					RenderTexture.ReleaseTemporary(renderTexture);
				}
				else if (AAenabled)
				{
					RenderTexture temporary3 = RenderTexture.GetTemporary(colorRT.width, colorRT.height);
					AARenderImage(colorRT, temporary3);
					Graphics.SetRenderTarget(mainDisplayColorBuffer, mainDisplayDepthBuffer);
					Graphics.Blit(temporary3, RenderTexture.active, ghoulAfterEffectMaterial, 8);
					RenderTexture.ReleaseTemporary(temporary3);
				}
				else
				{
					Graphics.SetRenderTarget(mainDisplayColorBuffer, mainDisplayDepthBuffer);
					Graphics.Blit(colorRT, RenderTexture.active, ghoulAfterEffectMaterial, 8);
				}
			}
			else if (enableDOF)
			{
				int width2 = colorRT.width / 4;
				int height2 = colorRT.height / 4;
				RenderTexture renderTexture2 = RenderTexture.GetTemporary(width2, height2, 0, colorRT.format);
				Graphics.Blit(colorRT, renderTexture2, ghoulAfterEffectMaterial, 9);
				ghoulAfterEffectMaterial.SetInt("_UpsideDown", upsideDown ? 1 : 0);
				for (int j = 0; j < 2; j++)
				{
					ghoulAfterEffectMaterial.SetVector("_Parameter", new Vector4(1f + (float)j * 1f, 0f, threshhold, intensity));
					RenderTexture temporary4 = RenderTexture.GetTemporary(width2, height2, 0, colorRT.format);
					temporary4.filterMode = FilterMode.Bilinear;
					Graphics.Blit(renderTexture2, temporary4, ghoulAfterEffectMaterial, 14);
					RenderTexture.ReleaseTemporary(renderTexture2);
					renderTexture2 = temporary4;
					temporary4 = RenderTexture.GetTemporary(width2, height2, 0, colorRT.format);
					temporary4.filterMode = FilterMode.Bilinear;
					Graphics.Blit(renderTexture2, temporary4, ghoulAfterEffectMaterial, 15);
					RenderTexture.ReleaseTemporary(renderTexture2);
					renderTexture2 = temporary4;
				}
				ghoulAfterEffectMaterial.SetTexture("_BlurMainTex", renderTexture2);
				ghoulAfterEffectMaterial.SetFloat("_FocusDepth", focusDepth);
				ghoulAfterEffectMaterial.SetFloat("_FocusDistance", focusDistance);
				if (AAenabled)
				{
					RenderTexture temporary5 = RenderTexture.GetTemporary(colorRT.width, colorRT.height);
					AARenderImage(colorRT, temporary5);
					Graphics.SetRenderTarget(mainDisplayColorBuffer, mainDisplayDepthBuffer);
					Graphics.Blit(temporary5, RenderTexture.active, ghoulAfterEffectMaterial, 10);
					RenderTexture.ReleaseTemporary(temporary5);
				}
				else
				{
					Graphics.SetRenderTarget(mainDisplayColorBuffer, mainDisplayDepthBuffer);
					Graphics.Blit(colorRT, RenderTexture.active, ghoulAfterEffectMaterial, 10);
				}
				RenderTexture.ReleaseTemporary(renderTexture2);
			}
			else if (AAenabled)
			{
				RenderTexture temporary6 = RenderTexture.GetTemporary(colorRT.width, colorRT.height);
				AARenderImage(colorRT, temporary6);
				Graphics.SetRenderTarget(mainDisplayColorBuffer, mainDisplayDepthBuffer);
				Graphics.Blit(temporary6, RenderTexture.active);
				RenderTexture.ReleaseTemporary(temporary6);
			}
			else
			{
				Graphics.SetRenderTarget(mainDisplayColorBuffer, mainDisplayDepthBuffer);
				Graphics.Blit(colorRT, RenderTexture.active);
			}
			targetCam.SetTargetBuffers(mainDisplayColorBuffer, mainDisplayDepthBuffer);
			if (colorRT != null)
			{
				if (RenderTexture.active == colorRT)
				{
					RenderTexture.active = null;
				}
				RenderTexture.ReleaseTemporary(colorRT);
				colorRT = null;
			}
			if (depthRT != null)
			{
				if (RenderTexture.active == depthRT)
				{
					RenderTexture.active = null;
				}
				RenderTexture.ReleaseTemporary(depthRT);
				depthRT = null;
			}
			return;
		}
		while (usedShockMatList.Count > 0)
		{
			Material item = usedShockMatList[0];
			usedShockMatList.RemoveAt(0);
			storedShockMatList.Add(item);
		}
		while (usedWaterMatList.Count > 0)
		{
			Material item2 = usedWaterMatList[0];
			usedWaterMatList.RemoveAt(0);
			storedWaterMatList.Add(item2);
		}
		int num = ((blurResolution != 0) ? 4 : 8);
		float num2 = ((blurResolution != 0) ? 0.5f : 0.25f);
		ghoulAfterEffectMaterial.SetVector("_Parameter", new Vector4(blurSize * num2, 0f, threshhold, intensity));
		ghoulAfterEffectMaterial.SetInt("_UpsideDown", upsideDown ? 1 : 0);
		int width3 = colorRT.width / num;
		int height3 = colorRT.height / num;
		RenderTexture renderTexture3 = RenderTexture.GetTemporary(width3, height3, 0, colorRT.format);
		renderTexture3.filterMode = FilterMode.Bilinear;
		Graphics.Blit(colorRT, renderTexture3, ghoulAfterEffectMaterial, 1);
		int num3 = ((blurType != 0) ? 2 : 0);
		for (int k = 0; k < blurIterations; k++)
		{
			ghoulAfterEffectMaterial.SetVector("_Parameter", new Vector4(blurSize * num2 + (float)k * 1f, 0f, threshhold, intensity));
			RenderTexture temporary7 = RenderTexture.GetTemporary(width3, height3, 0, colorRT.format);
			temporary7.filterMode = FilterMode.Bilinear;
			Graphics.Blit(renderTexture3, temporary7, ghoulAfterEffectMaterial, 2 + num3);
			RenderTexture.ReleaseTemporary(renderTexture3);
			renderTexture3 = temporary7;
			temporary7 = RenderTexture.GetTemporary(width3, height3, 0, colorRT.format);
			temporary7.filterMode = FilterMode.Bilinear;
			Graphics.Blit(renderTexture3, temporary7, ghoulAfterEffectMaterial, 3 + num3);
			RenderTexture.ReleaseTemporary(renderTexture3);
			renderTexture3 = temporary7;
		}
		ghoulAfterEffectMaterial.SetTexture("_Bloom", renderTexture3);
		if (haveWave())
		{
			ghoulAfterEffectMaterial.SetTexture("_DistortionMask", distortionRT);
			if (enableDOF)
			{
				int width4 = colorRT.width / num;
				int height4 = colorRT.height / num;
				RenderTexture renderTexture4 = RenderTexture.GetTemporary(width4, height4, 0, colorRT.format);
				Graphics.Blit(colorRT, renderTexture4, ghoulAfterEffectMaterial, 9);
				for (int l = 0; l < 2; l++)
				{
					ghoulAfterEffectMaterial.SetVector("_Parameter", new Vector4(1f + (float)l * 1f, 0f, threshhold, intensity));
					RenderTexture temporary8 = RenderTexture.GetTemporary(width4, height4, 0, colorRT.format);
					temporary8.filterMode = FilterMode.Bilinear;
					Graphics.Blit(renderTexture4, temporary8, ghoulAfterEffectMaterial, 14);
					RenderTexture.ReleaseTemporary(renderTexture4);
					renderTexture4 = temporary8;
					temporary8 = RenderTexture.GetTemporary(width4, height4, 0, colorRT.format);
					temporary8.filterMode = FilterMode.Bilinear;
					Graphics.Blit(renderTexture4, temporary8, ghoulAfterEffectMaterial, 15);
					RenderTexture.ReleaseTemporary(renderTexture4);
					renderTexture4 = temporary8;
				}
				ghoulAfterEffectMaterial.SetTexture("_BlurMainTex", renderTexture4);
				ghoulAfterEffectMaterial.SetFloat("_FocusDepth", focusDepth);
				ghoulAfterEffectMaterial.SetFloat("_FocusDistance", focusDistance);
				if (AAenabled)
				{
					RenderTexture temporary9 = RenderTexture.GetTemporary(colorRT.width, colorRT.height);
					AARenderImage(colorRT, temporary9);
					Graphics.SetRenderTarget(mainDisplayColorBuffer, mainDisplayDepthBuffer);
					Graphics.Blit(temporary9, RenderTexture.active, ghoulAfterEffectMaterial, 13);
					RenderTexture.ReleaseTemporary(temporary9);
				}
				else
				{
					Graphics.SetRenderTarget(mainDisplayColorBuffer, mainDisplayDepthBuffer);
					Graphics.Blit(colorRT, RenderTexture.active, ghoulAfterEffectMaterial, 13);
				}
				RenderTexture.ReleaseTemporary(renderTexture4);
			}
			else if (AAenabled)
			{
				RenderTexture temporary10 = RenderTexture.GetTemporary(colorRT.width, colorRT.height);
				AARenderImage(colorRT, temporary10);
				Graphics.SetRenderTarget(mainDisplayColorBuffer, mainDisplayDepthBuffer);
				Graphics.Blit(temporary10, RenderTexture.active, ghoulAfterEffectMaterial, 7);
				RenderTexture.ReleaseTemporary(temporary10);
			}
			else
			{
				Graphics.SetRenderTarget(mainDisplayColorBuffer, mainDisplayDepthBuffer);
				Graphics.Blit(colorRT, RenderTexture.active, ghoulAfterEffectMaterial, 7);
			}
		}
		else if (enableDOF)
		{
			int width5 = colorRT.width / num;
			int height5 = colorRT.height / num;
			RenderTexture renderTexture5 = RenderTexture.GetTemporary(width5, height5, 0, colorRT.format);
			Graphics.Blit(colorRT, renderTexture5, ghoulAfterEffectMaterial, 9);
			for (int m = 0; m < 2; m++)
			{
				ghoulAfterEffectMaterial.SetVector("_Parameter", new Vector4(1f + (float)m * 1f, 0f, threshhold, intensity));
				RenderTexture temporary11 = RenderTexture.GetTemporary(width5, height5, 0, colorRT.format);
				temporary11.filterMode = FilterMode.Bilinear;
				Graphics.Blit(renderTexture5, temporary11, ghoulAfterEffectMaterial, 14);
				RenderTexture.ReleaseTemporary(renderTexture5);
				renderTexture5 = temporary11;
				temporary11 = RenderTexture.GetTemporary(width5, height5, 0, colorRT.format);
				temporary11.filterMode = FilterMode.Bilinear;
				Graphics.Blit(renderTexture5, temporary11, ghoulAfterEffectMaterial, 15);
				RenderTexture.ReleaseTemporary(renderTexture5);
				renderTexture5 = temporary11;
			}
			ghoulAfterEffectMaterial.SetTexture("_BlurMainTex", renderTexture5);
			ghoulAfterEffectMaterial.SetFloat("_FocusDepth", focusDepth);
			ghoulAfterEffectMaterial.SetFloat("_FocusDistance", focusDistance);
			if (AAenabled)
			{
				RenderTexture temporary12 = RenderTexture.GetTemporary(colorRT.width, colorRT.height);
				AARenderImage(colorRT, temporary12);
				Graphics.SetRenderTarget(mainDisplayColorBuffer, mainDisplayDepthBuffer);
				Graphics.Blit(temporary12, RenderTexture.active, ghoulAfterEffectMaterial, 12);
				RenderTexture.ReleaseTemporary(temporary12);
			}
			else
			{
				Graphics.SetRenderTarget(mainDisplayColorBuffer, mainDisplayDepthBuffer);
				Graphics.Blit(colorRT, RenderTexture.active, ghoulAfterEffectMaterial, 12);
			}
			RenderTexture.ReleaseTemporary(renderTexture5);
		}
		else if (AAenabled)
		{
			RenderTexture temporary13 = RenderTexture.GetTemporary(colorRT.width, colorRT.height);
			AARenderImage(colorRT, temporary13);
			Graphics.SetRenderTarget(mainDisplayColorBuffer, mainDisplayDepthBuffer);
			Graphics.Blit(temporary13, RenderTexture.active, ghoulAfterEffectMaterial, 6);
			RenderTexture.ReleaseTemporary(temporary13);
		}
		else
		{
			Graphics.SetRenderTarget(mainDisplayColorBuffer, mainDisplayDepthBuffer);
			Graphics.Blit(colorRT, RenderTexture.active, ghoulAfterEffectMaterial, 6);
		}
		RenderTexture.ReleaseTemporary(renderTexture3);
		targetCam.SetTargetBuffers(mainDisplayColorBuffer, mainDisplayDepthBuffer);
		if (colorRT != null)
		{
			if (RenderTexture.active == colorRT)
			{
				RenderTexture.active = null;
			}
			RenderTexture.ReleaseTemporary(colorRT);
			colorRT = null;
		}
		if (depthRT != null)
		{
			if (RenderTexture.active == depthRT)
			{
				RenderTexture.active = null;
			}
			RenderTexture.ReleaseTemporary(depthRT);
			depthRT = null;
		}
	}

	private void OnGUIXX()
	{
		GUILayout.BeginVertical();
		GUILayout.EndVertical();
	}
}
