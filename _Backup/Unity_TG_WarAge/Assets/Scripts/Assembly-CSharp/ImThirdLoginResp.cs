using YunvaIM;

public class ImThirdLoginResp : YunvaMsgBase
{
	public int result;

	public string msg;

	public int userId;

	public string nickName;

	public string iconUrl;

	public string thirdUserId;

	public string thirdUseName;

	public string level;

	public string vip;

	public string ext;

	public int sex;

	public ImThirdLoginResp(object Parser)
	{
		uint parser = (uint)Parser;
		result = YunVaImInterface.parser_get_integer(parser, 1);
		msg = YunVaImInterface.IntPtrToString(YunVaImInterface.parser_get_string(parser, 2));
		userId = YunVaImInterface.parser_get_integer(parser, 3);
		nickName = YunVaImInterface.IntPtrToString(YunVaImInterface.parser_get_string(parser, 4));
		iconUrl = YunVaImInterface.IntPtrToString(YunVaImInterface.parser_get_string(parser, 5));
		thirdUserId = YunVaImInterface.IntPtrToString(YunVaImInterface.parser_get_string(parser, 6));
		thirdUseName = YunVaImInterface.IntPtrToString(YunVaImInterface.parser_get_string(parser, 7));
		level = YunVaImInterface.IntPtrToString(YunVaImInterface.parser_get_string(parser, 8));
		vip = YunVaImInterface.IntPtrToString(YunVaImInterface.parser_get_string(parser, 9));
		ext = YunVaImInterface.IntPtrToString(YunVaImInterface.parser_get_string(parser, 10));
		sex = YunVaImInterface.parser_get_integer(parser, 11);
		InvokeEventClass item = new InvokeEventClass(ProtocolEnum.IM_THIRD_LOGIN_RESP, this);
		YunVaImInterface.eventQueue.Enqueue(item);
		YunvaLogPrint.YvDebugLog("ImThirdLoginResp", string.Format("result:{0},msg:{1},userId:{2},nickName:{3},iconUrl:{4},thirdUserId:{5},thirdUseName:{6}", result, msg, userId, nickName, iconUrl, thirdUserId, thirdUseName));
	}

	public ImThirdLoginResp()
	{
	}
}
