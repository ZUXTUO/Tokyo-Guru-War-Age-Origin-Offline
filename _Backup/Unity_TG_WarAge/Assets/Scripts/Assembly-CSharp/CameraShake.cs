using System;
using System.Collections;
using System.Collections.Generic;
using UnityEngine;

[AddComponentMenu("Utilities/Camera Shake")]
public class CameraShake : MonoBehaviour
{
	internal class ShakeState
	{
		internal readonly Vector3 startPosition;

		internal readonly Quaternion startRotation;

		internal readonly Vector2 guiStartPosition;

		internal Vector3 shakePosition;

		internal Quaternion shakeRotation;

		internal Vector2 guiShakePosition;

		internal ShakeState(Vector3 position, Quaternion rotation, Vector2 guiPosition)
		{
			startPosition = position;
			startRotation = rotation;
			guiStartPosition = guiPosition;
			shakePosition = position;
			shakeRotation = rotation;
			guiShakePosition = guiPosition;
		}
	}

	public List<Camera> cameras = new List<Camera>();

	public int numberOfShakes = 2;

	public Vector3 shakeAmount = Vector3.one;

	public Vector3 rotationAmount = Vector3.zero;

	public float distance = 0.1f;

	public float speed = 50f;

	public float decay = 0.2f;

	public float guiShakeModifier = 1f;

	public bool multiplyByTimeScale = true;

	private Rect shakeRect;

	private bool shaking;

	private bool cancelling;

	private Dictionary<Camera, List<ShakeState>> states = new Dictionary<Camera, List<ShakeState>>();

	private Dictionary<Camera, int> shakeCount = new Dictionary<Camera, int>();

	private const bool checkForMinimumValues = true;

	private const float minShakeValue = 0.001f;

	private const float minRotationValue = 0.001f;

	public static CameraShake instance;

	private List<Vector3> offsetCache = new List<Vector3>(10);

	private List<Quaternion> rotationCache = new List<Quaternion>(10);

	public static bool isShaking
	{
		get
		{
			return instance.IsShaking();
		}
	}

	public static bool isCancelling
	{
		get
		{
			return instance.IsCancelling();
		}
	}

	public event Action cameraShakeStarted;

	public event Action allCameraShakesCompleted;

	private void OnEnable()
	{
		if (cameras.Count < 1 && (bool)GetComponent<Camera>())
		{
			cameras.Add(GetComponent<Camera>());
		}
		if (cameras.Count < 1 && (bool)Camera.main)
		{
			cameras.Add(Camera.main);
		}
		if (cameras.Count < 1)
		{
			Debug.LogError("Camera Shake: No cameras assigned in the inspector!");
		}
		instance = this;
	}

	public static void Shake()
	{
		instance.DoShake();
	}

	public static void Shake(int numberOfShakes, Vector3 shakeAmount, Vector3 rotationAmount, float distance, float speed, float decay, float guiShakeModifier, bool multiplyByTimeScale)
	{
		instance.DoShake(numberOfShakes, shakeAmount, rotationAmount, distance, speed, decay, guiShakeModifier, multiplyByTimeScale);
	}

	public static void Shake(Action callback)
	{
		instance.DoShake(callback);
	}

	public static void Shake(int numberOfShakes, Vector3 shakeAmount, Vector3 rotationAmount, float distance, float speed, float decay, float guiShakeModifier, bool multiplyByTimeScale, Action callback)
	{
		instance.DoShake(numberOfShakes, shakeAmount, rotationAmount, distance, speed, decay, guiShakeModifier, multiplyByTimeScale, callback);
	}

	public static void CancelShake()
	{
		instance.DoCancelShake();
	}

	public static void CancelShake(float time)
	{
		instance.DoCancelShake(time);
	}

	public static void BeginShakeGUI()
	{
		instance.DoBeginShakeGUI();
	}

	public static void EndShakeGUI()
	{
		instance.DoEndShakeGUI();
	}

	public static void BeginShakeGUILayout()
	{
		instance.DoBeginShakeGUILayout();
	}

	public static void EndShakeGUILayout()
	{
		instance.DoEndShakeGUILayout();
	}

	public bool IsShaking()
	{
		return shaking;
	}

	public bool IsCancelling()
	{
		return cancelling;
	}

	public void DoShake()
	{
		Vector3 insideUnitSphere = UnityEngine.Random.insideUnitSphere;
		foreach (Camera camera in cameras)
		{
			StartCoroutine(DoShake_Internal(camera, insideUnitSphere, numberOfShakes, shakeAmount, rotationAmount, distance, speed, decay, guiShakeModifier, multiplyByTimeScale, null));
		}
	}

