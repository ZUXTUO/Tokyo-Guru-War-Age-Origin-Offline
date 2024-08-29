using System.Collections.Generic;
using UnityEngine;

namespace Core.Scene
{
	public class ComponentSceneItem4 : MonoBehaviour, SceneResourceCallback4
	{
		private GameObject go;

		public SceneItem4 item;

		public List<string> resources;

		public List<string> tnames;

		public bool canVisible = true;

		public bool canInvisible = true;

		private bool isCreateTexture;

		private SceneResourceManager4 resMgr;

		private List<SceneResourceRequest4> resRequests = new List<SceneResourceRequest4>();

		private bool isInitDependencies;

		private Material[] cacheMaterials;

		private SceneAsset4[] cacheAssets;

		private List<Material> loadedMaterials = new List<Material>();

		private void Start()
		{
			go = base.gameObject;
			resMgr = SceneResourceManager4.GetInstance();
		}

		private bool RemoveLoadedMaterial(Material mat)
		{
			int i = 0;
			for (int count = loadedMaterials.Count; i < count; i++)
			{
				if (loadedMaterials[i] == mat)
				{
					loadedMaterials.RemoveAt(i);
					return true;
				}
			}
			return false;
		}

		private bool AddLoadedMaterial(Material mat)
		{
			RemoveLoadedMaterial(mat);
			loadedMaterials.Add(mat);
			return false;
		}

		private void InitDependencies()
		{
			if (isInitDependencies)
			{
				return;
			}
			UseTime useTime = new UseTime();
			isInitDependencies = true;
			ParticleSystemRenderer particleSystemRenderer = GetComponent<ParticleSystemRenderer>();
			if (particleSystemRenderer != null && !particleSystemRenderer.enabled)
			{
				particleSystemRenderer = null;
			}
			MeshRenderer meshRenderer = GetComponent<MeshRenderer>();
			if (meshRenderer != null && !meshRenderer.enabled)
			{
				meshRenderer = null;
			}
			SkinnedMeshRenderer skinnedMeshRenderer = GetComponent<SkinnedMeshRenderer>();
			if (skinnedMeshRenderer != null && !skinnedMeshRenderer.enabled)
			{
				skinnedMeshRenderer = null;
			}
			List<Material> list = new List<Material>();
			List<SceneAsset4> list2 = new List<SceneAsset4>();
			if (item != null && (particleSystemRenderer != null || meshRenderer != null || skinnedMeshRenderer != null))
			{
				int i = 0;
				for (int count = item.nodes.Count; i < count; i++)
				{
					SceneItemComponent4 sceneItemComponent = item.nodes[i];
					if (particleSystemRenderer != null && sceneItemComponent.type.Equals(SceneItemComponentType4.ParticleSystemRenderer) && sceneItemComponent.assets != null && sceneItemComponent.assets.Count == 1)
					{
						SceneAsset4 sceneAsset = sceneItemComponent.assets[0];
						Material sharedMaterial = particleSystemRenderer.sharedMaterial;
						if (sceneAsset != null && sceneAsset.Type.Equals(SceneAssetType4.Material))
						{
							list2.Add(sceneAsset);
							list.Add(sharedMaterial);
						}
					}
					if (meshRenderer != null && sceneItemComponent.type.Equals(SceneItemComponentType4.MeshRenderer))
					{
						Material[] sharedMaterials = meshRenderer.sharedMaterials;
						if (sceneItemComponent.assets != null && sceneItemComponent.assets.Count == sharedMaterials.Length)
						{
							for (int j = 0; j < sceneItemComponent.assets.Count; j++)
							{
								list2.Add(sceneItemComponent.assets[i]);
								list.Add(sharedMaterials[j]);
							}
						}
					}
					if (!(skinnedMeshRenderer != null) || !sceneItemComponent.type.Equals(SceneItemComponentType4.SkinnedMeshRenderer))
					{
						continue;
					}
					Material[] sharedMaterials2 = skinnedMeshRenderer.sharedMaterials;
					if (sceneItemComponent.assets != null && sceneItemComponent.assets.Count == sharedMaterials2.Length)
					{
						for (int k = 0; k < sceneItemComponent.assets.Count; k++)
						{
							list2.Add(sceneItemComponent.assets[i]);
							list.Add(sharedMaterials2[k]);
						}
					}
				}
			}
			cacheMaterials = ((list.Count <= 0) ? null : list.ToArray());
			cacheAssets = ((list2.Count <= 0) ? null : list2.ToArray());
			useTime.PrintStep(string.Format("go {0} init dependencies", go.name));
		}

