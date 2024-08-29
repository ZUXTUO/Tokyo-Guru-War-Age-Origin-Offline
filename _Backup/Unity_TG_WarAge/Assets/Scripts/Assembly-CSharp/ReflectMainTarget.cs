using UnityEngine;

public class ReflectMainTarget : MonoBehaviour
{
	public Transform[] influenceObjs;

	private Camera reflCam;

	public Material[] usedMaterials;

	public string reflTexName = "_ReflectionTex";

	public GameObject camObj;

	public RenderTexture reflTex;

	private Color clearColor = Color.black;

	private Vector3 oldpos = Vector3.zero;

	public float clipPlaneOffset = 0.07f;

	public void initCamera(Camera targetCam, LayerMask cullingMask, int w, int h)
	{
		if (camObj != null)
		{
			Object.DestroyImmediate(camObj);
		}
		camObj = GameObject.CreatePrimitive(PrimitiveType.Cube);
		camObj.name = "ReflCamFor " + base.name;
		Object.Destroy(camObj.GetComponent<BoxCollider>());
		Object.Destroy(camObj.GetComponent<MeshFilter>());
		Object.Destroy(camObj.GetComponent<MeshRenderer>());
		reflCam = camObj.AddComponent<Camera>();
		reflCam.CopyFrom(targetCam);
		reflCam.cullingMask = cullingMask;
		if (reflTex != null)
		{
			reflTex.Release();
			reflTex = new RenderTexture(w, h, 24);
			reflTex.filterMode = FilterMode.Bilinear;
		}
		else
		{
			reflTex = new RenderTexture(w, h, 24);
			reflTex.filterMode = FilterMode.Bilinear;
		}
		reflCam.targetTexture = reflTex;
		camObj.AddComponent<MirrorCam>();
	}

	public void disableRefl()
	{
		if (camObj != null)
		{
			Object.DestroyImmediate(camObj);
		}
		if (!(reflTex != null))
		{
			return;
		}
		if (influenceObjs != null && influenceObjs.Length > 0)
		{
			for (int i = 0; i < influenceObjs.Length; i++)
			{
				if (!(influenceObjs[i] != null))
				{
					continue;
				}
				Renderer component = influenceObjs[i].GetComponent<Renderer>();
				if (!(component != null))
				{
					continue;
				}
				if (usedMaterials != null && usedMaterials[i] != null)
				{
					component.sharedMaterial = usedMaterials[i];
					component.material = usedMaterials[i];
					if (usedMaterials[i].HasProperty(reflTexName))
					{
						usedMaterials[i].SetTexture(reflTexName, null);
					}
				}
				else
				{
					Material material = component.material;
					if (material.HasProperty(reflTexName))
					{
						material.SetTexture(reflTexName, null);
					}
				}
			}
		}
		reflTex.Release();
		reflTex = null;
	}

	public void useReflection(Camera targetCam)
	{
		if (camObj == null || reflCam == null)
		{
			return;
		}
		bool flag = false;
		for (int i = 0; i < influenceObjs.Length; i++)
		{
			Renderer component = influenceObjs[i].GetComponent<Renderer>();
			if (component != null && component.isVisible)
			{
				flag = true;
			}
		}
		if (flag)
		{
			camObj.SetActive(true);
			renderReflCamView(targetCam);
			if (influenceObjs == null || influenceObjs.Length <= 0)
			{
				return;
			}
			for (int j = 0; j < influenceObjs.Length; j++)
			{
				if (!(influenceObjs[j] != null))
				{
					continue;
				}
				Renderer component2 = influenceObjs[j].GetComponent<Renderer>();
				if (!(component2 != null))
				{
					continue;
				}
				if (usedMaterials != null && usedMaterials[j] != null)
				{
					component2.sharedMaterial = usedMaterials[j];
					component2.material = usedMaterials[j];
					if (usedMaterials[j].HasProperty(reflTexName))
					{
						usedMaterials[j].SetTexture(reflTexName, reflTex);
					}
				}
				else
				{
					Material material = component2.material;
					if (material.HasProperty(reflTexName))
					{
						material.SetTexture(reflTexName, reflTex);
					}
				}
			}
		}
		else
		{
			camObj.SetActive(false);
		}
	}

	private void renderReflCamView(Camera targetCam)
	{
		reflCam.backgroundColor = clearColor;
		Vector3 eulerAngles = targetCam.transform.eulerAngles;
		reflCam.transform.eulerAngles = new Vector3(0f - eulerAngles.x, eulerAngles.y, eulerAngles.z);
		reflCam.transform.position = targetCam.transform.position;
		Vector3 position = base.transform.position;
		position.y = base.transform.position.y;
		Vector3 up = base.transform.up;
		float w = 0f - Vector3.Dot(up, position) - clipPlaneOffset;
		Vector4 plane = new Vector4(up.x, up.y, up.z, w);
		Matrix4x4 zero = Matrix4x4.zero;
		zero = CalculateReflectionMatrix(zero, plane);
		oldpos = targetCam.transform.position;
		Vector3 position2 = zero.MultiplyPoint(oldpos);
		reflCam.worldToCameraMatrix = targetCam.worldToCameraMatrix * zero;
		Vector4 clipPlane = CameraSpacePlane(reflCam, position, up, 1f);
		Matrix4x4 projectionMatrix = targetCam.projectionMatrix;
		projectionMatrix = CalculateObliqueMatrix(projectionMatrix, clipPlane);
		reflCam.projectionMatrix = projectionMatrix;
		reflCam.fieldOfView = targetCam.fieldOfView;
		reflCam.ResetProjectionMatrix();
		reflCam.transform.position = position2;
		Vector3 eulerAngles2 = targetCam.transform.eulerAngles;
		reflCam.transform.eulerAngles = new Vector3(0f - eulerAngles2.x, eulerAngles2.y, eulerAngles2.z);
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

	private Vector4 CameraSpacePlane(Camera cam, Vector3 pos, Vector3 normal, float sideSign)
	{
		Vector3 v = pos + normal * clipPlaneOffset;
		Matrix4x4 worldToCameraMatrix = cam.worldToCameraMatrix;
		Vector3 lhs = worldToCameraMatrix.MultiplyPoint(v);
		Vector3 rhs = worldToCameraMatrix.MultiplyVector(normal).normalized * sideSign;
		return new Vector4(rhs.x, rhs.y, rhs.z, 0f - Vector3.Dot(lhs, rhs));
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
}
