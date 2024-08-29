using Core;
using UnityEngine;
using Wraper;

namespace UnityWrap
{
	public class MatrixWrap : BaseObject
	{
		public static AssetObjectCache<int, MatrixWrap> cache = new AssetObjectCache<int, MatrixWrap>();

		private Matrix4x4 com;

		public Matrix4x4 component
		{
			get
			{
				return com;
			}
		}

		public MatrixWrap()
		{
			lua_class_name = matrix_wraper.name;
		}

		public static MatrixWrap CreateInstance(Matrix4x4 com)
		{
			MatrixWrap matrixWrap = new MatrixWrap();
			matrixWrap.com = com;
			cache.Add(matrixWrap.GetPid(), matrixWrap);
			return matrixWrap;
		}

		public static void DestroyInstance(MatrixWrap obj)
		{
			if (obj != null)
			{
				cache.Remove(obj.GetPid());
				obj.com = Matrix4x4.identity;
			}
		}
	}
}
