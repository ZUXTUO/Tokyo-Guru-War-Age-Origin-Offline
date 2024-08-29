namespace YunvaIM
{
	public class ImGetThirdBindInfoResp : YunvaMsgBase
	{
		public int result;

		public string msg;

		public int yunvaId;

		public string nickName;

		public string iconUrl;

		public string level;

		public string vip;

		public string ext;

		public int sex;

		public string uid;

		public ImGetThirdBindInfoResp(object Parser)
		{
			uint parser = (uint)Parser;
			result = YunVaImInterface.parser_get_integer(parser, 1);
			msg = YunVaImInterface.IntPtrToString(YunVaImInterface.parser_get_string(parser, 2));
			yunvaId = YunVaImInterface.parser_get_integer(parser, 3);
			nickName = YunVaImInterface.IntPtrToString(YunVaImInterface.parser_get_string(parser, 4));
			iconUrl = YunVaImInterface.IntPtrToString(YunVaImInterface.parser_get_string(parser, 5));
			level = YunVaImInterface.IntPtrToString(YunVaImInterface.parser_get_string(parser, 6));
			vip = YunVaImInterface.IntPtrToString(YunVaImInterface.parser_get_string(parser, 7));
			ext = YunVaImInterface.IntPtrToString(YunVaImInterface.parser_get_string(parser, 8));
			sex = YunVaImInterface.parser_get_integer(parser, 9);
			uid = YunVaImInterface.IntPtrToString(YunVaImInterface.parser_get_string(parser, 10));
			YunVaImInterface.eventQueue.Enqueue(new InvokeEventClass(ProtocolEnum.IM_GET_THIRDBINDINFO_RESP, this));
			YunvaLogPrint.YvDebugLog("ImGetThirdBindInfoResp", string.Format("result:{0},msg:{1},yunvaId:{2},nickName:{3},iconUrl:{4},level:{5},vip:{6},ext:{7},sex:{8},uid:{9}", result, msg, yunvaId, nickName, iconUrl, level, vip, ext, sex, uid));
		}
	}
}
