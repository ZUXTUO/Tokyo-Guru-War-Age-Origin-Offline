using System;
using System.Collections.Generic;
using System.IO;
using System.Text;
using Core.Net;
using Core.Unity;
using LuaInterface;
using SNet;
using Script;
using Sio;
using UnityWrap;

namespace Wraper
{
	public class net_process : NIprocess
	{
		private static object lockobject = new object();

		private static net_process instance = null;

		private string con = string.Empty;

		private string error = string.Empty;

		private string clo = string.Empty;

		private string onSend = string.Empty;

		private string onReceive = string.Empty;

		private Dictionary<int, string> m_allSendMessage = new Dictionary<int, string>();

		public static net_process GetInstance()
		{
			lock (lockobject)
			{
				if (instance == null)
				{
					instance = new net_process();
				}
			}
			return instance;
		}

		public bool Process(Client c, Package p, int messageid, NFunction pf)
		{
			if (c.isConnected)
			{
				StringBuilder stringBuilder = new StringBuilder();
				stringBuilder.Append(pf.Nm.Name);
				stringBuilder.Append(".");
				stringBuilder.Append(pf.Name);
				if (onReceive != null && onReceive.Length > 0)
				{
					ScriptManager.GetInstance().CallFunction(onReceive, messageid, p.Header.GetExtData(), p.Header.GetSeqNum());
				}
				int num = 0;
				ScriptCall scriptCall = ScriptCall.Create(c.DispatchFunc);
				if (scriptCall != null && scriptCall.Start())
				{
					LuaVM.GetInstance().lua_pushnumber(c.SocketID);
					LuaVM.GetInstance().lua_pushnumber(messageid);
					LuaVM.GetInstance().lua_pushnumber(p.Header.GetExtData());
					LuaVM.GetInstance().lua_pushnumber(p.Header.GetSeqNum());
					LuaVM.GetInstance().lua_pushstring(stringBuilder.ToString());
					num = 5;
					IList<NParam> paramList = pf.ParamList;
					if (p.Data != null)
					{
						MemoryStream ms = new MemoryStream(p.Data);
						for (int i = 0; i < paramList.Count; i++)
						{
							push_to_lua(paramList[i], ms, scriptCall.L);
							num++;
						}
					}
					scriptCall.Finish(num);
				}
			}
			return true;
		}

		public bool ProcessEvent(Client c, Event.Type type, int error)
		{
			switch (type)
			{
			case Event.Type.CONNECT:
				return Connection(c);
			case Event.Type.CLOSE:
				return Close(c);
			case Event.Type.ERROR:
				return Error(c, error);
			default:
				Debug.LogWarning("ProcessEvent() failed.. reason: unknown event type");
				return true;
			}
		}

		private void push_to_lua(NParam o, MemoryStream ms, IntPtr L)
		{
			SDataBuff sDataBuff = new SDataBuff();
			sDataBuff.UnSerializ(ms);
			push_data(sDataBuff, L, o);
		}

		private void push_data(SDataBuff data, IntPtr L, NParam o)
		{
			switch (data.type)
			{
			case SType.stype_bool:
				LuaVM.GetInstance().lua_pushboolean(data.boolValue);
				break;
			case SType.stype_uchar:
				LuaVM.GetInstance().lua_pushnumber((int)data.ucharValue);
				break;
			case SType.stype_char:
				LuaVM.GetInstance().lua_pushnumber(data.charValue);
				break;
			case SType.stype_short:
				LuaVM.GetInstance().lua_pushnumber(data.shortValue);
				break;
			case SType.stype_ushort:
				LuaVM.GetInstance().lua_pushnumber((int)data.ushortValue);
				break;
			case SType.stype_int:
				LuaVM.GetInstance().lua_pushnumber(data.intValue);
				break;
			case SType.stype_uint:
				LuaVM.GetInstance().lua_pushnumber(data.uintValue);
				break;
			case SType.stype_float:
				LuaVM.GetInstance().lua_pushnumber(data.floatValue);
				break;
			case SType.stype_double:
				LuaVM.GetInstance().lua_pushnumber(data.doubleValue);
				break;
			case SType.stype_long:
				LuaVM.GetInstance().lua_pushstring(data.longValue.ToString());
				break;
			case SType.stype_string:
				LuaVM.GetInstance().lua_pushstring(data.stringValue);
				break;
			case SType.stype_list:
				push_list(data, o, L);
				break;
			case SType.stype_map:
				push_map(data, o, L);
				break;
			default:
				Debug.LogError("push_data error!!!!!!!!!!!!!!! type:" + data.type);
				break;
			}
		}

