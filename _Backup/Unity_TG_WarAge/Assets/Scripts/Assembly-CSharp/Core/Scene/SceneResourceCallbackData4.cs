using UnityEngine;

namespace Core.Scene
{
	public class SceneResourceCallbackData4
	{
		public int intData;

		public Object uObj;

		public object sObj;

		public SceneResourceCallbackData4()
		{
		}

		public SceneResourceCallbackData4(int _intData, Object uO, object sO)
		{
			intData = _intData;
			uObj = uO;
			sObj = sO;
		}
	}
}
