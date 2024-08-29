namespace Core
{
	public interface NameCacheInterface<T>
	{
		T GetByName(string name);
	}
}
