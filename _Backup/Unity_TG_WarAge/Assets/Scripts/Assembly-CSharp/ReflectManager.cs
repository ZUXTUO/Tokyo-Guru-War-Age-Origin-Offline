using UnityEngine;

public class ReflectManager : MonoBehaviour
{
	public enum Quality
	{
		Low = 1,
		Medium = 2,
		High = 3
	}

	public ReflectMainTarget[] reflMainTargets;

	public string targetCameraName = "fightCamera";

	public string defaultCameraName = "fightCamera";

	public LayerMask reflectionMask;

	public Quality quality = Quality.Low;

	private Quality lastQuality = Quality.High;

	private bool isInited;

	private Camera targetCam;

	private bool isAllTargetInitOk;

	public bool forceEnable;

	private static string[] lowLayerMask = new string[3] { "building", "building_item", "reflection" };

	private static string[] highLayerMask = new string[8] { "building", "monster", "player", "npc", "building_item", "weapon", "reflection", "pick" };

	private Camera lastTargetCam;

	private void Start()
	{
		base.gameObject.tag = "HighEffect";
		GameObject gameObject = GameObject.Find(targetCameraName);
		if (!(gameObject == null))
		{
			targetCam = gameObject.GetComponent<Camera>();
			checkQuality();
		}
	}

	public void checkQuality()
	{
		int qualityLevel = QualitySettings.GetQualityLevel();
		if (forceEnable)
		{
			switch (qualityLevel)
			{
			case 0:
				quality = Quality.Low;
				reflectionMask = LayerMask.GetMask(lowLayerMask);
				break;
			case 1:
				quality = Quality.Medium;
				reflectionMask = LayerMask.GetMask(lowLayerMask);
				break;
			case 2:
				quality = Quality.Medium;
				reflectionMask = LayerMask.GetMask(highLayerMask);
				break;
			}
		}
		else if (qualityLevel < 2)
		{
			base.enabled = false;
		}
		else
		{
			base.enabled = true;
			quality = Quality.Medium;
			reflectionMask = LayerMask.GetMask(highLayerMask);
		}
		isInited = false;
	}

	private void OnEnable()
	{
		isInited = false;
	}

	private void OnDisable()
	{
		for (int i = 0; i < reflMainTargets.Length; i++)
		{
			reflMainTargets[i].disableRefl();
		}
		isInited = false;
	}

	private void Update()
	{
		Camera[] allCameras = Camera.allCameras;
		float num = -100f;
		int num2 = -1;
		for (int i = 0; i < allCameras.Length; i++)
		{
			if (allCameras[i].isActiveAndEnabled && allCameras[i].targetTexture == null && allCameras[i].name != "uicamera" && allCameras[i].depth > num)
			{
				num = allCameras[i].depth;
				num2 = i;
			}
		}
		if (num2 >= 0)
		{
			targetCam = allCameras[num2];
		}
		if (targetCam == null)
		{
			GameObject gameObject = GameObject.Find(targetCameraName);
			if (gameObject == null)
			{
				gameObject = GameObject.Find(defaultCameraName);
				if (gameObject == null)
				{
					return;
				}
			}
			targetCam = gameObject.GetComponent<Camera>();
			if (targetCam == null)
			{
				return;
			}
		}
		if (!isInited || lastQuality != quality || targetCam != lastTargetCam)
		{
			lastTargetCam = targetCam;
			lastQuality = quality;
			isInited = true;
			float num3 = ((quality == Quality.Low) ? 0.25f : ((quality != Quality.Medium) ? 1f : 0.5f));
			int w = (int)((float)Screen.width * num3);
			int h = (int)((float)Screen.height * num3);
			for (int j = 0; j < reflMainTargets.Length; j++)
			{
				reflMainTargets[j].initCamera(targetCam, reflectionMask, w, h);
			}
		}
	}

	private void LateUpdate()
	{
		if (targetCam == null)
		{
			GameObject gameObject = GameObject.Find(targetCameraName);
			if (gameObject == null)
			{
				gameObject = GameObject.Find(defaultCameraName);
				if (gameObject == null)
				{
					return;
				}
			}
			targetCam = gameObject.GetComponent<Camera>();
			if (targetCam == null)
			{
				return;
			}
		}
		for (int i = 0; i < reflMainTargets.Length; i++)
		{
			if (reflMainTargets[i] != null)
			{
				reflMainTargets[i].useReflection(targetCam);
			}
			else
			{
				Debug.LogError("呼叫场景修正反射的MainTarget");
			}
		}
	}
}
