using System;
using LuaInterface;
using UnityEngine;
using UnityWrap;

namespace Wraper
{
	public class ngui_atlas_wraper
	{
		public static string name = "ngui_atlas";

		public static string libname = "ngui_atlas";

		private static luaL_Reg[] libfunc = new luaL_Reg[5]
		{
			new luaL_Reg("create_by_asset", create_by_asset),
			new luaL_Reg("create_by_textures", create_by_textures),
			new luaL_Reg("create_by_textures_with_shader", create_by_textures_with_shader),
			new luaL_Reg("add_texture", add_texture),
			new luaL_Reg("clear_texture", clear_texture)
		};

		private static luaL_Reg[] func = new luaL_Reg[15]
		{
			new luaL_Reg("get_pid", get_pid),
			new luaL_Reg("set_active", set_active),
			new luaL_Reg("set_name", set_name),
			new luaL_Reg("get_name", get_name),
			new luaL_Reg("set_position", set_position),
			new luaL_Reg("get_position", get_position),
			new luaL_Reg("get_size", get_size),
			new luaL_Reg("get_game_object", get_game_object),
			new luaL_Reg("get_parent", get_parent),
			new luaL_Reg("set_parent", set_parent),
			new luaL_Reg("clone", clone),
			new luaL_Reg("destroy_object", destroy_object),
			new luaL_Reg("get_pixel_size", get_pixel_size),
			new luaL_Reg("set_material", set_material),
			new luaL_Reg("replace_texture", replace_texture)
		};

		private static string string_create_by_asset = "ngui_atlas.create_by_asset";

		private static string string_create_by_textures = "ngui_atlas.create_by_textures";

		private static string string_create_by_textures_with_shader = "ngui_atlas.create_by_textures_with_shader";

		private static string string_add_texture = "ngui_atlas.add_texture";

		private static string string_get_pid = "ngui_atlas:get_pid";

		private static string string_set_active = "ngui_atlas:set_active";

		private static string string_set_name = "ngui_atlas:set_name";

		private static string string_get_name = "ngui_atlas:get_name";

		private static string string_set_position = "ngui_atlas:set_position";

		private static string string_get_position = "ngui_atlas:get_position";

		private static string string_get_size = "ngui_atlas:get_size";

		private static string string_get_game_object = "ngui_atlas:get_game_object";

		private static string string_get_parent = "ngui_atlas:get_parent";

		private static string string_set_parent = "ngui_atlas:set_parent";

		private static string string_clone = "ngui_atlas:clone";

		private static string string_destroy_object = "ngui_atlas:destroy_object";

		private static string string_get_pixel_size = "ngui_atlas:get_pixel_size";

		private static string string_set_material = "ngui_atlas:set_material";

		private static string string_replace_texture = "ngui_atlas:replace_texture";

		public static bool init(IntPtr L)
		{
			if (L != IntPtr.Zero)
			{
				LuaDLL.register_class(L, name, func, gc);
				LuaDLL.register_lib(L, libname, libfunc, 0);
				return true;
			}
			return false;
		}

		public static void push(IntPtr L, NGUIAtlasWrap obj)
		{
			if (obj == null)
			{
				LuaDLL.lua_pushnil(L);
				return;
			}
			LuaDLL.use_lua_newuserdata_ex(L, 4, obj.GetPid());
			LuaDLL.lua_getfield(L, LuaIndexes.LUA_REGISTRYINDEX, name);
			LuaDLL.lua_setmetatable(L, -2);
		}

		[MonoPInvokeCallback(typeof(LuaCSFunction))]
		private static int create_by_asset(IntPtr L)
		{
			int result = 0;
			if (WraperUtil.ValidIsUserdata(L, 1, string_create_by_asset) && WraperUtil.ValidIsBoolean(L, 2, string_create_by_asset))
			{
				AssetObject assetObject = null;
				bool flag = false;
				assetObject = WraperUtil.LuaToUserdata(L, 1, string_create_by_asset, AssetObject.cache);
				flag = LuaDLL.lua_toboolean(L, 2);
				NGUIAtlasWrap base_object = NGUIAtlasWrap.CreateByAssetObject(assetObject, flag);
				WraperUtil.PushObject(L, base_object);
				result = 1;
			}
			return result;
		}

