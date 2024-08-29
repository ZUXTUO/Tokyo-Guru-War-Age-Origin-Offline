using UnityEngine;

[RequireComponent(typeof(Camera))]
public class StarWarsShadow : MonoBehaviour
{
	public float Size;

	public float Depth;

	public LayerMask CameraLayerMask;

	public LayerMask ProjectorLayerMask;

	public Color ShadowColor = Color.black;

	public int textureSize = 1024;

	public Vector3 ShadowDir = new Vector3(0f, -1f, 0f);

	public Vector3 rayDirOffset = new Vector3(0f, 0f, 0f);

	public Transform rayTarget;

	private Camera fCamera;

	private Projector fProjector;

	public float rayDistance = 30f;

	private RenderTexture fRT;

	private Material fMaterial;

	private Camera pCamera;

	private int shadowID = -1;

	private static int shadowCount;

	private bool isStarted;

	private Ray ray = default(Ray);

	private void OnEnable()
	{
		if (shadowID == -1)
		{
			shadowCount++;
			shadowID = shadowCount;
		}
		base.gameObject.name = "StarWarsShadow " + shadowID;
		base.tag = "HighEffect";
		Init();
	}

	public void Init()
	{
		FS_ShadowSimple.canUseEffect = false;
		if (QualitySettings.GetQualityLevel() < 2)
		{
			FS_ShadowSimple.canUseEffect = true;
			base.enabled = false;
			fCamera = GetComponent<Camera>();
			if (fCamera != null)
			{
				fRT = fCamera.targetTexture;
				if (fRT != null)
				{
					fCamera.targetTexture = null;
					fRT.Release();
					if (fMaterial != null)
					{
						fMaterial.SetTexture("_MainTex", null);
						fMaterial = null;
					}
					fRT = null;
				}
				fCamera.enabled = false;
			}
			fProjector = GetComponent<Projector>();
			if (fProjector != null)
			{
				Object.DestroyImmediate(fProjector);
			}
		}
		else if (base.gameObject.activeInHierarchy)
		{
			fCamera = GetComponent<Camera>();
			Shader shader = null;
			shader = App3.GetInstance().FindShader("DyShader/Shadow");
			fCamera.SetReplacementShader(shader, "RenderType");
			pCamera = base.transform.parent.GetComponent<Camera>();
			if (fCamera != null)
			{
				fCamera.enabled = true;
				fCamera.clearFlags = CameraClearFlags.Color;
				fCamera.backgroundColor = new Color(0f, 0f, 0f, 0f);
				fCamera.cullingMask = CameraLayerMask;
				fCamera.orthographic = true;
				fCamera.orthographicSize = Size;
				fCamera.nearClipPlane = 0.01f;
				fCamera.farClipPlane = Depth;
				fCamera.rect = new Rect(0f, 0f, 1f, 1f);
				fCamera.depth = -10f;
				fCamera.renderingPath = RenderingPath.Forward;
				fCamera.useOcclusionCulling = false;
				fCamera.allowHDR = false;
			}
			fProjector = GetComponent<Projector>();
			if (fProjector == null)
			{
				fProjector = base.gameObject.AddComponent<Projector>();
			}
			fProjector.orthographic = true;
			fProjector.orthographicSize = Size;
			fProjector.nearClipPlane = 0.01f;
			fProjector.farClipPlane = Depth;
			fProjector.aspectRatio = 1f;
			fProjector.ignoreLayers = ~(int)ProjectorLayerMask;
			Shader shader2 = null;
			shader2 = App3.GetInstance().FindShader("Projector/Shadow");
			fMaterial = new Material(shader2);
			fProjector.material = fMaterial;
			fMaterial.SetColor("_Color", ShadowColor);
		}
	}

	private void OnPreRender()
	{
		fRT = RenderTexture.GetTemporary(textureSize, textureSize, 0, RenderTextureFormat.ARGB32);
		fRT.wrapMode = TextureWrapMode.Clamp;
		fRT.filterMode = FilterMode.Bilinear;
		fRT.anisoLevel = 0;
		fMaterial.SetTexture("_MainTex", fRT);
		fCamera.targetTexture = fRT;
	}

