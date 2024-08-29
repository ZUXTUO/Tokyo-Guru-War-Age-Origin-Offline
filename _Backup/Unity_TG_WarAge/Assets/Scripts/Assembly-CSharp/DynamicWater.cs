using System;
using System.Collections.Generic;
using LostPolygon.DynamicWaterSystem;
using UnityEngine;

[AddComponentMenu("Lost Polygon/Dynamic Water System/Dynamic Water")]
[RequireComponent(typeof(MeshFilter))]
[RequireComponent(typeof(MeshRenderer))]
[RequireComponent(typeof(BoxCollider))]
public class DynamicWater : FluidVolume, IDynamicWaterSettings, IDynamicWaterFluidVolumeSettings, IDynamicWaterFieldState
{
	public const string PlaneColliderLayerName = "DynamicWaterPlaneCollider";

	public const string DynamicWaterObstructionTag = "DynamicWaterObstruction";

	public bool UsePlaneCollider = true;

	public bool UpdateWhenNotVisible;

	private MeshFilter _meshFilter;

	private MeshRenderer _meshRenderer;

	private DynamicWaterSolver _waterSolver;

	private bool _prevIsDirty = true;

	private DynamicWaterMesh _waterMesh;

	private DynamicWaterMesh _waterMeshSimple;

	private Vector2 _nodeSizeNormalized;

	private BoxCollider _planeCollider;

	private Vector3 _lossyScale;

	[SerializeField]
	private float _damping = 0.97f;

	[SerializeField]
	private float _speed = 45f;

	[SerializeField]
	private bool _calculateNormals = true;

	[SerializeField]
	private bool _useFakeNormals;

	[SerializeField]
	private bool _normalizeFakeNormals = true;

	[SerializeField]
	private bool _useObstructions;

	[SerializeField]
	private bool _setTangents;

	[SerializeField]
	private int _quality = 64;

	private int _resolution = 64;

	private Vector2Int _grid;

	private float _nodeSize;

	public int Quality
	{
		get
		{
			return _quality;
		}
		set
		{
			if (_quality != value)
			{
				_quality = Mathf.Clamp(value, 4, 256);
				_resolution = Mathf.Clamp(Mathf.RoundToInt((float)(_quality * MaxResolution()) / 256f), 4, MaxResolution());
				if (_resolution % 2 == 1)
				{
					_resolution++;
				}
				PropertyChanged();
			}
		}
	}

	public Vector2Int GridSize
	{
		get
		{
			return _grid;
		}
	}

	public float NodeSize
	{
		get
		{
			return _nodeSize;
		}
	}

	public bool CalculateNormals
	{
		get
		{
			return _calculateNormals;
		}
		set
		{
			_calculateNormals = value;
		}
	}

	public bool UseFakeNormals
	{
		get
		{
			return _useFakeNormals;
		}
		set
		{
			_useFakeNormals = value;
		}
	}

	public bool NormalizeFakeNormals
	{
		get
		{
			return _normalizeFakeNormals;
		}
		set
		{
			_normalizeFakeNormals = value;
		}
	}

	public bool SetTangents
	{
		get
		{
			return _setTangents;
		}
		set
		{
			_setTangents = value;
		}
	}

	public bool UseObstructions
	{
		get
		{
			return _useObstructions;
		}
		set
		{
			_useObstructions = value;
		}
	}

	public float Speed
	{
		get
		{
			return _speed;
		}
		set
		{
			_speed = Mathf.Clamp(value, 0f, MaxSpeed());
		}
	}

	public float Damping
	{
		get
		{
			return 1f - _damping;
		}
		set
		{
			_damping = 1f - Mathf.Clamp01(value);
		}
	}

	public DynamicWaterSolver Solver
	{
		get
		{
			return _waterSolver;
		}
	}

	public virtual BoxCollider PlaneCollider
	{
		get
		{
			return _planeCollider;
		}
	}

