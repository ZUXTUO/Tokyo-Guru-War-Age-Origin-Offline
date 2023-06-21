DifficultSelect = Class('DifficultSelect',UiBaseClass)


--[[弹出难度选择界面，diffData = {{isOpen = true,rewards = {{id = 3,num = 10},{id = 2,num = 1}},levelLimit = 10},{isOpen = true,levelLimit = 20},{isOpen = false,levelLimit = 30},{isOpen = false,levelLimit = 40}}]]
function DifficultSelect.popPanel(diffData,challengeCallBack,sweepCallBack,usedTimes,totalTimes,curSelectData)
    --app.log("diffData============="..table.tostring(diffData))
    --app.log("curSelectData========"..table.tostring(curSelectData))
    if DifficultSelect.instance  == nil then
		DifficultSelect.instance = uiManager:PushUi(EUI.DifficultSelect, {
	        diff = diffData,
			challengeCall = challengeCallBack,
			sweepCall = sweepCallBack,
	        usedTimes = usedTimes;
	        totalTimes = totalTimes;
	        data = curSelectData;
	        })
	end
end 

function DifficultSelect.ClosePanel()
    if DifficultSelect.instance then
         uiManager:PopUi()
		DifficultSelect.instance.lockPlayedIndex = nil;
        DifficultSelect.instance = nil
    end
end

function DifficultSelect:GetSavedLockInfo()
	if file.exist("level_activity_"..tostring(g_dataCenter.player.playerid).."_"..tostring(self.data.id)) then 
		local fileobj = file.open("level_activity_"..tostring(g_dataCenter.player.playerid).."_"..tostring(self.data.id),3);
		self.lockPlayedIndex = fileobj:read_int();
		fileobj:close();
	else 
		self.lockPlayedIndex = 0;
	end
end 

function DifficultSelect:SaveLockInfo(index)
	local fileobj = file.open("level_activity_"..tostring(g_dataCenter.player.playerid).."_"..tostring(self.data.id),2);
	fileobj:write_int(self.maxOpen);
	fileobj:close();
end 
--重新开始
function DifficultSelect:Restart(data)
    self.textureBg = {}
	self.indexPidList = {};
	self.diffData = data.diff;
	self.challengeCall = data.challengeCall;
	self.sweepCall = data.sweepCall;
	self.usedTimes = data.usedTimes;
	self.totalTimes = data.totalTimes;
	self.data = data.data;
	self.isPlayLockAnim = {0,0,0,0,0,0,0,0,0};
	self.maxPass = -1;
    UiBaseClass.Restart(self, data);
end

function DifficultSelect:InitData(data)
    UiBaseClass.InitData(self, data);
	self.diffData = data.diff;
	self.challengeCall = data.challengeCall;
	self.sweepCall = data.sweepCall;
	self.usedTimes = data.usedTimes;
	self.totalTimes = data.totalTimes;
	self.data = data.data;	
end

function DifficultSelect:RegistFunc()
	----app.log("DifficultSelect:RegistFunc");
    self.bindfunc['on_main_ui_loaded'] = Utility.bind_callback(self, self.on_main_ui_loaded);
	self.bindfunc['load_main_ui'] = Utility.bind_callback(self, self.___LoadUI);
	self.bindfunc['onCloseClick'] = Utility.bind_callback(self, self.onCloseClick);
	self.bindfunc['updateItem'] = Utility.bind_callback(self, self.updateItem);
	self.bindfunc['clickDiffCard'] = Utility.bind_callback(self, self.clickDiffCard);
	self.bindfunc['onChallengeClick'] = Utility.bind_callback(self, self.onChallengeClick);
	self.bindfunc['onClickSweep'] = Utility.bind_callback(self, self.onClickSweep);
	self.bindfunc['onTimer'] = Utility.bind_callback(self, self.onTimer);
end

function DifficultSelect:onTimer()
	if self.timeFlagNum == nil then 
		--self.vs.downClockLabDesc:set_active(false); 
		--self.vs.downClockLabNum:set_active(false);
		--self.vs.downClockSp:set_active(false);
		if self.timerId ~= nil then 
			timer.stop(self.timerId);	
			self.timerId = nil;
		end 
	else 
		--self.vs.downClockLabDesc:set_active(true); 
		--self.vs.downClockLabNum:set_active(true);
		--self.vs.downClockSp:set_active(true);
		if self.timeFlagNum > system.time() then 
			local str = g_getTimeString(self.timeFlagNum - system.time());
			--app.log("玩法时间标志"..self.timeFlagNum.." | 服务器时间："..system.time());
			--self.vs.downClockLabNum:set_text(str);
		else 
			self.timeFlagNum = nil;
			--self.vs.downClockLabDesc:set_active(false); 
			--self.vs.downClockLabNum:set_active(false);
			--self.vs.downClockSp:set_active(false);
			if self.timerId ~= nil then 
				timer.stop(self.timerId);	
				self.timerId = nil;
			end 
		end
	end
