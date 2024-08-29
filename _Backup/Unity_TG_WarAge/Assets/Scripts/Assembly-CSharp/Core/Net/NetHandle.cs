namespace Core.Net
{
	public interface NetHandle
	{
		bool ProcessEvent(Client c, Event.Type type, int error);

		bool Event(Client c, Event.Type type, int ex = 0);

		int Packet(Client c, Package p);

		void Process();
	}
}
