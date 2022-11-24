
local _UIText = {
    [1] = "无法驻防, 此据点队伍已达上限",
    [2] = "战力 %s",
    [3] = "<点击驻扎队伍>",
    [4] = "<点击进行占领>",
    [5] = "社团战每天限使用3支队伍， 已没有队伍可用于进攻",
}

function GuildWarStrongholdUI:on_init_stronghold_item(obj, b, real_id)
    local index = math.abs(real_id) + 1
    local row = math.abs(b) + 1 
    --app.log('index .. row <--> ' .. index .. ' ' .. row)
    
    if self.wrapStrongholdItem[row] == nil then
        local item = {}

        item.btnItem = ngui.find_button(obj, obj:get_name())
        item.btnItem:set_on_click(self.bindfunc["on_btn_team_item"])
        item.spBgBlue = ngui.find_sprite(obj, "sp_bg1")
        item.wgBgBlue = ngui.find_widget(obj, "sp_bg1")
        item.spBgYellow = ngui.find_sprite(obj, "sp_bg2")

        --添加
        item.objCont1 = obj:get_child_by_name("cont1")
        item.lblCont1Add = ngui.find_label(obj, "cont1/lbl_add")

        item.objCont2 = obj:get_child_by_name("cont2")
        item.spMy = ngui.find_sprite(obj, "cont2/sp_self")
        local objHead = obj:get_child_by_name("cont2/sp_head_di_item")
        item.playerHead = UiPlayerHead:new({parent = objHead})

        item.lblName = ngui.find_label(obj, "cont2/sp_name_bg/lbl_name")
        item.lblFightValue = ngui.find_label(obj, "cont2/lbl_fighting_n")
        item.lblLevel = ngui.find_label(obj, "cont2/lbl_level")

        --英雄头像
        item.smallCard = {}
        for i = 1, 3 do
            local objParent = obj:get_child_by_name("cont2/cont_heads/big_card_item_80" .. i)
            item.smallCard[i] = SmallCardUi:new(
            {   
                parent = objParent,
                info = nil,
                sgroup = 4,	
			    isShine	= false		
            })
        end
        --撤防
        item.btnRemove = ngui.find_button(obj, "cont2/btn1")
        item.btnRemove:set_on_click(self.bindfunc["on_btn_defence_remove"])
        --换人
        item.btnChangePerson = ngui.find_button(obj, "cont2/btn2")
        item.btnChangePerson:set_on_click(self.bindfunc["on_btn_defence_change_person"])
        --进攻
        item.btnAttack = ngui.find_button(obj, "cont2/btn3")
        item.btnAttack:set_on_click(self.bindfunc["on_btn_attack"])

        item.spDeadAll = ngui.find_sprite(obj, "cont2/sp_dead_all")
        item.lblFighting = ngui.find_label(obj, "cont2/lbl_fighting")

        self.wrapStrongholdItem[row] = item
    end

    local item = self.wrapStrongholdItem[row]
    item.btnItem:set_event_value("", index)

    item.spBgBlue:set_active(false)
    item.spBgYellow:set_active(false)
    item.objCont1:set_active(false)
    item.objCont2:set_active(false)
    item.spMy:set_active(false)

    --撤防
    item.btnRemove:set_active(false)
    --换人
    item.btnChangePerson:set_active(false)
    --进攻
    item.btnAttack:set_active(false)
    --全灭
    item.spDeadAll:set_active(false)
    --战斗中
    item.lblFighting:set_active(false)

    --增加驻防/占领
    if index == 1 and (self.canAddTeam or self.canOccupy) then
        item.objCont1:set_active(true)
        item.spBgBlue:set_active(true)
        item.wgBgBlue:set_size(981, 104)
        if self.canAddTeam then
            item.lblCont1Add:set_text(_UIText[3])
        elseif self.canOccupy then
             item.lblCont1Add:set_text(_UIText[4])
        end
    else
        item.objCont2:set_active(true)
        item.wgBgBlue:set_size(932, 104)
        self:UpdateTeamItem(item, index)
    end    
end

