using Core;
using Core.Net;
using SNet;

namespace UnityWrap
{
	public class ClientObject : RefObject
	{
		public static AssetObjectCache<int, ClientObject> cache = new AssetObjectCache<int, ClientObject>();

		public static AssetObjectCache<Client, ClientObject> cache_by_client = new AssetObjectCache<Client, ClientObject>();

		private Client c;

		public Client client
		{
			get
			{
				return c;
			}
		}

		public static ClientObject CreateInstance()
		{
			ClientObject clientObject = new ClientObject();
			Client id = (clientObject.c = NetManager.GetInstance().CreateClient(NModuleManager.GetInstance()));
			cache.Add(clientObject.GetPid(), clientObject);
			cache_by_client.Add(id, clientObject);
			return clientObject;
		}

		public static void DestroyInstance(ClientObject clientObject)
		{
			if (clientObject != null)
			{
				cache.Remove(clientObject.GetPid());
				cache_by_client.Remove(clientObject.c);
				if (clientObject.c != null)
				{
					clientObject.c.Close();
				}
				clientObject.c = null;
			}
		}

		public override void ClearResources()
		{
			DestroyInstance(this);
		}
	}
}
