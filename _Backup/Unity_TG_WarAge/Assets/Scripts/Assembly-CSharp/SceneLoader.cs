using System;
using System.Collections;
using Core.Resource;
using Core.Unity;
using LuaInterface;
using UnityEngine;
using UnityEngine.SceneManagement;

public class SceneLoader : MonoBehaviour
{
	private static string m_sceneName = string.Empty;

	private static string m_mainScenePath = string.Empty;

	private static string m_dataRecordPath = string.Empty;

	private static string m_shareAssetPath = string.Empty;

	private static bool m_isSceneDone = true;

	private static bool m_isShareAssetDone = true;

	private static bool m_isDataRecordDone = true;

	private static AssetBundle m_dataRecordBundle;

	private static AssetBundle m_sceneBundle;

	private static AssetBundle m_shareAssetBundle;

	private static SceneDataRecord m_sceneDataRecord;

	private static SceneLoader m_instance;

	public static bool IsCanLoad()
	{
		return (m_isSceneDone && m_isShareAssetDone && m_isDataRecordDone) ? true : false;
	}

	private string GetFileNameByPath(string path)
	{
		string result = string.Empty;
		if (path != null && path.Length > 0)
		{
			int num = path.LastIndexOf('.');
			int num2 = path.LastIndexOf('/');
			result = path.Substring(num2 + 1, num - num2 - 1);
		}
		return result;
	}

	private void ReleaseLastScene()
	{
		if (m_sceneBundle != null)
		{
			m_sceneBundle.Unload(true);
			m_sceneBundle = null;
			m_mainScenePath = string.Empty;
		}
		if (m_dataRecordBundle != null)
		{
			m_dataRecordBundle.Unload(true);
			m_dataRecordBundle = null;
			m_dataRecordPath = string.Empty;
		}
		if (m_shareAssetBundle != null)
		{
			m_shareAssetBundle.Unload(true);
			m_shareAssetBundle = null;
			m_shareAssetPath = string.Empty;
		}
		m_sceneName = string.Empty;
		m_sceneDataRecord = null;
		Resources.UnloadUnusedAssets();
		GC.Collect();
	}

	public void LoadScene(string datarecordPath, string mainscenePath, string shareassetPath)
	{
		if (IsCanLoad())
		{
			Core.Unity.Debug.Log(string.Format("[SceneLoader LoadScene] Start load scene: {0}, {1}, {2}", datarecordPath, mainscenePath, shareassetPath), Core.Unity.Debug.LogLevel.Important);
			ReleaseLastScene();
			m_sceneName = GetFileNameByPath(datarecordPath);
			m_mainScenePath = mainscenePath;
			m_isSceneDone = false;
			m_dataRecordPath = datarecordPath;
			if (shareassetPath.Length > 0 && FileUtil.FileExist(shareassetPath))
			{
				m_shareAssetPath = shareassetPath;
				if (m_shareAssetBundle == null)
				{
					m_isShareAssetDone = false;
				}
				m_isDataRecordDone = false;
				StartCoroutine(LoadSceneDataRecord());
			}
			else
			{
				StartCoroutine(LoadScenePlayer());
			}
		}
		else
		{
			Core.Unity.Debug.LogError(string.Format("[SceneLoader LoadScene] the last scene {0} is not complete, ignore this load {1}", m_sceneName, datarecordPath));
		}
	}

	private IEnumerator LoadScenePlayer()
	{
		string url = FileUtil.GetWWWReadPath(m_mainScenePath);
		WWW www = null;
		try
		{
			www = new WWW(url);
		}
		catch
		{
			Core.Unity.Debug.LogError("[SceneLoader LoadScenePlayer] Load main scene form " + m_mainScenePath + "failed!");
		}
		yield return www;
		if (www.isDone)
		{
			if (www.error != null)
			{
				Core.Unity.Debug.LogError("[SceneLoader LoadScenePlayer] Error: " + www.error);
			}
			else
			{
				m_sceneBundle = www.assetBundle;
				SceneManager5.GetInstance().OnBaseProgress(0.5f);
				yield return new WaitForEndOfFrame();
				SceneManager.LoadScene(m_sceneName);
				yield return new WaitForEndOfFrame();
				bool hasShareAsset = m_shareAssetBundle != null && m_dataRecordBundle != null && m_sceneDataRecord != null;
				OnSceneLoaded(hasShareAsset);
				SceneManager5.GetInstance().OnBaseProgress(1f);
			}
		}
		yield return null;
	}

	private void UnLoad()
	{
		NGUIText.bitmapFont = null;
		NGUIText.dynamicFont = null;
		UIPanel[] array = UnityEngine.Object.FindObjectsOfType<UIPanel>();
		for (int i = 0; i < array.Length; i++)
		{
			array[i].Refresh();
		}
		StartCoroutine(ClearScene());
	}

	private IEnumerator ClearScene()
	{
		yield return new WaitForEndOfFrame();
		Resources.UnloadUnusedAssets();
	}

