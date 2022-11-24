HurdleCollectBoxUi = Class("HurdleCollectBoxUi", UiBaseClass);
local res = "assetbundles/prefabs/ui/wanfa/baoxiang/panel_open_box.assetbundle"

function HurdleCollectBoxUi.GetResList()
    return {res}
end

function HurdleCollectBoxUi:Init(data)
    self.pathRes = res;
    UiBaseClass.Init(self, data);
end

function HurdleCollectBoxUi:InitData(data)
    UiBaseClass.InitData(self, data);
end

function HurdleCollectBoxUi:Restart(data)
	self.openNumList = {};
	self.openScore = 0;
	self.curEntity = {};
	local cfg = FightScene.GetStartUpEnv().levelData
	local lst = cfg.perfact_condition;
	self.total = 0;
	for k,v in pairs(lst) do
		if k == "collect_num" then
			self.total = v[2];
		end
	end
    if not UiBaseClass.Restart(self, data) then
        return;
    end
end

function HurdleCollectBoxUi:RegistFunc()
    UiBaseClass.RegistFunc(self);
    self.bindfunc["onBtnOpen"] = Utility.bind_callback(self, self.onBtnOpen);
    self.bindfunc["onEventMove"] = Utility.bind_callback(self, self.onEventMove);
    self.bindfunc["onEventUseSkill"] = Utility.bind_callback(self, self.onEventUseSkill);
    self.bindfunc["onEventHitted"] = Utility.bind_callback(self, self.onEventHitted);
end

function HurdleCollectBoxUi:MsgRegist()
    UiBaseClass.MsgRegist(self);
    NoticeManager.BeginListen(ENUM.NoticeType.EntityBeginMove, self.bindfunc["onEventMove"]);
    NoticeManager.BeginListen(ENUM.NoticeType.EntityUseSkill, self.bindfunc["onEventUseSkill"]);
    NoticeManager.BeginListen(ENUM.NoticeType.EntityHitted, self.bindfunc["onEventHitted"]);
end

function HurdleCollectBoxUi:MsgUnRegist()
    UiBaseClass.MsgUnRegist(self);
    NoticeManager.EndListen(ENUM.NoticeType.EntityBeginMove, self.bindfunc["onEventMove"]);
    NoticeManager.EndListen(ENUM.NoticeType.EntityUseSkill, self.bindfunc["onEventUseSkill"]);
    NoticeManager.EndListen(ENUM.NoticeType.EntityHitted, self.bindfunc["onEventHitted"]);
end

function HurdleCollectBoxUi:InitUI(asset_obj)
    UiBaseClass.InitUI(self, asset_obj);
    self.ui:set_name("HurdleCollectBoxUi");

	self.btnOpen = ngui.find_button(self.ui, "centre_other/animation/btn");
	if self.btnOpen then
		self.btnOpen:set_on_click(self.bindfunc["onBtnOpen"]);
	end

	self.proOpen = ngui.find_sprite(self.ui, "centre_other/animation/btn/sp_shine");

	self.proCollect = ngui.find_progress_bar(self.ui,"centre_other/animation/background");
	self.labCollect = ngui.find_label(self.ui,"centre_other/animation/sp_box/lab");
	self.objGuideTips = self.ui:get_child_by_name("centre_other/animation/sp_down_arrow");

    self:UpdateUi();
end

function HurdleCollectBoxUi:UpdateUi()
    if not UiBaseClass.UpdateUi(self) then
        return;
    end
	self:UpdatePro();
	if self.btnOpen then
		self.btnOpen:set_active(false);
	end
    if self.proOpen then
    	self.proOpen:set_active(false);
    	self.proOpen:set_fill_amout(0);
    end

	local optionTipCom = GetMainUI():GetOptionTipUI()
	if optionTipCom then
		optionTipCom:ShowCollectProgress()
	end
end

function HurdleCollectBoxUi:DestroyUi()
    UiBaseClass.DestroyUi(self);
    self.beginOpenTime = nil;
end

function HurdleCollectBoxUi:Update(dt)
	if not UiBaseClass.Update(self, dt) then
		return false
	end
	if self.beginOpenTime and self.proOpen then
		local nNum = PublicFunc.QueryDeltaTime(self.beginOpenTime)/self.openTime;
		self.proOpen:set_fill_amout(nNum);
		if nNum >= 1 then
			self:onOpen();
		end
	end
end

-----------------------

