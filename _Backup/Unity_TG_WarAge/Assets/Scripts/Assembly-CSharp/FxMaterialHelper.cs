using UnityEngine;

public class FxMaterialHelper : MonoBehaviour
{
	public string colorName = "_TintColor";

	public Color color;

	private Color lastColor;

	private Renderer mr;

	private void Start()
	{
		color = Color.gray;
		mr = base.gameObject.GetComponent<Renderer>();
	}

	private void Update()
	{
		if (mr != null && color != lastColor)
		{
			mr.sharedMaterial.SetColor(colorName, color);
			lastColor = color;
		}
	}
}
