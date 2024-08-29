using System;
using System.IO;
using Core.Net;
using Core.Resource;
using LuaInterface;
using SNet;
using UnityWrap;

namespace Wraper
{
	public class gnet_wraper
	{
		public static string name = "client_object";

		public static string libname = "gnet";

		private static luaL_Reg[] libfunc = new luaL_Reg[7]
		{
			new luaL_Reg("create", create),
			new luaL_Reg("load_des", load_des),
			new luaL_Reg("set_listener", set_listener),
			new luaL_Reg("set_on_send", set_on_send),
			new luaL_Reg("set_on_receive", set_on_receive),
			new luaL_Reg("send", send),
			new luaL_Reg("set_next_ext_data", set_next_ext_data)
		};

		private static luaL_Reg[] func = new luaL_Reg[6]
		{
			new luaL_Reg("get_socket_id", get_socket_id),
			new luaL_Reg("asyc_connection", asyc_connection),
			new luaL_Reg("asyc_connection_ex", asyc_connection_ex),
			new luaL_Reg("asyc_connection_ex2", asyc_connection_ex2),
			new luaL_Reg("set_dispatch_func", set_dispatch_func),
			new luaL_Reg("close", close)
		};

		private static string string_load_des = "gnet.load_des";

		private static string string_set_listener = "gnet.set_listener";

		private static string string_set_on_send = "gnet.set_on_send";

		private static string string_set_on_receive = "gnet.set_on_receive";

		private static string string_send = "gnet.send";

		private static string string_set_next_ext_data = "gnet.set_next_ext_data";

		private static string string_get_socket_id = "client_object:get_socket_id";

		private static string string_asyc_connection = "client_object:asyc_connection";

		private static string string_asyc_connection_ex = "client_object:asyc_connection_ex";

		private static string string_asyc_connection_ex2 = "client_object:asyc_connection_ex2";

		private static string string_set_dispatch_func = "client_object.set_dispatch_func";

		private static string string_close = "client_object:close";

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

		public static void push(IntPtr L, ClientObject obj)
		{
			if (obj == null)
			{
				LuaDLL.lua_pushnil(L);
				return;
			}
			obj.AddRef();
			LuaDLL.use_lua_newuserdata_ex(L, 4, obj.GetPid());
			LuaDLL.lua_getfield(L, LuaIndexes.LUA_REGISTRYINDEX, name);
			LuaDLL.lua_setmetatable(L, -2);
		}

		[MonoPInvokeCallback(typeof(LuaCSFunction))]
		private static int create(IntPtr L)
		{
			int num = 0;
			ClientObject clientObject = ClientObject.CreateInstance();
			push(L, clientObject);
			clientObject.DelRef();
			return 1;
		}

		[MonoPInvokeCallback(typeof(LuaCSFunction))]
		private static int load_des(IntPtr L)
		{
			int result = 0;
			if (WraperUtil.ValidIsString(L, 1, string_load_des))
			{
				string text = null;
				text = LuaDLL.lua_tostring(L, 1);
				byte[] array = ResourceManager.GetInstance().LoadResourceByWWW(text);
				if (array != null)
				{
					using (MemoryStream s = new MemoryStream(array))
					{
						NModuleManager.GetInstance().Load(s, true);
					}
				}
				result = 0;
			}
			return result;
		}

		[MonoPInvokeCallback(typeof(LuaCSFunction))]
		private static int set_listener(IntPtr L)
		{
			int result = 0;
			if (WraperUtil.ValidIsString(L, 1, string_set_listener) && WraperUtil.ValidIsString(L, 2, string_set_listener) && WraperUtil.ValidIsString(L, 3, string_set_listener))
			{
				string text = null;
				string text2 = null;
				string text3 = null;
				text = LuaDLL.lua_tostring(L, 1);
				text2 = LuaDLL.lua_tostring(L, 2);
				text3 = LuaDLL.lua_tostring(L, 3);
				net_process instance = net_process.GetInstance();
				instance.SetListener(text, text2, text3);
				result = 0;
			}
			return result;
		}

