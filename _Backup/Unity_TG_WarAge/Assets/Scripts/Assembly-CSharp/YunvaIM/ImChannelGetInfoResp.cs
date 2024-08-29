using System.Collections.Generic;

namespace YunvaIM
{
	public class ImChannelGetInfoResp : YunvaMsgBase
	{
		public List<string> Game_channel;

		public ImChannelGetInfoResp(object Parser)
		{
			uint parser = (uint)Parser;
			for (int i = 0; !YunVaImInterface.parser_is_empty(parser, 1, i); i++)
			{
				uint num = YunVaImInterface.yvpacket_get_nested_parser(parser);
				YunVaImInterface.parser_get_object(parser, 1, num, i);
				Game_channel.Add(YunVaImInterface.IntPtrToString(YunVaImInterface.parser_get_string(num, 1)));
				YunvaLogPrint.YvDebugLog("ImChannelGetInfoResp", string.Format("Game_channel:{0}", Game_channel[i]));
			}
			YunVaImInterface.eventQueue.Enqueue(new InvokeEventClass(ProtocolEnum.IM_CHANNEL_GETINFO_RESP, this));
		}
	}
}
