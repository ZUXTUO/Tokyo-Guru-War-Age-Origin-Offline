GuildScienceSubitemUI = Class("GuildScienceSubitemUI", UiBaseClass);

function GuildScienceSubitemUI:Init(data)
    self.pathRes = "assetbundles/prefabs/ui/guild/ui_2808_guild_study.assetbundle";
    UiBaseClass.Init(self, data);
end

function GuildScienceSubitemUI:InitData(data)
    UiBaseClass.InitData(self, data);
end

function GuildScienceSubitemUI:Restart(data)
    msg_guild.cg_sync_guild_tech_level_info(data.id);
    self.guildData = g_dataCenter.guild:GetDetail();
    self.scienceID = data.id;
    self.scienceCfg = ConfigManager.Get(EConfigIndex.t_guild_science,data.id);
    self.subitemListCfg = ConfigManager._GetConfigTable(EConfigIndex["t_"..self.scienceCfg.cfg]);
    if UiBaseClass.Restart(self, data) then
    end
end

function GuildScienceSubitemUI:RegistFunc()
    UiBaseClass.RegistFunc(self);
    self.bindfunc["on_init_item"] = Utility.bind_callback(self, self.on_init_item);
    self.bindfunc["on_donate"] = Utility.bind_callback(self, self.on_donate);
    self.bindfunc["gc_sync_guild_tech_level_info"] = Utility.bind_callback(self, self.gc_sync_guild_tech_level_info);
end

function GuildScienceSubitemUI:MsgRegist()
    UiBaseClass.MsgRegist(self);
    PublicFunc.msg_regist(msg_guild.gc_sync_guild_tech_level_info,self.bindfunc["gc_sync_guild_tech_level_info"]);
end

function GuildScienceSubitemUI:MsgUnRegist()
    UiBaseClass.MsgUnRegist(self);
    PublicFunc.msg_unregist(msg_guild.gc_sync_guild_tech_level_info,self.bindfunc["gc_sync_guild_tech_level_info"]);
end

function GuildScienceSubitemUI:InitUI(asset_obj)
    UiBaseClass.InitUI(self, asset_obj);

    self.labTitle = ngui.find_label(self.ui,"center_other/animation/cont_top/sp_bk/lab");
    self.texTitleBg = ngui.find_texture(self.ui,"center_other/animation/cont_top/sp_bk");
    self.labPlayDes = ngui.find_label(self.ui,"center_other/animation/cont_top/lab_top_right");
    self.labLevelDes = ngui.find_label(self.ui,"center_other/animation/cont_top/lab_down_right");

    self.contItem = {};
    self.wrap = ngui.find_wrap_content(self.ui,"center_other/animation/sco_view/panel/wrap_cont");
    self.wrap:set_on_initialize_item(self.bindfunc["on_init_item"]);
    self.scroll = ngui.find_scroll_view(self.ui,"center_other/animation/sco_view/panel");

    self:UpdateUi();
end

