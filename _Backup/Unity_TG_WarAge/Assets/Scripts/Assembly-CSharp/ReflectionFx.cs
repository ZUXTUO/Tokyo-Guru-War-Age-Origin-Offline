using System.Collections.Generic;
using UnityEngine;

public class ReflectionFx : MonoBehaviour
{
	private class ReflectiveObj
	{
		public Transform obj;

		public Renderer render;
	}

	public enum ReflQuality
	{
		High = 0,
		Middle = 1,
		Low = 2
	}

	private string defaultCameraName = "fightCamera";

	public static Camera mainCamera;

	private Vector3 lastCameraPosition = new Vector3(-999999f, -999999f, -99999f);

	private Quaternion lastCameraRatation = default(Quaternion);

	private Transform lastClosetReflectiveObj;

	private Ray m_ray = default(Ray);

	private RaycastHit m_raycastHit = default(RaycastHit);

	public Transform[] reflectiveObjects;

	public Transform[] effectedObjects;

	private ReflectiveObj[] m_reflectiveObjList;

	public LayerMask reflectionMask;

	private LayerMask reflection2ObjLayerMask;

	public Material[] reflectiveMaterials;

	public float farClipPlane = 26f;

	private Transform reflectiveSurfaceHeight;

	public Shader replacementShader;

	public float checkDistance = 20f;

	public ReflQuality quality = ReflQuality.Middle;

	public Color clearColor = Color.black;

	public string reflectionSampler = "_ReflectionTex";

	public float clipPlaneOffset = 0.07f;

	private Vector3 oldpos = Vector3.zero;

	private Camera reflectionCamera;

	private Dictionary<Camera, bool> helperCameras;

	private LinkedList<ReflectiveObj> curReflectionPlaneList = new LinkedList<ReflectiveObj>();

	private LinkedListNode<ReflectiveObj> lastNodeOfReflectionPlaneList;

	public static void SetReflectionCamera(Camera c)
	{
		mainCamera = c;
	}

	public void Start()
	{
	}

	public void OnEnable()
	{
		if (reflectiveObjects != null)
		{
			if (!SystemInfo.supportsRenderTextures)
			{
				base.enabled = false;
				return;
			}
			for (int i = 0; i < reflectiveObjects.Length; i++)
			{
				reflection2ObjLayerMask.value |= 1 << reflectiveObjects[i].gameObject.layer;
			}
			if (effectedObjects != null)
			{
				for (int j = 0; j < effectedObjects.Length; j++)
				{
					effectedObjects[j].GetComponent<Renderer>().materials = reflectiveMaterials;
				}
			}
			m_reflectiveObjList = new ReflectiveObj[reflectiveObjects.Length];
			for (int k = 0; k < reflectiveObjects.Length; k++)
			{
				Transform transform = reflectiveObjects[k];
				if (!transform.gameObject.GetComponent<BoxCollider>())
				{
					transform.gameObject.AddComponent<BoxCollider>();
					transform.gameObject.GetComponent<BoxCollider>().isTrigger = true;
				}
				ReflectiveObj reflectiveObj = new ReflectiveObj();
				reflectiveObj.obj = transform;
				reflectiveObj.render = transform.GetComponent<Renderer>();
				m_reflectiveObjList[k] = reflectiveObj;
			}
		}
		else
		{
			base.enabled = false;
		}
		base.gameObject.tag = "HighEffect";
		if (QualitySettings.GetQualityLevel() < 2)
		{
			base.enabled = false;
		}
	}

	public void OnDisable()
	{
		if (reflectiveMaterials == null || reflectionSampler == null)
		{
			return;
		}
		for (int i = 0; i < reflectiveMaterials.Length; i++)
		{
			if (reflectiveMaterials[i] != null)
			{
				reflectiveMaterials[i].SetTexture(reflectionSampler, null);
			}
		}
	}

	private Camera CreateReflectionCameraFor(Camera cam)
	{
		string text = mainCamera.name + "Reflection" + cam.name;
		Debug.Log("AngryBots: created internal reflection camera " + text);
		GameObject gameObject = GameObject.Find(text);
		if (!gameObject)
		{
			gameObject = new GameObject(text, typeof(Camera));
		}
		if (!gameObject.GetComponent(typeof(Camera)))
		{
			gameObject.AddComponent(typeof(Camera));
		}
		Camera component = gameObject.GetComponent<Camera>();
		component.backgroundColor = clearColor;
		component.clearFlags = CameraClearFlags.Color;
		SetStandardCameraParameter(component, reflectionMask);
		if (!component.targetTexture)
		{
			component.targetTexture = CreateTextureFor(cam);
		}
		return component;
	}

