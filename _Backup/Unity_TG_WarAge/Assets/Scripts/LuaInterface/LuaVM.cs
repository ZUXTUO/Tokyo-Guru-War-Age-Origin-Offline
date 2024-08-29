using System;
using System.Collections.Generic;
using System.Runtime.InteropServices;

namespace LuaInterface
{
	public class LuaVM : IDisposable
	{
		public delegate bool InitFunction(IntPtr luaState);

		private IntPtr luaState = IntPtr.Zero;

		private static LuaVM instance;

		private bool isInit;

		private List<InitFunction> initList = new List<InitFunction>();

		public long usedTime;

		private LuaVM()
		{
		}

		public IntPtr GetLuaState()
		{
			return luaState;
		}

		public bool IsActive()
		{
			return luaState != IntPtr.Zero;
		}

		public static LuaVM GetInstance()
		{
			if (instance == null)
			{
				instance = new LuaVM();
			}
			return instance;
		}

		public bool Init()
		{
			if (!isInit)
			{
				luaState = LuaDLL.luaL_newstate();
				bool flag = false;
				if (luaState != IntPtr.Zero)
				{
					LuaDLL.luaL_openlibs(luaState);
					for (int i = 0; i < initList.Count; i++)
					{
						InitFunction initFunction = initList[i];
						if (initFunction != null && !initFunction(luaState))
						{
							return false;
						}
					}
					return true;
				}
				return false;
			}
			isInit = true;
			return true;
		}

		public bool Close()
		{
			if (luaState != IntPtr.Zero)
			{
				LuaDLL.lua_close(luaState);
				luaState = IntPtr.Zero;
			}
			initList.Clear();
			isInit = false;
			return true;
		}

		public bool AddInit(InitFunction f)
		{
			bool flag = false;
			for (int i = 0; i < initList.Count; i++)
			{
				InitFunction initFunction = initList[i];
				if (initFunction == f)
				{
					flag = true;
				}
			}
			if (!flag)
			{
				initList.Add(f);
				return true;
			}
			return false;
		}

		public void Dispose()
		{
			Close();
		}

		public void lua_register(string strFuncName, LuaCSFunction pFunc)
		{
			if (strFuncName != null && strFuncName.Length != 0 && pFunc != null)
			{
				lua_pushcclosure(pFunc, 0);
				lua_setfield(LuaIndexes.LUA_GLOBALSINDEX, strFuncName);
			}
		}

		public bool lua_isnone(int index)
		{
			return LuaDLL.lua_type(luaState, index) == LuaTypes.LUA_TNONE;
		}

		public bool lua_isnoneornil(int index)
		{
			return LuaDLL.lua_type(luaState, index) <= LuaTypes.LUA_TNIL;
		}

		public IntPtr lua_topointer(int idx)
		{
			return LuaDLL.lua_topointer(luaState, idx);
		}

		public int lua_tointeger(int idx)
		{
			return LuaDLL.lua_tointeger(luaState, idx);
		}

		public int lua_gc(LuaGCOptions what, int data)
		{
			return LuaDLL.lua_gc(luaState, what, data);
		}

		public string luaL_typename(int stackPos)
		{
			return LuaDLL.luaL_typename(luaState, stackPos);
		}

		public void luaL_error(string message)
		{
			LuaDLL.luaL_error(luaState, message);
		}

		public string luaL_gsub(string str, string pattern, string replacement)
		{
			return LuaDLL.luaL_gsub(luaState, str, pattern, replacement);
		}

		public void lua_getfenv(int stackPos)
		{
			LuaDLL.lua_getfenv(luaState, stackPos);
		}

		public bool lua_isfunction(int stackPos)
		{
			return LuaDLL.lua_isfunction(luaState, stackPos);
		}

		public bool lua_islightuserdata(int stackPos)
		{
			return LuaDLL.lua_islightuserdata(luaState, stackPos);
		}

