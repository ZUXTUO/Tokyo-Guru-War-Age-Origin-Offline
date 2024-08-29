using Core;
using Core.Unity;
using UnityEngine;
using Wraper;

namespace UnityWrap
{
	public class CameraWrap : BaseObject
	{
		public static AssetObjectCache<int, CameraWrap> cache = new AssetObjectCache<int, CameraWrap>();

		private Camera com;

		public Camera component
		{
			get
			{
				return com;
			}
		}

		public CameraWrap()
		{
			lua_class_name = camera_wraper.name;
		}

		public static CameraWrap CreateInstance(Camera com)
		{
			if (com == null)
			{
				Core.Unity.Debug.LogWarning("[CameraWrap CreateInstance] error: camera is null ");
				return null;
			}
			CameraWrap cameraWrap = new CameraWrap();
			cameraWrap.com = com;
			cache.Add(cameraWrap.GetPid(), cameraWrap);
			return cameraWrap;
		}

		public static void DestroyInstance(CameraWrap obj)
		{
			if (obj != null)
			{
				cache.Remove(obj.GetPid());
				obj.com = null;
			}
		}
	}
}
