using System;
using LuaInterface;
using UnityEngine;
using UnityWrap;

namespace Wraper
{
	public class ngui_sprite_animation_wraper
	{
		public static string name = "ngui_sprite_animation";

		private static luaL_Reg[] func = new luaL_Reg[14]
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
			new luaL_Reg("pause", pause),
			new luaL_Reg("reset_to_beginning", reset_to_beginning)
		};

		private static string string_get_pid = "ngui_sprite_animation:get_pid";

		private static string string_set_active = "ngui_sprite_animation:set_active";

		private static string string_set_name = "ngui_sprite_animation:set_name";

		private static string string_get_name = "ngui_sprite_animation:get_name";

		private static string string_set_position = "ngui_sprite_animation:set_position";

		private static string string_get_position = "ngui_sprite_animation:get_position";

		private static string string_get_size = "ngui_sprite_animation:get_size";

		private static string string_get_game_object = "ngui_sprite_animation:get_game_object";

		private static string string_get_parent = "ngui_sprite_animation:get_parent";

		private static string string_set_parent = "ngui_sprite_animation:set_parent";

		private static string string_clone = "ngui_sprite_animation:clone";

		private static string string_destroy_object = "ngui_sprite_animation:destroy_object";

		private static string string_pause = "ngui_sprite_animation:pause";

		private static string string_reset_to_beginning = "ngui_sprite_animation:reset_to_beginning";

		public static bool init(IntPtr L)
		{
			if (L != IntPtr.Zero)
			{
				LuaDLL.register_class(L, name, func, gc);
				return true;
			}
			return false;
		}

