using System;
using System.Collections.Generic;
using UnityEngine;

namespace YunvaIM
{
	public class YunVaImSDK : MonoSingleton<YunVaImSDK>
	{
		private Dictionary<string, Action<ImChatFriendResp>> p2pChatResponDic = new Dictionary<string, Action<ImChatFriendResp>>();

		private uint appid;

		public YunVaUserInfo userInfo = new YunVaUserInfo();

		public Action ActionReLoginSuccess;

		private Action<ImThirdLoginResp> ActionLoginResponse;

		private Action<ImGetThirdBindInfoResp> ActionThirdBindInfo;

		private Action<ImSetUserInfoResp> ActionSetUserInfo;

		public Action<bool> RecordingCallBack;

		private Action<ImRecordStopResp> ActionRecordStopResponse;

		private Dictionary<string, Action<ImRecordFinishPlayResp>> RecordFinishPlayRespMapping = new Dictionary<string, Action<ImRecordFinishPlayResp>>();

		private Action<ImSpeechStopResp> ActionSpeechResp;

		private Action<ImUploadFileResp> ActionUploadFileResp;

		private Action<ImDownLoadFileResp> ActionDownLoadFileResp;

		private Action<ImUploadLocationResp> ActionUploadLocationResp;

		private Action<ImGetLocationResp> ActionGetLocationResp;

		private Action<ImSearchAroundResp> ActionSearchAroundResp;

		private Action<ImShareLocationResp> ActionShareLocationResp;

		private Action<ImLBSSetLocatingTypeResp> ActionImLBSSetLocatingTypeResp;

		private Action<ImLBSGetSpportLangResp> ActionImLBSGetSpportLangResp;

		private Action<ImLBSSetLocalLangResp> ActionImLBSSetLocalLangResp;

		public Action<ImFriendListNotify> ActionFriendListNotify;

		public Action<ImFriendBlackListNotify> ActionBlackListNotify;

		private Action<ImFriendAddRespond> ActionFriendAddRespond;

		private Action<ImFriendAcceptResp> ActionAcceptOrRefuse;

		private Action<ImFriendDelResp> ActionDeleteFriendRequest;

		private Action<ImFriendSearchResp> ActionSearchFriendRequest;

		private Action<ImFriendSearchResp> ActionRecommandFriendRequest;

		private Action<ImFriendOperResp> ActionBlackListOperation;

		private Action<object> ActionSetFriendInfoRequest;

		private Action<ImUserGetInfoResp> ActionGetUserInfoRequest;

		private Action<ImRemoveContactesResp> ActionRemoveContactesResp;

		private Queue<Action<ImChatFriendResp>> SendFriendMsgRespQ = new Queue<Action<ImChatFriendResp>>();

		private Dictionary<string, Action<ImChatFriendResp>> SendFriendMsgRespMapping = new Dictionary<string, Action<ImChatFriendResp>>();

		private Queue<Action<ImChannelSendMsgResp>> SendChannelMsgRespQ = new Queue<Action<ImChannelSendMsgResp>>();

		private Dictionary<string, Action<ImChannelSendMsgResp>> SendChannelMsgRespMapping = new Dictionary<string, Action<ImChannelSendMsgResp>>();

		private Action<ImChannelMotifyResp> ActionImChannelMotifyResp;

		private Action<ImChannelLoginResp> ActionLoginChannelResp;

		private Action<ImChannelHistoryMsgResp> ActionGetChannelHistoryMsgResp;

		private Action<ImChannelGetParamResp> ActionChannelGetParamResp;

		private Action<ImCloudMsgLimitResp> ActioncloudMsgResp;

		public override void Init()
		{
			UnityEngine.Object.DontDestroyOnLoad(this);
			EventListenerManager.AddListener(ProtocolEnum.IM_THIRD_LOGIN_RESP, CPLoginResponse);
			EventListenerManager.AddListener(ProtocolEnum.IM_GET_THIRDBINDINFO_RESP, GetThirdBindInfo);
			EventListenerManager.AddListener(ProtocolEnum.IM_SETUSERINFO_RESP, SetUserInfo);
			EventListenerManager.AddListener(ProtocolEnum.IM_RECORD_STOP_RESP, RecordStopRespInfo);
			EventListenerManager.AddListener(ProtocolEnum.IM_RECORD_FINISHPLAY_RESP, RecordFinishPlayRespInfo);
			EventListenerManager.AddListener(ProtocolEnum.IM_SPEECH_STOP_RESP, RecordRecognizeRespInfo);
			EventListenerManager.AddListener(ProtocolEnum.IM_UPLOAD_FILE_RESP, UploadFileRespInfo);
			EventListenerManager.AddListener(ProtocolEnum.IM_DOWNLOAD_FILE_RESP, DownLoadFileRespInfo);
			EventListenerManager.AddListener(ProtocolEnum.IM_UPLOAD_LOCATION_RESP, UploadLocationResp);
			EventListenerManager.AddListener(ProtocolEnum.IM_GET_LOCATION_RESP, GetLocationResp);
			EventListenerManager.AddListener(ProtocolEnum.IM_SEARCH_AROUND_RESP, SearchAroundResp);
			EventListenerManager.AddListener(ProtocolEnum.IM_SHARE_LOCATION_RESP, ShareLocationResp);
			EventListenerManager.AddListener(ProtocolEnum.IM_LBS_SET_LOCATING_TYPE_RESP, LBSSetLocatingTypeResp);
			EventListenerManager.AddListener(ProtocolEnum.IM_LBS_GET_SUPPORT_LANG_RESP, LBSGetSpportLangResp);
			EventListenerManager.AddListener(ProtocolEnum.IM_LBS_SET_LOCAL_LANG_RESP, LBSSetLocalLangResp);
			EventListenerManager.AddListener(ProtocolEnum.IM_FRIEND_ADD_NOTIFY, delegate
			{
			});
			EventListenerManager.AddListener(ProtocolEnum.IM_FRIEND_DEL_NOTIFY, delegate
			{
			});
			EventListenerManager.AddListener(ProtocolEnum.IM_FRIEND_LIST_NOTIFY, FriendListNotify);
			EventListenerManager.AddListener(ProtocolEnum.IM_FRIEND_BLACKLIST_NOTIFY, BlackListNotify);
			EventListenerManager.AddListener(ProtocolEnum.IM_FRIEND_ADD_RESP, delegate
			{
			});
			EventListenerManager.AddListener(ProtocolEnum.IM_FRIEND_ACCEPT_RESP, AcceptOrRefuseResponse);
			EventListenerManager.AddListener(ProtocolEnum.IM_FRIEND_DEL_RESP, DeleteFriendResponse);
			EventListenerManager.AddListener(ProtocolEnum.IM_FRIEND_RECOMMAND_RESP, RecommandFriendRespone);
			EventListenerManager.AddListener(ProtocolEnum.IM_FRIEND_OPER_RESP, BlackListOperationResponse);
			EventListenerManager.AddListener(ProtocolEnum.IM_FRIEND_INFOSET_RESP, SetFriendInfoResponse);
			EventListenerManager.AddListener(ProtocolEnum.IM_USER_GETINFO_RESP, GetUserInfoResponse);
			EventListenerManager.AddListener(ProtocolEnum.IM_FRIEND_SEARCH_RESP, SearchFriendResponse);
			EventListenerManager.AddListener(ProtocolEnum.IM_REMOVE_CONTACTES_RESP, RemoveContactesResp);
			EventListenerManager.AddListener(ProtocolEnum.IM_FRIEND_ADD_RESPOND, FriendAddRespond);
			EventListenerManager.AddListener(ProtocolEnum.IM_CHAT_FRIEND_RESP, SendFriendMsgResponse);
			EventListenerManager.AddListener(ProtocolEnum.IM_CHAT_FRIEND_NOTIFY, delegate
			{
			});
			EventListenerManager.AddListener(ProtocolEnum.IM_CHANNEL_SENDMSG_RESP, SendChannelMsgResponse);
			EventListenerManager.AddListener(ProtocolEnum.IM_CHANNEL_MESSAGE_NOTIFY, delegate
			{
			});
			EventListenerManager.AddListener(ProtocolEnum.IM_CHANNEL_LOGIN_RESP, loginChannelResponse);
			EventListenerManager.AddListener(ProtocolEnum.IM_CHANNEL_HISTORY_MSG_RESP, getChannelHistoryMsgResponse);
			EventListenerManager.AddListener(ProtocolEnum.IM_CHANNEL_MODIFY_RESP, ChannelMotifyResponse);
			EventListenerManager.AddListener(ProtocolEnum.IM_CHANNEL_GET_PARAM_RESP, ChannelGetParamResponse);
			EventListenerManager.AddListener(ProtocolEnum.IM_CLOUDMSG_LIMIT_RESP, cloudMsgResponse);
		}

