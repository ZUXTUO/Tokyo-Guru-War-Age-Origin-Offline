using UnityEngine;

public class LoopCheckHelper : MonoBehaviour
{
	private SimpleHttpManager target;

	public void SetTarget(SimpleHttpManager dl)
	{
		target = dl;
	}

	private void FixedUpdate()
	{
		if (target != null)
		{
			target.Update();
		}
	}
}