		[MonoPInvokeCallback(typeof(LuaCSFunction))]
		private static int set_on_send(IntPtr L)
		{
			int result = 0;
			if (WraperUtil.ValidIsString(L, 1, string_set_on_send))
			{
				string text = null;
				text = LuaDLL.lua_tostring(L, 1);
				net_process instance = net_process.GetInstance();
				instance.SetOnSend(text);
				result = 0;
			}
			return result;
		}

		[MonoPInvokeCallback(typeof(LuaCSFunction))]
		private static int set_on_receive(IntPtr L)
		{
			int result = 0;
			if (WraperUtil.ValidIsString(L, 1, string_set_on_receive))
			{
				string text = null;
				text = LuaDLL.lua_tostring(L, 1);
				net_process instance = net_process.GetInstance();
				instance.SetOnReceive(text);
				result = 0;
			}
			return result;
		}

		[MonoPInvokeCallback(typeof(LuaCSFunction))]
		private static int send(IntPtr L)
		{
			int result = 0;
			if (WraperUtil.ValidIsUserdata(L, 1, string_send) && WraperUtil.ValidIsNumber(L, 2, string_send))
			{
				ClientObject clientObject = null;
				int num = 0;
				clientObject = WraperUtil.LuaToUserdata(L, 1, string_send, ClientObject.cache);
				num = (int)LuaDLL.lua_tonumber(L, 2);
				if (clientObject != null && clientObject.client != null)
				{
					uint num2 = net_process.GetInstance().Send(clientObject.client, num, L);
					LuaDLL.lua_pushnumber(L, num2);
				}
				else
				{
					LuaDLL.lua_pushnumber(L, 0.0);
				}
				result = 1;
			}
			return result;
		}

		[MonoPInvokeCallback(typeof(LuaCSFunction))]
		private static int set_next_ext_data(IntPtr L)
		{
			int result = 0;
			if (WraperUtil.ValidIsUserdata(L, 1, string_set_next_ext_data) && WraperUtil.ValidIsNumber(L, 2, string_set_next_ext_data))
			{
				ClientObject clientObject = WraperUtil.LuaToUserdata(L, 1, string_send, ClientObject.cache);
				uint nextSendPackageExtData = (uint)LuaDLL.lua_tonumber(L, 2);
				if (clientObject != null && clientObject.client != null)
				{
					clientObject.client.NextSendPackageExtData = nextSendPackageExtData;
					LuaDLL.lua_pushboolean(L, true);
				}
				else
				{
					LuaDLL.lua_pushboolean(L, false);
				}
				result = 1;
			}
			return result;
		}

		[MonoPInvokeCallback(typeof(LuaCSFunction))]
		private static int get_socket_id(IntPtr L)
		{
			int result = 0;
			if (WraperUtil.ValidIsUserdata(L, 1, string_get_socket_id))
			{
				ClientObject clientObject = null;
				clientObject = WraperUtil.LuaToUserdata(L, 1, string_get_socket_id, ClientObject.cache);
				if (clientObject != null && clientObject.client != null)
				{
					LuaDLL.lua_pushnumber(L, clientObject.client.SocketID);
				}
				result = 1;
			}
			return result;
		}

		[MonoPInvokeCallback(typeof(LuaCSFunction))]
		private static int asyc_connection(IntPtr L)
		{
			int result = 0;
			if (WraperUtil.ValidIsUserdata(L, 1, string_asyc_connection) && WraperUtil.ValidIsString(L, 2, string_asyc_connection) && WraperUtil.ValidIsNumber(L, 3, string_asyc_connection))
			{
				ClientObject clientObject = null;
				string text = null;
				int num = 0;
				clientObject = WraperUtil.LuaToUserdata(L, 1, string_asyc_connection, ClientObject.cache);
				text = LuaDLL.lua_tostring(L, 2);
				num = (int)LuaDLL.lua_tonumber(L, 3);
				if (clientObject != null && clientObject.client != null)
				{
					bool value = clientObject.client.AsycConnect(text, num);
					LuaDLL.lua_pushboolean(L, value);
				}
				result = 1;
			}
			return result;
		}

