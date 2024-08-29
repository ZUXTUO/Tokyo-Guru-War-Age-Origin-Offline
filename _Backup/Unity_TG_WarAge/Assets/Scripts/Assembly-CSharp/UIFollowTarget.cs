using UnityEngine;

public class UIFollowTarget : MonoBehaviour
{
	public delegate void OnVisibilityChange(bool isVisible);

	public OnVisibilityChange onChange;

	public Transform target;

	public Camera gameCamera;

	public Camera uiCamera;

	public bool disableIfInvisible = true;

	public bool destroyWithTarget = true;

	private Transform mTrans;

	private int mIsVisible = -1;

	public bool isVisible
	{
		get
		{
			return mIsVisible == 1;
		}
	}

	private void Awake()
	{
		mTrans = base.transform;
	}

	private void Start()
	{
		if ((bool)target)
		{
			if (gameCamera == null)
			{
				gameCamera = NGUITools.FindCameraForLayer(target.gameObject.layer);
			}
			if (uiCamera == null)
			{
				uiCamera = NGUITools.FindCameraForLayer(base.gameObject.layer);
			}
			Update();
		}
		else if (destroyWithTarget)
		{
			Object.Destroy(base.gameObject);
		}
		else
		{
			base.enabled = false;
		}
	}

	private void Update()
	{
		if ((bool)target && uiCamera != null)
		{
			Vector3 position = gameCamera.WorldToViewportPoint(target.position);
			int num = (((gameCamera.orthographic || position.z > 0f) && position.x > 0f && position.x < 1f && position.y > 0f && position.y < 1f) ? 1 : 0);
			bool flag = num == 1;
			if (flag)
			{
				position = uiCamera.ViewportToWorldPoint(position);
				position = mTrans.parent.InverseTransformPoint(position);
				position.z = 0f;
				mTrans.localPosition = position;
			}
			if (mIsVisible == num)
			{
				return;
			}
			mIsVisible = num;
			if (disableIfInvisible)
			{
				int i = 0;
				for (int childCount = mTrans.childCount; i < childCount; i++)
				{
					NGUITools.SetActive(mTrans.GetChild(i).gameObject, flag);
				}
			}
			if (onChange != null)
			{
				onChange(flag);
			}
		}
		else
		{
			Object.Destroy(base.gameObject);
		}
	}
}
