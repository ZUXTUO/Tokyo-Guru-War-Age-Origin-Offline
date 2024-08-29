using System;
using System.Runtime.InteropServices;
using UnityEngine;

namespace LostPolygon.DynamicWaterSystem
{
	public static class FastFunctions
	{
		[StructLayout(2)]
		public struct FloatIntUnion
		{
			[FieldOffset(0)]
			public float f;

			[FieldOffset(0)]
			public int i;
		}

		public const float DoublePi = (float)Math.PI * 2f;

		public const float InvDoublePi = 1f / (2f * (float)Math.PI);

		public const float Deg2Rad = (float)Math.PI / 180f;

		public static float FastSin(float x)
		{
			x -= (float)Math.PI * 2f * Mathf.Floor((x + (float)Math.PI) * (1f / (2f * (float)Math.PI)));
			x = ((!(x < 0f)) ? (4f / (float)Math.PI * x - 0.40528473f * x * x) : (4f / (float)Math.PI * x + 0.40528473f * x * x));
			return x;
		}

		public static float FastInvSqrt(float x)
		{
			FloatIntUnion floatIntUnion = default(FloatIntUnion);
			floatIntUnion.i = 0;
			floatIntUnion.f = x;
			float num = 0.5f * x;
			floatIntUnion.i = 1597463174 - (floatIntUnion.i >> 1);
			floatIntUnion.f *= 1.5f - num * floatIntUnion.f * floatIntUnion.f;
			return floatIntUnion.f;
		}

		public static float FastSqrt(float x)
		{
			FloatIntUnion floatIntUnion = default(FloatIntUnion);
			floatIntUnion.i = 0;
			floatIntUnion.f = x;
			float num = 0.5f * x;
			floatIntUnion.i = 1597463174 - (floatIntUnion.i >> 1);
			floatIntUnion.f *= 1.5f - num * floatIntUnion.f * floatIntUnion.f;
			return floatIntUnion.f * x;
		}

		public static float FastLog2(float x)
		{
			FloatIntUnion floatIntUnion = default(FloatIntUnion);
			floatIntUnion.i = 0;
			floatIntUnion.f = x;
			float num = floatIntUnion.i;
			num *= 1.1920929E-07f;
			return num - 126.942696f;
		}

		public static float FastPow2(float x)
		{
			float num = ((!(x < -126f)) ? x : (-126f));
			FloatIntUnion floatIntUnion = default(FloatIntUnion);
			floatIntUnion.f = 0f;
			floatIntUnion.i = (int)(8388608f * (num + 126.942696f));
			return floatIntUnion.f;
		}

		public static float FastPow(float a, float b)
		{
			FloatIntUnion floatIntUnion = default(FloatIntUnion);
			floatIntUnion.i = 0;
			floatIntUnion.f = a;
			float num = floatIntUnion.i;
			num *= 1.1920929E-07f;
			floatIntUnion.f = b * (num - 126.942696f);
			float num2 = ((!(floatIntUnion.f < -126f)) ? floatIntUnion.f : (-126f));
			floatIntUnion.i = (int)(8388608f * (num2 + 126.942696f));
			return floatIntUnion.f;
		}

		public static float FastVector3Magnitude(Vector3 vector)
		{
			float num = vector.x * vector.x + vector.y * vector.y + vector.z * vector.z;
			FloatIntUnion floatIntUnion = default(FloatIntUnion);
			floatIntUnion.i = 0;
			floatIntUnion.f = num;
			float num2 = 0.5f * num;
			floatIntUnion.i = 1597463174 - (floatIntUnion.i >> 1);
			floatIntUnion.f *= 1.5f - num2 * floatIntUnion.f * floatIntUnion.f;
			return floatIntUnion.f * num;
		}

		public static bool FastIsNaN(float x)
		{
			FloatIntUnion floatIntUnion = default(FloatIntUnion);
			floatIntUnion.i = 0;
			floatIntUnion.f = x;
			return (floatIntUnion.i & 0x7F800000) == 2139095040 && (floatIntUnion.i & 0x7FFFFF) != 0;
		}
	}
}
