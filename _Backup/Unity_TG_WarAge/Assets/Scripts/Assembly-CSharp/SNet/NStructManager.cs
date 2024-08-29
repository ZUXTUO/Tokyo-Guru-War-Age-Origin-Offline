using System.Collections.Generic;
using System.IO;
using Core.Unity;
using Sio;

namespace SNet
{
	public class NStructManager
	{
		private static NStructManager instance;

		private Dictionary<string, NStruct> cache = new Dictionary<string, NStruct>();

		private NStructManager()
		{
		}

		public static NStructManager GetInstance()
		{
			if (instance == null)
			{
				instance = new NStructManager();
			}
			return instance;
		}

		public bool ReadBinary(Stream s)
		{
			if (s != null)
			{
				uint num = Convert.ReadUint(s);
				for (uint num2 = 0u; num2 < num; num2++)
				{
					NStruct nStruct = new NStruct();
					if (nStruct.Unserial(s))
					{
						Add(nStruct);
					}
				}
				return true;
			}
			return false;
		}

		public bool ReadSio(Stream instream)
		{
			SDataBuff sDataBuff = new SDataBuff();
			if (sDataBuff.UnSerializ(instream))
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
							NStruct nStruct = new NStruct();
							if (nStruct.Unsrial(mapReader))
							{
								Add(nStruct);
							}
						}
					}
					return true;
				}
			}
			return false;
		}

		public bool Read(Stream instream, bool bin)
		{
			if (!bin)
			{
				return ReadSio(instream);
			}
			return ReadBinary(instream);
		}

		public bool init()
		{
			foreach (KeyValuePair<string, NStruct> item in cache)
			{
				item.Value.Init();
			}
			return true;
		}

		public NStruct Find(string pname)
		{
			if (cache.ContainsKey(pname))
			{
				return cache[pname];
			}
			return null;
		}

		public bool Add(NStruct ps)
		{
			if (cache.ContainsKey(ps.Name))
			{
				cache[ps.Name] = ps;
			}
			else
			{
				cache.Add(ps.Name, ps);
			}
			return true;
		}

		public bool remove(NStruct ps)
		{
			return cache.Remove(ps.Name);
		}

		public bool remove(string name)
		{
			return cache.Remove(name);
		}

		public void clear()
		{
			cache.Clear();
		}

		public int GetSize()
		{
			return cache.Count;
		}
	}
}
