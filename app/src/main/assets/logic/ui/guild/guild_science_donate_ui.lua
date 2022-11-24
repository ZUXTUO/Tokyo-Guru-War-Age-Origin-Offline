GuildScienceDonateUI = Class("GuildScienceDonateUI", UiBaseClass);

function GuildScienceDonateUI:Init(data)
    self.pathRes = "assetbundles/prefabs/ui/guild/ui_2814_guild_juanxian.assetbundle";
    UiBaseClass.Init(self, data);
end

function GuildScienceDonateUI:InitData(data)
    UiBaseClass.InitData(self, data);
end

function GuildScienceDonateUI:Restart(data)
    self.scienceID = data.id;
    self.guildData = g_dataCenter.guild:GetDetail();
    if data.id ~= 0 then
        self.scienceCfg = ConfigManager.Get(EConfigIndex.t_guild_science,data.id);
        self.subitemCfg = ConfigManager.Get(EConfigIndex["t_"..self.scienceCfg.cfg],data.sub_id);
        self.subitemData = self.guildData:GetScienceInfo(data.id, self.subitemCfg.system_id);
        self.subitemType = self.subitemCfg.system_id;
    else
        self.subitemCfg = {system_id=0,cfg="guild_level",name="社团等级：",icon=self.guildData.icon}
        self.subitemData = {lv=self.guildData.level,exp=self.guildData.exp};
    end
    self.donateCfg = self.guildData:GetDonateCfg(self.subitemCfg.system_id);
    if #self.donateCfg == 0 then
        app.log_warning("没有可捐献方式。");
    end
    if UiBaseClass.Restart(self, data) then
    end
end

function GuildScienceDonateUI:RegistFunc()
    UiBaseClass.RegistFunc(self);
    self.bindfunc["on_init_item"] = Utility.bind_callback(self, self.on_init_item);
    self.bindfunc["on_click_donate"] = Utility.bind_callback(self, self.on_click_donate);
    self.bindfunc["gc_guild_tech_donate"] = Utility.bind_callback(self, self.gc_guild_tech_donate);
    self.bindfunc["on_close"] = Utility.bind_callback(self, self.on_close);
end

function GuildScienceDonateUI:MsgRegist()
    UiBaseClass.MsgRegist(self);
    PublicFunc.msg_regist(msg_guild.gc_guild_tech_donate,self.bindfunc["gc_guild_tech_donate"]);
end

function GuildScienceDonateUI:MsgUnRegist()
    UiBaseClass.MsgUnRegist(self);
    PublicFunc.msg_unregist(msg_guild.gc_guild_tech_donate,self.bindfunc["gc_guild_tech_donate"]);
end

function GuildScienceDonateUI:InitUI(asset_obj)
    UiBaseClass.InitUI(self, asset_obj);

    self.spIcon = ngui.find_sprite(self.ui,"center_other/animation/sp_title2");
    self.labName = ngui.find_label(self.ui,"center_other/animation/lab_title");
    self.labLv = ngui.find_label(self.ui,"center_other/animation/txt_titile_big");
    self.texRoot = self.ui:get_child_by_name("center_other/animation/new_big_card_item");
    self.texIcon = ngui.find_texture(self.ui,"center_other/animation/new_big_card_item/texture");
    self.labDonateTimes = ngui.find_label(self.ui,"center_other/animation/lab_ci_shu/lab");

    self.pro = ngui.find_progress_bar(self.ui,"center_other/animation/progress_bar");
    self.labPro = ngui.find_label(self.ui,"center_other/animation/progress_bar/lab_word");

    self.cont = {};
    self.wrap = ngui.find_wrap_content(self.ui,"center_other/animation/sco_view/panel/wrap_cont");
    self.wrap:set_on_initialize_item(self.bindfunc["on_init_item"]);
    self.scroll = ngui.find_scroll_view(self.ui,"center_other/animation/sco_view/panel");

    self.grid = self.ui:get_child_by_name("center_other/animation/cont2");

    local obj = self.ui:get_child_by_name("center_other/animation/sco_view");
    obj:set_active(true);

    local btnFork = ngui.find_button(self.ui,"center_other/animation/btn_cha");
    btnFork:set_on_click(self.bindfunc["on_close"]);

    self:UpdateUi();
end

