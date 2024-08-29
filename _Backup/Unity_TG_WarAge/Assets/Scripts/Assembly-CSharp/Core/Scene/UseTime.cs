using System;

namespace Core.Scene
{
	public class UseTime
	{
		private long t0;

		public UseTime()
		{
			t0 = DateTime.Now.Ticks;
		}

		public double step()
		{
			long ticks = DateTime.Now.Ticks;
			double result = (double)(ticks - t0) / 10000.0;
			t0 = ticks;
			return result;
		}

		public void PrintStep(string str, double minT = 0.5)
		{
			long ticks = DateTime.Now.Ticks;
			long num = ticks - t0;
			t0 = ticks;
			if ((double)num >= minT * 10000.0)
			{
				ScenePrintUtil.Log(str + " use time: " + (float)num / 10000f);
			}
		}
	}
}
