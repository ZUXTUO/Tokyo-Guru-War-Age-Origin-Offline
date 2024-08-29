using Core.Util;
using UnityEngine;

namespace UnityWrap
{
	public class NGUIWrap
	{
		public static TReturn Find<TReturn, TComponent>(AssetGameObject aGO, string path) where TReturn : NGUIBase, new() where TComponent : Component
		{
			GameObject gameObject = aGO.gameObject;
			NodeQuickLookupHelper nodeQuickLookupHelper = null;
			if (AssetGameObject.useNodeQuickLookup)
			{
				nodeQuickLookupHelper = aGO.uiNodeLookUp;
			}
			if (path != null && path.Length != 0)
			{
				TComponent val = (TComponent)null;
				if (nodeQuickLookupHelper != null)
				{
					val = nodeQuickLookupHelper.GetByName(path).GetComponent<TComponent>();
				}
				if (null == val)
				{
					val = Utils.Find<TComponent>(gameObject, path);
				}
				if (val != null)
				{
					TReturn result = new TReturn();
					result.InitInstance(val);
					return result;
				}
			}
			return (TReturn)null;
		}

		public static TReturn Clone<TReturn, TComponent>(NGUIBase uiBase) where TReturn : NGUIBase, new() where TComponent : Component
		{
			if (uiBase != null)
			{
				Transform transform = uiBase.bcomponent.gameObject.transform;
				GameObject gameObject = Object.Instantiate(uiBase.bcomponent.gameObject, transform.localPosition, transform.localRotation);
				gameObject.transform.parent = transform.parent;
				gameObject.transform.localPosition = transform.localPosition;
				gameObject.transform.localRotation = transform.localRotation;
				gameObject.transform.localScale = transform.localScale;
				TReturn val = new TReturn();
				val.InitInstance(gameObject.GetComponent<TComponent>());
				val.isNeedDestroy = true;
				return val;
			}
			return (TReturn)null;
		}
	}
}
