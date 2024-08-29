using System;

namespace Core.Net
{
	public class NetManager
	{
		private static object lockOjbect = new object();

		private static NetManager instance = null;

		public static NetManager GetInstance()
		{
			lock (lockOjbect)
			{
				if (instance == null)
				{
					instance = new NetManager();
				}
			}
			return instance;
		}

		public Client CreateClient(NetHandle handle)
		{
			Client client = new Client();
			client.Handle = handle;
			return client;
		}

		public void CreateClient()
		{
			throw new NotImplementedException();
		}
	}
}
