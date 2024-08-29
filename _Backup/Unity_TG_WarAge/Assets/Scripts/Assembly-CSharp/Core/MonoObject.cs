using Core.Util;
using UnityEngine;

namespace Core
{
	public class MonoObject : MonoBehaviour, BaseInterface
	{
		private int instanceId = Utils.GenID();

		protected string lua_class_name = string.Empty;

		public static Transform parentTransform;

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

		public static GameObject CreateGameObject(string name)
		{
			GameObject gameObject = null;
			gameObject = ((name == null) ? new GameObject() : new GameObject(name));
			if (parentTransform != null)
			{
				gameObject.transform.parent = parentTransform;
			}
			Object.DontDestroyOnLoad(gameObject);
			return gameObject;
		}
	}
}