		public int YunVa_Init(uint context, uint appid, string path, bool isTest, bool oversea)
		{
			YunvaLogPrint.YvDebugLog("YunVa_Init", string.Format("context:{0},appid:{1},path:{2},isTest:{3},oversea:{4}", context, appid, path, isTest, oversea));
			this.appid = appid;
			return MonoSingleton<YunVaImInterface>.instance.InitSDK(context, appid, path, isTest, oversea);
		}

		public void YunVaOnLogin(string tt, string gameServerID, string[] wildCard, int readStatus, Action<ImThirdLoginResp> Response, Action<ImChannelLoginResp> channelLoginResp)
		{
			YunvaLogPrint.YvDebugLog("YunVaOnLogin", string.Format("tt:{0},gameServerID:{1},readStatus:{2},2", tt, gameServerID, readStatus));
			ActionLoginResponse = Response;
			ActionLoginChannelResp = channelLoginResp;
			uint parser = MonoSingleton<YunVaImInterface>.instance.YVpacket_get_parser();
			MonoSingleton<YunVaImInterface>.instance.YVparser_set_string(parser, 1, tt);
			MonoSingleton<YunVaImInterface>.instance.YVparser_set_string(parser, 2, gameServerID);
			for (int i = 0; i < wildCard.Length; i++)
			{
				YunvaLogPrint.YvDebugLog("YunVaOnLogin", string.Format("wildCard-{0}:{1}", i, wildCard[i]));
				MonoSingleton<YunVaImInterface>.instance.YVparser_set_string(parser, 3, wildCard[i]);
			}
			MonoSingleton<YunVaImInterface>.instance.YVparser_set_uint8(parser, 4, readStatus);
			MonoSingleton<YunVaImInterface>.instance.YV_SendCmd(CmdChannel.IM_LOGIN, 69634u, parser);
		}

		public void YunVaGetThirdBindInfo(int appId, string userId, Action<ImGetThirdBindInfoResp> Response)
		{
			YunvaLogPrint.YvDebugLog("YunVaGetThirdBindInfo", string.Format("appId:{0},userId:{1}", appId, userId));
			ActionThirdBindInfo = Response;
			uint parser = MonoSingleton<YunVaImInterface>.instance.YVpacket_get_parser();
			MonoSingleton<YunVaImInterface>.instance.YVparser_set_integer(parser, 1, appId);
			MonoSingleton<YunVaImInterface>.instance.YVparser_set_string(parser, 2, userId);
			MonoSingleton<YunVaImInterface>.instance.YV_SendCmd(CmdChannel.IM_LOGIN, 69652u, parser);
		}

		public void YunVaSetUserInfo(string nickname, Action<ImSetUserInfoResp> Response, string iconUrl = "", string level = "", string vip = "", string ext = "", int sex = 0)
		{
			YunvaLogPrint.YvDebugLog("YunVaSetUserInfo", string.Format("nickname:{0},iconUrl:{1},level:{2},vip:{3},ext:{4},sex:{5}", nickname, iconUrl, level, vip, ext, sex));
			ActionSetUserInfo = Response;
			uint parser = MonoSingleton<YunVaImInterface>.instance.YVpacket_get_parser();
			MonoSingleton<YunVaImInterface>.instance.YVparser_set_string(parser, 1, nickname);
			MonoSingleton<YunVaImInterface>.instance.YVparser_set_string(parser, 2, iconUrl);
			MonoSingleton<YunVaImInterface>.instance.YVparser_set_string(parser, 3, level);
			MonoSingleton<YunVaImInterface>.instance.YVparser_set_string(parser, 4, vip);
			MonoSingleton<YunVaImInterface>.instance.YVparser_set_string(parser, 5, ext);
			MonoSingleton<YunVaImInterface>.instance.YVparser_set_integer(parser, 6, sex);
			MonoSingleton<YunVaImInterface>.instance.YV_SendCmd(CmdChannel.IM_LOGIN, 69657u, parser);
		}

		private void SetUserInfo(object data)
		{
			if (data is ImSetUserInfoResp && ActionSetUserInfo != null)
			{
				ActionSetUserInfo((ImSetUserInfoResp)data);
				ActionSetUserInfo = null;
			}
		}

		public void YunVaLogOut()
		{
			YunvaLogPrint.YvDebugLog("YunVaLogOut", "YunVaLogOut...");
			uint parser = MonoSingleton<YunVaImInterface>.instance.YVpacket_get_parser();
			MonoSingleton<YunVaImInterface>.instance.YV_SendCmd(CmdChannel.IM_LOGIN, 69636u, parser);
		}

		private void CPLoginResponse(object data)
		{
			if (data is ImThirdLoginResp)
			{
				ImThirdLoginResp imThirdLoginResp = new ImThirdLoginResp();
				if (ActionLoginResponse != null)
				{
					userInfo.userId = imThirdLoginResp.userId;
					userInfo.nickName = imThirdLoginResp.nickName;
					userInfo.thirdUseName = imThirdLoginResp.thirdUseName;
					userInfo.thirdUserId = imThirdLoginResp.thirdUserId;
					userInfo.iconUrl = imThirdLoginResp.iconUrl;
					ActionLoginResponse((ImThirdLoginResp)data);
					ActionLoginResponse = null;
				}
			}
		}

		private void ReLoginNotify(object data)
		{
			if (ActionReLoginSuccess != null)
			{
				ActionReLoginSuccess();
			}
		}

		private void GetThirdBindInfo(object data)
		{
			if (data is ImGetThirdBindInfoResp && ActionThirdBindInfo != null)
			{
				ActionThirdBindInfo((ImGetThirdBindInfoResp)data);
				ActionThirdBindInfo = null;
			}
		}

