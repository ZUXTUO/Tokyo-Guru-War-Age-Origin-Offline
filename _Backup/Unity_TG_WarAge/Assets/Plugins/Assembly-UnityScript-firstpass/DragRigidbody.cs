using System;
using System.Collections;
using System.Collections.Generic;
using System.Runtime.CompilerServices;
using Boo.Lang;
using UnityEngine;

[Serializable]
public class DragRigidbody : MonoBehaviour
{
	[Serializable]
	[CompilerGenerated]
	internal sealed class _0024DragObject_002464 : GenericGenerator<object>
	{
		[Serializable]
		[CompilerGenerated]
		internal sealed class _0024 : GenericGeneratorEnumerator<object>, IEnumerator
		{
			internal float _0024oldDrag_002465;

			internal float _0024oldAngularDrag_002466;

			internal Camera _0024mainCamera_002467;

			internal Ray _0024ray_002468;

			internal float _0024distance_002469;

			internal DragRigidbody _0024self__002470;

			public _0024(float distance, DragRigidbody self_)
			{
				_0024distance_002469 = distance;
				_0024self__002470 = self_;
			}

			public override bool MoveNext()
			{
				int result;
				switch (_state)
				{
				default:
					_0024oldDrag_002465 = _0024self__002470.springJoint.connectedBody.drag;
					_0024oldAngularDrag_002466 = _0024self__002470.springJoint.connectedBody.angularDrag;
					_0024self__002470.springJoint.connectedBody.drag = _0024self__002470.drag;
					_0024self__002470.springJoint.connectedBody.angularDrag = _0024self__002470.angularDrag;
					_0024mainCamera_002467 = _0024self__002470.FindCamera();
					goto case 2;
				case 2:
					if (Input.GetMouseButton(0))
					{
						_0024ray_002468 = _0024mainCamera_002467.ScreenPointToRay(Input.mousePosition);
						_0024self__002470.springJoint.transform.position = _0024ray_002468.GetPoint(_0024distance_002469);
						result = (YieldDefault(2) ? 1 : 0);
						break;
					}
					if ((bool)_0024self__002470.springJoint.connectedBody)
					{
						_0024self__002470.springJoint.connectedBody.drag = _0024oldDrag_002465;
						_0024self__002470.springJoint.connectedBody.angularDrag = _0024oldAngularDrag_002466;
						_0024self__002470.springJoint.connectedBody = null;
					}
					YieldDefault(1);
					goto case 1;
				case 1:
					result = 0;
					break;
				}
				return (byte)result != 0;
			}
		}

		internal float _0024distance_002471;

		internal DragRigidbody _0024self__002472;

		public _0024DragObject_002464(float distance, DragRigidbody self_)
		{
			_0024distance_002471 = distance;
			_0024self__002472 = self_;
		}

		public override IEnumerator<object> GetEnumerator()
		{
			return new _0024(_0024distance_002471, _0024self__002472);
		}
	}

	public float spring;

	public float damper;

	public float drag;

	public float angularDrag;

	public float distance;

	public bool attachToCenterOfMass;

	private SpringJoint springJoint;

	public DragRigidbody()
	{
		spring = 50f;
		damper = 5f;
		drag = 10f;
		angularDrag = 5f;
		distance = 0.2f;
	}

	public virtual void Update()
	{
		if (!Input.GetMouseButtonDown(0))
		{
			return;
		}
		Camera camera = FindCamera();
		RaycastHit hitInfo = default(RaycastHit);
		if (Physics.Raycast(camera.ScreenPointToRay(Input.mousePosition), out hitInfo, 100f) && (bool)hitInfo.rigidbody && !hitInfo.rigidbody.isKinematic)
		{
			if (!springJoint)
			{
				GameObject gameObject = new GameObject("Rigidbody dragger");
				Rigidbody rigidbody = gameObject.AddComponent<Rigidbody>() as Rigidbody;
				springJoint = gameObject.AddComponent<SpringJoint>();
				rigidbody.isKinematic = true;
			}
			springJoint.transform.position = hitInfo.point;
			if (attachToCenterOfMass)
			{
				Vector3 position = transform.TransformDirection(hitInfo.rigidbody.centerOfMass) + hitInfo.rigidbody.transform.position;
				position = springJoint.transform.InverseTransformPoint(position);
				springJoint.anchor = position;
			}
			else
			{
				springJoint.anchor = Vector3.zero;
			}
			springJoint.spring = spring;
			springJoint.damper = damper;
			springJoint.maxDistance = distance;
			springJoint.connectedBody = hitInfo.rigidbody;
			StartCoroutine("DragObject", hitInfo.distance);
		}
	}

	public virtual IEnumerator DragObject(float distance)
	{
		return new _0024DragObject_002464(distance, this).GetEnumerator();
	}

	public virtual Camera FindCamera()
	{
		return (!GetComponent<Camera>()) ? Camera.main : GetComponent<Camera>();
	}

	public virtual void Main()
	{
	}
}
