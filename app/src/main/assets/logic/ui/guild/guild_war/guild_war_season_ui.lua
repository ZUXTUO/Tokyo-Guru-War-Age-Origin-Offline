
GuildWarSeasonUI = Class('GuildWarSeasonUI', UiBaseClass)

local _UIText = {
    [1] = "第%s赛季社团战",
    [2] = "黄金%s阶",
    [3] = "第%s名",
}

function GuildWarSeasonUI.Start()
    if GuildWarSeasonUI.cls == nil then
        GuildWarSeasonUI.cls = GuildWarSeasonUI:new()
    end
end

function GuildWarSeasonUI.End()
    if GuildWarSeasonUI.cls then
        GuildWarSeasonUI.cls:DestroyUi()
        GuildWarSeasonUI.cls = nil
    end
end

---------------------------------------华丽的分隔线--------------------------------------

function GuildWarSeasonUI:Init(data)
	self.pathRes = "assetbundles/prefabs/ui/guild/guild_war/ui_3806_guild_war.assetbundle"
	UiBaseClass.Init(self, data)
end

function GuildWarSeasonUI:InitData(data)
	UiBaseClass.InitData(self, data) 
    self.dc = g_dataCenter.guildWar   
end

function GuildWarSeasonUI:DestroyUi()    
    if self.textGuild then
        self.textGuild:Destroy()
        self.textGuild = nil
    end
	UiBaseClass.DestroyUi(self)    
end

function GuildWarSeasonUI:RegistFunc()
	UiBaseClass.RegistFunc(self)
	self.bindfunc["on_btn_close"] = Utility.bind_callback(self, self.on_btn_close)
end

function GuildWarSeasonUI:on_btn_close()
    GuildWarSeasonUI.End()
    PublicFunc.msg_dispatch("guild_war_on_handle_phase_tip")
end

function GuildWarSeasonUI:InitUI(asset_obj)
	UiBaseClass.InitUI(self, asset_obj)
	self.ui:set_name("ui_guild_war_season")
    local path = "centre_other/animation/"

    local btnClose = ngui.find_button(self.ui, path .. "btn_close")
    btnClose:set_on_click(self.bindfunc["on_btn_close"]) 
    
    --赛季日期
    local seasonInfo = self.dc:GetSeasonInfo()
    local lblSeasonName = ngui.find_label(self.ui, path .. "lbl1")
    lblSeasonName:set_text(string.format(_UIText[1], seasonInfo.season))

    local lblSeasonTime = ngui.find_label(self.ui, path .. "lbl2")
    local timeStr = self:GetDateString(seasonInfo)
    lblSeasonTime:set_text(timeStr)

    --社团
    local detail = g_dataCenter.guild:GetDetail()
    self.textGuild = ngui.find_texture(self.ui, path .. "cont1/texture_ico")
    local config = ConfigManager.Get(EConfigIndex.t_guild_icon, detail.icon)
    self.textGuild:set_texture(config.icon)
    
    local lblGuildName = ngui.find_label(self.ui, path .. "cont1/lbl_guild_name")
    lblGuildName:set_text(detail.name)

    local lblGuildLevel = ngui.find_label(self.ui, path .. "cont1/lbl_guild_level")
    lblGuildLevel:set_text("LV." .. detail.level)

    --社团段位
    local danConfig = ConfigManager.Get(EConfigIndex.t_guild_war_dan, seasonInfo.dan)
    if danConfig then
        local spPhase = ngui.find_sprite(self.ui, path .. "cont1/sp_ico")
        spPhase:set_sprite_name(danConfig.icon)
        local lblPhase = ngui.find_label(self.ui, path .. "cont1/lbl1")
        lblPhase:set_text(danConfig.name)
    end
    if seasonInfo.danRanking then
        local lblRank = ngui.find_label(self.ui, path .. "cont1/lbl2")
        lblRank:set_text(string.format(_UIText[3], seasonInfo.danRanking))
    end
end

function GuildWarSeasonUI:GetDateString(seasonInfo)
    local year, month, day = TimeAnalysis.ConvertToYearMonDay(seasonInfo.beginTime)
    local beginTimeStr = year .. '.' .. month .. '.' .. day

    year, month, day = TimeAnalysis.ConvertToYearMonDay(seasonInfo.endTime)
    local endTimeStr = year .. '.' .. month .. '.' .. day
    return beginTimeStr .. " - " .. endTimeStr
end