		public int RecordStartRequest(string filePath, int speech = 0, string ext = "")
		{
			YunvaLogPrint.YvDebugLog("RecordStartRequest", string.Format("filePath:{0},speech:{1},ext:{2}", filePath, speech, ext));
			if (RecordingCallBack != null)
			{
				RecordingCallBack(true);
			}
			uint parser = MonoSingleton<YunVaImInterface>.instance.YVpacket_get_parser();
			MonoSingleton<YunVaImInterface>.instance.YVparser_set_string(parser, 1, filePath);
			MonoSingleton<YunVaImInterface>.instance.YVparser_set_string(parser, 2, ext);
			MonoSingleton<YunVaImInterface>.instance.YVparser_set_integer(parser, 3, speech);
			int num = MonoSingleton<YunVaImInterface>.instance.YV_SendCmd(CmdChannel.IM_TOOLS, 102400u, parser);
			Debug.Log("RecordStartRequest ret=" + num);
			return num;
		}

		public void RecordStopRequest(Action<ImRecordStopResp> RecordResponse, Action<ImUploadFileResp> UploadResp = null, Action<ImSpeechStopResp> SpeechResp = null)
		{
			YunvaLogPrint.YvDebugLog("RecordStopRequest", "RecordStopRequest...");
			if (RecordingCallBack != null)
			{
				RecordingCallBack(false);
			}
			ActionRecordStopResponse = RecordResponse;
			ActionUploadFileResp = UploadResp;
			ActionSpeechResp = SpeechResp;
			uint parser = MonoSingleton<YunVaImInterface>.instance.YVpacket_get_parser();
			int num = MonoSingleton<YunVaImInterface>.instance.YV_SendCmd(CmdChannel.IM_TOOLS, 102401u, parser);
			Debug.Log("@RecordStopRequest@ ret=" + num);
		}

		private void RecordStopRespInfo(object data)
		{
			if (data is ImRecordStopResp && ActionRecordStopResponse != null)
			{
				ActionRecordStopResponse((ImRecordStopResp)data);
				ActionRecordStopResponse = null;
			}
		}

		public int RecordStartPlayRequest(string filePath, string url, string ext, Action<ImRecordFinishPlayResp> Response)
		{
			YunvaLogPrint.YvDebugLog("RecordStartPlayRequest", string.Format("filePath:{0},url:{1},ext:{2}", filePath, url, ext));
			if (!RecordFinishPlayRespMapping.ContainsKey(ext))
			{
				RecordFinishPlayRespMapping.Add(ext, Response);
			}
			uint parser = MonoSingleton<YunVaImInterface>.instance.YVpacket_get_parser();
			if (!string.IsNullOrEmpty(url))
			{
				MonoSingleton<YunVaImInterface>.instance.YVparser_set_string(parser, 1, url);
			}
			if (!string.IsNullOrEmpty(filePath))
			{
				MonoSingleton<YunVaImInterface>.instance.YVparser_set_string(parser, 2, filePath);
			}
			else
			{
				Debug.Log(string.Format("{0}: Play url voice", url));
				MonoSingleton<YunVaImInterface>.instance.YVparser_set_string(parser, 2, string.Empty);
			}
			MonoSingleton<YunVaImInterface>.instance.YVparser_set_string(parser, 3, ext);
			return MonoSingleton<YunVaImInterface>.instance.YV_SendCmd(CmdChannel.IM_TOOLS, 102403u, parser);
		}

		private void RecordFinishPlayRespInfo(object data)
		{
			if (!(data is ImRecordFinishPlayResp))
			{
				return;
			}
			ImRecordFinishPlayResp imRecordFinishPlayResp = (ImRecordFinishPlayResp)data;
			string ext = imRecordFinishPlayResp.ext;
			Action<ImRecordFinishPlayResp> value;
			if (RecordFinishPlayRespMapping.TryGetValue(ext, out value))
			{
				if (value != null)
				{
					value(imRecordFinishPlayResp);
				}
				RecordFinishPlayRespMapping.Remove(ext);
			}
			else
			{
				Debug.LogError(ext + ": callback not found");
			}
		}

		public void RecordStopPlayRequest()
		{
			YunvaLogPrint.YvDebugLog("RecordStopPlayRequest", "RecordStopPlayRequest...");
			uint parser = MonoSingleton<YunVaImInterface>.instance.YVpacket_get_parser();
			MonoSingleton<YunVaImInterface>.instance.YV_SendCmd(CmdChannel.IM_TOOLS, 102405u, parser);
		}

		public void SpeechStartRequest(string filePath, string ext, Action<ImSpeechStopResp> Response, int type = 0, string url = "")
		{
			YunvaLogPrint.YvDebugLog("SpeechStartRequest", string.Format("filePath:{0},ext:{1},type:{2},url:{3}", filePath, ext, type, url));
			ActionSpeechResp = Response;
			uint parser = MonoSingleton<YunVaImInterface>.instance.YVpacket_get_parser();
			MonoSingleton<YunVaImInterface>.instance.YVparser_set_string(parser, 1, filePath);
			MonoSingleton<YunVaImInterface>.instance.YVparser_set_string(parser, 2, ext);
			MonoSingleton<YunVaImInterface>.instance.YVparser_set_integer(parser, 3, type);
			MonoSingleton<YunVaImInterface>.instance.YVparser_set_string(parser, 4, url);
			MonoSingleton<YunVaImInterface>.instance.YV_SendCmd(CmdChannel.IM_TOOLS, 102406u, parser);
		}

		private void RecordRecognizeRespInfo(object data)
		{
			if (data is ImSpeechStopResp)
			{
				Debug.Log("record recognize...");
				ImSpeechStopResp imSpeechStopResp = (ImSpeechStopResp)data;
				if (data is ImSpeechStopResp && ActionSpeechResp != null)
				{
					ActionSpeechResp((ImSpeechStopResp)data);
					ActionSpeechResp = null;
				}
			}
		}

		public void SpeechSetLanguage(Yvimspeech_language langueage = Yvimspeech_language.im_speech_zn, yvimspeech_outlanguage outlanguage = yvimspeech_outlanguage.im_speechout_simplified)
		{
			YunvaLogPrint.YvDebugLog("SpeechSetLanguage", string.Format("langueage:{0},outlanguage:{1}", langueage, outlanguage));
			uint parser = MonoSingleton<YunVaImInterface>.instance.YVpacket_get_parser();
			MonoSingleton<YunVaImInterface>.instance.YVparser_set_integer(parser, 1, (int)langueage);
			MonoSingleton<YunVaImInterface>.instance.YVparser_set_integer(parser, 2, (int)outlanguage);
			MonoSingleton<YunVaImInterface>.instance.YV_SendCmd(CmdChannel.IM_TOOLS, 102408u, parser);
		}

		public void UploadFileRequest(string filePath, string fileId, Action<ImUploadFileResp> Response)
		{
			YunvaLogPrint.YvDebugLog("UploadFileRequest", string.Format("filePath:{0},fileId:{1}", filePath, fileId));
			ActionUploadFileResp = Response;
			uint parser = MonoSingleton<YunVaImInterface>.instance.YVpacket_get_parser();
			MonoSingleton<YunVaImInterface>.instance.YVparser_set_string(parser, 1, filePath);
			MonoSingleton<YunVaImInterface>.instance.YVparser_set_string(parser, 2, fileId);
			MonoSingleton<YunVaImInterface>.instance.YV_SendCmd(CmdChannel.IM_TOOLS, 102416u, parser);
		}

		private void UploadFileRespInfo(object data)
		{
			if (data is ImUploadFileResp && ActionUploadFileResp != null)
			{
				ActionUploadFileResp((ImUploadFileResp)data);
				ActionUploadFileResp = null;
			}
		}

