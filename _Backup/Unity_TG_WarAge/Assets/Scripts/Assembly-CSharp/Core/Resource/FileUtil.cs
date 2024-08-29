using System;
using System.Collections.Generic;
using System.IO;
using Core.Unity;

namespace Core.Resource
{
	public class FileUtil
	{
		public enum DirectoryType
		{
			ReadPath = 1,
			WritePath = 2
		}

		private static string readOnlyDirectory = string.Empty;

		private static string writeDirectory = string.Empty;

		private static HashSet<string> fileSet;

		public static void SeparateFileDirAndName(string fullFileName, ref string fileDir, ref string fileName)
		{
			int num = fullFileName.LastIndexOf('/');
			if (fileDir != null)
			{
				fileDir = fullFileName.Substring(0, num + 1);
			}
			if (fileName != null)
			{
				fileName = fullFileName.Substring(num + 1, fullFileName.Length - num - 1);
			}
		}

		public static void SeparateFileDirNameExt(string fullFileName, ref string fileDir, ref string fileName, ref string ext)
		{
			int num = fullFileName.LastIndexOf('/');
			int num2 = fullFileName.LastIndexOf('.');
			if (fileDir != null)
			{
				fileDir = fullFileName.Substring(0, num + 1);
			}
			if (fileName != null)
			{
				fileName = fullFileName.Substring(num + 1, num2 - num - 1);
			}
			if (ext != null)
			{
				ext = fullFileName.Substring(num2 + 1, fullFileName.Length - num2 - 1);
			}
		}

		public static string GetParentDir(string fileName)
		{
			fileName.Replace('\\', '/');
			int length = fileName.LastIndexOf("/", fileName.Length - 2, fileName.Length - 2);
			return fileName.Substring(0, length);
		}

		public static void InitAndroidFileSet()
		{
			/*
			byte[] array = ResourceManager.GetInstance().LoadResourceByWWW("file_names.txt");
			if (array == null || array.Length == 0)
			{
				Debug.LogError("[FileUtil InitAndroidFileSet] file_names.txt is not exist");
				return;
			}
			*/

			fileSet = new HashSet<string>();
			MemoryStream stream = new MemoryStream(ResourceManager.GetInstance().LoadResource("file_names.txt"));
			StreamReader streamReader = new StreamReader(stream);
			while (streamReader.Peek() >= 0)
			{
				string text = streamReader.ReadLine();
				fileSet.Add(text);
				Debug.Log("[FileUtil InitAndroidFileSet] read file: " + text, Debug.LogLevel.Normal);
			}
		}

		public static void SetReadOnlyDirectory(string dir)
		{
			if (dir == null)
			{
				dir = string.Empty;
			}
			dir = dir.Replace("\\", "/");
			if (dir.Length != 0 && dir[dir.Length - 1] != '/')
			{
				readOnlyDirectory = dir + "/";
			}
			else
			{
				readOnlyDirectory = dir;
			}
		}

		public static void SetWriteDirectory(string dir)
		{
			if (dir == null)
			{
				dir = string.Empty;
			}
			dir = dir.Replace("\\", "/");
			if (dir.Length != 0 && dir[dir.Length - 1] != '/')
			{
				writeDirectory = dir + "/";
			}
			else
			{
				writeDirectory = dir;
			}
		}

		public static string GetReadOnlyPath(string filepath)
		{
			return readOnlyDirectory + filepath;
		}

		public static string GetWritePath(string filepath)
		{
			return writeDirectory + filepath;
		}

		public static string GetWriteGrayPath(string filepath)
		{
			return writeDirectory + App3.GetInstance().GetGrayPath() + filepath;
		}

		public static string GetReadDir()
		{
			return readOnlyDirectory;
		}

		public static string GetWriteDir()
		{
			return writeDirectory;
		}

		public static string GetWWWReadPath(string filepath)
		{
			//string filePathGrayWrite = GetFilePathGrayWrite(filepath);
			//if (filePathGrayWrite != string.Empty)
			//{
			//	return "file:///" + filePathGrayWrite;
			//}
			//return GetReadOnlyPath(filepath);
			string path = PathManager.WWWstreamingAssetsPath() + filepath;
			UnityEngine.Debug.Log("GetWWWReadPath: " + path);
			return path;
		}

		public static string GetAssetBundlePath(string filepath)
		{
			//string text = GetFilePathGrayWrite(filepath);
			//if (!(text != string.Empty))
			//{
			//	text = GetReadOnlyPath(filepath);
			//}
			//return text;
			string path = PathManager.streamingAssetsPath() + filepath;
			UnityEngine.Debug.Log("GetAssetBundlePath: " + path);
			return path;
		}

		public static string GetFilePathGrayAll(string filepath)
		{
			if (filepath == null || filepath.Length == 0)
			{
				return string.Empty;
			}
			if (FileExist(App3.GetInstance().GetGrayPath() + filepath, DirectoryType.WritePath))
			{
				return GetWriteGrayPath(filepath);
			}
			if (FileExist(filepath, DirectoryType.WritePath))
			{
				return GetWritePath(filepath);
			}
			if (FileExist(filepath, DirectoryType.ReadPath))
			{
				return GetReadOnlyPath(filepath);
			}
			return string.Empty;
		}

