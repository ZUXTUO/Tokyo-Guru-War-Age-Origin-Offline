using System;
using LostPolygon.DynamicWaterSystem;
using UnityEngine;

[AddComponentMenu("Lost Polygon/Dynamic Water System/Simple Ambient Wave Solver")]
public class DynamicWaterSolverAmbientSimple : DynamicWaterSolverSimulation
{
	public float AmbientWaveHeight = 0.3f;

	public float AmbientWaveFrequency = 1f;

	public float AmbientWaveSpeed = 1f;

	public bool OnlyAmbient = true;

	private float[] _fieldSum;

	private float _time;

	public override void Initialize(IDynamicWaterSettings settings)
	{
		base.Initialize(settings);
		_fieldSum = new float[_grid.x * _grid.y];
	}

	public override void StepSimulation(float speed, float damping)
	{
		if (!OnlyAmbient)
		{
			base.StepSimulation(speed, damping);
		}
		_time += Time.deltaTime * AmbientWaveSpeed;
		Vector2 vector = new Vector2(1f / (float)_grid.x, 1f / (float)_grid.y);
		for (int i = 0; i < _grid.x; i++)
		{
			for (int j = 0; j < _grid.y; j++)
			{
				int num = j * _grid.x + i;
				float num2 = (float)i * vector.x;
				float num3 = (float)j * vector.y;
				float num4 = (num2 + num3) * ((float)Math.PI * 2f);
				if (OnlyAmbient)
				{
					_fieldSum[num] = FastFunctions.FastSin(num4 * AmbientWaveFrequency + _time) * AmbientWaveHeight;
				}
				else
				{
					_fieldSum[num] = FastFunctions.FastSin(num4 * AmbientWaveFrequency + _time) * AmbientWaveHeight + FieldSimNew[num];
				}
			}
		}
		_field = _fieldSum;
		_isDirty = true;
	}

	public override void CreateSplashNormalized(Vector2 center, float radius, float force)
	{
		if (!OnlyAmbient)
		{
			CreateSplashNormalized(center, radius, force, ref FieldSim);
		}
	}

	public override float GetWaterLevel(float x, float z)
	{
		if (x <= 0f || z <= 0f || x >= (float)_grid.x || z >= (float)_grid.y)
		{
			return float.NegativeInfinity;
		}
		return _fieldSum[(int)z * _grid.x + (int)x];
	}
}