		public void DownLoadFileRequest(string url, string filePath, string fileid, Action<ImDownLoadFileResp> Response)
		{
			YunvaLogPrint.YvDebugLog("DownLoadFileRequest", string.Format("url:{0},filePath:{1},fileid:{2}", url, filePath, fileid));
			ActionDownLoadFileResp = Response;
			uint parser = MonoSingleton<YunVaImInterface>.instance.YVpacket_get_parser();
			MonoSingleton<YunVaImInterface>.instance.YVparser_set_string(parser, 1, url);
			MonoSingleton<YunVaImInterface>.instance.YVparser_set_string(parser, 2, filePath);
			MonoSingleton<YunVaImInterface>.instance.YVparser_set_string(parser, 3, fileid);
			MonoSingleton<YunVaImInterface>.instance.YV_SendCmd(CmdChannel.IM_TOOLS, 102418u, parser);
		}

		private void DownLoadFileRespInfo(object data)
		{
			if (data is ImDownLoadFileResp && ActionDownLoadFileResp != null)
			{
				ActionDownLoadFileResp((ImDownLoadFileResp)data);
				ActionDownLoadFileResp = null;
			}
		}

		public void RecordSetInfoReq(bool isVolume = false)
		{
			YunvaLogPrint.YvDebugLog("RecordSetInfoReq", string.Format("isVolume:{0}", isVolume));
			RecordSetInfoReq(isVolume, 60);
		}

		public void RecordSetInfoReq(bool isVolume, int length)
		{
			YunvaLogPrint.YvDebugLog("RecordSetInfoReq", string.Format("isVolume:{0},length:{1}", isVolume, length));
			uint parser = MonoSingleton<YunVaImInterface>.instance.YVpacket_get_parser();
			if (isVolume)
			{
				MonoSingleton<YunVaImInterface>.instance.YVparser_set_integer(parser, 1, length);
				MonoSingleton<YunVaImInterface>.instance.YVparser_set_integer(parser, 2, 1);
			}
			else
			{
				MonoSingleton<YunVaImInterface>.instance.YVparser_set_integer(parser, 1, length);
				MonoSingleton<YunVaImInterface>.instance.YVparser_set_integer(parser, 2, 0);
			}
			MonoSingleton<YunVaImInterface>.instance.YV_SendCmd(CmdChannel.IM_TOOLS, 102420u, parser);
		}

		public bool CheckCacheFile(string url)
		{
			YunvaLogPrint.YvDebugLog("CheckCacheFile", string.Format("url:{0}", url));
			uint parser = MonoSingleton<YunVaImInterface>.instance.YVpacket_get_parser();
			MonoSingleton<YunVaImInterface>.instance.YVparser_set_string(parser, 1, url);
			int num = MonoSingleton<YunVaImInterface>.instance.YV_SendCmd(CmdChannel.IM_TOOLS, 102423u, parser);
			return num == 0;
		}

		public void UploadLocationReq(Action<ImUploadLocationResp> Response)
		{
			YunvaLogPrint.YvDebugLog("UploadLocationReq", "UploadLocationReq...");
			ActionUploadLocationResp = Response;
			uint parser = MonoSingleton<YunVaImInterface>.instance.YVpacket_get_parser();
			MonoSingleton<YunVaImInterface>.instance.YV_SendCmd(CmdChannel.IM_LBS, 98304u, parser);
		}

		private void UploadLocationResp(object data)
		{
			if (data is ImUploadLocationResp && ActionUploadLocationResp != null)
			{
				ActionUploadLocationResp((ImUploadLocationResp)data);
				ActionUploadLocationResp = null;
			}
		}

		public void GetLocationReq(Action<ImGetLocationResp> Response)
		{
			YunvaLogPrint.YvDebugLog("GetLocationReq", "GetLocationReq...");
			ActionGetLocationResp = Response;
			uint parser = MonoSingleton<YunVaImInterface>.instance.YVpacket_get_parser();
			MonoSingleton<YunVaImInterface>.instance.YV_SendCmd(CmdChannel.IM_LBS, 98306u, parser);
		}

		private void GetLocationResp(object data)
		{
			if (data is ImGetLocationResp && ActionGetLocationResp != null)
			{
				ActionGetLocationResp((ImGetLocationResp)data);
				ActionGetLocationResp = null;
			}
		}

		public void SearchAroundReq(int range, string city, int sex, int time, int pageIndex, int pageSize, string ext, Action<ImSearchAroundResp> Response, string province = "", string district = "", string detail = "")
		{
			YunvaLogPrint.YvDebugLog("SearchAroundReq", string.Format("range:{0},city:{1},sex:{2},time:{3},pageIndex:{4},pageSize:{5},ext:{6},province:{7},district:{8},detail:{9}", range, city, sex, time, pageIndex, pageSize, ext, province, district, detail));
			ActionSearchAroundResp = Response;
			uint parser = MonoSingleton<YunVaImInterface>.instance.YVpacket_get_parser();
			MonoSingleton<YunVaImInterface>.instance.YVparser_set_integer(parser, 1, range);
			MonoSingleton<YunVaImInterface>.instance.YVparser_set_string(parser, 2, city);
			MonoSingleton<YunVaImInterface>.instance.YVparser_set_integer(parser, 3, sex);
			MonoSingleton<YunVaImInterface>.instance.YVparser_set_integer(parser, 4, time);
			MonoSingleton<YunVaImInterface>.instance.YVparser_set_integer(parser, 5, pageIndex);
			MonoSingleton<YunVaImInterface>.instance.YVparser_set_integer(parser, 6, pageSize);
			MonoSingleton<YunVaImInterface>.instance.YVparser_set_string(parser, 7, ext);
			MonoSingleton<YunVaImInterface>.instance.YVparser_set_string(parser, 8, province);
			MonoSingleton<YunVaImInterface>.instance.YVparser_set_string(parser, 9, district);
			MonoSingleton<YunVaImInterface>.instance.YVparser_set_string(parser, 10, detail);
			MonoSingleton<YunVaImInterface>.instance.YV_SendCmd(CmdChannel.IM_LBS, 98308u, parser);
		}

		private void SearchAroundResp(object data)
		{
			if (data is ImSearchAroundResp && ActionSearchAroundResp != null)
			{
				ActionSearchAroundResp((ImSearchAroundResp)data);
				ActionSearchAroundResp = null;
			}
		}

		public void ShareLocationReq(int hide, Action<ImShareLocationResp> Response)
		{
			YunvaLogPrint.YvDebugLog("ShareLocationReq", string.Format("hide:{0}", hide));
			ActionShareLocationResp = Response;
			uint parser = MonoSingleton<YunVaImInterface>.instance.YVpacket_get_parser();
			MonoSingleton<YunVaImInterface>.instance.YVparser_set_integer(parser, 1, hide);
			MonoSingleton<YunVaImInterface>.instance.YV_SendCmd(CmdChannel.IM_LBS, 98310u, parser);
		}

		private void ShareLocationResp(object data)
		{
			if (data is ImShareLocationResp && ActionShareLocationResp != null)
			{
				ActionShareLocationResp((ImShareLocationResp)data);
				ActionShareLocationResp = null;
			}
		}