function GuildScienceDonateUI:UpdateUi()
    if not UiBaseClass.UpdateUi(self) then
        return;
    end
    if self.scienceID ~= 0 then
        self.subitemData = self.guildData:GetScienceInfo(self.scienceID, self.subitemType);
    else
        self.subitemData = {lv=self.guildData.level,exp=self.guildData.exp};
    end
    local lv = self.subitemData.lv or 1
    if self.scienceID == 0 then
        config = ConfigManager.Get(EConfigIndex.t_guild_icon,self.subitemCfg.icon)
        if config then
            self.texIcon:set_texture(config.icon);
            self.texRoot:set_active(true);
        else
            self.texRoot:set_active(false);
        end
        self.spIcon:set_active(false);
    else
        self.spIcon:set_sprite_name(self.subitemCfg.icon);
        self.spIcon:set_active(true);
        self.texRoot:set_active(false);
    end
    self.labName:set_text(self.subitemCfg.name);
    self.labLv:set_text("Lv."..lv);
    local curTimes = self.guildData.donateTimes or 0;
    local maxTimes = ConfigManager.Get(EConfigIndex.t_discrete,MsgEnum.ediscrete_id.eDiscreteID_guild_donate_day_times).data;
    if curTimes <= 0 then
        self.labDonateTimes:set_text("[E34D62FF]"..curTimes.."/"..maxTimes.."[-]");
    else
        self.labDonateTimes:set_text("[00FF73FF]"..curTimes.."/"..maxTimes.."[-]");
    end

    local lvCfg = ConfigManager.Get(EConfigIndex["t_"..self.subitemCfg.cfg],lv);
    local curExp = self.subitemData.exp or 0;
    local maxExp = lvCfg.exp;
    self.labPro:set_text("[974D04FF]"..curExp.."[-][7463C9FF]/"..maxExp.."[-]");
    self.pro:set_value(curExp/maxExp);

    if #self.donateCfg > 2 then
        self.scroll:set_active(true);
        self.grid:set_active(false);
        self.wrap:set_min_index(0);
        self.wrap:set_max_index(#self.donateCfg-1);
        self.wrap:reset();
        self.scroll:reset_position();
    else
        self.scroll:set_active(false);
        self.grid:set_active(true);
        if not self.cont2 then
            self.cont2 = {};
            for i=1,2 do
                self.cont2[i] = {};
                self.cont2[i].root = self.ui:get_child_by_name("center_other/animation/cont2/cont"..i);
                self:_InitItem(self.cont2[i], self.cont2[i].root);
            end
        end
        for i=1,2 do
            self:_SetItem(self.cont2[i], i);
        end
    end
end

function GuildScienceDonateUI:DestroyUi()
    UiBaseClass.DestroyUi(self);
    self.cont2 = nil;
end

function GuildScienceDonateUI:_InitItem(cont, obj)
    cont.labTitle = ngui.find_label(obj,"sp_big_bk1/lab_title");
    cont.spBg = ngui.find_sprite(obj,"sp_big_bk1");
    cont.labExp = ngui.find_label(obj,"sp_big_bk1/sp_di1/lab_exp/lab_num");
    cont.labGoods = ngui.find_label(obj,"sp_big_bk1/sp_di1/lab_token");
    cont.spGoods = ngui.find_sprite(obj,"sp_big_bk1/sp_di2/sp_gold");
    cont.spGen = ngui.find_sprite(obj,"sp_big_bk1/sp_di2/sp_gem");
    cont.labCost = ngui.find_label(obj,"sp_big_bk1/sp_di2/txt_gold");
    cont.btn = ngui.find_button(obj,"sp_big_bk1/btn2");
    cont.btn:set_on_click(self.bindfunc["on_click_donate"]);
    -- cont.labBtn = ngui.find_label(obj,"sp_big_bk1/btn2/animation/lab");
    -- cont.sp = ngui.find_sprite(obj,"sp_big_bk1/btn2/animation/sp");
    cont.fx = obj:get_child_by_name("sp_big_bk1/fx_ui_2814_guild_juanxian");
    cont.fx:set_active(false);
    return cont;
end

local ETitleColor=
{
    {r=32/255,g=93/255,b=165/255,a=1},  -- 205DA5FF
    {r=136/255,g=19/255,b=81/255,a=1},  -- 881351FF
    {r=175/255,g=83/255,b=24/255,a=1}, -- AF5318FF
}

function GuildScienceDonateUI:_SetItem(cont, index, b)
    local cfg = self.donateCfg[index];
    if cfg then
        cont.spBg:set_active(true);
        cont.labTitle:set_text(cfg.title_name);
        cont.labTitle:set_effect_color(ETitleColor[index].r,ETitleColor[index].g,ETitleColor[index].b,ETitleColor[index].a);
        cont.spBg:set_sprite_name(cfg.bg_name);
        cont.labExp:set_text(string.format("+%d",cfg.exp));
        cont.labGoods:set_text("+"..tostring(cfg.contribution));
        if cfg.item_id == 2 then
            cont.spGoods:set_active(true);
            cont.spGen:set_active(false);
        elseif cfg.item_id == 3 then
            cont.spGoods:set_active(false);
            cont.spGen:set_active(true);
        else
            cont.spGoods:set_active(false);
            cont.spGen:set_active(false);
            app.log_warning("guild_tech_donate中配置的道具id错误。id："..cfg.item_id);
        end
        cont.labCost:set_text(tostring(cfg.item_num));
        cont.btn:set_event_value(""..b,cfg.id);
        local curTimes = self.guildData.donateTimes or 0;
        if curTimes <= 0 then
            PublicFunc.SetButtonShowMode(cont.btn, 3, "sp", "lab")
            -- cont.sp:set_color(0,0,0,1);
            -- cont.labBtn:set_effect_color(139/255,139/255,139/255,1);
        else
            PublicFunc.SetButtonShowMode(cont.btn, 1, "sp", "lab")
            -- cont.sp:set_color(1,1,1,1);
            -- cont.labBtn:set_effect_color(174/255,65/255,40/255,1);
        end
    else
        cont.spBg:set_active(false);
    end
end

function GuildScienceDonateUI:on_init_item(obj, b, real_id)
    local index = math.abs(real_id)+1;
    local cont = self.cont[b] or {};
    if Utility.isEmpty(cont) then
        self.cont[b] = self:_InitItem(cont, obj);
    end
    self:_SetItem(self.cont[b], index, b);
end

function GuildScienceDonateUI:on_click_donate(t)
    local index = t.float_value;
    self.clickIndex = tonumber(t.string_value);
    self.cont[self.clickIndex].fx:set_active(false);
    local cfg = ConfigManager.Get(EConfigIndex.t_guild_tech_donate, index);
    if cfg.item_id == 2 then
        if g_dataCenter.player.gold < cfg.item_num then
            FloatTip.Float("金币不足");
            return;
        end
    elseif cfg.item_id == 3 then
        if g_dataCenter.player.crystal < cfg.item_num then
            FloatTip.Float("钻石不足");
            return;
        end
    else
        app.log_warning("guild_tech_donate中配置的道具id错误。id："..cfg.item_id);
        return;
    end
    msg_guild.cg_guild_tech_donate(index);
end

-- function GuildScienceDonateUI:on_navbar_back()
--     if self.scienceID == 0 then
--         local ui = uiManager:ReplaceUi(EUI.GuildScienceUI);
--     else
--         local ui = uiManager:ReplaceUi(EUI.GuildScienceSubitemUI,{id=self.scienceID});
--     end
--     return true;
-- end

function GuildScienceDonateUI:UpdateSceneInfo()
    self:UpdateUi();
end

function GuildScienceDonateUI:Update(dt)
    UiBaseClass.Update(self,dt);
    if self.fx_delay then
        if self.fx_delay <= 0 then
            if self.clickIndex then
                self.cont[self.clickIndex].fx:set_active(true);
                self.clickIndex = nil;
                self.fx_delay = nil;
            end
        else
            self.fx_delay = self.fx_delay - 1;
        end
    end
end

function GuildScienceDonateUI:gc_guild_tech_donate(ret, id , addExp, addContribution, newLevelInfo)
    self.fx_delay = 2;
    g_dataCenter.guild:UpdateScienceInfo(self.scienceID, newLevelInfo.type, newLevelInfo.level, newLevelInfo.curExp);
    local str;
    if addExp ~= 0 then
        str= "社团经验提升"..addExp;
    end
    local buf;
    if addContribution ~= 0 then
        buf = "社团贡献增加"..addContribution;
    end
    if buf then
        if str then
            str = str.."\n"..buf;
        else
            str = buf;
        end
    end
    if str then
        FloatTip.Float(str);
    end
    AudioManager.Play3dAudio(ENUM.EUiAudioType.DonationSuccess, AudioManager.GetUiAudioSourceNode(), true)
    self:UpdateUi();
end

function GuildScienceDonateUI:on_close()
    uiManager:PopUi();
end
