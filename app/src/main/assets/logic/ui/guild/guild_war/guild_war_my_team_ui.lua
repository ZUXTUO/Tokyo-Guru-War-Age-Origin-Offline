
GuildWarMyTeamUI = Class('GuildWarMyTeamUI', UiBaseClass)

local _UIText = {
    [1] = "可用",
    [2] = "防守中",
    [3] = "进攻中",
}

function GuildWarMyTeamUI.Start()
    if GuildWarMyTeamUI.cls == nil then
        GuildWarMyTeamUI.cls = GuildWarMyTeamUI:new()
    end
end

function GuildWarMyTeamUI.End()
    if GuildWarMyTeamUI.cls then
        GuildWarMyTeamUI.cls:DestroyUi()
        GuildWarMyTeamUI.cls = nil
    end
end

---------------------------------------华丽的分隔线--------------------------------------

function GuildWarMyTeamUI:Init(data)
	self.pathRes = "assetbundles/prefabs/ui/guild/guild_war/ui_3809_guild_war.assetbundle"
	UiBaseClass.Init(self, data)
end

function GuildWarMyTeamUI:InitData(data)
    self.isOpenFlag = false
    self.dc = g_dataCenter.guildWar
	UiBaseClass.InitData(self, data)    
end

function GuildWarMyTeamUI:DestroyUi()    
    for _, v in pairs(self.teamUi) do
        for _, smallCard in pairs(v.smallCards) do
            if smallCard then
                smallCard:DestroyUi()
                smallCard = nil
            end
        end
    end
	UiBaseClass.DestroyUi(self)    
end

function GuildWarMyTeamUI:RegistFunc()
	UiBaseClass.RegistFunc(self)
    self.bindfunc["on_play_animation"] = Utility.bind_callback(self, self.on_play_animation)
    self.bindfunc["update_ui"] = Utility.bind_callback(self, self.update_ui)
    self.bindfunc["on_click_item"] = Utility.bind_callback(self, self.on_click_item) 
    self.bindfunc["on_choose_hero"] = Utility.bind_callback(self, self.on_choose_hero) 

    self.bindfunc["gc_get_my_team_ret"] = Utility.bind_callback(self, self.gc_get_my_team_ret)    
end

function GuildWarMyTeamUI:MsgRegist()
	UiBaseClass.MsgRegist(self)  
    --我队伍数据返回/更新驻防数据/取消驻防  
    PublicFunc.msg_regist(msg_guild_war.gc_get_my_team_ret, self.bindfunc['gc_get_my_team_ret'])
end

function GuildWarMyTeamUI:MsgUnRegist()
	UiBaseClass.MsgUnRegist(self);
    PublicFunc.msg_unregist(msg_guild_war.gc_get_my_team_ret, self.bindfunc['gc_get_my_team_ret']) 
end

function GuildWarMyTeamUI:InitUI(asset_obj)
	UiBaseClass.InitUI(self, asset_obj)
	self.ui:set_name("ui_guild_war_my_team")
        
    local aniPath = "centre_other/animation/"   
    local path = aniPath .. "sp_di/"

    self.spTeamIcon = ngui.find_sprite(self.ui, path .. "btn/sp_1")
    self.aniObj = self.ui:get_child_by_name(aniPath)

    local btnTeam = ngui.find_button(self.ui, path .. "btn")
    btnTeam:set_on_click(self.bindfunc["on_play_animation"])
    
    self.teamUi = {}     
    for i = 1, 3 do
        local contPath = path .. "cont" .. i
        local btnItem = ngui.find_button(self.ui, contPath)
        btnItem:set_event_value("", i)
        btnItem:set_on_click(self.bindfunc["on_click_item"])

        local temp = {}      
        temp.spTitle = ngui.find_sprite(self.ui, contPath .. "/sp_title")
        temp.lblTitle = ngui.find_label(self.ui, contPath .. "/sp_title/lab2")
        --头像
        temp.smallCards = {}
        for j = 1, 3 do 
            local smallCard = SmallCardUi:new(
            {   
                parent = self.ui:get_child_by_name(contPath .. "/new_small_card_item" .. j),
                info = nil,
                sgroup = 4,	
			    isShine	= false		
            })
            smallCard:SetCallback(self.bindfunc["on_choose_hero"])
            smallCard:SetParam(i)
            temp.smallCards[j] = smallCard
        end
        self.teamUi[i] = temp
    end

    self:gc_get_my_team_ret()