	public void HighQuality()
	{
		quality = ReflQuality.High;
	}

	private void SetStandardCameraParameter(Camera cam, LayerMask mask)
	{
		cam.backgroundColor = Color.black;
		cam.enabled = false;
		cam.cullingMask = reflectionMask;
		cam.farClipPlane = farClipPlane;
	}

	private RenderTexture CreateTextureFor(Camera cam)
	{
		RenderTextureFormat format = RenderTextureFormat.RGB565;
		if (!SystemInfo.SupportsRenderTextureFormat(format))
		{
			format = RenderTextureFormat.Default;
		}
		float num = 0.25f;
		num = ((quality == ReflQuality.High) ? 1f : ((quality != ReflQuality.Middle) ? 0.25f : 0.5f));
		RenderTexture renderTexture = new RenderTexture(Mathf.FloorToInt((float)cam.pixelWidth * num), Mathf.FloorToInt((float)cam.pixelHeight * num), 24, format);
		renderTexture.hideFlags = HideFlags.DontSave;
		return renderTexture;
	}

	public void RenderHelpCameras(Camera currentCam)
	{
		if (helperCameras == null)
		{
			helperCameras = new Dictionary<Camera, bool>();
		}
		if (!helperCameras.ContainsKey(currentCam))
		{
			helperCameras.Add(currentCam, false);
		}
		if (helperCameras[currentCam])
		{
			return;
		}
		if (!reflectionCamera)
		{
			reflectionCamera = CreateReflectionCameraFor(currentCam);
		}
		if (reflectiveMaterials != null)
		{
			Material[] array = reflectiveMaterials;
			foreach (Material material in array)
			{
				material.SetTexture(reflectionSampler, reflectionCamera.targetTexture);
			}
		}
		RenderReflectionFor(currentCam, reflectionCamera);
		helperCameras[currentCam] = true;
	}

	private void Add2CurReflectiveObjList(ReflectiveObj obj)
	{
		if (curReflectionPlaneList.Last == lastNodeOfReflectionPlaneList)
		{
			curReflectionPlaneList.AddLast(obj);
			lastNodeOfReflectionPlaneList = curReflectionPlaneList.Last;
		}
		else if (lastNodeOfReflectionPlaneList == null)
		{
			curReflectionPlaneList.First.Value = obj;
			lastNodeOfReflectionPlaneList = curReflectionPlaneList.First;
		}
		else
		{
			lastNodeOfReflectionPlaneList.Value = obj;
			lastNodeOfReflectionPlaneList = lastNodeOfReflectionPlaneList.Next;
		}
	}

