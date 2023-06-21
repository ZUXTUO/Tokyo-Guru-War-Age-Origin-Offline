GuildScienceUI = Class("GuildScienceUI", UiBaseClass);

function GuildScienceUI.GetUiNode(id)
    return GuildScienceUI.idToUiNode[id];
end

function GuildScienceUI:Init(data)
    self.pathRes = "assetbundles/prefabs/ui/guild/ui_2809_guild_homepage.assetbundle";
    UiBaseClass.Init(self, data);
end

function GuildScienceUI:InitData(data)
    self.contItem = nil;
    self.scienceCfg = ConfigManager._GetConfigTable(EConfigIndex.t_guild_science);
	UiBaseClass.InitData(self, data);
end

function GuildScienceUI:Restart(data)
    msg_guild.cg_sync_guild_level_info();
    self.guildData = g_dataCenter.guild:GetDetail();
    self.contItem = {};
	if UiBaseClass.Restart(self, data) then
    end
end

function GuildScienceUI:RegistFunc()
	UiBaseClass.RegistFunc(self);
    self.bindfunc["on_init_item"] = Utility.bind_callback(self, self.on_init_item);
    self.bindfunc["on_click_item"] = Utility.bind_callback(self, self.on_click_item);
    self.bindfunc["on_donate"] = Utility.bind_callback(self, self.on_donate);
    self.bindfunc["gc_sync_guild_level_info"] = Utility.bind_callback(self, self.gc_sync_guild_level_info);
    self.bindfunc["gc_guild_donate"] = Utility.bind_callback(self, self.gc_guild_donate);
end

function GuildScienceUI:MsgRegist()
    UiBaseClass.MsgRegist(self);
    PublicFunc.msg_regist(msg_guild.gc_sync_guild_level_info,self.bindfunc["gc_sync_guild_level_info"]);
    PublicFunc.msg_regist(msg_guild.gc_guild_donate,self.bindfunc["gc_guild_donate"]);
end

function GuildScienceUI:MsgUnRegist()
    UiBaseClass.MsgUnRegist(self);
    PublicFunc.msg_unregist(msg_guild.gc_sync_guild_level_info,self.bindfunc["gc_sync_guild_level_info"]);
    PublicFunc.msg_unregist(msg_guild.gc_guild_donate,self.bindfunc["gc_guild_donate"]);
end

function GuildScienceUI:InitUI(asset_obj)
    UiBaseClass.InitUI(self, asset_obj);
    self.ui:set_name("guild_science_ui")

    self.labGuildLv = ngui.find_label(self.ui,"center_other/animation/cont_top/lab_level");

    self.labGuildExp = ngui.find_label(self.ui,"center_other/animation/cont_top/bar1/lab_num");
    self.proGuildExp = ngui.find_progress_bar(self.ui,"center_other/animation/cont_top/bar1/pro_bar_bk");

    self.labGuildDayExp = ngui.find_label(self.ui,"center_other/animation/cont_top/bar2/lab_num");
    self.proGuildDayExp = ngui.find_progress_bar(self.ui,"center_other/animation/cont_top/bar2/pro_bar_bk");

    self.labDonateTimes = ngui.find_label(self.ui,"center_other/animation/cont_top/lab_num");
    self.btnDonate = ngui.find_button(self.ui,"center_other/animation/cont_top/btn1");
    self.btnDonate:set_on_ngui_click(self.bindfunc["on_donate"]);
    -- self.spDonatePoint = ngui.find_sprite(self.ui,"center_other/animation/cont_top/btn1/animation/sp_point");

    self.scroll = ngui.find_scroll_view(self.ui,"center_other/animation/sco_view/panel");
    self.wrap = ngui.find_wrap_content(self.ui,"center_other/animation/sco_view/panel/wrap_cont");
    self.wrap:set_on_initialize_item(self.bindfunc["on_init_item"]);

    self:UpdateUi();
end

