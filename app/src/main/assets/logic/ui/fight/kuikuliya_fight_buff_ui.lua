KuiKuLiYaFightBuffUI = Class("KuiKuLiYaFightBuffUI", UiBaseClass);

-- local hurdleList = nil;
-- local instance = nil;

-- function KuiKuLiYaFightBuffUI.Create(hurdle_id)
-- 	if not instance then
-- 		instance = KuiKuLiYaFightBuffUI:new();
-- 	end
-- 	instance:Show(hurdle_id);
-- end

-- function KuiKuLiYaFightBuffEnd()
-- 	if instance then
-- 		instance:DestroyUi();
-- 		instance = nil;
-- 	end
-- end

function KuiKuLiYaFightBuffUI.GetResList()
    return {"assetbundles/prefabs/ui/new_fight/new_fight_ui_jxtz.assetbundle"}
end

function KuiKuLiYaFightBuffUI:Init(data)
    self.pathRes = KuiKuLiYaFightBuffUI.GetResList()[1];
    if not self.hurdleList then
    	self.hurdleList = {};
	    local _hurdleListCfg = ConfigManager._GetConfigTable(EConfigIndex.t_kuikuliya_hurdle_info);
	    for floor,cfg in pairs(_hurdleListCfg) do
	    	self.hurdleList[cfg.hurdle_id] = cfg;
	    end
	end
    UiBaseClass.Init(self, data);
end

function KuiKuLiYaFightBuffUI:InitData(data)
    UiBaseClass.InitData(self, data);
    self.hurdleId = 0;
    self.time = 2000;
    self.timerId = nil;
end

function KuiKuLiYaFightBuffUI:MsgUnRegist()
    UiBaseClass.MsgUnRegist(self);
end

function KuiKuLiYaFightBuffUI:InitUI(asset_obj)
    UiBaseClass.InitUI(self, asset_obj);
    self.ui:set_name("ui_4704_challenge");
    self.ui:set_active(false);

    self.labBuffName = ngui.find_label(self.ui,"defense_house/sp_di/lab1");
    self.labBuffDes = ngui.find_label(self.ui,"defense_house/sp_di/lab2");
    self.textBuff = ngui.find_texture(self.ui,"defense_house/sp_di/Texture");

    self:UpdateUi();
end

function KuiKuLiYaFightBuffUI:UpdateUi()
    if not UiBaseClass.UpdateUi(self) then
        return;
    end
    local cfg = self.hurdleList[self.hurdleId];
    if cfg then
    	self.ui:set_active(true);
    	self.labBuffName:set_text(tostring(cfg.buff_name));
    	self.labBuffDes:set_text(tostring(cfg.buff_des));
    	self.textBuff:set_texture(cfg.buff_sp);
    	if self.timerId then
    		timer.stop(self.timerId);
    	end
    	timer.create("KuiKuLiYaFightBuffEnd",self.time,1);
    end
end

function KuiKuLiYaFightBuffUI:Show(hurdle_id)
	self.hurdleId = hurdle_id;
	UiBaseClass.Show(self);
	self:UpdateUi();
end

function KuiKuLiYaFightBuffUI:DestroyUi()
    UiBaseClass.DestroyUi(self);
    if self.timerId then
    	timer.stop(self.timerId);
    	self.timerId = nil;
    end
end