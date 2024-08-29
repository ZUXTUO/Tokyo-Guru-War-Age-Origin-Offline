using UnityEngine;

public class CameraPathEvent : CameraPathPoint
{
	public enum Types
	{
		Broadcast = 0,
		Call = 1
	}

	public enum ArgumentTypes
	{
		None = 0,
		Float = 1,
		Int = 2,
		String = 3
	}

	public Types type;

	public string eventName = "Camera Path Event";

	public GameObject target;

	public string methodName;

	public string methodArgument;

	public ArgumentTypes argumentType;
}
