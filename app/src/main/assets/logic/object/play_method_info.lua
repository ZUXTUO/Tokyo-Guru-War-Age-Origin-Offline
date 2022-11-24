--用于记录玩法进入时间进入次数等信息
PlayMethodInfo = Class("PlayMethodInfo");
local file_path = "play_method_info.data";
function PlayMethodInfo:Init()
	self.data = {};

	self:ReadFile();
end

function PlayMethodInfo:ReadFile()
	local file_handler = file.open_read(file_path);
	if not file_handler then
		return;
	end
	local aaa = file_handler:read_all_text()
	if aaa ~= "" then
		local k = loadstring(aaa);
		if k ~= nil then
			for k,v in pairs(k()) do
				self.data[k] = v;
			end
		end
	end
	file_handler:close();
end

function PlayMethodInfo:WriteFile()
	local file_handler = file.open(file_path,4);
	if not file_handler then
		return;
	end
	file_handler:write_string(table.tostringEx(self.data));
	file_handler:close();
end

function PlayMethodInfo:RecordInfo(fight_type)
	self.data[g_dataCenter.player:GetGID().."x"..fight_type] = self.data[g_dataCenter.player:GetGID().."x"..fight_type] or {};
	self.data[g_dataCenter.player:GetGID().."x"..fight_type].count = self.data[g_dataCenter.player:GetGID().."x"..fight_type].count or 0;
	self.data[g_dataCenter.player:GetGID().."x"..fight_type].count = self.data[g_dataCenter.player:GetGID().."x"..fight_type].count + 1;
	if self.data[g_dataCenter.player:GetGID().."x"..fight_type].count == 1 then
		self.data[g_dataCenter.player:GetGID().."x"..fight_type].time = os.time();
	end
	self:WriteFile();
end

function PlayMethodInfo:GetCount(fight_type)
	if self.data[g_dataCenter.player:GetGID().."x"..fight_type] then
		return self.data[g_dataCenter.player:GetGID().."x"..fight_type].count;
	else
		return 0;
	end
end

function PlayMethodInfo:GetOpenDay()
	if self.data[g_dataCenter.player:GetGID().."x"..fight_type] then
		return Utility.timediff(os.time(),self.data[g_dataCenter.player:GetGID().."x"..fight_type].time).day;
	else
		return 0;
	end
end