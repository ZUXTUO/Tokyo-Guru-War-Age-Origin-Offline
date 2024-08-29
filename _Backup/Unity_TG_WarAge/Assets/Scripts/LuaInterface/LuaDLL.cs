using System;
using System.Collections.Generic;
using System.Diagnostics;
using System.Reflection;
using System.Runtime.InteropServices;
using UniLua;

namespace LuaInterface
{
	public class LuaDLL
	{
		private const string INDEXSTRING = "__index";

		private const string GCSTRING = "__gc";

		private const string BASEPATH = "";

		private const string LUADLL = "lua";

		private const string LUALIBDLL = "lua";

		[DllImport("lua")]
		public static extern int lua_gc(IntPtr luaState, LuaGCOptions what, int data);

		[DllImport("lua")]
		public static extern string lua_typename(IntPtr luaState, LuaTypes type);

		[DllImport("lua")]
		public static extern void luaL_error(IntPtr luaState, string message);

		[DllImport("lua")]
		public static extern string luaL_gsub(IntPtr luaState, string str, string pattern, string replacement);

		[DllImport("lua")]
		public static extern void lua_getfenv(IntPtr luaState, int stackPos);

		[DllImport("lua")]
		public static extern void lua_createtable(IntPtr luaState, int narr, int nrec);

		[DllImport("lua")]
		public static extern int lua_isuserdata(IntPtr luaState, int stackPos);

		[DllImport("lua")]
		public static extern int lua_lessthan(IntPtr luaState, int stackPos1, int stackPos2);

		[DllImport("lua")]
		public static extern int lua_rawequal(IntPtr luaState, int stackPos1, int stackPos2);

		[DllImport("lua")]
		public static extern int lua_setfenv(IntPtr luaState, int stackPos);

		[DllImport("lua")]
		public static extern void lua_setfield(IntPtr luaState, int stackPos, string name);

		[DllImport("lua")]
		public static extern int luaL_callmeta(IntPtr luaState, int stackPos, string name);

		[DllImport("lua")]
		public static extern IntPtr luaL_newstate();

		[DllImport("lua")]
		public static extern void lua_close(IntPtr luaState);

		[DllImport("lua")]
		public static extern void luaL_openlibs(IntPtr luaState);

		[DllImport("lua")]
		public static extern void luaopen_math(IntPtr luaState);

		[DllImport("lua")]
		public static extern int lua_objlen(IntPtr luaState, int stackPos);

		[DllImport("lua")]
		public static extern int luaL_loadstring(IntPtr luaState, string chunk);

		[DllImport("lua")]
		public static extern void lua_settop(IntPtr luaState, int newTop);

		[DllImport("lua")]
		public static extern void lua_insert(IntPtr luaState, int newTop);

		[DllImport("lua")]
		public static extern void lua_remove(IntPtr luaState, int index);

		[DllImport("lua")]
		public static extern void lua_gettable(IntPtr luaState, int index);

		[DllImport("lua")]
		public static extern void lua_rawget(IntPtr luaState, int index);

		[DllImport("lua")]
		public static extern void lua_settable(IntPtr luaState, int index);

		[DllImport("lua")]
		public static extern void lua_rawset(IntPtr luaState, int index);

		[DllImport("lua")]
		public static extern void lua_setmetatable(IntPtr luaState, int objIndex);

		[DllImport("lua")]
		public static extern int lua_getmetatable(IntPtr luaState, int objIndex);

		[DllImport("lua")]
		public static extern int lua_equal(IntPtr luaState, int index1, int index2);

		[DllImport("lua")]
		public static extern void lua_pushvalue(IntPtr luaState, int index);

		[DllImport("lua")]
		public static extern void lua_replace(IntPtr luaState, int index);

		[DllImport("lua")]
		public static extern int lua_gettop(IntPtr luaState);

		[DllImport("lua")]
		public static extern LuaTypes lua_type(IntPtr luaState, int index);

		[DllImport("lua")]
		public static extern bool lua_isnumber(IntPtr luaState, int index);

		[DllImport("lua")]
		public static extern int luaL_ref(IntPtr luaState, int registryIndex);

