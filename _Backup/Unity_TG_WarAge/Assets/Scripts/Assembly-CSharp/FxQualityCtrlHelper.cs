using UnityEngine;

public class FxQualityCtrlHelper : MonoBehaviour
{
	[Range(1f, 2f)]
	public int disableOnQualityLevel = 1;

	private void Awake()
	{
		if (QualitySettings.GetQualityLevel() + 1 <= disableOnQualityLevel)
		{
			base.gameObject.SetActive(false);
		}
	}

	public void SetQuality()
	{
		if (QualitySettings.GetQualityLevel() + 1 <= disableOnQualityLevel)
		{
			base.gameObject.SetActive(false);
		}
		else
		{
			base.gameObject.SetActive(true);
		}
	}
}
