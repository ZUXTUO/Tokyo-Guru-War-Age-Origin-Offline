namespace Core.Net
{
	public class Event
	{
		public enum Type : uint
		{
			CONNECT = 1u,
			CLOSE = 2u,
			ERROR = 4u
		}

		private Type state_type;

		private Client client;

		private int er;

		public Type ST
		{
			get
			{
				return state_type;
			}
			set
			{
				state_type = value;
			}
		}

		public Client CT
		{
			get
			{
				return client;
			}
			set
			{
				client = value;
			}
		}

		public int ER
		{
			get
			{
				return er;
			}
			set
			{
				er = value;
			}
		}

		public Event(Client c, Type s, int ex)
		{
			client = c;
			state_type = s;
			er = ex;
		}
	}
}