		[DllImport("lua")]
		public static extern void lua_rawgeti(IntPtr luaState, int tableIndex, int index);

		[DllImport("lua")]
		public static extern void lua_rawseti(IntPtr luaState, int tableIndex, int index);


#if UNITY_EDITOR
        [DllImport("lua")]
        public static extern IntPtr lua_newuserdata(IntPtr luaState, int size);
        public static void lua_newuserdata_ex(IntPtr L, int sz, int value)
		{
            //Marshal.StructureToPtr(value, L, false);
            lua_newuserdata(L, sz);
        }
		[DllImport("lua")]
		public static extern IntPtr lua_touserdata(IntPtr luaState, int index);

		public static int lua_touserdata_int(IntPtr lua_State, int idx)
		{
			return 0;
		}

#elif UNITY_ANDROID

		[DllImport("lua")]
		public static extern IntPtr lua_newuserdata(IntPtr luaState, int size);

		[DllImport("lua")]
		public static extern void lua_newuserdata_ex(IntPtr L, int sz, int value);

		[DllImport("lua")]
		public static extern IntPtr lua_touserdata(IntPtr luaState, int index);

		[DllImport("lua")]
		public static extern int lua_touserdata_int(IntPtr lua_State, int idx);
#endif
		

        public static IntPtr use_lua_newuserdata(IntPtr luaState, int size)
        {
			/*
			IntPtr eax = luaState + 0x10;
			if ((eax + 0x44) >= (eax + 0x40))
			{
				IntPtr eax_1 = luaState + 0x14;
				IntPtr eax_4;
                if (eax_1 != (luaState + 0x28))
				{
					eax_4 = ((eax_1 + 4) + 0xc);
                }
				else
				{
					eax_4 = luaState + 0x48;

                }
            }
			else
			{
				IntPtr eax_1 = luaState + 0x14;
				IntPtr eax_4;
                if (eax_1 == (luaState + 0x28))
				{
                    eax_4= luaState + 0x48;
				}
				else
				{
					eax_4 = (eax_1 + 4) + 0xc;
                }
            }

            unsafe
            {
                int* eax_6 = Sub103c0(arg1, arg2, eax_4);
                int** edx = (int**)(arg1 + 8);
                *edx = eax_6;
                edx[2] = (int*)7;
                *(luaState + 8) += 0xc;
                return (IntPtr)(&eax_6[5]);
            }
			*/

            IntPtr newData = lua_newuserdata(luaState, size);
            UnityEngine.Debug.Log("use_lua_newuserdata: " + newData);
            return newData;
        }
        public static void use_lua_newuserdata_ex(IntPtr L, int sz, int value)
        {
            UnityEngine.Debug.Log("use_lua_newuserdata_ex");
            lua_newuserdata_ex(L, sz, value);
        }
        public static IntPtr use_lua_touserdata(IntPtr luaState, int index)
        {
            IntPtr newData = lua_touserdata(luaState, index);
            UnityEngine.Debug.Log("lua_touserdata: " + newData);
            return newData;
        }
        public static int use_lua_touserdata_int(IntPtr lua_State, int idx)
        {
            int newData = lua_touserdata_int(lua_State, idx);
            UnityEngine.Debug.Log("lua_touserdata_int: " + newData);
            return newData;
        }

        [DllImport("lua")]
		public static extern void luaL_unref(IntPtr luaState, int registryIndex, int reference);

		[DllImport("lua")]
		public static extern bool lua_isstring(IntPtr luaState, int index);

		[DllImport("lua")]
		public static extern bool lua_iscfunction(IntPtr luaState, int index);

		[DllImport("lua")]
		public static extern void lua_pushnil(IntPtr luaState);

		[DllImport("lua")]
		public static extern void lua_pushcclosure(IntPtr lua_State, [MarshalAs(UnmanagedType.FunctionPtr)] LuaCSFunction func, int n);

		[DllImport("lua")]
		public static extern int lua_call(IntPtr luaState, int nArgs, int nResults);

		[DllImport("lua")]
		public static extern int lua_pcall(IntPtr luaState, int nArgs, int nResults, int errfunc);

