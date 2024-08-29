using Core.Util;

namespace Core
{
	public class BaseObject : BaseInterface
	{
		private int instanceId = Utils.GenID();

		protected string lua_class_name = string.Empty;

		public int GetPid()
		{
			return instanceId;
		}

		public string GetLuaClassName()
		{
			return lua_class_name;
		}

		public virtual void PrePushToLua()
		{
		}

		public virtual void PostPushToLua()
		{
		}
	}
}
