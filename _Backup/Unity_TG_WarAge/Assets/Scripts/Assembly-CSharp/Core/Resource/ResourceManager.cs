using System;
using System.IO;
using System.Threading;
using Core.Unity;
using UnityEngine;

namespace Core.Resource
{
	public class ResourceManager : MonoBehaviourEx
	{
		private static string go_name = "_ResourceManager";

		private static ResourceManager instance;

		public static ResourceManager GetInstance()
		{
			if (instance == null)
			{
				GameObject gameObject = MonoBehaviourEx.CreateGameObject(go_name);
				instance = gameObject.AddComponent<ResourceManager>();
			}
			return instance;
		}

		public byte[] LoadResource(string url)
		{
			byte[] fileBytes = null;
            try
			{
				string path = PathManager.streamingAssetsPath() + url;
				UnityEngine.Debug.Log("LoadResource: " + path);
				fileBytes = File.ReadAllBytes(path);
				return fileBytes;
			}
			catch (IOException e)
			{
				UnityEngine.Debug.LogError("读取文件错误: " + e.Message);
				return null;
			}
			//string filePathGrayAll = FileUtil.GetFilePathGrayAll(url);
			//if (filePathGrayAll == string.Empty)
			//{
			//	Core.Unity.Debug.LogError("[ResourceManager LoadResource] LoadResource failed. file not exist. path:" + url);
			//	return null;
			//}
			//if (filePathGrayAll.Length > 0)
			//{
			//	try
			//	{
			//		FileStream fileStream = File.OpenRead(filePathGrayAll);
			//		byte[] array = new byte[fileStream.Length];
			//		int num = fileStream.Read(array, 0, System.Convert.ToInt32(fileStream.Length));
			//		fileStream.Close();
			//		if (num <= 0)
			//		{
			//			return null;
			//		}
			//		byte[] array2 = Process(array);
			//		if (array2 == null)
			//		{
			//			return array;
			//		}
			//		return array2;
			//	}
			//	catch (Exception ex)
			//	{
			//		Core.Unity.Debug.LogError(ex.ToString());
			//		return null;
			//	}
			//}
		}

		public string GetResourceFullPath(string url)
		{
			string filePathGrayAll = FileUtil.GetFilePathGrayAll(url);
			if (filePathGrayAll == string.Empty)
			{
				Core.Unity.Debug.LogError("[ResourceManager GetResourceFullPath] GetResourceFullPath failed. file not exist. path:" + url);
			}
			return filePathGrayAll;
		}

		public byte[] LoadResourceByWWW(string url)
		{
			byte[] fileBytes = null;
			try
			{
				string path = PathManager.streamingAssetsPath() + url;
				UnityEngine.Debug.Log("LoadResourceByWWW: " + path);
				fileBytes = File.ReadAllBytes(path);
				return fileBytes;
			}
			catch (IOException e)
			{
				UnityEngine.Debug.LogError("读取文件错误: " + e.Message);
				return null;
			}
			//string wWWReadPath = FileUtil.GetWWWReadPath(url);
			//WWW wWW = new WWW(wWWReadPath);
			//while (!wWW.isDone)
			//{
			//	Thread.Sleep(0);
			//}
			//if (wWW.error != null)
			//{
			//	return null;
			//}
			//byte[] array = Process(wWW.bytes);
			//if (array == null)
			//{
			//	return wWW.bytes;
			//}
			//return array;
		}

		public byte[] loadByJNI(string filePath)
		{
			byte[] array = AndroidAssetsLoader.LoadAssetEx(filePath);
			byte[] array2 = Process(array);
			if (array2 == null)
			{
				return array;
			}
			return array2;
		}

		public byte[] __loadByJNI_bug(string filePath)
		{
			AndroidJavaObject @static = new AndroidJavaClass("com.unity3d.player.UnityPlayer").GetStatic<AndroidJavaObject>("currentActivity");
			AndroidJavaObject androidJavaObject = @static.Call<AndroidJavaObject>("getAssets", new object[0]);
			AndroidJavaObject androidJavaObject2 = androidJavaObject.Call<AndroidJavaObject>("open", new object[1] { filePath });
			int size = androidJavaObject2.Call<int>("available", new object[0]);
			IntPtr javaClass = AndroidJNI.FindClass("java.io.InputStream");
			IntPtr methodID = AndroidJNIHelper.GetMethodID(javaClass, "read", "([B)I");
			IntPtr intPtr = AndroidJNI.NewByteArray(size);
			int num = AndroidJNI.CallIntMethod(androidJavaObject2.GetRawObject(), methodID, new jvalue[1]
			{
				new jvalue
				{
					l = intPtr
				}
			});
			byte[] result = AndroidJNI.FromByteArray(intPtr);
			AndroidJNI.DeleteLocalRef(intPtr);
			androidJavaObject2.Call("close");
			androidJavaObject2.Dispose();
			return result;
		}

		public AssetBundle LoadAssetBundleFromFile(string filepath)
		{
			string assetBundlePath = FileUtil.GetAssetBundlePath(filepath);
			return AssetBundle.LoadFromFile(assetBundlePath);
		}

		public byte[] Process(byte[] encryptData)
		{
			byte[] array = null;
			ResourceHeader resourceHeader = new ResourceHeader();
			MemoryStream memoryStream = new MemoryStream(encryptData);
			if (!resourceHeader.Unserial(memoryStream))
			{
				return null;
			}
			if (resourceHeader.herderVersion == 1 && resourceHeader.fileType == 3 && resourceHeader.fileSize == memoryStream.Length - resourceHeader.headerSize)
			{
				array = new byte[resourceHeader.fileSize];
				memoryStream.Read(array, 0, resourceHeader.fileSize);
				ProcessNor(array, resourceHeader.encryptKey);
			}
			return array;
		}

		private bool ProcessNor(byte[] bs, byte[] encryptKey)
		{
			int num = bs.Length / 4;
			int num2 = encryptKey.Length / 4;
			int num3 = 0;
			int num4 = 0;
			int num5 = 0;
			for (int i = 0; i < num; i++)
			{
				num4 = BitConverter.ToInt32(bs, i * 4);
				num5 = BitConverter.ToInt32(encryptKey, num3 * 4);
				if ((i & 3) > 0)
				{
					num4 = ~num4;
				}
				num4 ^= num5;
				BitConverter.GetBytes(num4).CopyTo(bs, i * 4);
				num3++;
				num3 %= num2;
			}
			return true;
		}
	}
}
