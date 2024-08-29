namespace YunvaIM
{
	public class ImCloudMsgNotify : YunvaMsgBase
	{
		public string source;

		public int id;

		public int beginid;

		public int endid;

		public int time;

		public P2PChatMsg packet = new P2PChatMsg();

		public int unread;

		public int cloudId;

		public string cloudResource;

		public ImCloudMsgNotify()
		{
		}

		public ImCloudMsgNotify(object Parser)
		{
			uint parser = (uint)Parser;
			if (YunVaImInterface.IntPtrToString(YunVaImInterface.parser_get_string(parser, 1)) == "P2P")
			{
				source = YunVaImInterface.IntPtrToString(YunVaImInterface.parser_get_string(parser, 1));
				id = YunVaImInterface.parser_get_integer(parser, 2);
				beginid = YunVaImInterface.parser_get_integer(parser, 3);
				endid = YunVaImInterface.parser_get_integer(parser, 4);
				time = YunVaImInterface.parser_get_integer(parser, 5);
				uint num = YunVaImInterface.yvpacket_get_nested_parser(parser);
				YunVaImInterface.parser_get_object(parser, 6, num);
				packet = chatMessageNotify(num);
				unread = YunVaImInterface.parser_get_integer(parser, 7);
				cloudId = YunVaImInterface.parser_get_integer(parser, 110);
				cloudResource = YunVaImInterface.IntPtrToString(YunVaImInterface.parser_get_string(parser, 111));
				YunvaLogPrint.YvInfoLog("ImCloudMsgNotify", string.Format("source:{0},id:{1},beginid:{2},endid:{3},time:{4},unread:{5},cloudId:{6},cloudResource:{7}", source, id, beginid, endid, time, unread, cloudId, cloudResource));
				YunVaImInterface.eventQueue.Enqueue(new InvokeEventClass(ProtocolEnum.IM_CLOUDMSG_NOTIFY, this));
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
			YunvaLogPrint.YvInfoLog("ImCloudMsgNotify", string.Format("userID:{0},name:{1},signature:{2},headUrl:{3},sendTime:{4},type:{5},data:{6},imageUrl:{7},audioTime:{8},attach:{9},ext1:{10}", p2PChatMsg.userID, p2PChatMsg.name, p2PChatMsg.signature, p2PChatMsg.headUrl, p2PChatMsg.sendTime, p2PChatMsg.type, p2PChatMsg.data, p2PChatMsg.imageUrl, p2PChatMsg.audioTime, p2PChatMsg.attach, p2PChatMsg.ext1));
			p2PChatMsg.cloudMsgID = YunVaImInterface.parser_get_integer(parser, 110);
			p2PChatMsg.cloudResource = YunVaImInterface.IntPtrToString(YunVaImInterface.parser_get_string(parser, 111));
			return p2PChatMsg;
		}
	}
}
