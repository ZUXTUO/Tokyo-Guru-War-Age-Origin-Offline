using System;
using Core.Unity;
using LuaInterface;
using UnityEngine;
using UnityWrap;

namespace Wraper
{
	public class ngui_texture_wraper
	{
		public static string name = "ngui_texture";

		private static luaL_Reg[] func = new luaL_Reg[27]
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
			new luaL_Reg("set_texture", set_texture),
			new luaL_Reg("set_render_texture", set_render_texture),
			new luaL_Reg("get_texture", get_texture),
			new luaL_Reg("clear_texture", clear_texture),
			new luaL_Reg("set_color", set_color),
			new luaL_Reg("get_color", get_color),
			new luaL_Reg("get_fill_amout", get_fill_amout),
			new luaL_Reg("set_fill_amout", set_fill_amout),
			new luaL_Reg("set_fill_direction", set_fill_direction),
			new luaL_Reg("set_material", set_material),
			new luaL_Reg("get_material", get_material),
			new luaL_Reg("set_shader", set_shader),
			new luaL_Reg("get_shader", get_shader),
			new luaL_Reg("set_enable", set_enable),
			new luaL_Reg("get_enable", get_enable)
		};

		private static string string_get_pid = "ngui_texture:get_pid";

		private static string string_set_active = "ngui_texture:set_active";

		private static string string_set_name = "ngui_texture:set_name";

		private static string string_get_name = "ngui_texture:get_name";

		private static string string_set_position = "ngui_texture:set_position";

		private static string string_get_position = "ngui_texture:get_position";

		private static string string_get_size = "ngui_texture:get_size";

		private static string string_get_game_object = "ngui_texture:get_game_object";

		private static string string_get_parent = "ngui_texture:get_parent";

		private static string string_set_parent = "ngui_texture:set_parent";

		private static string string_clone = "ngui_texture:clone";

		private static string string_destroy_object = "ngui_texture:destroy_object";

		private static string string_set_texture = "ngui_texture:set_texture";

		private static string string_set_render_texture = "ngui_texture:set_render_texture";

		private static string string_get_texture = "ngui_texture:get_texture";

		private static string string_clear_texture = "ngui_texture:clear_texture";

		private static string string_set_color = "ngui_texture:set_color";

		private static string string_get_color = "ngui_texture:get_color";

		private static string string_get_fill_amout = "ngui_texture:get_fill_amout";

		private static string string_set_fill_amout = "ngui_texture:set_fill_amout";

		private static string string_set_fill_direction = "ngui_texture:set_fill_direction";

		private static string string_set_material = "ngui_texture:set_material";

		private static string string_get_material = "ngui_texture:get_material";

		private static string string_set_shader = "ngui_texture:set_shader";

		private static string string_get_shader = "ngui_texture:get_shader";

		private static string string_set_enable = "ngui_texture:set_enable";

		private static string string_get_enable = "ngui_texture:get_enable";

		public static bool init(IntPtr L)
		{
			if (L != IntPtr.Zero)
			{
				LuaDLL.register_class(L, name, func, gc);
				return true;
			}
			return false;
		}

