namespace YunvaIM
{
	public class ImRecordVolumeNotify : YunvaMsgBase
	{
		public string v_ext;

		public int v_volume;

		public ImRecordVolumeNotify(object Parser)
		{
			uint parser = (uint)Parser;
			v_ext = YunVaImInterface.IntPtrToString(YunVaImInterface.parser_get_string(parser, 1));
			v_volume = YunVaImInterface.parser_get_integer(parser, 2);
			YunvaLogPrint.YvDebugLog("ImRecordVolumeNotify", string.Format("v_ext:{0},v_volume:{1}", v_ext, v_volume));
			YunVaImInterface.eventQueue.Enqueue(new InvokeEventClass(ProtocolEnum.IM_RECORD_VOLUME_NOTIFY, this));
		}
	}
}
