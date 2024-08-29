namespace Core.Scene
{
	public abstract class SceneResourceDownloadAdapter4
	{
		public SceneResourceDownloadManager4 downloadManager;

		public abstract bool StartDownload(string relativePath, int downloadPriority);

		protected void OnDownloadFinish(string relativePath, bool isSuccess)
		{
			if (downloadManager != null)
			{
				downloadManager.OnDownloadFinish(relativePath, isSuccess);
			}
		}
	}
}
