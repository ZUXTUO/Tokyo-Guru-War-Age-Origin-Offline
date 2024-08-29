using System;
using System.IO;
using Core;
using Core.Resource;
using Core.Unity;
using Wraper;

namespace UnityWrap
{
	public class FileHandleWrap : BaseObject
	{
		public static AssetObjectCache<int, FileHandleWrap> cache = new AssetObjectCache<int, FileHandleWrap>();

		public StreamHandle m_streamHandle;

		public FileHandleWrap()
		{
			lua_class_name = file_wraper.name;
		}

		public static FileHandleWrap CreateInstance(Stream sm)
		{
			FileHandleWrap fileHandleWrap = new FileHandleWrap();
			fileHandleWrap.m_streamHandle = new StreamHandle(sm);
			cache.Add(fileHandleWrap.GetPid(), fileHandleWrap);
			return fileHandleWrap;
		}

		public static void DestroyInstance(FileHandleWrap wrap)
		{
			if (wrap != null)
			{
				cache.Remove(wrap.GetPid());
				wrap.Close();
				wrap.m_streamHandle = null;
			}
		}

		public static FileStream Open(string filePath, int type)
		{
			string outFullPath = string.Empty;
			FileStream fileStream = null;
			FileMode mode = FileMode.Create;
			if (type == 1)
			{
				mode = FileMode.CreateNew;
			}
			if (type == 2)
			{
				mode = FileMode.Create;
			}
			if (type == 3)
			{
				mode = FileMode.Open;
			}
			if (type == 4)
			{
				mode = FileMode.OpenOrCreate;
			}
			if (type == 5)
			{
				mode = FileMode.Truncate;
			}
			if (type == 6)
			{
				mode = FileMode.Append;
			}
			if (type == 1 || type == 2 || type == 5 || type == 6)
			{
				outFullPath = FileUtil.GetWritePath(filePath);
			}
			else if (!FileUtil.FileExist(filePath, ref outFullPath))
			{
				outFullPath = FileUtil.GetWritePath(filePath);
			}
			FileUtil.CreateFolderByFile(outFullPath);
			try
			{
				return new FileStream(outFullPath, mode);
			}
			catch (Exception ex)
			{
				Debug.LogError(string.Format("[FileHandleWrap Open] Exception: {0}, path: {1}", ex.ToString(), filePath));
				return null;
			}
		}

		public static Stream OpenRead(string filePath)
		{
			string outFullPath = string.Empty;
			if (!FileUtil.FileExist(filePath, ref outFullPath))
			{
				Debug.LogWarning(string.Format("[FileHandleWrap OpenRead] file not exist, path: {0}", filePath));
				return null;
			}
			if (!FileUtil.FileExist(filePath, FileUtil.DirectoryType.WritePath))
			{
				byte[] array = ResourceManager.GetInstance().LoadResourceByWWW(filePath);
				if (array == null)
				{
					return null;
				}
				MemoryStream memoryStream = new MemoryStream();
				memoryStream.Write(array, 0, array.Length);
				memoryStream.Position = 0L;
				return memoryStream;
			}
			FileStream fileStream = null;
			try
			{
				return File.OpenRead(outFullPath);
			}
			catch (Exception ex)
			{
				Debug.LogError(string.Format("[FileHandleWrap OpenRead] Exception: {0}, path: {1}", ex.ToString(), filePath));
				return null;
			}
		}

		public static bool Exist(string filePath)
		{
			string outFullPath = string.Empty;
			return FileUtil.FileExist(filePath, ref outFullPath);
		}

		public static bool Exist(string filePath, FileUtil.DirectoryType type)
		{
			return FileUtil.FileExist(filePath, type);
		}

		public static void Delete(string filePath)
		{
			string writePath = FileUtil.GetWritePath(filePath);
			if (File.Exists(writePath))
			{
				File.Delete(writePath);
			}
		}

		public static void DeleteDir(string dirPath, bool recursive)
		{
			string writePath = FileUtil.GetWritePath(dirPath);
			if (Directory.Exists(writePath))
			{
				Directory.Delete(writePath, recursive);
			}
		}

		public void Write(bool value)
		{
			m_streamHandle.Write(value);
		}

		public void Write(int value)
		{
			m_streamHandle.Write(value);
		}

		public void Write(float value)
		{
			m_streamHandle.Write(value);
		}

		public void Write(string value)
		{
			m_streamHandle.Write(value);
		}

		public void WriteLine(string value)
		{
			m_streamHandle.WriteLine(value);
		}

		public void Write(IntPtr ptr, int size)
		{
			m_streamHandle.Write(ptr, size);
		}

		public void Flush()
		{
			m_streamHandle.Flush();
		}

		public void Close()
		{
			m_streamHandle.Close();
		}

		public void ReadAll(ref string value)
		{
			value = m_streamHandle.streamReader.ReadToEnd();
		}

		public byte[] ReadAll()
		{
			byte[] array = new byte[m_streamHandle.stream.Length];
			int num = m_streamHandle.Read(array);
			return array;
		}

		public void ReadLine(ref string value)
		{
			m_streamHandle.ReadLine(ref value);
		}

		public int Read(ref bool value)
		{
			return m_streamHandle.Read(ref value);
		}

		public int Read(ref int value)
		{
			return m_streamHandle.Read(ref value);
		}

		public int Read(ref float value)
		{
			return m_streamHandle.Read(ref value);
		}

		public int Read(ref string value)
		{
			return m_streamHandle.Read(ref value);
		}

		public int Read(byte[] buffer, int size)
		{
			return m_streamHandle.Read(buffer);
		}
	}
}
