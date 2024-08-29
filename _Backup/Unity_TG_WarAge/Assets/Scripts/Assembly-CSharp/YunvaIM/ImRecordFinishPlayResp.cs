namespace YunvaIM
{
	public class ImRecordFinishPlayResp : YunvaMsgBase
	{
		public uint result;

		public string describe;

		public string ext;

		public ImRecordFinishPlayResp(object Parser)
		{
			uint parser = (uint)Parser;
			result = YunVaImInterface.parser_get_uint32(parser, 1);
			describe = YunVaImInterface.IntPtrToString(YunVaImInterface.parser_get_string(parser, 2));
			ext = YunVaImInterface.IntPtrToString(YunVaImInterface.parser_get_string(parser, 3));
			YunVaImInterface.eventQueue.Enqueue(new InvokeEventClass(ProtocolEnum.IM_RECORD_FINISHPLAY_RESP, this));
			YunvaLogPrint.YvDebugLog("ImRecordFinishPlayResp", string.Format("result:{0},describe:{1},ext:{2}", result, describe, ext));
		}
	}
}
