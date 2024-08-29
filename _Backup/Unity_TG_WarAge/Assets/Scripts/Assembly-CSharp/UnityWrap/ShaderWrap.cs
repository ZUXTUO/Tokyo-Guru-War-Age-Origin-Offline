using Core;
using Core.Unity;
using UnityEngine;
using Wraper;

namespace UnityWrap
{
	public class ShaderWrap : BaseObject
	{
		public static AssetObjectCache<int, ShaderWrap> cache = new AssetObjectCache<int, ShaderWrap>();

		private Shader mShader;

		public Shader component
		{
			get
			{
				return mShader;
			}
		}

		public ShaderWrap()
		{
			lua_class_name = shader_wraper.name;
		}

		public static ShaderWrap CreateInstance(Shader shader)
		{
			if (shader == null)
			{
				Core.Unity.Debug.LogWarning("[ShaderWrap CreateInstance] error: shader is null ");
				return null;
			}
			ShaderWrap shaderWrap = new ShaderWrap();
			shaderWrap.mShader = shader;
			cache.Add(shaderWrap.GetPid(), shaderWrap);
			return shaderWrap;
		}

		public static ShaderWrap Load(string name)
		{
			Shader shader = App3.GetInstance().FindShader(name);
			if (shader == null)
			{
				Core.Unity.Debug.LogWarning("[ShaderWrap Load] error: Shader.Find get null shader");
				return null;
			}
			ShaderWrap shaderWrap = new ShaderWrap();
			shaderWrap.mShader = shader;
			cache.Add(shaderWrap.GetPid(), shaderWrap);
			return shaderWrap;
		}

		public static void DestroyInstance(ShaderWrap obj)
		{
			if (obj != null)
			{
				cache.Remove(obj.GetPid());
				obj.mShader = null;
			}
		}
	}
}
