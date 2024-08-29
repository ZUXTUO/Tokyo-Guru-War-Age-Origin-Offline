using System;
using System.Collections.Generic;
using System.Runtime.InteropServices;
using System.Text;
using YunvaIM;

public class EncodingHelper : MonoSingleton<EncodingHelper>
{
	private List<IntPtr> mMemList = new List<IntPtr>();

	public void clearMems()
	{
		foreach (IntPtr mMem in mMemList)
		{
			Marshal.FreeHGlobal(mMem);
		}
		mMemList.Clear();
	}

	private IntPtr string2encoding(string text, Encoding coding)
	{
		if (text == null)
		{
			text = string.Empty;
		}
		byte[] bytes = coding.GetBytes(text);
		byte[] array = new byte[bytes.Length + 1];
		for (int i = 0; i < bytes.Length; i++)
		{
			array[i] = bytes[i];
		}
		array[bytes.Length] = 0;
		IntPtr intPtr = Marshal.AllocHGlobal(bytes.Length + 1);
		Marshal.Copy(array, 0, intPtr, array.Length);
		mMemList.Add(intPtr);
		return intPtr;
	}

	public IntPtr string2utf8(string text)
	{
		return string2encoding(text, Encoding.UTF8);
	}

	public IntPtr string2default(string text)
	{
		return string2encoding(text, Encoding.Default);
	}

	private void OnApplicationQuit()
	{
		MonoSingleton<EncodingHelper>.instance.clearMems();
	}
}
