using ComponentEx;
using Core;
using Core.Unity;
using Wraper;

namespace UnityWrap
{
	public class CameraFollowWrap : BaseObject
	{
		public static AssetObjectCache<int, CameraFollowWrap> cache = new AssetObjectCache<int, CameraFollowWrap>();

		private CameraFollow com;

		public CameraFollow component
		{
			get
			{
				return com;
			}
		}

		public CameraFollowWrap()
		{
			lua_class_name = camera_follow_wraper.name;
		}

		public static CameraFollowWrap CreateInstance(CameraFollow com)
		{
			if (com == null)
			{
				Debug.LogWarning("[CameraFollowWrap CreateInstance] error: camera follow is null ");
				return null;
			}
			CameraFollowWrap cameraFollowWrap = new CameraFollowWrap();
			cameraFollowWrap.com = com;
			cache.Add(cameraFollowWrap.GetPid(), cameraFollowWrap);
			return cameraFollowWrap;
		}

		public static void DestroyInstance(CameraFollowWrap obj)
		{
			if (obj != null)
			{
				cache.Remove(obj.GetPid());
				obj.com = null;
			}
		}
	}
}