		public static string GetFilePathGrayWrite(string filepath)
		{
			if (filepath == null || filepath.Length == 0)
			{
				return string.Empty;
			}
			if (FileExist(App3.GetInstance().GetGrayPath() + filepath, DirectoryType.WritePath))
			{
				return GetWriteGrayPath(filepath);
			}
			if (FileExist(filepath, DirectoryType.WritePath))
			{
				return GetWritePath(filepath);
			}
			return string.Empty;
		}

		public static string GetGaryPath(string filepath)
		{
			return GetWriteDir() + App3.GetInstance().GetGrayPath() + filepath;
		}

		public static bool FileExist(string filepath)
		{
			string outFullPath = string.Empty;
			return FileExist(filepath, ref outFullPath);
		}

		public static bool FileExist(string filepath, ref string outFullPath)
		{
			if (filepath != null && filepath.Length != 0)
			{
				if (FileExist(filepath, DirectoryType.WritePath))
				{
					outFullPath = GetWritePath(filepath);
					return true;
				}
				if (FileExist(filepath, DirectoryType.ReadPath))
				{
					outFullPath = GetReadOnlyPath(filepath);
					return true;
				}
			}
			return false;
		}

		public static bool FileExist(string filepath, DirectoryType type)
		{
			if (filepath != null && filepath.Length != 0)
			{
				if (type == DirectoryType.WritePath && File.Exists(GetWritePath(filepath)))
				{
					return true;
				}
				if (type == DirectoryType.ReadPath)
				{
					if (fileSet != null && fileSet.Contains(filepath))
					{
						return true;
					}
					if (File.Exists(GetReadOnlyPath(filepath)))
					{
						return true;
					}
				}
			}
			return false;
		}

		public static string FilePath(string filepath, DirectoryType type)
		{
			string result = string.Empty;
			if (filepath == null || filepath.Length == 0)
			{
				return result;
			}
			if (type == DirectoryType.WritePath)
			{
				result = GetWritePath(filepath);
			}
			if (type == DirectoryType.ReadPath)
			{
				result = GetReadOnlyPath(filepath);
			}
			return result;
		}

		public static bool Save(MemoryStream m, string path)
		{
			if (m != null)
			{
				string writePath = GetWritePath(path);
				if (CreateFolderByFile(writePath))
				{
					try
					{
						if (File.Exists(writePath))
						{
							File.Delete(writePath);
						}
						FileStream fileStream = File.Create(writePath);
						fileStream.Write(m.GetBuffer(), System.Convert.ToInt32(m.Position), System.Convert.ToInt32(m.Length - m.Position));
						fileStream.Flush();
						fileStream.Close();
						return true;
					}
					catch (Exception ex)
					{
						Debug.LogError(ex.ToString());
					}
				}
			}
			return false;
		}

		public static bool Save(char[] buffer, string path)
		{
			if (buffer != null)
			{
				string writePath = GetWritePath(path);
				if (CreateFolderByFile(writePath))
				{
					try
					{
						if (File.Exists(writePath))
						{
							File.Delete(writePath);
						}
						FileStream stream = File.Create(writePath);
						StreamWriter streamWriter = new StreamWriter(stream);
						streamWriter.Write(buffer);
						streamWriter.Flush();
						streamWriter.Close();
					}
					catch (Exception ex)
					{
						Debug.LogError(ex.ToString());
					}
				}
			}
			return false;
		}

		public static bool CreateFolderByFile(string filepath)
		{
			bool result = false;
			int num = filepath.LastIndexOf('/');
			if (num == -1)
			{
				Debug.LogWarning("CreateFolderByFile failed. not find '/'. filepath:" + filepath);
			}
			else
			{
				string path = filepath.Substring(0, num);
				try
				{
					if (!Directory.Exists(path))
					{
						Directory.CreateDirectory(path);
					}
					result = true;
				}
				catch (Exception ex)
				{
					Debug.LogWarning(ex.ToString());
				}
			}
			return result;
		}

		public static bool Fremove(string path)
		{
			string writePath = GetWritePath(path);
			if (File.Exists(writePath))
			{
				try
				{
					File.Delete(writePath);
					return true;
				}
				catch (Exception ex)
				{
					Debug.LogWarning(ex.ToString());
				}
			}
			return false;
		}

		private static bool Rename(string from, string to)
		{
			try
			{
				if (!File.Exists(from))
				{
					return false;
				}
				if (File.Exists(to))
				{
					File.Delete(to);
				}
				File.Move(from, to);
				return true;
			}
			catch (Exception ex)
			{
				Debug.LogError(ex.ToString());
			}
			return false;
		}

		public static List<string> GetFileName(string dirPath)
		{
			List<string> list = new List<string>();
			if (Directory.Exists(dirPath))
			{
				list.AddRange(Directory.GetFiles(dirPath));
			}
			return list;
		}

		public static List<string> GetDirs(string dirPath)
		{
			List<string> list = new List<string>();
			string[] directories = Directory.GetDirectories(dirPath);
			if (directories.Length > 0)
			{
				string[] array = directories;
				foreach (string text in array)
				{
					list.Add(text);
					list.AddRange(GetDirs(text));
				}
			}
			return list;
		}

		public static List<string> GetAllFileName(string rootPath)
		{
			List<string> list = new List<string>();
			list.Add(rootPath);
			list.AddRange(GetDirs(rootPath));
			string[] array = list.ToArray();
			List<string> list2 = new List<string>();
			string[] array2 = array;
			foreach (object obj in array2)
			{
				list2.AddRange(GetFileName(obj.ToString()));
			}
			return list2;
		}
	}
}
