using Core;
using Core.Resource;
using Core.Unity;
using Script;
using UnityEngine;
using Wraper;

namespace UnityWrap
{
	public class AncontrollerWraper : BaseObject
	{
		public static AssetObjectCache<int, AncontrollerWraper> cache = new AssetObjectCache<int, AncontrollerWraper>();

		private static string mCallbackScript = string.Empty;

		private RuntimeAnimatorController mContr;

		private bool isDestory = true;

		public RuntimeAnimatorController component
		{
			get
			{
				return mContr;
			}
		}

		public AncontrollerWraper()
		{
			lua_class_name = ancontroller_wraper.name;
		}

		public static AncontrollerWraper Load(string filepath)
		{
			RuntimeAnimatorController runtimeAnimatorController = Resources.Load(filepath, typeof(RuntimeAnimatorController)) as RuntimeAnimatorController;
			if (runtimeAnimatorController == null)
			{
				Core.Unity.Debug.LogError(string.Format("[AncontrollerWraper Load] error: Resources.Load( {0} ) get null RuntimeAnimatorController", filepath));
				return null;
			}
			return CreateInstance(runtimeAnimatorController);
		}

		public static void Load(string filepath, string callback)
		{
			mCallbackScript = callback;
			if (!AssetBundleLoader.GetInstance().Load(filepath, LoadCallback))
			{
				OnLoadCallbackImp(filepath, null, "[AncontrollerWraper Load] The same file to be load");
			}
		}

		private static void LoadCallback(string filepath, bool loadByWWW, WWW www, AssetBundle assetBundle, string err_msg)
		{
			string text = filepath.Substring(filepath.LastIndexOf('/') + 1);
			RuntimeAnimatorController runtimeAnimatorController = null;
			runtimeAnimatorController = ((!loadByWWW) ? AssertFactory.CreateanController(filepath, assetBundle) : AssertFactory.CreateanController(www));
			if (runtimeAnimatorController != null)
			{
				runtimeAnimatorController.name = text.Substring(0, text.LastIndexOf('.'));
			}
			AncontrollerWraper contrObject = CreateInstance(runtimeAnimatorController);
			OnLoadCallbackImp(filepath, contrObject, err_msg);
		}

		private static void OnLoadCallbackImp(string filepath, AncontrollerWraper contrObject, string err_msg)
		{
			int num = -1;
			if (contrObject != null)
			{
				num = contrObject.GetPid();
			}
			ScriptManager.GetInstance().CallFunction(mCallbackScript, num, filepath, contrObject, err_msg);
		}

		public static AncontrollerWraper CreateInstance(RuntimeAnimatorController com, bool destory = true)
		{
			if (com == null)
			{
				Core.Unity.Debug.LogError("[AncontrollerWraper CreateInstance] error: texture is null ");
				return null;
			}
			AncontrollerWraper ancontrollerWraper = new AncontrollerWraper();
			ancontrollerWraper.mContr = com;
			ancontrollerWraper.isDestory = destory;
			cache.Add(ancontrollerWraper.GetPid(), ancontrollerWraper);
			return ancontrollerWraper;
		}

		public static void DestroyInstance(AncontrollerWraper obj)
		{
			if (obj != null)
			{
				cache.Remove(obj.GetPid());
				if (obj.mContr != null && obj.isDestory)
				{
					Object.DestroyImmediate(obj.mContr, true);
					obj.mContr = null;
				}
			}
		}
	}
}
