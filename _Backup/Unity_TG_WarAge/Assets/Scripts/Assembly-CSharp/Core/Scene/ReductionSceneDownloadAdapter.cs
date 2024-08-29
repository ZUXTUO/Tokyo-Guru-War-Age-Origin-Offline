using System.IO;

namespace Core.Scene
{
	public class ReductionSceneDownloadAdapter : SceneResourceDownloadAdapter4
	{
		public override bool StartDownload(string relativePath, int downloadPriority)
		{
			if (relativePath.Length != 0 && !ResourceManager4.FileExists(relativePath))
			{
				ResourceManager4.CreateDirectoryByFile(relativePath);
				string sourceFileName = ResourceManager4.GetAbsPath(relativePath).Replace("/assetbundles/", "/assetbundles_bak/");
				string absPath = ResourceManager4.GetAbsPath(relativePath);
				File.Copy(sourceFileName, absPath);
				OnDownloadFinish(relativePath, true);
			}
			else
			{
				OnDownloadFinish(relativePath, true);
			}
			return false;
		}
	}
}