		public void ImLBSSetLocatingTypeReq(bool isGpsLocate, bool isWifiLocate, bool isCellLocate, bool isNetWork, bool isBluetooth, Action<ImLBSSetLocatingTypeResp> Response)
		{
			YunvaLogPrint.YvDebugLog("ImLBSSetLocatingTypeReq", string.Format("isGpsLocate:{0},isWifiLocate:{1},isCellLocate:{2},isNetWork:{3},isBluetooth:{4}", isGpsLocate, isWifiLocate, isCellLocate, isNetWork, isBluetooth));
			ActionImLBSSetLocatingTypeResp = Response;
			uint parser = MonoSingleton<YunVaImInterface>.instance.YVpacket_get_parser();
			if (isGpsLocate)
			{
				MonoSingleton<YunVaImInterface>.instance.YVparser_set_uint8(parser, 1, 0);
			}
			else
			{
				MonoSingleton<YunVaImInterface>.instance.YVparser_set_uint8(parser, 1, 1);
			}
			if (isWifiLocate)
			{
				MonoSingleton<YunVaImInterface>.instance.YVparser_set_uint8(parser, 2, 0);
			}
			else
			{
				MonoSingleton<YunVaImInterface>.instance.YVparser_set_uint8(parser, 2, 1);
			}
			if (isCellLocate)
			{
				MonoSingleton<YunVaImInterface>.instance.YVparser_set_uint8(parser, 3, 0);
			}
			else
			{
				MonoSingleton<YunVaImInterface>.instance.YVparser_set_uint8(parser, 3, 1);
			}
			if (isNetWork)
			{
				MonoSingleton<YunVaImInterface>.instance.YVparser_set_uint8(parser, 4, 0);
			}
			else
			{
				MonoSingleton<YunVaImInterface>.instance.YVparser_set_uint8(parser, 4, 1);
			}
			if (isBluetooth)
			{
				MonoSingleton<YunVaImInterface>.instance.YVparser_set_uint8(parser, 5, 0);
			}
			else
			{
				MonoSingleton<YunVaImInterface>.instance.YVparser_set_uint8(parser, 5, 1);
			}
			MonoSingleton<YunVaImInterface>.instance.YV_SendCmd(CmdChannel.IM_LBS, 98322u, parser);
		}

		private void LBSSetLocatingTypeResp(object data)
		{
			if (data is ImLBSSetLocatingTypeResp && ActionImLBSSetLocatingTypeResp != null)
			{
				ActionImLBSSetLocatingTypeResp((ImLBSSetLocatingTypeResp)data);
				ActionImLBSSetLocatingTypeResp = null;
			}
		}

		public void ImLBSGetSpportLangReq(Action<ImLBSGetSpportLangResp> Response)
		{
			YunvaLogPrint.YvDebugLog("ImLBSGetSpportLangReq", "ImLBSGetSpportLangReq...");
			ActionImLBSGetSpportLangResp = Response;
			uint parser = MonoSingleton<YunVaImInterface>.instance.YVpacket_get_parser();
			MonoSingleton<YunVaImInterface>.instance.YV_SendCmd(CmdChannel.IM_LBS, 98312u, parser);
		}

		private void LBSGetSpportLangResp(object data)
		{
			if (data is ImLBSGetSpportLangResp && ActionImLBSGetSpportLangResp != null)
			{
				ActionImLBSGetSpportLangResp((ImLBSGetSpportLangResp)data);
				ActionImLBSGetSpportLangResp = null;
			}
		}

		public void ImLBSSetLocalLangReq(string lang_code, string country_code, Action<ImLBSSetLocalLangResp> Response)
		{
			YunvaLogPrint.YvDebugLog("ImLBSSetLocalLangReq", string.Format("lang_code:{0},country_code:{1}", lang_code, country_code));
			ActionImLBSSetLocalLangResp = Response;
			uint parser = MonoSingleton<YunVaImInterface>.instance.YVpacket_get_parser();
			MonoSingleton<YunVaImInterface>.instance.YVparser_set_string(parser, 1, lang_code);
			MonoSingleton<YunVaImInterface>.instance.YVparser_set_string(parser, 2, country_code);
			MonoSingleton<YunVaImInterface>.instance.YV_SendCmd(CmdChannel.IM_LBS, 98320u, parser);
		}

		private void LBSSetLocalLangResp(object data)
		{
			if (data is ImLBSSetLocalLangResp && ActionImLBSSetLocalLangResp != null)
			{
				ActionImLBSSetLocalLangResp((ImLBSSetLocalLangResp)data);
				ActionImLBSSetLocalLangResp = null;
			}
		}

		private void FriendListNotify(object data)
		{
			if (data is ImFriendListNotify && ActionFriendListNotify != null)
			{
				ActionFriendListNotify((ImFriendListNotify)data);
			}
		}

		private void BlackListNotify(object data)
		{
			if (data is ImFriendBlackListNotify && ActionBlackListNotify != null)
			{
				ActionBlackListNotify((ImFriendBlackListNotify)data);
			}
		}

		public void FriendAddRequest(int userId, Action<ImFriendAddRespond> Response, string greet = "")
		{
			YunvaLogPrint.YvDebugLog("FriendAddRequest", string.Format("userId:{0},greet:{1}", userId, greet));
			ActionFriendAddRespond = Response;
			uint parser = MonoSingleton<YunVaImInterface>.instance.YVpacket_get_parser();
			MonoSingleton<YunVaImInterface>.instance.YVparser_set_integer(parser, 1, userId);
			MonoSingleton<YunVaImInterface>.instance.YVparser_set_string(parser, 2, greet);
			MonoSingleton<YunVaImInterface>.instance.YV_SendCmd(CmdChannel.IM_FRIEND, 73728u, parser);
		}

		private void FriendAddRespond(object data)
		{
			if (data is ImFriendAddRespond && ActionFriendAddRespond != null)
			{
				ActionFriendAddRespond((ImFriendAddRespond)data);
				ActionFriendAddRespond = null;
			}
		}

		public void AcceptOrRefuseRequest(int userId, e_addfriend_affirm affirm, Action<ImFriendAcceptResp> Response, string greet = "")
		{
			YunvaLogPrint.YvDebugLog("AcceptOrRefuseRequest", string.Format("userId:{0},affirm:{1},greet:{2}", userId, affirm, greet));
			ActionAcceptOrRefuse = Response;
			uint parser = MonoSingleton<YunVaImInterface>.instance.YVpacket_get_parser();
			MonoSingleton<YunVaImInterface>.instance.YVparser_set_integer(parser, 1, userId);
			MonoSingleton<YunVaImInterface>.instance.YVparser_set_integer(parser, 2, (int)affirm);
			MonoSingleton<YunVaImInterface>.instance.YVparser_set_string(parser, 3, greet);
			MonoSingleton<YunVaImInterface>.instance.YV_SendCmd(CmdChannel.IM_FRIEND, 73731u, parser);
		}

		private void AcceptOrRefuseResponse(object data)
		{
			if (data is ImFriendAcceptResp && ActionAcceptOrRefuse != null)
			{
				ActionAcceptOrRefuse((ImFriendAcceptResp)data);
				ActionAcceptOrRefuse = null;
			}
		}

		public void DeleteFriendRequest(int userId, e_delfriend act, Action<ImFriendDelResp> Response)
		{
			YunvaLogPrint.YvDebugLog("DeleteFriendRequest", string.Format("userId:{0},act:{1}", userId, act));
			ActionDeleteFriendRequest = Response;
			uint parser = MonoSingleton<YunVaImInterface>.instance.YVpacket_get_parser();
			MonoSingleton<YunVaImInterface>.instance.YVparser_set_integer(parser, 1, userId);
			MonoSingleton<YunVaImInterface>.instance.YVparser_set_integer(parser, 2, (int)act);
			MonoSingleton<YunVaImInterface>.instance.YV_SendCmd(CmdChannel.IM_FRIEND, 73733u, parser);
		}

