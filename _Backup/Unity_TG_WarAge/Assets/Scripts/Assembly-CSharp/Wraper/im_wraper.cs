using System;
using System.Collections.Generic;
using System.Text;
using Core.Unity;
using LuaInterface;
using Script;
using UnityEngine;
using YunvaIM;

namespace Wraper
{
	public class im_wraper
	{
		public static string libname = "im";

		private static luaL_Reg[] libfunc = new luaL_Reg[13]
		{
			new luaL_Reg("init_sdk", init_sdk),
			new luaL_Reg("login", login),
			new luaL_Reg("login_channel", login_channel),
			new luaL_Reg("logout_channel", logout_channel),
			new luaL_Reg("start_audio_record", start_audio_record),
			new luaL_Reg("stop_audio_record", stop_audio_record),
			new luaL_Reg("send_common_message", send_common_message),
			new luaL_Reg("send_whisper_message", send_whisper_message),
			new luaL_Reg("register_volume_notify", register_volume_notify),
			new luaL_Reg("register_common_notify", register_common_notify),
			new luaL_Reg("register_whisper_notify", register_whisper_notify),
			new luaL_Reg("start_play_request", start_play_request),
			new luaL_Reg("stop_play_request", stop_play_request)
		};

		private static string string_init_sdk = "im:init_sdk";

		private static string string_login = "im:login";

		private static string string_login_channel = "im:login_channel";

		private static string string_logout_channel = "im:logout_channel";

		private static string string_start_audio_record = "im:start_audio_record";

		private static string string_stop_audio_record = "im:stop_audio_record";

		private static string string_send_common_message = "im:send_common_message";

		private static string string_send_whisper_message = "im:send_whisper_message";

		private static string string_register_volume_notify = "im:register_volume_notify";

		private static string string_register_common_notify = "im:register_common_notify";

		private static string string_register_whisper_notify = "im:register_whisper_notify";

		private static string string_start_play_request = "im:start_play_request";

		private static string string_stop_play_request = "im:stop_play_request";

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
		private static int init_sdk(IntPtr L)
		{
			int result = 0;
			if (WraperUtil.ValidIsNumber(L, 1, string_init_sdk) && WraperUtil.ValidIsNumber(L, 2, string_init_sdk) && WraperUtil.ValidIsBoolean(L, 3, string_init_sdk) && WraperUtil.ValidIsString(L, 4, string_init_sdk))
			{
				uint num = 0u;
				uint num2 = 0u;
				string persistentDataPath = Application.persistentDataPath;
				bool flag = false;
				num = (uint)LuaDLL.lua_tonumber(L, 1);
				num2 = (uint)LuaDLL.lua_tonumber(L, 2);
				flag = LuaDLL.lua_toboolean(L, 3);
				int num3 = MonoSingleton<YunVaImSDK>.instance.YunVa_Init(num, num2, persistentDataPath, flag, false);
				if (num3 == 0)
				{
					MonoSingleton<YunVaImSDK>.instance.YvLog_setLogLevel(0);
				}
				if (WraperUtil.ValidIsString(L, 4, string_init_sdk))
				{
					ScriptManager.GetInstance().CallFunction(LuaDLL.lua_tostring(L, 4), num3);
				}
				else
				{
					Core.Unity.Debug.LogError("not found init_sdk callback");
				}
				result = 0;
			}
			return result;
		}

