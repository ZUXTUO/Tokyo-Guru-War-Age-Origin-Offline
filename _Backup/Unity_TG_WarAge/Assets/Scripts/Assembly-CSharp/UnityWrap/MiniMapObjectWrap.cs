using Core;
using Wraper;

namespace UnityWrap
{
	public class MiniMapObjectWrap : BaseObject
	{
		public static AssetObjectCache<int, MiniMapObjectWrap> cache = new AssetObjectCache<int, MiniMapObjectWrap>();

		private MiniMapObject com;

		public MiniMapObject component
		{
			get
			{
				return com;
			}
		}

		public MiniMapObjectWrap()
		{
			lua_class_name = mini_map_object_wraper.name;
		}

		public static MiniMapObjectWrap CreateInstance(MiniMapObject com)
		{
			MiniMapObjectWrap miniMapObjectWrap = new MiniMapObjectWrap();
			miniMapObjectWrap.com = com;
			cache.Add(miniMapObjectWrap.GetPid(), miniMapObjectWrap);
			return miniMapObjectWrap;
		}

		public static void DestroyInstance(MiniMapObjectWrap obj)
		{
			if (obj != null)
			{
				cache.Remove(obj.GetPid());
				obj.com = null;
			}
		}
	}
}
