using System;
using System.IO;
using System.Text;
using UnityEngine;

namespace Core.Scene
{
	public class ScenePrintUtil
	{
		private static FileStream logFileStream;

		public static void UnityLogString(string result)
		{
		}

		public static void Log(UnityEngine.Object uo)
		{
			Log(uo.ToString());
		}

		public static void Log(string format, params object[] args)
		{
			string s = format;
			switch (args.Length)
			{
			case 1:
				s = string.Format(format, args[0]);
				break;
			case 2:
				s = string.Format(format, args[0], args[1]);
				break;
			case 3:
				s = string.Format(format, args[0], args[1], args[2]);
				break;
			case 4:
				s = string.Format(format, args[0], args[1], args[2], args[3]);
				break;
			case 5:
				s = string.Format(format, args[0], args[1], args[2], args[3], args[4]);
				break;
			case 6:
				s = string.Format(format, args[0], args[1], args[2], args[3], args[4], args[5]);
				break;
			case 7:
				s = string.Format(format, args[0], args[1], args[2], args[3], args[4], args[5], args[6]);
				break;
			case 8:
				s = string.Format(format, args[0], args[1], args[2], args[3], args[4], args[5], args[6], args[7]);
				break;
			}
			if (logFileStream != null)
			{
				byte[] bytes = new UTF8Encoding(true).GetBytes(DateTime.Now.ToString("dd-hh:mm:ss:fff "));
				logFileStream.Write(bytes, 0, bytes.Length);
				byte[] bytes2 = new UTF8Encoding(true).GetBytes(s);
				logFileStream.Write(bytes2, 0, bytes2.Length);
				byte value = 10;
				logFileStream.WriteByte(value);
			}
		}

		public static void LogStart(string logPath = "sceneExportVersion1.log")
		{
			if (logFileStream == null)
			{
				string writePath = ResourceManager4.GetWritePath(logPath);
				Debug.Log("delete path:" + writePath + ", logPath:" + logPath);
				if (File.Exists(writePath))
				{
					File.Delete(writePath);
				}
				ResourceManager4.CreateDirectoryByFile(logPath);
				logFileStream = File.Create(writePath);
			}
		}

		public static void LogFinish()
		{
			if (logFileStream != null)
			{
				logFileStream.Flush();
				logFileStream.Close();
			}
			logFileStream = null;
		}
	}
}
