namespace YunvaIM
{
	public enum ProtocolEnum : uint
	{
		IM_LOGIN_REQ = 69632u,
		IM_LOGIN_RESP = 69633u,
		IM_THIRD_LOGIN_REQ = 69634u,
		IM_THIRD_LOGIN_RESP = 69635u,
		IM_LOGOUT_REQ = 69636u,
		IM_DEVICE_SETINFO = 69650u,
		IM_RECONNECTION_NOTIFY = 69651u,
		IM_GET_THIRDBINDINFO_REQ = 69652u,
		IM_GET_THIRDBINDINFO_RESP = 69653u,
		IM_NET_STATE_NOTIFY = 69654u,
		IM_SETUSERINFO_REQ = 69657u,
		IM_SETUSERINFO_RESP = 69664u,
		IM_RECORD_STRART_REQ = 102400u,
		IM_RECORD_STOP_REQ = 102401u,
		IM_RECORD_STOP_RESP = 102402u,
		IM_RECORD_STARTPLAY_REQ = 102403u,
		IM_RECORD_FINISHPLAY_RESP = 102404u,
		IM_RECORD_STOPPLAY_REQ = 102405u,
		IM_SPEECH_START_REQ = 102406u,
		IM_SPEECH_STOP_REQ = 102407u,
		IM_SPEECH_STOP_RESP = 102409u,
		IM_SPEECH_SETLANGUAGE_REQ = 102408u,
		IM_UPLOAD_FILE_REQ = 102416u,
		IM_UPLOAD_FILE_RESP = 102417u,
		IM_DOWNLOAD_FILE_REQ = 102418u,
		IM_DOWNLOAD_FILE_RESP = 102419u,
		IM_RECORD_SETINFO_REQ = 102420u,
		IM_RECORD_VOLUME_NOTIFY = 102421u,
		IM_RECORD_PLAY_PERCENT_NOTIFY = 102422u,
		IM_TOOL_HAS_CACHE_FILE = 102423u,
		IM_UPLOAD_LOCATION_REQ = 98304u,
		IM_UPLOAD_LOCATION_RESP = 98305u,
		IM_GET_LOCATION_REQ = 98306u,
		IM_GET_LOCATION_RESP = 98307u,
		IM_SEARCH_AROUND_REQ = 98308u,
		IM_SEARCH_AROUND_RESP = 98309u,
		IM_SHARE_LOCATION_REQ = 98310u,
		IM_SHARE_LOCATION_RESP = 98311u,
		IM_LBS_GET_SUPPORT_LANG_REQ = 98312u,
		IM_LBS_GET_SUPPORT_LANG_RESP = 98313u,
		IM_LBS_SET_LOCAL_LANG_REQ = 98320u,
		IM_LBS_SET_LOCAL_LANG_RESP = 98321u,
		IM_LBS_SET_LOCATING_TYPE_REQ = 98322u,
		IM_LBS_SET_LOCATING_TYPE_RESP = 98323u,
		IM_FRIEND_ADD_REQ = 73728u,
		IM_FRIEND_ADD_RESP = 73729u,
		IM_FRIEND_ADD_NOTIFY = 73730u,
		IM_FRIEND_ADD_ACCEPT = 73731u,
		IM_FRIEND_ACCEPT_RESP = 73732u,
		IM_FRIEND_DEL_REQ = 73733u,
		IM_FRIEND_DEL_RESP = 73734u,
		IM_FRIEND_DEL_NOTIFY = 73735u,
		IM_FRIEND_RECOMMAND_REQ = 73736u,
		IM_FRIEND_RECOMMAND_RESP = 73737u,
		IM_FRIEND_OPER_REQ = 73744u,
		IM_FRIEND_OPER_RESP = 73745u,
		IM_FRIEND_LIST_NOTIFY = 73746u,
		IM_FRIEND_BLACKLIST_NOTIFY = 73747u,
		IM_FRIEND_NEARLIST_NOTIFY = 73748u,
		IM_FRIEND_STATUS_NOTIFY = 73749u,
		IM_FRIEND_INFOSET_REQ = 73750u,
		IM_FRIEND_INFOSET_RESP = 73751u,
		IM_FRIEND_SEARCH_REQ = 73752u,
		IM_FRIEND_SEARCH_RESP = 73753u,
		IM_USER_GETINFO_REQ = 73760u,
		IM_USER_GETINFO_RESP = 73761u,
		IM_USER_SETINFO_REQ = 73762u,
		IM_USER_SETINFO_RESP = 73763u,
		IM_USER_SETINFO_NOTIFY = 73764u,
		IM_FRIEND_ADD_RESPOND = 73765u,
		IM_REMOVE_CONTACTES_REQ = 73766u,
		IM_REMOVE_CONTACTES_RESP = 73767u,
		IM_CHAT_FRIEND_TEXT_REQ = 81920u,
		IM_CHAT_FRIEND_IMAGE_REQ = 81921u,
		IM_CHAT_FRIEND_AUDIO_REQ = 81922u,
		IM_CHAT_FRIEND_RESP = 81924u,
		IM_CHAT_FRIEND_NOTIFY = 81923u,
		IM_CLOUDMSG_NOTIFY = 86018u,
		IM_CLOUDMSG_LIMIT_REQ = 86019u,
		IM_CLOUDMSG_LIMIT_RESP = 86020u,
		IM_CLOUDMSG_LIMIT_NOTIFY = 86021u,
		IM_MSG_PUSH = 86022u,
		IM_CLOUDMSG_READ_STATUS = 86023u,
		IM_CLOUDMSG_IGNORE_REQ = 86024u,
		IM_CHANNEL_LOGIN_REQ = 90119u,
		IM_CHANNEL_LOGIN_RESP = 90120u,
		IM_CHANNEL_LOGOUT_REQ = 90121u,
		IM_CHANNEL_MODIFY_REQ = 90129u,
		IM_CHANNEL_MODIFY_RESP = 90130u,
		IM_CHANNEL_GETINFO_REQ = 90112u,
		IM_CHANNEL_GETINFO_RESP = 90113u,
		IM_CHANNEL_TEXTMSG_REQ = 90114u,
		IM_CHANNEL_VOICEMSG_REQ = 90115u,
		IM_CHANNEL_SENDMSG_RESP = 90128u,
		IM_CHANNEL_MESSAGE_NOTIFY = 90116u,
		IM_CHANNEL_HISTORY_MSG_REQ = 90117u,
		IM_CHANNEL_HISTORY_MSG_RESP = 90118u,
		IM_CHANNEL_PUSH_MSG_NOTIFY = 90131u,
		IM_CHANNEL_GET_PARAM_REQ = 90132u,
		IM_CHANNEL_GET_PARAM_RESP = 90133u,
		IM_GROUP_USERLIST_NOTIFY = 77824u,
		IM_GROUP_USERMDY_NOTIFY = 77825u,
		IM_GROUP_CREATE_REQ = 77826u,
		IM_GROUP_CREATE_RESP = 77827u,
		IM_GROUP_SEARCH_REQ = 77828u,
		IM_GROUP_SEARCH_RESP = 77829u,
		IM_GROUP_JOIN_REQ = 77830u,
		IM_GROUP_JOIN_NOTIFY = 77831u,
		IM_GROUP_JOIN_ACCEPT = 77832u,
		IM_GROUP_JOIN_RESP = 77833u,
		IM_GROUP_EXIT_REQ = 77840u,
		IM_GROUP_EXIT_RESP = 77841u,
		IM_GROUP_EXIT_NOTIFY = 77842u,
		IM_GROUP_MODIFY_REQ = 77843u,
		IM_GROUP_MODIFY_RESP = 77844u,
		IM_GROUP_SHIFTOWNER_REQ = 77845u,
		IM_GROUP_SHIFTOWNER_NOTIFY = 77846u,
		IM_GROUP_SHIFTOWNER_RESP = 77847u,
		IM_GROUP_KICK_REQ = 77848u,
		IM_KGROUP_KICK_NOTIFY = 77849u,
		IM_GROUP_KICK_RESP = 77856u,
		IM_GROUP_INVITE_REQ = 77857u,
		IM_GROUP_INVITE_NOTIFY = 77858u,
		IM_GROUP_INVITE_ACCEPT = 77859u,
		IM_GROUP_INVITE_RESP = 77860u,
		IM_GROUP_SETROLE_REQ = 77861u,
		IM_GROUP_SETROLE_RESP = 77862u,
		IM_GROUP_SETROLE_NOTIFY = 77863u,
		IM_GROUP_DISSOLVE_REQ = 77864u,
		IM_GROUP_DISSOLVE_RESP = 77865u,
		IM_GROUP_SETOTHER_REQ = 77872u,
		IM_GROUP_SETOTHER_NOTIFY = 77873u,
		IM_GROUP_SETOTHER_RESP = 77874u,
		IM_GROUP_PROPERTY_NOTIFY = 77875u,
		IM_GROUP_MEMBER_ONLINE = 77876u,
		IM_GROUP_USERJOIN_NOTIFY = 77877u,
		CreateEnterPointAtFirst = 77878u,
		RemoveMessageList = 77879u
	}
}