		public static void push(IntPtr L, NGUITextureWrap obj)
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
		private static int get_pid(IntPtr L)
		{
			int result = 0;
			if (WraperUtil.ValidIsUserdata(L, 1, string_get_pid))
			{
				NGUITextureWrap nGUITextureWrap = null;
				nGUITextureWrap = WraperUtil.LuaToUserdata(L, 1, string_get_pid, NGUITextureWrap.cache);
				LuaDLL.lua_pushnumber(L, nGUITextureWrap.GetPid());
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
				NGUITextureWrap nGUITextureWrap = null;
				bool flag = false;
				nGUITextureWrap = WraperUtil.LuaToUserdata(L, 1, string_set_active, NGUITextureWrap.cache);
				flag = LuaDLL.lua_toboolean(L, 2);
				nGUITextureWrap.bcomponent.gameObject.SetActive(flag);
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
				NGUITextureWrap nGUITextureWrap = null;
				string text = null;
				nGUITextureWrap = WraperUtil.LuaToUserdata(L, 1, string_set_name, NGUITextureWrap.cache);
				text = LuaDLL.lua_tostring(L, 2);
				nGUITextureWrap.bcomponent.gameObject.name = text;
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
				NGUITextureWrap nGUITextureWrap = null;
				nGUITextureWrap = WraperUtil.LuaToUserdata(L, 1, string_get_name, NGUITextureWrap.cache);
				LuaDLL.lua_pushstring(L, nGUITextureWrap.bcomponent.gameObject.name);
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
				NGUITextureWrap nGUITextureWrap = null;
				float num = 0f;
				float num2 = 0f;
				float num3 = 0f;
				nGUITextureWrap = WraperUtil.LuaToUserdata(L, 1, string_set_position, NGUITextureWrap.cache);
				num = (float)LuaDLL.lua_tonumber(L, 2);
				num2 = (float)LuaDLL.lua_tonumber(L, 3);
				num3 = (float)LuaDLL.lua_tonumber(L, 4);
				nGUITextureWrap.bcomponent.gameObject.transform.localPosition = new Vector3(num, num2, num3);
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
				NGUITextureWrap nGUITextureWrap = null;
				nGUITextureWrap = WraperUtil.LuaToUserdata(L, 1, string_get_position, NGUITextureWrap.cache);
				Vector3 localPosition = nGUITextureWrap.bcomponent.gameObject.transform.localPosition;
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
				NGUITextureWrap nGUITextureWrap = null;
				nGUITextureWrap = WraperUtil.LuaToUserdata(L, 1, string_get_size, NGUITextureWrap.cache);
				int num = ((!(nGUITextureWrap.widget == null)) ? nGUITextureWrap.widget.width : 0);
				int num2 = ((!(nGUITextureWrap.widget == null)) ? nGUITextureWrap.widget.height : 0);
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
				NGUITextureWrap nGUITextureWrap = null;
				nGUITextureWrap = WraperUtil.LuaToUserdata(L, 1, string_get_game_object, NGUITextureWrap.cache);
				if (nGUITextureWrap != null && nGUITextureWrap.bcomponent != null)
				{
					AssetGameObject base_object = AssetGameObject.CreateByInstance(nGUITextureWrap.bcomponent.gameObject);
					WraperUtil.PushObject(L, base_object);
				}
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
				NGUITextureWrap nGUITextureWrap = null;
				nGUITextureWrap = WraperUtil.LuaToUserdata(L, 1, string_get_parent, NGUITextureWrap.cache);
				AssetGameObject assetGameObject = null;
				Transform parent = nGUITextureWrap.bcomponent.gameObject.transform.parent;
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
				NGUITextureWrap nGUITextureWrap = null;
				AssetGameObject assetGameObject = null;
				nGUITextureWrap = WraperUtil.LuaToUserdata(L, 1, string_set_parent, NGUITextureWrap.cache);
				assetGameObject = WraperUtil.LuaToUserdataOrNil(L, 2, string_set_parent, AssetGameObject.cache);
				nGUITextureWrap.bcomponent.gameObject.transform.parent = ((assetGameObject != null) ? assetGameObject.transform : null);
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
				NGUITextureWrap nGUITextureWrap = null;
				nGUITextureWrap = WraperUtil.LuaToUserdata(L, 1, string_clone, NGUITextureWrap.cache);
				nGUITextureWrap.Clone(L);
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
				NGUITextureWrap nGUITextureWrap = null;
				nGUITextureWrap = WraperUtil.LuaToUserdata(L, 1, string_destroy_object, NGUITextureWrap.cache);
				nGUITextureWrap.isNeedDestroy = true;
				result = 0;
			}
			return result;
		}

