using Script;
using UnityEngine;

namespace ComponentEx
{
	public class MouseHandler : MonoBehaviour
	{
		public string onClick = string.Empty;

		public void OnClick()
		{
			if (!(onClick == string.Empty) && (!UICamera.hoveredObject || UICamera.hoveredObject.layer != LayerMask.GetMask("UI")))
			{
				ScriptManager.GetInstance().CallFunction(onClick, base.gameObject.name);
			}
		}
	}
}
