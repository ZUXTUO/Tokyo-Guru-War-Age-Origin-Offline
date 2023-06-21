FlagHelper = Class("FlagHelper");

-----------------------------------外部接口------------------------------
function FlagHelper:GetStringFlag(system_id)
	return self.stringList[system_id], self.stringExList[system_id];
end
function FlagHelper:GetNumberFlag(system_id)
	return self.numberList[system_id];
end


-----------------------------------内部接口-----------------------------
function FlagHelper:Init(data)
	self.stringList = {};
	self.stringExList = {};
	self.numberList = {};
end

function FlagHelper:SetList(vec_data)
	--app.log("........"..table.tostring(vec_data))
	for k, v in pairs(vec_data) do
		self:AddFlag(v);
	end
end

function FlagHelper:UpdateFlag(data)
	if type(data) ~= "table" then
		app.log("UpdateFlag 数据为"..tostring(data).." traceback="..debug.traceback());
		return;
	end
	if data.flag_type == 1 then
		self:UpdateString(data.system_id, data.string_flag, data.string_flag_ex);
	elseif data.flag_type == 2 then
		self:UpdateNumber(data.system_id, data.number_flag);
	end
end

function FlagHelper:UpdateString(system_id, string, string_ex)
	if self.stringList[system_id] then
		self.stringList[system_id] = string;
	end
	if self.stringExList[system_id] then
		self.stringExList[system_id] = string_ex;
	end
	if g_dataCenter.activity[system_id] and g_dataCenter.activity[system_id].UpdateTime then
		g_dataCenter.activity[system_id]:UpdateTime();
	end
end

function FlagHelper:UpdateNumber(system_id, number)
	if self.numberList[system_id] then
		self.numberList[system_id] = number;
	end
end

function FlagHelper:AddFlag(data)
	if type(data) ~= "table" then
		app.log("AddFlag 数据为"..tostring(data).." traceback="..debug.traceback());
		return;
	end
	if data.flag_type == 1 then
		self:AddString(data.system_id, data.string_flag, data.string_flag_ex);
	elseif data.flag_type == 2 then
		self:AddNumber(data.system_id, data.number_flag);
	end
end

function FlagHelper:AddString(system_id, string, string_flag_ex)
	self.stringList[system_id] = string;
	self.stringExList[system_id] = string_flag_ex;
	if g_dataCenter.activity[system_id] and g_dataCenter.activity[system_id].UpdateTime then
		g_dataCenter.activity[system_id]:UpdateTime();
	end
end

function FlagHelper:AddNumber(system_id, number)
	self.numberList[system_id] = number;
end

function FlagHelper:RemoveFlag(data)
	if type(data) ~= "table" then
		app.log("RemoveFlag 数据为"..tostring(data).." traceback="..debug.traceback());
		return;
	end
	if data.flag_type == 1 then
		self:RemoveString(data.system_id);
	elseif data.flag_type == 2 then
		self:RemoveNumber(data.system_id);
	end
end

function FlagHelper:RemoveString(system_id)
	self.stringList[system_id] = nil;
	self.stringExList[system_id] = nil;
end

function FlagHelper:RemoveNumber(system_id)
	self.numberList[system_id] = nil;
end

