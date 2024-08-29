using System.Collections;
using Core.Scene;
using UnityEngine;

public class FS_ShadowManager : MonoBehaviour
{
	private static FS_ShadowManager _manager;

	private Hashtable shadowMeshes = new Hashtable();

	private Hashtable shadowMeshesStatic = new Hashtable();

	private int frameCalcedFustrum;

	private Plane[] fustrumPlanes;

	private void Start()
	{
		FS_ShadowManager[] array = (FS_ShadowManager[])Object.FindObjectsOfType(typeof(FS_ShadowManager));
		if (array.Length > 1)
		{
			Debug.LogWarning("There should only be one FS_ShadowManger in the scene. Found " + array.Length);
		}
	}

	private void OnApplicationQuit()
	{
		shadowMeshes.Clear();
		shadowMeshesStatic.Clear();
	}

	public static FS_ShadowManager Manager()
	{
		if (_manager == null)
		{
			FS_ShadowManager fS_ShadowManager = (FS_ShadowManager)Object.FindObjectOfType(typeof(FS_ShadowManager));
			if (fS_ShadowManager == null)
			{
				GameObject gameObject = new GameObject("FS_ShadowManager");
				_manager = gameObject.AddComponent<FS_ShadowManager>();
				if (gameObject.GetComponent<ComponentDontDestroy>() == null)
				{
					gameObject.AddComponent<ComponentDontDestroy>();
				}
			}
			else
			{
				_manager = fS_ShadowManager;
			}
		}
		return _manager;
	}

	public void registerGeometry(FS_ShadowSimple s, FS_MeshKey meshKey)
	{
		FS_ShadowManagerMesh fS_ShadowManagerMesh;
		if (meshKey.isStatic)
		{
			if (!shadowMeshesStatic.ContainsKey(meshKey))
			{
				GameObject gameObject = new GameObject("ShadowMeshStatic_" + meshKey.mat.name);
				gameObject.transform.parent = base.transform;
				fS_ShadowManagerMesh = gameObject.AddComponent<FS_ShadowManagerMesh>();
				fS_ShadowManagerMesh.shadowMaterial = s.shadowMaterial;
				fS_ShadowManagerMesh.isStatic = true;
				shadowMeshesStatic.Add(meshKey, fS_ShadowManagerMesh);
			}
			else
			{
				fS_ShadowManagerMesh = (FS_ShadowManagerMesh)shadowMeshesStatic[meshKey];
			}
		}
		else if (!shadowMeshes.ContainsKey(meshKey))
		{
			GameObject gameObject2 = new GameObject("ShadowMesh_" + meshKey.mat.name);
			gameObject2.transform.parent = base.transform;
			fS_ShadowManagerMesh = gameObject2.AddComponent<FS_ShadowManagerMesh>();
			fS_ShadowManagerMesh.shadowMaterial = s.shadowMaterial;
			fS_ShadowManagerMesh.isStatic = false;
			shadowMeshes.Add(meshKey, fS_ShadowManagerMesh);
		}
		else
		{
			fS_ShadowManagerMesh = (FS_ShadowManagerMesh)shadowMeshes[meshKey];
		}
		fS_ShadowManagerMesh.registerGeometry(s);
	}

	public Plane[] getCameraFustrumPlanes()
	{
		if (Time.frameCount != frameCalcedFustrum || fustrumPlanes == null)
		{
			Camera main = Camera.main;
			if (main == null)
			{
				Debug.LogWarning("No main camera could be found for visibility culling.");
				fustrumPlanes = null;
			}
			else
			{
				fustrumPlanes = GeometryUtility.CalculateFrustumPlanes(main);
				frameCalcedFustrum = Time.frameCount;
			}
		}
		return fustrumPlanes;
	}
}
