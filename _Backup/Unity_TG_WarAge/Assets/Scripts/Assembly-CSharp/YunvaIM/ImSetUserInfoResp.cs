namespace YunvaIM
{
	public class ImSetUserInfoResp : YunvaMsgBase
	{
		public int result;

		public string msg;

		public ImSetUserInfoResp(object Parser)
		{
			uint parser = (uint)Parser;
			result = YunVaImInterface.parser_get_integer(parser, 1);
			msg = YunVaImInterface.IntPtrToString(YunVaImInterface.parser_get_string(parser, 2));
			YunVaImInterface.eventQueue.Enqueue(new InvokeEventClass(ProtocolEnum.IM_SETUSERINFO_RESP, this));
			YunvaLogPrint.YvDebugLog("ImSetUserInfoResp", string.Format("result:{0},msg:{1}", result, msg));
		}
	}
}
