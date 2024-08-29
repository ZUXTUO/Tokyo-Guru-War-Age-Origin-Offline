namespace Core
{
	public abstract class RefObject : BaseObject
	{
		protected int refCount = 1;

		public virtual void AddRef()
		{
			refCount++;
		}

		public virtual void DelRef()
		{
			refCount--;
			if (refCount <= 0)
			{
				ClearResources();
			}
		}

		public int GetRefCount()
		{
			return refCount;
		}

		public abstract void ClearResources();
	}
}