		private void DeleteFriendResponse(object data)
		{
			if (data is ImFriendDelResp && ActionDeleteFriendRequest != null)
			{
				ActionDeleteFriendRequest((ImFriendDelResp)data);
				ActionDeleteFriendRequest = null;
			}
		}

		public void SearchFriendRequest(string keyWrold, Action<ImFriendSearchResp> Respone, int searchCount)
		{
			YunvaLogPrint.YvDebugLog("SearchFriendRequest", string.Format("keyWrold:{0},searchCount:{1}", keyWrold, searchCount));
			ActionSearchFriendRequest = Respone;
			uint parser = MonoSingleton<YunVaImInterface>.instance.YVpacket_get_parser();
			MonoSingleton<YunVaImInterface>.instance.YVparser_set_string(parser, 1, keyWrold);
			MonoSingleton<YunVaImInterface>.instance.YVparser_set_integer(parser, 2, 0);
			MonoSingleton<YunVaImInterface>.instance.YVparser_set_integer(parser, 3, searchCount);
			MonoSingleton<YunVaImInterface>.instance.YV_SendCmd(CmdChannel.IM_FRIEND, 73752u, parser);
		}

		private void SearchFriendResponse(object data)
		{
			if (data is ImFriendSearchResp && ActionSearchFriendRequest != null)
			{
				ActionSearchFriendRequest((ImFriendSearchResp)data);
				ActionSearchFriendRequest = null;
			}
		}

		public void RecommandFriendRequest(int recommandCount, Action<ImFriendSearchResp> Response = null)
		{
			YunvaLogPrint.YvDebugLog("RecommandFriendRequest", string.Format("recommandCount:{0}", recommandCount));
			ActionRecommandFriendRequest = Response;
			uint parser = MonoSingleton<YunVaImInterface>.instance.YVpacket_get_parser();
			MonoSingleton<YunVaImInterface>.instance.YVparser_set_integer(parser, 1, 0);
			MonoSingleton<YunVaImInterface>.instance.YVparser_set_integer(parser, 2, recommandCount);
			MonoSingleton<YunVaImInterface>.instance.YV_SendCmd(CmdChannel.IM_FRIEND, 73736u, parser);
		}

		private void RecommandFriendRespone(object data)
		{
			if (data is ImFriendSearchResp && ActionRecommandFriendRequest != null)
			{
				ActionRecommandFriendRequest((ImFriendSearchResp)data);
				ActionRecommandFriendRequest = null;
			}
		}

		public void BlackListOperation(int myUserId, int operUserId, Action<ImFriendOperResp> Response, e_oper_friend_act act = e_oper_friend_act.oper_add_blacklist)
		{
			YunvaLogPrint.YvDebugLog("BlackListOperation", string.Format("myUserId:{0},operUserId:{1},act:{2}", myUserId, operUserId, act));
			ActionBlackListOperation = Response;
			uint parser = MonoSingleton<YunVaImInterface>.instance.YVpacket_get_parser();
			MonoSingleton<YunVaImInterface>.instance.YVparser_set_integer(parser, 1, myUserId);
			MonoSingleton<YunVaImInterface>.instance.YVparser_set_integer(parser, 2, operUserId);
			MonoSingleton<YunVaImInterface>.instance.YVparser_set_integer(parser, 3, (int)act);
			MonoSingleton<YunVaImInterface>.instance.YV_SendCmd(CmdChannel.IM_FRIEND, 73744u, parser);
		}

		private void BlackListOperationResponse(object data)
		{
			if (data is ImFriendOperResp && ActionBlackListOperation != null)
			{
				ActionBlackListOperation((ImFriendOperResp)data);
				ActionBlackListOperation = null;
			}
		}

		public void SetFriendInfoRequest(int friendId, string group, string note, Action<object> Response)
		{
			YunvaLogPrint.YvDebugLog("SetFriendInfoRequest", string.Format("friendId:{0},group:{1},note:{2}", friendId, group, note));
			ActionSetFriendInfoRequest = Response;
			uint parser = MonoSingleton<YunVaImInterface>.instance.YVpacket_get_parser();
			MonoSingleton<YunVaImInterface>.instance.YVparser_set_integer(parser, 1, friendId);
			MonoSingleton<YunVaImInterface>.instance.YVparser_set_string(parser, 2, group);
			MonoSingleton<YunVaImInterface>.instance.YVparser_set_string(parser, 3, note);
			MonoSingleton<YunVaImInterface>.instance.YV_SendCmd(CmdChannel.IM_FRIEND, 73750u, parser);
		}

		private void SetFriendInfoResponse(object data)
		{
			if (ActionSetFriendInfoRequest != null)
			{
				ActionSetFriendInfoRequest(data);
				ActionSetFriendInfoRequest = null;
			}
		}

		public void GetUserInfoRequest(int userId, Action<ImUserGetInfoResp> Response)
		{
			YunvaLogPrint.YvDebugLog("GetUserInfoRequest", string.Format("userId:{0}", userId));
			ActionGetUserInfoRequest = Response;
			uint parser = MonoSingleton<YunVaImInterface>.instance.YVpacket_get_parser();
			MonoSingleton<YunVaImInterface>.instance.YVparser_set_integer(parser, 1, userId);
			MonoSingleton<YunVaImInterface>.instance.YV_SendCmd(CmdChannel.IM_FRIEND, 73760u, parser);
		}

		private void GetUserInfoResponse(object data)
		{
			if (data is ImUserGetInfoResp && ActionGetUserInfoRequest != null)
			{
				ActionGetUserInfoRequest((ImUserGetInfoResp)data);
				ActionGetUserInfoRequest = null;
			}
		}

		public void RemoveContactesReq(int userId, Action<ImRemoveContactesResp> Response)
		{
			YunvaLogPrint.YvDebugLog("RemoveContactesReq", string.Format("userId:{0}", userId));
			ActionRemoveContactesResp = Response;
			uint parser = MonoSingleton<YunVaImInterface>.instance.YVpacket_get_parser();
			MonoSingleton<YunVaImInterface>.instance.YVparser_set_integer(parser, 1, userId);
			MonoSingleton<YunVaImInterface>.instance.YV_SendCmd(CmdChannel.IM_FRIEND, 73766u, parser);
		}

		private void RemoveContactesResp(object data)
		{
			if (data is ImRemoveContactesResp && ActionRemoveContactesResp != null)
			{
				ActionRemoveContactesResp((ImRemoveContactesResp)data);
				ActionRemoveContactesResp = null;
			}
		}

		public int SendP2PTextMessage(int userId, string textMsg, Action<ImChatFriendResp> Response, string flag, string ext = "")
		{
			YunvaLogPrint.YvDebugLog("SendP2PTextMessage", string.Format("userId:{0},textMsg:{1},flag:{2},ext:{3}", userId, textMsg, flag, ext));
			uint parser = MonoSingleton<YunVaImInterface>.instance.YVpacket_get_parser();
			MonoSingleton<YunVaImInterface>.instance.YVparser_set_integer(parser, 1, userId);
			MonoSingleton<YunVaImInterface>.instance.YVparser_set_string(parser, 2, textMsg);
			MonoSingleton<YunVaImInterface>.instance.YVparser_set_string(parser, 3, ext);
			MonoSingleton<YunVaImInterface>.instance.YVparser_set_string(parser, 4, flag);
			int num = MonoSingleton<YunVaImInterface>.instance.YV_SendCmd(CmdChannel.IM_CHAT, 81920u, parser);
			Debug.Log("SendP2PTextMessage ret=" + num);
			if (num == 0)
			{
				Action<ImChatFriendResp> value;
				if (SendFriendMsgRespMapping.TryGetValue(flag, out value))
				{
					value = Response;
				}
				else
				{
					SendFriendMsgRespMapping.Add(flag, Response);
				}
			}
			else
			{
				Debug.Log("fail in send...");
			}
			return num;
		}

