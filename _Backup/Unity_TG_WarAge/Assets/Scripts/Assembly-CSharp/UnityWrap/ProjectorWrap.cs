using Core;
using Core.Unity;
using UnityEngine;
using Wraper;

namespace UnityWrap
{
	public class ProjectorWrap : BaseObject
	{
		public static AssetObjectCache<int, ProjectorWrap> cache = new AssetObjectCache<int, ProjectorWrap>();

		private Projector com;

		public Projector component
		{
			get
			{
				return com;
			}
		}

		public ProjectorWrap()
		{
			lua_class_name = projector_wraper.name;
		}

		public static ProjectorWrap CreateInstance(Projector com)
		{
			if (com == null)
			{
				Core.Unity.Debug.LogWarning("[ProjectorWrap CreateInstance] error: projector is null ");
				return null;
			}
			ProjectorWrap projectorWrap = new ProjectorWrap();
			projectorWrap.com = com;
			cache.Add(projectorWrap.GetPid(), projectorWrap);
			return projectorWrap;
		}

		public static void DestroyInstance(ProjectorWrap obj)
		{
			if (obj != null)
			{
				cache.Remove(obj.GetPid());
				obj.com = null;
			}
		}
	}
}
