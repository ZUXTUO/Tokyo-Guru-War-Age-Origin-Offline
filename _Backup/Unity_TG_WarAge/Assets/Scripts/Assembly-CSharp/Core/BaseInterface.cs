namespace Core
{
	public interface BaseInterface
	{
		int GetPid();

		string GetLuaClassName();

		void PrePushToLua();

		void PostPushToLua();
	}
}
