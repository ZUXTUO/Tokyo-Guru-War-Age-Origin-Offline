namespace YunvaIM
{
	public class ImGetLocationResp : YunvaMsgBase
	{
		public int result;

		public string msg;

		public int range;

		public string city;

		public string province;

		public string district;

		public string detail;

		public string longitude;

		public string latitude;

		public ImGetLocationResp(object Parser)
		{
			uint parser = (uint)Parser;
			result = YunVaImInterface.parser_get_integer(parser, 1);
			msg = YunVaImInterface.IntPtrToString(YunVaImInterface.parser_get_string(parser, 2));
			city = YunVaImInterface.IntPtrToString(YunVaImInterface.parser_get_string(parser, 3));
			province = YunVaImInterface.IntPtrToString(YunVaImInterface.parser_get_string(parser, 4));
			district = YunVaImInterface.IntPtrToString(YunVaImInterface.parser_get_string(parser, 5));
			detail = YunVaImInterface.IntPtrToString(YunVaImInterface.parser_get_string(parser, 6));
			longitude = YunVaImInterface.IntPtrToString(YunVaImInterface.parser_get_string(parser, 7));
			latitude = YunVaImInterface.IntPtrToString(YunVaImInterface.parser_get_string(parser, 8));
			YunvaLogPrint.YvDebugLog("ImGetLocationResp", string.Format("result:{0},msg:{1},city:{2},province:{3},district:{4},detail:{5},longitude:{6},latitude:{7}", result, msg, city, province, district, detail, longitude, latitude));
			YunVaImInterface.eventQueue.Enqueue(new InvokeEventClass(ProtocolEnum.IM_GET_LOCATION_RESP, this));
		}
	}
}
