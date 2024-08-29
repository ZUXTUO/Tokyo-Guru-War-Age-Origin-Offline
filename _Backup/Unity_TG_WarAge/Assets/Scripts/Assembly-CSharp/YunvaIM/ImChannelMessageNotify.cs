namespace YunvaIM
{
	public class ImChannelMessageNotify : YunvaMsgBase
	{
		public uint userId;

		public string messageBody;

		public string nickname;

		public string ext1;

		public string ext2;

		public int channel;

		public string wildcard;

		public uint messageType;

		public uint voiceDuration;

		public string attach;

		public uint shield;

		public ImChannelMessageNotify(object Parser)
		{
			uint parser = (uint)Parser;
			userId = YunVaImInterface.parser_get_uint32(parser, 1);
			messageBody = YunVaImInterface.IntPtrToString(YunVaImInterface.parser_get_string(parser, 2));
			nickname = YunVaImInterface.IntPtrToString(YunVaImInterface.parser_get_string(parser, 3));
			ext1 = YunVaImInterface.IntPtrToString(YunVaImInterface.parser_get_string(parser, 4));
			ext2 = YunVaImInterface.IntPtrToString(YunVaImInterface.parser_get_string(parser, 5));
			channel = YunVaImInterface.parser_get_uint8(parser, 6);
			wildcard = YunVaImInterface.IntPtrToString(YunVaImInterface.parser_get_string(parser, 7));
			messageType = YunVaImInterface.parser_get_uint32(parser, 8);
			voiceDuration = YunVaImInterface.parser_get_uint32(parser, 9);
			attach = YunVaImInterface.IntPtrToString(YunVaImInterface.parser_get_string(parser, 10), true);
			shield = YunVaImInterface.parser_get_uint32(parser, 11);
			YunvaLogPrint.YvDebugLog("ImChannelMessageNotify", string.Format("userId:{0},messageBody:{1},nickname:{2},ext1:{3},ext2:{4},channel:{5},wildcard:{6},messageType:{7},voiceDuration:{8},attach:{9},shield{10}", userId, messageBody, nickname, ext1, ext2, channel, wildcard, messageType, voiceDuration, attach, shield));
			YunVaImInterface.eventQueue.Enqueue(new InvokeEventClass(ProtocolEnum.IM_CHANNEL_MESSAGE_NOTIFY, this));
		}
	}
}
