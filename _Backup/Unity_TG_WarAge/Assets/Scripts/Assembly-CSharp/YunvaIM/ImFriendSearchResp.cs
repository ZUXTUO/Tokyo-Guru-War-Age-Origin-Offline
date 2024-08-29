using System.Collections.Generic;

namespace YunvaIM
{
	public class ImFriendSearchResp : YunvaMsgBase
	{
		public int result;

		public string msg;

		public List<xSearchInfo> searchUserInfo;

		public ImFriendSearchResp(object Parser, ProtocolEnum protocol)
		{
			YunVaImInterface.eventQueue.Enqueue(new InvokeEventClass(protocol, SearchFriendInfo((uint)Parser)));
		}

		public ImFriendSearchResp()
		{
		}

		private ImFriendSearchResp SearchFriendInfo(uint parser)
		{
			ImFriendSearchResp imFriendSearchResp = new ImFriendSearchResp();
			List<xSearchInfo> list = new List<xSearchInfo>();
			imFriendSearchResp.result = YunVaImInterface.parser_get_integer(parser, 1);
			imFriendSearchResp.msg = YunVaImInterface.IntPtrToString(YunVaImInterface.parser_get_string(parser, 2));
			YunvaLogPrint.YvDebugLog("ImFriendSearchResp", string.Format("result:{0},msg:{1}", imFriendSearchResp.result, imFriendSearchResp.msg));
			for (int i = 0; !YunVaImInterface.parser_is_empty(parser, 3, i); i++)
			{
				uint num = YunVaImInterface.yvpacket_get_nested_parser(parser);
				YunVaImInterface.parser_get_object(parser, 3, num, i);
				xSearchInfo xSearchInfo = new xSearchInfo();
				xSearchInfo.yunvaId = YunVaImInterface.parser_get_integer(num, 1);
				xSearchInfo.userId = YunVaImInterface.IntPtrToString(YunVaImInterface.parser_get_string(num, 2));
				xSearchInfo.nickName = YunVaImInterface.IntPtrToString(YunVaImInterface.parser_get_string(num, 3));
				xSearchInfo.iconUrl = YunVaImInterface.IntPtrToString(YunVaImInterface.parser_get_string(num, 4));
				xSearchInfo.level = YunVaImInterface.IntPtrToString(YunVaImInterface.parser_get_string(num, 5));
				xSearchInfo.vip = YunVaImInterface.IntPtrToString(YunVaImInterface.parser_get_string(num, 6));
				xSearchInfo.ext = YunVaImInterface.IntPtrToString(YunVaImInterface.parser_get_string(num, 7));
				YunvaLogPrint.YvDebugLog("ImFriendSearchResp", string.Format("yunvaId:{0},userId:{1},nickName:{2},iconUrl:{3},level:{4},vip:{5},ext:{6}", xSearchInfo.yunvaId, xSearchInfo.userId, xSearchInfo.nickName, xSearchInfo.iconUrl, xSearchInfo.level, xSearchInfo.vip, xSearchInfo.ext));
				list.Add(xSearchInfo);
			}
			imFriendSearchResp.searchUserInfo = list;
			return imFriendSearchResp;
		}
	}
}
