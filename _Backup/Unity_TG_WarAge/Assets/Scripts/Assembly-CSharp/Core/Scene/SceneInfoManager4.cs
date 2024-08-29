using System;
using System.Collections;
using System.Collections.Generic;
using System.IO;
using Core.Resource;
using UnityEngine;

namespace Core.Scene
{
	public class SceneInfoManager4 : MonoBehaviour, SceneResourceCallback4
	{
		private LevelHandlerVoid OnBaseLoaded;

		private LevelHandlerVoid OnDetailLoaded;

		private LevelHandlerFloat OnBaseProgress;

		private LevelHandlerFloat OnDetailProgress;

		private bool isAsyncMainAsset = true;

		private AssetBundle mainAssetLevel;

		private List<ComponentSceneItem4> activeCmps = new List<ComponentSceneItem4>();

		private SceneInfo4 _sceneInfo;

		private static SceneInfoManager4 _instance;

		public SceneInfo4 SceneInfo
		{
			get
			{
				return _sceneInfo;
			}
		}

		public void Clear()
		{
			ScenePrintUtil.Log("SceneInfoManager.Clear");
			_sceneInfo = null;
			OnBaseLoaded = null;
			OnDetailLoaded = null;
			OnBaseProgress = null;
			OnDetailProgress = null;
			if (mainAssetLevel != null)
			{
				mainAssetLevel.Unload(false);
				mainAssetLevel = null;
			}
			activeCmps.Clear();
		}

		public bool StartSceneByPath(string path)
		{
			_sceneInfo = null;
			if (ResourceManager4.FileExists(path))
			{
				byte[] buffer = ResourceManager.GetInstance().LoadResourceByWWW(path);
				MemoryStream memoryStream = new MemoryStream(buffer);
				BinaryReader binaryReader = new BinaryReader(memoryStream);
				if (binaryReader != null)
				{
					try
					{
						SceneInfo4 sceneInfo = new SceneInfo4();
						sceneInfo.unserial(binaryReader);
						_sceneInfo = sceneInfo;
						return true;
					}
					catch (Exception ex)
					{
						ScenePrintUtil.Log("[exception] : " + ex);
						return false;
					}
					finally
					{
						binaryReader.Close();
						memoryStream.Close();
					}
				}
				ScenePrintUtil.Log("create binary reader failed: {0}", path);
			}
			else
			{
				ScenePrintUtil.Log("file not exist: {0}", path);
			}
			return false;
		}

		public bool StartLoadMainAsset(string path, LevelHandlerVoid baseLoaded, LevelHandlerVoid detailLoaded, LevelHandlerFloat baseProgress, LevelHandlerFloat detaIlProgress, bool isAsyncMainAsset)
		{
			ScenePrintUtil.Log("StartLoadMainAsset: " + path);
			Clear();
			if (StartSceneByPath(path) && _sceneInfo != null && ResourceManager4.FileExists(_sceneInfo.mainAsset))
			{
				OnBaseLoaded = baseLoaded;
				OnDetailLoaded = detailLoaded;
				OnBaseProgress = baseProgress;
				OnDetailProgress = detaIlProgress;
				this.isAsyncMainAsset = isAsyncMainAsset;
				SceneResourceManager4.GetInstance().OnTasksComplete = OnTasksComplete;
				SceneResourceManager4.GetInstance().OnTasksProgress = OnTasksProgress;
				StartCoroutine(LoadMainAsset());
				return true;
			}
			ScenePrintUtil.Log("StartLoadMainAsset failed");
			if (_sceneInfo != null)
			{
			}
			return false;
		}

		public void OnTasksComplete()
		{
			SceneResourceManager4.GetInstance().OnTasksComplete = null;
			SceneResourceManager4.GetInstance().OnTasksProgress = null;
			if (OnDetailLoaded != null)
			{
				OnDetailLoaded();
			}
			ScenePrintUtil.Log("this.activeCmps.Count:{0}", activeCmps.Count);
			if (activeCmps.Count > 0)
			{
				for (int i = 0; i < activeCmps.Count; i++)
				{
					ComponentSceneItem4 componentSceneItem = activeCmps[i];
					componentSceneItem.ActiveVisible(-1);
				}
				activeCmps.Clear();
			}
		}

