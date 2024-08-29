using ComponentEx;
using Core;
using Wraper;

namespace UnityWrap
{
	public class FlashLightingWrap : BaseObject
	{
		public static AssetObjectCache<int, FlashLightingWrap> cache = new AssetObjectCache<int, FlashLightingWrap>();

		private FlashLighting com;

		public FlashLighting component
		{
			get
			{
				return com;
			}
		}

		public FlashLightingWrap()
		{
			lua_class_name = flash_lighting_wraper.name;
		}

		public static FlashLightingWrap CreateInstance(FlashLighting com)
		{
			FlashLightingWrap flashLightingWrap = new FlashLightingWrap();
			flashLightingWrap.com = com;
			cache.Add(flashLightingWrap.GetPid(), flashLightingWrap);
			return flashLightingWrap;
		}

		public static void DestroyInstance(FlashLightingWrap obj)
		{
			if (obj != null)
			{
				cache.Remove(obj.GetPid());
				obj.com = null;
			}
		}
	}
}