		private void push_map(SDataBuff data, NParam o, IntPtr L)
		{
			SMapReader mapReader = data.mapReader;
			LuaVM.GetInstance().lua_newtable();
			if (mapReader == null || o.DType != ParamType.ptype_object)
			{
				return;
			}
			NStruct nStruct = NStructManager.GetInstance().Find(o.TypeName);
			if (nStruct == null)
			{
				return;
			}
			SDataBuff sDataBuff = new SDataBuff();
			SDataBuff sDataBuff2 = new SDataBuff();
			while (mapReader.Next(sDataBuff, sDataBuff2))
			{
				NParam nParam = nStruct.Get(sDataBuff.intValue);
				if (nParam != null)
				{
					LuaVM.GetInstance().lua_pushstring(nParam.Name);
					push_data(sDataBuff2, L, nParam);
					LuaVM.GetInstance().lua_settable(-3);
				}
			}
		}

		private void push_list(SDataBuff data, NParam o, IntPtr L)
		{
			SListReader listReader = data.listReader;
			LuaVM.GetInstance().lua_newtable();
			int tableIndex = LuaVM.GetInstance().lua_gettop();
			int num = 0;
			if (listReader != null && o.Container == ParamContainer.pparam_container_list)
			{
				SDataBuff sDataBuff = new SDataBuff();
				while (listReader.Next(sDataBuff))
				{
					push_data(sDataBuff, L, o);
					LuaVM.GetInstance().lua_rawseti(tableIndex, ++num);
				}
			}
		}

		public bool Connection(Client c)
		{
			Debug.Log("<color=#E00000ff> ===net_process connect success=== </color>", Debug.LogLevel.Important);
			ScriptCall scriptCall = ScriptCall.Create(con);
			if (scriptCall != null && scriptCall.Start())
			{
				gnet_wraper.push(scriptCall.L, ClientObject.cache_by_client.Find(c));
				scriptCall.Finish(1);
			}
			return true;
		}

		public bool Close(Client c)
		{
			ScriptCall scriptCall = ScriptCall.Create(clo);
			if (scriptCall != null && scriptCall.Start())
			{
				gnet_wraper.push(scriptCall.L, ClientObject.cache_by_client.Find(c));
				scriptCall.Finish(1);
			}
			return true;
		}

		public bool Error(Client c, int etype)
		{
			ScriptCall scriptCall = ScriptCall.Create(error);
			if (scriptCall != null && scriptCall.Start())
			{
				gnet_wraper.push(scriptCall.L, ClientObject.cache_by_client.Find(c));
				LuaDLL.lua_pushnumber(scriptCall.L, etype);
				scriptCall.Finish(2);
			}
			return true;
		}

		public void SetListener(string onConnection, string onClose, string onError)
		{
			con = onConnection;
			clo = onClose;
			error = onError;
		}

		public void SetOnSend(string onSend)
		{
			this.onSend = onSend;
		}

		public void SetOnReceive(string onReceive)
		{
			this.onReceive = onReceive;
		}

		internal uint Send(Client c, int messageid, IntPtr L)
		{
			NFunction functin = NModuleManager.GetInstance().GetFunctin(messageid);
			if (functin != null)
			{
				Package package = c.PackageFactory.CreatePackage();
				package.Header.SetExtData(c.NextSendPackageExtData);
				package.MessageID = messageid;
				FormatPackage(package, functin, L);
				c.Send(package);
				if (onSend != null && onSend.Length > 0)
				{
					ScriptManager.GetInstance().CallFunction(onSend, messageid, package.Header.GetExtData(), package.Header.GetSeqNum());
				}
				return package.Header.GetExtData();
			}
			return 0u;
		}

		private void FormatPackage(Package p, NFunction f, IntPtr L)
		{
			int num = 2;
			IList<NParam> paramList = f.ParamList;
			using (MemoryStream memoryStream = new MemoryStream())
			{
				for (int i = 0; i < paramList.Count; i++)
				{
					SData sData = format_data(paramList[i], L, ++num, true);
					if (sData != null)
					{
						sData.Serializ(memoryStream);
					}
				}
				byte[] array = new byte[memoryStream.Length];
				Array.Copy(memoryStream.GetBuffer(), array, memoryStream.Length);
				p.Data = array;
			}
		}