function GuildWarStrongholdUI:UpdateTeamItem(item, index)  
    if self.canAddTeam then
        index = index - 1
    end 
    local data = self.dc:GetTeamDataByIndex(self.nodeId, index)
    if data == nil then return end

    --头像
    item.playerHead:SetRoleId(data.image)
    --item.playerHead:SetGray(false)
    local _isMyTeam = (data.playerid == g_dataCenter.player:GetGID())

    --自己队伍
    if _isMyTeam then
        item.spBgYellow:set_active(true)
        item.spMy:set_active(true)
    else
        item.spBgBlue:set_active(true)
    end
    item.lblName:set_text(data.playerName)    
    item.lblLevel:set_text("LV." .. data.level)
      
    local allDead = nil
    if self.dc:IsDefenceOrIntervalPhase() then
        if _isMyTeam and self.dc:IsDefencePhase() then
            item.btnRemove:set_active(true)
            item.btnRemove:set_event_value("", data.teamType)
            item.btnChangePerson:set_active(true)
            item.btnChangePerson:set_event_value("", data.teamType)
        end
    elseif self.dc:IsAttackPhase() then 
        allDead = self.dc:IsTeamAllDead(data.heros)
        item.spDeadAll:set_active(allDead)
        --全灭(变灰)
        if allDead then
            PublicFunc.SetUISpriteGray(item.spBgBlue)
            item.playerHead:SetGray(true)
        else
            PublicFunc.SetUISpriteWhite(item.spBgBlue)
            item.playerHead:SetGray(false)
        end

        --战斗中
        local isFighting = data.fightState == 1
        item.lblFighting:set_active(isFighting)

        item.btnAttack:set_event_value("", index)

        if self.attackStatus == self._AttackStatus.Defence then
            --无法进攻

        elseif self.attackStatus == self._AttackStatus.MaxLimit then
            --无法进攻

        elseif self.attackStatus == self._AttackStatus.NoTeamOfMy then
            --进攻按钮变灰
            if allDead or isFighting then
            else
                item.btnAttack:set_active(true)
            end
        elseif self.attackStatus == self._AttackStatus.Attack then        
            --进攻
            if allDead or isFighting then
            else
                item.btnAttack:set_active(true)
            end
        end             
    end

    --头像
    local totalFightValue = 0
    for i = 1, 3 do
        local heroData = data.heros[i]
        if heroData ~= nil then
            local info = CardHuman:new({number = heroData.number, level = heroData.level})
            local smallCard = item.smallCard[i]
            smallCard:SetData(info)
            --全灭(变灰)
            if allDead then
                smallCard:SetGray(true)
            end
            --血量(被攻打时显示)
            if self.dc:IsAttackPhase() and (not self.dc:IsMyNode(self.nodeId)) then
                local _proValue = nil
                if heroData.curHp == - 1 or heroData.curHp > heroData.maxHp then
                    _proValue = 1
                else
                    _proValue = heroData.curHp / heroData.maxHp
                end
                smallCard:SetLifeBar(true, _proValue)
            else
                smallCard:SetLifeBar(false)
            end
            totalFightValue = totalFightValue + heroData.fightValue
        end
    end 
    item.lblFightValue:set_text(string.format(_UIText[2], totalFightValue))
end

--[[驻防/占领]]
function GuildWarStrongholdUI:on_btn_team_item(t)
    if t.float_value ~= 1 then
        return
    end
    if self.canAddTeam then
        self.dc:ShowCommonFormationUI(self.nodeId, 0)
        GuildWarStrongholdUI.End()
    --无驻防，直接占领
    elseif self.canOccupy then
        --清除
        self.dc:ClearFightInfo()
        GuildWarChooseTeamUI.Start(self.nodeId)
        GuildWarStrongholdUI.End()
    end
end

--[[撤防]]
function GuildWarStrongholdUI:on_btn_defence_remove(t)
    msg_guild_war.cg_cancel_guard_team(self.nodeId, t.float_value)
end

--[[换人]]
function GuildWarStrongholdUI:on_btn_defence_change_person(t)
    self.dc:ShowCommonFormationUI(self.nodeId, t.float_value)
    GuildWarStrongholdUI.End()
end

--[[进攻]]
function GuildWarStrongholdUI:on_btn_attack(t)
    if self.attackStatus == self._AttackStatus.NoTeamOfMy then
        FloatTip.Float(_UIText[5])
        return
    end
    GuildWarStrongholdUI:End()
    
    local defenceTeamInfo = self.dc:GetTeamDataByIndex(self.nodeId, t.float_value)
    --清除
    self.dc:ClearFightInfo()
    self.dc:SetFightInfo({defenceTeamInfo = defenceTeamInfo})
    
    --进攻队伍选择弹窗
    GuildWarChooseTeamUI.Start(self.nodeId)
end