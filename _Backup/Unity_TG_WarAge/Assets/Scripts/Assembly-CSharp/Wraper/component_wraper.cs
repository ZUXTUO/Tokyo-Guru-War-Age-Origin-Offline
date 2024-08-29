using System;
using LuaInterface;
using UnityEngine;
using UnityWrap;

namespace Wraper
{
	public class component_wraper
	{
		public static string libname = "component";

		private static luaL_Reg[] libfunc = new luaL_Reg[3]
		{
			new luaL_Reg("get_component_mini_map", get_component_mini_map),
			new luaL_Reg("get_component_projector", get_component_projector),
			new luaL_Reg("get_component_camera", get_component_camera)
		};

		private static string string_get_component_mini_map = "component.get_component_mini_map";

		private static string string_get_component_projector = "component.get_component_projector";

		private static string string_get_component_camera = "component.get_component_camera";

		public static bool init(IntPtr L)
		{
			if (L != IntPtr.Zero)
			{
				LuaDLL.register_lib(L, libname, libfunc, 0);
				return true;
			}
			return false;
		}

		[MonoPInvokeCallback(typeof(LuaCSFunction))]
		private static int get_component_mini_map(IntPtr L)
		{
			int result = 0;
			if (WraperUtil.ValidIsUserdata(L, 1, string_get_component_mini_map))
			{
				AssetGameObject assetGameObject = null;
				assetGameObject = WraperUtil.LuaToUserdata(L, 1, string_get_component_mini_map, AssetGameObject.cache);
				if (assetGameObject != null)
				{
					MiniMap component = assetGameObject.gameObject.GetComponent<MiniMap>();
					if (component == null)
					{
						LuaDLL.lua_pushnil(L);
					}
					else
					{
						WraperUtil.PushObject(L, MiniMapWrap.CreateInstance(component));
					}
				}
				else
				{
					LuaDLL.lua_pushnil(L);
				}
				result = 1;
			}
			return result;
		}

		[MonoPInvokeCallback(typeof(LuaCSFunction))]
		private static int get_component_projector(IntPtr L)
		{
			int result = 0;
			if (WraperUtil.ValidIsUserdata(L, 1, string_get_component_projector))
			{
				AssetGameObject assetGameObject = null;
				assetGameObject = WraperUtil.LuaToUserdata(L, 1, string_get_component_projector, AssetGameObject.cache);
				if (assetGameObject != null)
				{
					Projector component = assetGameObject.gameObject.GetComponent<Projector>();
					if (component == null)
					{
						LuaDLL.lua_pushnil(L);
					}
					else
					{
						WraperUtil.PushObject(L, ProjectorWrap.CreateInstance(component));
					}
				}
				else
				{
					LuaDLL.lua_pushnil(L);
				}
				result = 1;
			}
			return result;
		}

		[MonoPInvokeCallback(typeof(LuaCSFunction))]
		private static int get_component_camera(IntPtr L)
		{
			int result = 0;
			if (WraperUtil.ValidIsUserdata(L, 1, string_get_component_camera))
			{
				AssetGameObject assetGameObject = null;
				assetGameObject = WraperUtil.LuaToUserdata(L, 1, string_get_component_camera, AssetGameObject.cache);
				if (assetGameObject != null)
				{
					Camera component = assetGameObject.gameObject.GetComponent<Camera>();
					if (component == null)
					{
						LuaDLL.lua_pushnil(L);
					}
					else
					{
						WraperUtil.PushObject(L, CameraWrap.CreateInstance(component));
					}
				}
				else
				{
					LuaDLL.lua_pushnil(L);
				}
				result = 1;
			}
			return result;
		}
	}
}
