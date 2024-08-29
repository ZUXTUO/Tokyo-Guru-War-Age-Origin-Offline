using UnityEngine;

namespace ComponentEx
{
	public class FlashLightingEffect : MonoBehaviour
	{
		public Vector3 startPos;

		public Vector3 endPos;

		public float startWidth = 0.1f;

		public float endWidth = 0.03f;

		private LineRenderer lineRender;

		public float light_Distence = 1f;

		public float light_range_min = 0.1f;

		public float light_range_max = 0.3f;

		public bool light_cross;

		public float uv_o_x;

		public float uv_o_y;

		public float uv_s_x = 1f;

		public float uv_s_y = 1f;

		public Material material;

		public float light_speed = 0.03f;

		public Color startColor = Color.white;

		public Color endColor = Color.white;

		public float peak_rate = 0.5f;

		public float peak_value = 0.1f;

		public bool bMove;

		public float moveSpeed = 0.1f;

		private float last_time;

		private Vector3 movePos = Vector3.zero;

		private void Awake()
		{
			lineRender = base.gameObject.AddComponent<LineRenderer>();
			movePos = startPos;
		}

		private void Update()
		{
			Draw();
		}

		private void Draw()
		{
			if (!lineRender)
			{
				return;
			}
			if (bMove)
			{
				movePos = Vector3.Lerp(movePos, endPos, moveSpeed);
			}
			else
			{
				movePos = endPos;
			}
			if ((bool)material && lineRender.material.name != material.name)
			{
				lineRender.material = material;
			}
			lineRender.material.SetTextureOffset("_MainTex", new Vector2(uv_o_x, uv_o_y));
			lineRender.material.SetTextureScale("_MainTex", new Vector2(uv_s_x, uv_s_y));
			lineRender.SetColors(startColor, endColor);
			float realtimeSinceStartup = Time.realtimeSinceStartup;
			if (!(realtimeSinceStartup - last_time > light_speed))
			{
				return;
			}
			last_time = realtimeSinceStartup;
			lineRender.SetWidth(startWidth, endWidth);
			float num = Vector3.Distance(startPos, movePos);
			float num2 = num / light_Distence;
			int num3 = (int)num2 + 2;
			if (num3 <= 0)
			{
				return;
			}
			lineRender.SetVertexCount(num3);
			for (int i = 0; i < num3; i++)
			{
				Vector3 position = Vector3.Lerp(startPos, movePos, (float)i / (float)(num3 - 1));
				if (i > 0 && i < num3 - 1)
				{
					float num4 = (float)i / (float)num3;
					num4 = Mathf.Abs(num4 - peak_rate);
					num4 = peak_rate - num4;
					if (num4 < 0f)
					{
						num4 = 0f;
					}
					float num5 = Random.RandomRange(light_range_min, light_range_max);
					num5 += num4 * peak_value * 3f;
					float x = Random.Range(0f - num5, num5);
					float y = Random.Range(0f - num5, num5);
					float z = Random.Range(0f - num5, num5);
					position += new Vector3(x, y, z);
				}
				lineRender.SetPosition(i, position);
			}
		}
	}
}