	public void DoShake(int numberOfShakes, Vector3 shakeAmount, Vector3 rotationAmount, float distance, float speed, float decay, float guiShakeModifier, bool multiplyByTimeScale)
	{
		Vector3 insideUnitSphere = UnityEngine.Random.insideUnitSphere;
		foreach (Camera camera in cameras)
		{
			StartCoroutine(DoShake_Internal(camera, insideUnitSphere, numberOfShakes, shakeAmount, rotationAmount, distance, speed, decay, guiShakeModifier, multiplyByTimeScale, null));
		}
	}

	public void DoShake(int numberOfShakes, Vector3 shakeAmount, Vector3 rotationAmount, float distance, float speed, float decay, bool multiplyByTimeScale)
	{
		Vector3 insideUnitSphere = UnityEngine.Random.insideUnitSphere;
		foreach (Camera camera in cameras)
		{
			StartCoroutine(DoShake_Internal(camera, insideUnitSphere, numberOfShakes, shakeAmount, rotationAmount, distance, speed, decay, guiShakeModifier, multiplyByTimeScale, null));
		}
	}

	public void DoShake(Action callback)
	{
		Vector3 insideUnitSphere = UnityEngine.Random.insideUnitSphere;
		foreach (Camera camera in cameras)
		{
			StartCoroutine(DoShake_Internal(camera, insideUnitSphere, numberOfShakes, shakeAmount, rotationAmount, distance, speed, decay, guiShakeModifier, multiplyByTimeScale, callback));
		}
	}

	public void DoShake(int numberOfShakes, Vector3 shakeAmount, Vector3 rotationAmount, float distance, float speed, float decay, float guiShakeModifier, bool multiplyByTimeScale, Action callback)
	{
		Vector3 insideUnitSphere = UnityEngine.Random.insideUnitSphere;
		foreach (Camera camera in cameras)
		{
			StartCoroutine(DoShake_Internal(camera, insideUnitSphere, numberOfShakes, shakeAmount, rotationAmount, distance, speed, decay, guiShakeModifier, multiplyByTimeScale, callback));
		}
	}

	public void DoCancelShake()
	{
		if (!shaking || cancelling)
		{
			return;
		}
		shaking = false;
		StopAllCoroutines();
		foreach (Camera camera in cameras)
		{
			if (shakeCount.ContainsKey(camera))
			{
				shakeCount[camera] = 0;
			}
			ResetState(camera.transform, camera);
		}
	}

	public void DoCancelShake(float time)
	{
		if (shaking && !cancelling)
		{
			StopAllCoroutines();
			StartCoroutine(DoResetState(cameras, shakeCount, time));
		}
	}

	public void DoBeginShakeGUI()
	{
		CheckShakeRect();
		GUI.BeginGroup(shakeRect);
	}

	public void DoEndShakeGUI()
	{
		GUI.EndGroup();
	}

	public void DoBeginShakeGUILayout()
	{
		CheckShakeRect();
		GUILayout.BeginArea(shakeRect);
	}

	public void DoEndShakeGUILayout()
	{
		GUILayout.EndArea();
	}

	private void OnDrawGizmosSelected()
	{
		foreach (Camera camera in cameras)
		{
			if ((bool)camera)
			{
				if (IsShaking())
				{
					Vector3 position = camera.worldToCameraMatrix.GetColumn(3);
					position.z *= -1f;
					position = camera.transform.position + camera.transform.TransformPoint(position);
					Quaternion q = QuaternionFromMatrix(camera.worldToCameraMatrix.inverse * Matrix4x4.TRS(Vector3.zero, Quaternion.identity, new Vector3(1f, 1f, -1f)));
					Matrix4x4 matrix = Matrix4x4.TRS(position, q, camera.transform.lossyScale);
					Gizmos.matrix = matrix;
				}
				else
				{
					Matrix4x4 matrix2 = Matrix4x4.TRS(camera.transform.position, camera.transform.rotation, camera.transform.lossyScale);
					Gizmos.matrix = matrix2;
				}
				Gizmos.DrawWireCube(Vector3.zero, shakeAmount);
				Gizmos.color = Color.cyan;
				if (camera.orthographic)
				{
					Vector3 center = new Vector3(0f, 0f, (camera.near + camera.far) / 2f);
					Vector3 size = new Vector3(camera.orthographicSize / camera.aspect, camera.orthographicSize * 2f, camera.far - camera.near);
					Gizmos.DrawWireCube(center, size);
				}
				else
				{
					Gizmos.DrawFrustum(Vector3.zero, camera.fov, camera.far, camera.near, 0.7f / camera.aspect);
				}
			}
		}
	}

