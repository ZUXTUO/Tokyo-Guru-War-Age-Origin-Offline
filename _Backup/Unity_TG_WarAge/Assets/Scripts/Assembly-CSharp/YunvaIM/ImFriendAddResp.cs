namespace YunvaIM
{
	public class ImFriendAddResp : YunvaMsgBase
	{
		public int affirm;

		public int userId;

		public string name;

		public string iconUrl;

		public string greet;

		public ImFriendAddResp(object Parser)
		{
			uint parser = (uint)Parser;
			affirm = YunVaImInterface.parser_get_integer(parser, 1);
			userId = YunVaImInterface.parser_get_integer(parser, 2);
			name = YunVaImInterface.IntPtrToString(YunVaImInterface.parser_get_string(parser, 3));
			iconUrl = YunVaImInterface.IntPtrToString(YunVaImInterface.parser_get_string(parser, 4));
			greet = YunVaImInterface.IntPtrToString(YunVaImInterface.parser_get_string(parser, 5));
			YunvaLogPrint.YvDebugLog("ImFriendAddResp", string.Format("affirm:{0},userId:{1},name:{2},iconUrl:{3},greet:{4}", affirm, userId, name, iconUrl, greet));
			YunVaImInterface.eventQueue.Enqueue(new InvokeEventClass(ProtocolEnum.IM_FRIEND_ADD_RESP, this));
		}
	}
}
