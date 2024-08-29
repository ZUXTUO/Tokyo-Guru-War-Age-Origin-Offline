using System;

namespace Core.Net
{
	public class Package
	{
		protected PackageHeader header;

		private byte[] data;

		private Client c;

		public int AllSize
		{
			get
			{
				if (header != null)
				{
					return header.Size() + header.Length;
				}
				return 0;
			}
		}

		public int MessageID
		{
			get
			{
				if (header != null)
				{
					return header.MessageId;
				}
				return 0;
			}
			set
			{
				if (header != null)
				{
					header.MessageId = value;
					return;
				}
				Header = new PackageHeader();
				header.MessageId = value;
			}
		}

		public PackageHeader Header
		{
			get
			{
				return header;
			}
			set
			{
				if (value != null)
				{
					if (data == null)
					{
						value.Length = 0;
					}
					else
					{
						value.Length = data.Length;
					}
				}
				header = value;
			}
		}

		public byte[] Data
		{
			get
			{
				return data;
			}
			set
			{
				if (header != null && value != null)
				{
					header.Length = value.Length;
				}
				data = value;
			}
		}

		public Client C
		{
			get
			{
				return c;
			}
			set
			{
				c = value;
			}
		}

		public virtual bool encode()
		{
			return true;
		}

		public virtual bool decode()
		{
			return true;
		}

		public virtual void SetKey(uint inKey)
		{
		}

		public byte[] GetBytes()
		{
			if (header != null)
			{
				byte[] array = null;
				if (data != null)
				{
					array = new byte[header.Size() + data.Length];
					Array.Copy(data, 0, array, header.Size(), data.Length);
				}
				else
				{
					array = new byte[header.Size()];
				}
				header.Serial(array, 0);
				return array;
			}
			return null;
		}
	}
}
