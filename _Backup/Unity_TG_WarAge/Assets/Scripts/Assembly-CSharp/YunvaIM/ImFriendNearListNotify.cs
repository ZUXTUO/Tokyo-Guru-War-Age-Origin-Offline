using System.Collections.Generic;

namespace YunvaIM
{
	public class ImFriendNearListNotify : YunvaMsgBase
	{
		public List<RecentConact> recentList;

		public ImFriendNearListNotify(object Parse)
		{
			recentList = GetRecentConactList(Parse, 1);
			YunVaImInterface.eventQueue.Enqueue(new InvokeEventClass(ProtocolEnum.IM_FRIEND_NEARLIST_NOTIFY, this));
		}

		private List<RecentConact> GetRecentConactList(object Parser, byte cmdId = 1)
		{
			uint parser = (uint)Parser;
			List<RecentConact> list = new List<RecentConact>();
			for (int i = 0; !YunVaImInterface.parser_is_empty(parser, cmdId, i); i++)
			{
				uint num = YunVaImInterface.yvpacket_get_nested_parser(parser);
				YunVaImInterface.parser_get_object(parser, 1, num, i);
				RecentConact recentConact = new RecentConact();
				recentConact.endId = YunVaImInterface.parser_get_integer(num, 1);
				recentConact.unread = YunVaImInterface.parser_get_integer(num, 2);
				YunvaLogPrint.YvInfoLog("ImFriendNearListNotify", string.Format("endId:{0},unread:{1}", recentConact.endId, recentConact.unread));
				uint num2 = YunVaImInterface.yvpacket_get_nested_parser(parser);
				YunVaImInterface.parser_get_object(num, 3, num2);
				recentConact.lastMsg = chatMessageNotify(num2);
				uint num3 = YunVaImInterface.yvpacket_get_nested_parser(parser);
				YunVaImInterface.parser_get_object(num, 4, num3);
				NearChatInfo nearChatInfo = new NearChatInfo();
				nearChatInfo.nickName = YunVaImInterface.IntPtrToString(YunVaImInterface.parser_get_string(num3, 1));
				nearChatInfo.userId = YunVaImInterface.parser_get_integer(num3, 2);
				nearChatInfo.iconUrl = YunVaImInterface.IntPtrToString(YunVaImInterface.parser_get_string(num3, 3));
				nearChatInfo.online = YunVaImInterface.parser_get_integer(num3, 4);
				nearChatInfo.userLevel = YunVaImInterface.IntPtrToString(YunVaImInterface.parser_get_string(num3, 5));
				nearChatInfo.vipLevel = YunVaImInterface.IntPtrToString(YunVaImInterface.parser_get_string(num3, 6));
				nearChatInfo.ext = YunVaImInterface.IntPtrToString(YunVaImInterface.parser_get_string(num3, 7));
				nearChatInfo.shieldMsg = YunVaImInterface.parser_get_integer(num3, 8);
				nearChatInfo.sex = YunVaImInterface.parser_get_integer(num3, 9);
				nearChatInfo.group = YunVaImInterface.IntPtrToString(YunVaImInterface.parser_get_string(num3, 10));
				nearChatInfo.remark = YunVaImInterface.IntPtrToString(YunVaImInterface.parser_get_string(num3, 11));
				nearChatInfo.times = YunVaImInterface.parser_get_integer(num3, 12);
				YunvaLogPrint.YvInfoLog("ImFriendNearListNotify", string.Format("nickName:{0},userId:{1},iconUrl:{2},onLine:{3},userLevel:{4},vipLevel:{5},ext:{6},shieldmsg:{7},sex:{8},group:{9},remark:{10},times:{11}", nearChatInfo.nickName, nearChatInfo.userId, nearChatInfo.iconUrl, nearChatInfo.online, nearChatInfo.userLevel, nearChatInfo.vipLevel, nearChatInfo.ext, nearChatInfo.shieldMsg, nearChatInfo.sex, nearChatInfo.group, nearChatInfo.remark, nearChatInfo.times));
				recentConact.userInfo = nearChatInfo;
				list.Add(recentConact);
			}
			return list;
		}

		private P2PChatMsg chatMessageNotify(uint parser)
		{
			P2PChatMsg p2PChatMsg = new P2PChatMsg();
			p2PChatMsg.userID = YunVaImInterface.parser_get_integer(parser, 1);
			p2PChatMsg.name = YunVaImInterface.IntPtrToString(YunVaImInterface.parser_get_string(parser, 2));
			p2PChatMsg.signature = YunVaImInterface.IntPtrToString(YunVaImInterface.parser_get_string(parser, 3));
			p2PChatMsg.headUrl = YunVaImInterface.IntPtrToString(YunVaImInterface.parser_get_string(parser, 4));
			p2PChatMsg.sendTime = YunVaImInterface.parser_get_integer(parser, 5);
			p2PChatMsg.type = YunVaImInterface.parser_get_integer(parser, 6);
			p2PChatMsg.data = YunVaImInterface.IntPtrToString(YunVaImInterface.parser_get_string(parser, 7));
			p2PChatMsg.imageUrl = YunVaImInterface.IntPtrToString(YunVaImInterface.parser_get_string(parser, 8));
			p2PChatMsg.audioTime = YunVaImInterface.parser_get_integer(parser, 9);
			p2PChatMsg.attach = YunVaImInterface.IntPtrToString(YunVaImInterface.parser_get_string(parser, 10));
			p2PChatMsg.ext1 = YunVaImInterface.IntPtrToString(YunVaImInterface.parser_get_string(parser, 11));
			YunvaLogPrint.YvInfoLog("ImFriendNearListNotify", string.Format("userID:{0},name:{1},signature:{2},headUrl:{3},sendTime:{4},type:{5},data:{6},imageUrl:{7},audioTime:{8},attach:{9},ext1{10}", p2PChatMsg.userID, p2PChatMsg.name, p2PChatMsg.signature, p2PChatMsg.headUrl, p2PChatMsg.sendTime, p2PChatMsg.type, p2PChatMsg.data, p2PChatMsg.imageUrl, p2PChatMsg.audioTime, p2PChatMsg.attach, p2PChatMsg.ext1));
			p2PChatMsg.cloudMsgID = YunVaImInterface.parser_get_integer(parser, 110);
			p2PChatMsg.cloudResource = YunVaImInterface.IntPtrToString(YunVaImInterface.parser_get_string(parser, 111));
			return p2PChatMsg;
		}
	}
}
