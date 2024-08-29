using Script;
using UnityEngine;

public class KeyPress : MonoBehaviour
{
	private bool key_w_down;

	private bool key_e_down;

	private void Start()
	{
		key_w_down = false;
		key_e_down = false;
	}

	private void OnGUI()
	{
		if (key_w_down && Input.GetKeyUp(KeyCode.W))
		{
			ScriptManager.GetInstance().CallFunction("OnSpecialKeyWUp");
			key_w_down = false;
		}
		if (Input.GetKeyDown(KeyCode.W) && !key_w_down)
		{
			ScriptManager.GetInstance().CallFunction("OnSpecialKeyWDown");
			key_w_down = true;
		}
		if (key_e_down && Input.GetKeyUp(KeyCode.E))
		{
			ScriptManager.GetInstance().CallFunction("OnSpecialKeyEUp");
			key_e_down = false;
		}
		if (Input.GetKeyDown(KeyCode.E) && !key_e_down)
		{
			ScriptManager.GetInstance().CallFunction("OnSpecialKeyEDown");
			key_e_down = true;
		}
	}
}
