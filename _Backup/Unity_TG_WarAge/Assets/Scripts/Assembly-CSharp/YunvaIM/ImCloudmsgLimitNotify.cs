using System.Collections.Generic;

namespace YunvaIM
{
	public class ImCloudmsgLimitNotify : YunvaMsgBase
	{
		public string source;

		public uint p2pId;

		public uint count;

		public uint indexId;

		public uint ptime;

		public P2PChatMsg packet;

		public List<P2PChatMsg> pacektList;

		public ImCloudmsgLimitNotify(object Parser)
		{
			uint parser = (uint)Parser;
			pacektList = new List<P2PChatMsg>();
			source = YunVaImInterface.IntPtrToString(YunVaImInterface.parser_get_string(parser, 1));
			p2pId = YunVaImInterface.parser_get_uint32(parser, 2);
			count = YunVaImInterface.parser_get_uint32(parser, 3);
			indexId = YunVaImInterface.parser_get_uint32(parser, 4);
			ptime = YunVaImInterface.parser_get_uint32(parser, 5);
			YunvaLogPrint.YvDebugLog("ImCloudmsgLimitNotify", string.Format("source:{0},p2pId:{1},count:{2},indexId:{3},ptime:{4}", source, p2pId, count, indexId, ptime));
			if (source == "P2P" && count != 0)
			{
				uint obj = YunVaImInterface.yvpacket_get_nested_parser(parser);
				YunVaImInterface.parser_get_object(parser, 6, obj);
				for (int i = 0; !YunVaImInterface.parser_is_empty(parser, 6, i); i++)
				{
					uint num = YunVaImInterface.yvpacket_get_nested_parser(parser);
					YunVaImInterface.parser_get_object(parser, 6, num, i);
					pacektList.Add(chatMessageNotify(num));
				}
				YunVaImInterface.eventQueue.Enqueue(new InvokeEventClass(ProtocolEnum.IM_CLOUDMSG_LIMIT_NOTIFY, this));
			}
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
			p2PChatMsg.index = YunVaImInterface.parser_get_integer(parser, 12);
			YunvaLogPrint.YvDebugLog("ImCloudmsgLimitNotify", string.Format("userID:{0},name:{1},signature:{2},headUrl:{3},sendTime:{4},type:{5},data:{6},imageUrl:{7},audioTime:{8},attach:{9},ext1:{10},index:{11}", p2PChatMsg.userID, p2PChatMsg.name, p2PChatMsg.signature, p2PChatMsg.headUrl, p2PChatMsg.sendTime, p2PChatMsg.type, p2PChatMsg.data, p2PChatMsg.imageUrl, p2PChatMsg.audioTime, p2PChatMsg.attach, p2PChatMsg.ext1, p2PChatMsg.index));
			p2PChatMsg.cloudMsgID = YunVaImInterface.parser_get_integer(parser, 110);
			p2PChatMsg.cloudResource = YunVaImInterface.IntPtrToString(YunVaImInterface.parser_get_string(parser, 111));
			return p2PChatMsg;
		}
	}
}
