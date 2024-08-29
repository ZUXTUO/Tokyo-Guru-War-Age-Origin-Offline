using Core.Net;

namespace SNet
{
	public interface NIprocess
	{
		bool ProcessEvent(Client c, Event.Type type, int error);

		bool Process(Client c, Package p, int messageid, NFunction f);
	}
}
