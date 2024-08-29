using UnityEngine;

public class CreatureActiveByCamera : MonoBehaviour
{
	public SwapSmallCreature ssc;

	public int lastNum;

	public float cullDistance = 35f;

	private GameObject[] allCreature;

	private void Start()
	{
	}

	private void Update()
	{
		allCreature = ssc.allCreawture;
		if (allCreature == null)
		{
			return;
		}
		for (int i = 0; i < allCreature.Length; i++)
		{
			if (Vector3.Distance(allCreature[i].transform.position, base.transform.position) < cullDistance)
			{
				allCreature[i].SetActive(true);
			}
			else
			{
				allCreature[i].SetActive(false);
			}
		}
	}
}
