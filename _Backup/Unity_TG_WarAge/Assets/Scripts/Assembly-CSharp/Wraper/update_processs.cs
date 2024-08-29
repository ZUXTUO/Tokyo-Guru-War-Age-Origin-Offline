using System.Collections.Generic;
using Core.Net;
using LuaInterface;
using SUpdate.GStruct;
using SUpdate.Interface;
using SUpdate.Logic;
using Script;

namespace Wraper
{
	public class update_processs : IUpdate
	{
		private static update_processs instance = new update_processs();

		public string ConnectionFunction = string.Empty;

		public string ErrorFunction = string.Empty;

		public string DeviceErrorFunction = string.Empty;

		public string OpVerFunction = string.Empty;

		public string CloseFunction = string.Empty;

		public static update_processs Instance
		{
			get
			{
				return instance;
			}
		}

		void IUpdate.Close(Client c)
		{
			ScriptManager.GetInstance().CallFunction(CloseFunction);
		}

		void IUpdate.Connection(Client c)
		{
			ScriptManager.GetInstance().CallFunction(ConnectionFunction);
		}

		void IUpdate.Error(Client c, int errortype)
		{
			ScriptManager.GetInstance().CallFunction(ErrorFunction, errortype);
		}

		void IUpdate.DeviceError(Client c, string mes, string url)
		{
			ScriptManager.GetInstance().CallFunction(DeviceErrorFunction, mes, url);
		}

		void IUpdate.OpVersion(IList<op_data> fileList, int down_count)
		{
			ScriptCall scriptCall = ScriptCall.Create(OpVerFunction);
			if (scriptCall != null && scriptCall.Start())
			{
				int num = 0;
				LuaDLL.lua_newtable(scriptCall.L);
				int tableIndex = LuaDLL.lua_gettop(scriptCall.L);
				for (int i = 0; i < fileList.Count; i++)
				{
					op_data op_data = fileList[i];
					LuaDLL.lua_newtable(scriptCall.L);
					scriptCall.lua_settable("oid", op_data.Id);
					scriptCall.lua_settable("path", op_data.Path);
					scriptCall.lua_settable("fsize", op_data.Fsize);
					scriptCall.lua_settable("type", (int)op_data.Type);
					LuaDLL.lua_rawseti(scriptCall.L, tableIndex, i + 1);
					num += (int)op_data.Fsize;
				}
				scriptCall.lua_settable("all_fsize", num);
				scriptCall.Finish(1);
			}
		}

		public void DownProcess(Update up)
		{
			if (up == null)
			{
				return;
			}
			List<Update.ScriptCallBack> callback = up.Callback;
			for (int i = 0; i < callback.Count; i++)
			{
				Update.ScriptCallBack scriptCallBack = callback[i];
				if (scriptCallBack.ProcessScript.Length != 0)
				{
					Dictionary<string, object> dictionary = new Dictionary<string, object>();
					dictionary.Add("filepath", up.Path);
					dictionary.Add("fsize", up.Fsize);
					dictionary.Add("current", up.Current_pos);
					ScriptManager.GetInstance().CallFunction(scriptCallBack.ProcessScript, dictionary);
				}
			}
		}

		public void DownFinish(Update up)
		{
			if (up == null)
			{
				return;
			}
			List<Update.ScriptCallBack> callback = up.Callback;
			for (int i = 0; i < callback.Count; i++)
			{
				Update.ScriptCallBack scriptCallBack = callback[i];
				if (scriptCallBack.FinishScript.Length != 0)
				{
					Dictionary<string, object> dictionary = new Dictionary<string, object>();
					dictionary.Add("filepath", up.Path);
					dictionary.Add("fsize", up.Fsize);
					dictionary.Add("result", up.Result);
					ScriptManager.GetInstance().CallFunction(scriptCallBack.FinishScript, dictionary);
				}
			}
		}

		public void DownProcess(UpdateGroup ug, Update up)
		{
			if (ug != null)
			{
				Update.ScriptCallBack callback = ug.Callback;
				if (callback != null && callback.ProcessScript.Length != 0)
				{
					Dictionary<string, object> dictionary = new Dictionary<string, object>();
					dictionary.Add("filepath", up.Path);
					dictionary.Add("fsize", up.Fsize);
					dictionary.Add("current", up.Current_pos);
					dictionary.Add("down_count", ug.AllCount);
					dictionary.Add("finish_count", ug.FinishCount);
					dictionary.Add("error_count", ug.ErrorCount);
					ScriptManager.GetInstance().CallFunction(callback.ProcessScript, dictionary);
				}
			}
		}

		public void DownFinish(UpdateGroup ug, Update up, int result)
		{
			if (ug != null)
			{
				Update.ScriptCallBack callback = ug.Callback;
				if (callback != null && callback.FinishScript.Length != 0)
				{
					Dictionary<string, object> dictionary = new Dictionary<string, object>();
					dictionary.Add("filepath", up.Path);
					dictionary.Add("fsize", up.Fsize);
					dictionary.Add("result", up.Result);
					dictionary.Add("current", up.Current_pos);
					dictionary.Add("down_count", ug.AllCount);
					dictionary.Add("finish_count", ug.FinishCount);
					dictionary.Add("error_count", ug.ErrorCount);
					ScriptManager.GetInstance().CallFunction(callback.FinishScript, dictionary);
				}
			}
		}
	}
}
