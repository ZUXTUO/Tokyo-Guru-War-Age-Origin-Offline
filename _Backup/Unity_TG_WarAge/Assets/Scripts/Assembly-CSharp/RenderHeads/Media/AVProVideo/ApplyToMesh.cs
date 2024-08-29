using UnityEngine;

namespace RenderHeads.Media.AVProVideo
{
	[AddComponentMenu("AVPro Video/Apply To Mesh")]
	public class ApplyToMesh : MonoBehaviour
	{
		public Vector2 _offset = Vector2.zero;

		public Vector2 _scale = Vector2.one;

		public MeshRenderer _mesh;

		public MediaPlayer _media;

		public Texture2D _defaultTexture;

		private void Update()
		{
			bool flag = false;
			if (_media != null && _media.TextureProducer != null)
			{
				Texture texture = _media.TextureProducer.GetTexture();
				if (texture != null)
				{
					ApplyMapping(texture, _media.TextureProducer.RequiresVerticalFlip());
					flag = true;
				}
			}
			if (!flag)
			{
				ApplyMapping(_defaultTexture, false);
			}
		}

		private void ApplyMapping(Texture texture, bool requiresYFlip)
		{
			if (!(_mesh != null) || _mesh.materials == null)
			{
				return;
			}
			for (int i = 0; i < _mesh.materials.Length; i++)
			{
				Material material = _mesh.materials[i];
				if (!(material != null))
				{
					continue;
				}
				material.mainTexture = texture;
				if (texture != null)
				{
					if (requiresYFlip)
					{
						material.mainTextureScale = new Vector2(_scale.x, 0f - _scale.y);
						material.mainTextureOffset = Vector2.up + _offset;
					}
					else
					{
						material.mainTextureScale = _scale;
						material.mainTextureOffset = _offset;
					}
				}
				if (material.shader.name == "Unlit/InsideSphere" && _media != null)
				{
					Helper.SetupStereoMaterial(material, _media.m_StereoPacking, _media.m_DisplayDebugStereoColorTint);
				}
			}
		}

		private void OnEnable()
		{
			if (_mesh == null)
			{
				_mesh = GetComponent<MeshRenderer>();
				if (_mesh == null)
				{
					Debug.LogWarning("[AVProVideo] No mesh renderer set or found in gameobject");
				}
			}
			if (_mesh != null)
			{
				Update();
			}
		}

		private void OnDisable()
		{
			ApplyMapping(_defaultTexture, false);
		}
	}
}