end 

function DifficultSelect:InitUI(asset_obj)
	self.isPlayLockAnim = {0,0,0,0,0,0,0,0,0};
	--app.log("DifficultSelect:InitUI");
	UiBaseClass.InitUI(self, asset_obj);
    self.ui:set_name('DifficultSelect');
	self.vs = {};
	self.vs.panel = ngui.find_panel(self.ui,self.ui:get_name());
	--self.vs.panel:set_depth(1802);
	self.vs.btnClose = ngui.find_button(self.ui,"centre_other/animation/content_di_1004_564/btn_cha")
	self.vs.btnClose:set_on_click(self.bindfunc['onCloseClick'])
	self.vs.timesRemain = ngui.find_label(self.ui,"centre_other/animation/content/lab_num");

	self.vs.panelScroll = ngui.find_panel(self.ui,"centre_other/animation/panel");
	--self.vs.panelScroll:set_depth(1803);
	self.vs.btnSweep = ngui.find_button(self.ui,"centre_other/animation/btn1");
	--self.vs.btnSweep:set_active(false);
	self.vs.btnSweep:set_on_click(self.bindfunc['onClickSweep'])
	self.vs.btnChallenge = ngui.find_button(self.ui,"centre_other/animation/btn2");
	self.vs.btnChallenge:set_on_click(self.bindfunc['onChallengeClick']);

	self.vs.dragCycleGroup = ngui.find_enchance_scroll_view(self.ui,"centre_other/animation/panel");
	self.vs.dragCycleGroup:set_on_initialize_item(self.bindfunc['updateItem']);
	--self.vs.downClockLabNum = ngui.find_label(self.ui,"centre_other/animation/content/lab_time");
	--self.vs.downClockLabDesc = ngui.find_label(self.ui,"centre_other/animation/content/lab_title2");
	--self.vs.downClockSp = ngui.find_sprite(self.ui,"centre_other/animation/content/sp_di/sp_clock");
	self:UpdateUi();
end

local levelTexturePath = {
	[1] = "assetbundles/prefabs/ui/image/backgroud/huo_dong/huodong_guanqia/hdgq_nandu_d.assetbundle",
	[2] = "assetbundles/prefabs/ui/image/backgroud/huo_dong/huodong_guanqia/hdgq_nandu_c.assetbundle",
	[3] = "assetbundles/prefabs/ui/image/backgroud/huo_dong/huodong_guanqia/hdgq_nandu_b.assetbundle",
	[4] = "assetbundles/prefabs/ui/image/backgroud/huo_dong/huodong_guanqia/hdgq_nandu_a.assetbundle",
	[5] = "assetbundles/prefabs/ui/image/backgroud/huo_dong/huodong_guanqia/hdgq_nandu_s.assetbundle",
	[6] = "assetbundles/prefabs/ui/image/backgroud/huo_dong/huodong_guanqia/hdgq_nandu_ss.assetbundle",
	[7] = "assetbundles/prefabs/ui/image/backgroud/huo_dong/huodong_guanqia/hdgq_nandu_sss.assetbundle",
}

local _UIText = {
    [1] = "[73BE37]简单[-]",
    [2] = "[5580E2]普通[-]",
    [3] = "[9A51D1]困难[-]",
    [4] = "[FFBB03]高手[-]",
    [5] = "[FA8730]专家[-]",
    [6] = "[E72D66]大师[-]",
    [7] = "[F52E41]噩梦[-]",

    [100] = "[32EDBAFF]%s[-]/%s",
}

