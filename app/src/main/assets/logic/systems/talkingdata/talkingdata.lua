--
-- Created by IntelliJ IDEA.
-- User: pokong
-- Date: 2017/3/24
-- Time: 16:45
-- To change this template use File | Settings | File Templates.
--

talkingdata = {};


function talkingdata.submit(type,info)
	app.log("talkingdata type="..tostring(type)..",info="..tostring(info));

	if type == nil or type == "" or info == nil or info == "" then return end;

	local json_info = "";
	local table_info = {};

	if tostring(type) == "register" then
		table_info.type = "register";
		table_info.userId = tostring(info);
		json_info = pjson.encode(table_info);
	end

	if tostring(type) == "login" then
		table_info.type = "login";
		table_info.userId = tostring(info);
		json_info = pjson.encode(table_info);
	end

	if tostring(type) == "createRole" then
		table_info.type = "createRole";
		table_info.roleData = tostring(info);
		json_info = pjson.encode(table_info);
	end

	talking_data.submit("talkingdata",json_info);
end

