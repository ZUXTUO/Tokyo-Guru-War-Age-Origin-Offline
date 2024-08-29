using LostPolygon.DynamicWaterSystem;
using UnityEngine;

[AddComponentMenu("Lost Polygon/Dynamic Water System/Fluid Volume")]
[ExecuteInEditMode]
[RequireComponent(typeof(BoxCollider))]
public class FluidVolume : MonoBehaviour, IDynamicWaterFluidVolumeSettings, IDynamicWaterFieldState
{
	public const string DynamicWaterTagName = "DynamicWater";

	[SerializeField]
	protected Vector2 _size = new Vector2(10f, 10f);

	[SerializeField]
	protected float _density = 1000f;

	[SerializeField]
	protected float _depth = 10f;

	protected Transform _transform;

	protected BoxCollider _collider;

	public virtual Vector2 Size
	{
		get
		{
			return _size;
		}
		set
		{
			if (_size != value)
			{
				_size.x = Mathf.Clamp(value.x, 0f, float.PositiveInfinity);
				_size.y = Mathf.Clamp(value.y, 0f, float.PositiveInfinity);
				PropertyChanged();
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
			_density = Mathf.Clamp(value, 0f, 10000f);
		}
	}

	public virtual float Depth
	{
		get
		{
			return _depth;
		}
		set
		{
			_depth = Mathf.Clamp(value, 0f, 10000f);
			CreateCollider();
			UpdateCollider();
		}
	}

	public virtual BoxCollider Collider
	{
		get
		{
			return base.gameObject.GetComponent<BoxCollider>();
		}
	}

	public virtual float GetWaterLevel(float x, float z)
	{
		return float.PositiveInfinity;
	}

	public virtual void CreateSplash(Vector3 center, float radius, float force)
	{
	}

	protected virtual void Initialize()
	{
		_transform = base.gameObject.GetComponent<Transform>();
		base.tag = "DynamicWater";
		CreateCollider();
		UpdateCollider();
	}

	protected virtual void UpdateCollider()
	{
		Vector2 vector = new Vector2(_size.x * base.transform.lossyScale.x, _size.y * base.transform.lossyScale.y);
		_collider.center = new Vector3(vector.x / 2f, _depth / 2f, vector.y / 2f);
		_collider.size = new Vector3(vector.x, _depth, vector.y);
	}

	protected void CreateCollider()
	{
		_collider = base.gameObject.GetComponent<BoxCollider>();
		if (_collider == null)
		{
			_collider = base.gameObject.AddComponent<BoxCollider>();
		}
		_collider.isTrigger = true;
		UpdateCollider();
	}

	protected virtual void PropertyChanged()
	{
		UpdateCollider();
	}

	private void Start()
	{
		Initialize();
	}

	private void OnDrawGizmos()
	{
		if (Application.isEditor)
		{
			Gizmos.DrawIcon(new Vector3(GetComponent<Collider>().bounds.center.x, base.transform.position.y + 0.1f, GetComponent<Collider>().bounds.center.z), "DynamicWater/FluidVolume.png");
			Gizmos.color = new Color(0f, 0f, 1f, 0.1f);
			if (_collider != null)
			{
				Gizmos.DrawCube(GetComponent<Collider>().bounds.center, GetComponent<Collider>().bounds.size);
			}
		}
	}
}
