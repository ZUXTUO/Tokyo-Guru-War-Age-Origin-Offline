using System.Collections;
using System.Collections.Generic;
using System.IO;
using Core.Net;
using Core.Unity;
using Sio;

namespace SNet
{
	public class NModuleManager : SampleHandler
	{
		private static NModuleManager instance;

		private ArrayList moduelCache = new ArrayList();

		private Dictionary<uint, NFunction> functionCache = new Dictionary<uint, NFunction>();

		private NIprocess pprocess;

		public NIprocess Pprocess
		{
			get
			{
				return pprocess;
			}
			set
			{
				pprocess = value;
			}
		}

		public static NModuleManager GetInstance()
		{
			if (instance == null)
			{
				instance = new NModuleManager();
			}
			return instance;
		}

		public bool Load(Stream s, bool bin = false)
		{
			bool result = false;
			if (s != null)
			{
				result = NStructManager.GetInstance().Read(s, bin) && Read(s, bin);
			}
			return result;
		}

		private bool ReadBinary(Stream s)
		{
			if (s != null)
			{
				uint num = Convert.ReadUint(s);
				for (uint num2 = 0u; num2 < num; num2++)
				{
					NModule nModule = new NModule();
					if (nModule.Unserial(s))
					{
						Add(nModule);
					}
				}
				return true;
			}
			return false;
		}

		private bool ReadSio(Stream s)
		{
			SDataBuff sDataBuff = new SDataBuff();
			if (sDataBuff.UnSerializ(s))
			{
				SListReader listReader = sDataBuff.listReader;
				if (listReader != null)
				{
					SDataBuff sDataBuff2 = new SDataBuff();
					while (listReader.Next(sDataBuff2))
					{
						SMapReader mapReader = sDataBuff2.mapReader;
						if (mapReader != null)
						{
							NModule nModule = new NModule();
							if (nModule.Unserial(mapReader))
							{
								Add(nModule);
							}
						}
					}
					return true;
				}
			}
			return false;
		}

		public bool Read(Stream s, bool binary)
		{
			if (binary)
			{
				return ReadBinary(s);
			}
			return ReadSio(s);
		}

		public int getModuleSize()
		{
			return moduelCache.Count;
		}

		public void clear()
		{
			for (int i = 0; i < moduelCache.Count; i++)
			{
				Clear((NModule)moduelCache[i]);
			}
		}

		private void Clear(NModule o)
		{
			IList<NFunction> functionList = o.GetFunctionList();
			for (int i = 0; i < functionList.Count; i++)
			{
				Clear(functionList[i]);
			}
		}

		private void Clear(NFunction f)
		{
			if (f != null)
			{
				functionCache.Remove(f.Id);
			}
		}

		public bool Remove(NModule m)
		{
			for (int i = 0; i < moduelCache.Count; i++)
			{
				if (moduelCache[i].Equals(m))
				{
					Clear(m);
					moduelCache.RemoveAt(i);
					return true;
				}
			}
			return false;
		}

		public bool Add(NModule m)
		{
			if (m != null)
			{
				Remove(m);
				moduelCache.Add(m);
				IList<NFunction> functionList = m.GetFunctionList();
				for (int i = 0; i < functionList.Count; i++)
				{
					NFunction nFunction = functionList[i];
					if (functionCache.ContainsKey(nFunction.Id))
					{
						functionCache[nFunction.Id] = nFunction;
					}
					else
					{
						functionCache.Add(nFunction.Id, nFunction);
					}
				}
				return true;
			}
			return false;
		}

		public override bool ProcessEvent(Client c, Event.Type p, int error)
		{
			return pprocess.ProcessEvent(c, p, error);
		}

		public override string GetMessageFuncName(int mid)
		{
			NFunction functin = GetFunctin(mid);
			string result = string.Empty;
			if (functin != null)
			{
				result = functin.Name;
			}
			return result;
		}

		public override void Process(Package p)
		{
			int messageID = p.MessageID;
			NFunction functin = GetFunctin(messageID);
			if (functin != null && pprocess != null)
			{
				pprocess.Process(p.C, p, messageID, functin);
			}
			else
			{
				Debug.LogWarning("not find functioin msgid:" + messageID);
			}
		}

		public NFunction GetFunctin(int mid)
		{
			if (functionCache.ContainsKey((uint)mid))
			{
				return functionCache[(uint)mid];
			}
			return null;
		}
	}
}