		[MonoPInvokeCallback(typeof(LuaCSFunction))]
		private static int asyc_connection_ex(IntPtr L)
		{
			int result = 0;
			if (WraperUtil.ValidIsUserdata(L, 1, string_asyc_connection_ex) && WraperUtil.ValidIsString(L, 2, string_asyc_connection_ex) && WraperUtil.ValidIsNumber(L, 3, string_asyc_connection_ex))
			{
				ClientObject clientObject = null;
				string text = null;
				int num = 0;
				clientObject = WraperUtil.LuaToUserdata(L, 1, string_asyc_connection_ex, ClientObject.cache);
				text = LuaDLL.lua_tostring(L, 2);
				num = (int)LuaDLL.lua_tonumber(L, 3);
				if (clientObject != null && clientObject.client != null)
				{
					clientObject.client.PackageFactory = new PackageFactoryEx();
					bool value = clientObject.client.AsycConnect(text, num);
					LuaDLL.lua_pushboolean(L, value);
				}
				result = 1;
			}
			return result;
		}

		[MonoPInvokeCallback(typeof(LuaCSFunction))]
		private static int asyc_connection_ex2(IntPtr L)
		{
			int result = 0;
			if (WraperUtil.ValidIsUserdata(L, 1, string_asyc_connection_ex2) && WraperUtil.ValidIsString(L, 2, string_asyc_connection_ex2) && WraperUtil.ValidIsNumber(L, 3, string_asyc_connection_ex2))
			{
				ClientObject clientObject = null;
				string text = null;
				int num = 0;
				clientObject = WraperUtil.LuaToUserdata(L, 1, string_asyc_connection_ex2, ClientObject.cache);
				text = LuaDLL.lua_tostring(L, 2);
				num = (int)LuaDLL.lua_tonumber(L, 3);
				if (clientObject != null && clientObject.client != null)
				{
					clientObject.client.PackageFactory = new PackageFactoryEx2();
					clientObject.client.IsNeedExchangeKey = true;
					bool value = clientObject.client.AsycConnect(text, num);
					LuaDLL.lua_pushboolean(L, value);
				}
				result = 1;
			}
			return result;
		}

		[MonoPInvokeCallback(typeof(LuaCSFunction))]
		private static int set_dispatch_func(IntPtr L)
		{
			int result = 0;
			if (WraperUtil.ValidIsUserdata(L, 1, string_set_dispatch_func) && WraperUtil.ValidIsString(L, 2, string_set_dispatch_func))
			{
				ClientObject clientObject = null;
				clientObject = WraperUtil.LuaToUserdata(L, 1, string_asyc_connection_ex2, ClientObject.cache);
				string dispatchFunc = LuaDLL.lua_tostring(L, 2);
				if (clientObject != null && clientObject.client != null)
				{
					clientObject.client.DispatchFunc = dispatchFunc;
					LuaDLL.lua_pushboolean(L, true);
				}
				else
				{
					LuaDLL.lua_pushboolean(L, false);
				}
				result = 1;
			}
			return result;
		}

		[MonoPInvokeCallback(typeof(LuaCSFunction))]
		private static int close(IntPtr L)
		{
			int result = 0;
			if (WraperUtil.ValidIsUserdata(L, 1, string_close))
			{
				ClientObject clientObject = null;
				clientObject = WraperUtil.LuaToUserdata(L, 1, string_close, ClientObject.cache);
				if (clientObject != null && clientObject.client != null)
				{
					clientObject.client.Close();
				}
				result = 0;
			}
			return result;
		}

		[MonoPInvokeCallback(typeof(LuaCSFunction))]
		private static int gc(IntPtr L)
		{
			ClientObject clientObject = WraperUtil.LuaToUserdataByGc(L, 1, "gc client_object", ClientObject.cache);
			if (clientObject != null)
			{
				clientObject.DelRef();
			}
			return 0;
		}
	}
}
