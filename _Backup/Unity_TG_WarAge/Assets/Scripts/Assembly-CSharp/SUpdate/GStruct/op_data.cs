using Sio;

namespace SUpdate.GStruct
{
	public class op_data
	{
		private enum key
		{
			key_id = 1,
			key_type = 2,
			key_path = 3,
			key_fsize = 4
		}

		private uint id_;

		private byte type_;

		private string path_ = string.Empty;

		private uint fsize_;

		public uint Id
		{
			get
			{
				return id_;
			}
			set
			{
				id_ = value;
			}
		}

		public byte Type
		{
			get
			{
				return type_;
			}
			set
			{
				type_ = value;
			}
		}

		public string Path
		{
			get
			{
				return path_;
			}
			set
			{
				path_ = value;
			}
		}

		public uint Fsize
		{
			get
			{
				return fsize_;
			}
			set
			{
				fsize_ = value;
			}
		}

		public bool Unserial(SMapReader m)
		{
			if (m != null)
			{
				SDataBuff sDataBuff = new SDataBuff();
				SDataBuff sDataBuff2 = new SDataBuff();
				while (m.Next(sDataBuff, sDataBuff2))
				{
					Feild(sDataBuff.uintValue, sDataBuff2);
				}
			}
			return true;
		}

		public bool Feild(uint k, SDataBuff d)
		{
			switch ((key)k)
			{
			case key.key_id:
				id_ = d.uintValue;
				break;
			case key.key_path:
				path_ = d.stringValue;
				break;
			case key.key_type:
				type_ = d.ucharValue;
				break;
			case key.key_fsize:
				fsize_ = d.uintValue;
				break;
			default:
				return false;
			}
			return true;
		}

		public bool Serial(SMapWriter m)
		{
			if (m != null)
			{
				m.write(1u, id_);
				m.write(2u, type_);
				m.write(3u, path_);
				m.write(4u, fsize_);
				return true;
			}
			return false;
		}
	}
}
