namespace YunvaIM
{
	public class ImUploadFileResp : YunvaMsgBase
	{
		public int result;

		public string msg;

		public string fileid;

		public string fileurl;

		public int percent;

		public ImUploadFileResp(object Parser)
		{
			uint parser = (uint)Parser;
			result = YunVaImInterface.parser_get_integer(parser, 1);
			msg = YunVaImInterface.IntPtrToString(YunVaImInterface.parser_get_string(parser, 2));
			fileid = YunVaImInterface.IntPtrToString(YunVaImInterface.parser_get_string(parser, 3));
			fileurl = YunVaImInterface.IntPtrToString(YunVaImInterface.parser_get_string(parser, 4));
			percent = YunVaImInterface.parser_get_integer(parser, 5);
			if ((result == 0 && percent == 100) || result != 0)
			{
				YunVaImInterface.eventQueue.Enqueue(new InvokeEventClass(ProtocolEnum.IM_UPLOAD_FILE_RESP, this));
				YunvaLogPrint.YvDebugLog("ImUploadFileResp", string.Format("result:{0},msg:{1},fileid:{2},fileurl:{3},percent:{4}", result, msg, fileid, fileurl, percent));
			}
		}
	}
}
