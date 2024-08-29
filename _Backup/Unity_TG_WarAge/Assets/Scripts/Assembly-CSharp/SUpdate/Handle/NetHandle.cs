using Core.Net;
using Core.Unity;
using SUpdate.Logic;
using SUpdate.Module;

namespace SUpdate.Handle
{
	public class NetHandle : SampleHandler
	{
		public override bool Init()
		{
			AddModule(new NetUpdate());
			return true;
		}

		public override bool ProcessEvent(Client c, Event.Type type, int error)
		{
			switch (type)
			{
			case Core.Net.Event.Type.CONNECT:
				UpdateManager.GetInstance().Connection(c);
				break;
			case Core.Net.Event.Type.CLOSE:
				UpdateManager.GetInstance().Close(c);
				break;
			case Core.Net.Event.Type.ERROR:
				UpdateManager.GetInstance().Error(c, error);
				break;
			default:
				Debug.LogWarning("ProcessEvent() failed.. reason: unknown event type");
				break;
			}
			return true;
		}
	}
}
