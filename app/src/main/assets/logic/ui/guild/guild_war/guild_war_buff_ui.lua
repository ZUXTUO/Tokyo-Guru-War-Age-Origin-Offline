
GuildWarBuffUI = Class('GuildWarBuffUI', UiBaseClass)

function GuildWarBuffUI.Start()
    if GuildWarBuffUI.cls == nil then
        GuildWarBuffUI.cls = GuildWarBuffUI:new()
    end
end

function GuildWarBuffUI.Update(dt)
    if GuildWarBuffUI.cls then
        GuildWarBuffUI.cls:update(dt);
    end
end

function GuildWarBuffUI.End()
    if GuildWarBuffUI.cls then
        GuildWarBuffUI.cls:DestroyUi()
        GuildWarBuffUI.cls = nil
    end
end

---------------------------------------华丽的分隔线--------------------------------------

local _UIText = {
}

function GuildWarBuffUI:Init(data)
	self.pathRes = "assetbundles/prefabs/ui/guild/guild_war/ui_3808_guild_war_buff.assetbundle"
	UiBaseClass.Init(self, data)
end

function GuildWarBuffUI:InitData(data)
    self.dc  = g_dataCenter.guildWar
	UiBaseClass.InitData(self, data)    
end

function GuildWarBuffUI:DestroyUi()    
	UiBaseClass.DestroyUi(self)    
end

function GuildWarBuffUI:RegistFunc()
	UiBaseClass.RegistFunc(self)
	self.bindfunc["on_btn_close"] = Utility.bind_callback(self, self.on_btn_close)
    self.bindfunc["on_btn_buy"] = Utility.bind_callback(self, self.on_btn_buy);
    self.bindfunc["gc_buy_buff_ret"] = Utility.bind_callback(self, self.gc_buy_buff_ret);
end

function GuildWarBuffUI:MsgRegist()
    UiBaseClass.MsgRegist(self);
    PublicFunc.msg_regist(msg_guild_war.gc_buy_buff_ret,self.bindfunc["gc_buy_buff_ret"]);
end

function GuildWarBuffUI:MsgUnRegist()
    UiBaseClass.MsgUnRegist(self);
    PublicFunc.msg_unregist(msg_guild_war.gc_buy_buff_ret,self.bindfunc["gc_buy_buff_ret"]);
end

function GuildWarBuffUI:InitUI(asset_obj)
	UiBaseClass.InitUI(self, asset_obj)
	self.ui:set_name("GuildWarBuffUI")

    local btnClose = ngui.find_button(self.ui, "centre_other/animation/btn_close")
    btnClose:set_on_click(self.bindfunc["on_btn_close"])   

    self.buffList = {}
    for i = 1, 3 do
        self.buffList[i] = {};
        self.buffList[i].lab = ngui.find_label(self.ui,"centre_other/animation/cont2/cont"..i.."/sp_bg/lbl_v");
        self.buffList[i].tex = ngui.find_sprite(self.ui,"centre_other/animation/cont2/cont"..i.."/sp_buff_ico");
    end

    self.costList = {};
    for i = 1, 2 do
        self.costList[i] = {};
        self.costList[i].labCost = ngui.find_label(self.ui,"centre_other/animation/cont3/cont"..i.."/sp_bg1/lbl_v");
        self.costList[i].labCostTimes = ngui.find_label(self.ui,"centre_other/animation/cont3/cont"..i.."/lab");
        self.costList[i].objFx = self.ui:get_child_by_name("centre_other/animation/cont3/cont"..i.."/fx_ui_2814_guild_juanxian");
        self.costList[i].btn = ngui.find_button(self.ui,"centre_other/animation/cont3/cont"..i.."/btn1");
        self.costList[i].btn:set_on_click(self.bindfunc["on_btn_buy"]);
        self.costList[i].btn:set_event_value("",i);
    end

    self:UpdateUi();
 end

 function GuildWarBuffUI:UpdateUi()
    if not UiBaseClass.UpdateUi(self) then
        return;
    end
    local cfg = ConfigManager.Get(EConfigIndex.t_guild_war_discrete,1);
    local buffInfo = 
    {
        {texture=cfg.crit_icon, value=cfg.crit_value, attrName="暴击："},
        {texture=cfg.attack_icon, value=cfg.attack_value, attrName="攻击："},
        {texture=cfg.defense_icon, value=cfg.defense_value, attrName="防御："},
    }
    for k,v in pairs(self.buffList) do
        v.lab:set_text(buffInfo[k].attrName.."[7ACF0FFF]"..buffInfo[k].value);
        v.tex:set_sprite_name(buffInfo[k].texture);
    end
    local costInfo = self.dc:GetEncourageTimes();
    for k,v in pairs(self.costList) do
        local info = costInfo[k];
        v.labCost:set_text(""..info.costNum);
        v.labCostTimes:set_text("剩余购买次数：[7ACF0FFF]"..(info.maxTimes-info.curTimes).."/"..info.maxTimes.."[-]");
    end
end

function GuildWarBuffUI:update(dt)
    if self.fx_delay then
        if self.fx_delay <= 0 then
            if self.clickCostType then
                self.costList[self.clickCostType].objFx:set_active(true);
                self.clickCostType = nil;
                self.fx_delay = nil;
            end
        else
            self.fx_delay = self.fx_delay - 1;
        end
    end
end

function GuildWarBuffUI:on_btn_close()
    GuildWarBuffUI.End()
end

function GuildWarBuffUI:gc_buy_buff_ret()
    self:UpdateUi();
    if not self.oldBuffInfo then
        return ;
    end
    local buffType = 1;
    local newBuffInfo = self.dc:GetBuffLv()[1];
    for k,v in pairs(self.oldBuffInfo) do
        if newBuffInfo[k] ~= v then
            buffType = k;
        end
    end

    local cfg = ConfigManager.Get(EConfigIndex.t_guild_war_discrete,1);
    local buffInfo = 
    {
        {value=cfg.crit_value, attrName="暴击"},
        {value=cfg.attack_value, attrName="攻击"},
        {value=cfg.defense_value, attrName="防御"},
    }
    str = buffInfo[buffType].attrName..buffInfo[buffType].value;
    FloatTip.Float(str);
    self.fx_delay = 2;
    self.oldBuffInfo = nil;
end

function GuildWarBuffUI:on_btn_buy(t)
    local costType = t.float_value;
    msg_guild_war.cg_buy_buff(costType);
    self.oldBuffInfo = Utility.clone(self.dc:GetBuffLv()[1]);
    self.clickCostType = costType;
    self.costList[self.clickCostType].objFx:set_active(false);
end
