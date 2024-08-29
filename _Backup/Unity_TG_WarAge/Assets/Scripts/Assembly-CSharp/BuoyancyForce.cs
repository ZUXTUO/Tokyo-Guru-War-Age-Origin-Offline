using System;
using System.Collections.Generic;
using LostPolygon.DynamicWaterSystem;
using UnityEngine;

[AddComponentMenu("Lost Polygon/Dynamic Water System/Buoyancy Force")]
[RequireComponent(typeof(Rigidbody))]
public class BuoyancyForce : MonoBehaviour
{
	private struct BuoyancyVoxel
	{
		public Vector3 Position;

		public bool HadPassedWater;

		public bool IsOnColliderEdge;
	}

	[SerializeField]
	private int _resolution = 2;

	[SerializeField]
	private float _density = 750f;

	[SerializeField]
	private float _dragInFluid = 1f;

	[SerializeField]
	private float _angularDragInFluid = 1f;

	[SerializeField]
	private float _splashForceFactor = 2.5f;

	[SerializeField]
	private float _maxSplashForce = 2f;

	[SerializeField]
	private bool _useDensity = true;

	[SerializeField]
	private bool _processChildren;

	[SerializeField]
	private bool _setMassByDensity;

	private Transform _transform;

	private Collider[] _colliders;

	private Rigidbody _rigidbody;

	private float _voxelSize;

	private BuoyancyVoxel[] _buoyancyVoxels;

	private Bounds _bounds;

	private Vector3Int _voxelResolution;

	private Vector3 _voxelArchimedesForce;

	private IDynamicWaterFluidVolumeSettings _water;

	private float _archimedesForceFactor;

	private float _volume;

	private float _dragNonFluid;

	private float _angularDragNonFluid;

	private float _subMergedVolume;

	private float _subMergedVolumePrev;

	private bool _isReady;

	public int Resolution
	{
		get
		{
			return _resolution;
		}
		set
		{
			int num = Mathf.Clamp(value, 1, 15);
			if (_resolution != num)
			{
				_resolution = num;
				if (Application.isPlaying)
				{
					Recalculate();
				}
			}
		}
	}

	public float Density
	{
		get
		{
			return _density;
		}
		set
		{
			_density = Mathf.Clamp(value, 0.1f, float.PositiveInfinity);
			if (_setMassByDensity && _volume > 0.01f)
			{
				GetComponent<Rigidbody>().mass = _volume * _density;
			}
		}
	}

	public float DragInFluid
	{
		get
		{
			return _dragInFluid;
		}
		set
		{
			_dragInFluid = Mathf.Clamp(value, 0f, float.PositiveInfinity);
		}
	}

	public float AngularDragInFluid
	{
		get
		{
			return _angularDragInFluid;
		}
		set
		{
			_angularDragInFluid = Mathf.Clamp(value, 0f, float.PositiveInfinity);
		}
	}

	public float SplashForceFactor
	{
		get
		{
			return _splashForceFactor;
		}
		set
		{
			_splashForceFactor = Mathf.Clamp(value, 0f, 200f);
		}
	}

	public float MaxSplashForce
	{
		get
		{
			return _maxSplashForce;
		}
		set
		{
			_maxSplashForce = Mathf.Clamp(value, 0f, 200f);
		}
	}

	public bool ProcessChildren
	{
		get
		{
			return _processChildren;
		}
		set
		{
			_processChildren = value;
		}
	}

	public bool UseDensity
	{
		get
		{
			return _useDensity;
		}
		set
		{
			_useDensity = value;
		}
	}

	public bool SetMassByDensity
	{
		get
		{
			return _setMassByDensity;
		}
		set
		{
			_setMassByDensity = value;
		}
	}

	public float SubmergedVolume
	{
		get
		{
			return _subMergedVolume;
		}
	}

	private void Start()
	{
		_isReady = false;
		_transform = GetComponent<Transform>();
		_rigidbody = GetComponent<Rigidbody>();
		Recalculate();
	}

