using UnityEngine;

[ExecuteInEditMode]
public class MotionBlurEffects : UITweener
{
	public Shader CurShader;

	private Vector4 ScreenResolution;

	private Material CurMaterial;

	[Range(5f, 50f)]
	public float IterationNumber = 15f;

	[Range(-0.5f, 0.5f)]
	public float Intensity = 0.5f;

	[Range(-2f, -2f)]
	public float OffsetX = 0.5f;

	[Range(-2f, -2f)]
	public float OffsetY = 0.5f;

	private float lerpTime = 2f;

	private float currentLerpTime;

	private float from = 0.12f;

	private float to;

	private float tcfrom = 0.2f;

	private float tcto;

	private bool isrunning;

	private bool mTc;

	private Material material
	{
		get
		{
			if (CurMaterial == null)
			{
				CurMaterial = new Material(CurShader);
				CurMaterial.hideFlags = HideFlags.HideAndDontSave;
			}
			return CurMaterial;
		}
	}

	private float value
	{
		get
		{
			return Intensity;
		}
		set
		{
			Intensity = value;
		}
	}

	private new void Start()
	{
		CurShader = App3.GetInstance().FindShader("ssg_shader/MotionBlurEffects");
		if (!SystemInfo.supportsImageEffects)
		{
			Debug.Log("MotionBlurEffects:SystemInfo.supportsImageEffects==false");
			base.enabled = false;
		}
	}

	public void BeginBlurTween(float _from, float _to, float duration)
	{
		MotionBlurEffects component = GetComponent<MotionBlurEffects>();
		from = _from;
		to = _to;
		component.Sample(1f, true);
		component.PlayForward();
	}

	public void BeginTcTween(float _tcfrom, float _tcto, float duration)
	{
		mTc = true;
		tcfrom = _tcfrom;
		tcto = _tcto;
		lerpTime = duration / 1000f;
		currentLerpTime = 0f;
		isrunning = true;
	}

	public void SetValue(float intensity, float ox, float oy, float bw)
	{
		Intensity = intensity;
		OffsetX = ox;
		OffsetY = oy;
		IterationNumber = bw;
	}

	public float GetIntensityValue()
	{
		return Intensity;
	}

	private void OnDisable()
	{
		if ((bool)CurMaterial)
		{
			Object.DestroyImmediate(CurMaterial);
		}
	}

	protected override void OnUpdate(float factor, bool isFinished)
	{
		value = Mathf.Lerp(from, to, factor);
	}
}