		[MonoPInvokeCallback(typeof(LuaCSFunction))]
		private static int login(IntPtr L)
		{
			int result2 = 0;
			Dictionary<string, object> result = new Dictionary<string, object>();
			if (WraperUtil.ValidIsString(L, 1, string_login) && WraperUtil.ValidIsString(L, 2, string_login) && WraperUtil.ValidIsString(L, 3, string_login) && WraperUtil.ValidIsNumber(L, 4, string_login) && WraperUtil.ValidIsString(L, 5, string_login) && WraperUtil.ValidIsString(L, 6, string_login))
			{
				string text = "-1";
				string empty = string.Empty;
				string empty2 = string.Empty;
				int num = 0;
				string login_callback = string.Empty;
				text = LuaDLL.lua_tostring(L, 1);
				empty = LuaDLL.lua_tostring(L, 2);
				empty2 = LuaDLL.lua_tostring(L, 3);
				num = (int)LuaDLL.lua_tonumber(L, 4);
				login_callback = LuaDLL.lua_tostring(L, 5);
				string text2 = LuaDLL.lua_tostring(L, 6);
				string[] wildCard = null;
				if (!string.IsNullOrEmpty(text2))
				{
					wildCard = text2.Split(new char[1] { '|' }, StringSplitOptions.RemoveEmptyEntries);
				}
				string format = "{{\"nickname\":\"{0}\",\"uid\":\"{1}\",\"iconUrl\":\"{2}\",\"level\":{3},\"vip\":{4},\"ext\":\"{5}\"}}";
				string tt = string.Format(format, empty2, empty, "touxiang1", 10, 3, "10000");
				MonoSingleton<YunVaImSDK>.instance.YunVaOnLogin(tt, text, wildCard, num, delegate(ImThirdLoginResp r)
				{
					if (!string.IsNullOrEmpty(login_callback))
					{
						result.Add("result", r.result);
						result.Add("msg", r.msg);
						result.Add("userId", r.userId);
						result.Add("nickName", r.nickName);
						result.Add("iconUrl", r.iconUrl);
						result.Add("thirdUserId", r.thirdUserId);
						result.Add("thirdUseName", r.thirdUseName);
						ScriptManager.GetInstance().CallFunction(login_callback, result);
					}
					else
					{
						Core.Unity.Debug.LogError("not found im login_callback");
					}
				}, delegate
				{
				});
				result2 = 0;
			}
			return result2;
		}

		[MonoPInvokeCallback(typeof(LuaCSFunction))]
		private static int login_channel(IntPtr L)
		{
			int result = 0;
			if (WraperUtil.ValidIsNumber(L, 1, string_login_channel) && WraperUtil.ValidIsString(L, 2, string_login_channel) && WraperUtil.ValidIsString(L, 3, string_login_channel))
			{
				int channel = (int)LuaDLL.lua_tonumber(L, 1);
				string wildCard = LuaDLL.lua_tostring(L, 2);
				string text = LuaDLL.lua_tostring(L, 3);
				MonoSingleton<YunVaImSDK>.instance.LoginChannel(channel, wildCard, delegate(ImChannelMotifyResp res)
				{
					Dictionary<string, object> dictionary = new Dictionary<string, object>();
					Dictionary<string, object> dictionary2 = new Dictionary<string, object>();
					dictionary.Add("result", res.result);
					dictionary.Add("msg", res.msg);
					if (res.result == 0)
					{
						for (int i = 0; i < res.wildcard.Count; i++)
						{
							dictionary2.Add(i.ToString(), res.wildcard[i]);
						}
					}
					dictionary.Add("data", dictionary2);
				});
			}
			return result;
		}

		[MonoPInvokeCallback(typeof(LuaCSFunction))]
		private static int logout_channel(IntPtr L)
		{
			int result = 0;
			if (WraperUtil.ValidIsNumber(L, 1, string_logout_channel) && WraperUtil.ValidIsString(L, 2, string_logout_channel) && WraperUtil.ValidIsString(L, 3, string_logout_channel))
			{
				int channel = (int)LuaDLL.lua_tonumber(L, 1);
				string wildCard = LuaDLL.lua_tostring(L, 2);
				string text = LuaDLL.lua_tostring(L, 3);
				MonoSingleton<YunVaImSDK>.instance.LogoutChannel(channel, wildCard, delegate(ImChannelMotifyResp res)
				{
					Dictionary<string, object> dictionary = new Dictionary<string, object>();
					Dictionary<string, object> dictionary2 = new Dictionary<string, object>();
					dictionary.Add("result", res.result);
					dictionary.Add("msg", res.msg);
					if (res.result == 0)
					{
						for (int i = 0; i < res.wildcard.Count; i++)
						{
							dictionary2.Add(i.ToString(), res.wildcard[i]);
						}
					}
					dictionary.Add("data", dictionary2);
				});
			}
			return result;
		}

