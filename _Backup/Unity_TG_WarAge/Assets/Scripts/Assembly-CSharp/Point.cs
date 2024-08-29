using UnityEngine;

internal class Point
{
	public static float distance(Vector3 pointFrom, Vector3 pointTo)
	{
		return Mathf.Sqrt((pointFrom.x - pointTo.x) * (pointFrom.x - pointTo.x) + (pointFrom.y - pointTo.y) * (pointFrom.y - pointTo.y) + (pointFrom.z - pointTo.z) * (pointFrom.z - pointTo.z));
	}

	public static Vector3 interpolate(Vector3 pointA, Vector3 pointB, float rate = 0.5f)
	{
		return new Vector3(pointA.x + rate * (pointB.x - pointA.x), pointA.y + rate * (pointB.y - pointA.y), pointA.z + rate * (pointB.z - pointA.z));
	}

	public static Vector3 add(Vector3 pointA, Vector3 pointB)
	{
		return new Vector3(pointA.x + pointB.x, pointA.y + pointB.y, pointA.z + pointB.z);
	}

	public static Vector3 dec(Vector3 pointA, Vector3 pointB)
	{
		return new Vector3(pointA.x - pointB.x, pointA.y - pointB.y, pointA.z - pointB.z);
	}
}