	public override void CreateSplash(Vector3 center, float radius, float force)
	{
		if (!(_waterSolver == null) && _collider.bounds.Contains(center))
		{
			center = _transform.InverseTransformPoint(center);
			center = new Vector2(center.x * _nodeSizeNormalized.x, center.z * _nodeSizeNormalized.y);
			CreateSplashNormalized(center, radius, force);
		}
	}

	public void CreateSplash(Vector3 start, Vector3 end, float radius, float force)
	{
		if (!(_waterSolver == null) && (_collider.bounds.Contains(start) || _collider.bounds.Contains(end)))
		{
			start = _transform.InverseTransformPoint(start);
			end = _transform.InverseTransformPoint(end);
			start = new Vector2(start.x * _nodeSizeNormalized.x, start.z * _nodeSizeNormalized.y);
			end = new Vector2(end.x * _nodeSizeNormalized.x, end.z * _nodeSizeNormalized.y);
			CreateSplashLine(new Vector2Int(start), new Vector2Int(end), radius, force);
		}
	}

	public override float GetWaterLevel(float x, float z)
	{
		if (_waterSolver == null)
		{
			return 0f;
		}
		Vector3 position = default(Vector3);
		position.x = x;
		position.y = 0f;
		position.z = z;
		position = _transform.InverseTransformPoint(position);
		position.x *= _nodeSizeNormalized.x;
		position.z *= _nodeSizeNormalized.y;
		position.y = _waterSolver.GetWaterLevel(position.x, position.z);
		if (position.y != float.NegativeInfinity)
		{
			position.y = _transform.position.y + _lossyScale.y * position.y;
		}
		return position.y;
	}

	public int MaxResolution()
	{
		float num = 0.5f * (Mathf.Sqrt(260000f * _size.x * _size.y + _size.x * _size.x + _size.y * _size.y - 2f * _size.x * _size.y) - _size.x - _size.y);
		num /= Mathf.Min(_size.x, _size.y);
		int num2 = (int)num - 1;
		while (true)
		{
			Vector2Int vector2Int = SizeToGridResolution(Size, num2);
			if (vector2Int.x * vector2Int.y > 65000)
			{
				num2--;
				continue;
			}
			break;
		}
		return num2;
	}

	public float MaxSpeed()
	{
		Vector2Int vector2Int = SizeToGridResolution(Size, _resolution);
		float num = (float)(vector2Int.x + vector2Int.y) / 128f;
		return 1.412f / (Time.fixedDeltaTime * num);
	}

	public void RecalculateObstructions()
	{
		bool[] array = new bool[_grid.x * _grid.y];
		Vector2 vector = new Vector2(1f / (float)_grid.x * _collider.size.x, 1f / (float)_grid.y * _collider.size.z);
		GameObject[] gameObjectsWithTagInBounds = GetGameObjectsWithTagInBounds("DynamicWaterObstruction", _collider.bounds);
		for (int i = 0; i < _grid.y; i++)
		{
			for (int j = 0; j < _grid.x; j++)
			{
				int num = i * _grid.x + j;
				float x = (float)j * vector.x;
				float z = (float)i * vector.y;
				GameObject[] array2 = gameObjectsWithTagInBounds;
				foreach (GameObject gameObject in array2)
				{
					Collider component = gameObject.GetComponent<Collider>();
					if (component != null)
					{
						Vector3 point = _transform.TransformPoint(x, 0f, z);
						if (component.bounds.Contains(point) && ColliderTools.IsPointInsideCollider(component, point))
						{
							array[num] = true;
							break;
						}
					}
				}
			}
		}
		_waterSolver.FieldObstruction = array;
	}

	private GameObject[] GetGameObjectsWithTagInBounds(string searchTag, Bounds bounds)
	{
		GameObject[] array = GameObject.FindGameObjectsWithTag(searchTag);
		List<GameObject> list = new List<GameObject>(array.Length);
		GameObject[] array2 = array;
		foreach (GameObject gameObject in array2)
		{
			if (gameObject.GetComponent<Collider>() != null && bounds.Intersects(gameObject.GetComponent<Collider>().bounds))
			{
				list.Add(gameObject);
			}
		}
		return list.ToArray();
	}