		private SData format_data(NParam o, IntPtr L, int index, bool checklist)
		{
			if (checklist && o.Container == ParamContainer.pparam_container_list)
			{
				return format_List(L, index, o);
			}
			switch (o.DType)
			{
			case ParamType.ptype_bool:
			{
				bool v5 = false;
				if (LuaVM.GetInstance().lua_isboolean(index))
				{
					v5 = LuaVM.GetInstance().lua_toboolean(index);
				}
				return new SData(v5);
			}
			case ParamType.ptype_char:
			case ParamType.ptype_uchar:
			{
				byte v8 = 0;
				if (LuaVM.GetInstance().lua_isnumber(index))
				{
					v8 = (byte)LuaVM.GetInstance().lua_tointeger(index);
				}
				return new SData(v8);
			}
			case ParamType.ptype_ushort:
			{
				ushort v6 = 0;
				if (LuaVM.GetInstance().lua_isnumber(index))
				{
					v6 = (ushort)LuaVM.GetInstance().lua_tointeger(index);
				}
				return new SData(v6);
			}
			case ParamType.ptype_short:
			{
				short v3 = 0;
				if (LuaVM.GetInstance().lua_isnumber(index))
				{
					v3 = (short)LuaVM.GetInstance().lua_tointeger(index);
				}
				return new SData(v3);
			}
			case ParamType.ptype_int:
			{
				int v10 = 0;
				if (LuaVM.GetInstance().lua_isnumber(index))
				{
					v10 = LuaVM.GetInstance().lua_tointeger(index);
				}
				return new SData(v10);
			}
			case ParamType.ptype_uint:
			{
				uint v7 = 0u;
				if (LuaVM.GetInstance().lua_isnumber(index))
				{
					v7 = (uint)LuaVM.GetInstance().lua_tointeger(index);
				}
				return new SData(v7);
			}
			case ParamType.ptype_float:
			{
				float v2 = 0f;
				if (LuaVM.GetInstance().lua_isnumber(index))
				{
					v2 = (float)LuaVM.GetInstance().lua_tonumber(index);
				}
				return new SData(v2);
			}
			case ParamType.ptype_double:
			{
				double v9 = 0.0;
				if (LuaVM.GetInstance().lua_isnumber(index))
				{
					v9 = LuaVM.GetInstance().lua_tonumber(index);
				}
				return new SData(v9);
			}
			case ParamType.ptype_long:
			case ParamType.ptype_ulong:
				if (LuaVM.GetInstance().lua_type(index) == LuaTypes.LUA_TSTRING)
				{
					string s = LuaVM.GetInstance().lua_tostring(index);
					return new SData(long.Parse(s));
				}
				if (LuaVM.GetInstance().lua_isnumber(index))
				{
					long v4 = (long)LuaVM.GetInstance().lua_tonumber(index);
					return new SData(v4);
				}
				return null;
			case ParamType.ptype_string:
			{
				string v = string.Empty;
				if (LuaVM.GetInstance().lua_isstring(index))
				{
					v = LuaVM.GetInstance().lua_tostring(index);
				}
				return new SData(v);
			}
			case ParamType.ptype_object:
				return format_map(L, index, o);
			default:
				return null;
			}
		}

		private SData format_map(IntPtr L, int index, NParam o)
		{
			SMapWriter sMapWriter = new SMapWriter();
			SData result = new SData(sMapWriter);
			if (LuaVM.GetInstance().lua_istable(index) && o.DType == ParamType.ptype_object)
			{
				NStruct nStruct = NStructManager.GetInstance().Find(o.TypeName);
				if (nStruct != null)
				{
					LuaVM.GetInstance().lua_pushnil();
					while (LuaVM.GetInstance().lua_next(index) != 0)
					{
						if (LuaVM.GetInstance().lua_isstring(-2))
						{
							NParam nParam = nStruct.Get(LuaVM.GetInstance().lua_tostring(-2));
							if (nParam != null)
							{
								sMapWriter.write(nParam.Id, format_data(nParam, L, LuaVM.GetInstance().lua_gettop(), true));
							}
						}
						LuaVM.GetInstance().lua_pop(1);
					}
				}
			}
			return result;
		}

		private SData format_List(IntPtr L, int index, NParam o)
		{
			SListWriter sListWriter = new SListWriter();
			SData result = new SData(sListWriter);
			if (LuaVM.GetInstance().lua_istable(index))
			{
				int num = LuaVM.GetInstance().lua_objlen(index);
				for (int i = 1; i <= num; i++)
				{
					LuaVM.GetInstance().lua_rawgeti(index, i);
					SData o2 = format_data(o, L, LuaVM.GetInstance().lua_gettop(), false);
					sListWriter.add(o2);
					LuaVM.GetInstance().lua_pop(1);
				}
			}
			return result;
		}
	}
}
