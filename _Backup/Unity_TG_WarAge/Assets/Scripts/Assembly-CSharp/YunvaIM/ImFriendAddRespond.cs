namespace YunvaIM
{
	public class ImFriendAddRespond : YunvaMsgBase
	{
		public int result;

		public string msg;

		public int userid;

		public ImFriendAddRespond(object Parser)
		{
			uint parser = (uint)Parser;
			result = YunVaImInterface.parser_get_integer(parser, 1);
			msg = YunVaImInterface.IntPtrToString(YunVaImInterface.parser_get_string(parser, 2));
			userid = YunVaImInterface.parser_get_integer(parser, 3);
			YunVaImInterface.eventQueue.Enqueue(new InvokeEventClass(ProtocolEnum.IM_FRIEND_ADD_RESPOND, this));
			YunvaLogPrint.YvDebugLog("ImFriendAddRespond", string.Format("result:{0},msg:{1},userid:{2}", result, msg, userid));
		}
	}
}
