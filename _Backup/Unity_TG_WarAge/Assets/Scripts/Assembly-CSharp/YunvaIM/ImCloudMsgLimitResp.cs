namespace YunvaIM
{
	public class ImCloudMsgLimitResp : YunvaMsgBase
	{
		public int results;

		public string msgs;

		public string session;

		public int id;

		public int index;

		public int limit;

		public ImCloudMsgLimitResp(object Parser)
		{
			uint parser = (uint)Parser;
			results = YunVaImInterface.parser_get_integer(parser, 1);
			msgs = YunVaImInterface.IntPtrToString(YunVaImInterface.parser_get_string(parser, 2));
			session = YunVaImInterface.IntPtrToString(YunVaImInterface.parser_get_string(parser, 3));
			id = YunVaImInterface.parser_get_integer(parser, 4);
			index = YunVaImInterface.parser_get_integer(parser, 5);
			limit = YunVaImInterface.parser_get_integer(parser, 6);
			YunvaLogPrint.YvDebugLog("ImCloudMsgLimitResp", string.Format("results:{0},msgs:{1},session:{2},id:{3},index:{4},limit:{5}", results, msgs, session, id, index, limit));
			YunVaImInterface.eventQueue.Enqueue(new InvokeEventClass(ProtocolEnum.IM_CLOUDMSG_LIMIT_RESP, this));
		}
	}
}