		public static void push(IntPtr L, NGUITweenColorWrap obj)
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
				NGUISpriteAnimationWrap nGUISpriteAnimationWrap = null;
				nGUISpriteAnimationWrap = WraperUtil.LuaToUserdata(L, 1, string_get_pid, NGUISpriteAnimationWrap.cache);
				LuaDLL.lua_pushnumber(L, nGUISpriteAnimationWrap.GetPid());
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
				NGUISpriteAnimationWrap nGUISpriteAnimationWrap = null;
				bool flag = false;
				nGUISpriteAnimationWrap = WraperUtil.LuaToUserdata(L, 1, string_set_active, NGUISpriteAnimationWrap.cache);
				flag = LuaDLL.lua_toboolean(L, 2);
				nGUISpriteAnimationWrap.bcomponent.gameObject.SetActive(flag);
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
				NGUISpriteAnimationWrap nGUISpriteAnimationWrap = null;
				string text = null;
				nGUISpriteAnimationWrap = WraperUtil.LuaToUserdata(L, 1, string_set_name, NGUISpriteAnimationWrap.cache);
				text = LuaDLL.lua_tostring(L, 2);
				nGUISpriteAnimationWrap.bcomponent.gameObject.name = text;
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
				NGUISpriteAnimationWrap nGUISpriteAnimationWrap = null;
				nGUISpriteAnimationWrap = WraperUtil.LuaToUserdata(L, 1, string_get_name, NGUISpriteAnimationWrap.cache);
				LuaDLL.lua_pushstring(L, nGUISpriteAnimationWrap.bcomponent.gameObject.name);
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
				NGUISpriteAnimationWrap nGUISpriteAnimationWrap = null;
				float num = 0f;
				float num2 = 0f;
				float num3 = 0f;
				nGUISpriteAnimationWrap = WraperUtil.LuaToUserdata(L, 1, string_set_position, NGUISpriteAnimationWrap.cache);
				num = (float)LuaDLL.lua_tonumber(L, 2);
				num2 = (float)LuaDLL.lua_tonumber(L, 3);
				num3 = (float)LuaDLL.lua_tonumber(L, 4);
				nGUISpriteAnimationWrap.bcomponent.gameObject.transform.localPosition = new Vector3(num, num2, num3);
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
				NGUISpriteAnimationWrap nGUISpriteAnimationWrap = null;
				nGUISpriteAnimationWrap = WraperUtil.LuaToUserdata(L, 1, string_get_position, NGUISpriteAnimationWrap.cache);
				Vector3 localPosition = nGUISpriteAnimationWrap.bcomponent.gameObject.transform.localPosition;
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
				NGUISpriteAnimationWrap nGUISpriteAnimationWrap = null;
				nGUISpriteAnimationWrap = WraperUtil.LuaToUserdata(L, 1, string_get_size, NGUISpriteAnimationWrap.cache);
				int num = ((!(nGUISpriteAnimationWrap.widget == null)) ? nGUISpriteAnimationWrap.widget.width : 0);
				int num2 = ((!(nGUISpriteAnimationWrap.widget == null)) ? nGUISpriteAnimationWrap.widget.height : 0);
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
				NGUISpriteAnimationWrap nGUISpriteAnimationWrap = null;
				nGUISpriteAnimationWrap = WraperUtil.LuaToUserdata(L, 1, string_get_game_object, NGUISpriteAnimationWrap.cache);
				AssetGameObject base_object = AssetGameObject.CreateByInstance(nGUISpriteAnimationWrap.bcomponent.gameObject);
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
				NGUISpriteAnimationWrap nGUISpriteAnimationWrap = null;
				nGUISpriteAnimationWrap = WraperUtil.LuaToUserdata(L, 1, string_get_parent, NGUISpriteAnimationWrap.cache);
				AssetGameObject assetGameObject = null;
				Transform parent = nGUISpriteAnimationWrap.bcomponent.gameObject.transform.parent;
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
				NGUISpriteAnimationWrap nGUISpriteAnimationWrap = null;
				AssetGameObject assetGameObject = null;
				nGUISpriteAnimationWrap = WraperUtil.LuaToUserdata(L, 1, string_set_parent, NGUISpriteAnimationWrap.cache);
				assetGameObject = WraperUtil.LuaToUserdataOrNil(L, 2, string_set_parent, AssetGameObject.cache);
				nGUISpriteAnimationWrap.bcomponent.gameObject.transform.parent = ((assetGameObject != null) ? assetGameObject.transform : null);
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
				NGUISpriteAnimationWrap nGUISpriteAnimationWrap = null;
				nGUISpriteAnimationWrap = WraperUtil.LuaToUserdata(L, 1, string_clone, NGUISpriteAnimationWrap.cache);
				nGUISpriteAnimationWrap.Clone(L);
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
				NGUISpriteAnimationWrap nGUISpriteAnimationWrap = null;
				nGUISpriteAnimationWrap = WraperUtil.LuaToUserdata(L, 1, string_destroy_object, NGUISpriteAnimationWrap.cache);
				nGUISpriteAnimationWrap.isNeedDestroy = true;
				result = 0;
			}
			return result;
		}

		[MonoPInvokeCallback(typeof(LuaCSFunction))]
		private static int pause(IntPtr L)
		{
			int result = 0;
			if (WraperUtil.ValidIsUserdata(L, 1, string_pause))
			{
				NGUISpriteAnimationWrap nGUISpriteAnimationWrap = null;
				nGUISpriteAnimationWrap = WraperUtil.LuaToUserdata(L, 1, string_pause, NGUISpriteAnimationWrap.cache);
				nGUISpriteAnimationWrap.component.Pause();
				result = 0;
			}
			return result;
		}

		[MonoPInvokeCallback(typeof(LuaCSFunction))]
		private static int reset_to_beginning(IntPtr L)
		{
			int result = 0;
			if (WraperUtil.ValidIsUserdata(L, 1, string_reset_to_beginning))
			{
				NGUISpriteAnimationWrap nGUISpriteAnimationWrap = null;
				nGUISpriteAnimationWrap = WraperUtil.LuaToUserdata(L, 1, string_reset_to_beginning, NGUISpriteAnimationWrap.cache);
				nGUISpriteAnimationWrap.component.ResetToBeginning();
				result = 0;
			}
			return result;
		}

		[MonoPInvokeCallback(typeof(LuaCSFunction))]
		private static int gc(IntPtr L)
		{
			NGUISpriteAnimationWrap nGUISpriteAnimationWrap = WraperUtil.LuaToUserdataByGc(L, 1, "gc ngui_sprite_animation", NGUISpriteAnimationWrap.cache);
			if (nGUISpriteAnimationWrap != null)
			{
				nGUISpriteAnimationWrap.DestroyInstance();
			}
			return 0;
		}
	}
}
