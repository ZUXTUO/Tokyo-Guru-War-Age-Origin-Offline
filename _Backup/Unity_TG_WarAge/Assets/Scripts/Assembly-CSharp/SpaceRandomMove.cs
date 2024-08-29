using UnityEngine;
using UnityEngine.AI;

public class SpaceRandomMove : MonoBehaviour
{
	public enum States
	{
		move = 0,
		idle = 1
	}

	private Animation anim;

	private Animator animator;

	private bool canUpdate = true;

	public Transform target;

	public string navMeshAreaName;

	private States curState;

	private float spdChangeTime;

	private float dirChangeTime;

	private float spdTimeCounter;

	private float dirTimeCounter;

	private float spdChangeTimeMin = 0.75f;

	private float spdChangeTimeMax = 1.5f;

	public float spdMin = 0.5f;

	public float spdMax = 2.5f;

	public float rotAngleLimit = 0.005f;

	public float speed;

	private Vector3 targetPoint;

	private float rot = 2f;

	private float targetChangeTimeMin = 2.5f;

	private float targetChangeTimeMax = 6.5f;

	public float minHight = 2f;

	public float maxHight = 7f;

	private float dirChangeRate;

	private int areaMask = -1;

	private Vector3 targetVec;

	public float targetDistance = 2f;

	private bool isSpeedUp;

	private void Start()
	{
		areaMask = 1 << NavMesh.GetAreaFromName(navMeshAreaName);
		NavMeshHit hit;
		if (!NavMesh.SamplePosition(new Vector3(0f, 0f, 0f), out hit, 100000f, areaMask))
		{
			canUpdate = false;
			MonoBehaviour.print("未能找到行走面");
			base.enabled = false;
			return;
		}
		anim = base.transform.GetComponent<Animation>();
		animator = base.transform.GetComponent<Animator>();
		if (animator == null && base.transform.childCount > 0)
		{
			animator = base.transform.GetChild(0).GetComponent<Animator>();
		}
		targetVec = default(Vector3);
		float num = Random.Range(0f, 1000f) / 1000f;
		float num2 = Random.Range(0f, 1000f) / 1000f;
		float num3 = Random.Range(0f, 1000f) / 1000f;
		targetVec.x = num - 0.5f;
		targetVec.y = num2 * 0.5f - 0.25f;
		targetVec.z = num3 - 0.5f;
		changeTarget();
		curState = States.move;
	}

	private bool changeSpeed()
	{
		float num = speed;
		speed = Random.Range(spdMin, spdMax);
		spdChangeTime = Random.Range(spdChangeTimeMin, spdChangeTimeMax);
		spdTimeCounter = 0f;
		return num < speed;
	}

	private void changeTarget()
	{
		curState = States.move;
		Vector3 vector = targetVec.normalized * targetDistance;
		Vector3 sourcePosition = default(Vector3);
		targetPoint = new Vector3(vector.x + base.transform.position.x, vector.y + base.transform.position.y, vector.z + base.transform.position.z);
		NavMeshHit hit = default(NavMeshHit);
		bool flag = true;
		sourcePosition.x = targetPoint.x;
		sourcePosition.y = 0f;
		sourcePosition.z = targetPoint.z;
		if (minHight < maxHight)
		{
			if (base.transform.position.y < minHight)
			{
				flag = false;
			}
			else if (base.transform.position.y > maxHight)
			{
				flag = false;
			}
		}
		float num = 0.2f;
		if (!NavMesh.SamplePosition(sourcePosition, out hit, num, areaMask) || !flag)
		{
			do
			{
				float num2 = Random.Range(0f, 1000f) / 1000f;
				float num3 = Random.Range(0f, 1000f) / 1000f;
				float num4 = Random.Range(0f, 1000f) / 1000f;
				targetVec.x = num2 - 0.5f;
				if (minHight < maxHight)
				{
					if (base.transform.position.y <= minHight)
					{
						targetVec.y = num3 * 0.25f;
					}
					else if (base.transform.position.y >= maxHight)
					{
						targetVec.y = (0f - num3) * 0.25f;
					}
					else
					{
						targetVec.y = num3 * 0.5f - 0.25f;
					}
				}
				else
				{
					targetVec.y = 0f;
				}
				targetVec.z = num4 - 0.5f;
				vector = targetVec.normalized * targetDistance;
				if (minHight < maxHight)
				{
					targetPoint = new Vector3(vector.x + base.transform.position.x, vector.y + base.transform.position.y, vector.z + base.transform.position.z);
				}
				else
				{
					targetPoint = new Vector3(vector.x + base.transform.position.x, minHight, vector.z + base.transform.position.z);
				}
				sourcePosition.x = targetPoint.x;
				sourcePosition.y = 0f;
				sourcePosition.z = targetPoint.z;
				flag = NavMesh.SamplePosition(sourcePosition, out hit, num, areaMask);
				num *= 2f;
			}
			while (!flag);
			dirTimeCounter = 0f;
			vector = hit.position - base.transform.position;
			targetVec.x = vector.x;
			targetVec.z = vector.z;
			targetPoint = new Vector3(hit.position.x, targetPoint.y, hit.position.z);
		}
		dirChangeRate = 0f;
	}