		public void ActiveVisible(int pri)
		{
			ProcessOnVisible(true, pri);
		}

		private void OnBecameVisible()
		{
			ProcessOnVisible(false, 0);
		}

		private void ProcessOnVisible(bool useNewPri, int newPri)
		{
			if (ComponentAssetDataManager4.StopItemVisibleTask || !canVisible || isCreateTexture)
			{
				return;
			}
			isCreateTexture = true;
			ClearRequest();
			if (!(go != null))
			{
				return;
			}
			ScenePrintUtil.Log(string.Concat("OnBecameVisible:", go.GetInstanceID(), " ++++++++++++++++++ ", go.name, " type: ", item.type, " ", item.GetHashCode()));
			InitDependencies();
			if (cacheMaterials == null)
			{
				return;
			}
			UseTime useTime = new UseTime();
			ScenePrintUtil.Log(" +++++++ " + cacheMaterials.Length);
			int num = cacheMaterials.Length;
			for (int i = 0; i < num; i++)
			{
				SceneResourceRequest4 sceneResourceRequest = ReductionSceneUtil4.CreateLoadTask((!useNewPri) ? item.priority : newPri, cacheAssets[i], cacheMaterials[i], resources, resMgr, this);
				useTime.PrintStep(" for create load task", 1.0);
				if (sceneResourceRequest != null)
				{
					resRequests.Add(sceneResourceRequest);
				}
			}
			useTime.PrintStep(string.Format("go {0} on became visibe", go.name));
		}

		private void OnBecameInvisible()
		{
			if (ComponentAssetDataManager4.StopItemVisibleTask || !canInvisible || !isCreateTexture)
			{
				return;
			}
			isCreateTexture = false;
			ScenePrintUtil.Log("OnBecameInvisible: id:{0}, name:{1}", go ? go.GetInstanceID() : 0, (!go) ? "nil" : go.name);
			ClearRequest();
			if (cacheMaterials == null)
			{
				return;
			}
			ScenePrintUtil.Log(" ------- " + cacheMaterials.Length);
			UseTime useTime = new UseTime();
			int num = cacheMaterials.Length;
			for (int i = 0; i < num; i++)
			{
				Material material = cacheMaterials[i];
				if (!(material != null) || !RemoveLoadedMaterial(material))
				{
					continue;
				}
				ComponentAssetData4 componentAssetData = ComponentAssetDataManager4.Remove(material, go);
				if (componentAssetData == null || componentAssetData.dependencies == null)
				{
					continue;
				}
				SceneAsset4[] dependencies = componentAssetData.dependencies;
				int num2 = dependencies.Length;
				for (int j = 0; j < num2; j++)
				{
					SceneAsset4 sceneAsset = dependencies[j];
					if (sceneAsset == null)
					{
						continue;
					}
					SceneAssetBundle sceneAssetBundle = sceneAsset.sObj as SceneAssetBundle;
					if (sceneAssetBundle == null)
					{
						continue;
					}
					Texture texture = sceneAsset.uObj as Texture;
					string text = ((sceneAsset.Key < 0 || sceneAsset.Key >= tnames.Count) ? null : tnames[sceneAsset.Key]);
					if (text != null)
					{
						material.SetTexture(tnames[sceneAsset.Key], texture);
						if (sceneAssetBundle != null)
						{
							sceneAssetBundle.Release();
						}
						sceneAsset.sObj = null;
						if (sceneAssetBundle != null)
						{
							sceneAssetBundle.Release();
						}
						if (texture != null)
						{
							Texture texture2 = ((text == null) ? null : material.GetTexture(text));
							ScenePrintUtil.Log(" ->t restore texture: {0} {1}, go:{2} preidTex:{3}", texture.GetInstanceID(), texture.name, go.name, (!(texture2 != null)) ? (-1) : texture2.GetInstanceID());
						}
					}
				}
			}
			ScenePrintUtil.Log("go {0} on became invisible use time {1}", go.name, useTime.step());
		}