		[MonoPInvokeCallback(typeof(LuaCSFunction))]
		private static int set_texture(IntPtr L)
		{
			int result = 0;
			if (WraperUtil.ValidIsUserdata(L, 1, string_set_texture) && WraperUtil.ValidIsUserdata(L, 2, string_set_texture))
			{
				NGUITextureWrap nGUITextureWrap = null;
				TextureWrap textureWrap = null;
				nGUITextureWrap = WraperUtil.LuaToUserdata(L, 1, string_set_texture, NGUITextureWrap.cache);
				textureWrap = WraperUtil.LuaToUserdata(L, 2, string_set_texture, TextureWrap.cache);
				nGUITextureWrap.component.mainTexture = textureWrap.component;
				nGUITextureWrap.component.mainTexture.wrapMode = TextureWrapMode.Clamp;
				result = 0;
			}
			return result;
		}

		[MonoPInvokeCallback(typeof(LuaCSFunction))]
		private static int set_render_texture(IntPtr L)
		{
			int result = 0;
			if (WraperUtil.ValidIsUserdata(L, 1, string_set_render_texture) && WraperUtil.ValidIsUserdata(L, 2, string_set_render_texture))
			{
				NGUITextureWrap nGUITextureWrap = null;
				RenderTextureWrap renderTextureWrap = null;
				nGUITextureWrap = WraperUtil.LuaToUserdata(L, 1, string_set_render_texture, NGUITextureWrap.cache);
				renderTextureWrap = WraperUtil.LuaToUserdata(L, 2, string_set_render_texture, RenderTextureWrap.cache);
				nGUITextureWrap.component.mainTexture = renderTextureWrap.component;
				nGUITextureWrap.component.mainTexture.wrapMode = TextureWrapMode.Clamp;
				result = 0;
			}
			return result;
		}

		[MonoPInvokeCallback(typeof(LuaCSFunction))]
		private static int get_texture(IntPtr L)
		{
			int result = 0;
			if (WraperUtil.ValidIsUserdata(L, 1, string_get_texture))
			{
				NGUITextureWrap nGUITextureWrap = null;
				nGUITextureWrap = WraperUtil.LuaToUserdata(L, 1, string_get_texture, NGUITextureWrap.cache);
				WraperUtil.PushObject(L, TextureWrap.CreateInstance(nGUITextureWrap.component.mainTexture));
				result = 1;
			}
			return result;
		}

		[MonoPInvokeCallback(typeof(LuaCSFunction))]
		private static int clear_texture(IntPtr L)
		{
			int result = 0;
			if (WraperUtil.ValidIsUserdata(L, 1, string_clear_texture))
			{
				NGUITextureWrap nGUITextureWrap = null;
				nGUITextureWrap = WraperUtil.LuaToUserdata(L, 1, string_clear_texture, NGUITextureWrap.cache);
				nGUITextureWrap.component.mainTexture = null;
				result = 0;
			}
			return result;
		}

		[MonoPInvokeCallback(typeof(LuaCSFunction))]
		private static int set_color(IntPtr L)
		{
			int result = 0;
			if (WraperUtil.ValidIsUserdata(L, 1, string_set_color) && WraperUtil.ValidIsNumber(L, 2, string_set_color) && WraperUtil.ValidIsNumber(L, 3, string_set_color) && WraperUtil.ValidIsNumber(L, 4, string_set_color) && WraperUtil.ValidIsNumber(L, 5, string_set_color))
			{
				NGUITextureWrap nGUITextureWrap = null;
				float num = 0f;
				float num2 = 0f;
				float num3 = 0f;
				float num4 = 0f;
				nGUITextureWrap = WraperUtil.LuaToUserdata(L, 1, string_set_color, NGUITextureWrap.cache);
				num = (float)LuaDLL.lua_tonumber(L, 2);
				num2 = (float)LuaDLL.lua_tonumber(L, 3);
				num3 = (float)LuaDLL.lua_tonumber(L, 4);
				num4 = (float)LuaDLL.lua_tonumber(L, 5);
				nGUITextureWrap.component.color = new Color(num, num2, num3, num4);
				result = 0;
			}
			return result;
		}

