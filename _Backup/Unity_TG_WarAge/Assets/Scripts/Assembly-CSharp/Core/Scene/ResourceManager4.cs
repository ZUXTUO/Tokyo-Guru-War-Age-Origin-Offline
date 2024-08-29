using System.IO;
using Core.Resource;

namespace Core.Scene
{
	public class ResourceManager4
	{
		public static bool FileExists(string relPath)
		{
			return true;
		}

		public static bool CreateDirectoryByFile(string relPath)
		{
			string writePath = FileUtil.GetWritePath(relPath);
			int num = writePath.LastIndexOf('/');
			if (num > 0)
			{
				writePath = writePath.Substring(0, num);
				if (!Directory.Exists(writePath))
				{
					Directory.CreateDirectory(writePath);
				}
			}
			return true;
		}

		public static string GetAbsPath(string relPath)
		{
			string outFullPath = string.Empty;
			FileUtil.FileExist(relPath, ref outFullPath);
			return outFullPath;
		}

		public static string GetWritePath(string relPath)
		{
			return FileUtil.GetWritePath(relPath);
		}

		public static string GetWWWPath(string relPath)
		{
			return FileUtil.GetWWWReadPath(relPath);
		}
	}
}