	public void LateUpdate()
	{
		if (reflectiveObjects == null)
		{
			return;
		}
		GameObject gameObject = null;
		if (null == mainCamera)
		{
			gameObject = GameObject.Find(defaultCameraName);
			if (null != gameObject)
			{
				mainCamera = gameObject.GetComponent<Camera>();
			}
			if (null == mainCamera)
			{
				return;
			}
		}
		if (!mainCamera.gameObject.activeInHierarchy)
		{
			if (!(null != gameObject))
			{
				mainCamera = null;
			}
			return;
		}
		bool flag = true;
		if (mainCamera.transform.position == lastCameraPosition && mainCamera.transform.rotation == lastCameraRatation && null != lastClosetReflectiveObj)
		{
			flag = false;
		}
		else
		{
			lastCameraPosition = mainCamera.transform.position;
			lastCameraRatation = mainCamera.transform.rotation;
			flag = true;
		}
		if (flag)
		{
			lastNodeOfReflectionPlaneList = null;
			float num = float.PositiveInfinity;
			float maxDistance = float.PositiveInfinity;
			RaycastHit[] array = Physics.RaycastAll(mainCamera.transform.position, mainCamera.transform.forward, maxDistance);
			m_ray.origin = mainCamera.transform.position;
			m_ray.direction = mainCamera.transform.forward;
			if (Physics.Raycast(m_ray, out m_raycastHit, (int)reflection2ObjLayerMask))
			{
				if (m_reflectiveObjList == null)
				{
					m_reflectiveObjList = new ReflectiveObj[reflectiveObjects.Length];
					for (int i = 0; i < reflectiveObjects.Length; i++)
					{
						Transform transform = reflectiveObjects[i];
						if (!transform.gameObject.GetComponent<BoxCollider>())
						{
							transform.gameObject.AddComponent<BoxCollider>();
							transform.gameObject.GetComponent<BoxCollider>().isTrigger = true;
						}
						ReflectiveObj reflectiveObj = new ReflectiveObj();
						reflectiveObj.obj = transform;
						reflectiveObj.render = transform.GetComponent<Renderer>();
						m_reflectiveObjList[i] = reflectiveObj;
					}
				}
				for (int j = 0; j < m_reflectiveObjList.Length; j++)
				{
					ReflectiveObj reflectiveObj2 = m_reflectiveObjList[j];
					if (m_raycastHit.transform.GetInstanceID() == reflectiveObj2.obj.GetInstanceID())
					{
						Add2CurReflectiveObjList(reflectiveObj2);
					}
				}
			}
			if (lastNodeOfReflectionPlaneList != null)
			{
				LinkedListNode<ReflectiveObj> first = curReflectionPlaneList.First;
				Transform transform2 = null;
				float num2 = 0f;
				while (first != lastNodeOfReflectionPlaneList)
				{
					transform2 = first.Value.obj;
					num2 = Vector3.Distance(transform2.position, mainCamera.transform.position);
					if (num2 < num)
					{
						num = num2;
						lastClosetReflectiveObj = transform2;
					}
				}
				transform2 = lastNodeOfReflectionPlaneList.Value.obj;
				num2 = Vector3.Distance(transform2.position, mainCamera.transform.position);
				if (num2 < num)
				{
					num = num2;
					lastClosetReflectiveObj = transform2;
				}
			}
			if (!lastClosetReflectiveObj)
			{
				Vector3 vector = mainCamera.transform.forward * checkDistance;
				Vector3 a = mainCamera.transform.position + vector;
				if (m_reflectiveObjList == null)
				{
					m_reflectiveObjList = new ReflectiveObj[reflectiveObjects.Length];
					for (int k = 0; k < reflectiveObjects.Length; k++)
					{
						Transform transform3 = reflectiveObjects[k];
						if (!transform3.gameObject.GetComponent<BoxCollider>())
						{
							transform3.gameObject.AddComponent<BoxCollider>();
							transform3.gameObject.GetComponent<BoxCollider>().isTrigger = true;
						}
						ReflectiveObj reflectiveObj3 = new ReflectiveObj();
						reflectiveObj3.obj = transform3;
						reflectiveObj3.render = transform3.GetComponent<Renderer>();
						m_reflectiveObjList[k] = reflectiveObj3;
					}
				}
				for (int l = 0; l < m_reflectiveObjList.Length; l++)
				{
					ReflectiveObj reflectiveObj4 = m_reflectiveObjList[l];
					if (null != reflectiveObj4.render && reflectiveObj4.render.isVisible)
					{
						float num3 = Vector3.Distance(a, reflectiveObj4.obj.position);
						if (num3 < num)
						{
							float num4 = Vector3.Dot(mainCamera.transform.forward, reflectiveObj4.obj.transform.up);
							num = num3;
							lastClosetReflectiveObj = reflectiveObj4.obj;
						}
					}
				}
			}
			if (!lastClosetReflectiveObj)
			{
				return;
			}
		}
		ObjectBeingRendered(lastClosetReflectiveObj, mainCamera);
		if (helperCameras != null)
		{
			helperCameras.Clear();
		}
	}

	private void ObjectBeingRendered(Transform tr, Camera currentCam)
	{
		if (!(null == tr))
		{
			reflectiveSurfaceHeight = tr;
			RenderHelpCameras(currentCam);
		}
	}

