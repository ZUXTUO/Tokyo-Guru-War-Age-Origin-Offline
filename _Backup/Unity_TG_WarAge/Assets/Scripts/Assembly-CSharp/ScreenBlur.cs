using System.Collections;
using UnityEngine;

[RequireComponent(typeof(UITexture))]
public class ScreenBlur : MonoBehaviour
{
	private Camera uicam;

	private Camera mainUISceneCamera;

	private Camera fightCamera;

	[Range(0f, 1f)]
	private RenderTexture blurRt1;

	private RenderTexture blurRt2;

	private static float whRate;

	[Range(1f, 16f)]
	public float downSample = 8f;

	private float lastDownSample = 8f;

	public GameObject[] hideObjs;

	private int[] hideObjlastLayer;

	private Material blurMat;

	private UITexture targetTex;

	public Color texColor = new Color(0.705f, 0.705f, 0.705f, 1f);

	private bool doEffect = true;

	private bool lataUpdateHideObj;

	public static int curCount;

	private bool executeEndFrame;

	private int selfIndex = -1;

	public Material material
	{
		get
		{
			if (blurMat == null)
			{
				blurMat = new Material(Shader.Find("DyShader/TokyoGhoul/GhoulAfterScreenEffect"));
			}
			return blurMat;
		}
	}

	private void OnEnable()
	{
		if (whRate == 0f)
		{
			whRate = (float)Screen.width / (float)Screen.height;
		}
		targetTex = GetComponent<UITexture>();
		doEffect = true;
		targetTex.width = 1290;
		targetTex.height = (int)Mathf.Ceil(1290f / whRate);
		targetTex.color = texColor;
		UIButton component = GetComponent<UIButton>();
		if (component != null)
		{
			component.enableTweenColor = false;
		}
		lataUpdateHideObj = true;
		executeEndFrame = false;
		StartCoroutine(OnEndOfFrame());
	}

	private void LateUpdate()
	{
		if (!lataUpdateHideObj)
		{
			return;
		}
		lataUpdateHideObj = false;
		if (hideObjs != null)
		{
			hideObjlastLayer = new int[hideObjs.Length];
			for (int i = 0; i < hideObjs.Length; i++)
			{
				if (hideObjs[i] != null)
				{
					hideObjs[i].SetActive(false);
				}
			}
		}
		if (executeEndFrame)
		{
			StartCoroutine(OnEndOfFrame());
		}
	}

	private void OnDisable()
	{
		if (blurRt1 != null)
		{
			if (targetTex != null)
			{
				targetTex.mainTexture = null;
			}
			if (RenderTexture.active == blurRt1 || RenderTexture.active == blurRt2)
			{
				RenderTexture.active = null;
			}
			RenderTexture.ReleaseTemporary(blurRt1);
			RenderTexture.ReleaseTemporary(blurRt2);
			blurRt1 = null;
			blurRt2 = null;
		}
		if (doEffect)
		{
			return;
		}
		curCount--;
		if (curCount == 0)
		{
			if (GhoulAfterEffects.GetInstance().targetCam != null)
			{
				GhoulAfterEffects.GetInstance().targetCam.enabled = true;
			}
			GhoulAfterEffectsConsole.GetInstance().stopCheckCamera = false;
		}
	}

	private void OnDestroy()
	{
		if (blurRt1 != null)
		{
			if (targetTex != null)
			{
				targetTex.mainTexture = null;
			}
			if (RenderTexture.active == blurRt1 || RenderTexture.active == blurRt2)
			{
				RenderTexture.active = null;
			}
			RenderTexture.ReleaseTemporary(blurRt1);
			RenderTexture.ReleaseTemporary(blurRt2);
			blurRt1 = null;
			blurRt2 = null;
		}
	}

	private IEnumerator OnEndOfFrame()
	{
		yield return new WaitForEndOfFrame();
		executeEndFrame = true;
		if (doEffect)
		{
			if (curCount == 0 && GhoulAfterEffects.GetInstance().targetCam != null)
			{
				GhoulAfterEffects.GetInstance().targetCam.enabled = false;
				GhoulAfterEffectsConsole.GetInstance().stopCheckCamera = true;
			}
			curCount++;
			doEffect = false;
			UseEffect();
		}
		else
		{
			if (hideObjs == null)
			{
				yield break;
			}
			for (int i = 0; i < hideObjs.Length; i++)
			{
				if (hideObjs[i] != null)
				{
					hideObjs[i].SetActive(true);
				}
			}
		}
	}

	private void UseEffect()
	{
		if (blurRt1 == null)
		{
			blurRt1 = RenderTexture.GetTemporary((int)(1280f / downSample), (int)Mathf.Ceil(1280f / whRate / downSample), 0);
			blurRt2 = RenderTexture.GetTemporary(blurRt1.width, blurRt1.height, 0);
		}
		RenderTexture temporary = RenderTexture.GetTemporary(Screen.width, Screen.height);
		Graphics.Blit(RenderTexture.active, temporary);
		Graphics.Blit(temporary, blurRt1, material, 16);
		RenderTexture.ReleaseTemporary(temporary);
		material.SetVector("_Parameter", new Vector4(1f, 0f, 0f, 0f));
		Graphics.Blit(blurRt1, blurRt2, material, 14);
		Graphics.Blit(blurRt2, blurRt1, material, 15);
		Graphics.Blit(blurRt1, blurRt2, material, 14);
		Graphics.Blit(blurRt2, blurRt1, material, 15);
		targetTex.mainTexture = blurRt1;
		if (hideObjs == null)
		{
			return;
		}
		for (int i = 0; i < hideObjs.Length; i++)
		{
			if (hideObjs[i] != null)
			{
				hideObjs[i].SetActive(true);
			}
		}
	}
}
