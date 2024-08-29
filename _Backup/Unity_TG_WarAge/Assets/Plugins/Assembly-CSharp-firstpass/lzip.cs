using System;
using System.Collections.Generic;
using System.IO;
using System.Runtime.InteropServices;
using UnityEngine;

public class lzip
{
	public static List<string> ninfo = new List<string>();

	public static List<long> uinfo = new List<long>();

	public static List<long> cinfo = new List<long>();

	public static int zipFiles;

	public static int zipFolders;

	public static int cProgress = 0;

	[DllImport("zipw")]
	internal static extern int zipGetTotalFiles(string zipArchive);

	[DllImport("zipw")]
	internal static extern int zipGetInfo(string zipArchive, string path);

	[DllImport("zipw")]
	internal static extern void releaseBuffer(IntPtr buffer);

	[DllImport("zipw")]
	internal static extern int zipGetEntrySize(string zipArchive, string entry);

	[DllImport("zipw")]
	internal static extern int zipCD(int levelOfCompression, string zipArchive, string inFilePath, string fileName, string comment);

	[DllImport("zipw")]
	internal static extern bool zipBuf2File(int levelOfCompression, string zipArchive, string arc_filename, IntPtr buffer, int bufferSize);

	[DllImport("zipw")]
	internal static extern bool zipEntry2Buffer(string zipArchive, string entry, IntPtr buffer, int bufferSize);

	[DllImport("zipw")]
	internal static extern IntPtr zipCompressBuffer(IntPtr source, int sourceLen, int levelOfCompression, ref int v);

	[DllImport("zipw")]
	internal static extern IntPtr zipDecompressBuffer(IntPtr source, int sourceLen, ref int v);

	[DllImport("zipw")]
	internal static extern int zipEX(string zipArchive, string outPath, ref int progress);

	[DllImport("zipw")]
	internal static extern int zipEntry(string zipArchive, string arc_filename, string outpath);

	public static int getTotalFiles(string zipArchive)
	{
		return zipGetTotalFiles(zipArchive);
	}

	public static long getFileInfo(string zipArchive, string path)
	{
		ninfo.Clear();
		uinfo.Clear();
		cinfo.Clear();
		zipFiles = 0;
		zipFolders = 0;
		switch (zipGetInfo(zipArchive, path))
		{
		case -1:
			Debug.Log("Input file not found.");
			return -1L;
		case -2:
			Debug.Log("Path does not exist: " + path);
			return -2L;
		case -3:
			Debug.Log("Entry info error.");
			return -3L;
		default:
		{
			string path2 = path + "/uziplog.txt";
			if (!File.Exists(path2))
			{
				Debug.Log("Info file not found.");
				return -4L;
			}
			StreamReader streamReader = new StreamReader(path2);
			long result = 0L;
			long num = 0L;
			string text;
			while ((text = streamReader.ReadLine()) != null)
			{
				string[] array = text.Split('|');
				ninfo.Add(array[0]);
				long.TryParse(array[1], out result);
				num += result;
				uinfo.Add(result);
				if (result > 0)
				{
					zipFiles++;
				}
				else
				{
					zipFolders++;
				}
				long.TryParse(array[2], out result);
				cinfo.Add(result);
			}
			streamReader.Close();
			streamReader.Dispose();
			File.Delete(path2);
			return num;
		}
		}
	}

	public static int getEntrySize(string zipArchive, string entry)
	{
		return zipGetEntrySize(zipArchive, entry);
	}

	public static bool compressBuffer(byte[] source, ref byte[] outBuffer, int levelOfCompression)
	{
		if (levelOfCompression < 0)
		{
			levelOfCompression = 0;
		}
		if (levelOfCompression > 10)
		{
			levelOfCompression = 10;
		}
		GCHandle gCHandle = GCHandle.Alloc(source, GCHandleType.Pinned);
		int v = 0;
		IntPtr intPtr = zipCompressBuffer(gCHandle.AddrOfPinnedObject(), source.Length, levelOfCompression, ref v);
		if (v == 0 || intPtr == IntPtr.Zero)
		{
			gCHandle.Free();
			releaseBuffer(intPtr);
			return false;
		}
		Array.Resize(ref outBuffer, v);
		Marshal.Copy(intPtr, outBuffer, 0, v);
		gCHandle.Free();
		releaseBuffer(intPtr);
		return true;
	}

	public static byte[] compressBuffer(byte[] source, int levelOfCompression)
	{
		if (levelOfCompression < 0)
		{
			levelOfCompression = 0;
		}
		if (levelOfCompression > 10)
		{
			levelOfCompression = 10;
		}
		GCHandle gCHandle = GCHandle.Alloc(source, GCHandleType.Pinned);
		int v = 0;
		IntPtr intPtr = zipCompressBuffer(gCHandle.AddrOfPinnedObject(), source.Length, levelOfCompression, ref v);
		if (v == 0 || intPtr == IntPtr.Zero)
		{
			gCHandle.Free();
			releaseBuffer(intPtr);
			return null;
		}
		byte[] array = new byte[v];
		Marshal.Copy(intPtr, array, 0, v);
		gCHandle.Free();
		releaseBuffer(intPtr);
		return array;
	}