	private void Recalculate()
	{
		_isReady = false;
		if (_processChildren)
		{
			_colliders = GetComponentsInChildren<Collider>();
		}
		else
		{
			_colliders = ((!(GetComponent<Collider>() != null)) ? new Collider[0] : new Collider[1] { GetComponent<Collider>() });
		}
		if (_colliders.Length == 0)
		{
			Debug.LogError((!_processChildren) ? "No colliders are attached to the object, buoyancy disabled. Enabled \"Process children\" if you have colliders attached to the children" : "No colliders are attached to the object and to the children, buoyancy disabled", this);
			UnityEngine.Object.Destroy(this);
			return;
		}
		_angularDragNonFluid = _rigidbody.angularDrag;
		_dragNonFluid = _rigidbody.drag;
		Quaternion rotation = _transform.rotation;
		Vector3 position = _transform.position;
		_transform.rotation = Quaternion.identity;
		_transform.position = Vector3.zero;
		Collider[] colliders = _colliders;
		foreach (Collider collider in colliders)
		{
			_bounds.Encapsulate(collider.bounds);
		}
		if (Math.Abs(_bounds.extents.magnitude) < 0.001f)
		{
			Debug.LogError("Collider bounds are zero-sized, buoyancy disabled", this);
			UnityEngine.Object.Destroy(this);
			return;
		}
		_voxelSize = _bounds.size.magnitude / (float)_resolution / 2f;
		_voxelResolution.x = Mathf.RoundToInt(_bounds.size.x / _voxelSize) + 1;
		_voxelResolution.y = Mathf.RoundToInt(_bounds.size.y / _voxelSize) + 1;
		_voxelResolution.z = Mathf.RoundToInt(_bounds.size.z / _voxelSize) + 1;
		_buoyancyVoxels = SliceIntoVoxels().ToArray();
		if (_buoyancyVoxels.Length == 0)
		{
			Debug.LogWarning("No buoyancy voxels were generated. Try to increase the Resolution parameter", this);
		}
		_transform.rotation = rotation;
		_transform.position = position;
		_voxelSize = Mathf.Pow(_bounds.size.x * _bounds.size.y * _bounds.size.z / (float)(_voxelResolution.x * _voxelResolution.y * _voxelResolution.z), 1f / 3f);
		_volume = (float)_buoyancyVoxels.Length * _voxelSize * _voxelSize * _voxelSize;
		if (_setMassByDensity)
		{
			GetComponent<Rigidbody>().mass = _volume * _density;
		}
		_isReady = true;
	}

	private List<BuoyancyVoxel> SliceIntoVoxels()
	{
		List<BuoyancyVoxel> list = new List<BuoyancyVoxel>(_voxelResolution.x * _voxelResolution.y * _voxelResolution.z);
		BuoyancyVoxel item = default(BuoyancyVoxel);
		for (int i = 0; i < _voxelResolution.x; i++)
		{
			for (int j = 0; j < _voxelResolution.y; j++)
			{
				for (int k = 0; k < _voxelResolution.z; k++)
				{
					float x = _bounds.min.x + _bounds.size.x / (float)_voxelResolution.x * (0.5f + (float)i);
					float y = _bounds.min.y + _bounds.size.y / (float)_voxelResolution.y * (0.5f + (float)j);
					float z = _bounds.min.z + _bounds.size.z / (float)_voxelResolution.z * (0.5f + (float)k);
					Vector3 vector = new Vector3(x, y, z);
					for (int l = 0; l < _colliders.Length; l++)
					{
						if (ColliderTools.IsPointInsideCollider(_colliders[l], vector))
						{
							item.Position = _transform.InverseTransformPoint(vector);
							item.IsOnColliderEdge = ColliderTools.IsPointAtColliderEdge(_colliders[l], vector, _voxelSize);
							item.HadPassedWater = true;
							list.Add(item);
							break;
						}
					}
				}
			}
		}
		return list;
	}

	private void OnTriggerEnter(Collider otherCollider)
	{
		if (_isReady && otherCollider.CompareTag("DynamicWater"))
		{
			IDynamicWaterFluidVolumeSettings dynamicWaterFluidVolumeSettings = otherCollider.gameObject.GetComponent<FluidVolume>() ?? otherCollider.gameObject.GetComponent<DynamicWater>();
			if (dynamicWaterFluidVolumeSettings != null)
			{
				_water = dynamicWaterFluidVolumeSettings;
			}
		}
	}

	private void OnTriggerExit(Collider otherCollider)
	{
		if (_isReady && _water != null && otherCollider.CompareTag("DynamicWater") && otherCollider == _water.Collider)
		{
			_water = null;
		}
	}

