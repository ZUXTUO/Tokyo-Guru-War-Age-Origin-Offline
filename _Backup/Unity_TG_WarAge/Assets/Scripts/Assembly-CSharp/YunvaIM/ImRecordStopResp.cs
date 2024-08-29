namespace YunvaIM
{
	public class ImRecordStopResp : YunvaMsgBase
	{
		public uint time;

		public string strfilepath;

		public string ext;

		public int result;

		public string msg;

		public ImRecordStopResp(object Parser)
		{
			uint parser = (uint)Parser;
			time = YunVaImInterface.parser_get_uint32(parser, 1);
			strfilepath = YunVaImInterface.IntPtrToString(YunVaImInterface.parser_get_string(parser, 2));
			ext = YunVaImInterface.IntPtrToString(YunVaImInterface.parser_get_string(parser, 3));
			result = YunVaImInterface.parser_get_integer(parser, 4);
			msg = YunVaImInterface.IntPtrToString(YunVaImInterface.parser_get_string(parser, 5));
			YunVaImInterface.eventQueue.Enqueue(new InvokeEventClass(ProtocolEnum.IM_RECORD_STOP_RESP, this));
			YunvaLogPrint.YvDebugLog("ImRecordStopResp", string.Format("time:{0},strfilepath:{1},ext:{2},result:{3},msg:{4}", time, strfilepath, ext, result, msg));
		}
	}
}
