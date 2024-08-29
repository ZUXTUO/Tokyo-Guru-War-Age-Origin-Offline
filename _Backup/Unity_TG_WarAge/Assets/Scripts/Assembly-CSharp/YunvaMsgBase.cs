using YunvaIM;

public class YunvaMsgBase
{
	public static YunvaMsgBase GetMsg(uint CmdId, object Parser)
	{
		switch (CmdId)
		{
		case 69635u:
			return new ImThirdLoginResp(Parser);
		case 73729u:
			return new ImFriendAddResp(Parser);
		case 73730u:
			return new ImFriendAddNotify(Parser);
		case 73732u:
			return new ImFriendAcceptResp(Parser);
		case 73734u:
			return new ImFriendDelResp(Parser);
		case 73737u:
			return new ImFriendSearchResp(Parser, ProtocolEnum.IM_FRIEND_RECOMMAND_RESP);
		case 73753u:
			return new ImFriendSearchResp(Parser, ProtocolEnum.IM_FRIEND_SEARCH_RESP);
		case 73745u:
			return new ImFriendOperResp(Parser);
		case 73761u:
			return new ImUserGetInfoResp(Parser);
		case 86018u:
			return new ImCloudMsgNotify(Parser);
		case 73735u:
			return new ImFriendDelNotify(Parser);
		case 73746u:
			return new ImFriendListNotify(Parser);
		case 73747u:
			return new ImFriendBlackListNotify(Parser);
		case 81923u:
			return new ImChatFriendNotify(Parser);
		case 86020u:
			return new ImCloudMsgLimitResp(Parser);
		case 86021u:
			return new ImCloudmsgLimitNotify(Parser);
		case 81924u:
			return new ImChatFriendResp(Parser);
		case 90116u:
			return new ImChannelMessageNotify(Parser);
		case 90113u:
			return new ImChannelGetInfoResp(Parser);
		case 90128u:
			return new ImChannelSendMsgResp(Parser);
		case 90118u:
			return new ImChannelHistoryMsgResp(Parser);
		case 102402u:
			return new ImRecordStopResp(Parser);
		case 102409u:
			return new ImSpeechStopResp(Parser);
		case 102404u:
			return new ImRecordFinishPlayResp(Parser);
		case 69654u:
			return new ImNetStateNotify(Parser);
		case 102421u:
			return new ImRecordVolumeNotify(Parser);
		case 69651u:
			return new ImReconnectionNotify(Parser);
		case 102417u:
			return new ImUploadFileResp(Parser);
		case 102419u:
			return new ImDownLoadFileResp(Parser);
		case 73748u:
			return new ImFriendNearListNotify(Parser);
		case 102422u:
			return new ImPlayPercentNotify(Parser);
		case 69653u:
			return new ImGetThirdBindInfoResp(Parser);
		case 73767u:
			return new ImRemoveContactesResp(Parser);
		case 90130u:
			return new ImChannelMotifyResp(Parser);
		case 90131u:
			return new ImChannelPushMsgNotify(Parser);
		case 98305u:
			return new ImUploadLocationResp(Parser);
		case 98307u:
			return new ImGetLocationResp(Parser);
		case 98309u:
			return new ImSearchAroundResp(Parser);
		case 98311u:
			return new ImShareLocationResp(Parser);
		case 98323u:
			return new ImLBSSetLocatingTypeResp(Parser);
		case 98313u:
			return new ImLBSGetSpportLangResp(Parser);
		case 98321u:
			return new ImLBSSetLocalLangResp(Parser);
		case 90133u:
			return new ImChannelGetParamResp(Parser);
		case 90120u:
			return new ImChannelLoginResp(Parser);
		case 69664u:
			return new ImSetUserInfoResp(Parser);
		case 73765u:
			return new ImFriendAddRespond(Parser);
		default:
			return null;
		}
	}
}
