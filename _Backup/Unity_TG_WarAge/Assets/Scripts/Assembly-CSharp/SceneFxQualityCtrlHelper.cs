using UnityEngine;

public class SceneFxQualityCtrlHelper : MonoBehaviour
{
	[Range(1f, 2f)]
	public int disableOnQualityLevel = 1;

	private int lastQuality = -1;

	public int GetFxQualityLevel()
	{
		return AppConfig.GetFXQualityLevel();
	}

	private void Awake()
	{
		lastQuality = GetFxQualityLevel();
		SetQuality();
	}

	private void Update()
	{
		int fxQualityLevel = GetFxQualityLevel();
		if (fxQualityLevel != lastQuality)
		{
			lastQuality = fxQualityLevel;
			SetQuality();
		}
	}

	public void SetQuality()
	{
		if (GetFxQualityLevel() <= disableOnQualityLevel)
		{
			base.gameObject.SetActive(false);
		}
		else if (!base.gameObject.activeSelf)
		{
			base.gameObject.SetActive(true);
		}
	}
}