	private void RenderReflectionFor(Camera cam, Camera reflectCamera)
	{
		if ((bool)reflectCamera)
		{
			SaneCameraSettings(reflectCamera);
			reflectCamera.backgroundColor = clearColor;
			GL.SetRevertBackfacing(true);
			Transform transform = reflectiveSurfaceHeight;
			Vector3 eulerAngles = cam.transform.eulerAngles;
			reflectCamera.transform.eulerAngles = new Vector3(0f - eulerAngles.x, eulerAngles.y, eulerAngles.z);
			reflectCamera.transform.position = cam.transform.position;
			Vector3 position = transform.transform.position;
			position.y = transform.position.y;
			Vector3 up = transform.transform.up;
			float w = 0f - Vector3.Dot(up, position) - clipPlaneOffset;
			Vector4 plane = new Vector4(up.x, up.y, up.z, w);
			Matrix4x4 zero = Matrix4x4.zero;
			zero = CalculateReflectionMatrix(zero, plane);
			oldpos = cam.transform.position;
			Vector3 position2 = zero.MultiplyPoint(oldpos);
			reflectCamera.worldToCameraMatrix = cam.worldToCameraMatrix * zero;
			Vector4 clipPlane = CameraSpacePlane(reflectCamera, position, up, 1f);
			Matrix4x4 projectionMatrix = cam.projectionMatrix;
			projectionMatrix = CalculateObliqueMatrix(projectionMatrix, clipPlane);
			reflectCamera.projectionMatrix = projectionMatrix;
			reflectCamera.fieldOfView = cam.fieldOfView;
			reflectCamera.ResetProjectionMatrix();
			reflectCamera.transform.position = position2;
			Vector3 eulerAngles2 = cam.transform.eulerAngles;
			reflectCamera.transform.eulerAngles = new Vector3(0f - eulerAngles2.x, eulerAngles2.y, eulerAngles2.z);
			reflectCamera.RenderWithShader(replacementShader, "Reflection");
			GL.SetRevertBackfacing(false);
		}
	}

	private void SaneCameraSettings(Camera helperCam)
	{
		helperCam.depthTextureMode = DepthTextureMode.None;
		helperCam.backgroundColor = Color.black;
		helperCam.clearFlags = CameraClearFlags.Color;
		helperCam.renderingPath = RenderingPath.Forward;
	}

	private static Matrix4x4 CalculateObliqueMatrix(Matrix4x4 projection, Vector4 clipPlane)
	{
		Vector4 b = projection.inverse * new Vector4(sgn(clipPlane.x), sgn(clipPlane.y), 1f, 1f);
		Vector4 vector = clipPlane * (2f / Vector4.Dot(clipPlane, b));
		projection[2] = vector.x - projection[3];
		projection[6] = vector.y - projection[7];
		projection[10] = vector.z - projection[11];
		projection[14] = vector.w - projection[15];
		return projection;
	}

	private static Matrix4x4 CalculateReflectionMatrix(Matrix4x4 reflectionMat, Vector4 plane)
	{
		reflectionMat.m00 = 1f - 2f * plane[0] * plane[0];
		reflectionMat.m01 = -2f * plane[0] * plane[1];
		reflectionMat.m02 = -2f * plane[0] * plane[2];
		reflectionMat.m03 = -2f * plane[3] * plane[0];
		reflectionMat.m10 = -2f * plane[1] * plane[0];
		reflectionMat.m11 = 1f - 2f * plane[1] * plane[1];
		reflectionMat.m12 = -2f * plane[1] * plane[2];
		reflectionMat.m13 = -2f * plane[3] * plane[1];
		reflectionMat.m20 = -2f * plane[2] * plane[0];
		reflectionMat.m21 = -2f * plane[2] * plane[1];
		reflectionMat.m22 = 1f - 2f * plane[2] * plane[2];
		reflectionMat.m23 = -2f * plane[3] * plane[2];
		reflectionMat.m30 = 0f;
		reflectionMat.m31 = 0f;
		reflectionMat.m32 = 0f;
		reflectionMat.m33 = 1f;
		return reflectionMat;
	}

	private static float sgn(float a)
	{
		if (a > 0f)
		{
			return 1f;
		}
		if (a < 0f)
		{
			return -1f;
		}
		return 0f;
	}

	private Vector4 CameraSpacePlane(Camera cam, Vector3 pos, Vector3 normal, float sideSign)
	{
		Vector3 v = pos + normal * clipPlaneOffset;
		Matrix4x4 worldToCameraMatrix = cam.worldToCameraMatrix;
		Vector3 lhs = worldToCameraMatrix.MultiplyPoint(v);
		Vector3 rhs = worldToCameraMatrix.MultiplyVector(normal).normalized * sideSign;
		return new Vector4(rhs.x, rhs.y, rhs.z, 0f - Vector3.Dot(lhs, rhs));
	}
}
