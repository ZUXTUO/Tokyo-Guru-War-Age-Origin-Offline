namespace YunvaIM
{
	public class ImDownLoadFileResp : YunvaMsgBase
	{
		public int result;

		public string msg;

		public string filename;

		public string fileid;

		public int percent;

		public ImDownLoadFileResp(object Parser)
		{
			uint parser = (uint)Parser;
			result = YunVaImInterface.parser_get_integer(parser, 1);
			msg = YunVaImInterface.IntPtrToString(YunVaImInterface.parser_get_string(parser, 2));
			filename = YunVaImInterface.IntPtrToString(YunVaImInterface.parser_get_string(parser, 3));
			fileid = YunVaImInterface.IntPtrToString(YunVaImInterface.parser_get_string(parser, 4));
			percent = YunVaImInterface.parser_get_integer(parser, 5);
			if ((result == 0 && percent == 100) || result != 0)
			{
				YunVaImInterface.eventQueue.Enqueue(new InvokeEventClass(ProtocolEnum.IM_DOWNLOAD_FILE_RESP, this));
				YunvaLogPrint.YvDebugLog("ImDownLoadFileResp", string.Format("result:{0},msg:{1},filename:{2},fileid:{3},percent:{4}", result, msg, filename, fileid, percent));
			}
		}
	}
}
