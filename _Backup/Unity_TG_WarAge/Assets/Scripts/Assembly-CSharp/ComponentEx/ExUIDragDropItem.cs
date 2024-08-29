using Script;
using UnityEngine;
using UnityWrap;

namespace ComponentEx
{
	public class ExUIDragDropItem : UIDragDropItem
	{
		public string onDragDropStartScript = string.Empty;

		public string onDragDropReleaseScript = string.Empty;

		protected override void OnDragDropStart()
		{
			base.OnDragDropStart();
			AssetGameObject assetGameObject = AssetGameObject.CreateByInstance(base.gameObject);
			if (!ScriptManager.GetInstance().CallFunction(onDragDropStartScript, assetGameObject))
			{
				assetGameObject.ClearResources();
			}
		}

		protected override void OnDragDropRelease(GameObject surface)
		{
			base.OnDragDropRelease(surface);
			AssetGameObject assetGameObject = AssetGameObject.CreateByInstance(base.gameObject);
			AssetGameObject assetGameObject2 = AssetGameObject.CreateByInstance(surface);
			if (!ScriptManager.GetInstance().CallFunction(onDragDropReleaseScript, assetGameObject, assetGameObject2))
			{
				assetGameObject.ClearResources();
				assetGameObject2.ClearResources();
			}
		}
	}
}
