using Core;
using Core.Unity;
using UnityEngine.AI;
using Wraper;

namespace UnityWrap
{
	public class NavMeshObstacleWrap : BaseObject
	{
		public static AssetObjectCache<int, NavMeshObstacleWrap> cache = new AssetObjectCache<int, NavMeshObstacleWrap>();

		private NavMeshObstacle com;

		public NavMeshObstacle component
		{
			get
			{
				return com;
			}
		}

		public NavMeshObstacleWrap()
		{
			lua_class_name = nav_mesh_obstacle_wraper.name;
		}

		public static NavMeshObstacleWrap CreateInstance(NavMeshObstacle com)
		{
			if (com == null)
			{
				Debug.LogWarning("[NavMeshObstacleWrap CreateInstance] error: nav mesh obstacle is null ");
				return null;
			}
			NavMeshObstacleWrap navMeshObstacleWrap = new NavMeshObstacleWrap();
			navMeshObstacleWrap.com = com;
			cache.Add(navMeshObstacleWrap.GetPid(), navMeshObstacleWrap);
			return navMeshObstacleWrap;
		}

		public static void DestroyInstance(NavMeshObstacleWrap obj)
		{
			if (obj != null)
			{
				cache.Remove(obj.GetPid());
				obj.com = null;
			}
		}
	}
}