		[DllImport("lua")]
		public static extern IntPtr lua_tocfunction(IntPtr luaState, int index);

		[DllImport("lua")]
		public static extern double lua_tonumber(IntPtr luaState, int index);

		[DllImport("lua")]
		public static extern bool lua_toboolean(IntPtr luaState, int index);

		[DllImport("lua")]
		public static extern IntPtr lua_tolstring(IntPtr luaState, int index, out int strLen);

		[DllImport("lua")]
		public static extern IntPtr luaL_findtable(IntPtr lua_State, int idx, string fname, int szhint);

		[DllImport("lua")]
		public static extern void lua_atpanic(IntPtr luaState, LuaFunctionCallback panicf);

		[DllImport("lua")]
		public static extern void lua_pushnumber(IntPtr luaState, double number);

		[DllImport("lua")]
		public static extern void lua_pushboolean(IntPtr luaState, bool value);

		[DllImport("lua")]
		public static extern void lua_pushlstring(IntPtr luaState, ref byte str, int size);

		[DllImport("lua")]
		public static extern void lua_pushstring(IntPtr luaState, string str);

		[DllImport("lua")]
		public static extern int luaL_newmetatable(IntPtr luaState, string meta);

		[DllImport("lua")]
		public static extern void lua_getfield(IntPtr luaState, int stackPos, string meta);

		[DllImport("lua")]
		public static extern IntPtr luaL_checkudata(IntPtr luaState, int stackPos, string meta);

		[DllImport("lua")]
		public static extern bool luaL_getmetafield(IntPtr luaState, int stackPos, string field);

		[DllImport("lua")]
		public static extern int lua_load(IntPtr luaState, LuaChunkReader chunkReader, ref ReaderInfo data, string chunkName);

		[DllImport("lua")]
		public static extern int luaL_loadbuffer(IntPtr luaState, IntPtr buff, int size, string name);

		[DllImport("lua")]
		public static extern int luaL_loadfile(IntPtr luaState, string filename);

		[DllImport("lua")]
		public static extern void lua_error(IntPtr luaState);

		[DllImport("lua")]
		public static extern bool lua_checkstack(IntPtr luaState, int extra);

		[DllImport("lua")]
		public static extern int lua_next(IntPtr luaState, int index);

		[DllImport("lua")]
		public static extern void lua_pushlightuserdata(IntPtr luaState, IntPtr udata);

		[DllImport("lua")]
		public static extern IntPtr lua_topointer(IntPtr luaState, int idx);

		[DllImport("lua")]
		public static extern int lua_tointeger(IntPtr luaState, int idx);

		[DllImport("lua")]
		public static extern IntPtr lua_tolstring_ds(IntPtr luaState, int idx, out int strLen);

		public static IntPtr lua_open()
		{
			return luaL_newstate();
		}

		public static string luaL_typename(IntPtr luaState, int stackPos)
		{
			return lua_typename(luaState, lua_type(luaState, stackPos));
		}

		public static void register_lib(IntPtr lua_state, string libname, luaL_Reg[] l, int nup)
		{
			if (libname != null && libname.Length != 0)
			{
				int szhint = l.Length;
				LuaFindTable(lua_state, LuaIndexes.LUA_REGISTRYINDEX, "_LOADED", 1);
				lua_getfield(lua_state, -1, libname);
				if (!lua_istable(lua_state, -1))
				{
					lua_pop(lua_state, 1);
					if (LuaFindTable(lua_state, LuaIndexes.LUA_GLOBALSINDEX, libname, szhint).Length != 0)
					{
						luaL_error(lua_state, "name conflict for module ");
					}
					lua_pushvalue(lua_state, -1);
					lua_setfield(lua_state, -3, libname);
				}
				lua_remove(lua_state, -2);
				lua_insert(lua_state, -(nup + 1));
			}
			for (int i = 0; i < l.Length; i++)
			{
				if (l[i].name != null && l[i].func != null)
				{
					for (int j = 0; j < nup; j++)
					{
						lua_pushvalue(lua_state, -nup);
					}
					lua_pushcclosure(lua_state, l[i].func, nup);
					lua_setfield(lua_state, -(nup + 2), l[i].name);
				}
			}
			lua_pop(lua_state, nup + 1);
		}

