MMOUiManager = Class("MMOUiManager");

MMOEUI = {
	["MMOFightUIClick"] = {Class=MMOFightUIClick,group=1},
	["MMOTaskTrackUI"] = {Class=MMOTaskTrackUI,group=2},
	["MMOTaskListUI"] = {Class=MMOTaskListUI,group=3},
	["MMOTaskDialogUI"] = {Class=MMOTaskDialogUI,group=4},
    ["MMOMainUI"] = {Class = MMOMainUI, group = 10},

    ["PackageUI"] = {Class = PackageUI, group = 50},
    ["UiLevel"] = {Class = UiLevel, group = 51},
    ["UiLevelChallenge"] = {Class = UiLevelChallenge, group = 52},
}

function MMOUiManager:Start()
	self.uiList = {--[[name={obj=xxx,isShow=false}--]]};
	self.groupList = {--[[ [group] = name--]]};

    Root.AddUpdate(self.Update, self);
end

function MMOUiManager:ShowUi(name)
	app.log("=== ShowUi(name):"..name)
	local cfg = MMOEUI[name];
	if not cfg then
		app.log_warning("配置出错。EUI:"..tostring(name));
		return;
	end

	local cur_group_name = self.groupList[cfg.group];
	if cur_group_name then
		self:_HideUi(cur_group_name)
	end

	local obj = self:_ShowUi(name);
	return obj;
end 

function MMOUiManager:HideUi(name)
	self:_HideUi(name);
end

function MMOUiManager:HideAll(not_reply)
	for k,v in pairs(self.uiList) do
		if not_reply then
			self:_HideUi(k);
		else
			self:_HideUi(k,false);
		end
	end
end

function MMOUiManager:ReplyAll()
	for k,v in pairs(self.uiList) do
		if v.isShow then
			self:_ShowUi(k);
		end
	end
end

function MMOUiManager:Destroy()
	for k,v in pairs(self.uiList) do
		self:_Destroy(k);
	end
	self.uiList = nil;
	self.groupList = nil;

    Root.DelUpdate(self.Update, self);
end

function MMOUiManager:Update(dt)
	for k,v in pairs(self.uiList) do
		if v.isShow and v.obj.Update then
		    v.obj:Update(dt)
		end
	end
end

function MMOUiManager:GetUi(name)
    if self.uiList then
        local uiData = self.uiList[name]
        if uiData then
            return uiData.obj
        end
    end
    return nil
end

-------------------内部函数---------------

function MMOUiManager:_ShowUi(name)
	local cfg = MMOEUI[name];
	local data = self.uiList[name];
	if not data then
		data = {};
		data.obj = cfg.Class:new();
		self.uiList[name] = data;
	else
		data.obj:Show()
	end
	data.isShow = true;
	self.groupList[cfg.group] = name;
	return data.obj;
end

function MMOUiManager:_HideUi(name,set_flag)
	local cfg = MMOEUI[name];
	local data = self.uiList[name];
	if not cfg or not data then
		app.log_warning("配置出错。EUI:"..tostring(name));
		return;
	end
	data.obj:Hide();
	if set_flag == nil or set_flag then
		data.isShow = false;
	end
	self.groupList[cfg.group] = nil;
end

function MMOUiManager:_Destroy(name)
	local cfg = MMOEUI[name];
	local data = self.uiList[name];
	if not cfg or not data then
		app.log_warning("配置出错。EUI:"..tostring(name));
		return;
	end
	data.obj:DestroyUi();
	data.obj = nil;
	data.isShow = false;
	self.groupList[cfg.group] = nil;
end

MMOUiMgr = MMOUiManager:new();
