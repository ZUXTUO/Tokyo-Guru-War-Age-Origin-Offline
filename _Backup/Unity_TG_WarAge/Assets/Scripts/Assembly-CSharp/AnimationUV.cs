using UnityEngine;

public class AnimationUV : MonoBehaviour
{
	public int uvAnimationTileX = 24;

	public int uvAnimationTileY = 1;

	public float framesPerSecond = 10f;

	public bool loop;

	public bool play = true;

	private int index;

	private float offsettime;

	public bool Hidewhenstopplaying;

	private void Start()
	{
		offsettime = Time.time;
	}

	private void Update()
	{
		index = (int)((Time.time - offsettime) * framesPerSecond);
		if (play)
		{
			index %= uvAnimationTileX * uvAnimationTileY;
			Vector2 value = new Vector2(1f / (float)uvAnimationTileX, 1f / (float)uvAnimationTileY);
			int num = index % uvAnimationTileX;
			int num2 = index / uvAnimationTileX;
			Vector2 value2 = new Vector2((float)num * value.x, 1f - value.y - (float)num2 * value.y);
			GetComponent<Renderer>().material.SetTextureOffset("_MainTex", value2);
			GetComponent<Renderer>().material.SetTextureScale("_MainTex", value);
		}
		if (!loop && index >= uvAnimationTileX * uvAnimationTileY - 1)
		{
			play = false;
			if (Hidewhenstopplaying)
			{
				GetComponent<Renderer>().enabled = false;
			}
		}
	}
}
