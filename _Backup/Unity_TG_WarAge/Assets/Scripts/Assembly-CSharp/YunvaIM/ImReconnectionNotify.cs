namespace YunvaIM
{
	public class ImReconnectionNotify : YunvaMsgBase
	{
		public int userid;

		public ImReconnectionNotify(object Parser)
		{
			uint parser = (uint)Parser;
			userid = YunVaImInterface.parser_get_integer(parser, 1);
			YunVaImInterface.eventQueue.Enqueue(new InvokeEventClass(ProtocolEnum.IM_RECONNECTION_NOTIFY, this));
			YunvaLogPrint.YvDebugLog("ImReconnectionNotify", string.Format("userid:{0}", userid));
		}
	}
}