		public void OnTasksProgress(float val)
		{
			if (OnDetailProgress != null)
			{
				OnDetailProgress(val);
			}
		}

		public bool StartLoadSceneDependencies()
		{
			if (_sceneInfo != null)
			{
				StartCoroutine(LoadSceneDependencies());
			}
			return false;
		}

		private IEnumerator LoadMainAsset()
		{
			ScenePrintUtil.Log("LoadMainAsset");
			if (_sceneInfo != null && ResourceManager4.FileExists(_sceneInfo.mainAsset))
			{
				string urlPath = FileUtil.GetWWWReadPath(_sceneInfo.mainAsset);
				ScenePrintUtil.Log("LoadMainAsset:" + urlPath);
				WWW localWWW = new WWW(urlPath);
				ScenePrintUtil.Log("=============================== 0 " + DateTime.Now.Ticks);
				yield return localWWW;
				if (localWWW.error == null)
				{
					if (urlPath.Equals(localWWW.url))
					{
						mainAssetLevel = localWWW.assetBundle;
						if (isAsyncMainAsset)
						{
							int displayProgress = 0;
							int toProgress2 = 0;
							AsyncOperation asyncO = Application.LoadLevelAsync(_sceneInfo.name);
							asyncO.allowSceneActivation = false;
							while (asyncO.progress < 0.9f)
							{
								toProgress2 = (int)(asyncO.progress * 100f);
								while (displayProgress < toProgress2)
								{
									displayProgress += 2;
									if (displayProgress > toProgress2)
									{
										displayProgress = toProgress2;
									}
									OnBaseProgress((float)displayProgress / 100f);
									yield return 0;
								}
								yield return 0;
							}
							toProgress2 = 100;
							while (displayProgress < toProgress2)
							{
								displayProgress += 2;
								if (displayProgress > toProgress2)
								{
									displayProgress = toProgress2;
								}
								OnBaseProgress((float)displayProgress / 100f);
								yield return 0;
							}
							asyncO.allowSceneActivation = true;
							ScenePrintUtil.Log("loadLevel.progress: {0}", asyncO.progress);
							ScenePrintUtil.Log("loadLevel.progress: ok");
						}
						else
						{
							if (OnBaseProgress != null)
							{
								OnBaseProgress(1f);
							}
							Application.LoadLevel(_sceneInfo.name);
						}
						SceneManager4.GetInstance().SetDisableItemReduction(false);
						yield return 0;
						StartLoadSceneDependencies();
					}
					else
					{
						localWWW.assetBundle.Unload(true);
					}
				}
				else
				{
					ScenePrintUtil.Log("error: " + localWWW.error);
				}
			}
			ScenePrintUtil.Log("=============================== 1 " + DateTime.Now.Ticks);
			yield return 0;
			ScenePrintUtil.Log("=============================== 2 " + DateTime.Now.Ticks);
		}