	private IEnumerator LoadSceneDataRecord()
	{
		string url = FileUtil.GetWWWReadPath(m_dataRecordPath);
		WWW www = null;
		try
		{
			www = new WWW(url);
		}
		catch
		{
			Core.Unity.Debug.LogError("[SceneLoader LoadSceneDataRecord] Load SceneDataRecord form " + m_dataRecordPath + "failed!");
		}
		yield return www;
		if (www.isDone)
		{
			if (www.error != null)
			{
				Core.Unity.Debug.LogError("[SceneLoader LoadSceneDataRecord] Error: " + www.error);
			}
			else
			{
				OnDataRecordLoadComplete(www.assetBundle);
			}
		}
		yield return null;
	}

	private void SetMaterialTexture(Material _mat, int index)
	{
		string text = m_sceneDataRecord.texture_array[index];
		string text2 = m_sceneDataRecord.texture_propert[index];
		if (text.Length > 0)
		{
			string fileNameByPath = GetFileNameByPath(text);
			Texture texture = m_shareAssetBundle.LoadAsset(fileNameByPath, typeof(Texture)) as Texture;
			if (null == _mat)
			{
				int num = 123;
			}
			if (null == texture)
			{
				int num2 = 123;
			}
			if (texture != null)
			{
				_mat.SetTexture(text2, texture);
			}
		}
	}

	private void TravelRestoreSceneObject(Transform root, ref int mat_count_index, ref int shader_texcount_index, ref int texture_index, ref int mesh_index, ref int sound_index)
	{
		GameObject gameObject = root.gameObject;
		ParticleSystem component = gameObject.GetComponent<ParticleSystem>();
		MeshRenderer component2 = gameObject.GetComponent<MeshRenderer>();
		SkinnedMeshRenderer component3 = gameObject.GetComponent<SkinnedMeshRenderer>();
		if (component != null || component2 != null || component3 != null)
		{
			string text = m_sceneDataRecord.object_material_count[mat_count_index++];
			int num = text.IndexOf("PS_");
			if (num != -1 && component != null)
			{
				Renderer component4 = component.GetComponent<Renderer>();
				int num2 = System.Convert.ToInt32(text.Substring(num + 3, 1));
				int num3 = component4.sharedMaterials.Length;
				if (num3 != num2 && component4.sharedMaterials[component4.sharedMaterials.Length - 1] != null)
				{
					UnityEngine.Debug.LogWarning(string.Format("GameObject {0} ParticleSystem' Material count is {1} but rd is {2}", gameObject.name, num3, num2));
				}
				for (int i = 0; i < num2; i++)
				{
					if (shader_texcount_index == m_sceneDataRecord.shader_tex_property_count.Length)
					{
						UnityEngine.Debug.Log("PS Material count > index >>>" + gameObject.name);
					}
					int num4 = m_sceneDataRecord.shader_tex_property_count[shader_texcount_index++];
					Material material = component4.sharedMaterials[i];
					if (material == null)
					{
						UnityEngine.Debug.LogWarning(string.Format("{0}'s material is null", gameObject.name));
						texture_index += num4;
						continue;
					}
					for (int j = 0; j < num4; j++)
					{
						SetMaterialTexture(material, texture_index++);
					}
				}
			}
			int num5 = text.IndexOf("MR_");
			if (num5 != -1 && component2 != null)
			{
				Renderer component5 = component2.GetComponent<Renderer>();
				int num6 = System.Convert.ToInt32(text.Substring(num5 + 3, 1));
				int num7 = component5.sharedMaterials.Length;
				int num8 = System.Convert.ToInt32(num6) - num7;
				if (num7 != num6)
				{
					UnityEngine.Debug.LogWarning(string.Format("GameObject {0} MeshRender' Material count is {1} but rd is {2}", gameObject.name, num7, num6));
				}
				for (int k = 0; k < num6; k++)
				{
					if (shader_texcount_index == m_sceneDataRecord.shader_tex_property_count.Length)
					{
						UnityEngine.Debug.Log("MR Material count > index >>>" + gameObject.name);
					}
					int num9 = m_sceneDataRecord.shader_tex_property_count[shader_texcount_index++];
					Material material2 = component5.sharedMaterials[k];
					if (material2 == null)
					{
						UnityEngine.Debug.LogWarning(string.Format("{0}'s material is null", gameObject.name));
						texture_index += num9;
						continue;
					}
					for (int l = 0; l < num9; l++)
					{
						SetMaterialTexture(material2, texture_index++);
					}
				}
			}
			int num10 = text.IndexOf("SMR_");
			if (num10 != -1 && component3 != null)
			{
				int num11 = System.Convert.ToInt32(text.Substring(num10 + 4, 1));
				int num12 = component3.GetComponent<Renderer>().sharedMaterials.Length;
				if (num11 != num12)
				{
					UnityEngine.Debug.LogWarning(string.Format("GameObject {0} SkinnedMeshRender' Material count is {1} but rd is {2}", gameObject.name, num12, num11));
				}
				for (int m = 0; m < num11; m++)
				{
					if (shader_texcount_index == m_sceneDataRecord.shader_tex_property_count.Length)
					{
						UnityEngine.Debug.Log("SMR Material count > index >>>" + gameObject.name);
					}
					int num13 = m_sceneDataRecord.shader_tex_property_count[shader_texcount_index++];
					Material material3 = component3.GetComponent<Renderer>().sharedMaterials[m];
					if (material3 == null)
					{
						UnityEngine.Debug.Log(string.Format("{0}'s material is null", gameObject.name));
						texture_index += num13;
						continue;
					}
					for (int n = 0; n < num13; n++)
					{
						SetMaterialTexture(material3, texture_index++);
					}
				}
			}
		}
		MeshFilter component6 = gameObject.GetComponent<MeshFilter>();
		if (component6 != null)
		{
			string text2 = m_sceneDataRecord.mesh_array[mesh_index++];
			if (component6.sharedMesh == null && text2.Length > 0)
			{
				string fileNameByPath = GetFileNameByPath(text2);
				component6.sharedMesh = m_shareAssetBundle.LoadAsset(fileNameByPath, typeof(Mesh)) as Mesh;
			}
		}
		AudioSource component7 = gameObject.GetComponent<AudioSource>();
		if (component7 != null)
		{
			string text3 = m_sceneDataRecord.sound_array[sound_index++];
			if (component7.clip == null && text3.Length > 0)
			{
				string fileNameByPath2 = GetFileNameByPath(text3);
				component7.clip = m_shareAssetBundle.LoadAsset(fileNameByPath2, typeof(AudioClip)) as AudioClip;
			}
		}
		for (int num14 = 0; num14 < root.childCount; num14++)
		{
			Transform child = root.GetChild(num14);
			TravelRestoreSceneObject(child, ref mat_count_index, ref shader_texcount_index, ref texture_index, ref mesh_index, ref sound_index);
		}
	}

