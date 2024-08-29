using UnityEngine;

public class labelCut : MonoBehaviour
{
	private UILabel uiLabel;

	private void Start()
	{
		uiLabel = base.gameObject.GetComponent<UILabel>();
		uiLabel.onChange = OnLabelChange;
	}

	private void Update()
	{
	}

	private void OnLabelChange()
	{
		string text = uiLabel.text;
		string final = string.Empty;
		if (!uiLabel.Wrap(text, out final, uiLabel.height))
		{
			final = final.Substring(0, final.Length - 1);
			final += "...";
		}
		uiLabel.text = final;
	}
}