function DifficultSelect:updateItem(obj,index)
	self.indexPidList = self.indexPidList or {};
	local pid = obj:get_instance_id();
	--obj:set_active(true);
	self.selectPidList = self.selectPidList or {};
	if self.indexPidList[pid] ~= index then 
		if self.diffData[index] == nil then 
			--obj:set_active(false);
		else 
			local data = self.diffData[index];
			self.indexPidList[pid] = index;
			--obj:set_active(true);
			obj:set_name(tostring(index));
			ngui.find_sprite(obj,obj:get_name()):set_on_ngui_click(self.bindfunc['clickDiffCard']);
			local suoAni = obj:get_child_by_name("sp_suo");
			local selectFrame = ngui.find_texture(obj,"sp_kuang");
            if self.textureBg[index] == nil then
                self.textureBg[index] =  ngui.find_texture(obj, "texture")
            end
            self.textureBg[index]:set_texture(levelTexturePath[math.min(index,7)]);
			--local rankSprite = ngui.find_sprite(obj,"sp_art_font");
			local spLimit = ngui.find_texture(obj,"texture_mark");
			local labLevel = ngui.find_label(obj,"texture_mark/lab")
			local spsuo = ngui.find_sprite(obj,"sp_suo");
			labLevel:set_text(tostring(data.levelLimit));

            local lblRankName = ngui.find_label(obj,obj:get_name() .. "/lab")
			lblRankName:set_color(1,1,1,1);
            lblRankName:set_text(tostring(_UIText[math.min(index,7)]))
			if self.lockPlayedIndex == nil then 
				self:GetSavedLockInfo();
			end 
			if index == self.maxOpen and self.lockPlayedIndex < index then 
				if self.isPlayLockAnim[index] == 0 then 
					self:SaveLockInfo();
					self.isPlayLockAnim[index] = 1;
					spLimit:set_active(true);
					spsuo:set_active(true);
					local tover = function()
						self.isPlayLockAnim[index] = 2;
						spLimit:set_active(not self.diffData[tonumber(obj:get_name())].isOpen);
						spsuo:set_active(not self.diffData[tonumber(obj:get_name())].isOpen);
					end
					local tstart = function()
						suoAni:animated_play("ui_7102_award_level_center_kaisuo");
					end 
					Tween.addTween(spLimit,0.9,{},Transitions.linear,0.01,tstart,nil,tover);
				else
					if self.isPlayLockAnim[index] == 2 then 
						spLimit:set_active(not data.isOpen);
						spsuo:set_active(not data.isOpen);
					end 
					if data.isOpen == false then 
						spLimit:set_active(true);
						suoAni:animated_stop("ui_7102_award_level_center_kaisuo");
						suoAni:set_animated_time("ui_7102_award_level_center_kaisuo",0);
						suoAni:set_local_scale(1,1,1);
						suoAni:set_local_rotation(0,0,0);
						spsuo:set_color(1,1,1,1);
						spsuo:set_active(true);
						
					end
				end 
			else
				spLimit:set_active(not data.isOpen);
				spsuo:set_active(not data.isOpen);
			end 
			if self.selectPidList[tostring(index).."|"..tostring(pid)] == 1 then 
				selectFrame:set_active(true);
			else 
				selectFrame:set_active(false);
			end
		end
	end 
end 

function DifficultSelect:clickDiffCard(name, x, y, go_obj)
	--app.log("DifficultSelect:clickDiffCard index = "..table.tostring(name));
	--app.log("diffData"..table.tostring(self.diffData));
	local len = #self.diffData;
	local maxPass = 0;
	for i = 1,len do 
		if self.diffData[i].pass == true then 
			maxPass = i;
		end
	end
	local index = tonumber(name);
	local data = self.diffData[index];
	if data.isOpen == true then
		self.selectPidList = {};
		self.selectPidList[name.."|"..tostring(go_obj:get_instance_id())] = 1;
		self.selectDiffIndex = index;
		self.indexPidList = {};
		self.vs.dragCycleGroup:refresh_list();
		if index == maxPass then 
			self.vs.btnSweep:set_active(true);
		else
			self.vs.btnSweep:set_active(false); 
		end 
	else 
		local level = g_dataCenter.player.level;
		if level < data.levelLimit then 
			FloatTip.Float("还未解锁该难度：等级不足");
		else 
			FloatTip.Float("还未解锁该难度：需要通过上一难度");
		end
	end
end 

function DifficultSelect:onChallengeClick()
	if self.usedTimes >= self.totalTimes and g_dataCenter.gmCheat:getPlayLimit()==true  then 
		FloatTip.Float("今日挑战次数已用完");
	else 
		if self.timeFlagNum ~= nil and g_dataCenter.gmCheat:getPlayLimit()==true then 
			--local str = g_getTimeChString(self.timeFlagNum - system.time());
			--app.log("玩法时间标志"..self.timeFlagNum.." | 服务器时间："..system.time());
			FloatTip.Float("活动冷却中");
			do return end;
		end
		if self.selectDiffIndex ~= nil then 
			if self.challengeCall ~= nil and _G[self.challengeCall] ~= nil then  
				--_G[self.challengeCall](self.selectDiffIndex);
				SelectRoleUi.popPanel(self.data.id,self.selectDiffIndex, self.challengeCall)
				--DifficultSelect.ClosePanel()
			end 
		else 
			FloatTip.Float("还未选择挑战难度");
		end
	end 
end 

function DifficultSelect:changeChallengeTimes(usedTimes,totalTimes)
	self.usedTimes = usedTimes;
	self.totalTimes = totalTimes;
	self.vs.timesRemain:set_text(string.format(_UIText[100] , tostring(self.totalTimes - self.usedTimes), tostring(self.totalTimes)))
