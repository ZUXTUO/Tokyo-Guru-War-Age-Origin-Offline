namespace YunvaIM
{
	public class ImChatFriendNotify : YunvaMsgBase
	{
		public P2PChatMsg chatMsg;

		private int cloudID;

		private string source;

		public ImChatFriendNotify(object Parser)
		{
			uint parser = (uint)Parser;
			chatMsg = new P2PChatMsg();
			chatMsg = chatMessageNotify(parser);
			cloudID = YunVaImInterface.parser_get_integer(parser, 110);
			source = YunVaImInterface.IntPtrToString(YunVaImInterface.parser_get_string(parser, 111));
			YunVaImInterface.eventQueue.Enqueue(new InvokeEventClass(ProtocolEnum.IM_CHAT_FRIEND_NOTIFY, this));
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
			p2PChatMsg.cloudMsgID = YunVaImInterface.parser_get_integer(parser, 110);
			p2PChatMsg.cloudResource = YunVaImInterface.IntPtrToString(YunVaImInterface.parser_get_string(parser, 111));
			YunvaLogPrint.YvDebugLog("ImChatFriendNotify", string.Format("userID:{0},name:{1},signature:{2},headUrl:{3},sendTime:{4},type:{5},data:{6},imageUrl:{7},audioTime:{8},attach:{9},ext1{10}", p2PChatMsg.userID, p2PChatMsg.name, p2PChatMsg.signature, p2PChatMsg.headUrl, p2PChatMsg.sendTime, p2PChatMsg.type, p2PChatMsg.data, p2PChatMsg.imageUrl, p2PChatMsg.audioTime, p2PChatMsg.attach, p2PChatMsg.ext1));
			return p2PChatMsg;
		}
	}
}