function GuildScienceUI:UpdateUi()
	if not UiBaseClass.UpdateUi(self) then
        return;
    end
    local guildLv = self.guildData.level or 1;
    self.labGuildLv:set_text("社团等级:[00FF73FF]"..guildLv.."[-]");

    local guildLvCfg = ConfigManager.Get(EConfigIndex.t_guild_level,guildLv)
    local curGuildExp = self.guildData.exp or 0;
    local maxGuildExp = guildLvCfg.exp
    self.labGuildExp:set_text("[974D04FF]"..curGuildExp.."[-][7463C9FF]/"..maxGuildExp.."[-]");
    self.proGuildExp:set_value(curGuildExp/maxGuildExp);

    local curGuildDayExp = self.guildData.todayGrowExp or 0;
    local maxGuildDayExp = guildLvCfg.everyday_exp_limit;
    self.labGuildDayExp:set_text("[974D04FF]"..curGuildDayExp.."[-][7463C9FF]/"..maxGuildDayExp.."[-]");
    self.proGuildDayExp:set_value(curGuildDayExp/maxGuildDayExp);

    local curTimes = self.guildData.donateTimes or 0;
    local maxTimes = ConfigManager.Get(EConfigIndex.t_discrete,MsgEnum.ediscrete_id.eDiscreteID_guild_donate_day_times).data;
    if curTimes <= 0 then
        PublicFunc.SetButtonShowMode(self.btnDonate, 3, "sp", "lab");
        self.labDonateTimes:set_text("捐献次数:[E34D62FF]"..curTimes.."/"..maxTimes.."[-]");
    else
        PublicFunc.SetButtonShowMode(self.btnDonate, 1, "sp", "lab");
        self.labDonateTimes:set_text("捐献次数:[00FF73FF]"..curTimes.."/"..maxTimes.."[-]");
    end
    -- if self.guildData:CanScienceSubDonate(0, true) then
    --     self.spDonatePoint:set_active(true);
    -- else
    --     self.spDonatePoint:set_active(false);
    -- end
    GuildScienceUI.idToUiNode = {};
    GuildScienceUI.indexToid = {};
    self.wrap:set_min_index(1-#self.scienceCfg);
    self.wrap:set_max_index(0);
    self.wrap:reset();
    self.scroll:reset_position();
end

function GuildScienceUI:Show()
    UiBaseClass.Show(self);
    msg_guild.cg_sync_guild_level_info();
end

function GuildScienceUI:on_init_item(obj, b, real_id)
    local index = math.abs(real_id)+1;
    local cont = self.contItem[b] or {};
    if Utility.isEmpty(cont) then
        cont.btn = ngui.find_button(obj,obj:get_name());
        cont.btn:set_on_click(self.bindfunc["on_click_item"]);
        cont.spLock = obj:get_child_by_name("sp_view");
        cont.sp = obj:get_child_by_name("lab_go");
        cont.tex = ngui.find_texture(obj,"texture_bk");
        cont.labTitle = ngui.find_label(obj,"lab_name");
        cont.spPoint = ngui.find_sprite(obj,"sp_point");
        self.contItem[b] = cont;
    end
    local cfg = self.scienceCfg[index];
    local open_lv = cfg.guild_level;
    if open_lv > self.guildData.level then
        cont.spLock:set_active(true);
        cont.sp:set_active(false);
    else
        cont.spLock:set_active(false);
        cont.sp:set_active(true);
    end
    if GuildScienceUI.indexToid[b] then
        local id = GuildScienceUI.indexToid[b];
        GuildScienceUI.idToUiNode[id] = nil;
        GuildScienceUI.indexToid[b] = nil;
    end
    GuildScienceUI.indexToid[b] = index;
    GuildScienceUI.idToUiNode[index] = cont.spPoint;
    -- if self.guildData:CanScienceSubDonate(index, true) then
    --     cont.spPoint:set_active(true);
    -- else
    --     cont.spPoint:set_active(false);
    -- end
    cont.btn:set_event_value("",index);
    cont.tex:set_texture(cfg.icon);
    cont.labTitle:set_text(cfg.name);
end

function GuildScienceUI:on_click_item(t)
    local id = t.float_value;
    local cfg = self.scienceCfg[id];
    local open_lv = cfg.guild_level;
    if open_lv > self.guildData.level then
        local des = cfg.tips;
        if des ~= "" then
            FloatTip.Float(des);
        else
            FloatTip.Float("暂未开放");
            app.log_warning("#lhf GuildScienceUI#没有配置未开启提示"..id);
        end
    else
        local ui = uiManager:ReplaceUi(EUI.GuildScienceSubitemUI,{id=id});
        self.guildData:IntoDonateUIFlg(true);
    end
end

function GuildScienceUI:on_donate()
    local curTimes = self.guildData.donateTimes or 0;
    if curTimes == 0 and g_dataCenter.gmCheat:getPlayLimit() then
        FloatTip.Float("今天的捐赠次数已用完");
    else
        local ui = uiManager:PushUi(EUI.GuildScienceDonateUI,{id=0});
        self.guildData:IntoDonateUIFlg(true);
    end
end

function GuildScienceUI:gc_sync_guild_level_info()
    self:UpdateUi();
end

function GuildScienceUI:gc_guild_donate()
    self:UpdateUi();
end

function GuildScienceUI:DestroyUi()
    UiBaseClass.DestroyUi(self)
    GuildScienceUI.idToUiNode = {};
    GuildScienceUI.indexToid = {};
end