		public bool lua_istable(int stackPos)
		{
			return LuaDLL.lua_istable(luaState, stackPos);
		}

		public int lua_isuserdata(int stackPos)
		{
			return LuaDLL.lua_isuserdata(luaState, stackPos);
		}

		public int lua_lessthan(int stackPos1, int stackPos2)
		{
			return LuaDLL.lua_lessthan(luaState, stackPos1, stackPos2);
		}

		public int lua_rawequal(int stackPos1, int stackPos2)
		{
			return LuaDLL.lua_rawequal(luaState, stackPos1, stackPos2);
		}

		public int lua_setfenv(int stackPos)
		{
			return LuaDLL.lua_setfenv(luaState, stackPos);
		}

		public void lua_setfield(int stackPos, string name)
		{
			LuaDLL.lua_setfield(luaState, stackPos, name);
		}

		public int luaL_callmeta(int stackPos, string name)
		{
			return LuaDLL.luaL_callmeta(luaState, stackPos, name);
		}

		public IntPtr luaL_newstate()
		{
			return LuaDLL.luaL_newstate();
		}

		public IntPtr lua_open()
		{
			return luaL_newstate();
		}

		public void lua_close()
		{
			LuaDLL.lua_close(luaState);
		}

		public void luaL_openlibs()
		{
			LuaDLL.luaL_openlibs(luaState);
		}

		public int lua_objlen(int stackPos)
		{
			return LuaDLL.lua_objlen(luaState, stackPos);
		}

		public int lua_strlen(int stackPos)
		{
			return LuaDLL.lua_strlen(luaState, stackPos);
		}

		public int luaL_loadstring(string chunk)
		{
			return LuaDLL.luaL_loadstring(luaState, chunk);
		}

		public int luaL_dostring(string chunk)
		{
			return LuaDLL.luaL_dostring(luaState, chunk);
		}

		public int luaL_dostring(IntPtr L, string chunk)
		{
			return LuaDLL.luaL_dostring(L, chunk);
		}

		public void lua_createtable(int narr, int nrec)
		{
			LuaDLL.lua_createtable(luaState, narr, nrec);
		}

		public void lua_newtable()
		{
			LuaDLL.lua_newtable(luaState);
		}

		public int luaL_dofile(string fileName)
		{
			return LuaDLL.luaL_dofile(luaState, fileName);
		}

		public void lua_getglobal(string name)
		{
			LuaDLL.lua_getglobal(luaState, name);
		}

		public void lua_setglobal(string name)
		{
			LuaDLL.lua_setglobal(luaState, name);
		}

		public void lua_settop(int newTop)
		{
			LuaDLL.lua_settop(luaState, newTop);
		}

		public void lua_pop(int amount)
		{
			LuaDLL.lua_pop(luaState, amount);
		}

		public void lua_insert(int newTop)
		{
			LuaDLL.lua_insert(luaState, newTop);
		}

		public void lua_remove(int index)
		{
			LuaDLL.lua_remove(luaState, index);
		}

		public void lua_gettable(int index)
		{
			LuaDLL.lua_gettable(luaState, index);
		}

		public void lua_rawget(int index)
		{
			LuaDLL.lua_rawget(luaState, index);
		}

		public void lua_settable(int index)
		{
			LuaDLL.lua_settable(luaState, index);
		}

		public void lua_rawset(int index)
		{
			LuaDLL.lua_rawset(luaState, index);
		}

		public void lua_setmetatable(int objIndex)
		{
			LuaDLL.lua_setmetatable(luaState, objIndex);
		}

		public int lua_getmetatable(int objIndex)
		{
			return LuaDLL.lua_getmetatable(luaState, objIndex);
		}

		public int lua_equal(int index1, int index2)
		{
			return LuaDLL.lua_equal(luaState, index1, index2);
		}

		public void lua_pushvalue(int index)
		{
			LuaDLL.lua_pushvalue(luaState, index);
		}