		[MonoPInvokeCallback(typeof(LuaCSFunction))]
		private static int start_audio_record(IntPtr L)
		{
			int result = 0;
			string filePath = string.Format("{0}/{1}.amr", Application.persistentDataPath, DateTime.Now.ToFileTime());
			int num = MonoSingleton<YunVaImSDK>.instance.RecordStartRequest(filePath, 1, string.Empty);
			return result;
		}

		[MonoPInvokeCallback(typeof(LuaCSFunction))]
		private static int stop_audio_record(IntPtr L)
		{
			int result = 0;
			if (WraperUtil.ValidIsString(L, 1, string_stop_audio_record))
			{
				string func = LuaDLL.lua_tostring(L, 1);
				MonoSingleton<YunVaImSDK>.instance.RecordStopRequest(delegate(ImRecordStopResp reData)
				{
					uint time = reData.time;
					string strfilepath = reData.strfilepath;
					if (func != string.Empty)
					{
						ScriptManager.GetInstance().CallFunction(func, (int)time, strfilepath);
					}
				});
			}
			return result;
		}

		[MonoPInvokeCallback(typeof(LuaCSFunction))]
		private static int send_common_message(IntPtr L)
		{
			int result = 0;
			if (WraperUtil.ValidIsString(L, 1, string_send_common_message) && WraperUtil.ValidIsNumber(L, 2, string_send_common_message) && WraperUtil.ValidIsString(L, 3, string_send_common_message) && WraperUtil.ValidIsString(L, 4, string_send_common_message) && WraperUtil.ValidIsString(L, 5, string_send_common_message) && WraperUtil.ValidIsString(L, 6, string_send_common_message) && WraperUtil.ValidIsString(L, 7, string_send_common_message))
			{
				string empty = string.Empty;
				int num = 0;
				string empty2 = string.Empty;
				string empty3 = string.Empty;
				string func = string.Empty;
				string empty4 = string.Empty;
				string empty5 = string.Empty;
				empty = LuaDLL.lua_tostring(L, 1);
				num = (int)LuaDLL.lua_tonumber(L, 2);
				empty2 = LuaDLL.lua_tostring(L, 3);
				empty3 = LuaDLL.lua_tostring(L, 4);
				func = LuaDLL.lua_tostring(L, 5);
				empty4 = LuaDLL.lua_tostring(L, 6);
				empty5 = LuaDLL.lua_tostring(L, 7);
				Action<ImChannelSendMsgResp> response = delegate(ImChannelSendMsgResp res)
				{
					Dictionary<string, object> table = new Dictionary<string, object>
					{
						{ "result", res.result },
						{ "msg", res.msg },
						{ "type", res.type },
						{ "wildCard", res.wildCard },
						{ "textMsg", res.textMsg },
						{ "url", res.url },
						{ "voiceDurationTime", res.voiceDurationTime },
						{ "expand", res.expand },
						{ "shield", res.shield },
						{ "channel", res.channel },
						{ "flag", res.flag }
					};
					ScriptManager.GetInstance().CallFunction(func, table);
				};
				MonoSingleton<YunVaImSDK>.instance.SendChannelVoiceMessage(empty, num, empty2, empty3, response, empty4, empty5);
			}
			return result;
		}

