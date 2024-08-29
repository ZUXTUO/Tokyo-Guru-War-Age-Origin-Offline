using UnityEngine;

public class HttpDownloadMessageDeal : MonoBehaviour
{
	private HttpDownload m_downlaod;

	public void SetDownload(HttpDownload dl)
	{
		m_downlaod = dl;
	}

	private void FixedUpdate()
	{
		m_downlaod.Update();
	}
}
