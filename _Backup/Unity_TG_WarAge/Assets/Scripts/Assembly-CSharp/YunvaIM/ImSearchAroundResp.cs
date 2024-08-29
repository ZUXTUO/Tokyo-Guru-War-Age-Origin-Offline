using System.Collections.Generic;

namespace YunvaIM
{
	public class ImSearchAroundResp : YunvaMsgBase
	{
		public int result;

		public string msg;

		public List<xAroundUser> aroundUserList;

		public ImSearchAroundResp(object Parser)
		{
			uint parser = (uint)Parser;
			aroundUserList = new List<xAroundUser>();
			result = YunVaImInterface.parser_get_integer(parser, 1);
			msg = YunVaImInterface.IntPtrToString(YunVaImInterface.parser_get_string(parser, 2));
			YunvaLogPrint.YvDebugLog("ImSearchAroundResp", string.Format("result:{0},msg:{1}", result, msg));
			for (int i = 0; !YunVaImInterface.parser_is_empty(parser, 3, i); i++)
			{
				uint num = YunVaImInterface.yvpacket_get_nested_parser(parser);
				YunVaImInterface.parser_get_object(parser, 3, num, i);
				xAroundUser xAroundUser2 = new xAroundUser
				{
					yunvaId = YunVaImInterface.parser_get_integer(num, 1),
					nickName = YunVaImInterface.IntPtrToString(YunVaImInterface.parser_get_string(num, 2)),
					sex = YunVaImInterface.parser_get_integer(num, 3),
					city = YunVaImInterface.IntPtrToString(YunVaImInterface.parser_get_string(num, 4)),
					headicon = YunVaImInterface.IntPtrToString(YunVaImInterface.parser_get_string(num, 5)),
					distance = YunVaImInterface.parser_get_integer(num, 6),
					lately = YunVaImInterface.IntPtrToString(YunVaImInterface.parser_get_string(num, 7)),
					longitude = YunVaImInterface.IntPtrToString(YunVaImInterface.parser_get_string(num, 8)),
					latitude = YunVaImInterface.IntPtrToString(YunVaImInterface.parser_get_string(num, 9)),
					ext = YunVaImInterface.IntPtrToString(YunVaImInterface.parser_get_string(num, 10))
				};
				YunvaLogPrint.YvDebugLog("ImSearchAroundResp", string.Format("yunvaId:{0},nickName:{1},sex:{2},city:{3},headicon:{4},distance:{5},lately:{6},longitude:{7},latitude:{8},ext:{9}", xAroundUser2.yunvaId, xAroundUser2.nickName, xAroundUser2.sex, xAroundUser2.city, xAroundUser2.headicon, xAroundUser2.distance, xAroundUser2.lately, xAroundUser2.longitude, xAroundUser2.latitude, xAroundUser2.ext));
				aroundUserList.Add(xAroundUser2);
			}
			YunVaImInterface.eventQueue.Enqueue(new InvokeEventClass(ProtocolEnum.IM_SEARCH_AROUND_RESP, this));
		}
	}
}
