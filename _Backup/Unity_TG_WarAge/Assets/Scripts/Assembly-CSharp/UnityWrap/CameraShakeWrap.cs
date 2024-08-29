using Core;
using Core.Unity;
using Wraper;

namespace UnityWrap
{
	public class CameraShakeWrap : BaseObject
	{
		public static AssetObjectCache<int, CameraShakeWrap> cache = new AssetObjectCache<int, CameraShakeWrap>();

		private CameraShake com;

		public CameraShake component
		{
			get
			{
				return com;
			}
		}

		public CameraShakeWrap()
		{
			lua_class_name = camera_shake_wraper.name;
		}

		public static CameraShakeWrap CreateInstance(CameraShake com)
		{
			if (com == null)
			{
				Debug.LogWarning("[CameraShakeWrap CreateInstance] error: camera shake is null ");
				return null;
			}
			CameraShakeWrap cameraShakeWrap = new CameraShakeWrap();
			cameraShakeWrap.com = com;
			cache.Add(cameraShakeWrap.GetPid(), cameraShakeWrap);
			return cameraShakeWrap;
		}

		public static void DestroyInstance(CameraShakeWrap obj)
		{
			if (obj != null)
			{
				cache.Remove(obj.GetPid());
				obj.com = null;
			}
		}
	}
}
