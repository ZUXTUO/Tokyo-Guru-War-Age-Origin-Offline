using System.Collections.Generic;
using System.IO;
using Core.Unity;
using Sio;

namespace SNet
{
	public class NParamContainer
	{
		private IList<NParam> paramList = new List<NParam>();

		public IList<NParam> ParamList
		{
			get
			{
				return paramList;
			}
			set
			{
				paramList = value;
			}
		}

		public virtual bool Unserial(Stream s)
		{
			if (s != null)
			{
				uint num = Convert.ReadUint(s);
				for (uint num2 = 0u; num2 < num; num2++)
				{
					NParam nParam = new NParam();
					if (nParam.Unserial(s))
					{
						paramList.Add(nParam);
					}
				}
				return true;
			}
			return false;
		}

		public virtual bool Unsrial(SMapReader map)
		{
			if (map != null)
			{
				SDataBuff sDataBuff = new SDataBuff();
				SDataBuff sDataBuff2 = new SDataBuff();
				while (map.Next(sDataBuff, sDataBuff2))
				{
					Feild(sDataBuff.uintValue, sDataBuff2);
				}
				return true;
			}
			return false;
		}

		public virtual bool Feild(uint k, SDataBuff d)
		{
			if (k == 0)
			{
				SListReader sListReader = new SListReader();
				if (sListReader != null)
				{
					SDataBuff sDataBuff = new SDataBuff();
					while (sListReader.Next(sDataBuff))
					{
						SMapReader mapReader = sDataBuff.mapReader;
						NParam nParam = new NParam();
						if (mapReader != null && nParam.Unserial(mapReader))
						{
							paramList.Add(nParam);
						}
					}
				}
				return true;
			}
			return false;
		}

		public bool Add(NParam param)
		{
			if (param == null || param.Name == null)
			{
				return false;
			}
			for (int i = 0; i < paramList.Count; i++)
			{
				NParam nParam = paramList[i];
				if (nParam.Name != null && nParam.Name.CompareTo(param.Name) == 0)
				{
					return false;
				}
			}
			param.Id = paramList.Count + 1;
			return true;
		}

		public bool Remove(NParam param)
		{
			return paramList.Remove(param);
		}

		public bool Remove(int id)
		{
			for (int i = 0; i < paramList.Count; i++)
			{
				NParam nParam = paramList[i];
				if (nParam.Id == id)
				{
					paramList.Remove(nParam);
					return true;
				}
			}
			return false;
		}

		public bool Remove(string name)
		{
			if (name == null || name.Length == 0)
			{
				return false;
			}
			for (int i = 0; i < paramList.Count; i++)
			{
				NParam nParam = paramList[i];
				if (nParam.Name.CompareTo(name) == 0)
				{
					paramList.Remove(nParam);
					return true;
				}
			}
			return false;
		}

		public NParam Get(string name)
		{
			if (name == null || name.Length == 0)
			{
				return null;
			}
			for (int i = 0; i < paramList.Count; i++)
			{
				NParam nParam = paramList[i];
				if (nParam.Name.CompareTo(name) == 0)
				{
					return nParam;
				}
			}
			return null;
		}

		public NParam Get(int id)
		{
			for (int i = 0; i < paramList.Count; i++)
			{
				NParam nParam = paramList[i];
				if (nParam.Id == id)
				{
					return nParam;
				}
			}
			return null;
		}
	}
}