		private void ClearRequest()
		{
			UseTime useTime = new UseTime();
			int i = 0;
			for (int count = resRequests.Count; i < count; i++)
			{
				resMgr.RemoveLoadTask(resRequests[i]);
			}
			resRequests.Clear();
			useTime.PrintStep(string.Format("go {0} clear request", (!go) ? "nil" : go.name));
		}

		public void OnLoaded(SceneAssetBundle[] assetBundles, SceneResourceCallbackData4 data)
		{
			UseTime useTime = new UseTime();
			if (!(go != null))
			{
				return;
			}
			ScenePrintUtil.Log("OnLoaded: {0}, data:{1} uobj:{2}, sobj:{3}", go.name, data, (data == null) ? null : data.uObj, (data == null) ? null : data.sObj);
			if (data != null && data.uObj != null && data.sObj != null)
			{
				ScenePrintUtil.Log("OnLoaded data != null");
				if (data.uObj.GetType().Equals(typeof(Material)) && data.sObj.GetType().Equals(typeof(List<SceneAsset4>)))
				{
					List<SceneAsset4> list = data.sObj as List<SceneAsset4>;
					Material material = data.uObj as Material;
					bool flag = ComponentAssetDataManager4.Contains(material);
					ScenePrintUtil.Log("OnLoaded  equal material, dependencies.Count:{0}, isCached:{1}", list.Count, flag);
					if (flag)
					{
						AddLoadedMaterial(material);
						ComponentAssetDataManager4.Add(material, go);
					}
					else
					{
						AddLoadedMaterial(material);
						ComponentAssetDataManager4.Add(material, new ComponentAssetData4(list.ToArray()), go);
						int count = list.Count;
						ScenePrintUtil.Log("OnLoaded   len:{0}, {1}", count, assetBundles.Length);
						if (count == assetBundles.Length)
						{
							for (int i = 0; i < count; i++)
							{
								SceneAsset4 sceneAsset = list[i];
								ScenePrintUtil.Log("OnLoaded    childAsset:{0} type:{1}", sceneAsset, (int)((sceneAsset == null) ? ((SceneAssetType4)(-1)) : sceneAsset.Type));
								if (sceneAsset == null || !sceneAsset.Type.Equals(SceneAssetType4.Texture))
								{
									continue;
								}
								SceneAssetBundle sceneAssetBundle = assetBundles[i];
								ScenePrintUtil.Log("OnLoaded sab:{0}, sab.mainAssets:{1}", sceneAssetBundle, (sceneAssetBundle != null) ? sceneAssetBundle.mainAsset : null);
								if (sceneAssetBundle == null || !(sceneAssetBundle.mainAsset != null))
								{
									continue;
								}
								string text = ((sceneAsset.Key < 0 || sceneAsset.Key >= tnames.Count) ? null : tnames[sceneAsset.Key]);
								ScenePrintUtil.Log("OnLoaded     sab != null, childAssetKey:{0} texProName:{1}", text, sceneAsset.Key);
								if (text != null)
								{
									sceneAssetBundle.Retain();
									sceneAssetBundle.Retain();
									if (sceneAsset.sObj != null)
									{
										SceneAssetBundle sceneAssetBundle2 = sceneAsset.sObj as SceneAssetBundle;
										sceneAssetBundle2.Release();
										sceneAssetBundle2.Release();
									}
									ScenePrintUtil.Log("setTexture: {0} {1}", sceneAssetBundle.mainAsset.GetInstanceID(), sceneAssetBundle.mainAsset.name);
									Texture texture = material.GetTexture(text);
									if (texture != null)
									{
										ScenePrintUtil.Log(" ->t delete texture: {0} {1}, go:{2} newTex:{3}", texture.GetInstanceID(), texture.name, go.name, sceneAssetBundle.mainAsset.GetInstanceID());
									}
									sceneAsset.uObj = texture;
									sceneAsset.sObj = sceneAssetBundle;
									material.SetTexture(text, sceneAssetBundle.mainAsset as Texture);
									Texture texture2 = sceneAssetBundle.mainAsset as Texture;
									ScenePrintUtil.Log("OnLoaded set material:{0} texture key:{1} value:{2} size:{3} {4}", material.GetInstanceID(), text, texture2.GetInstanceID(), texture2.width, texture2.height);
								}
							}
						}
					}
					resRequests.Clear();
				}
			}
			useTime.PrintStep(string.Format("go {0} onloaded", go.name));
		}
	}
}
