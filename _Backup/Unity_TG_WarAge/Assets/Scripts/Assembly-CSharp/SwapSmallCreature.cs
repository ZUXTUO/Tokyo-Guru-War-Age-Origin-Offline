using UnityEngine;
using UnityEngine.AI;

public class SwapSmallCreature : MonoBehaviour
{
	public GameObject targetBase;

	public int MaxNum = 100;

	public float swapTimeDur = 0.2f;

	public int curNum = 1;

	public string swapAreaName;

	public float swapMinHight;

	public float swapMaxHight = 5f;

	public float swapScaleMin = 0.2f;

	public float swapScaleMax = 0.3f;

	public string cameraName = "fightCamera";

	public string defaultCameraName = "fightCamera";

	public float cullDistance = 25f;

	private float timeCounter;

	private Vector3 navCenterPoint;

	private float navWidth;

	private float navHeight;

	private Vector3 startPos;

	private NavMeshHit afterHit;

	private int areaMask = -1;

	public GameObject[] allCreawture;

	private CreatureActiveByCamera cc;

	private bool findTargetCamera;

	private void Start()
	{
		allCreawture = new GameObject[MaxNum];
		NavMeshHit hit = default(NavMeshHit);
		NavMeshHit hit2 = default(NavMeshHit);
		NavMeshHit hit3 = default(NavMeshHit);
		NavMeshHit hit4 = default(NavMeshHit);
		afterHit = default(NavMeshHit);
		startPos = default(Vector3);
		if (swapAreaName != null)
		{
			areaMask = 1 << NavMesh.GetAreaFromName(swapAreaName);
		}
		NavMesh.SamplePosition(new Vector3(-10000f, 0f, 0f), out hit, 100000f, areaMask);
		NavMesh.SamplePosition(new Vector3(10000f, 0f, 0f), out hit2, 100000f, areaMask);
		NavMesh.SamplePosition(new Vector3(0f, 0f, 10000f), out hit3, 100000f, areaMask);
		NavMesh.SamplePosition(new Vector3(0f, 0f, -10000f), out hit4, 100000f, areaMask);
		navCenterPoint = new Vector3((hit2.position.x - hit.position.x) / 2f + hit.position.x, hit2.position.y, (hit3.position.z - hit4.position.z) / 2f + hit4.position.z);
		navWidth = hit2.position.x - hit.position.x;
		navHeight = hit3.position.z - hit4.position.z;
		if (targetBase != null)
		{
			allCreawture[0] = targetBase;
		}
		if (swapTimeDur <= 0f)
		{
			for (int i = 0; i < MaxNum - 1; i++)
			{
				createCreature();
			}
		}
	}

	private void createCreature()
	{
		timeCounter = 0f;
		startPos.x = navCenterPoint.x;
		startPos.y = navCenterPoint.y;
		startPos.z = navCenterPoint.z;
		startPos.x = startPos.x + Random.Range(0.0001f, navWidth) - navWidth / 2f;
		startPos.z = startPos.z + Random.Range(0.0001f, navHeight) - navHeight / 2f;
		if (NavMesh.SamplePosition(startPos, out afterHit, 10000f, areaMask))
		{
			GameObject gameObject = Object.Instantiate(targetBase);
			gameObject.transform.position = new Vector3(afterHit.position.x, Random.Range(swapMinHight + 0.0001f, swapMaxHight + 0.0001f), afterHit.position.z);
			gameObject.transform.forward = Vector3.Lerp(base.transform.forward, new Vector3(Random.Range(-50, 50), Random.Range(-50, 50), Random.Range(-50, 50)), 1f);
			float num = Random.Range(swapScaleMin, swapScaleMax);
			gameObject.transform.localScale = new Vector3(num, num, num);
			allCreawture[curNum] = gameObject;
		}
		else
		{
			allCreawture = null;
		}
		curNum++;
	}

	private void Update()
	{
		if (curNum < MaxNum)
		{
			timeCounter += Time.deltaTime;
			if (timeCounter > swapTimeDur)
			{
				createCreature();
			}
		}
		if (!findTargetCamera)
		{
			Camera[] allCameras = Camera.allCameras;
			for (int i = 0; i < allCameras.Length; i++)
			{
				if (allCameras[i].name == cameraName)
				{
					cc = allCameras[i].gameObject.AddComponent<CreatureActiveByCamera>();
					cc.ssc = this;
					cc.cullDistance = cullDistance;
					findTargetCamera = true;
					break;
				}
			}
			if (!findTargetCamera && cameraName != defaultCameraName)
			{
				for (int j = 0; j < allCameras.Length; j++)
				{
					if (allCameras[j].name == defaultCameraName)
					{
						cc = allCameras[j].gameObject.AddComponent<CreatureActiveByCamera>();
						cc.ssc = this;
						cc.cullDistance = cullDistance;
						findTargetCamera = true;
						break;
					}
				}
			}
		}
		if (cc != null)
		{
			cc.cullDistance = cullDistance;
		}
	}
}
