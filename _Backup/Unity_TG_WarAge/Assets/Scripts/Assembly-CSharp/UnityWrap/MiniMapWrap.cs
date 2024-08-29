using Core;
using Wraper;

namespace UnityWrap
{
	public class MiniMapWrap : BaseObject
	{
		public static AssetObjectCache<int, MiniMapWrap> cache = new AssetObjectCache<int, MiniMapWrap>();

		private MiniMap com;

		public MiniMap component
		{
			get
			{
				return com;
			}
		}

		public MiniMapWrap()
		{
			lua_class_name = mini_map_wraper.name;
		}

		public static MiniMapWrap CreateInstance(MiniMap com)
		{
			MiniMapWrap miniMapWrap = new MiniMapWrap();
			miniMapWrap.com = com;
			cache.Add(miniMapWrap.GetPid(), miniMapWrap);
			return miniMapWrap;
		}

		public static void DestroyInstance(MiniMapWrap obj)
		{
			if (obj != null)
			{
				cache.Remove(obj.GetPid());
				obj.com = null;
			}
		}
	}
}
