using System;
using System.Collections.Generic;
using Core.Unity;
using UnityEngine;

[ExecuteInEditMode]
public class TransObj : MonoBehaviour
{
	[Range(1f, 100f)]
	public float detectLength = 30f;

	[Range(-100f, 0f)]
	public float backLength = -10f;

	public float tweenSpeed = 0.5f;

	[Range(0f, 0.8f)]
	public float alpha;

	public new string tag = "trans_obj";

	[Range(0.1f, 2f)]
	public float time_inteval = 0.5f;

	public bool debug;

	private Dictionary<int, Transform> list_1 = new Dictionary<int, Transform>();

	private Dictionary<int, Transform> list_2 = new Dictionary<int, Transform>();

	private Dictionary<int, Transform> lastTransObjList;

	private Dictionary<int, Transform> newTransObjList;

	private float lastCheckTime;

	private MeshRenderer mrd;

	private Transform mTransform;

	private void Awake()
	{
		mTransform = base.transform;
	}

	private void Start()
	{
		Reset();
	}

	private void Reset()
	{
		lastTransObjList = list_1;
		newTransObjList = list_2;
	}

	private void SwitchList()
	{
		Dictionary<int, Transform> dictionary = lastTransObjList;
		lastTransObjList = newTransObjList;
		newTransObjList = dictionary;
		dictionary = null;
	}

	private void OnDrawGizmos()
	{
		Gizmos.color = Color.red;
		Gizmos.DrawRay(mTransform.position + mTransform.forward * backLength, mTransform.forward * detectLength);
	}

	private void Update()
	{
		try
		{
			UpdateCheck();
		}
		catch (Exception ex)
		{
			Core.Unity.Debug.LogError(" TransObj : " + ex.ToString());
		}
	}

	private void UpdateCheck()
	{
		if (debug)
		{
			UnityEngine.Debug.DrawLine(mTransform.position, mTransform.forward * detectLength, Color.red);
		}
		float time = Time.time;
		if (time - lastCheckTime <= time_inteval)
		{
			return;
		}
		lastCheckTime = time;
		RaycastHit[] array = Physics.RaycastAll(mTransform.position + mTransform.forward * backLength, mTransform.forward, detectLength + Mathf.Abs(backLength));
		if (array.Length == 0 && lastTransObjList.Count == 0)
		{
			return;
		}
		foreach (RaycastHit raycastHit in array)
		{
			Transform transform = raycastHit.transform;
			if (!transform.CompareTag(tag))
			{
				continue;
			}
			mrd = transform.gameObject.GetComponent<MeshRenderer>();
			if (mrd != null && mrd.material != null)
			{
				if (!newTransObjList.ContainsKey(transform.GetInstanceID()))
				{
					newTransObjList.Add(transform.GetInstanceID(), transform);
				}
				Color color = mrd.material.color;
				color.a = alpha;
				TweenColor.Begin(transform.gameObject, tweenSpeed, color);
			}
		}
		foreach (Transform value in lastTransObjList.Values)
		{
			if (null != value && !newTransObjList.ContainsKey(value.GetInstanceID()))
			{
				mrd = value.gameObject.GetComponent<MeshRenderer>();
				if (mrd != null)
				{
					Color color2 = mrd.material.color;
					color2.a = 1f;
					TweenColor.Begin(value.gameObject, tweenSpeed, color2);
				}
			}
		}
		SwitchList();
		newTransObjList.Clear();
	}

	private void OnDestroy()
	{
		list_1 = null;
		list_2 = null;
		lastTransObjList = null;
		newTransObjList = null;
		mrd = null;
	}
}