		[MonoPInvokeCallback(typeof(LuaCSFunction))]
		private static int create_by_textures(IntPtr L)
		{
			int result = 0;
			if (WraperUtil.ValidIsNumber(L, 1, string_create_by_textures))
			{
				int num = 0;
				num = (int)LuaDLL.lua_tonumber(L, 1);
				NGUIAtlasWrap base_object = null;
				if (num == 1)
				{
					base_object = NGUIAtlasWrap.CreateByTextures(256);
				}
				if (num == 2)
				{
					base_object = NGUIAtlasWrap.CreateByTextures(512);
				}
				if (num == 3)
				{
					base_object = NGUIAtlasWrap.CreateByTextures(1024);
				}
				if (num == 4)
				{
					base_object = NGUIAtlasWrap.CreateByTextures(2048);
				}
				WraperUtil.PushObject(L, base_object);
				result = 1;
			}
			return result;
		}

		[MonoPInvokeCallback(typeof(LuaCSFunction))]
		private static int create_by_textures_with_shader(IntPtr L)
		{
			int result = 0;
			if (WraperUtil.ValidIsNumber(L, 1, string_create_by_textures_with_shader) && WraperUtil.ValidIsString(L, 2, string_create_by_textures_with_shader))
			{
				int num = 0;
				string text = null;
				num = (int)LuaDLL.lua_tonumber(L, 1);
				text = LuaDLL.lua_tostring(L, 2);
				NGUIAtlasWrap base_object = null;
				if (num == 1)
				{
					base_object = NGUIAtlasWrap.CreateByTextures(256, text);
				}
				if (num == 2)
				{
					base_object = NGUIAtlasWrap.CreateByTextures(512, text);
				}
				if (num == 3)
				{
					base_object = NGUIAtlasWrap.CreateByTextures(1024, text);
				}
				if (num == 4)
				{
					base_object = NGUIAtlasWrap.CreateByTextures(2048, text);
				}
				WraperUtil.PushObject(L, base_object);
				result = 1;
			}
			return result;
		}

		[MonoPInvokeCallback(typeof(LuaCSFunction))]
		private static int add_texture(IntPtr L)
		{
			int result = 0;
			if (WraperUtil.ValidIsUserdata(L, 1, string_add_texture))
			{
				TextureWrap textureWrap = null;
				textureWrap = WraperUtil.LuaToUserdata(L, 1, string_add_texture, TextureWrap.cache);
				NGUIAtlasWrap.addTextures.Add((Texture2D)textureWrap.component);
				result = 0;
			}
			return result;
		}

		[MonoPInvokeCallback(typeof(LuaCSFunction))]
		private static int clear_texture(IntPtr L)
		{
			int num = 0;
			NGUIAtlasWrap.addTextures.Clear();
			return 0;
		}

		[MonoPInvokeCallback(typeof(LuaCSFunction))]
		private static int get_pid(IntPtr L)
		{
			int result = 0;
			if (WraperUtil.ValidIsUserdata(L, 1, string_get_pid))
			{
				NGUIAtlasWrap nGUIAtlasWrap = null;
				nGUIAtlasWrap = WraperUtil.LuaToUserdata(L, 1, string_get_pid, NGUIAtlasWrap.cache);
				LuaDLL.lua_pushnumber(L, nGUIAtlasWrap.GetPid());
				result = 1;
			}
			return result;
		}

