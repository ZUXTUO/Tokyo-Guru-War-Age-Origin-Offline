using UnityEngine;

namespace YunvaIM
{
	public class YunvaLogPrint
	{
		private static int s_YvlogLevel = 1;

		public static void YvLog_setLogLevel(int loglevel)
		{
			s_YvlogLevel = loglevel;
		}

		public static void YvDebugLog(string yv_function, string yv_msg)
		{
			YvLogPrintf(yv_function, yv_msg);
		}

		public static void YvInfoLog(string yv_function, string yv_msg)
		{
			YvLogPrintf(yv_function, yv_msg, 2);
		}

		public static void YvErrorLog(string yv_function, string yv_msg)
		{
			YvLogPrintf(yv_function, yv_msg, 3);
		}

		private static void YvLogPrintf(string yv_function, string yv_msg, int loglevel = 1)
		{
			if (s_YvlogLevel != 0 && loglevel <= s_YvlogLevel)
			{
				if (loglevel == 1)
				{
					Debug.Log(string.Format("###YayaU3DLogPrintf [Debug]###{0},logMsg:{1}", yv_function, yv_msg));
				}
				if (loglevel == 2)
				{
					Debug.Log(string.Format("###YayaU3DLogPrintf [Info]###{0},logMsg:{1}", yv_function, yv_msg));
				}
				if (loglevel == 3)
				{
					Debug.Log(string.Format("###YayaU3DLogPrintf [Error]###{0},logMsg:{1}", yv_function, yv_msg));
				}
			}
		}
	}
}