	public static bool decompressBuffer(byte[] source, ref byte[] outBuffer)
	{
		GCHandle gCHandle = GCHandle.Alloc(source, GCHandleType.Pinned);
		int v = 0;
		IntPtr intPtr = zipDecompressBuffer(gCHandle.AddrOfPinnedObject(), source.Length, ref v);
		if (v == 0 || intPtr == IntPtr.Zero)
		{
			gCHandle.Free();
			releaseBuffer(intPtr);
			return false;
		}
		Array.Resize(ref outBuffer, v);
		Marshal.Copy(intPtr, outBuffer, 0, v);
		gCHandle.Free();
		releaseBuffer(intPtr);
		return true;
	}

	public static byte[] decompressBuffer(byte[] source)
	{
		GCHandle gCHandle = GCHandle.Alloc(source, GCHandleType.Pinned);
		int v = 0;
		IntPtr intPtr = zipDecompressBuffer(gCHandle.AddrOfPinnedObject(), source.Length, ref v);
		if (v == 0 || intPtr == IntPtr.Zero)
		{
			gCHandle.Free();
			releaseBuffer(intPtr);
			return null;
		}
		byte[] array = new byte[v];
		Marshal.Copy(intPtr, array, 0, v);
		gCHandle.Free();
		releaseBuffer(intPtr);
		return array;
	}

	public static bool entry2Buffer(string zipArchive, string entry, ref byte[] buffer)
	{
		int num = zipGetEntrySize(zipArchive, entry);
		if (num <= 0)
		{
			return false;
		}
		Array.Resize(ref buffer, num);
		GCHandle gCHandle = GCHandle.Alloc(buffer, GCHandleType.Pinned);
		bool result = zipEntry2Buffer(zipArchive, entry, gCHandle.AddrOfPinnedObject(), num);
		gCHandle.Free();
		return result;
	}

	public static byte[] entry2Buffer(string zipArchive, string entry)
	{
		int num = zipGetEntrySize(zipArchive, entry);
		if (num <= 0)
		{
			return null;
		}
		byte[] array = new byte[num];
		GCHandle gCHandle = GCHandle.Alloc(array, GCHandleType.Pinned);
		bool flag = zipEntry2Buffer(zipArchive, entry, gCHandle.AddrOfPinnedObject(), num);
		gCHandle.Free();
		if (!flag)
		{
			return null;
		}
		return array;
	}

	public static bool buffer2File(int levelOfCompression, string zipArchive, string arc_filename, byte[] buffer, bool append = false)
	{
		if (!append && File.Exists(zipArchive))
		{
			File.Delete(zipArchive);
		}
		GCHandle gCHandle = GCHandle.Alloc(buffer, GCHandleType.Pinned);
		if (levelOfCompression < 0)
		{
			levelOfCompression = 0;
		}
		if (levelOfCompression > 10)
		{
			levelOfCompression = 10;
		}
		bool result = zipBuf2File(levelOfCompression, zipArchive, arc_filename, gCHandle.AddrOfPinnedObject(), buffer.Length);
		gCHandle.Free();
		return result;
	}

	public static int extract_entry(string zipArchive, string arc_filename, string outpath)
	{
		return zipEntry(zipArchive, arc_filename, outpath);
	}

	public static int decompress_File(string zipArchive, string outPath, ref int progress)
	{
		if (outPath.Substring(outPath.Length - 1, 1) != "/")
		{
			outPath += "/";
		}
		return zipEX(zipArchive, outPath, ref progress);
	}

	public static int compress_File(int levelOfCompression, string zipArchive, string inFilePath, bool append = false, string fileName = "", string comment = "")
	{
		if (!append && File.Exists(zipArchive))
		{
			File.Delete(zipArchive);
		}
		if (!File.Exists(inFilePath))
		{
			return -10;
		}
		if (fileName == string.Empty)
		{
			fileName = Path.GetFileName(inFilePath);
		}
		if (levelOfCompression < 0)
		{
			levelOfCompression = 0;
		}
		if (levelOfCompression > 10)
		{
			levelOfCompression = 10;
		}
		return zipCD(levelOfCompression, zipArchive, inFilePath, fileName, comment);
	}

	public static void compressDir(string sourceDir, int levelOfCompression, string zipArchive, bool includeRoot = false)
	{
		string text = sourceDir.Replace("\\", "/");
		if (File.Exists(zipArchive))
		{
			File.Delete(zipArchive);
		}
		string[] array = text.Split('/');
		string text2 = array[array.Length - 1];
		string text3 = text2;
		cProgress = 0;
		if (levelOfCompression < 0)
		{
			levelOfCompression = 0;
		}
		if (levelOfCompression > 10)
		{
			levelOfCompression = 10;
		}
		try
		{
			string[] files = Directory.GetFiles(text, "*", SearchOption.AllDirectories);
			foreach (string text4 in files)
			{
				string text5 = text4.Replace(text, text2).Replace("\\", "/");
				if (!includeRoot)
				{
					text5 = text5.Replace(text3 + "/", string.Empty);
				}
				compress_File(levelOfCompression, zipArchive, text4, true, text5, string.Empty);
				cProgress++;
			}
		}
		catch (Exception ex)
		{
			Debug.Log("#" + ex.Message);
		}
	}

	public static int getAllFiles(string Dir)
	{
		string[] files = Directory.GetFiles(Dir, "*", SearchOption.AllDirectories);
		int result = files.Length;
		files = null;
		return result;
	}
}