	private bool g_checkClockwise(Vector2 p1, Vector2 p2, Vector2 p3)
	{
		float num = (p2.x - p1.x) * (p3.y - p2.y) - (p2.y - p1.y) * (p3.x - p2.x);
		if (num > 0f)
		{
			return false;
		}
		if (num < 0f)
		{
			return true;
		}
		return true;
	}

	private void Update()
	{
		if (!canUpdate)
		{
			return;
		}
		if (Vector3.Distance(targetPoint, base.transform.position) < 0.2f)
		{
			changeTarget();
		}
		spdTimeCounter += Time.deltaTime;
		if (spdTimeCounter > spdChangeTime)
		{
			isSpeedUp = changeSpeed();
		}
		base.transform.Translate(new Vector3(0f, 0f, speed) * Time.deltaTime);
		dirTimeCounter += Time.deltaTime;
		if (dirTimeCounter > dirChangeTime)
		{
			dirChangeTime = Random.Range(targetChangeTimeMin, targetChangeTimeMax);
			dirTimeCounter = 0f;
			targetVec.x = Random.Range(0, 11) - 5;
			if (minHight < maxHight)
			{
				targetVec.y = Random.Range(0, 11) - 5;
			}
			else
			{
				targetVec.y = 0f;
			}
			changeTarget();
		}
		if (target != null)
		{
			target.position = targetPoint;
		}
		float num = Time.deltaTime * rot;
		if (num > rotAngleLimit)
		{
			num = rotAngleLimit;
		}
		dirChangeRate += num;
		if (dirChangeRate >= 1f)
		{
			dirChangeRate = 1f;
		}
		Vector3 vector = targetPoint - base.transform.position;
		if ((bool)animator)
		{
			if (speed > spdMin + (spdMax - spdMin) * 0.5f)
			{
				animator.SetInteger("stateValue", 2);
			}
			else if (speed > spdMin + (spdMax - spdMin) * 0.2f)
			{
				animator.SetInteger("stateValue", 1);
			}
			else
			{
				animator.SetInteger("stateValue", 0);
			}
			float num2 = Vector3.Dot(base.transform.forward, vector) / base.transform.forward.magnitude / vector.magnitude;
			if (num2 < 0.5f)
			{
				animator.SetInteger("stateValue", 2);
			}
		}
		else if ((bool)anim)
		{
			float num3 = Vector3.Dot(base.transform.forward, vector) / base.transform.forward.magnitude / vector.magnitude;
			if ((double)num3 < 0.5)
			{
				anim.Play("fly");
			}
			else if ((double)base.transform.forward.y > 0.1)
			{
				anim.Play("fly");
			}
			else if ((double)base.transform.forward.y > -0.1 && isSpeedUp)
			{
				anim.Play("fly");
			}
			else
			{
				anim.Play("swoop");
			}
		}
		base.transform.forward = Vector3.Lerp(base.transform.forward, vector, dirChangeRate);
	}
}