		public void lua_replace(int index)
		{
			LuaDLL.lua_replace(luaState, index);
		}

		public int lua_gettop()
		{
			return LuaDLL.lua_gettop(luaState);
		}

		public LuaTypes lua_type(int index)
		{
			return LuaDLL.lua_type(luaState, index);
		}

		public bool lua_isnil(int index)
		{
			return LuaDLL.lua_isnil(luaState, index);
		}

		public bool lua_isnumber(int index)
		{
			return LuaDLL.lua_isnumber(luaState, index);
		}

		public bool lua_isboolean(int index)
		{
			return LuaDLL.lua_isboolean(luaState, index);
		}

		public int luaL_ref(int registryIndex)
		{
			return LuaDLL.luaL_ref(luaState, registryIndex);
		}

		public int lua_ref(int lockRef)
		{
			return LuaDLL.lua_ref(luaState, lockRef);
		}

		public void lua_rawgeti(int tableIndex, int index)
		{
			LuaDLL.lua_rawgeti(luaState, tableIndex, index);
		}

		public void lua_rawseti(int tableIndex, int index)
		{
			LuaDLL.lua_rawseti(luaState, tableIndex, index);
		}

		public IntPtr lua_newuserdata(int size)
		{
			return LuaDLL.lua_newuserdata(luaState, size);
		}

		public void lua_newuserdata_ex(int size, int value)
		{
			LuaDLL.lua_newuserdata_ex(luaState, size, value);
		}

		public IntPtr lua_touserdata(int index)
		{
			return LuaDLL.lua_touserdata(luaState, index);
		}

		public int lua_touserdata_int(int index)
		{
			return LuaDLL.lua_touserdata_int(luaState, index);
		}

		public void lua_getref(int reference)
		{
			LuaDLL.lua_getref(luaState, reference);
		}

		public void luaL_unref(int registryIndex, int reference)
		{
			LuaDLL.luaL_unref(luaState, registryIndex, reference);
		}

		public void lua_unref(int reference)
		{
			LuaDLL.lua_unref(luaState, reference);
		}

		public bool lua_isstring(int index)
		{
			return LuaDLL.lua_isstring(luaState, index);
		}

		public bool lua_iscfunction(int index)
		{
			return LuaDLL.lua_iscfunction(luaState, index);
		}

		public void lua_pushnil()
		{
			LuaDLL.lua_pushnil(luaState);
		}

		public void lua_pushcclosure(LuaCSFunction func, int n)
		{
			LuaDLL.lua_pushcclosure(luaState, func, n);
		}

		public void lua_pushstdcallcfunction(LuaCSFunction func)
		{
			LuaDLL.lua_pushstdcallcfunction(luaState, func);
		}

		public int lua_call(int nArgs, int nResults)
		{
			return LuaDLL.lua_call(luaState, nArgs, nResults);
		}

		public int lua_pcall(int nArgs, int nResults, int errfunc)
		{
			return LuaDLL.lua_pcall(luaState, nArgs, nResults, errfunc);
		}

		public IntPtr lua_tocfunction(int index)
		{
			return LuaDLL.lua_tocfunction(luaState, index);
		}

		public double lua_tonumber(int index)
		{
			return LuaDLL.lua_tonumber(luaState, index);
		}

		public bool lua_toboolean(int index)
		{
			return LuaDLL.lua_toboolean(luaState, index);
		}

		public IntPtr lua_tolstring(int index, out int strLen)
		{
			return LuaDLL.lua_tolstring(luaState, index, out strLen);
		}

		public string lua_tostring(int index)
		{
			return LuaDLL.lua_tostring(luaState, index);
		}

		public void lua_atpanic(LuaFunctionCallback panicf)
		{
			LuaDLL.lua_atpanic(luaState, panicf);
		}

		public void lua_pushnumber(double number)
		{
			LuaDLL.lua_pushnumber(luaState, number);
		}

		public void lua_pushboolean(bool value)
		{
			LuaDLL.lua_pushboolean(luaState, value);
		}

