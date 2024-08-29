using UnityEngine;

public class UIPosAlignment : MonoBehaviour
{
	public UIWidget[] ui;

	private Vector3[] pos;

	private UIWidget curUW;

	private void Awake()
	{
		pos = new Vector3[ui.Length];
		for (int i = 0; i < ui.Length; i++)
		{
			pos[i] = ui[i].transform.localPosition;
		}
		curUW = base.gameObject.GetComponent<UIWidget>();
	}

	public void PosUpdate()
	{
		int num = 0;
		for (int i = 0; i < ui.Length; i++)
		{
			if (ui[i].gameObject.active)
			{
				ui[i].transform.localPosition = new Vector3(ui[i].transform.localPosition.x, pos[num++].y, ui[i].transform.localPosition.z);
			}
		}
		if ((bool)curUW)
		{
			curUW.Update();
		}
	}
}
