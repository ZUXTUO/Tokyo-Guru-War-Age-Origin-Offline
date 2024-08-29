namespace Core.Resource
{
	public class NewBundleRequest
	{
		public string m_filepath = string.Empty;

		public NewLoadCallback m_callback;

		public string m_zipFrom = string.Empty;

		public string m_zipTo = string.Empty;

		public string m_rwFilePath = string.Empty;

		public bool m_processed;

		public string m_msg = string.Empty;

		public string folderName = string.Empty;
	}
}
