using UnityEngine;

namespace LostPolygon.DynamicWaterSystem
{
	public abstract class DynamicWaterSolver : MonoBehaviour, IDynamicWaterSolverFieldState
	{
		public const float DirtyThreshold = 0.001f;

		protected bool _isDirty;

		protected Vector2Int _grid;

		protected IDynamicWaterSettings _settings;

		protected bool _isInitialized;

		protected float[] _field;

		protected bool[] _fieldObstruction;

		public float[] Field
		{
			get
			{
				return _field;
			}
			set
			{
				_field = value;
			}
		}

		public bool[] FieldObstruction
		{
			get
			{
				return _fieldObstruction;
			}
			set
			{
				_fieldObstruction = value;
			}
		}

		public bool IsDirty
		{
			get
			{
				return _isDirty;
			}
			protected set
			{
				_isDirty = value;
			}
		}

		private void Awake()
		{
			if (GetComponent<DynamicWater>() == null)
			{
				Debug.LogError("DynamicWaterSolver attached to a GameObject without a DynamicWater component. Destroying the Solver");
				Object.Destroy(this);
			}
		}

		public virtual void Initialize(IDynamicWaterSettings settings)
		{
			_isInitialized = true;
			_settings = settings;
			_grid = _settings.GridSize;
		}

		public abstract void CreateSplashNormalized(Vector2 center, float radius, float force);

		public abstract float GetWaterLevel(float x, float z);

		public abstract void StepSimulation(float speed, float damping);

		protected void CreateSplashNormalized(Vector2 center, float radius, float force, ref float[] field)
		{
			if (!_isInitialized)
			{
				return;
			}
			bool flag = _fieldObstruction == null;
			float num = 1f / (radius * radius);
			if (radius > 1f)
			{
				int num2 = Mathf.Clamp(Mathf.RoundToInt(center.x - radius), 1, _grid.x - 1);
				int num3 = Mathf.Clamp(Mathf.RoundToInt(center.x + radius), 1, _grid.x - 1);
				int num4 = Mathf.Clamp(Mathf.RoundToInt(center.y - radius), 1, _grid.y - 1);
				int num5 = Mathf.Clamp(Mathf.RoundToInt(center.y + radius), 1, _grid.y - 1);
				for (int i = num4; i < num5; i++)
				{
					for (int j = num2; j < num3; j++)
					{
						int num6 = i * _grid.x + j;
						if (flag || !_fieldObstruction[num6])
						{
							float num7 = 1f - ((center.x - (float)j) * (center.x - (float)j) + (center.y - (float)i) * (center.y - (float)i)) * num;
							if (!(num7 < 0.02f))
							{
								num7 *= num7;
								num7 = num7 * num7 * (1f / 24f) - num7 * 0.5f;
								field[num6] += num7 * force;
							}
						}
					}
				}
			}
			else
			{
				field[Mathf.Clamp((int)center.y, 1, _grid.y - 2) * _grid.x + Mathf.Clamp((int)center.x, 1, _grid.x - 2)] += 0f - force;
			}
			_isDirty = true;
		}
	}
}
