using LostPolygon.DynamicWaterSystem;
using UnityEngine;

[AddComponentMenu("Lost Polygon/Dynamic Water System/Wave Simulation Solver")]
public class DynamicWaterSolverSimulation : DynamicWaterSolver
{
	protected float[] FieldSim;

	protected float[] FieldSimNew;

	protected float[] FieldSimSpeed;

	protected float _simulationSpeedNormalizationFactor;

	private bool _switchField;

	public override void Initialize(IDynamicWaterSettings settings)
	{
		base.Initialize(settings);
		FieldSim = new float[_grid.x * _grid.y];
		FieldSimNew = new float[_grid.x * _grid.y];
		FieldSimSpeed = new float[_grid.x * _grid.y];
		base.Field = FieldSim;
	}

	public override void StepSimulation(float speed, float damping)
	{
		if (_isDirty && _isInitialized)
		{
			_simulationSpeedNormalizationFactor = (float)(_grid.x + _grid.y) / 128f;
			float timeDelta = Mathf.Clamp(Time.deltaTime * speed * _simulationSpeedNormalizationFactor, 0f, 1.412f);
			float maxValue;
			if (_switchField)
			{
				LinearWaveEqueationSolver.Solve(ref FieldSim, ref FieldSimNew, ref FieldSimSpeed, _fieldObstruction, _grid, timeDelta, damping, out maxValue);
				_field = FieldSimNew;
			}
			else
			{
				LinearWaveEqueationSolver.Solve(ref FieldSimNew, ref FieldSim, ref FieldSimSpeed, _fieldObstruction, _grid, timeDelta, damping, out maxValue);
				_field = FieldSim;
			}
			_switchField = !_switchField;
			_isDirty = maxValue > 0.001f;
		}
	}

	public override float GetWaterLevel(float x, float z)
	{
		if (x <= 0f || z <= 0f || x >= (float)_grid.x || z >= (float)_grid.y)
		{
			return float.NegativeInfinity;
		}
		return FieldSim[(int)z * _grid.x + (int)x];
	}

	public override void CreateSplashNormalized(Vector2 center, float radius, float force)
	{
		if (!_switchField)
		{
			CreateSplashNormalized(center, radius, force, ref FieldSimNew);
		}
		else
		{
			CreateSplashNormalized(center, radius, force, ref FieldSim);
		}
	}
}