end

function GuildWarMyTeamUI:gc_get_my_team_ret()
    if self.teamUi == nil then
        return
    end

    for i = 1, 3 do
        local _ui = self.teamUi[i]
        local info = self.dc:GetMyTeamInfo(i)
        if info ~= nil then
            --英雄
            local data = info.heros
            local tempData = {}
            for j = 1, 3 do
                if data[j] ~= nil then
                    table.insert(tempData, {id = data[j].dataid, hp = data[j].hp})                    
                end
            end
            for k = 1, 3 do                
                local cardInfo = nil
                if tempData[k] ~= nil then
                    cardInfo = g_dataCenter.package:find_card(ENUM.EPackageType.Hero, tempData[k].id)
                end
                local smallCard = _ui.smallCards[k]
                smallCard:SetData(cardInfo)

                smallCard:SetDead(false)
                smallCard:SetLifeBar(false)
                if cardInfo ~= nil then
                    if self.dc:IsDefenceOrIntervalPhase() then
                    else
                        --血量
                        local _proValue = nil          
                        local currHp = tempData[k].hp
                        local maxHp = cardInfo:GetPropertyVal(ENUM.EHeroAttribute.max_hp)
                        --初始化血量为-1
                        if currHp == - 1 or currHp > maxHp  then
                            _proValue = 1
                        else
                            _proValue = currHp / maxHp
                        end
                        --app.log('==========>_proValue =  ' .. _proValue)
                        smallCard:SetDead(_proValue == 0)      
                        smallCard:SetGray(_proValue == 0)                                 
                        smallCard:SetLifeBar(true, _proValue)
                    end
                end
            end
        else
            for k = 1, 3 do
                local smallCard = _ui.smallCards[k]
                smallCard:SetData(nil)
                smallCard:SetDead(false)      
                smallCard:SetLifeBar(false)
            end
        end

        --标签
        if info == nil then
            _ui.spTitle:set_sprite_name("stz_biaoqian_lan")
            _ui.lblTitle:set_text(_UIText[1])
        else
            _ui.spTitle:set_sprite_name("stz_biaoqian_huang")
            if info.isAttack == 0 then
                _ui.lblTitle:set_text(_UIText[2])
            elseif info.isAttack == 2 then
                _ui.lblTitle:set_text(_UIText[3])
            end
        end
    end
end

--[[播放动画]]
function GuildWarMyTeamUI:on_play_animation()
    if self.isOpenFlag then        
        self.spTeamIcon:set_sprite_name("stz_anniu_zhankai")
        self.aniObj:animated_play("guild_war_animation_right")
    else
        self.spTeamIcon:set_sprite_name("stz_anniu_shouhui")
        self.aniObj:animated_play("guild_war_animation_left")        
    end    
    self.isOpenFlag = not self.isOpenFlag    
end

function GuildWarMyTeamUI:on_click_item(t)
    local info = self.dc:GetMyTeamInfo(t.float_value)
    if info == nil or info.nodeId == nil then
        return
    end  
    --app.log('================>on_click_item  nodeId = ' .. info.nodeId)
    PublicFunc.msg_dispatch("guild_war_show_node_positioin_zoom_in", info.nodeId)
end

function GuildWarMyTeamUI:on_choose_hero(obj, info, pos)
    self:on_click_item({float_value = pos})
end