	private IEnumerator DoShake_Internal(Camera cam, Vector3 seed, int numberOfShakes, Vector3 shakeAmount, Vector3 rotationAmount, float distance, float speed, float decay, float guiShakeModifier, bool multiplyByTimeScale, Action callback)
	{
		if (cancelling)
		{
			yield return null;
		}
		int mod1 = ((seed.x > 0.5f) ? 1 : (-1));
		int mod2 = ((seed.y > 0.5f) ? 1 : (-1));
		int mod3 = ((seed.z > 0.5f) ? 1 : (-1));
		if (!shaking)
		{
			shaking = true;
			if (this.cameraShakeStarted != null)
			{
				this.cameraShakeStarted();
			}
		}
		if (shakeCount.ContainsKey(cam))
		{
			shakeCount[cam]++;
		}
		else
		{
			shakeCount.Add(cam, 1);
		}
		float pixelWidth = GetPixelWidth(cameras[0].transform, cameras[0]);
		Transform cachedTransform = cam.transform;
		Vector3 camOffset = Vector3.zero;
		Quaternion camRot = Quaternion.identity;
		int currentShakes = numberOfShakes;
		float shakeDistance = distance;
		float rotationStrength = 1f;
		float startTime = Time.time;
		float scale = ((!multiplyByTimeScale) ? 1f : Time.timeScale);
		float pixelScale = pixelWidth * guiShakeModifier * scale;
		Vector3 start1 = Vector2.zero;
		Quaternion startR = Quaternion.identity;
		Vector2 start2 = Vector2.zero;
		ShakeState state = new ShakeState(cachedTransform.position, cachedTransform.rotation, new Vector2(shakeRect.x, shakeRect.y));
		List<ShakeState> stateList;
		if (states.TryGetValue(cam, out stateList))
		{
			stateList.Add(state);
		}
		else
		{
			stateList = new List<ShakeState> { state };
			states.Add(cam, stateList);
		}
		while (currentShakes > 0 && (rotationAmount.sqrMagnitude == 0f || !(rotationStrength <= 0.001f)) && (shakeAmount.sqrMagnitude == 0f || distance == 0f || !(shakeDistance <= 0.001f)))
		{
			float timer = (Time.time - startTime) * speed;
			state.shakePosition = start1 + new Vector3((float)mod1 * Mathf.Sin(timer) * (shakeAmount.x * shakeDistance * scale), (float)mod2 * Mathf.Cos(timer) * (shakeAmount.y * shakeDistance * scale), (float)mod3 * Mathf.Sin(timer) * (shakeAmount.z * shakeDistance * scale));
			state.guiShakePosition = new Vector2(start2.x - (float)mod1 * Mathf.Sin(timer) * (shakeAmount.x * shakeDistance * pixelScale), start2.y - (float)mod2 * Mathf.Cos(timer) * (shakeAmount.y * shakeDistance * pixelScale));
			camOffset = GetGeometricAvg(stateList, true);
			Matrix4x4 i = Matrix4x4.TRS(camOffset, camRot, new Vector3(1f, 1f, -1f));
			if ((bool)cam.transform.parent && cam.transform.parent.GetComponent<UIRoot>() != null)
			{
				cam.worldToCameraMatrix = i;
			}
			else
			{
				cam.worldToCameraMatrix = i * cachedTransform.worldToLocalMatrix;
			}
			Vector3 avg = GetGeometricAvg(stateList, false);
			shakeRect.x = avg.x;
			shakeRect.y = avg.y;
			if (timer > (float)Math.PI * 2f)
			{
				startTime = Time.time;
				shakeDistance *= 1f - Mathf.Clamp01(decay);
				rotationStrength *= 1f - Mathf.Clamp01(decay);
				currentShakes--;
			}
			yield return null;
		}
		shakeCount[cam]--;
		if (shakeCount[cam] == 0)
		{
			shaking = false;
			ResetState(cam.transform, cam);
			if (this.allCameraShakesCompleted != null)
			{
				this.allCameraShakesCompleted();
			}
		}
		else
		{
			stateList.Remove(state);
		}
		if (callback != null)
		{
			callback();
		}
	}

	private Vector3 GetGeometricAvg(List<ShakeState> states, bool position)
	{
		float num = 0f;
		float num2 = 0f;
		float num3 = 0f;
		float num4 = states.Count;
		foreach (ShakeState state in states)
		{
			if (position)
			{
				num -= state.shakePosition.x;
				num2 -= state.shakePosition.y;
				num3 -= state.shakePosition.z;
			}
			else
			{
				num += state.guiShakePosition.x;
				num2 += state.guiShakePosition.y;
			}
		}
		return new Vector3(num / num4, num2 / num4, num3 / num4);
	}

