using Core;
using Wraper;

namespace UnityWrap
{
	public class HudTextWrap : BaseObject
	{
		public static AssetObjectCache<int, HudTextWrap> cache = new AssetObjectCache<int, HudTextWrap>();

		private HUDText mHudText;

		private UIFollowTarget mUIFollowTarget;

		public HUDText HudText
		{
			get
			{
				return mHudText;
			}
		}

		public UIFollowTarget UIFollowTarget
		{
			get
			{
				return mUIFollowTarget;
			}
		}

		public HudTextWrap()
		{
			lua_class_name = hud_text_wraper.name;
		}

		public HudTextWrap InitInstance(HUDText compnnent, UIFollowTarget uft)
		{
			mHudText = compnnent;
			mUIFollowTarget = uft;
			cache.Add(GetPid(), this);
			return this;
		}

		public void DestroyInstance()
		{
			if (mHudText != null)
			{
				cache.Remove(GetPid());
				mHudText = null;
			}
		}
	}
}
