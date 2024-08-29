using System.IO;
using Core.Unity;
using Sio;

namespace SNet
{
	public class NParam
	{
		private enum ParamKey
		{
			param_key_name = 0,
			param_key_type_name = 1,
			param_key_type = 2,
			param_key_container = 3,
			param_key_id = 4,
			param_key_is_list = 5
		}

		private string name = string.Empty;

		private string typeName = string.Empty;

		private ParamType dtype;

		private ParamContainer container;

		private int id;

		private bool isList;

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

		public string TypeName
		{
			get
			{
				return typeName;
			}
			set
			{
				typeName = value;
			}
		}

		public ParamType DType
		{
			get
			{
				return dtype;
			}
			set
			{
				dtype = value;
			}
		}

		public ParamContainer Container
		{
			get
			{
				return container;
			}
			set
			{
				container = value;
			}
		}

		public int Id
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

		public bool Is_list_
		{
			get
			{
				return isList;
			}
			set
			{
				isList = value;
			}
		}

		public bool Unserial(Stream s)
		{
			if (s != null)
			{
				name = Convert.ReadString(s);
				typeName = Convert.ReadString(s);
				dtype = (ParamType)Convert.ReadUShort(s);
				container = (ParamContainer)Convert.ReadUShort(s);
				id = Convert.ReadInt(s);
				isList = Convert.ReadBool(s);
				return true;
			}
			return false;
		}

		public bool Unserial(SMapReader pmap)
		{
			if (pmap != null)
			{
				SDataBuff sDataBuff = new SDataBuff();
				SDataBuff v = new SDataBuff();
				while (pmap.Next(sDataBuff, v))
				{
					Feild(sDataBuff.uintValue, v);
				}
				return true;
			}
			return false;
		}

		public bool Feild(uint k, SDataBuff v)
		{
			switch ((ParamKey)k)
			{
			case ParamKey.param_key_name:
				name = v.stringValue;
				break;
			case ParamKey.param_key_type_name:
				typeName = v.stringValue;
				break;
			case ParamKey.param_key_type:
				dtype = (ParamType)v.intValue;
				break;
			case ParamKey.param_key_container:
				container = (ParamContainer)v.intValue;
				break;
			case ParamKey.param_key_id:
				id = v.intValue;
				break;
			case ParamKey.param_key_is_list:
				isList = v.boolValue;
				break;
			default:
				return false;
			}
			return true;
		}
	}
}
