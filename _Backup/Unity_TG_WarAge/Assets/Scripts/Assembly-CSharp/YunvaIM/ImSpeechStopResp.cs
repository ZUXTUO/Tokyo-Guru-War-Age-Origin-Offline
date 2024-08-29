namespace YunvaIM
{
	public class ImSpeechStopResp : YunvaMsgBase
	{
		public int result;

		public string msg;

		public string text;

		public string ext;

		public string url;

		public ImSpeechStopResp(object Parser)
		{
			uint parser = (uint)Parser;
			result = YunVaImInterface.parser_get_integer(parser, 1);
			msg = YunVaImInterface.IntPtrToString(YunVaImInterface.parser_get_string(parser, 2));
			text = YunVaImInterface.IntPtrToString(YunVaImInterface.parser_get_string(parser, 3));
			ext = YunVaImInterface.IntPtrToString(YunVaImInterface.parser_get_string(parser, 4));
			url = YunVaImInterface.IntPtrToString(YunVaImInterface.parser_get_string(parser, 5));
			YunVaImInterface.eventQueue.Enqueue(new InvokeEventClass(ProtocolEnum.IM_SPEECH_STOP_RESP, this));
			YunvaLogPrint.YvDebugLog("ImSpeechStopResp", string.Format("result:{0},msg:{1},text:{2},ext:{3},url:{4}", result, msg, text, ext, url));
		}
	}
}