		public int SendP2PTextMessage(string gameUserID, string textMsg, Action<ImChatFriendResp> Response, string flag, string ext = "")
		{
			int ret = 0;
			YunvaLogPrint.YvDebugLog("SendP2PTextMessage", string.Format("gameUserID:{0}", gameUserID));
			YunVaGetThirdBindInfo((int)appid, gameUserID, delegate(ImGetThirdBindInfoResp data)
			{
				ret = SendP2PTextMessage(data.yunvaId, textMsg, Response, flag, ext);
			});
			return ret;
		}

		public int SendP2PVoiceMessage(int userId, string filePath, int audioTime, string txt, Action<ImChatFriendResp> Response, string flag, string ext = "")
		{
			YunvaLogPrint.YvDebugLog("SendP2PVoiceMessage", string.Format("userId:{0},filePath:{1},audioTime:{2},txt:{3},flag:{4},ext:{5}", userId, filePath, audioTime, txt, flag, ext));
			uint parser = MonoSingleton<YunVaImInterface>.instance.YVpacket_get_parser();
			MonoSingleton<YunVaImInterface>.instance.YVparser_set_integer(parser, 1, userId);
			MonoSingleton<YunVaImInterface>.instance.YVparser_set_string(parser, 2, filePath);
			MonoSingleton<YunVaImInterface>.instance.YVparser_set_integer(parser, 3, audioTime);
			if (!string.IsNullOrEmpty(txt))
			{
				MonoSingleton<YunVaImInterface>.instance.YVparser_set_string(parser, 4, txt);
			}
			MonoSingleton<YunVaImInterface>.instance.YVparser_set_string(parser, 5, ext);
			MonoSingleton<YunVaImInterface>.instance.YVparser_set_string(parser, 6, flag);
			int num = MonoSingleton<YunVaImInterface>.instance.YV_SendCmd(CmdChannel.IM_CHAT, 81922u, parser);
			Debug.Log("SendP2PVoiceMessage ret=" + num);
			if (num == 0)
			{
				Action<ImChatFriendResp> value;
				if (SendFriendMsgRespMapping.TryGetValue(flag, out value))
				{
					value = Response;
				}
				else
				{
					SendFriendMsgRespMapping.Add(flag, Response);
				}
			}
			else
			{
				Debug.Log("fail in send...");
			}
			return num;
		}

		private void SendFriendMsgResponse(object data)
		{
			if (!(data is ImChatFriendResp))
			{
				return;
			}
			ImChatFriendResp imChatFriendResp = (ImChatFriendResp)data;
			string flag = imChatFriendResp.flag;
			Action<ImChatFriendResp> value;
			if (SendFriendMsgRespMapping.TryGetValue(flag, out value))
			{
				SendFriendMsgRespMapping.Remove(flag);
				if (value != null)
				{
					value(imChatFriendResp);
				}
			}
		}

		public int SendP2PVoiceMessage(string gameUserID, string filePath, int audioTime, string txt, Action<ImChatFriendResp> Response, string flag, string ext = "")
		{
			int ret = 0;
			YunvaLogPrint.YvDebugLog("SendP2PVoiceMessage", string.Format("gameUserID:{0}", gameUserID));
			YunVaGetThirdBindInfo((int)appid, gameUserID, delegate(ImGetThirdBindInfoResp data)
			{
				ret = SendP2PVoiceMessage(data.yunvaId, filePath, audioTime, txt, Response, flag, ext);
			});
			return ret;
		}

		public int SendChannelTextMessage(string textMsg, string wildCard, Action<ImChannelSendMsgResp> Response, string expand, string flag = "")
		{
			YunvaLogPrint.YvDebugLog("SendChannelTextMessage", string.Format("textMsg:{0},wildCard:{1},expand:{2},flag:{3}", textMsg, wildCard, expand, flag));
			Action<ImChannelSendMsgResp> value;
			if (SendChannelMsgRespMapping.TryGetValue(flag, out value))
			{
				value = Response;
			}
			else
			{
				SendChannelMsgRespMapping.Add(flag, Response);
			}
			uint parser = MonoSingleton<YunVaImInterface>.instance.YVpacket_get_parser();
			MonoSingleton<YunVaImInterface>.instance.YVparser_set_string(parser, 1, textMsg);
			MonoSingleton<YunVaImInterface>.instance.YVparser_set_string(parser, 2, wildCard);
			MonoSingleton<YunVaImInterface>.instance.YVparser_set_string(parser, 3, expand);
			MonoSingleton<YunVaImInterface>.instance.YVparser_set_string(parser, 4, flag);
			int num = MonoSingleton<YunVaImInterface>.instance.YV_SendCmd(CmdChannel.IM_CHANNEL, 90114u, parser);
			Debug.Log("SendChannelTextMessage return:" + num);
			switch (num)
			{
			case 1004:
				Debug.Log("yunva come in 1004...");
				break;
			default:
				Debug.Log("fail in send...");
				break;
			case 0:
				break;
			}
			return num;
		}

		public int SendChannelVoiceMessage(string voicePath, int voiceDurationTime, string wildCard, string text, Action<ImChannelSendMsgResp> Response, string expand, string flag = "")
		{
			YunvaLogPrint.YvDebugLog("SendChannelVoiceMessage", string.Format("voicePath:{0},voiceDurationTime:{1},wildCard:{2},text:{3},expand:{4},flag:{5}", voicePath, voiceDurationTime, wildCard, text, expand, flag));
			uint parser = MonoSingleton<YunVaImInterface>.instance.YVpacket_get_parser();
			MonoSingleton<YunVaImInterface>.instance.YVparser_set_string(parser, 1, voicePath);
			MonoSingleton<YunVaImInterface>.instance.YVparser_set_integer(parser, 2, voiceDurationTime);
			MonoSingleton<YunVaImInterface>.instance.YVparser_set_string(parser, 3, wildCard);
			if (!string.IsNullOrEmpty(text))
			{
				MonoSingleton<YunVaImInterface>.instance.YVparser_set_string(parser, 4, text);
			}
			MonoSingleton<YunVaImInterface>.instance.YVparser_set_string(parser, 5, expand);
			MonoSingleton<YunVaImInterface>.instance.YVparser_set_string(parser, 6, flag);
			int num = MonoSingleton<YunVaImInterface>.instance.YV_SendCmd(CmdChannel.IM_CHANNEL, 90115u, parser);
			Debug.Log("SendChannelVoiceMessage return:" + num);
			if (num == 0)
			{
				Action<ImChannelSendMsgResp> value;
				if (SendChannelMsgRespMapping.TryGetValue(flag, out value))
				{
					value = Response;
				}
				else
				{
					SendChannelMsgRespMapping.Add(flag, Response);
				}
			}
			else
			{
				Debug.Log("fail in send...");
			}
			return num;
		}

