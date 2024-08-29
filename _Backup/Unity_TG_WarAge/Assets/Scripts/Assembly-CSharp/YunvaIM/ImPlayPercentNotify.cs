namespace YunvaIM
{
	public class ImPlayPercentNotify : YunvaMsgBase
	{
		public int percent;

		public string ext;

		public ImPlayPercentNotify(object Parser)
		{
			uint parser = (uint)Parser;
			percent = YunVaImInterface.parser_get_integer(parser, 1);
			ext = YunVaImInterface.IntPtrToString(YunVaImInterface.parser_get_string(parser, 2));
			YunVaImInterface.eventQueue.Enqueue(new InvokeEventClass(ProtocolEnum.IM_RECORD_PLAY_PERCENT_NOTIFY, this));
			YunvaLogPrint.YvDebugLog("ImPlayPercentNotify", string.Format("percent:{0},ext:{1}", percent, ext));
		}
	}
}