		public static void create_lib(IntPtr lua_state, luaL_Reg[] l, int nup, bool crate_table = true)
		{
			if (crate_table)
			{
				lua_newtable(lua_state);
			}
			for (int i = 0; i < l.Length; i++)
			{
				if (l[i].name != null && l[i].func != null)
				{
					for (int j = 0; j < nup; j++)
					{
						lua_pushvalue(lua_state, -nup);
					}
					lua_pushcclosure(lua_state, l[i].func, nup);
					lua_setfield(lua_state, -(nup + 2), l[i].name);
				}
			}
			lua_pop(lua_state, nup);
		}

		public static int lua_strlen(IntPtr luaState, int stackPos)
		{
			return lua_objlen(luaState, stackPos);
		}

		public static int luaL_dostring(IntPtr luaState, string chunk)
		{
			int num = luaL_loadstring(luaState, chunk);
			if (num != 0)
			{
				return num;
			}
			return lua_pcall(luaState, 0, 0, 0);
		}

		public static int lua_dostring(IntPtr luaState, string chunk)
		{
			return luaL_dostring(luaState, chunk);
		}

		public static void lua_newtable(IntPtr luaState)
		{
			lua_createtable(luaState, 0, 0);
		}

		public static int luaL_dofile(IntPtr luaState, string fileName)
		{
			int newTop = lua_gettop(luaState);
			lua_getglobal(luaState, "gcallerr");
			if (lua_type(luaState, -1) != LuaTypes.LUA_TFUNCTION)
			{
				lua_settop(luaState, newTop);
				int num = luaL_loadfile(luaState, fileName);
				if (num != 0)
				{
					return num;
				}
				return lua_pcall(luaState, 0, -1, 0);
			}
			int errfunc = lua_gettop(luaState);
			int num2 = luaL_loadfile(luaState, fileName);
			if (num2 != 0)
			{
				return num2;
			}
			int result = lua_pcall(luaState, 0, 0, errfunc);
			lua_settop(luaState, newTop);
			return result;
		}

		public static void lua_getglobal(IntPtr luaState, string name)
		{
			lua_getfield(luaState, LuaIndexes.LUA_GLOBALSINDEX, name);
		}

		public static void lua_setglobal(IntPtr luaState, string name)
		{
			lua_setfield(luaState, LuaIndexes.LUA_GLOBALSINDEX, name);
		}

		public static void lua_pop(IntPtr luaState, int amount)
		{
			lua_settop(luaState, -amount - 1);
		}

		public static bool lua_isnil(IntPtr luaState, int index)
		{
			return lua_type(luaState, index) == LuaTypes.LUA_TNIL;
		}

		public static bool lua_isboolean(IntPtr luaState, int index)
		{
			return lua_type(luaState, index) == LuaTypes.LUA_TBOOLEAN;
		}

		public static bool lua_isfunction(IntPtr luaState, int index)
		{
			return lua_type(luaState, index) == LuaTypes.LUA_TFUNCTION;
		}

		public static bool lua_isthread(IntPtr luaState, int index)
		{
			return lua_type(luaState, index) == LuaTypes.LUA_THREAD;
		}

		public static bool lua_islightuserdata(IntPtr luaState, int index)
		{
			return lua_type(luaState, index) == LuaTypes.LUA_TLIGHTUSERDATA;
		}

		public static bool lua_isnone(IntPtr luaState, int index)
		{
			return lua_type(luaState, index) == LuaTypes.LUA_TNONE;
		}

		public static bool lua_isnoneornil(IntPtr luaState, int index)
		{
			return lua_type(luaState, index) <= LuaTypes.LUA_TNIL;
		}

		public static bool lua_istable(IntPtr luaState, int stackPos)
		{
			return lua_type(luaState, stackPos) == LuaTypes.LUA_TTABLE;
		}

		public static int lua_ref(IntPtr luaState, int lockRef)
		{
			if (lockRef != 0)
			{
				return luaL_ref(luaState, LuaIndexes.LUA_REGISTRYINDEX);
			}
			return 0;
		}

