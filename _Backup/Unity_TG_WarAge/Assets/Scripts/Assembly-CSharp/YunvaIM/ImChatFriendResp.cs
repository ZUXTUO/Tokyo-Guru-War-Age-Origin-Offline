namespace YunvaIM
{
	public class ImChatFriendResp : YunvaMsgBase
	{
		public int result;

		public string msg;

		public int type;

		public int userId;

		public string flag;

		public string indexId;

		public string text;

		public string audiourl;

		public int audiotime;

		public string imageurl1;

		public string imageurl2;

		public string ext1;

		public ImChatFriendResp(object Parser)
		{
			uint parser = (uint)Parser;
			result = YunVaImInterface.parser_get_integer(parser, 1);
			msg = YunVaImInterface.IntPtrToString(YunVaImInterface.parser_get_string(parser, 2));
			type = YunVaImInterface.parser_get_integer(parser, 3);
			userId = YunVaImInterface.parser_get_integer(parser, 4);
			flag = YunVaImInterface.IntPtrToString(YunVaImInterface.parser_get_string(parser, 5));
			indexId = YunVaImInterface.IntPtrToString(YunVaImInterface.parser_get_string(parser, 6));
			text = YunVaImInterface.IntPtrToString(YunVaImInterface.parser_get_string(parser, 7));
			audiourl = YunVaImInterface.IntPtrToString(YunVaImInterface.parser_get_string(parser, 8));
			audiotime = YunVaImInterface.parser_get_integer(parser, 9);
			imageurl1 = YunVaImInterface.IntPtrToString(YunVaImInterface.parser_get_string(parser, 10));
			imageurl2 = YunVaImInterface.IntPtrToString(YunVaImInterface.parser_get_string(parser, 11));
			ext1 = YunVaImInterface.IntPtrToString(YunVaImInterface.parser_get_string(parser, 13));
			YunvaLogPrint.YvDebugLog("ImChatFriendResp", string.Format("result:{0},msg:{1},type:{2},userId:{3},flag:{4},indexId:{5},text:{6},audiourl:{7},audiotime:{8},imageurl1:{9},imageurl2{10},ext1:{11}", result, msg, type, userId, flag, indexId, text, audiourl, audiotime, imageurl1, imageurl2, ext1));
			YunVaImInterface.eventQueue.Enqueue(new InvokeEventClass(ProtocolEnum.IM_CHAT_FRIEND_RESP, this));
		}
	}
}
