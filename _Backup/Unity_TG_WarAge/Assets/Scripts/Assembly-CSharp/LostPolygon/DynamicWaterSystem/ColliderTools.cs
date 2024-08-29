using UnityEngine;

namespace LostPolygon.DynamicWaterSystem
{
	public static class ColliderTools
	{
		public static bool IsPointInsideCollider(Collider collider, Vector3 point)
		{
			RaycastHit hitInfo;
			if (collider is TerrainCollider)
			{
				if (!collider.Raycast(new Ray(point, Vector3.up), out hitInfo, collider.bounds.size.y))
				{
					return false;
				}
			}
			else if (collider is MeshCollider && !((MeshCollider)collider).convex)
			{
				if (!IsPointInsideMeshCollider(collider, point))
				{
					return false;
				}
			}
			else
			{
				Vector3 vector = collider.bounds.center - point;
				float magnitude = vector.magnitude;
				if (magnitude > 0.01f && collider.Raycast(new Ray(point, vector.normalized), out hitInfo, magnitude))
				{
					return false;
				}
			}
			return true;
		}

		public static bool IsPointInsideMeshCollider(Collider collider, Vector3 point)
		{
			Vector3[] array = new Vector3[6]
			{
				Vector3.up,
				Vector3.down,
				Vector3.left,
				Vector3.right,
				Vector3.forward,
				Vector3.back
			};
			Vector3[] array2 = array;
			foreach (Vector3 vector in array2)
			{
				RaycastHit hitInfo;
				if (!collider.Raycast(new Ray(point - vector * 1000f, vector), out hitInfo, 1000f))
				{
					return false;
				}
			}
			return true;
		}

		public static bool IsPointAtColliderEdge(Collider collider, Vector3 point, float tolerance)
		{
			tolerance *= 0.71f;
			Vector3 vector = collider.bounds.center - point;
			Vector3 normalized = vector.normalized;
			RaycastHit hitInfo;
			return vector != Vector3.zero && collider.Raycast(new Ray(point - normalized * tolerance, normalized), out hitInfo, tolerance);
		}
	}
}
