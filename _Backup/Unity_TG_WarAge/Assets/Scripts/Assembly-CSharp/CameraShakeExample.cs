using System.Collections;
using UnityEngine;

[AddComponentMenu("")]
public class CameraShakeExample : MonoBehaviour
{
	private CameraShake shake;

	private bool shakeGUI;

	private bool shake1;

	private bool shake2;

	private bool multiShake;

	private void Start()
	{
		shake = CameraShake.instance;
	}

	private void OnGUI()
	{
		if ((bool)shake)
		{
			DrawGUIArea1();
			DrawGUIArea2();
		}
	}

	private void DrawGUIArea1()
	{
		GUI.enabled = (CameraShake.isShaking || multiShake) && !CameraShake.isCancelling;
		GUILayout.Space(10f);
		GUILayout.BeginHorizontal();
		GUILayout.Space(10f);
		if (GUILayout.Button("Cancel Shake"))
		{
			StopAllCoroutines();
			CameraShake.CancelShake(0.5f);
			shake1 = false;
			shake2 = false;
			multiShake = false;
		}
		GUILayout.EndHorizontal();
		GUI.enabled = true;
	}

	private void DrawGUIArea2()
	{
		if (shakeGUI)
		{
			CameraShake.BeginShakeGUILayout();
		}
		else
		{
			GUILayout.BeginArea(new Rect(0f, 0f, Screen.width, Screen.height));
		}
		GUILayout.BeginVertical();
		GUILayout.FlexibleSpace();
		GUILayout.Space(100f);
		GUILayout.BeginHorizontal();
		GUILayout.FlexibleSpace();
		GUI.enabled = !CameraShake.isShaking && !multiShake;
		shake1 = GUILayout.Toggle(shake1, "Shake (without GUI)", GUI.skin.button, GUILayout.Width(200f), GUILayout.Height(50f));
		shake2 = GUILayout.Toggle(shake2, "Shake (with GUI)", GUI.skin.button, GUILayout.Width(200f), GUILayout.Height(50f));
		GUILayout.FlexibleSpace();
		GUILayout.EndHorizontal();
		GUILayout.BeginHorizontal();
		GUILayout.FlexibleSpace();
		GUILayout.BeginVertical(GUILayout.Width(300f));
		GUILayout.Label("Number of Shakes: " + shake.numberOfShakes);
		shake.numberOfShakes = (int)GUILayout.HorizontalSlider(shake.numberOfShakes, 1f, 10f);
		GUILayout.Label("Shake Amount: " + shake.shakeAmount.ToString());
		float num = GUILayout.HorizontalSlider(shake.shakeAmount.x, 0f, 10f);
		float num2 = GUILayout.HorizontalSlider(shake.shakeAmount.y, 0f, 10f);
		float num3 = GUILayout.HorizontalSlider(shake.shakeAmount.z, 0f, 10f);
		if (num != shake.shakeAmount.x || num2 != shake.shakeAmount.y || num3 != shake.shakeAmount.z)
		{
			shake.shakeAmount = new Vector3(num, num2, num3);
		}
		GUILayout.Label("Distance: " + shake.distance.ToString("0.00"));
		shake.distance = GUILayout.HorizontalSlider(shake.distance, 0f, 0.1f);
		GUILayout.Label("Speed: " + shake.speed.ToString("0.00"));
		shake.speed = GUILayout.HorizontalSlider(shake.speed, 1f, 100f);
		GUILayout.Label("Decay: " + shake.decay.ToString("0.00%"));
		shake.decay = GUILayout.HorizontalSlider(shake.decay, 0f, 1f);
		GUILayout.Space(5f);
		GUILayout.Label("Presets:");
		GUILayout.BeginHorizontal();
		if (GUILayout.Button("Explosion"))
		{
			Explosion();
		}
		if (GUILayout.Button("Footsteps"))
		{
			Footsteps();
		}
		if (GUILayout.Button("Bumpy"))
		{
			Bumpy();
		}
		GUILayout.EndHorizontal();
		if (GUILayout.Button("Reset"))
		{
			Application.LoadLevel(Application.loadedLevel);
		}
		GUILayout.EndVertical();
		GUILayout.FlexibleSpace();
		GUILayout.EndHorizontal();
		GUILayout.FlexibleSpace();
		GUILayout.EndVertical();
		GUI.enabled = true;
		if (shakeGUI)
		{
			CameraShake.EndShakeGUILayout();
		}
		else
		{
			GUILayout.EndArea();
		}
	}

	private void Update()
	{
		if (shake1)
		{
			shakeGUI = false;
			shake1 = false;
			CameraShake.Shake();
		}
		else if (shake2)
		{
			shakeGUI = true;
			shake2 = false;
			CameraShake.Shake();
		}
	}

	private void Explosion()
	{
		multiShake = true;
		shakeGUI = true;
		CameraShake.Shake(rotationAmount: new Vector3(2f, 0.5f, 10f), numberOfShakes: 5, shakeAmount: Vector3.one, distance: 0.25f, speed: 50f, decay: 0.2f, guiShakeModifier: 1f, multiplyByTimeScale: true, callback: delegate
		{
			multiShake = false;
		});
	}

	private void Footsteps()
	{
		shakeGUI = true;
		multiShake = true;
		StartCoroutine(DoFootsteps());
	}

	private IEnumerator DoFootsteps()
	{
		Vector3 rot = new Vector3(2f, 0.5f, 1f);
		CameraShake.Shake(3, Vector3.one, rot, 0.02f, 50f, 0.5f, 1f, true, null);
		yield return new WaitForSeconds(1f);
		CameraShake.Shake(3, Vector3.one, rot, 0.03f, 50f, 0.5f, 1f, true, null);
		yield return new WaitForSeconds(1f);
		CameraShake.Shake(3, Vector3.one, rot * 1.5f, 0.04f, 50f, 0.5f, 1f, true, null);
		yield return new WaitForSeconds(1f);
		CameraShake.Shake(3, Vector3.one, rot * 2f, 0.05f, 50f, 0.5f, 1f, true, null);
		yield return new WaitForSeconds(1f);
		CameraShake.Shake(3, Vector3.one, rot * 2.5f, 0.06f, 50f, 0.5f, 1f, true, delegate
		{
			multiShake = false;
		});
	}

	private void Bumpy()
	{
		shakeGUI = true;
		multiShake = true;
		StartCoroutine(DoBumpy());
		StartCoroutine(DoBumpy2());
	}

	private IEnumerator DoBumpy()
	{
		Vector3 rot = new Vector3(2f, 2f, 2f);
		for (int i = 0; i < 50; i++)
		{
			CameraShake.Shake(3, Vector3.one, rot, 0.02f, 50f, 0f, 1f, true, null);
			yield return new WaitForSeconds(0.1f);
		}
		CameraShake.Shake(3, Vector3.one, Vector3.one, 0.02f, 50f, 0f, 1f, true, delegate
		{
			multiShake = false;
		});
	}

	private IEnumerator DoBumpy2()
	{
		Vector3 rot = new Vector3(8f, 1f, 4f);
		for (int i = 0; i < 5; i++)
		{
			yield return new WaitForSeconds(1f);
			CameraShake.Shake(10, Vector3.up, rot, 0.5f, 50f, 0.2f, 1f, true, null);
		}
	}
}