		[MonoPInvokeCallback(typeof(LuaCSFunction))]
		private static int set_active(IntPtr L)
		{
			int result = 0;
			if (WraperUtil.ValidIsUserdata(L, 1, string_set_active) && WraperUtil.ValidIsBoolean(L, 2, string_set_active))
			{
				NGUIAtlasWrap nGUIAtlasWrap = null;
				bool flag = false;
				nGUIAtlasWrap = WraperUtil.LuaToUserdata(L, 1, string_set_active, NGUIAtlasWrap.cache);
				flag = LuaDLL.lua_toboolean(L, 2);
				nGUIAtlasWrap.bcomponent.gameObject.SetActive(flag);
				result = 0;
			}
			return result;
		}

		[MonoPInvokeCallback(typeof(LuaCSFunction))]
		private static int set_name(IntPtr L)
		{
			int result = 0;
			if (WraperUtil.ValidIsUserdata(L, 1, string_set_name) && WraperUtil.ValidIsString(L, 2, string_set_name))
			{
				NGUIAtlasWrap nGUIAtlasWrap = null;
				string text = null;
				nGUIAtlasWrap = WraperUtil.LuaToUserdata(L, 1, string_set_name, NGUIAtlasWrap.cache);
				text = LuaDLL.lua_tostring(L, 2);
				nGUIAtlasWrap.bcomponent.gameObject.name = text;
				result = 0;
			}
			return result;
		}

		[MonoPInvokeCallback(typeof(LuaCSFunction))]
		private static int get_name(IntPtr L)
		{
			int result = 0;
			if (WraperUtil.ValidIsUserdata(L, 1, string_get_name))
			{
				NGUIAtlasWrap nGUIAtlasWrap = null;
				nGUIAtlasWrap = WraperUtil.LuaToUserdata(L, 1, string_get_name, NGUIAtlasWrap.cache);
				LuaDLL.lua_pushstring(L, nGUIAtlasWrap.bcomponent.gameObject.name);
				result = 1;
			}
			return result;
		}

		[MonoPInvokeCallback(typeof(LuaCSFunction))]
		private static int set_position(IntPtr L)
		{
			int result = 0;
			if (WraperUtil.ValidIsUserdata(L, 1, string_set_position) && WraperUtil.ValidIsNumber(L, 2, string_set_position) && WraperUtil.ValidIsNumber(L, 3, string_set_position) && WraperUtil.ValidIsNumber(L, 4, string_set_position))
			{
				NGUIAtlasWrap nGUIAtlasWrap = null;
				float num = 0f;
				float num2 = 0f;
				float num3 = 0f;
				nGUIAtlasWrap = WraperUtil.LuaToUserdata(L, 1, string_set_position, NGUIAtlasWrap.cache);
				num = (float)LuaDLL.lua_tonumber(L, 2);
				num2 = (float)LuaDLL.lua_tonumber(L, 3);
				num3 = (float)LuaDLL.lua_tonumber(L, 4);
				nGUIAtlasWrap.bcomponent.gameObject.transform.localPosition = new Vector3(num, num2, num3);
				result = 0;
			}
			return result;
		}

		[MonoPInvokeCallback(typeof(LuaCSFunction))]
		private static int get_position(IntPtr L)
		{
			int result = 0;
			if (WraperUtil.ValidIsUserdata(L, 1, string_get_position))
			{
				NGUIAtlasWrap nGUIAtlasWrap = null;
				nGUIAtlasWrap = WraperUtil.LuaToUserdata(L, 1, string_get_position, NGUIAtlasWrap.cache);
				Vector3 localPosition = nGUIAtlasWrap.bcomponent.gameObject.transform.localPosition;
				LuaDLL.lua_pushnumber(L, localPosition.x);
				LuaDLL.lua_pushnumber(L, localPosition.y);
				LuaDLL.lua_pushnumber(L, localPosition.z);
				result = 3;
			}
			return result;
		}

