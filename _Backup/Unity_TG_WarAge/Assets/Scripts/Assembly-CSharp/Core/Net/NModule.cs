namespace Core.Net
{
	public class NModule
	{
		protected uint startid;

		protected uint endid;

		public uint Startid
		{
			get
			{
				return startid;
			}
			set
			{
				startid = value;
			}
		}

		public uint Endid
		{
			get
			{
				return endid;
			}
			set
			{
				endid = value;
			}
		}

		public virtual bool Dispatch(Client c, Package p)
		{
			return false;
		}
	}
}
