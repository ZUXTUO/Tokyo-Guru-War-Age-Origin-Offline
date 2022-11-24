WorldBossReportUI = Class("WorldBossReportUI", UiBaseClass);

function WorldBossReportUI:Init(data)
    self.pathRes = "assetbundles/prefabs/ui/wanfa/world_boss/ui_3004_world_boss.assetbundle";
    UiBaseClass.Init(self, data);
end

function WorldBossReportUI:Restart(data)
	msg_world_boss.cg_world_boss_request_fight_report();
    if not UiBaseClass.Restart(self, data) then
        return;
    end
end

function WorldBossReportUI:RegistFunc()
    UiBaseClass.RegistFunc(self);
    self.bindfunc["on_init_item"] = Utility.bind_callback(self, self.on_init_item);
    self.bindfunc["onClose"] = Utility.bind_callback(self, self.onClose);
    self.bindfunc["gc_sync_world_boss_fight_report"] = Utility.bind_callback(self, self.gc_sync_world_boss_fight_report);
end

function WorldBossReportUI:MsgRegist()
    UiBaseClass.MsgRegist(self);
    PublicFunc.msg_regist(msg_world_boss.gc_sync_world_boss_fight_report,self.bindfunc["gc_sync_world_boss_fight_report"]);
end

function WorldBossReportUI:MsgUnRegist()
    UiBaseClass.MsgUnRegist(self);
    PublicFunc.msg_unregist(msg_world_boss.gc_sync_world_boss_fight_report,self.bindfunc["gc_sync_world_boss_fight_report"]);
end

function WorldBossReportUI:InitUI(asset_obj)
    UiBaseClass.InitUI(self, asset_obj);
    self.ui:set_name("WorldBossReportUI");

    self.cont = {};
    self.scroll = ngui.find_scroll_view(self.ui,"centre_other/animation/scroll_view/panel");
    self.warpList = ngui.find_wrap_list(self.ui,"centre_other/animation/scroll_view/panel/wrap_list");
    self.warpList:set_on_initialize_item(self.bindfunc["on_init_item"]);

    local btn = ngui.find_button(self.ui,"centre_other/animation/btn_cha");
    btn:set_on_click(self.bindfunc["onClose"]);

    self:UpdateUi();
end

function WorldBossReportUI:UpdateUi()
    if not UiBaseClass.UpdateUi(self) then
        return;
    end
    if self.listReport then
    	self.warpList:set_min_index(1-#self.listReport);
    	self.warpList:set_max_index(0);
    	self.warpList:reset();
    	self.scroll:reset_position();
    else
    	self.warpList:set_min_index(1);
    	self.warpList:set_max_index(0);
    	self.warpList:reset();
    	self.scroll:reset_position();
    end
end

function WorldBossReportUI:DestroyUi()
	self.listReport = nil;
    UiBaseClass.DestroyUi(self);
end

function WorldBossReportUI:onClose()
	uiManager:PopUi();
end

function WorldBossReportUI:on_init_item(obj, b, real_id)
    local index = math.abs(real_id)+1;
    if Utility.isEmpty(self.cont[b]) then
        self.cont[b] = self:init_item(obj)
    end
    self:update_item(self.cont[b], index);
end

function WorldBossReportUI:init_item(obj)
    local cont = {}
    cont.obj = obj;
    cont.labBoss = ngui.find_label(obj,"lab");
    cont.labDes = ngui.find_label(obj,"lab_describe");
    cont.labTime = ngui.find_label(obj,"lab_time");
    return cont;
end

function WorldBossReportUI:update_item(cont, index)
	local cfg = self.listReport[index];
	local _,_,_,hour,min,sec = TimeAnalysis.ConvertToYearMonDay(cfg.report_time);
	cont.labTime:set_text(string.format("[%02d:%02d]",hour,min,sec));

    local str = gs_string_world_boss["report_"..cfg.report_type];
    if cfg.report_type == 0 then
        str = string.gsub(str, "#name#",cfg.player_name);
        local awardList = ConfigManager.Get(EConfigIndex.t_world_boss_level_reward, cfg.boss_id);
        local awards = awardList[cfg.boss_level].luck_attack_reward;
        local strAwards;
        for k,v in pairs(awards) do
            local cfg = ConfigManager.Get(EConfigIndex.t_item,v.id);
            local num = v.num;
            if strAwards then
                strAwards = strAwards..","..cfg.name.."x"..num;
            else
                strAwards = cfg.name.."x"..num;
            end
        end
        str = string.gsub(str, "#award#",strAwards);
    elseif cfg.report_type == 1 then
        str = string.gsub(str, "#name#",cfg.player_name);
        local awardList = ConfigManager.Get(EConfigIndex.t_world_boss_level_reward, cfg.boss_id);
        local awards = awardList[cfg.boss_level].kill_reward;
        local strAwards;
        for k,v in pairs(awards) do
            local cfg = ConfigManager.Get(EConfigIndex.t_item,v.id);
            local num = v.num;
            if strAwards then
                strAwards = strAwards..","..cfg.name.."x"..num;
            else
                strAwards = cfg.name.."x"..num;
            end
        end
        str = string.gsub(str, "#award#",strAwards);
    end
    cont.labDes:set_text(str);

	if cfg.showBoss then
	    local monsterCfg = ConfigManager.Get(EConfigIndex.t_monster_property, cfg.boss_id);
	    cont.labBoss:set_text(monsterCfg.name.."[FFF011FF]"..cfg.boss_level.."级[-]");
		cont.labBoss:set_active(true);
	else
		cont.labBoss:set_active(false);
	end
end

function WorldBossReportUI:gc_sync_world_boss_fight_report(info)
	local curBossId;
	local curBossLv;
	for i=#info,1,-1 do
        local v = info[i];
        v.showBoss = true;
		if curBossId == v.boss_id and curBossLv == v.boss_level then
            curBossId = v.boss_id
            curBossLv = v.boss_level
            v.showBoss = false;
		end
        if curBossLv == nil and curBossLv == nil then
            curBossId = v.boss_id
            curBossLv = v.boss_level
        end
	end
    self.listReport = info;
	self:UpdateUi();
end