	private void OnPostRender()
	{
		RenderTexture.ReleaseTemporary(fRT);
		fRT = null;
		fCamera.targetTexture = null;
	}

	private void OnDisable()
	{
		if (shadowID == -1)
		{
			shadowCount++;
			shadowID = shadowCount;
			base.gameObject.name = "StarWarsShadow " + shadowID;
		}
		fCamera = GetComponent<Camera>();
		FS_ShadowSimple.canUseEffect = true;
		if (fCamera != null)
		{
			fCamera.targetTexture = null;
			if (fRT != null)
			{
				RenderTexture.ReleaseTemporary(fRT);
				fRT = null;
			}
			fCamera.enabled = false;
			fCamera = null;
		}
		Resources.UnloadUnusedAssets();
	}

	public void Update()
	{
	}

	public void LateUpdate()
	{
		if (!(pCamera != null))
		{
			return;
		}
		ray.origin = pCamera.transform.position;
		if (rayTarget != null)
		{
			ray.direction = rayTarget.position - ray.origin + rayDirOffset;
		}
		else
		{
			ray.direction = pCamera.transform.forward + rayDirOffset;
		}
		RaycastHit[] array = Physics.RaycastAll(ray, rayDistance, ProjectorLayerMask.value);
		bool flag = false;
		if (array.Length > 0)
		{
			RaycastHit raycastHit = array[0];
			Transform transform = raycastHit.transform;
			base.transform.forward = ShadowDir;
			base.transform.position = raycastHit.point - Vector3.Normalize(ShadowDir) * (Depth - 10f);
			flag = true;
		}
		if (!flag)
		{
			ray.origin = pCamera.transform.position;
			if (rayTarget != null)
			{
				ray.direction = rayTarget.position - ray.origin - pCamera.transform.up * 0.1f + rayDirOffset;
			}
			else
			{
				ray.direction = pCamera.transform.forward - pCamera.transform.up * 0.1f + rayDirOffset;
			}
			array = Physics.RaycastAll(ray, rayDistance, ProjectorLayerMask.value);
			if (array.Length > 0)
			{
				RaycastHit raycastHit2 = array[0];
				Transform transform2 = raycastHit2.transform;
				base.transform.forward = ShadowDir;
				base.transform.position = raycastHit2.point - Vector3.Normalize(ShadowDir) * (Depth - 10f);
				flag = true;
			}
		}
	}

	public void SetPara()
	{
		fCamera = GetComponent<Camera>();
		if ((bool)fCamera)
		{
			fCamera.clearFlags = CameraClearFlags.Color;
			fCamera.backgroundColor = new Color(0f, 0f, 0f, 0f);
			fCamera.cullingMask = CameraLayerMask;
			fCamera.orthographic = true;
			fCamera.orthographicSize = Size;
			fCamera.nearClipPlane = 0.01f;
			fCamera.farClipPlane = Depth;
			fCamera.rect = new Rect(0f, 0f, 1f, 1f);
			fCamera.depth = -10f;
			fCamera.renderingPath = RenderingPath.Forward;
			fCamera.useOcclusionCulling = false;
			fCamera.allowHDR = false;
			fRT = fCamera.targetTexture;
			if (fRT != null)
			{
				fRT.wrapMode = TextureWrapMode.Clamp;
				fRT.filterMode = FilterMode.Bilinear;
				fRT.anisoLevel = 0;
			}
			fProjector = GetComponent<Projector>();
			if ((bool)fProjector)
			{
				fProjector.orthographic = true;
				fProjector.orthographicSize = Size;
				fProjector.nearClipPlane = 0.01f;
				fProjector.farClipPlane = Depth;
				fProjector.aspectRatio = 1f;
				fProjector.ignoreLayers = ~(int)ProjectorLayerMask;
				fMaterial = fProjector.material;
				fMaterial.SetColor("_Color", ShadowColor);
				fMaterial.SetTexture("_MainTex", fRT);
			}
		}
	}
}