		public static void lua_getref(IntPtr luaState, int reference)
		{
			lua_rawgeti(luaState, LuaIndexes.LUA_REGISTRYINDEX, reference);
		}

		public static void lua_unref(IntPtr luaState, int reference)
		{
			luaL_unref(luaState, LuaIndexes.LUA_REGISTRYINDEX, reference);
		}

		public static void lua_pushstdcallcfunction(IntPtr luaState, [MarshalAs(UnmanagedType.FunctionPtr)] LuaCSFunction func)
		{
			lua_pushcclosure(luaState, func, 0);
		}

		public static string LuaFindTable(IntPtr luaState, int idx, string fname, int szhint)
		{
			IntPtr intPtr = luaL_findtable(luaState, idx, fname, szhint);
			if (intPtr != IntPtr.Zero)
			{
				return Marshal.PtrToStringAnsi(intPtr);
			}
			return string.Empty;
		}

		public static string lua_tostring(IntPtr luaState, int index)
		{
			int strLen;
#if UNITY_EDITOR
			IntPtr intPtr = lua_tolstring(luaState, index, out strLen);
#elif UNITY_ANDROID
			IntPtr intPtr = lua_tolstring_ds(luaState, index, out strLen);
#endif
			if (intPtr != IntPtr.Zero)
			{
				return Marshal.PtrToStringAnsi(intPtr, strLen);
			}
			return string.Empty;
		}

		public static void luaL_getmetatable(IntPtr luaState, string meta)
		{
			lua_getfield(luaState, LuaIndexes.LUA_REGISTRYINDEX, meta);
		}

		public static void register_class(IntPtr L, string name, luaL_Reg[] func, LuaCSFunction gc)
		{
			if (L != IntPtr.Zero)
			{
				luaL_newmetatable(L, name);
				lua_pushstring(L, "__index");
				create_lib(L, func, 0);
				lua_settable(L, -3);
				lua_pushcclosure(L, gc, 0);
				lua_setfield(L, -2, "__gc");
				lua_pop(L, 1);
			}
		}

		public static void register_class(IntPtr L, string name, luaL_Reg[] func, LuaCSFunction gc, string partent)
		{
			luaL_newmetatable(L, name);
			lua_pushstring(L, "__index");
			lua_newtable(L);
			lua_getfield(L, LuaIndexes.LUA_REGISTRYINDEX, partent);
			if (lua_istable(L, -1))
			{
				lua_getfield(L, -1, "__index");
				if (lua_istable(L, -1))
				{
					lua_pushnil(L);
					while (lua_next(L, -2) != 0)
					{
						lua_pushvalue(L, -2);
						lua_insert(L, -2);
						lua_settable(L, -6);
					}
				}
				lua_pop(L, 2);
			}
			else
			{
				lua_pop(L, 1);
			}
			create_lib(L, func, 0, false);
			lua_settable(L, -3);
			lua_pushcclosure(L, gc, 0);
			lua_setfield(L, -2, "__gc");
			lua_pop(L, 1);
		}

		public static object ToVarObject(IntPtr L, int stackPos)
		{
			switch (lua_type(L, stackPos))
			{
			case LuaTypes.LUA_TNUMBER:
				return lua_tonumber(L, stackPos);
			case LuaTypes.LUA_TSTRING:
				return lua_tostring(L, stackPos);
			case LuaTypes.LUA_TBOOLEAN:
				return lua_toboolean(L, stackPos);
			case LuaTypes.LUA_TTABLE:
				return ToLuaDictionary(L, stackPos);
			default:
				return null;
			}
		}

		public static Dictionary<object, object> ToLuaDictionary(IntPtr L, int stackPos)
		{
			Dictionary<object, object> dictionary = new Dictionary<object, object>();
			if (lua_istable(L, stackPos))
			{
				int num = lua_gettop(L);
				lua_pushnil(L);
				while (lua_next(L, num) != 0)
				{
					dictionary.Add(ToVarObject(L, -2), ToVarObject(L, -1));
					lua_pop(L, 1);
				}
				lua_settop(L, num);
			}
			return dictionary;
		}
	}
}
