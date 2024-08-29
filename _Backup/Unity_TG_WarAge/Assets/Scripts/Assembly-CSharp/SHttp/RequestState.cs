using System.Collections.Generic;
using System.Net;

namespace SHttp
{
	public class RequestState
	{
		public HttpWebRequest request;

		public HttpWebResponse response;

		public SuccessCallback successCallback;

		public ErrorCallback errorCallback;

		public DowningCallback downingCallback;

		public string postData;

		public byte[] buffer;

		public List<byte> bytes;

		public object userData;

		public bool timeOut;

		public string errStr;

		public int status;

		public bool finish;

		public int downSize;

		public bool iszip;

		public RequestState()
		{
			request = null;
			successCallback = null;
			errorCallback = null;
			response = null;
			postData = string.Empty;
			buffer = new byte[1024];
			bytes = new List<byte>();
			userData = null;
			timeOut = false;
			errStr = string.Empty;
			status = -1;
			finish = false;
			downSize = 0;
			iszip = false;
		}

		~RequestState()
		{
			if (response != null && response.GetResponseStream() != null)
			{
				response.GetResponseStream().Close();
			}
		}
	}
}
