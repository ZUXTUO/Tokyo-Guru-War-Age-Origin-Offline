namespace Core.Util
{
	public class MemoryManager
	{
		private static MemoryManager inStance;

		private double[] memoryArray = new double[4];

		private MemoryManager()
		{
			for (int i = 0; i < 4; i++)
			{
				memoryArray[i] = 0.0;
			}
		}

		public static MemoryManager getInstance()
		{
			if (inStance == null)
			{
				inStance = new MemoryManager();
			}
			return inStance;
		}

		public void AddMemory(MEM_TYPE type, double size)
		{
			if (type >= MEM_TYPE.MEM_ACTOR && type < MEM_TYPE.MEM_AMOUNT)
			{
				memoryArray[(int)type] += size;
			}
		}

		public void RemoveMemory(MEM_TYPE type, double size)
		{
			if (type >= MEM_TYPE.MEM_ACTOR && type < MEM_TYPE.MEM_AMOUNT)
			{
				memoryArray[(int)type] -= size;
			}
		}

		public double getMemorySize(MEM_TYPE type)
		{
			if (type >= MEM_TYPE.MEM_ACTOR && type < MEM_TYPE.MEM_AMOUNT)
			{
				return memoryArray[(int)type];
			}
			return 0.0;
		}
	}
}
