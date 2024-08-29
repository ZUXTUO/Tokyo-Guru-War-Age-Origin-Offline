using UnityEngine;

[AddComponentMenu("NGUI/Examples/HUD Root")]
public class HUDRoot : MonoBehaviour
{
	public static GameObject go;

	private void Awake()
	{
		go = base.gameObject;
	}
}
