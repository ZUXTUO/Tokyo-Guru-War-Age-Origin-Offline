using System.Collections.Generic;

namespace YunvaIM
{
	public class ImLBSGetSpportLangResp : YunvaMsgBase
	{
		public int result;

		public string msg;

		public List<xLanguage> LanguageList;

		public ImLBSGetSpportLangResp(object Parser)
		{
			uint parser = (uint)Parser;
			LanguageList = new List<xLanguage>();
			result = YunVaImInterface.parser_get_integer(parser, 1);
			msg = YunVaImInterface.IntPtrToString(YunVaImInterface.parser_get_string(parser, 2));
			YunvaLogPrint.YvDebugLog("ImLBSGetSpportLangResp", string.Format("result:{0},msg:{1}", result, msg));
			for (int i = 0; !YunVaImInterface.parser_is_empty(parser, 3, i); i++)
			{
				uint num = YunVaImInterface.yvpacket_get_nested_parser(parser);
				YunVaImInterface.parser_get_object(parser, 3, num, i);
				xLanguage xLanguage2 = new xLanguage
				{
					lang_code = YunVaImInterface.IntPtrToString(YunVaImInterface.parser_get_string(num, 1)),
					lang_name = YunVaImInterface.IntPtrToString(YunVaImInterface.parser_get_string(num, 2))
				};
				LanguageList.Add(xLanguage2);
				YunvaLogPrint.YvDebugLog("ImLBSGetSpportLangResp", string.Format("lang_code:{0},lang_name:{1}", xLanguage2.lang_code, xLanguage2.lang_name));
			}
			YunVaImInterface.eventQueue.Enqueue(new InvokeEventClass(ProtocolEnum.IM_LBS_GET_SUPPORT_LANG_RESP, this));
		}
	}
}
