using System.Collections.Generic;

namespace YunvaIM
{
	public class ImChannelHistoryMsgResp : YunvaMsgBase
	{
		public List<HistoryMsgInfo> channelHisList;

		public ImChannelHistoryMsgResp(object Parser)
		{
			uint parser = (uint)Parser;
			channelHisList = new List<HistoryMsgInfo>();
			for (int i = 0; !YunVaImInterface.parser_is_empty(parser, 1, i); i++)
			{
				uint num = YunVaImInterface.yvpacket_get_nested_parser(parser);
				YunVaImInterface.parser_get_object(parser, 1, num, i);
				HistoryMsgInfo channelMessageNotify = GetChannelMessageNotify(num);
				channelHisList.Add(channelMessageNotify);
			}
			YunVaImInterface.eventQueue.Enqueue(new InvokeEventClass(ProtocolEnum.IM_CHANNEL_HISTORY_MSG_RESP, this));
		}

		public static HistoryMsgInfo GetChannelMessageNotify(uint parser)
		{
			HistoryMsgInfo historyMsgInfo = new HistoryMsgInfo();
			historyMsgInfo.index = YunVaImInterface.parser_get_uint32(parser, 1);
			historyMsgInfo.ctime = YunVaImInterface.IntPtrToString(YunVaImInterface.parser_get_string(parser, 2));
			historyMsgInfo.userId = YunVaImInterface.parser_get_uint32(parser, 3);
			historyMsgInfo.messageBody = YunVaImInterface.IntPtrToString(YunVaImInterface.parser_get_string(parser, 4));
			historyMsgInfo.nickName = YunVaImInterface.IntPtrToString(YunVaImInterface.parser_get_string(parser, 5));
			historyMsgInfo.ext1 = YunVaImInterface.IntPtrToString(YunVaImInterface.parser_get_string(parser, 6));
			historyMsgInfo.ext2 = YunVaImInterface.IntPtrToString(YunVaImInterface.parser_get_string(parser, 7));
			historyMsgInfo.channel = YunVaImInterface.parser_get_uint8(parser, 8);
			historyMsgInfo.wildCard = YunVaImInterface.IntPtrToString(YunVaImInterface.parser_get_string(parser, 9));
			historyMsgInfo.messageType = YunVaImInterface.parser_get_uint32(parser, 10);
			historyMsgInfo.voiceDuration = YunVaImInterface.parser_get_uint32(parser, 11);
			historyMsgInfo.attach = YunVaImInterface.IntPtrToString(YunVaImInterface.parser_get_string(parser, 12), true);
			YunvaLogPrint.YvDebugLog("ImChannelHistoryMsgResp", string.Format("index:{0},ctime:{1},userId:{2},messageBody:{3},nickName:{4},ext1:{5},ext2:{6},channel:{7},wildCard:{8},messageType:{9},voiceDuration:{10},attach:{11}", historyMsgInfo.index, historyMsgInfo.ctime, historyMsgInfo.userId, historyMsgInfo.messageBody, historyMsgInfo.nickName, historyMsgInfo.ext1, historyMsgInfo.ext2, historyMsgInfo.channel, historyMsgInfo.wildCard, historyMsgInfo.messageType, historyMsgInfo.voiceDuration, historyMsgInfo.attach));
			return historyMsgInfo;
		}
	}
}
