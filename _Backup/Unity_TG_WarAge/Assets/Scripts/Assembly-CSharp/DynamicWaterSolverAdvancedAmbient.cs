using System;
using LostPolygon.DynamicWaterSystem;
using UnityEngine;

[AddComponentMenu("Lost Polygon/Dynamic Water System/Advanced Ambient Wave Solver")]
public class DynamicWaterSolverAdvancedAmbient : DynamicWaterSolverSimulation
{
	[Serializable]
	public class Wave
	{
		public float Amplitude;

		public float Angle;

		public float Frequency;

		public float Velocity;

		public int Steepness;

		public bool Excluded;

		[HideInInspector]
		public Vector2 Direction;
	}

	public Wave[] Waves;

	public bool OnlyAmbient = true;

	private float[] _fieldSum;

	private float _time;

	public override void Initialize(IDynamicWaterSettings settings)
	{
		base.Initialize(settings);
		_fieldSum = new float[_grid.x * _grid.y];
		_field = _fieldSum;
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

	public override void StepSimulation(float speed, float damping)
	{
		if (!OnlyAmbient)
		{
			base.StepSimulation(speed, damping);
		}
		_time += Time.deltaTime;
		Wave[] waves = Waves;
		foreach (Wave wave in waves)
		{
			wave.Direction = new Vector2(Mathf.Cos(wave.Angle * ((float)Math.PI / 180f)), Mathf.Sin(wave.Angle * ((float)Math.PI / 180f)));
		}
		Vector2 vector = new Vector2(1f / (float)_grid.x, 1f / (float)_grid.y);
		for (int j = 0; j < _grid.x; j++)
		{
			for (int k = 0; k < _grid.y; k++)
			{
				int num = k * _grid.x + j;
				float num2 = (float)j * vector.x * ((float)Math.PI * 2f);
				float num3 = (float)k * vector.y * ((float)Math.PI * 2f);
				_fieldSum[num] = 0f;
				Wave[] waves2 = Waves;
				foreach (Wave wave2 in waves2)
				{
					if (!wave2.Excluded)
					{
						float x = (wave2.Direction.x * num2 + wave2.Direction.y * num3) * wave2.Frequency + _time * wave2.Velocity;
						_fieldSum[num] += FastFunctions.FastPow((FastFunctions.FastSin(x) + 1f) * 0.5f, wave2.Steepness) * wave2.Amplitude;
					}
				}
				if (!OnlyAmbient)
				{
					_fieldSum[num] += FieldSimNew[num];
				}
			}
		}
		_field = _fieldSum;
		_isDirty = true;
	}
}
