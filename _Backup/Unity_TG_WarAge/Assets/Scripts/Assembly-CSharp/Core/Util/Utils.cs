using System;
using System.Security.Cryptography;
using System.Text;
using System.Text.RegularExpressions;
using Core.Unity;
using UnityEngine;

namespace Core.Util
{
	public class Utils
	{
		public static DateTime startTime = new DateTime(1970, 1, 1, 0, 0, 0, 0);

		private static int genID = 1000000;

		public static long GetTimeSeconds()
		{
			DateTime now = DateTime.Now;
			return (long)(now - startTime).TotalSeconds;
		}

		public static string GetDateStringBySecond(long second)
		{
			return new DateTime(second * 1000 * 1000 * 10 + startTime.Ticks).GetDateTimeFormats('g')[0].ToString();
		}

		public static DateTime GetDateObject(long second)
		{
			return new DateTime(second * 1000 * 1000 * 10 + startTime.Ticks);
		}

		public static float CalculateActorSpeed(Vector3 p1, Vector3 p2, float deltaTime)
		{
			if (deltaTime <= 0f)
			{
				return -1f;
			}
			float num = Vector3.Distance(new Vector3(p1.x, 0f, p1.z), new Vector3(p2.x, 0f, p2.z));
			return num / deltaTime;
		}

		public static Vector3 GetLerp(Vector3 p1, Vector3 p2, float reduceDistance)
		{
			float num = Vector3.Distance(p1, p2);
			float t = (num - reduceDistance) / num;
			return Vector3.Lerp(p1, p2, t);
		}

		public static string MD5(string toCryString)
		{
			MD5CryptoServiceProvider mD5CryptoServiceProvider = new MD5CryptoServiceProvider();
			string text = BitConverter.ToString(mD5CryptoServiceProvider.ComputeHash(Encoding.Default.GetBytes(toCryString)));
			return text.Replace("-", string.Empty);
		}

		public static void MD5(byte[] buffer, out ulong md51, out ulong md52)
		{
			MD5CryptoServiceProvider mD5CryptoServiceProvider = new MD5CryptoServiceProvider();
			byte[] value = mD5CryptoServiceProvider.ComputeHash(buffer);
			md51 = BitConverter.ToUInt64(value, 0);
			md52 = BitConverter.ToUInt64(value, 8);
		}

		public static Transform GetChildTransformByName(Transform parent, string name)
		{
			Component[] componentsInChildren = parent.GetComponentsInChildren(typeof(Transform));
			for (int i = 0; i < componentsInChildren.Length; i++)
			{
				Transform transform = (Transform)componentsInChildren[i];
				if (string.Compare(name, transform.name) == 0)
				{
					return transform;
				}
			}
			return null;
		}

		public static bool StrongFindPathCheck(Transform transform, string[] nameAry)
		{
			int num = nameAry.Length - 1;
			while (transform != null && num >= 0 && transform.name.Equals(nameAry[num]))
			{
				transform = transform.parent;
				num--;
			}
			return num == -1;
		}

		public static bool WeakFindPathCheck(Transform transform, string[] nameAry)
		{
			int num = nameAry.Length - 1;
			while (transform != null && num >= 0)
			{
				if (transform.name.Equals(nameAry[num]))
				{
					num--;
				}
				transform = transform.parent;
			}
			return num == -1;
		}

		public static TComponent FastFind<TComponent>(NameCacheInterface<GameObject> objNameCache, GameObject current, string path) where TComponent : Component
		{
			if (current == null)
			{
				return (TComponent)null;
			}
			GameObject gameObject = null;
			TComponent val = (TComponent)null;
			if (objNameCache != null)
			{
				gameObject = objNameCache.GetByName(path);
				if (null != gameObject)
				{
					val = gameObject.GetComponent<TComponent>();
				}
				if (null != val)
				{
					return val;
				}
			}
			Transform transform = current.transform.Find(path);
			if (transform != null)
			{
				TComponent component = transform.GetComponent<TComponent>();
				if (component != null)
				{
					return component;
				}
			}
			return Find<TComponent>(current, path);
		}

		public static TComponent Find<TComponent>(GameObject current, string path) where TComponent : Component
		{
			TComponent val = (TComponent)null;
			if (path != null && path.Length != 0)
			{
				TComponent[] componentsInChildren = current.GetComponentsInChildren<TComponent>(true);
				string[] array = path.Split('/');
				if (array.Length != 0)
				{
					if (array.Length == 1)
					{
						int i = 0;
						for (int num = componentsInChildren.Length; i < num; i++)
						{
							if (componentsInChildren[i].name.Equals(array[0]))
							{
								val = componentsInChildren[i];
								break;
							}
						}
					}
					else if (!(val != null))
					{
						int j = 0;
						for (int num2 = componentsInChildren.Length; j < num2; j++)
						{
							if (componentsInChildren[j].name.Equals(array[array.Length - 1]) && StrongFindPathCheck(componentsInChildren[j].gameObject.transform, array))
							{
								val = componentsInChildren[j];
								break;
							}
						}
						if (!(val != null))
						{
							int k = 0;
							for (int num3 = componentsInChildren.Length; k < num3; k++)
							{
								if (componentsInChildren[k].name.Equals(array[array.Length - 1]) && WeakFindPathCheck(componentsInChildren[k].gameObject.transform, array))
								{
									val = componentsInChildren[k];
									break;
								}
							}
						}
					}
				}
			}
			return val;
		}

		public static Camera FindCameraForName(string name)
		{
			GameObject gameObject = GameObject.Find(name);
			if ((bool)gameObject)
			{
				return gameObject.GetComponent<Camera>();
			}
			return null;
		}

		public static string GetAbsulotePath(GameObject obj)
		{
			string text = obj.name;
			Transform parent = obj.transform.parent;
			while (parent != null)
			{
				text = parent.gameObject.name + "/" + text;
				parent = parent.parent;
			}
			return text;
		}

		public static string GetFileNameByPath(string scenePath)
		{
			string result = null;
			if (scenePath != null && scenePath.Length > 0)
			{
				int num = scenePath.LastIndexOf("/");
				int num2 = scenePath.LastIndexOf(".");
				result = scenePath.Substring(num + 1, num2 - num - 1);
			}
			return result;
		}

		public static int GenID()
		{
			return genID++;
		}

		public static float GetTerrainHeight(float x, float z)
		{
			float result = 20f;
			Ray ray = new Ray(new Vector3(x, 100f, z), Vector3.down);
			RaycastHit hitInfo;
			if (Physics.Raycast(ray, out hitInfo, 1000f, 1024))
			{
				result = hitInfo.point.y;
			}
			return result;
		}

		public static bool StringContainUpper(string text)
		{
			if (Regex.IsMatch(text, "[A-Z]"))
			{
				return true;
			}
			return false;
		}

		public static void BindService(int time)
		{
		}

		public static void UnBindService()
		{
		}

		public static void CheckGameObjectIsDestroyed(GameObject obj)
		{
			if (obj == null)
			{
				string format = "access has been destroyed GameObject;lua " + Core.Unity.Debug.Get_Lua_Fun("debug.traceback");
				Core.Unity.Debug.LogWarning(format);
			}
		}
	}
}