		[MonoPInvokeCallback(typeof(LuaCSFunction))]
		private static int get_color(IntPtr L)
		{
			int result = 0;
			if (WraperUtil.ValidIsUserdata(L, 1, string_get_color))
			{
				NGUITextureWrap nGUITextureWrap = null;
				nGUITextureWrap = WraperUtil.LuaToUserdata(L, 1, string_get_color, NGUITextureWrap.cache);
				LuaDLL.lua_pushnumber(L, nGUITextureWrap.component.color.r);
				LuaDLL.lua_pushnumber(L, nGUITextureWrap.component.color.g);
				LuaDLL.lua_pushnumber(L, nGUITextureWrap.component.color.b);
				LuaDLL.lua_pushnumber(L, nGUITextureWrap.component.color.a);
				result = 4;
			}
			return result;
		}

		[MonoPInvokeCallback(typeof(LuaCSFunction))]
		private static int get_fill_amout(IntPtr L)
		{
			int result = 0;
			if (WraperUtil.ValidIsUserdata(L, 1, string_get_fill_amout))
			{
				NGUITextureWrap nGUITextureWrap = null;
				nGUITextureWrap = WraperUtil.LuaToUserdata(L, 1, string_get_fill_amout, NGUITextureWrap.cache);
				if (nGUITextureWrap.component == null)
				{
					Core.Unity.Debug.LogError("[ngui_texture_wraper get_fill_amout] error: component is null");
				}
				else
				{
					LuaDLL.lua_pushnumber(L, nGUITextureWrap.component.fillAmount);
					result = 1;
				}
			}
			return result;
		}

		[MonoPInvokeCallback(typeof(LuaCSFunction))]
		private static int set_fill_amout(IntPtr L)
		{
			int result = 0;
			if (WraperUtil.ValidIsUserdata(L, 1, string_set_fill_amout) && WraperUtil.ValidIsNumber(L, 2, string_set_fill_amout))
			{
				NGUITextureWrap nGUITextureWrap = null;
				float num = 0f;
				nGUITextureWrap = WraperUtil.LuaToUserdata(L, 1, string_set_fill_amout, NGUITextureWrap.cache);
				num = (float)LuaDLL.lua_tonumber(L, 2);
				if (nGUITextureWrap.component == null)
				{
					Core.Unity.Debug.LogError("[ngui_texture_wraper set_fill_amout] error: component is null");
				}
				else
				{
					nGUITextureWrap.component.fillAmount = num;
					result = 0;
				}
			}
			return result;
		}

		[MonoPInvokeCallback(typeof(LuaCSFunction))]
		private static int set_fill_direction(IntPtr L)
		{
			int result = 0;
			if (WraperUtil.ValidIsUserdata(L, 1, string_set_fill_direction) && WraperUtil.ValidIsNumber(L, 2, string_set_fill_direction))
			{
				NGUITextureWrap nGUITextureWrap = null;
				int num = 0;
				nGUITextureWrap = WraperUtil.LuaToUserdata(L, 1, string_set_fill_direction, NGUITextureWrap.cache);
				num = (int)LuaDLL.lua_tonumber(L, 2);
				if (num < 1 || num > 5)
				{
					Core.Unity.Debug.LogError("[ngui_texture_wraper set_fill_direction] error: direction should between 1 ~ 5");
				}
				else if (nGUITextureWrap.component == null)
				{
					Core.Unity.Debug.LogError("[ngui_texture_wraper set_fill_direction] error: component is null");
				}
				else
				{
					nGUITextureWrap.component.fillDirection = (UIBasicSprite.FillDirection)num;
					result = 0;
				}
			}
			return result;
		}