	private void OnSceneLoaded(bool isShareScene)
	{
		if (isShareScene)
		{
			int mat_count_index = 0;
			int shader_texcount_index = 0;
			int texture_index = 0;
			int mesh_index = 0;
			int sound_index = 0;
			for (int i = 0; i < m_sceneDataRecord.restor_sequence.Length; i++)
			{
				string text = m_sceneDataRecord.restor_sequence[i];
				GameObject gameObject = GameObject.Find(text);
				if (gameObject == null)
				{
					Core.Unity.Debug.LogError("[SceneLoader OnSceneLoaded] Scene: " + m_sceneName + " can not find ChildObject: " + text + " !");
					break;
				}
				GameObject gameObject2 = gameObject;
				TravelRestoreSceneObject(gameObject2.transform, ref mat_count_index, ref shader_texcount_index, ref texture_index, ref mesh_index, ref sound_index);
			}
		}
		m_isSceneDone = true;
		m_sceneBundle.Unload(false);
		if (isShareScene)
		{
			m_shareAssetBundle.Unload(false);
			m_dataRecordBundle.Unload(false);
		}
		SceneManager5.GetInstance().OnLevelBaseLoaded();
		SceneManager5.GetInstance().OnLevelDetailLoaded();
		int num = LuaVM.GetInstance().lua_gc(LuaGCOptions.LUA_GCCOUNT, 0);
		float num2 = (float)num / 1024f;
		Core.Unity.Debug.LogWarning(string.Format("当前Lua占用内存 {0} MB", num2));
	}

	private IEnumerator LoadSceneShareAsset()
	{
		string url = FileUtil.GetWWWReadPath(m_shareAssetPath);
		WWW www = null;
		try
		{
			www = new WWW(url);
		}
		catch
		{
			Core.Unity.Debug.LogError("[SceneLoader LoadSceneShareAsset] Load share asset form " + m_shareAssetPath + "failed!");
		}
		yield return www;
		if (www.isDone)
		{
			if (www.error != null)
			{
				Core.Unity.Debug.LogError("[SceneLoader LoadSceneShareAsset] Error: " + www.error);
			}
			else
			{
				m_shareAssetBundle = www.assetBundle;
			}
			m_isShareAssetDone = true;
			StartCoroutine(LoadScenePlayer());
		}
		yield return null;
	}

	private void OnDataRecordLoadComplete(AssetBundle recordbundle)
	{
		m_isDataRecordDone = true;
		m_dataRecordBundle = recordbundle;
		m_sceneDataRecord = recordbundle.LoadAsset(m_sceneName, typeof(SceneDataRecord)) as SceneDataRecord;
		if (m_sceneDataRecord == null)
		{
			Core.Unity.Debug.LogError(string.Format("[SceneLoader OnDataRecordLoadComplete] SceneDataRecord is null"));
		}
		if (m_shareAssetBundle == null)
		{
			StartCoroutine(LoadSceneShareAsset());
		}
		else
		{
			StartCoroutine(LoadScenePlayer());
		}
	}

	public static SceneLoader Init(GameObject go)
	{
		if (m_instance == null && go != null)
		{
			m_instance = go.AddComponent<SceneLoader>();
			UnityEngine.Object.DontDestroyOnLoad(go);
			UnityEngine.Object.DontDestroyOnLoad(m_instance.gameObject);
		}
		return m_instance;
	}

	public static SceneLoader GetInstance()
	{
		return m_instance;
	}

	public void OnApplicationQuit()
	{
		ReleaseLastScene();
	}
}