		private void SendChannelMsgResponse(object data)
		{
			if (!(data is ImChannelSendMsgResp))
			{
				return;
			}
			ImChannelSendMsgResp imChannelSendMsgResp = data as ImChannelSendMsgResp;
			string flag = imChannelSendMsgResp.flag;
			Debug.Log("recive falg:" + flag);
			Action<ImChannelSendMsgResp> value;
			if (SendChannelMsgRespMapping.TryGetValue(flag, out value))
			{
				SendChannelMsgRespMapping.Remove(flag);
				if (value != null)
				{
					value(imChannelSendMsgResp);
				}
			}
		}

		public void LoginChannel(int channel, string wildCard, Action<ImChannelMotifyResp> Response)
		{
			YunvaLogPrint.YvDebugLog("LoginChannel", string.Format("channel:{0},wildCard:{1}", channel, wildCard));
			ActionImChannelMotifyResp = Response;
			uint parser = MonoSingleton<YunVaImInterface>.instance.YVpacket_get_parser();
			MonoSingleton<YunVaImInterface>.instance.YVparser_set_integer(parser, 1, 1);
			MonoSingleton<YunVaImInterface>.instance.YVparser_set_integer(parser, 2, channel);
			MonoSingleton<YunVaImInterface>.instance.YVparser_set_string(parser, 3, wildCard);
			MonoSingleton<YunVaImInterface>.instance.YV_SendCmd(CmdChannel.IM_CHANNEL, 90129u, parser);
		}

		public void LogoutChannel(int channel, string wildCard, Action<ImChannelMotifyResp> Response)
		{
			YunvaLogPrint.YvDebugLog("LogoutChannel", string.Format("channel:{0},wildCard:{1}", channel, wildCard));
			ActionImChannelMotifyResp = Response;
			uint parser = MonoSingleton<YunVaImInterface>.instance.YVpacket_get_parser();
			MonoSingleton<YunVaImInterface>.instance.YVparser_set_integer(parser, 1, 0);
			MonoSingleton<YunVaImInterface>.instance.YVparser_set_integer(parser, 2, channel);
			MonoSingleton<YunVaImInterface>.instance.YVparser_set_string(parser, 3, wildCard);
			MonoSingleton<YunVaImInterface>.instance.YV_SendCmd(CmdChannel.IM_CHANNEL, 90129u, parser);
		}

		private void ChannelMotifyResponse(object data)
		{
			if (data is ImChannelMotifyResp && ActionImChannelMotifyResp != null)
			{
				ActionImChannelMotifyResp((ImChannelMotifyResp)data);
				ActionImChannelMotifyResp = null;
			}
		}

		private void loginChannelResponse(object data)
		{
			if (data is ImChannelLoginResp && ActionLoginChannelResp != null)
			{
				ActionLoginChannelResp((ImChannelLoginResp)data);
				ActionLoginChannelResp = null;
			}
		}

		public void getChannelHistoryMsg(int index, int count, string wildcard, Action<ImChannelHistoryMsgResp> Response)
		{
			YunvaLogPrint.YvDebugLog("getChannelHistoryMsg", string.Format("index:{0},count:{1},wildcard:{2}", index, count, wildcard));
			ActionGetChannelHistoryMsgResp = Response;
			uint parser = MonoSingleton<YunVaImInterface>.instance.YVpacket_get_parser();
			MonoSingleton<YunVaImInterface>.instance.YVparser_set_integer(parser, 1, index);
			MonoSingleton<YunVaImInterface>.instance.YVparser_set_integer(parser, 2, count);
			MonoSingleton<YunVaImInterface>.instance.YVparser_set_string(parser, 3, wildcard);
			MonoSingleton<YunVaImInterface>.instance.YV_SendCmd(CmdChannel.IM_CHANNEL, 90117u, parser);
		}

		private void getChannelHistoryMsgResponse(object data)
		{
			if (data is ImChannelHistoryMsgResp && ActionGetChannelHistoryMsgResp != null)
			{
				ActionGetChannelHistoryMsgResp((ImChannelHistoryMsgResp)data);
				ActionGetChannelHistoryMsgResp = null;
			}
		}

		public void getChannelGetParamReq(Action<ImChannelGetParamResp> Response)
		{
			YunvaLogPrint.YvDebugLog("getChannelGetParamReq", "getChannelGetParamReq...");
			ActionChannelGetParamResp = Response;
			uint parser = MonoSingleton<YunVaImInterface>.instance.YVpacket_get_parser();
			MonoSingleton<YunVaImInterface>.instance.YV_SendCmd(CmdChannel.IM_CHANNEL, 90132u, parser);
		}

		private void ChannelGetParamResponse(object data)
		{
			if (data is ImChannelGetParamResp && ActionChannelGetParamResp != null)
			{
				ActionChannelGetParamResp((ImChannelGetParamResp)data);
				ActionChannelGetParamResp = null;
			}
		}

		public void cloudMsgRequest(string source, int id, int end, int limit, Action<ImCloudMsgLimitResp> Response)
		{
			YunvaLogPrint.YvDebugLog("cloudMsgRequest", string.Format("source:{0},id:{1},end:{2},limit:{3}", source, id, end, limit));
			if (limit < -20)
			{
				limit = -20;
			}
			ActioncloudMsgResp = Response;
			uint parser = MonoSingleton<YunVaImInterface>.instance.YVpacket_get_parser();
			MonoSingleton<YunVaImInterface>.instance.YVparser_set_string(parser, 1, source);
			MonoSingleton<YunVaImInterface>.instance.YVparser_set_integer(parser, 2, id);
			MonoSingleton<YunVaImInterface>.instance.YVparser_set_integer(parser, 3, end);
			MonoSingleton<YunVaImInterface>.instance.YVparser_set_integer(parser, 4, limit);
			MonoSingleton<YunVaImInterface>.instance.YV_SendCmd(CmdChannel.IM_CLOUND, 86019u, parser);
		}

		private void cloudMsgResponse(object data)
		{
			if (data is ImCloudMsgLimitResp && ActioncloudMsgResp != null)
			{
				ActioncloudMsgResp((ImCloudMsgLimitResp)data);
				ActioncloudMsgResp = null;
			}
		}

		public void cloudMsgConfirmRequest(int id, string source)
		{
			YunvaLogPrint.YvDebugLog("cloudMsgConfirmRequest", string.Format("id:{0},source:{1}", id, source));
			uint parser = MonoSingleton<YunVaImInterface>.instance.YVpacket_get_parser();
			MonoSingleton<YunVaImInterface>.instance.YVparser_set_integer(parser, 1, id);
			MonoSingleton<YunVaImInterface>.instance.YVparser_set_string(parser, 2, source);
			MonoSingleton<YunVaImInterface>.instance.YV_SendCmd(CmdChannel.IM_CLOUND, 86023u, parser);
		}

		public void outLineMsgIgnoreRequest(string source, int id, int index)
		{
			YunvaLogPrint.YvDebugLog("outLineMsgIgnoreRequest", string.Format("source:{0},id:{1},index:{2}", source, id, index));
			uint parser = MonoSingleton<YunVaImInterface>.instance.YVpacket_get_parser();
			MonoSingleton<YunVaImInterface>.instance.YVparser_set_string(parser, 1, source);
			MonoSingleton<YunVaImInterface>.instance.YVparser_set_integer(parser, 2, id);
			MonoSingleton<YunVaImInterface>.instance.YVparser_set_integer(parser, 3, index);
			MonoSingleton<YunVaImInterface>.instance.YV_SendCmd(CmdChannel.IM_CLOUND, 86024u, parser);
		}

		public void YvLog_setLogLevel(int logLevel = 1)
		{
			YunvaLogPrint.YvLog_setLogLevel(logLevel);
		}
	}
}
