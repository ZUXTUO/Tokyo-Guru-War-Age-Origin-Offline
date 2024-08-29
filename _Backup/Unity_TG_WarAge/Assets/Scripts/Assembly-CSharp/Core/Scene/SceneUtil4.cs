using UnityEngine;

namespace Core.Scene
{
	public class SceneUtil4
	{
		public static int IndexOf(int[] datas, int val)
		{
			ScenePrintUtil.Log("scene util indexof int");
			int result = -1;
			int i = 0;
			for (int num = datas.Length; i < num; i++)
			{
				if (datas[i] == val)
				{
					return i;
				}
			}
			return result;
		}

		public static int IndexOf(Object[] datas, Object val)
		{
			ScenePrintUtil.Log("scene util uObject int");
			int result = -1;
			int i = 0;
			for (int num = datas.Length; i < num; i++)
			{
				if (datas[i] == val)
				{
					return i;
				}
			}
			return result;
		}

		public static int IndexOf(object[] datas, object val)
		{
			ScenePrintUtil.Log("scene util sObject int");
			int result = -1;
			int i = 0;
			for (int num = datas.Length; i < num; i++)
			{
				if (datas[i] == val)
				{
					return i;
				}
			}
			return result;
		}
	}
}