	protected override void Initialize()
	{
		base.Initialize();
		UpdateComponents();
		UpdateProperties();
	}

	protected override void PropertyChanged()
	{
		UpdateProperties();
	}

	protected override void UpdateCollider()
	{
		Vector2 vector = new Vector2(_size.x * base.transform.lossyScale.x, _size.y * base.transform.lossyScale.y);
		if (Application.isPlaying)
		{
			_collider.center = new Vector3(vector.x / 2f, 0f, vector.y / 2f);
			_collider.size = new Vector3(vector.x, _depth * 2f, vector.y);
		}
		else
		{
			_collider.center = new Vector3(vector.x / 2f, (0f - _depth) / 2f - 0.1f, vector.y / 2f);
			_collider.size = new Vector3(vector.x, _depth - 0.1f, vector.y);
		}
		_collider.isTrigger = true;
	}

	protected void CreatePlaneCollider()
	{
		GameObject gameObject = null;
		foreach (Transform item in base.transform)
		{
			if (item.CompareTag("DynamicWaterPlaneCollider"))
			{
				gameObject = item.gameObject;
				break;
			}
		}
		if (gameObject == null)
		{
			gameObject = new GameObject("DynamicWaterPlaneCollider");
			gameObject.tag = "DynamicWaterPlaneCollider";
			gameObject.layer = LayerMask.NameToLayer("DynamicWaterPlaneCollider");
			gameObject.transform.parent = _transform;
			gameObject.transform.rotation = base.transform.rotation;
		}
		BoxCollider boxCollider = gameObject.GetComponent<BoxCollider>();
		if (boxCollider == null)
		{
			boxCollider = gameObject.AddComponent<BoxCollider>();
		}
		boxCollider.size = new Vector3(_collider.size.x, 0f, _collider.size.z);
		boxCollider.center = _collider.center;
		boxCollider.isTrigger = true;
		_planeCollider = boxCollider;
		gameObject.transform.localPosition = Vector3.zero;
	}

	private void Start()
	{
		Initialize();
	}

	private void FixedUpdate()
	{
		if (Application.isPlaying)
		{
			if (Application.isEditor)
			{
				UpdateComponents();
			}
			StepSimulation();
		}
	}

	private void OnDestroy()
	{
		ClearMeshes();
	}

	private void StepSimulation()
	{
		if (_waterSolver == null || (!_meshRenderer.isVisible && !UpdateWhenNotVisible))
		{
			return;
		}
		_lossyScale = _transform.lossyScale;
		_waterSolver.StepSimulation(_speed, _damping);
		if (_waterSolver.IsDirty)
		{
			_waterMesh.IsDirty = _waterSolver.IsDirty;
			if (_meshRenderer.isVisible)
			{
				float[] field = _waterSolver.Field;
				bool[] fieldObstruction = _waterSolver.FieldObstruction;
				_waterMesh.UpdateMesh(field, fieldObstruction);
			}
		}
		if (_prevIsDirty != _waterSolver.IsDirty)
		{
			_meshFilter.mesh = ((!_waterSolver.IsDirty) ? _waterMeshSimple.Mesh : _waterMesh.Mesh);
		}
		_prevIsDirty = _waterSolver.IsDirty;
	}

	private void UpdateComponents()
	{
		_meshFilter = base.gameObject.GetComponent<MeshFilter>();
		_meshRenderer = base.gameObject.GetComponent<MeshRenderer>();
	}

