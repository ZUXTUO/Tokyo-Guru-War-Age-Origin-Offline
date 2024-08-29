using System;
using System.Collections.Generic;
using ComponentEx;
using Core;
using Core.Resource;
using Core.Unity;
using Core.Util;
using UnityEngine;
using Wraper;

namespace UnityWrap
{
	public class AssetGameObject : RefObject
	{
		private static bool m_useNodeQuickLookup = true;

		public static AssetObjectCache<int, AssetGameObject> cache = new AssetObjectCache<int, AssetGameObject>();

		private bool mGetTransform;

		private bool mGetGameObject;

		private bool mGetRender;

		private bool mGetAnimation;

		private bool mGetCharacterController;

		private bool mGetCollider;

		private bool mGetAnimator;

		private bool mGetUILookUp;

		private AssetObject assetObject;

		public bool isNeedDestroy;

		private GameObject _gameObject;

		private Renderer _render;

		private Animation _animation;

		private Animator _animator;

		private Transform _transform;

		private Collider _collider;

		private CharacterController _characterController;

		private EffectHelper _effectHelper;

		private NodeQuickLookupHelper _nodeQuickLookup;

		private string debugName = string.Empty;

		public static bool useNodeQuickLookup
		{
			get
			{
				return m_useNodeQuickLookup;
			}
			set
			{
				m_useNodeQuickLookup = value;
			}
		}

		public string gameObjectName
		{
			get
			{
				return (!(_gameObject == null)) ? _gameObject.name : null;
			}
		}

		public GameObject gameObject
		{
			get
			{
				Utils.CheckGameObjectIsDestroyed(_gameObject);
				return _gameObject;
			}
		}

		public Renderer render
		{
			get
			{
				if (_render == null && !mGetRender)
				{
					_render = gameObject.GetComponent<Renderer>();
					mGetRender = true;
				}
				return _render;
			}
		}

		public Animation animation
		{
			get
			{
				if (_animation == null && !mGetAnimation)
				{
					_animation = gameObject.GetComponent<Animation>();
					mGetAnimation = true;
				}
				return _animation;
			}
		}

		public Transform transform
		{
			get
			{
				if (_transform == null && !mGetTransform)
				{
					try
					{
						_transform = gameObject.transform;
						mGetTransform = true;
					}
					catch (Exception ex)
					{
						UnityEngine.Debug.LogWarning(ex.Message + ":" + debugName);
					}
				}
				return _transform;
			}
		}

		public CharacterController characterController
		{
			get
			{
				if (_characterController == null && !mGetCharacterController)
				{
					_characterController = gameObject.GetComponent<CharacterController>();
					mGetCharacterController = true;
				}
				return _characterController;
			}
		}

		public Collider collider
		{
			get
			{
				if (_collider == null && !mGetCollider)
				{
					_collider = gameObject.GetComponent<Collider>();
					mGetCollider = true;
				}
				return _collider;
			}
		}

		public Animator animator
		{
			get
			{
				if (_animator == null && !mGetAnimator)
				{
					_animator = gameObject.GetComponent<Animator>();
					mGetAnimator = true;
				}
				return _animator;
			}
		}

		public NodeQuickLookupHelper uiNodeLookUp
		{
			get
			{
				if (!mGetUILookUp && null == _nodeQuickLookup && useNodeQuickLookup)
				{
					_nodeQuickLookup = gameObject.GetComponent<NodeQuickLookupHelper>();
					mGetUILookUp = true;
				}
				return _nodeQuickLookup;
			}
		}

		public EffectHelper effectHelper
		{
			get
			{
				return _effectHelper;
			}
		}

		public AssetGameObject()
		{
			lua_class_name = asset_game_object_wraper.name;
		}

		public override void PrePushToLua()
		{
			AddRef();
		}

		public override void PostPushToLua()
		{
			DelRef();
		}

		public static AssetGameObject CreateByAssetObject(AssetObject asset, bool save)
		{
			AssetGameObject assetGameObject = null;
			if (asset == null)
			{
				Core.Unity.Debug.LogError("[AssetGameObject CrateByAssetObject] error: asset is nil.");
			}
			else if (asset.mainAsset == null)
			{
				Core.Unity.Debug.LogError("[AssetGameObject CrateByAssetObject] error: asset.mainAsset is nil.");
			}
			else if (asset.mainAsset.GetType() != typeof(GameObject))
			{
				Core.Unity.Debug.LogError("[AssetGameObject CrateByAssetObject] error: asset type error:" + asset.GetType());
			}
			else
			{
				assetGameObject = new AssetGameObject();
				assetGameObject.isNeedDestroy = true;
				assetGameObject._gameObject = (GameObject)UnityEngine.Object.Instantiate(asset.mainAsset);
				AssetBundleLoader.GetInstance().checkAddSharedAtlasRef(asset, assetGameObject);
				assetGameObject.InitComponent();
				if (save)
				{
					assetGameObject.assetObject = asset;
					assetGameObject.assetObject.AddRef();
					asset.unloadAll = true;
				}
				else
				{
					asset.unloadAll = false;
				}
				cache.Add(assetGameObject.GetPid(), assetGameObject);
			}
			return assetGameObject;
		}