	private Quaternion GetAvgRotation(List<ShakeState> states)
	{
		Quaternion quaternion = new Quaternion(0f, 0f, 0f, 0f);
		foreach (ShakeState state in states)
		{
			if (Quaternion.Dot(state.shakeRotation, quaternion) > 0f)
			{
				quaternion.x += state.shakeRotation.x;
				quaternion.y += state.shakeRotation.y;
				quaternion.z += state.shakeRotation.z;
				quaternion.w += state.shakeRotation.w;
			}
			else
			{
				quaternion.x += 0f - state.shakeRotation.x;
				quaternion.y += 0f - state.shakeRotation.y;
				quaternion.z += 0f - state.shakeRotation.z;
				quaternion.w += 0f - state.shakeRotation.w;
			}
		}
		float num = Mathf.Sqrt(quaternion.x * quaternion.x + quaternion.y * quaternion.y + quaternion.z * quaternion.z + quaternion.w * quaternion.w);
		if (num > 0.0001f)
		{
			quaternion.x /= num;
			quaternion.y /= num;
			quaternion.z /= num;
			quaternion.w /= num;
			return quaternion;
		}
		return states[0].shakeRotation;
	}

	private void CheckShakeRect()
	{
		if ((float)Screen.width != shakeRect.width || (float)Screen.height != shakeRect.height)
		{
			shakeRect.width = Screen.width;
			shakeRect.height = Screen.height;
		}
	}

	private float GetPixelWidth(Transform cachedTransform, Camera cachedCamera)
	{
		Vector3 position = cachedTransform.position;
		Vector3 vector = cachedCamera.WorldToScreenPoint(position - cachedTransform.forward * 0.01f);
		Vector3 zero = Vector3.zero;
		if (vector.x > 0f)
		{
			zero = vector - Vector3.right;
		}
		else
		{
			zero = vector + Vector3.right;
		}
		zero = ((!(vector.y > 0f)) ? (vector + Vector3.up) : (vector - Vector3.up));
		zero = cachedCamera.ScreenToWorldPoint(zero);
		return 1f / (cachedTransform.InverseTransformPoint(position) - cachedTransform.InverseTransformPoint(zero)).magnitude;
	}

	private void ResetState(Transform cachedTransform, Camera cam)
	{
		cam.ResetWorldToCameraMatrix();
		shakeRect.x = 0f;
		shakeRect.y = 0f;
		states[cam].Clear();
	}

	private IEnumerator DoResetState(List<Camera> cameras, Dictionary<Camera, int> shakeCount, float time)
	{
		offsetCache.Clear();
		rotationCache.Clear();
		foreach (Camera camera in cameras)
		{
			offsetCache.Add((camera.worldToCameraMatrix * camera.transform.worldToLocalMatrix.inverse).GetColumn(3));
			rotationCache.Add(QuaternionFromMatrix((camera.worldToCameraMatrix * camera.transform.worldToLocalMatrix.inverse).inverse * Matrix4x4.TRS(Vector3.zero, Quaternion.identity, new Vector3(1f, 1f, -1f))));
			if (shakeCount.ContainsKey(camera))
			{
				shakeCount[camera] = 0;
			}
			states[camera].Clear();
		}
		float t = 0f;
		float x = shakeRect.x;
		float y = shakeRect.y;
		cancelling = true;
		while (t < time)
		{
			int i = 0;
			foreach (Camera camera2 in cameras)
			{
				Transform transform = camera2.transform;
				shakeRect.x = Mathf.Lerp(x, 0f, t / time);
				shakeRect.y = Mathf.Lerp(y, 0f, t / time);
				Vector3 pos = Vector3.Lerp(offsetCache[i], Vector3.zero, t / time);
				Quaternion q = Quaternion.Slerp(rotationCache[i], transform.rotation, t / time);
				Matrix4x4 matrix4x = Matrix4x4.TRS(pos, q, new Vector3(1f, 1f, -1f));
				camera2.worldToCameraMatrix = matrix4x * transform.worldToLocalMatrix;
				i++;
			}
			t += Time.deltaTime;
			yield return null;
		}
		foreach (Camera camera3 in cameras)
		{
			camera3.ResetWorldToCameraMatrix();
			shakeRect.x = 0f;
			shakeRect.y = 0f;
		}
		shaking = false;
		cancelling = false;
	}

	private static Quaternion QuaternionFromMatrix(Matrix4x4 m)
	{
		return Quaternion.LookRotation(m.GetColumn(2), m.GetColumn(1));
	}

	private static void NormalizeQuaternion(ref Quaternion q)
	{
		float num = 0f;
		for (int i = 0; i < 4; i++)
		{
			num += q[i] * q[i];
		}
		float num2 = 1f / Mathf.Sqrt(num);
		for (int j = 0; j < 4; j++)
		{
			q[j] *= num2;
		}
	}
}
