using System.IO;
using Core.Unity;
using Sio;

namespace SNet
{
	public class NFunction : NParamContainer
	{
		protected enum function_name
		{
			func_key_start = 1,
			func_key_name = 2,
			func_key_id = 3,
			func_key_is_client = 4
		}

		private string name = string.Empty;

		private uint id;

		private bool isClient;

		private NModule nm;

		public string Name
		{
			get
			{
				return name;
			}
			set
			{
				name = value;
			}
		}

		public uint Id
		{
			get
			{
				return id;
			}
			set
			{
				id = value;
			}
		}

		public bool IsClient
		{
			get
			{
				return isClient;
			}
			set
			{
				isClient = value;
			}
		}

		public NModule Nm
		{
			get
			{
				return nm;
			}
			set
			{
				nm = value;
			}
		}

		public override bool Unserial(Stream s)
		{
			if (s != null && base.Unserial(s))
			{
				name = Convert.ReadString(s);
				id = Convert.ReadUint(s);
				isClient = Convert.ReadBool(s);
				return true;
			}
			return false;
		}

		public override bool Feild(uint k, SDataBuff d)
		{
			if (base.Feild(k, d))
			{
				return true;
			}
			switch ((function_name)k)
			{
			case function_name.func_key_name:
				name = d.stringValue;
				break;
			case function_name.func_key_id:
				id = d.uintValue;
				break;
			case function_name.func_key_is_client:
				isClient = d.boolValue;
				break;
			default:
				return false;
			}
			return true;
		}
	}
}
