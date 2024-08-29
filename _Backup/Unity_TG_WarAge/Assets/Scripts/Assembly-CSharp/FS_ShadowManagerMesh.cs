using System.Collections.Generic;
using UnityEngine;

public class FS_ShadowManagerMesh : MonoBehaviour
{
	public Material shadowMaterial;

	public bool isStatic;

	private int numShadows;

	private List<FS_ShadowSimple> shadows = new List<FS_ShadowSimple>();

	private Mesh _mesh;

	private Mesh _mesh1;

	private Mesh _mesh2;

	private bool pingPong;

	private MeshFilter _filter;

	private Renderer _ren;

	private Vector3[] _verts;

	private Vector2[] _uvs;

	private Vector3[] _norms;

	private Color[] _colors;

	private int[] _indices;

	private int blockGrowSize = 64;

	public int getNumShadows()
	{
		return numShadows;
	}

	public void Start()
	{
		if (isStatic)
		{
			_CreateGeometry();
		}
	}

	public void registerGeometry(FS_ShadowSimple s)
	{
		if (s.shadowMaterial != shadowMaterial)
		{
			Debug.LogError("Shadow did not have the same material");
		}
		shadows.Add(s);
	}

	public void recreateStaticGeometry()
	{
		_CreateGeometry();
	}

	private void LateUpdate()
	{
		if (!isStatic)
		{
			_CreateGeometry();
		}
	}

	private Mesh _GetMesh()
	{
		pingPong = !pingPong;
		if (pingPong)
		{
			if (_mesh1 == null)
			{
				_mesh1 = new Mesh();
				_mesh1.MarkDynamic();
				_mesh1.hideFlags = HideFlags.DontSave;
			}
			else
			{
				_mesh1.Clear();
			}
			return _mesh1;
		}
		if (_mesh2 == null)
		{
			_mesh2 = new Mesh();
			_mesh2.MarkDynamic();
			_mesh2.hideFlags = HideFlags.DontSave;
		}
		else
		{
			_mesh2.Clear();
		}
		return _mesh2;
	}

	private void _CreateGeometry()
	{
		numShadows = shadows.Count;
		int num = shadows.Count * 4;
		_mesh = _GetMesh();
		if (_filter == null)
		{
			_filter = GetComponent<MeshFilter>();
		}
		if (_filter == null)
		{
			_filter = base.gameObject.AddComponent<MeshFilter>();
		}
		if (_ren == null)
		{
			_ren = base.gameObject.GetComponent<MeshRenderer>();
		}
		if (_ren == null)
		{
			_ren = base.gameObject.AddComponent<MeshRenderer>();
			_ren.material = shadowMaterial;
		}
		if (num < 65000)
		{
			int num2 = (num >> 1) * 3;
			if (_indices == null || _indices.Length != num2)
			{
				_indices = new int[num2];
			}
			bool flag = false;
			int num3 = 0;
			if (_verts != null)
			{
				num3 = _verts.Length;
			}
			if (num > num3 || num < num3 - blockGrowSize)
			{
				flag = true;
				num = (Mathf.FloorToInt(num / blockGrowSize) + 1) * blockGrowSize;
			}
			if (flag)
			{
				_verts = new Vector3[num];
				_uvs = new Vector2[num];
				_norms = new Vector3[num];
				_colors = new Color[num];
			}
			int num4;
			int num5 = (num4 = 0);
			for (int i = 0; i < shadows.Count; i++)
			{
				FS_ShadowSimple fS_ShadowSimple = shadows[i];
				_verts[num5] = fS_ShadowSimple.corners[0];
				_verts[num5 + 1] = fS_ShadowSimple.corners[1];
				_verts[num5 + 2] = fS_ShadowSimple.corners[2];
				_verts[num5 + 3] = fS_ShadowSimple.corners[3];
				_indices[num4] = num5;
				_indices[num4 + 1] = num5 + 1;
				_indices[num4 + 2] = num5 + 2;
				_indices[num4 + 3] = num5 + 2;
				_indices[num4 + 4] = num5 + 3;
				_indices[num4 + 5] = num5;
				_uvs[num5].x = fS_ShadowSimple.uvs.x;
				_uvs[num5].y = fS_ShadowSimple.uvs.y;
				_uvs[num5 + 1].x = fS_ShadowSimple.uvs.x + fS_ShadowSimple.uvs.width;
				_uvs[num5 + 1].y = fS_ShadowSimple.uvs.y;
				_uvs[num5 + 2].x = fS_ShadowSimple.uvs.x + fS_ShadowSimple.uvs.width;
				_uvs[num5 + 2].y = fS_ShadowSimple.uvs.y + fS_ShadowSimple.uvs.height;
				_uvs[num5 + 3].x = fS_ShadowSimple.uvs.x;
				_uvs[num5 + 3].y = fS_ShadowSimple.uvs.y + fS_ShadowSimple.uvs.height;
				_norms[num5] = fS_ShadowSimple.normal;
				_norms[num5 + 1] = fS_ShadowSimple.normal;
				_norms[num5 + 2] = fS_ShadowSimple.normal;
				_norms[num5 + 3] = fS_ShadowSimple.normal;
				_colors[num5] = fS_ShadowSimple.color;
				_colors[num5 + 1] = fS_ShadowSimple.color;
				_colors[num5 + 2] = fS_ShadowSimple.color;
				_colors[num5 + 3] = fS_ShadowSimple.color;
				num4 += 6;
				num5 += 4;
			}
			if (flag)
			{
				_mesh.Clear(false);
			}
			else
			{
				_mesh.Clear(true);
			}
			_mesh.Clear();
			_mesh.name = "shadow mesh";
			_mesh.vertices = _verts;
			_mesh.uv = _uvs;
			_mesh.normals = _norms;
			_mesh.colors = _colors;
			_mesh.triangles = _indices;
			_mesh.RecalculateBounds();
			_filter.mesh = _mesh;
			shadows.Clear();
		}
		else
		{
			if (_filter.mesh != null)
			{
				_filter.mesh.Clear();
			}
			Debug.LogError("Too many shadows. limit is " + 16250);
		}
	}
}