		[MonoPInvokeCallback(typeof(LuaCSFunction))]
		private static int get_size(IntPtr L)
		{
			int result = 0;
			if (WraperUtil.ValidIsUserdata(L, 1, string_get_size))
			{
				NGUIAtlasWrap nGUIAtlasWrap = null;
				nGUIAtlasWrap = WraperUtil.LuaToUserdata(L, 1, string_get_size, NGUIAtlasWrap.cache);
				int num = ((!(nGUIAtlasWrap.widget == null)) ? nGUIAtlasWrap.widget.width : 0);
				int num2 = ((!(nGUIAtlasWrap.widget == null)) ? nGUIAtlasWrap.widget.height : 0);
				LuaDLL.lua_pushnumber(L, num);
				LuaDLL.lua_pushnumber(L, num2);
				result = 2;
			}
			return result;
		}

		[MonoPInvokeCallback(typeof(LuaCSFunction))]
		private static int get_game_object(IntPtr L)
		{
			int result = 0;
			if (WraperUtil.ValidIsUserdata(L, 1, string_get_game_object))
			{
				NGUIAtlasWrap nGUIAtlasWrap = null;
				nGUIAtlasWrap = WraperUtil.LuaToUserdata(L, 1, string_get_game_object, NGUIAtlasWrap.cache);
				AssetGameObject base_object = AssetGameObject.CreateByInstance(nGUIAtlasWrap.bcomponent.gameObject);
				WraperUtil.PushObject(L, base_object);
				result = 1;
			}
			return result;
		}

