namespace YunvaIM
{
	public class ImFriendOperResp : YunvaMsgBase
	{
		public int userId;

		public int operId;

		public int act;

		public int oper_state;

		public ImFriendOperResp(object Parser)
		{
			uint parser = (uint)Parser;
			userId = YunVaImInterface.parser_get_integer(parser, 1);
			operId = YunVaImInterface.parser_get_integer(parser, 2);
			act = YunVaImInterface.parser_get_integer(parser, 3);
			oper_state = YunVaImInterface.parser_get_integer(parser, 4);
			YunvaLogPrint.YvDebugLog("ImFriendOperResp", string.Format("userId:{0},operId:{1},act:{2},oper_state:{3}", userId, operId, act, oper_state));
			YunVaImInterface.eventQueue.Enqueue(new InvokeEventClass(ProtocolEnum.IM_FRIEND_OPER_RESP, this));
		}
	}
}