		[MonoPInvokeCallback(typeof(LuaCSFunction))]
		private static int set_material(IntPtr L)
		{
			int result = 0;
			if (WraperUtil.ValidIsUserdata(L, 1, string_set_material) && WraperUtil.ValidIsUserdata(L, 2, string_set_material))
			{
				NGUITextureWrap nGUITextureWrap = null;
				MaterialWrap materialWrap = null;
				nGUITextureWrap = WraperUtil.LuaToUserdata(L, 1, string_set_material, NGUITextureWrap.cache);
				materialWrap = WraperUtil.LuaToUserdata(L, 2, string_set_material, MaterialWrap.cache);
				nGUITextureWrap.component.material = materialWrap.material;
				result = 0;
			}
			return result;
		}

		[MonoPInvokeCallback(typeof(LuaCSFunction))]
		private static int get_material(IntPtr L)
		{
			int result = 0;
			if (WraperUtil.ValidIsUserdata(L, 1, string_get_material))
			{
				NGUITextureWrap nGUITextureWrap = null;
				nGUITextureWrap = WraperUtil.LuaToUserdata(L, 1, string_get_material, NGUITextureWrap.cache);
				WraperUtil.PushObject(L, MaterialWrap.CreateInstance(nGUITextureWrap.component.material));
				result = 1;
			}
			return result;
		}

		[MonoPInvokeCallback(typeof(LuaCSFunction))]
		private static int set_shader(IntPtr L)
		{
			int result = 0;
			if (WraperUtil.ValidIsUserdata(L, 1, string_set_shader) && WraperUtil.ValidIsUserdata(L, 2, string_set_shader))
			{
				NGUITextureWrap nGUITextureWrap = null;
				ShaderWrap shaderWrap = null;
				nGUITextureWrap = WraperUtil.LuaToUserdata(L, 1, string_set_shader, NGUITextureWrap.cache);
				shaderWrap = WraperUtil.LuaToUserdata(L, 2, string_set_shader, ShaderWrap.cache);
				nGUITextureWrap.component.shader = shaderWrap.component;
				result = 0;
			}
			return result;
		}

		[MonoPInvokeCallback(typeof(LuaCSFunction))]
		private static int get_shader(IntPtr L)
		{
			int result = 0;
			if (WraperUtil.ValidIsUserdata(L, 1, string_get_shader))
			{
				NGUITextureWrap nGUITextureWrap = null;
				nGUITextureWrap = WraperUtil.LuaToUserdata(L, 1, string_get_shader, NGUITextureWrap.cache);
				WraperUtil.PushObject(L, ShaderWrap.CreateInstance(nGUITextureWrap.component.shader));
				result = 1;
			}
			return result;
		}

		[MonoPInvokeCallback(typeof(LuaCSFunction))]
		private static int gc(IntPtr L)
		{
			NGUITextureWrap nGUITextureWrap = WraperUtil.LuaToUserdataByGc(L, 1, "gc ngui_texture", NGUITextureWrap.cache);
			if (nGUITextureWrap != null)
			{
				nGUITextureWrap.DestroyInstance();
			}
			return 0;
		}

		[MonoPInvokeCallback(typeof(LuaCSFunction))]
		private static int set_enable(IntPtr L)
		{
			int result = 0;
			if (WraperUtil.ValidIsUserdata(L, 1, string_set_enable) && WraperUtil.ValidIsBoolean(L, 2, string_set_enable))
			{
				NGUITextureWrap nGUITextureWrap = null;
				bool flag = false;
				nGUITextureWrap = WraperUtil.LuaToUserdata(L, 1, string_set_enable, NGUITextureWrap.cache);
				flag = LuaDLL.lua_toboolean(L, 2);
				nGUITextureWrap.component.enabled = flag;
				result = 0;
			}
			return result;
		}

		[MonoPInvokeCallback(typeof(LuaCSFunction))]
		private static int get_enable(IntPtr L)
		{
			int result = 0;
			if (WraperUtil.ValidIsUserdata(L, 1, string_get_enable))
			{
				NGUITextureWrap nGUITextureWrap = WraperUtil.LuaToUserdata(L, 1, string_get_enable, NGUITextureWrap.cache);
				LuaDLL.lua_pushboolean(L, nGUITextureWrap.component.enabled);
				result = 1;
			}
			return result;
		}
	}
}
