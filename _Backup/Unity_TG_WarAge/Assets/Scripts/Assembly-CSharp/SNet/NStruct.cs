using System.IO;
using Core.Unity;
using Sio;

namespace SNet
{
	public class NStruct : NParamContainer
	{
		private enum nstruct_key
		{
			nstruct_key_start = 1,
			nstruct_key_name = 2,
			nstruct_key_partent = 3,
			nstruct_key_end = 4
		}

		private string name = string.Empty;

		private NStruct partent;

		private string partentName = string.Empty;

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

		internal NStruct Partent
		{
			get
			{
				return partent;
			}
			set
			{
				partent = value;
			}
		}

		public string PartentName
		{
			get
			{
				return partentName;
			}
			set
			{
				partentName = value;
			}
		}

		public void ChangePartent(NStruct partent)
		{
			partentName = partent.Name;
			this.partent = partent;
		}

		public override bool Unserial(Stream s)
		{
			if (base.Unserial(s))
			{
				name = Convert.ReadString(s);
				partentName = Convert.ReadString(s);
				return true;
			}
			return false;
		}

		public override bool Feild(uint k, SDataBuff v)
		{
			if (base.Feild(k, v))
			{
				return true;
			}
			switch ((nstruct_key)k)
			{
			case nstruct_key.nstruct_key_partent:
				partentName = v.stringValue;
				break;
			case nstruct_key.nstruct_key_name:
				name = v.stringValue;
				break;
			default:
				return false;
			}
			return true;
		}

		public bool Init()
		{
			if (partentName != null && partentName.Length != 0)
			{
				NStruct nStruct = NStructManager.GetInstance().Find(partentName);
				if (nStruct != null)
				{
					partent = nStruct;
				}
			}
			return true;
		}

		public void SetPartentName(string name)
		{
			partentName = name;
			if (partent == null || partent.Name.CompareTo(name) != 0)
			{
				NStruct nStruct = NStructManager.GetInstance().Find(partentName);
				if (nStruct != null)
				{
					partent = nStruct;
				}
			}
		}
	}
}