	private void FixedUpdate()
	{
		if (_water == null || _density < 0.01f || !_isReady)
		{
			_rigidbody.drag = _dragNonFluid;
			_rigidbody.angularDrag = _angularDragNonFluid;
			return;
		}
		if (_useDensity)
		{
			_archimedesForceFactor = 1f / _density;
		}
		else
		{
			_archimedesForceFactor = _volume / _rigidbody.mass;
		}
		float num = (0f - Physics.gravity.y) * _archimedesForceFactor;
		float num2 = _water.Density * _water.Density * _rigidbody.mass / _water.Density * Time.deltaTime;
		_voxelArchimedesForce = Vector3.up * (num * num2 / (float)_buoyancyVoxels.Length);
		float num3 = _splashForceFactor / 100f;
		float num4 = _maxSplashForce / 100f;
		int num5 = _buoyancyVoxels.Length;
		for (int i = 0; i < num5; i++)
		{
			Vector3 position = _buoyancyVoxels[i].Position;
			Vector3 vector = _transform.TransformPoint(position);
			float waterLevel = _water.GetWaterLevel(vector.x, vector.z);
			if (waterLevel == float.NegativeInfinity || !(vector.y - _voxelSize / 1f < waterLevel))
			{
				continue;
			}
			Vector3 pointVelocity = _rigidbody.GetPointVelocity(vector);
			float num6 = (waterLevel - vector.y) / (2f * _voxelSize) + 0.5f;
			if (_buoyancyVoxels[i].IsOnColliderEdge)
			{
				if (!_buoyancyVoxels[i].HadPassedWater && num6 < 1f && num6 > 0f)
				{
					float num7 = FastFunctions.FastVector3Magnitude(pointVelocity) * num3;
					if (num7 > num4)
					{
						num7 = num4;
					}
					if (num7 > 0.0075f)
					{
						_water.CreateSplash(vector, _voxelSize, num7);
					}
					_buoyancyVoxels[i].HadPassedWater = true;
				}
				else
				{
					_buoyancyVoxels[i].HadPassedWater = false;
				}
			}
			if (num6 > 1f)
			{
				num6 = 1f;
			}
			else if (num6 < 0f)
			{
				num6 = 0f;
			}
			_subMergedVolume += num6;
			Vector3 force = num6 * _voxelArchimedesForce;
			_rigidbody.AddForceAtPosition(force, vector, ForceMode.Impulse);
		}
		_subMergedVolume /= num5;
		if (_subMergedVolumePrev < 0.01f && _subMergedVolume >= 0.01f)
		{
			SendMessage("OnFluidVolumeEnter", _water, SendMessageOptions.DontRequireReceiver);
		}
		else if (_subMergedVolumePrev >= 0.01f && _subMergedVolume < 0.01f)
		{
			SendMessage("OnFluidVolumeExit", _water, SendMessageOptions.DontRequireReceiver);
		}
		_subMergedVolumePrev = _subMergedVolume;
		_rigidbody.drag = Mathf.Lerp(_rigidbody.drag, (!(_subMergedVolume > 0.0001f)) ? _dragNonFluid : (_dragNonFluid + _dragInFluid), 15f * Time.deltaTime);
		_rigidbody.angularDrag = Mathf.Lerp(_rigidbody.angularDrag, (!(_subMergedVolume > 0.0001f)) ? _angularDragNonFluid : (_angularDragNonFluid + _angularDragInFluid), 15f * Time.deltaTime);
	}

	private void OnDrawGizmos()
	{
		Gizmos.DrawIcon(base.transform.position, "DynamicWater/BuoyancyForce.png");
		if (Application.isEditor && _buoyancyVoxels != null)
		{
			Vector3 size = Vector3.one * _voxelSize;
			Gizmos.color = new Color(Color.yellow.r, Color.yellow.g, Color.yellow.b, 0.5f);
			BuoyancyVoxel[] buoyancyVoxels = _buoyancyVoxels;
			for (int i = 0; i < buoyancyVoxels.Length; i++)
			{
				BuoyancyVoxel buoyancyVoxel = buoyancyVoxels[i];
				Gizmos.DrawCube(base.transform.TransformPoint(buoyancyVoxel.Position), size);
			}
			Gizmos.color = Color.red;
			Gizmos.DrawSphere(GetComponent<Rigidbody>().worldCenterOfMass, _voxelSize / 2f);
		}
	}
}
