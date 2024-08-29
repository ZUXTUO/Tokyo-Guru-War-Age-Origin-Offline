using System;
using Core;
using Core.Unity;
using LuaInterface;
using Script;
using UnityEngine;
using Wraper;

namespace UnityWrap
{
	public class UniWebViewWrap : BaseObject
	{
		public static AssetObjectCache<int, UniWebViewWrap> cache = new AssetObjectCache<int, UniWebViewWrap>();

		protected Component _component;

		public bool isNeedDestroy;

		public UniWebView bcomponent
		{
			get
			{
				return _component as UniWebView;
			}
		}

		public UniWebViewWrap()
		{
			lua_class_name = uni_web_view_wraper.name;
		}

		public void InitInstance(Component compnnent)
		{
			_component = compnnent;
			cache.Add(GetPid(), this);
		}

		public void DestroyInstance()
		{
			if (isNeedDestroy && (bool)_component)
			{
				UnityEngine.Object.Destroy(_component.gameObject);
			}
			_component = null;
			cache.Remove(GetPid());
		}

		public virtual void Clone(IntPtr L)
		{
			Core.Unity.Debug.LogError("[UniWebViewWrap Clone] Clone is not implement yet");
			LuaDLL.lua_pushnil(L);
		}

		public static UniWebViewWrap GetOrCreateCom(GameObject current, string path)
		{
			if (path != null && path.Length != 0 && current != null)
			{
				UniWebView uniWebView = current.GetComponentInChildren<UniWebView>();
				if (uniWebView == null)
				{
					GameObject gameObject = new GameObject();
					gameObject.transform.parent = current.transform;
					uniWebView = gameObject.AddComponent<UniWebView>();
				}
				uniWebView.OnWebViewShouldClose += (UniWebView w) => false;
				if (uniWebView != null)
				{
					UniWebViewWrap uniWebViewWrap = new UniWebViewWrap();
					uniWebViewWrap.InitInstance(uniWebView);
					return uniWebViewWrap;
				}
			}
			return null;
		}

		public void CallLua(string func)
		{
			ScriptCall scriptCall = ScriptCall.Create(func);
			if (scriptCall != null && scriptCall.Start())
			{
				LuaDLL.lua_newtable(scriptCall.L);
				scriptCall.lua_settable("pid", GetPid());
				scriptCall.lua_settable("string_value", string.Empty);
				scriptCall.lua_settable("float_value", 0.0);
				AssetGameObject value = null;
				if ((bool)bcomponent && (bool)bcomponent.gameObject)
				{
					value = AssetGameObject.CreateByInstance(bcomponent.gameObject);
				}
				else
				{
					Core.Unity.Debug.LogWarning("[NGUIButtonWrap OnButtonClick] UIBotton is null");
				}
				scriptCall.lua_settable("game_object", value);
				scriptCall.Finish(1);
			}
		}
	}
}
