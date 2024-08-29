using UnityEngine;

namespace ComponentEx
{
	public class FlashLighting : MonoBehaviour
	{
		public Vector3 m_startPos;

		public Vector3 m_endPos;

		public Material m_material;

		public float m_startWidth = 0.1f;

		public float m_endWidth = 0.03f;

		public float m_light_Distence = 1f;

		public float m_light_range_min = 0.1f;

		public float m_light_range_max = 0.3f;

		public bool m_light_cross;

		public float m_light_speed = 0.03f;

		public Color m_startColor = Color.white;

		public Color m_endColor = Color.white;

		public float peak_rate = 0.5f;

		public float peak_value = 0.1f;

		public bool m_activeFlash;

		private FlashLightingEffect m_lighting_effect1;

		private FlashLightingEffect m_lighting_effect2;

		public Vector3 startPos
		{
			get
			{
				return m_startPos;
			}
			set
			{
				m_startPos = value;
				m_lighting_effect1.startPos = value;
				m_lighting_effect2.startPos = value;
			}
		}

		public Vector3 endPos
		{
			get
			{
				return m_endPos;
			}
			set
			{
				m_endPos = value;
				m_lighting_effect1.endPos = value;
				m_lighting_effect2.endPos = value;
			}
		}

		public bool activeFlash
		{
			get
			{
				return m_activeFlash;
			}
			set
			{
				m_activeFlash = value;
				m_lighting_effect1.gameObject.SetActive(value);
				m_lighting_effect2.gameObject.SetActive(value);
			}
		}

		private void Awake()
		{
			GameObject gameObject = new GameObject("LightingObject1");
			gameObject.transform.parent = base.gameObject.transform;
			m_lighting_effect1 = gameObject.AddComponent<FlashLightingEffect>();
			GameObject gameObject2 = new GameObject("LightingObject2");
			gameObject2.transform.parent = base.gameObject.transform;
			m_lighting_effect2 = gameObject2.AddComponent<FlashLightingEffect>();
		}

		private void Update()
		{
			m_lighting_effect1.startPos = m_startPos;
			m_lighting_effect2.startPos = m_startPos;
			m_lighting_effect1.endPos = m_endPos;
			m_lighting_effect2.endPos = m_endPos;
			m_lighting_effect1.material = m_material;
			m_lighting_effect2.material = m_material;
			float num = Random.Range(m_startWidth, m_endWidth);
			m_lighting_effect1.startWidth = num;
			m_lighting_effect2.startWidth = num;
			m_lighting_effect1.endWidth = num;
			m_lighting_effect2.endWidth = num;
			m_lighting_effect1.light_Distence = m_light_Distence;
			m_lighting_effect2.light_Distence = m_light_Distence;
			m_lighting_effect1.light_range_min = m_light_range_min;
			m_lighting_effect2.light_range_min = m_light_range_min;
			m_lighting_effect1.light_range_max = m_light_range_max;
			m_lighting_effect2.light_range_max = m_light_range_max;
			m_lighting_effect1.light_cross = m_light_cross;
			m_lighting_effect2.light_cross = m_light_cross;
			m_lighting_effect1.light_speed = m_light_speed;
			m_lighting_effect2.light_speed = m_light_speed;
			m_lighting_effect1.startColor = m_startColor;
			m_lighting_effect2.startColor = m_startColor;
			m_lighting_effect1.endColor = m_endColor;
			m_lighting_effect2.endColor = m_endColor;
		}
	}
}
