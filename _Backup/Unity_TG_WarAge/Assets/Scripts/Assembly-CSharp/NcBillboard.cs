using UnityEngine;

public class NcBillboard : NcEffectBehaviour
{
	public enum AXIS_TYPE
	{
		AXIS_FORWARD = 0,
		AXIS_BACK = 1,
		AXIS_RIGHT = 2,
		AXIS_LEFT = 3,
		AXIS_UP = 4,
		AXIS_DOWN = 5
	}

	public enum ROTATION
	{
		NONE = 0,
		RND = 1,
		ROTATE = 2
	}

	public enum AXIS
	{
		X = 0,
		Y = 1,
		Z = 2
	}

	public bool m_bCameraLookAt;

	public bool m_bFixedObjectUp;

	public bool m_bFixedStand;

	public AXIS_TYPE m_FrontAxis;

	public ROTATION m_RatationMode;

	public AXIS m_RatationAxis = AXIS.Z;

	public float m_fRotationValue = 180f;

	protected float m_fRndValue;

	protected float m_fTotalRotationValue;

	protected Quaternion m_qOiginal;

	public Camera fightCamera;

	private void Awake()
	{
	}

	private void OnEnable()
	{
		UpdateBillboard();
	}

	public void UpdateBillboard()
	{
		m_fRndValue = Random.Range(0f, 360f);
		if (base.enabled)
		{
			Update();
		}
	}

	private void Start()
	{
		m_qOiginal = base.transform.rotation;
		fightCamera = Camera.main;
		GameObject gameObject = GameObject.Find("fightCamera");
		if (null != gameObject)
		{
			fightCamera = gameObject.GetComponent<Camera>();
		}
	}

	private void Update()
	{
		if (!(fightCamera == null))
		{
			Vector3 worldUp = ((!m_bFixedObjectUp) ? (fightCamera.transform.rotation * Vector3.up) : base.transform.up);
			if (m_bCameraLookAt)
			{
				base.transform.LookAt(fightCamera.transform, worldUp);
			}
			else
			{
				base.transform.LookAt(base.transform.position + fightCamera.transform.rotation * Vector3.back, worldUp);
			}
			switch (m_FrontAxis)
			{
			case AXIS_TYPE.AXIS_BACK:
				base.transform.Rotate(base.transform.up, 180f, Space.World);
				break;
			case AXIS_TYPE.AXIS_RIGHT:
				base.transform.Rotate(base.transform.up, 270f, Space.World);
				break;
			case AXIS_TYPE.AXIS_LEFT:
				base.transform.Rotate(base.transform.up, 90f, Space.World);
				break;
			case AXIS_TYPE.AXIS_UP:
				base.transform.Rotate(base.transform.right, 90f, Space.World);
				break;
			case AXIS_TYPE.AXIS_DOWN:
				base.transform.Rotate(base.transform.right, 270f, Space.World);
				break;
			}
			if (m_bFixedStand)
			{
				base.transform.rotation = Quaternion.Euler(new Vector3(0f, base.transform.rotation.eulerAngles.y, base.transform.rotation.eulerAngles.z));
			}
			if (m_RatationMode == ROTATION.RND)
			{
				base.transform.localRotation *= Quaternion.Euler((m_RatationAxis != 0) ? 0f : m_fRndValue, (m_RatationAxis != AXIS.Y) ? 0f : m_fRndValue, (m_RatationAxis != AXIS.Z) ? 0f : m_fRndValue);
			}
			if (m_RatationMode == ROTATION.ROTATE)
			{
				float num = m_fTotalRotationValue + NcEffectBehaviour.GetEngineDeltaTime() * m_fRotationValue;
				base.transform.Rotate((m_RatationAxis != 0) ? 0f : num, (m_RatationAxis != AXIS.Y) ? 0f : num, (m_RatationAxis != AXIS.Z) ? 0f : num, Space.Self);
				m_fTotalRotationValue = num;
			}
		}
	}
}
