using Core;
using Core.Unity;
using UnityEngine;
using Wraper;

namespace UnityWrap
{
	public class LineRenderWrap : BaseObject
	{
		public static AssetObjectCache<int, LineRenderWrap> cache = new AssetObjectCache<int, LineRenderWrap>();

		private LineRenderer com;

		public LineRenderer component
		{
			get
			{
				return com;
			}
		}

		public LineRenderWrap()
		{
			lua_class_name = line_render_wraper.name;
		}

		public static LineRenderWrap CreateInstance(LineRenderer com)
		{
			if (com == null)
			{
				Core.Unity.Debug.LogWarning("[LineRenderWrap CreateInstance] error: line render is null ");
				return null;
			}
			LineRenderWrap lineRenderWrap = new LineRenderWrap();
			lineRenderWrap.com = com;
			cache.Add(lineRenderWrap.GetPid(), lineRenderWrap);
			return lineRenderWrap;
		}

		public static void DestroyInstance(LineRenderWrap obj)
		{
			if (obj != null)
			{
				cache.Remove(obj.GetPid());
				obj.com = null;
			}
		}
	}
}