function GuildScienceSubitemUI:UpdateUi()
    if not UiBaseClass.UpdateUi(self) then
        return;
    end

    self.labTitle:set_text(self.scienceCfg.name);
    self.texTitleBg:set_texture(self.scienceCfg.small_icon);
    self.labPlayDes:set_text(self.scienceCfg.play_des);
    self.labLevelDes:set_text(self.scienceCfg.level_des);

    self.wrap:set_min_index(0);
    self.wrap:set_max_index(#self.subitemListCfg-1);
    self.wrap:reset();
    self.scroll:reset_position();
end

function GuildScienceSubitemUI:UpdateSceneInfo()
    self:UpdateUi();
end

function GuildScienceSubitemUI:on_init_item(obj, b, real_id)
    local index = math.abs(real_id)+1;
    local cont = self.contItem[b] or {};
    if Utility.isEmpty(cont) then
        cont.objLockRoot = obj:get_child_by_name("sp_art_font");
        cont.objRoot = obj:get_child_by_name("sp_frame1");
        cont.labName = ngui.find_label(cont.objRoot,"lab_hurt");
        cont.labLv = ngui.find_label(cont.objRoot,"lab_level");
        cont.spIcon = ngui.find_sprite(cont.objRoot,"sp_tu_biao");

        cont.labProExp = ngui.find_label(cont.objRoot,"pro_bar_di/lab_num");
        cont.proExp = ngui.find_progress_bar(cont.objRoot,"pro_bar_di");

        cont.labCurLvDes = ngui.find_label(cont.objRoot,"sp_kuang/lab_title1/lab_word");
        cont.labNextLvDes = ngui.find_label(cont.objRoot,"sp_kuang/lab_title2/lab_word");
        -- cont.spBtn = ngui.find_sprite(cont.objRoot,"btn_donate/animation/sp");
        -- cont.labBtn = ngui.find_label(cont.objRoot,"btn_donate/animation/lab");
        cont.btn = ngui.find_button(cont.objRoot,"btn_donate");
        cont.btn:set_on_click(self.bindfunc["on_donate"]);
        self.contItem[b] = cont;
    end
    local InfoCfg = self.subitemListCfg[index];
    local open_lv = InfoCfg.guild_level;
    if open_lv > self.guildData.level then
        cont.objLockRoot:set_active(true);
        cont.objRoot:set_active(false);
    else
        cont.objLockRoot:set_active(false);
        cont.objRoot:set_active(true);
        local info = self.guildData:GetScienceInfo(self.scienceID, InfoCfg.system_id);
        local lv = info.lv or 1;
        local lvCfg = ConfigManager.Get(EConfigIndex["t_"..InfoCfg.cfg],lv);
        cont.labName:set_text(InfoCfg.name);
        cont.labLv:set_text("等级:"..lv);
        cont.spIcon:set_sprite_name(InfoCfg.icon);

        local curExp = info.exp or 0;
        local maxExp = lvCfg.exp;
        cont.labProExp:set_text("[974D04FF]"..curExp.."[-][7463C9FF]/"..maxExp.."[-]");
        cont.proExp:set_value(curExp/maxExp);

        local formatDes = InfoCfg.des;
        cont.labCurLvDes:set_text(PublicFunc.FormatString(formatDes,{lvCfg["param"..1],lvCfg["param"..2]}))
        local nextLvCfg = ConfigManager.Get(EConfigIndex["t_"..InfoCfg.cfg],lv+1);
        if nextLvCfg then
            cont.labNextLvDes:set_text(PublicFunc.FormatString(formatDes,{nextLvCfg["param"..1],nextLvCfg["param"..2]}));
        else
            cont.labNextLvDes:set_text("已达到最高等级");
        end
        local curTimes = self.guildData.donateTimes or 0;
        if curTimes == 0 then
            PublicFunc.SetButtonShowMode(cont.btn, 3, "sp", "lab");
            -- cont.spBtn:set_color(0,0,0,1);
            -- cont.labBtn:set_effect_color(139/255,139/255,139/255,1);
        else
            PublicFunc.SetButtonShowMode(cont.btn, 1, "sp", "lab");
            -- cont.spBtn:set_color(1,1,1,1);
            -- cont.labBtn:set_effect_color(174/255,65/255,40/255,1);
        end
        cont.btn:set_event_value("",index);
    end
end

function GuildScienceSubitemUI:on_donate(t)
    local curTimes = self.guildData.donateTimes or 0;
    if curTimes == 0 and g_dataCenter.gmCheat:getPlayLimit() then
        FloatTip.Float("今天的捐赠次数已用完");
    else
        local index = t.float_value;
        local data = {id=self.scienceID,sub_id=index};
        local ui = uiManager:PushUi(EUI.GuildScienceDonateUI,data);
    end
end

function GuildScienceSubitemUI:gc_sync_guild_tech_level_info()
    self:UpdateUi();
end

function GuildScienceSubitemUI:DestroyUi()
    UiBaseClass.DestroyUi(self);
end

function GuildScienceSubitemUI:on_navbar_back()
    uiManager:ReplaceUi(EUI.GuildScienceUI);
    return true;
end