		[MonoPInvokeCallback(typeof(LuaCSFunction))]
		private static int get_parent(IntPtr L)
		{
			int result = 0;
			if (WraperUtil.ValidIsUserdata(L, 1, string_get_parent))
			{
				NGUIAtlasWrap nGUIAtlasWrap = null;
				nGUIAtlasWrap = WraperUtil.LuaToUserdata(L, 1, string_get_parent, NGUIAtlasWrap.cache);
				AssetGameObject assetGameObject = null;
				Transform parent = nGUIAtlasWrap.bcomponent.gameObject.transform.parent;
				if (parent != null)
				{
					assetGameObject = AssetGameObject.CreateByInstance(parent.gameObject);
				}
				if (assetGameObject != null)
				{
					WraperUtil.PushObject(L, assetGameObject);
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
		private static int set_parent(IntPtr L)
		{
			int result = 0;
			if (WraperUtil.ValidIsUserdata(L, 1, string_set_parent) && WraperUtil.ValidIsUserdataOrNil(L, 2, string_set_parent))
			{
				NGUIAtlasWrap nGUIAtlasWrap = null;
				AssetGameObject assetGameObject = null;
				nGUIAtlasWrap = WraperUtil.LuaToUserdata(L, 1, string_set_parent, NGUIAtlasWrap.cache);
				assetGameObject = WraperUtil.LuaToUserdataOrNil(L, 2, string_set_parent, AssetGameObject.cache);
				nGUIAtlasWrap.bcomponent.gameObject.transform.parent = ((assetGameObject != null) ? assetGameObject.transform : null);
				result = 0;
			}
			return result;
		}

		[MonoPInvokeCallback(typeof(LuaCSFunction))]
		private static int clone(IntPtr L)
		{
			int result = 0;
			if (WraperUtil.ValidIsUserdata(L, 1, string_clone))
			{
				NGUIAtlasWrap nGUIAtlasWrap = null;
				nGUIAtlasWrap = WraperUtil.LuaToUserdata(L, 1, string_clone, NGUIAtlasWrap.cache);
				nGUIAtlasWrap.Clone(L);
				result = 1;
			}
			return result;
		}

		[MonoPInvokeCallback(typeof(LuaCSFunction))]
		private static int destroy_object(IntPtr L)
		{
			int result = 0;
			if (WraperUtil.ValidIsUserdata(L, 1, string_destroy_object))
			{
				NGUIAtlasWrap nGUIAtlasWrap = null;
				nGUIAtlasWrap = WraperUtil.LuaToUserdata(L, 1, string_destroy_object, NGUIAtlasWrap.cache);
				nGUIAtlasWrap.isNeedDestroy = true;
				result = 0;
			}
			return result;
		}

		[MonoPInvokeCallback(typeof(LuaCSFunction))]
		private static int get_pixel_size(IntPtr L)
		{
			int result = 0;
			if (WraperUtil.ValidIsUserdata(L, 1, string_get_pixel_size))
			{
				NGUIAtlasWrap nGUIAtlasWrap = null;
				nGUIAtlasWrap = WraperUtil.LuaToUserdata(L, 1, string_get_pixel_size, NGUIAtlasWrap.cache);
				LuaDLL.lua_pushnumber(L, nGUIAtlasWrap.component.pixelSize);
				result = 1;
			}
			return result;
		}

		[MonoPInvokeCallback(typeof(LuaCSFunction))]
		private static int set_material(IntPtr L)
		{
			int result = 0;
			if (WraperUtil.ValidIsUserdata(L, 1, string_set_material) && WraperUtil.ValidIsUserdata(L, 2, string_set_material))
			{
				NGUIAtlasWrap nGUIAtlasWrap = null;
				MaterialWrap materialWrap = null;
				nGUIAtlasWrap = WraperUtil.LuaToUserdata(L, 1, string_set_material, NGUIAtlasWrap.cache);
				materialWrap = WraperUtil.LuaToUserdata(L, 2, string_set_material, MaterialWrap.cache);
				nGUIAtlasWrap.component.spriteMaterial = materialWrap.material;
				result = 0;
			}
			return result;
		}

		[MonoPInvokeCallback(typeof(LuaCSFunction))]
		private static int replace_texture(IntPtr L)
		{
			int result = 0;
			if (WraperUtil.ValidIsUserdata(L, 1, string_replace_texture) && WraperUtil.ValidIsString(L, 2, string_replace_texture) && WraperUtil.ValidIsUserdata(L, 3, string_replace_texture))
			{
				NGUIAtlasWrap nGUIAtlasWrap = null;
				string text = null;
				TextureWrap textureWrap = null;
				nGUIAtlasWrap = WraperUtil.LuaToUserdata(L, 1, string_replace_texture, NGUIAtlasWrap.cache);
				text = LuaDLL.lua_tostring(L, 2);
				textureWrap = WraperUtil.LuaToUserdata(L, 3, string_replace_texture, TextureWrap.cache);
				for (int i = 0; i < nGUIAtlasWrap.component.spriteList.Count; i++)
				{
					if (nGUIAtlasWrap.component.spriteList[i].name == text)
					{
						UISpriteData uISpriteData = nGUIAtlasWrap.component.spriteList[i];
						nGUIAtlasWrap.component.spriteList[i].name = textureWrap.component.name;
						Texture2D texture2D = nGUIAtlasWrap.component.spriteMaterial.mainTexture as Texture2D;
						Color[] pixels = ((Texture2D)textureWrap.component).GetPixels();
						texture2D.SetPixels(uISpriteData.x, texture2D.height - uISpriteData.y - uISpriteData.height, uISpriteData.width, uISpriteData.height, pixels);
						texture2D.Apply();
						nGUIAtlasWrap.component.spriteMaterial.mainTexture = texture2D;
						break;
					}
				}
				result = 0;
			}
			return result;
		}

		[MonoPInvokeCallback(typeof(LuaCSFunction))]
		private static int gc(IntPtr L)
		{
			NGUIAtlasWrap nGUIAtlasWrap = WraperUtil.LuaToUserdataByGc(L, 1, "gc ngui_atlas", NGUIAtlasWrap.cache);
			if (nGUIAtlasWrap != null)
			{
				nGUIAtlasWrap.DestroyInstance();
			}
			return 0;
		}
	}
}