		public void lua_pushlstring(ref byte str, int size)
		{
			LuaDLL.lua_pushlstring(luaState, ref str, size);
		}

		public void lua_pushstring(string str)
		{
			LuaDLL.lua_pushstring(luaState, str);
		}

		public int luaL_newmetatable(string meta)
		{
			return LuaDLL.luaL_newmetatable(luaState, meta);
		}

		public void lua_getfield(int stackPos, string meta)
		{
			LuaDLL.lua_getfield(luaState, stackPos, meta);
		}

		public void luaL_getmetatable(string meta)
		{
			LuaDLL.luaL_getmetatable(luaState, meta);
		}

		public IntPtr luaL_checkudata(int stackPos, string meta)
		{
			return LuaDLL.luaL_checkudata(luaState, stackPos, meta);
		}

		public bool luaL_getmetafield(int stackPos, string field)
		{
			return LuaDLL.luaL_getmetafield(luaState, stackPos, field);
		}

		public int lua_load(LuaChunkReader chunkReader, ref ReaderInfo data, string chunkName)
		{
			return LuaDLL.lua_load(luaState, chunkReader, ref data, chunkName);
		}

		public int luaL_loadbuffer(byte[] buff, int size, string name)
		{
			int cb = Marshal.SizeOf(buff[0]) * buff.Length;
			IntPtr intPtr = Marshal.AllocHGlobal(cb);
			int num = -1;
			try
			{
				Marshal.Copy(buff, 0, intPtr, buff.Length);
				return LuaDLL.luaL_loadbuffer(luaState, intPtr, size, name);
			}
			finally
			{
				Marshal.FreeHGlobal(intPtr);
			}
		}

		public int luaL_loadbuffer(IntPtr buff, int size, string name)
		{
			return LuaDLL.luaL_loadbuffer(luaState, buff, size, name);
		}

		public int luaL_loadfile(string filename)
		{
			return LuaDLL.luaL_loadfile(luaState, filename);
		}

		public void lua_error()
		{
			LuaDLL.lua_error(luaState);
		}

		public bool lua_checkstack(int extra)
		{
			return LuaDLL.lua_checkstack(luaState, extra);
		}

		public int lua_next(int index)
		{
			return LuaDLL.lua_next(luaState, index);
		}

		public void lua_pushlightuserdata(IntPtr udata)
		{
			LuaDLL.lua_pushlightuserdata(luaState, udata);
		}

		public bool Lua_GetFunction(string function, ref int pushcount)
		{
			if (function != null && function.Length != 0)
			{
				pushcount = 0;
				int stackPos = LuaIndexes.LUA_GLOBALSINDEX;
				string text = function;
				while (true)
				{
					int num = text.IndexOf('.');
					if (num < 0 || num == text.Length)
					{
						GetInstance().lua_getfield(stackPos, text);
						pushcount++;
						break;
					}
					string meta = text.Substring(0, num);
					text = text.Substring(num + 1, text.Length - num - 1);
					GetInstance().lua_getfield(stackPos, meta);
					pushcount++;
					if (GetInstance().lua_isnoneornil(-1))
					{
						break;
					}
					stackPos = GetInstance().lua_gettop();
				}
				if (!GetInstance().lua_isfunction(-1))
				{
					GetInstance().lua_pop(pushcount);
					pushcount = 0;
					return false;
				}
				return true;
			}
			return false;
		}

		public void register_class(string name, luaL_Reg[] func, LuaCSFunction gc)
		{
			LuaDLL.register_class(luaState, name, func, gc);
		}

		public void register_class(string name, luaL_Reg[] func, LuaCSFunction gc, string partent)
		{
			LuaDLL.register_class(luaState, name, func, gc, partent);
		}

		public void register_lib(string libname, luaL_Reg[] l, int nup)
		{
			LuaDLL.register_lib(luaState, libname, l, nup);
		}
	}
}
