using Core;
using Core.Unity;
using Wraper;

namespace UnityWrap
{
	public class MotionBlurEffectsWrap : BaseObject
	{
		public static AssetObjectCache<int, MotionBlurEffectsWrap> cache = new AssetObjectCache<int, MotionBlurEffectsWrap>();

		private MotionBlurEffects com;

		public MotionBlurEffects component
		{
			get
			{
				return com;
			}
		}

		public MotionBlurEffectsWrap()
		{
			lua_class_name = motion_blur_effects_wraper.name;
		}

		public static MotionBlurEffectsWrap CreateInstance(MotionBlurEffects com)
		{
			if (com == null)
			{
				Debug.LogWarning("[MotionBlurEffectsWrap CreateInstance] error: MotionBlurEffects is null ");
				return null;
			}
			MotionBlurEffectsWrap motionBlurEffectsWrap = new MotionBlurEffectsWrap();
			motionBlurEffectsWrap.com = com;
			cache.Add(motionBlurEffectsWrap.GetPid(), motionBlurEffectsWrap);
			return motionBlurEffectsWrap;
		}

		public static void DestroyInstance(MotionBlurEffectsWrap obj)
		{
			if (obj != null)
			{
				cache.Remove(obj.GetPid());
				obj.com = null;
			}
		}
	}
}