		public static void FixShader(AssetGameObject go)
		{
			List<MeshRenderer> list = new List<MeshRenderer>();
			MeshRenderer component = go._gameObject.GetComponent<MeshRenderer>();
			if ((bool)component)
			{
				list.Add(component);
			}
			MeshRenderer[] componentsInChildren = go._gameObject.GetComponentsInChildren<MeshRenderer>();
			list.AddRange(componentsInChildren);
			foreach (MeshRenderer item in list)
			{
				Shader shader = Shader.Find(item.material.shader.name);
				if ((bool)shader)
				{
					item.material.shader = shader;
				}
				else
				{
					UnityEngine.Debug.LogWarning("shader 丢失" + item.material.shader.name);
				}
			}
		}

		public static AssetGameObject CreateByFind(string name)
		{
			AssetGameObject assetGameObject = null;
			GameObject gameObject = GameObject.Find(name);
			if (gameObject == null)
			{
				Core.Unity.Debug.LogWarning(string.Format("[AssetGameObject CreateByFind] error: GameObject.Find( {0} ) failed, target is null", name));
			}
			else
			{
				assetGameObject = new AssetGameObject();
				assetGameObject.isNeedDestroy = false;
				assetGameObject._gameObject = gameObject;
				assetGameObject.InitComponent();
				cache.Add(assetGameObject.GetPid(), assetGameObject);
			}
			return assetGameObject;
		}

		public static AssetGameObject[] CreateByFindWithTag(string tag)
		{
			AssetGameObject[] result = null;
			GameObject[] array = GameObject.FindGameObjectsWithTag(tag);
			if (array == null)
			{
				Core.Unity.Debug.LogError("[AssetGameObject CreateByFindWithTag] error: GameObject.FindGameObjectsWithTag() failed, targets is null");
			}
			else
			{
				List<AssetGameObject> list = new List<AssetGameObject>();
				for (int i = 0; i < array.Length; i++)
				{
					AssetGameObject assetGameObject = new AssetGameObject();
					assetGameObject = new AssetGameObject();
					assetGameObject.isNeedDestroy = false;
					assetGameObject._gameObject = array[i];
					assetGameObject.InitComponent();
					list.Add(assetGameObject);
					cache.Add(assetGameObject.GetPid(), assetGameObject);
				}
				result = list.ToArray();
			}
			return result;
		}

		public static AssetGameObject CreateByInstance(GameObject inGameObject)
		{
			AssetGameObject assetGameObject = null;
			assetGameObject = new AssetGameObject();
			assetGameObject.isNeedDestroy = false;
			assetGameObject._gameObject = inGameObject;
			assetGameObject.InitComponent();
			cache.Add(assetGameObject.GetPid(), assetGameObject);
			return assetGameObject;
		}

		public static AssetGameObject Clone(AssetGameObject baseObject)
		{
			AssetGameObject assetGameObject = null;
			if (baseObject == null || baseObject.gameObject == null)
			{
				Core.Unity.Debug.LogError("[AssetGameObject Clone] error: baseObject is null");
			}
			else
			{
				assetGameObject = new AssetGameObject();
				Transform transform = baseObject.gameObject.transform;
				assetGameObject._gameObject = UnityEngine.Object.Instantiate(baseObject.gameObject, transform.position, transform.rotation);
				assetGameObject._gameObject.transform.parent = transform.parent;
				assetGameObject._gameObject.transform.localPosition = transform.localPosition;
				assetGameObject._gameObject.transform.localRotation = transform.localRotation;
				assetGameObject._gameObject.transform.localScale = transform.localScale;
				assetGameObject.isNeedDestroy = true;
				assetGameObject.InitComponent();
				AssetBundleLoader.GetInstance().checkAddSharedAtlasRef(baseObject, assetGameObject);
				cache.Add(assetGameObject.GetPid(), assetGameObject);
			}
			return assetGameObject;
		}

		public static void DestroyAll()
		{
			Dictionary<int, AssetGameObject> cacheMap = cache.cacheMap;
			foreach (AssetGameObject value in cacheMap.Values)
			{
				value.ClearResources(false);
			}
			cacheMap.Clear();
		}

		public override void ClearResources()
		{
			ClearResources(true);
		}

		public void ClearResources(bool needRemove)
		{
			if (needRemove)
			{
				AssetBundleLoader.GetInstance().checkDelSharedAtlasRef(GetPid());
				cache.Remove(GetPid());
			}
			if (isNeedDestroy)
			{
				UnityEngine.Object.Destroy(_gameObject);
			}
			if (assetObject != null)
			{
				assetObject.DelRef();
				assetObject = null;
			}
		}

		private void InitComponent()
		{
			if (_gameObject != null)
			{
				if (_gameObject.GetComponent<AnimationEventHandler>() == null)
				{
					_gameObject.AddComponent<AnimationEventHandler>();
				}
				debugName = _gameObject.name;
			}
		}

		public void SetupEffectHelper()
		{
			if (null == _effectHelper && null != _gameObject)
			{
				_effectHelper = _gameObject.AddComponent<EffectHelper>();
			}
		}
	}
}