		private IEnumerator LoadSceneDependencies()
		{
			ScenePrintUtil.Log("LoadSceneDependencies start");
			SceneInfo4 info = _sceneInfo;
			if (info != null)
			{
				long ticks = DateTime.Now.Ticks;
				GameObject[] array = UnityEngine.Object.FindObjectsOfType(typeof(GameObject)) as GameObject[];
				SceneItem4[] items = info.items.ToArray();
				for (int i = 0; i < array.Length; i++)
				{
					if (!ReductionSceneUtil4.FindRootGameObject(array[i]).name.Equals(info.name))
					{
						continue;
					}
					SceneItem4 sceneItem = ReductionSceneUtil4.BinarySearch(items, array[i]);
					if (sceneItem != null)
					{
						sceneItem.go = array[i];
						ComponentSceneItem4 componentSceneItem = sceneItem.go.AddComponent<ComponentSceneItem4>();
						if (sceneItem.type.Equals(SceneItemType4.Particle))
						{
							sceneItem.go.AddComponent<MeshRenderer>();
							componentSceneItem.canInvisible = false;
							activeCmps.Add(componentSceneItem);
						}
						componentSceneItem.item = sceneItem;
						componentSceneItem.resources = info.resources;
						componentSceneItem.tnames = info.textureNames;
						sceneItem.go.SetActive(false);
						sceneItem.go.SetActive(true);
						ScenePrintUtil.Log("find item<->gameObject:{0}", (!sceneItem.go) ? "nil" : sceneItem.go.name);
					}
				}
				long ticks2 = DateTime.Now.Ticks;
				ScenePrintUtil.Log("find all items, and addCmp use time: " + (float)(ticks2 - ticks) / 10000f + " tick, itemsCount:" + info.items.Count + " / allgos: " + array.Length);
				if (OnBaseLoaded != null)
				{
					OnBaseLoaded();
				}
				yield return 0;
				if (info.sceneSkybox == null || info.sceneSkybox.textureAsset != null)
				{
				}
				if (info.lightmaps != null)
				{
					string[] array2 = new string[info.lightmaps.Count * 2];
					for (int j = 0; j < info.lightmaps.Count; j++)
					{
						SceneLightData4 sceneLightData = info.lightmaps[j];
						int lightmapFarIndex = sceneLightData.lightmapFarIndex;
						if (lightmapFarIndex >= 0 && lightmapFarIndex < info.resources.Count)
						{
							array2[j * 2] = info.resources[lightmapFarIndex];
						}
						lightmapFarIndex = sceneLightData.lightmapNearIndex;
						if (lightmapFarIndex >= 0 && lightmapFarIndex < info.resources.Count)
						{
							array2[j * 2 + 1] = info.resources[lightmapFarIndex];
						}
					}
					SceneResourceManager4.GetInstance().AddLoadTask(array2, info.lightmapLoadPriority, this, new SceneResourceCallbackData4(1, null, null));
				}
				SceneResourceManager4.GetInstance().downloadMgr.SetIdleDownloadFiles(info.resources);
			}
			yield return 0;
			ScenePrintUtil.Log("LoadSceneDependencies end");
		}

		public void OnLoaded(SceneAssetBundle[] assetBundles, SceneResourceCallbackData4 data)
		{
			if (data.intData != 1)
			{
				return;
			}
			LightmapData[] lightmaps = LightmapSettings.lightmaps;
			if (assetBundles.Length != lightmaps.Length * 2)
			{
				return;
			}
			int num = lightmaps.Length;
			LightmapData[] array = new LightmapData[num];
			for (int i = 0; i < num; i++)
			{
				LightmapData lightmapData = LightmapSettings.lightmaps[i];
				LightmapData lightmapData2 = new LightmapData();
				Texture2D lightmapColor = lightmapData.lightmapColor;
				if (assetBundles[i * 2] != null)
				{
					lightmapColor = assetBundles[i * 2].mainAsset as Texture2D;
					assetBundles[i * 2].Retain();
				}
				lightmapData2.lightmapColor = lightmapColor;
				Texture2D lightmapDir = lightmapData.lightmapDir;
				if (assetBundles[i * 2 + 1] != null)
				{
					lightmapDir = assetBundles[i * 2 + 1].mainAsset as Texture2D;
					assetBundles[i * 2 + 1].Retain();
				}
				lightmapData2.lightmapDir = lightmapDir;
				array[i] = lightmapData2;
			}
			LightmapSettings.lightmaps = array;
		}

		public string GetSceneName()
		{
			if (_sceneInfo == null)
			{
				return string.Empty;
			}
			return _sceneInfo.name;
		}

		public static void Init(GameObject go)
		{
			if (_instance == null && go != null)
			{
				_instance = go.AddComponent<SceneInfoManager4>();
				UnityEngine.Object.DontDestroyOnLoad(go);
			}
		}

		public static SceneInfoManager4 GetInstance()
		{
			return _instance;
		}
	}
}