function HurdleCollectBoxUi:onBtnOpen()
	local curEntity = self.curEntity[#self.curEntity];
	local entity = ObjectManager.GetObjectByName(curEntity)
	if entity and entity:IsItem() then
		self.itemId = entity:GetConfigId();
		local cfg = ConfigManager.Get(EConfigIndex.t_world_item,self.itemId);
		self.openTime = cfg.delay_time;
		self.beginOpenTime = self.beginOpenTime or PublicFunc.QueryCurTime();
		if self.proOpen then
			self.proOpen:set_active(true);
		end
	end
end

function HurdleCollectBoxUi:onEventMove(entity)
	if entity:IsCaptain() then
		self:BreakOpen();
	end
end

function HurdleCollectBoxUi:onEventUseSkill(entity)
	if entity:IsCaptain() then
		self:BreakOpen();
	end
end

function HurdleCollectBoxUi:onEventHitted(entity)
	if entity:IsCaptain() then
		self:BreakOpen();
	end
end

function HurdleCollectBoxUi:onOpen()
	local cfg = ConfigManager.Get(EConfigIndex.t_world_item,self.itemId);
	self.openNumList[self.itemId] = (self.openNumList[self.itemId] or 0) + 1;
	if type(cfg.extra_content) == "number" then
		self.openScore = self.openScore + cfg.extra_content;
	elseif type(cfg.extra_content) == "string" then
		FloatTip.Float(cfg.extra_content)
	elseif type(cfg.extra_content) == "table" then
		self.openScore = self.openScore + cfg.extra_content.score;
		FloatTip.Float(Utility.GetRootObjByString(cfg.extra_content.str));
	end
	AudioManager.PlayUiAudio(81200113)
	self:BrushMonster(cfg.trigger_monster);
	self:UpdatePro();

	local curEntity = self.curEntity[#self.curEntity];
	local entity = ObjectManager.GetObjectByName(curEntity)
	self:ShowBtn(false, entity);
	FightScene.DeleteObj(curEntity, 50)
	self.beginOpenTime = nil;
	if self.proOpen then
		self.proOpen:set_active(false);
	end
end

function HurdleCollectBoxUi:UpdatePro()
	local cur = self:GetOpenNum(0);
	self.labCollect:set_text(tostring(cur).."/"..tostring(self.total));
	self.proCollect:set_value(tonumber(cur)/tonumber(self.total));

	local optionTipCom = GetMainUI():GetOptionTipUI()
	if optionTipCom then
		optionTipCom:UpdateCollectProgress(cur, self.total)
	end
end

function HurdleCollectBoxUi:BrushMonster(cfg_list)
	if cfg_list == 0 then
		return;
	end
	local curEntity = self.curEntity[#self.curEntity];
	for k,cfg in pairs(cfg_list) do
		local entity = ObjectManager.GetObjectByName(curEntity)
		local pos = entity:GetPosition();
		local newmonster = FightScene.CreateMonsterAsync(nil, cfg.id, 2, nil, cfg.lv);
		newmonster:SetPosition(pos.x,pos.y,pos.z);
		PublicFunc.UnifiedScale(newmonster);
	end
end

function HurdleCollectBoxUi:BreakOpen()
	if self.beginOpenTime then
		FloatTip.Float(tostring(gs_misc['str_91']));
	end
	self.beginOpenTime = nil;
	if self.proOpen then
		self.proOpen:set_active(false);
	end
end

function HurdleCollectBoxUi:CheckGuideTips()
	local fight_type = FightScene.GetStartUpEnv().levelData.fight_type;
    local count = g_dataCenter.playMethodInfo:GetCount(fight_type);
    if count >= 1 then
    	self.objGuideTips:set_active(false);
        return;
    end
    if self:GetOpenNum(0) > 0 then
    	self.objGuideTips:set_active(false);
    	return;
    end
    self.objGuideTips:set_active(true);
end

-----------------------
function HurdleCollectBoxUi:ShowBtn(isShow, entity)
	if isShow then
		local curEntity = entity:GetName();
		for k,v in pairs(self.curEntity) do
			if v == curEntity then
				return;
			end
		end
		table.insert(self.curEntity, curEntity);
	else
		for k,v in pairs(self.curEntity) do
			if v == entity:GetName() then
				table.remove(self.curEntity,k);
				break;
			end
		end
	end
	if self.proOpen then
		self.proOpen:set_active(false);
		self.proOpen:set_fill_amout(0);
	end
	if self.btnOpen then
		self.btnOpen:set_active(#self.curEntity>0);
		self:CheckGuideTips();
	end
end

function HurdleCollectBoxUi:GetOpenNum(id)
	if id == 0 then
		local num = 0;
		for k,v in pairs(self.openNumList) do
			num = num + v;
		end
		return num;
	else
		return self.openNumList[id] or 0;
	end
end

function HurdleCollectBoxUi:GetScore()
	return self.openScore;
end
