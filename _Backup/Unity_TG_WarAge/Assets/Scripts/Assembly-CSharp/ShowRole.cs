using UnityEngine;

public class ShowRole : MonoBehaviour
{
	public Texture bgTexture;

	public Camera cam;

	[Range(0f, 1000f)]
	public float far;

	[Range(0f, 1000f)]
	public float near;

	[Range(0f, 180f)]
	public float fov;

	[Range(0f, 1000f)]
	public float bgNearDistance;

	[Range(0f, 1000f)]
	public float shadowTargetDistance;

	public StarWarsShadow shadowCam;

	public Transform posRole;

	private Material bgMat;

	private GameObject bgObject;

	private MeshFilter mf;

	private MeshCollider mc;

	private Mesh bgMesh;

	private MeshRenderer mr;

	public bool enableUpdate;

	private void Start()
	{
		if (cam != null)
		{
			bgMat = new Material(Shader.Find("DyShader/Colored BG"));
			bgObject = new GameObject("bg");
			bgObject.transform.parent = base.transform;
			bgObject.transform.localPosition = Vector3.zero;
			if (shadowCam != null)
			{
				posRole.parent = base.transform;
				shadowCam.CameraLayerMask = 1 << LayerMask.NameToLayer("player");
				shadowCam.ProjectorLayerMask = 1 << LayerMask.NameToLayer("terrain");
			}
			mf = bgObject.AddComponent<MeshFilter>();
			mr = bgObject.AddComponent<MeshRenderer>();
			bgMesh = new Mesh();
			mf.mesh = bgMesh;
			mr.material = bgMat;
			mc = bgObject.AddComponent<MeshCollider>();
			setParam();
		}
		else
		{
			Object.DestroyImmediate(this);
		}
	}

	private void setParam()
	{
		cam.orthographic = false;
		cam.nearClipPlane = near;
		cam.farClipPlane = far;
		cam.fieldOfView = fov;
		bgMat.mainTexture = bgTexture;
		Vector3 vector = cam.ViewportToWorldPoint(new Vector3(0f, 0f, near + bgNearDistance));
		Vector3 vector2 = cam.ViewportToWorldPoint(new Vector3(1f, 0f, near + bgNearDistance));
		Vector3 vector3 = cam.ViewportToWorldPoint(new Vector3(0f, 1f, far));
		Vector3 vector4 = cam.ViewportToWorldPoint(new Vector3(1f, 1f, far));
		Vector3 vector5 = bgObject.transform.worldToLocalMatrix.MultiplyPoint(vector);
		Vector3 vector6 = bgObject.transform.worldToLocalMatrix.MultiplyPoint(vector2);
		Vector3 vector7 = bgObject.transform.worldToLocalMatrix.MultiplyPoint(vector3);
		Vector3 vector8 = bgObject.transform.worldToLocalMatrix.MultiplyPoint(vector4);
		if (shadowCam != null)
		{
			Vector3 pointA = Point.interpolate(vector, vector2);
			Vector3 pointB = Point.interpolate(vector3, vector4);
			pointB.y = pointA.y;
			Vector3 localPosition = base.transform.worldToLocalMatrix.MultiplyPoint(Point.interpolate(pointA, pointB, shadowTargetDistance / (far - near)));
			posRole.localPosition = localPosition;
			shadowCam.rayTarget = posRole;
			shadowCam.rayDistance = Vector3.Distance(posRole.position, shadowCam.transform.position) + 20f;
		}
		Vector3[] array = new Vector3[4];
		int[] array2 = new int[12];
		array[0] = vector5;
		array[1] = vector6;
		array[2] = vector7;
		array[3] = vector8;
		array2[0] = 0;
		array2[1] = 1;
		array2[2] = 2;
		array2[3] = 1;
		array2[4] = 3;
		array2[5] = 2;
		array2[6] = 0;
		array2[7] = 2;
		array2[8] = 1;
		array2[9] = 1;
		array2[10] = 2;
		array2[11] = 3;
		Vector2[] uv = new Vector2[4]
		{
			new Vector2(0f, 0f),
			new Vector2(1f, 0f),
			new Vector2(0f, 1f),
			new Vector2(1f, 1f)
		};
		bgMesh.vertices = array;
		bgMesh.triangles = array2;
		bgMesh.uv = uv;
		mc.enabled = false;
		mc.enabled = true;
	}

	private void Update()
	{
	}
}
