-- 读写本地文件
LocalFile = {}

LocalFile.fileName = {
	prologue = "prologue.data",
	hero_egg = "egg1",
	guide_log = "guide_log.txt",
}

local _update_account_record_state = false

function LocalFile._GetPrologueRecordData()
	--[[
	local file_handler = file.open_read(LocalFile.fileName.prologue);
	if file_handler then
		local content = file_handler:read_all_text()
		file_handler:close();
		if content ~= "" then
			local k = loadstring("return "..content);
			if k ~= nil then
				return k()
			end
		end
	end
	--]]
end

--查询巅峰展示打点记录
function LocalFile.GetPrologueRecord()
	local result = 0
	local record_data = LocalFile._GetPrologueRecordData()
	--if record_data then
		--local encode_account = SimpleEncrypt.Encode(UserCenter.get_accountid())
		--result = record_data[encode_account] or -1
	--end
	--return result
end

--写入巅峰展示打点记录
function LocalFile.WritePrologueRecord(val)
	local record_data = LocalFile._GetPrologueRecordData() or {}

	-- val:0/1/2/3 无记录/完成巅峰/完成序章1/完成序章2
	local file_handler = file.open(LocalFile.fileName.prologue, 2);
	--if file_handler then
		--local encode_account = SimpleEncrypt.Encode(UserCenter.get_accountid())
		--record_data[encode_account] = val
		--file_handler:write_string( table.toFileString(record_data) )
		--file_handler:close();
	--end

	--EnterShow.PostHttpRecord(val) -- 发送账号打点消息

	--_update_account_record_state = true
end

function LocalFile.ReadUpdateAccountState()
	local result = _update_account_record_state
	_update_account_record_state = false -- 取出之后重置状态
	return result
end

--查询第一次扭蛋打点记录
function LocalFile.GetHeroEggRecord(index)
	local result = false
	local file_handler = file.open_read(LocalFile.fileName.hero_egg);
	if file_handler then
		local aaa = file_handler:read_all_text()
		if aaa ~= "" then
			local ret = loadstring(aaa);
			if ret ~= nil then
				local data = ret() or {}
				for k, v in pairs(data) do
					if v == tostring(index) then
						result = true
						break;
					end
				end
			end
		end
		file_handler:close();
	end
	return result
end

--写入第一次扭蛋打点记录
function LocalFile.WriteHeroEggRecord(index)
	local file_handler = file.open(LocalFile.fileName.hero_egg,2);
	if not file_handler then
		return
	end

	local dataStr = ""
	local aaa = file_handler:read_all_text()
	if aaa ~= "" then
		local ret = loadstring(aaa);
		
		if ret ~= nil then
			local data = ret() or {}
			local exist = false
			for k, v in pairs(data) do
				if v == tostring(index) then
					exist = true
					break;
				end
			end
			if not exist then
				table.insert(data, tostring(index))
				dataStr = table.tostringEx(data);
				--dataStr = tostring(data);
			end
		end
	end

	if dataStr == "" then
		dataStr = string.format( "{'%s'}", index );
	end
	file_handler:write_string( "return "..dataStr );
	file_handler:close();
end

function LocalFile.InsertGuideLog(content)
	local file_handler = file.open(LocalFile.fileName.guide_log, 6);
	if file_handler then
		file_handler:write_string(content)
		file_handler:close()
		file_handler = nil
	end
end

function LocalFile.RemoveGuideLog()
	if file.exist(LocalFile.fileName.guide_log) then
		file.delete(LocalFile.fileName.guide_log)
	end
end