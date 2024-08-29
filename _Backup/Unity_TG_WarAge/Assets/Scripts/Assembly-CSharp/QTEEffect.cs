using System.Collections.Generic;
using UnityEngine;

public class QTEEffect : MonoBehaviour
{
	private Camera fightCam;

	private Camera QTECam;

	private List<Plane> plist;

	public bool playEffect;

	private GameObject QTECamObj;

	public static bool isInEffect;

	public List<GameObject> tempObjs;

	private string[] masks = new string[5];

	private float timeCounter;

	private float tweenTime;

	private bool isInEndProcess;

	private Color startColor;

	private Color endColor;

	private Color curColor;

	private int storedCullMask;

	private int effectCullMask;

	private MeshRenderer mrd;

	public void startEffect(float _alphaStart, float _alphaEnd, float _tweenTime)
	{
		if (!isInEffect || isInEndProcess)
		{
			fightCam = base.gameObject.GetComponent<Camera>();
			if (fightCam == null)
			{
				Debug.LogError("QTE脚本，未能找到目标相机");
			}
			isInEffect = true;
			isInEndProcess = false;
			startColor = new Color(0f, 0f, 0f, _alphaStart);
			endColor = new Color(0f, 0f, 0f, _alphaEnd);
			curColor = new Color(0f, 0f, 0f, _alphaStart);
			tweenTime = _tweenTime;
			timeCounter = 0f;
			if (QTECamObj != null)
			{
				Object.Destroy(QTECamObj);
			}
			QTECamObj = GameObject.CreatePrimitive(PrimitiveType.Sphere);
			QTECamObj.name = "QTECamera";
			mrd = QTECamObj.GetComponent<MeshRenderer>();
			Shader shader = App3.GetInstance().FindShader("Sprites/Default");
			mrd.material = new Material(shader);
			mrd.material.SetColor("_Color", startColor);
			QTECamObj.transform.localScale = new Vector3(15f, 1f, 15f);
			QTECamObj.layer = 11;
			GameObject[] array = GameObject.FindGameObjectsWithTag("SceneEntity");
			Object.Destroy(QTECamObj.GetComponent<BoxCollider>());
			QTECam = QTECamObj.AddComponent<Camera>();
			QTECam.CopyFrom(fightCam);
			if (masks[0] == null)
			{
				masks[0] = "QTE";
				masks[1] = "npc";
				masks[2] = "player";
				masks[3] = "monster";
				masks[4] = "TransparentFX";
			}
			QTECam.cullingMask = LayerMask.GetMask(masks);
			QTECam.clearFlags = CameraClearFlags.Depth;
			QTECam.depth = fightCam.depth + 2f;
			if (storedCullMask == 0)
			{
				storedCullMask = fightCam.cullingMask;
				effectCullMask = fightCam.cullingMask - LayerMask.GetMask(masks);
			}
			fightCam.cullingMask = effectCullMask;
			if (GhoulAfterEffects.isSetRenderBuffer)
			{
				QTECam.SetTargetBuffers(GhoulAfterEffects.mainDisplayColorBuffer, GhoulAfterEffects.mainDisplayDepthBuffer);
			}
		}
	}

	private void Update()
	{
		if (isInEffect)
		{
			QTECamObj.transform.position = fightCam.transform.position;
			if (timeCounter <= tweenTime && mrd != null)
			{
				curColor = Vector4.Lerp(startColor, endColor, timeCounter / tweenTime);
				mrd.material.SetColor("_Color", curColor);
			}
			else
			{
				mrd.material.SetColor("_Color", endColor);
				if (isInEndProcess)
				{
					fightCam.cullingMask = storedCullMask;
					Object.Destroy(QTECamObj);
					Object.Destroy(this);
					isInEffect = false;
					return;
				}
			}
			timeCounter += Time.unscaledDeltaTime;
		}
		else
		{
			Object.Destroy(this);
		}
	}

	public void stopEffect(float _tweenTime)
	{
		if (isInEffect)
		{
			if (_tweenTime <= 0f)
			{
				isInEffect = false;
				fightCam.cullingMask = storedCullMask;
				Object.Destroy(QTECamObj);
				Object.Destroy(this);
			}
			else
			{
				isInEndProcess = true;
				startColor = Color.Lerp(curColor, curColor, 1f);
				endColor = Color.clear;
				tweenTime = _tweenTime;
				timeCounter = 0f;
			}
		}
	}
}
