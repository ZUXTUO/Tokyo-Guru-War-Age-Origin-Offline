namespace YunvaIM
{
	public class ImUserGetInfoResp : YunvaMsgBase
	{
		public int userId;

		public int sex;

		public string nickName;

		public string iconUrl;

		public string userLevel;

		public string vipLevel;

		public string ext;

		public int result;

		public string msg;

		public string uid;

		public ImUserGetInfoResp(object Parser)
		{
			uint parser = (uint)Parser;
			userId = YunVaImInterface.parser_get_integer(parser, 1);
			sex = YunVaImInterface.parser_get_integer(parser, 2);
			nickName = YunVaImInterface.IntPtrToString(YunVaImInterface.parser_get_string(parser, 3));
			iconUrl = YunVaImInterface.IntPtrToString(YunVaImInterface.parser_get_string(parser, 4));
			userLevel = YunVaImInterface.IntPtrToString(YunVaImInterface.parser_get_string(parser, 5));
			vipLevel = YunVaImInterface.IntPtrToString(YunVaImInterface.parser_get_string(parser, 6));
			ext = YunVaImInterface.IntPtrToString(YunVaImInterface.parser_get_string(parser, 7));
			result = YunVaImInterface.parser_get_integer(parser, 8);
			msg = YunVaImInterface.IntPtrToString(YunVaImInterface.parser_get_string(parser, 9));
			uid = YunVaImInterface.IntPtrToString(YunVaImInterface.parser_get_string(parser, 10));
			YunvaLogPrint.YvDebugLog("ImUserGetInfoResp", string.Format("userId:{0},sex:{1},nickName:{2},iconUrl:{3},userLevel:{4},vipLevel:{5},ext:{6},result:{7},msg:{8},uid:{9}", userId, sex, nickName, iconUrl, userLevel, vipLevel, ext, result, msg, uid));
			YunVaImInterface.eventQueue.Enqueue(new InvokeEventClass(ProtocolEnum.IM_USER_GETINFO_RESP, this));
		}
	}
}
