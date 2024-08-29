using UnityEngine;

internal class UnzipAssetFileOut
{
	private static UnzipAssetFileOut m_ins;

	private AndroidJavaObject jarClassObject;

	public static UnzipAssetFileOut Instance()
	{
		if (m_ins == null)
		{
			m_ins = new UnzipAssetFileOut();
			m_ins.jarClassObject = new AndroidJavaObject("com.digitalsky.ghoul.ziptools.LoadAssetFileOut");
		}
		return m_ins;
	}

	public void copyAssetFileOut(string assetName, string outpath)
	{
		jarClassObject.Call("copyAssetFileOut", assetName, outpath);
	}

	public void Quit()
	{
		jarClassObject.Call("Quit");
	}

	public void showLog(bool show)
	{
		jarClassObject.Call("showLog", show);
	}

	public void addZipFile(string fileName, string assetNames, string outputDirectorys)
	{
		jarClassObject.Call("addZipFile", fileName, assetNames, outputDirectorys);
	}

	public void startExecuteTask()
	{
		jarClassObject.Call("startExecuteTask");
	}

	public string getUnzipCompleteFiles()
	{
		return jarClassObject.Call<string>("getUnzipCompleteFiles", new object[0]);
	}

	public string getUnzipFailedFiles()
	{
		return jarClassObject.Call<string>("getUnzipFailedFiles", new object[0]);
	}

	public void initThreadNum(int num)
	{
		jarClassObject.Call("initThreadNum", num);
	}
}
