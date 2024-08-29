using System.Collections.Generic;

namespace YunvaIM
{
	public class ImFriendListNotify : YunvaMsgBase
	{
		public List<xUserInfo> userInfoList;

		public ImFriendListNotify(object Parser)
		{
			uint parser = (uint)Parser;
			userInfoList = new List<xUserInfo>();
			userInfoList = InsertUserInfo(parser, 1);
			InvokeEventClass item = new InvokeEventClass(ProtocolEnum.IM_FRIEND_LIST_NOTIFY, this);
			YunVaImInterface.eventQueue.Enqueue(item);
		}

		private List<xUserInfo> InsertUserInfo(uint parser, byte cmdId = 1)
		{
			List<xUserInfo> list = new List<xUserInfo>();
			for (int i = 0; !YunVaImInterface.parser_is_empty(parser, cmdId, i); i++)
			{
				uint num = YunVaImInterface.yvpacket_get_nested_parser(parser);
				YunVaImInterface.parser_get_object(parser, cmdId, num, i);
				xUserInfo xUserInfo = new xUserInfo();
				xUserInfo.nickName = YunVaImInterface.IntPtrToString(YunVaImInterface.parser_get_string(num, 1));
				xUserInfo.userId = YunVaImInterface.parser_get_integer(num, 2);
				xUserInfo.iconUrl = YunVaImInterface.IntPtrToString(YunVaImInterface.parser_get_string(num, 3));
				xUserInfo.onLine = YunVaImInterface.parser_get_integer(num, 4);
				xUserInfo.userLevel = YunVaImInterface.IntPtrToString(YunVaImInterface.parser_get_string(num, 5));
				xUserInfo.vipLevel = YunVaImInterface.IntPtrToString(YunVaImInterface.parser_get_string(num, 6));
				xUserInfo.ext = YunVaImInterface.IntPtrToString(YunVaImInterface.parser_get_string(num, 7));
				xUserInfo.shieldmsg = YunVaImInterface.parser_get_integer(num, 8);
				xUserInfo.sex = YunVaImInterface.parser_get_integer(num, 9);
				xUserInfo.group = YunVaImInterface.IntPtrToString(YunVaImInterface.parser_get_string(num, 10));
				xUserInfo.remark = YunVaImInterface.IntPtrToString(YunVaImInterface.parser_get_string(num, 11));
				YunvaLogPrint.YvInfoLog("ImFriendListNotify", string.Format("nickName:{0},userId:{1},iconUrl:{2},onLine:{3},userLevel:{4},vipLevel:{5},ext:{6},shieldmsg:{7},sex:{8},group:{9},remark:{10}", xUserInfo.nickName, xUserInfo.userId, xUserInfo.iconUrl, xUserInfo.onLine, xUserInfo.userLevel, xUserInfo.vipLevel, xUserInfo.ext, xUserInfo.shieldmsg, xUserInfo.sex, xUserInfo.group, xUserInfo.remark));
				list.Add(xUserInfo);
			}
			return list;
		}
	}
}
