--
-- Created by IntelliJ IDEA.
-- User: PoKong_OS
-- Date: 2015/3/18
-- Time: 10:56
-- To change this template use File | Settings | File Templates.
--

Lang = {};

--[[通用得到汉字]]
function Lang.get_words(index)
	if index == nil or index <= 0 then return "error" end;
	local region = AppConfig.get_update_region();
	if region == nil or region == "" then return "error" end;

	local temp_lang = nil;

	if region == "cn" then
		temp_lang = LangCn;
	end

	if temp_lang == nil or temp_lang == {} then return "error" end;

	return temp_lang[index][2];

end

