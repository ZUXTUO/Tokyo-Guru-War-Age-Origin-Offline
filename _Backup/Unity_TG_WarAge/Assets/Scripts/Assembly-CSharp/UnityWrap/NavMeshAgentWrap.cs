using Core;
using Core.Unity;
using UnityEngine.AI;
using Wraper;

namespace UnityWrap
{
	public class NavMeshAgentWrap : BaseObject
	{
		public static AssetObjectCache<int, NavMeshAgentWrap> cache = new AssetObjectCache<int, NavMeshAgentWrap>();

		private NavMeshAgent com;

		public NavMeshAgent component
		{
			get
			{
				return com;
			}
		}

		public NavMeshAgentWrap()
		{
			lua_class_name = nav_mesh_agent_wraper.name;
		}

		public static NavMeshAgentWrap CreateInstance(NavMeshAgent com)
		{
			if (com == null)
			{
				Debug.LogWarning("[NavMeshAgentWrap CreateInstance] error: nav mesh agent is null ");
				return null;
			}
			NavMeshAgentWrap navMeshAgentWrap = new NavMeshAgentWrap();
			navMeshAgentWrap.com = com;
			cache.Add(navMeshAgentWrap.GetPid(), navMeshAgentWrap);
			return navMeshAgentWrap;
		}

		public static void DestroyInstance(NavMeshAgentWrap obj)
		{
			if (obj != null)
			{
				cache.Remove(obj.GetPid());
				obj.com = null;
			}
		}
	}
}