	private void UpdateProperties()
	{
		ClearMeshes();
		_meshFilter = base.gameObject.GetComponent<MeshFilter>();
		_nodeSize = Mathf.Max(Size.x, Size.y) / 6f;
		_grid.x = Mathf.RoundToInt(Size.x / _nodeSize) + 1;
		_grid.y = Mathf.RoundToInt(Size.y / _nodeSize) + 1;
		_waterMeshSimple = new DynamicWaterMesh(this);
		_resolution = Mathf.RoundToInt((float)(_quality * MaxResolution()) / 256f);
		_nodeSize = Mathf.Max(Size.x, Size.y) / (float)_resolution;
		_grid.x = Mathf.RoundToInt(Size.x / _nodeSize) + 1;
		_grid.y = Mathf.RoundToInt(Size.y / _nodeSize) + 1;
		if (_size.x == 0f || _size.y == 0f)
		{
			_grid = new Vector2Int(1, 1);
		}
		_nodeSizeNormalized.x = 1f / Size.x * (float)_grid.x;
		_nodeSizeNormalized.y = 1f / Size.y * (float)_grid.y;
		_waterMesh = new DynamicWaterMesh(this);
		_meshFilter.mesh = _waterMesh.Mesh;
		UpdateCollider();
		if (Application.isPlaying && UsePlaneCollider)
		{
			CreatePlaneCollider();
		}
		if (Application.isPlaying)
		{
			_waterSolver = null;
			DynamicWaterSolver[] components = GetComponents<DynamicWaterSolver>();
			DynamicWaterSolver[] array = components;
			foreach (DynamicWaterSolver dynamicWaterSolver in array)
			{
				if (_waterSolver == null)
				{
					_waterSolver = dynamicWaterSolver;
				}
				else
				{
					UnityEngine.Object.Destroy(dynamicWaterSolver);
				}
			}
			if (components.Length > 1)
			{
				Debug.LogWarning("More than one DynamicWaterSolver component present. Using the first one, others are destroyed", this);
			}
			if (_waterSolver != null)
			{
				_waterSolver.Initialize(this);
				if (_useObstructions)
				{
					RecalculateObstructions();
				}
			}
			else
			{
				Debug.LogError("No DynamicWaterSolver component attached!", this);
			}
		}
		_prevIsDirty = true;
	}

	private Vector2Int SizeToGridResolution(Vector2 size, int resolution)
	{
		float num = Mathf.Max(size.x, size.y) / (float)resolution;
		Vector2Int result = default(Vector2Int);
		result.x = Mathf.RoundToInt(size.x / num) + 1;
		result.y = Mathf.RoundToInt(size.y / num) + 1;
		return result;
	}

	private void ClearMeshes()
	{
		if (_meshFilter != null)
		{
			UnityEngine.Object.DestroyImmediate(_meshFilter.sharedMesh);
		}
		if (_waterMeshSimple != null)
		{
			_waterMeshSimple.FreeMesh();
			_waterMeshSimple = null;
		}
		if (_waterMesh != null)
		{
			_waterMesh.FreeMesh();
			_waterMesh = null;
		}
	}

	private void CreateSplashNormalized(Vector2 center, float radius, float force)
	{
		radius = ((!(_size.x < _size.y)) ? (radius / _size.y * (float)_grid.y) : (radius / _size.x * (float)_grid.x));
		_waterSolver.CreateSplashNormalized(center, radius, force);
	}

	private void CreateSplashLine(Vector2Int start, Vector2Int end, float radius, float force)
	{
		int num = Math.Abs(end.x - start.x);
		int num2 = Math.Abs(end.y - start.y);
		int num3 = ((start.x < end.x) ? 1 : (-1));
		int num4 = ((start.y < end.y) ? 1 : (-1));
		int num5 = num - num2;
		bool flag = false;
		Vector2 center = default(Vector2);
		while (start.x != end.x || start.y != end.y)
		{
			center.x = start.x;
			center.y = start.y;
			CreateSplashNormalized(center, radius, force);
			flag = true;
			int num6 = 2 * num5;
			if (num6 > -num2)
			{
				num5 -= num2;
				start.x += num3;
			}
			if (num6 < num)
			{
				num5 += num;
				start.y += num4;
			}
		}
		if (!flag)
		{
			CreateSplashNormalized(new Vector2(start.x, start.y), radius, force);
		}
	}
}
