using System;
using System.Collections.Generic;
using System.IO;
using Core.Unity;
using Sio;

namespace SNet
{
	public class NModule
	{
		private enum moduleKey
		{
			module_name_key = 0,
			module_startid = 1,
			module_endid = 2,
			module_function_list = 3
		}

		private string name = string.Empty;

		private uint startID;

		private uint endID;

		private IList<NFunction> functionList = new List<NFunction>();

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

		public uint StartID
		{
			get
			{
				return startID;
			}
			set
			{
				startID = value;
			}
		}

		public uint EndID
		{
			get
			{
				return endID;
			}
			set
			{
				endID = value;
			}
		}

		public void SetId(uint startid, uint endid)
		{
			startID = Math.Min(startid, endid);
			endID = Math.Max(startid, endid);
		}

		public IList<NFunction> GetFunctionList()
		{
			return functionList;
		}

		public NFunction GetFunction(uint id)
		{
			for (int i = 0; i < functionList.Count; i++)
			{
				NFunction nFunction = functionList[i];
				if (nFunction.Id == id)
				{
					return nFunction;
				}
			}
			return null;
		}

		public NFunction GetFunction(string pname)
		{
			if (pname == null)
			{
				return null;
			}
			for (int i = 0; i < functionList.Count; i++)
			{
				NFunction nFunction = functionList[i];
				if (nFunction.Name.CompareTo(pname) == 0)
				{
					return nFunction;
				}
			}
			return null;
		}

		public bool Add(NFunction pf)
		{
			pf.Nm = this;
			functionList.Remove(pf);
			functionList.Add(pf);
			return true;
		}

		public bool Remove(NFunction pf)
		{
			pf.Nm = null;
			functionList.Remove(pf);
			return true;
		}

		public bool remove(uint id)
		{
			for (int i = 0; i < functionList.Count; i++)
			{
				NFunction nFunction = functionList[i];
				if (nFunction.Id == id)
				{
					functionList.Remove(nFunction);
				}
			}
			return false;
		}

		public void Clear()
		{
			functionList.Clear();
		}

		public bool Unserial(Stream s)
		{
			if (s != null)
			{
				name = Core.Unity.Convert.ReadString(s);
				startID = Core.Unity.Convert.ReadUint(s);
				endID = Core.Unity.Convert.ReadUint(s);
				uint num = 0u;
				num = Core.Unity.Convert.ReadUint(s);
				for (uint num2 = 0u; num2 < num; num2++)
				{
					NFunction nFunction = new NFunction();
					if (nFunction.Unserial(s))
					{
						Add(nFunction);
					}
				}
				return true;
			}
			return false;
		}

		public bool Unserial(SMapReader pmap)
		{
			if (pmap != null)
			{
				SDataBuff sDataBuff = new SDataBuff();
				SDataBuff sDataBuff2 = new SDataBuff();
				while (pmap.Next(sDataBuff, sDataBuff2))
				{
					Feild(sDataBuff.uintValue, sDataBuff2);
				}
			}
			return false;
		}

		private bool Feild(uint k, SDataBuff d)
		{
			switch ((moduleKey)k)
			{
			case moduleKey.module_name_key:
				name = d.stringValue;
				break;
			case moduleKey.module_startid:
				startID = d.uintValue;
				break;
			case moduleKey.module_endid:
				endID = d.uintValue;
				break;
			case moduleKey.module_function_list:
			{
				SListReader listReader = d.listReader;
				SDataBuff sDataBuff = new SDataBuff();
				while (listReader.Next(sDataBuff))
				{
					SMapReader mapReader = sDataBuff.mapReader;
					if (mapReader != null)
					{
						NFunction nFunction = new NFunction();
						if (nFunction.Unsrial(mapReader))
						{
							Add(nFunction);
						}
					}
				}
				break;
			}
			default:
				return false;
			}
			return true;
		}
	}
}
