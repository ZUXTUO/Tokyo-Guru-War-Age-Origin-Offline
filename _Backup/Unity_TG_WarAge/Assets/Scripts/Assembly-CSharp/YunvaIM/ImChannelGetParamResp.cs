using UnityEngine;

namespace YunvaIM
{
	public class ImChannelGetParamResp : YunvaMsgBase
	{
		public int result;

		public string msg;

		public string announcement;

		public ImChannelGetParamResp(object Parser)
		{
			Debug.Log("公告返回");
			uint parser = (uint)Parser;
			result = YunVaImInterface.parser_get_integer(parser, 1);
			msg = YunVaImInterface.IntPtrToString(YunVaImInterface.parser_get_string(parser, 2));
			announcement = YunVaImInterface.IntPtrToString(YunVaImInterface.parser_get_string(parser, 3));
			YunVaImInterface.eventQueue.Enqueue(new InvokeEventClass(ProtocolEnum.IM_CHANNEL_GET_PARAM_RESP, this));
			YunvaLogPrint.YvDebugLog("ImChannelGetParamResp", string.Format("result:{0},msg:{1},announcement:{2}", result, msg, announcement));
		}
	}
}
