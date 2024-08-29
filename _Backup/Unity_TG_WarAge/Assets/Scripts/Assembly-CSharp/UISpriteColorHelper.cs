using UnityEngine;

public class UISpriteColorHelper : MonoBehaviour
{
	public Color color;

	private UISprite sprite;

	private void Start()
	{
		sprite = base.gameObject.GetComponent<UISprite>();
	}

	private void Update()
	{
		if (!(null == sprite))
		{
			sprite.color = color;
		}
	}
}