		[MonoPInvokeCallback(typeof(LuaCSFunction))]
		private static int send_whisper_message(IntPtr L)
		{
			int result = 0;
			if (WraperUtil.ValidIsString(L, 1, string_send_whisper_message) && WraperUtil.ValidIsString(L, 2, string_send_whisper_message) && WraperUtil.ValidIsNumber(L, 3, string_send_whisper_message) && WraperUtil.ValidIsString(L, 4, string_send_whisper_message) && WraperUtil.ValidIsString(L, 5, string_send_whisper_message) && WraperUtil.ValidIsString(L, 6, string_send_whisper_message) && WraperUtil.ValidIsString(L, 7, string_send_whisper_message))
			{
				string gameUserID = LuaDLL.lua_tostring(L, 1);
				string filePath = LuaDLL.lua_tostring(L, 2);
				int audioTime = (int)LuaDLL.lua_tonumber(L, 3);
				string txt = LuaDLL.lua_tostring(L, 4);
				string func = LuaDLL.lua_tostring(L, 5);
				string flag = LuaDLL.lua_tostring(L, 6);
				string ext = LuaDLL.lua_tostring(L, 7);
				MonoSingleton<YunVaImSDK>.instance.SendP2PVoiceMessage(gameUserID, filePath, audioTime, txt, delegate(ImChatFriendResp res)
				{
					StringBuilder stringBuilder = new StringBuilder();
					Dictionary<string, object> dictionary = new Dictionary<string, object>
					{
						{ "result", res.result },
						{ "msg", res.msg },
						{ "type", res.type },
						{ "userId", res.userId },
						{ "flag", res.flag },
						{ "indexId", res.indexId },
						{ "text", res.text },
						{ "audiourl", res.audiourl },
						{ "audiotime", res.audiotime },
						{ "imageurl1", res.imageurl1 },
						{ "imageurl2", res.imageurl2 },
						{ "ext1", res.ext1 }
					};
					foreach (KeyValuePair<string, object> item in dictionary)
					{
						stringBuilder.Append(string.Format("{0}={1}\t", item.Key, item.Value));
					}
					UnityEngine.Debug.Log("SendP2PVoiceMessageCallback:" + stringBuilder.ToString());
					if (!string.IsNullOrEmpty(func))
					{
						ScriptManager.GetInstance().CallFunction(func, dictionary);
					}
				}, flag, ext);
			}
			return result;
		}

		[MonoPInvokeCallback(typeof(LuaCSFunction))]
		private static int register_volume_notify(IntPtr L)
		{
			int result = 0;
			if (WraperUtil.ValidIsString(L, 1, string_register_volume_notify))
			{
				MonoSingleton<YunVaImSDK>.instance.RecordSetInfoReq(true);
				string func = LuaDLL.lua_tostring(L, 1);
				EventListenerManager.AddListener(ProtocolEnum.IM_RECORD_VOLUME_NOTIFY, delegate(object data)
				{
					ImRecordVolumeNotify imRecordVolumeNotify = data as ImRecordVolumeNotify;
					ScriptManager.GetInstance().CallFunction(func, imRecordVolumeNotify.v_volume);
				});
			}
			return result;
		}

		[MonoPInvokeCallback(typeof(LuaCSFunction))]
		private static int register_common_notify(IntPtr L)
		{
			int result = 0;
			if (WraperUtil.ValidIsString(L, 1, string_register_common_notify))
			{
				string func = LuaDLL.lua_tostring(L, 1);
				EventListenerManager.AddListener(ProtocolEnum.IM_CHANNEL_MESSAGE_NOTIFY, delegate(object data)
				{
					ImChannelMessageNotify imChannelMessageNotify = data as ImChannelMessageNotify;
					string message = "接收频道消息：\nuserId:" + imChannelMessageNotify.userId + "\nmessageBody:" + imChannelMessageNotify.messageBody + "\nnickname:" + imChannelMessageNotify.nickname + "\next1:" + imChannelMessageNotify.ext1 + "\next2:" + imChannelMessageNotify.ext2 + "\nchannel:" + imChannelMessageNotify.channel + "\nwildcard:" + imChannelMessageNotify.wildcard + "\nmessageType:" + imChannelMessageNotify.messageType + "\nvoiceDuration:" + imChannelMessageNotify.voiceDuration + "\nattach:" + imChannelMessageNotify.attach + "\nshield" + imChannelMessageNotify.shield + "\n";
					UnityEngine.Debug.Log(message);
					Dictionary<string, object> table = new Dictionary<string, object>
					{
						{ "userId", imChannelMessageNotify.userId },
						{ "messageBody", imChannelMessageNotify.messageBody },
						{ "nickname", imChannelMessageNotify.nickname },
						{ "ext1", imChannelMessageNotify.ext1 },
						{ "ext2", imChannelMessageNotify.ext2 },
						{ "channel", imChannelMessageNotify.channel },
						{ "wildcard", imChannelMessageNotify.wildcard },
						{ "messageType", imChannelMessageNotify.messageType },
						{ "voiceDuration", imChannelMessageNotify.voiceDuration },
						{ "attach", imChannelMessageNotify.attach },
						{ "shield", imChannelMessageNotify.shield }
					};
					ScriptManager.GetInstance().CallFunction(func, table);
				});
			}
			return result;
		}