end 

function DifficultSelect:UpdateUi()
	self.vs.timesRemain:set_text(string.format(_UIText[100] , tostring(self.totalTimes - self.usedTimes), tostring(self.totalTimes)))
	local len = #self.diffData;
	local openIndex = 0;
	self.maxPass = 0;
	self.maxOpen = 0;
	for i = 1,len do 
		if self.diffData[i].pass == true then 
			self.maxPass = i;
		end
		if self.diffData[i].isOpen == false then 
			openIndex = i - 1;
			break;
		else
			openIndex = i;
		end
	end
	self.maxOpen = openIndex;
	if openIndex == self.maxPass then 
		self.vs.btnSweep:set_active(true);
	else 
		self.vs.btnSweep:set_active(false);
	end 
	--self.vs.btnSweep:set_active(true);
	self.vs.dragCycleGroup:set_showIndex(openIndex);
	for pid,index in pairs(self.indexPidList) do 
		if index == openIndex then 
			self.selectPidList = {};
			self.selectPidList[tostring(openIndex).."|"..tostring(pid)] = 1;
			self.selectDiffIndex = index;
			self.indexPidList = {};
			self.vs.dragCycleGroup:refresh_list();
			break;
		end
	end 
	self.vs.dragCycleGroup:set_maxNum(len);
	flagHelper = g_dataCenter.player:GetFlagHelper();
	local timeStr = flagHelper:GetStringFlag(self.data.id);
	self.timeFlagNum = nil;
	if self.timerId ~= nil then 
		timer.stop(self.timerId);
		self.timerId = nil;
	end 
	if self.usedTimes < self.totalTimes and timeStr ~= nil then 
		self.timeFlagNum = tonumber(timeStr);
		if self.timeFlagNum == nil then 
			local a = string.split(timeStr,";");
			if a[2] ~= nil then 
				local b = string.split(a[2],"=");
				self.timeFlagNum = tonumber(b[2]);
			end 
		end 
		if self.timeFlagNum ~= nil then 
			self.timeFlagNum = self.timeFlagNum + self.data.relative;
			if self.timeFlagNum > system.time() then 
				local str = g_getTimeString(self.timeFlagNum - system.time());
				self.timerId = timer.create(self.bindfunc['onTimer'],1000,-1);
			else 
				self.timeFlagNum = nil;
			end
		end 
	end 
end 

function DifficultSelect:onClickSweep()
	if self.sweepCall ~= nil and _G[self.sweepCall] ~= nil then 
		if self.usedTimes >= self.totalTimes and g_dataCenter.gmCheat:getPlayLimit()==true then 
			FloatTip.Float("今日挑战次数已用完，不能扫荡");
			do return end;
		end
		if self.timeFlagNum ~= nil and g_dataCenter.gmCheat:getPlayLimit()==true then 
			local str = g_getTimeChString(self.timeFlagNum - system.time());
			--app.log("玩法时间标志"..self.timeFlagNum.." | 服务器时间："..system.time());
			FloatTip.Float("活动冷却中");
			do return end;
		end
		_G[self.sweepCall](self.selectDiffIndex);
	end
end 

function DifficultSelect:onCloseClick()
	DifficultSelect.ClosePanel()
end 

function DifficultSelect:Init(data)
	--app.log("DifficultSelect:Init");
    self.pathRes = "assetbundles/prefabs/ui/level_activity/ui_7102_award_level.assetbundle";
	UiBaseClass.Init(self, data);
end

--析构函数
function DifficultSelect:DestroyUi()
	--app.log("DifficultSelect:DestroyUi");
	if self.timerId ~= nil then 
		timer.stop(self.timerId);
		self.timerId = nil;
	end 
	if self.vs ~= nil then 
		self.vs = nil;
	end 
    for k, v in pairs(self.textureBg) do
        if v then
            v:Destroy()
            v = nil
        end
    end

    UiBaseClass.DestroyUi(self);
    --Root.DelUpdate(self.Update, self)
end

--显示ui
function DifficultSelect:Show()
	--app.log("DifficultSelect:Show");
    UiBaseClass.Show(self);
end

--隐藏ui
function DifficultSelect:Hide()
	--app.log("DifficultSelect:Hide");
    UiBaseClass.Hide(self);
end

--注册消息分发回调函数
function DifficultSelect:MsgRegist()
	--app.log("DifficultSelect:MsgRegist");
    UiBaseClass.MsgRegist(self);
end

--注销消息分发回调函数
function DifficultSelect:MsgUnRegist()
	--app.log("DifficultSelect:MsgUnRegist");
    UiBaseClass.MsgUnRegist(self);
end