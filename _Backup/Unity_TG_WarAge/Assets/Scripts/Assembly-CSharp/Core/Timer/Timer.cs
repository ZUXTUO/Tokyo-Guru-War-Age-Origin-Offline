namespace Core.Timer
{
	internal class Timer : BaseObject
	{
		public string callback;

		public float interval = -1f;

		public int loop = -1;

		public int type = 1;

		public float lastTime;

		public bool pause;

		public void Init(string callback, float interval, int loop)
		{
			this.callback = callback;
			this.interval = interval;
			this.loop = loop;
		}
	}
}