		[MonoPInvokeCallback(typeof(LuaCSFunction))]
		private static int register_whisper_notify(IntPtr L)
		{
			int result = 0;
			if (WraperUtil.ValidIsString(L, 1, string_register_whisper_notify))
			{
				string func = LuaDLL.lua_tostring(L, 1);
				if (!string.IsNullOrEmpty(func))
				{
					EventListenerManager.AddListener(ProtocolEnum.IM_CHAT_FRIEND_NOTIFY, delegate(object data)
					{
						ImChatFriendNotify imChatFriendNotify = (ImChatFriendNotify)data;
						P2PChatMsg chatMsg = imChatFriendNotify.chatMsg;
						string message = "接收私聊消息：\nuserID:" + chatMsg.userID + "\nname:" + chatMsg.name + "\nsignature:" + chatMsg.signature + "\nheadUrl:" + chatMsg.headUrl + "\nsendTime:" + chatMsg.sendTime + "\ntype:" + chatMsg.type + "\ndata:" + chatMsg.data + "\nimageUrl:" + chatMsg.imageUrl + "\naudioTime:" + chatMsg.audioTime + "\nattach:" + chatMsg.attach + "\next1:" + chatMsg.ext1 + "\ncloudMsgID:" + chatMsg.cloudMsgID + "\ncloudResource:" + chatMsg.cloudResource + "\n";
						UnityEngine.Debug.Log(message);
						Dictionary<string, object> table = new Dictionary<string, object>
						{
							{ "userID", chatMsg.userID },
							{ "name", chatMsg.name },
							{ "signature", chatMsg.signature },
							{ "headUrl", chatMsg.headUrl },
							{ "type", chatMsg.type },
							{ "data", chatMsg.data },
							{ "imageUrl", chatMsg.imageUrl },
							{ "audioTime", chatMsg.audioTime },
							{ "attach", chatMsg.attach },
							{ "sendTime", chatMsg.sendTime },
							{ "ext1", chatMsg.ext1 },
							{ "cloudMsgID", chatMsg.cloudMsgID },
							{ "cloudResource", chatMsg.cloudResource }
						};
						ScriptManager.GetInstance().CallFunction(func, table);
					});
				}
			}
			return result;
		}

		[MonoPInvokeCallback(typeof(LuaCSFunction))]
		private static int start_play_request(IntPtr L)
		{
			int result = 0;
			if (WraperUtil.ValidIsString(L, 1, string_start_play_request) && WraperUtil.ValidIsString(L, 2, string_start_play_request) && WraperUtil.ValidIsString(L, 3, string_start_play_request) && WraperUtil.ValidIsString(L, 4, string_start_play_request))
			{
				string filePath = LuaDLL.lua_tostring(L, 1);
				string url = LuaDLL.lua_tostring(L, 2);
				string ext = LuaDLL.lua_tostring(L, 3);
				string func = LuaDLL.lua_tostring(L, 4);
				Action<ImRecordFinishPlayResp> response = delegate(ImRecordFinishPlayResp r)
				{
					if (!string.IsNullOrEmpty(func))
					{
						Dictionary<string, object> table = new Dictionary<string, object>
						{
							{ "result", r.result },
							{ "describe", r.describe },
							{ "ext", r.ext }
						};
						ScriptManager.GetInstance().CallFunction(func, table);
					}
				};
				MonoSingleton<YunVaImSDK>.instance.RecordStartPlayRequest(filePath, url, ext, response);
			}
			return result;
		}

		[MonoPInvokeCallback(typeof(LuaCSFunction))]
		private static int stop_play_request(IntPtr L)
		{
			MonoSingleton<YunVaImSDK>.instance.RecordStopPlayRequest();
			return 0;
		}
	}
}
