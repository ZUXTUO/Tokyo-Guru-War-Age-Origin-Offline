
GuildWarChooseTeamUI = Class('GuildWarChooseTeamUI', UiBaseClass)

function GuildWarChooseTeamUI.Start(nodeId, backFromFormationUi)
    if GuildWarChooseTeamUI.cls == nil then
        GuildWarChooseTeamUI.cls = GuildWarChooseTeamUI:new({nodeId = nodeId, backFromFormationUi = backFromFormationUi})
    end
end

function GuildWarChooseTeamUI.End()
    if GuildWarChooseTeamUI.cls then
        GuildWarChooseTeamUI.cls:DestroyUi()
        GuildWarChooseTeamUI.cls = nil
    end
end

---------------------------------------华丽的分隔线--------------------------------------

local _UIText = {
    [1] = "%s队",
    [2] = "已进攻%s",
    [3] = "防守中",
    [4] = "战斗力：%s",
    [5] = "据点已被他人占领",
}

local _TeamStatus = {
    Enabled = 1,
    Enabled_Attack_This = 2,        --攻击此据点
    Unenabled_Defence = 3,
    Unenabled_Attack_Other = 4,     --攻击其它据点
    Unenabled_Attack_All_Die = 5,
}

function GuildWarChooseTeamUI:Init(data)
	self.pathRes = "assetbundles/prefabs/ui/guild/guild_war/ui_3805_guild_war_chose.assetbundle"
	UiBaseClass.Init(self, data)
end

function GuildWarChooseTeamUI:InitData(data)
    self.wrapItem = {}
    self.nodeId = data.nodeId
    self.backFromFormationUi = data.backFromFormationUi
    self.dc = g_dataCenter.guildWar
    self.selectIndex = nil
	UiBaseClass.InitData(self, data)    
end

function GuildWarChooseTeamUI:DestroyUi()       
    for _, v in pairs(self.wrapItem) do
        for _, smallCard in pairs(v.smallCards) do
            if smallCard then
                smallCard:DestroyUi()
                smallCard = nil
            end
        end
    end
	UiBaseClass.DestroyUi(self)    
end

function GuildWarChooseTeamUI:RegistFunc()
	UiBaseClass.RegistFunc(self)
	self.bindfunc["on_btn_close"] = Utility.bind_callback(self, self.on_btn_close)
    self.bindfunc["on_btn_confirm"] = Utility.bind_callback(self, self.on_btn_confirm)
    self.bindfunc["on_init_item"] = Utility.bind_callback(self, self.on_init_item)
    self.bindfunc["on_choose_team"] = Utility.bind_callback(self, self.on_choose_team)  
    self.bindfunc["on_add_team"] = Utility.bind_callback(self, self.on_add_team)   
    self.bindfunc["on_change_person"] = Utility.bind_callback(self, self.on_change_person) 
    self.bindfunc["on_embattle"] = Utility.bind_callback(self, self.on_embattle)

    self.bindfunc["on_begin_attack_result"]  = Utility.bind_callback(self, self.on_begin_attack_result) 
    self.bindfunc["on_direct_occupy_result"]  = Utility.bind_callback(self, self.on_direct_occupy_result) 
end

function GuildWarChooseTeamUI:MsgRegist()
	UiBaseClass.MsgRegist(self)    
    PublicFunc.msg_regist(msg_guild_war.gc_begin_attack_ret, self.bindfunc['on_begin_attack_result'])
    PublicFunc.msg_regist(msg_guild_war.gc_direct_occupy, self.bindfunc['on_direct_occupy_result'])
end

function GuildWarChooseTeamUI:MsgUnRegist()
	UiBaseClass.MsgUnRegist(self);
    PublicFunc.msg_unregist(msg_guild_war.gc_begin_attack_ret, self.bindfunc['on_begin_attack_result'])
    PublicFunc.msg_unregist(msg_guild_war.gc_direct_occupy, self.bindfunc['on_direct_occupy_result'])
end

function GuildWarChooseTeamUI:on_btn_close()
    self.dc:ClearFightInfo()
    GuildWarChooseTeamUI.End()
    PublicFunc.msg_dispatch("guild_war_on_open_stronghold_ui")
end

function GuildWarChooseTeamUI:InitUI(asset_obj)
	UiBaseClass.InitUI(self, asset_obj)
	self.ui:set_name("ui_guild_war_choose_team")

    local path = "centre_other/animation/"

    local btnClose = ngui.find_button(self.ui, path .. "btn_close")
    btnClose:set_on_click(self.bindfunc["on_btn_close"])    

    self.scrollView = ngui.find_scroll_view(self.ui, path .. "scrollview")
    self.wrapContent = ngui.find_wrap_content(self.ui, path .. "scrollview/wrapcontent")
    self.wrapContent:set_on_initialize_item(self.bindfunc["on_init_item"])

    local btnCancel = ngui.find_button(self.ui, path .. "btn1")
    btnCancel:set_on_click(self.bindfunc["on_btn_close"])
    self.btnConfirm = ngui.find_button(self.ui, path .. "btn2")
    self.btnConfirm:set_enable(false)

    self:UpdateUi()

    if self.backFromFormationUi then
        self.dc:ShowEmbattleUI()
    end
end

function GuildWarChooseTeamUI:GetShowTeamCount()
    local count = self.dc:GetMyTeamInfoCount()    
    --显示新增item / 临时数据展示
    count = count + 1
    if count > 3 then
        count = 3
    end
    return count
end

function GuildWarChooseTeamUI:IsShowTempTeamData()
    return self.dc:GetTempMyAttackTeamInfo() ~= nil
end

function GuildWarChooseTeamUI:UpdateUi()
    self.allTeamStatus = {}
    self.teamCnt = self:GetShowTeamCount()
    self.wrapContent:set_min_index(- self.teamCnt + 1)
    self.wrapContent:set_max_index(0)
    self.wrapContent:reset()
    self.scrollView:reset_position() 
end

function GuildWarChooseTeamUI:on_init_item(obj, b, real_id)
    local index = math.abs(real_id) + 1
    local row = math.abs(b) + 1 
    --app.log('index .. row <--> ' .. index .. ' ' .. row)

    if self.wrapItem[row] == nil then
        local item = {}
        
        item.btnItem = ngui.find_button(obj, obj:get_name())
        item.btnItem:set_on_click(self.bindfunc["on_choose_team"])

        item.spBg = ngui.find_sprite(obj, "sp_bg1")
        item.spHightLight = ngui.find_sprite(obj, "sp_bg2")
        item.lblTeamNumber = ngui.find_label(obj, "sp_team/lbl_n")

        item.objCont1 = obj:get_child_by_name("cont1")
        item.btnAdd = ngui.find_button(obj, "cont1/sp_add")
        item.btnAdd:set_on_click(self.bindfunc["on_add_team"])

        item.objCont2 = obj:get_child_by_name("cont2")

        item.lblFightValue = ngui.find_label(obj, "cont2/sp_fighting_bg/lbl_name")  
        --英雄头像
        item.smallCards = {}
        for i = 1, 3 do 
            local smallCard = SmallCardUi:new(
            {   
                parent = obj:get_child_by_name("cont2/cont1/big_card_item_80" .. i),
                info = nil,
                sgroup = 4,	
			    isShine	= false		
            })
            item.smallCards[i] = smallCard
        end       

        item.btnChangePerson = ngui.find_button(obj, "cont2/cont2/btn1")
        item.btnChangePerson:set_on_click(self.bindfunc["on_change_person"])

        item.btnEmbattle = ngui.find_button(obj, "cont2/cont2/btn2")
        item.btnEmbattle:set_on_click(self.bindfunc["on_embattle"])

        item.spChoose = ngui.find_sprite(obj, "cont2/cont2/toggle")

        item.lblAttacked = ngui.find_label(obj, "cont2/lbl_t")
        item.spDealAll = ngui.find_sprite(obj, "cont2/sp_dead_all")

        self.wrapItem[row] = item
    end

    local item = self.wrapItem[row]
    local info = self.dc:GetMyTeamInfo(index)
    local status = self:GetMyTeamStatus(info)
    if self.teamCnt == index then
        if self:IsShowTempTeamData() then
            info, status = self:GetTempTeamData()
        end
    end
    app.log('=============================> team = ' .. index .. ' stauts = ' .. tostring(status))

    --保存队伍状态
    self.allTeamStatus[index] = status

    item.btnAdd:set_event_value("", index)
    item.btnItem:set_event_value("", index)
   
    item.objCont1:set_active(false) 
    item.objCont2:set_active(false)    
    item.spHightLight:set_active(false)
    item.spChoose:set_active(false)

    item.lblTeamNumber:set_text(string.format(_UIText[1], index))

    if info ~= nil then    
        item.objCont2:set_active(true) 
        
        local totalFightValue = 0
        for i = 1, 3 do
            local hero = info.heros[i]
            local smallCard = item.smallCards[i]

           smallCard:SetDead(false)
           smallCard:SetLifeBar(false)

            if hero ~= nil then
                local cardData = g_dataCenter.package:find_card(ENUM.EPackageType.Hero, hero.dataid)
                smallCard:SetData(cardData)
                totalFightValue = totalFightValue + cardData:GetFightValue()

                --血量
                local _proValue = nil          
                local maxHp = cardData:GetPropertyVal(ENUM.EHeroAttribute.max_hp)
                --初始化血量为-1
                if hero.hp == - 1 or hero.hp > maxHp  then
                    _proValue = 1
                else
                    _proValue = hero.hp / maxHp
                end
                --app.log('==========>_proValue =  ' .. _proValue)
                smallCard:SetDead(_proValue == 0)   
                smallCard:SetGray(_proValue == 0)       
                smallCard:SetLifeBar(true, _proValue)
            end
        end
        
        --战斗力
        item.lblFightValue:set_text(string.format(_UIText[4], totalFightValue))  
        item.btnChangePerson:set_event_value("", info.teamType)
        item.btnEmbattle:set_event_value("", info.teamType)
                 
        item.spDealAll:set_active(false)   
        item.lblAttacked:set_active(false)   
        item.btnChangePerson:set_active(false)
        item.btnEmbattle:set_active(false)
            
        --防守中
        if status == _TeamStatus.Unenabled_Defence then   
            item.lblAttacked:set_active(true)
            item.lblAttacked:set_text(_UIText[3])

        --全部阵亡   
        elseif status == _TeamStatus.Unenabled_Attack_All_Die then
            item.spDealAll:set_active(true)
            item.lblAttacked:set_active(true)
            item.lblAttacked:set_text(string.format(_UIText[2], ""))

        --之前进攻过
        elseif status == _TeamStatus.Enabled_Attack_This then
            --可以布阵
            item.btnEmbattle:set_active(true)

        --进攻过其它
        elseif status == _TeamStatus.Unenabled_Attack_Other then
            item.lblAttacked:set_active(true)
            item.lblAttacked:set_text(string.format(_UIText[2], ""))

        elseif status == _TeamStatus.Enabled then
            item.btnChangePerson:set_active(true)  

        end

        --
        PublicFunc.SetUISpriteWhite(item.spBg)

        if status == _TeamStatus.Enabled or status == _TeamStatus.Enabled_Attack_This then
            
        else
            --不可用==>变灰
            PublicFunc.SetUISpriteGray(item.spBg)
        end        
    else
        item.objCont1:set_active(true)         
    end

    --设置默认选中
    if self.teamCnt == index then
        local orderStatus = {_TeamStatus.Enabled_Attack_This, _TeamStatus.Enabled}
        if self.backFromFormationUi then
            orderStatus = {_TeamStatus.Enabled, _TeamStatus.Enabled_Attack_This}
        end
        for _, findStatus in ipairs(orderStatus) do
            for index, status in pairs(self.allTeamStatus) do
                if status ~= nil and status == findStatus then
                    self:on_choose_team({float_value = index})
                    return
                end
            end
        end
    end
end

function GuildWarChooseTeamUI:GetMyTeamStatus(info)
    if info ~= nil then
        --防守
        if info.isAttack == 0 then
            return _TeamStatus.Unenabled_Defence

        --进攻
        elseif info.isAttack == 2 then
            --当前节点
            if info.nodeId == self.nodeId then                
                if info.heros then                    
                    --全部阵亡    
                    local _dieAll = true
                    for k, v in pairs(info.heros) do
                        if v.hp ~= 0 then
                            _dieAll = false
                        end
                    end                  
                    if _dieAll then
                        return _TeamStatus.Unenabled_Attack_All_Die
                    else
                        return _TeamStatus.Enabled_Attack_This
                    end
                end   
            --其它据点             
            else
                return _TeamStatus.Unenabled_Attack_Other
            end
        end
    end    
    return nil
end


function GuildWarChooseTeamUI:on_add_team(t)
    self.dc:ShowCommonFormationUI(self.nodeId, 0)
    GuildWarChooseTeamUI.End()
end

function GuildWarChooseTeamUI:on_choose_team(t)
    local index = t.float_value
    if index == self.selectIndex then
        return
    end
    self.selectIndex = index

    local info = self.dc:GetMyTeamInfo(index)
    local status = self:GetMyTeamStatus(info)
    if info == nil then
        if self:IsShowTempTeamData() then
            info, status = self:GetTempTeamData()
        end
    end      
    if status == _TeamStatus.Enabled or status == _TeamStatus.Enabled_Attack_This then
        --选中
        for k, v in ipairs(self.wrapItem) do
            v.spHightLight:set_active(k == index)
            v.spChoose:set_active(k == index)
        end
        --------------设置进攻的队伍-----------
        self.dc:SetFightInfo({
            attackNodeId = self.nodeId,
            myTeamType = info.teamType,
        })
        ----------------------------------------  
        self.btnConfirm:set_enable(true)
        self.btnConfirm:reset_on_click()
        self.btnConfirm:set_on_click(self.bindfunc["on_btn_confirm"])
    end
end

function GuildWarChooseTeamUI:GetTempTeamData()
    local info = {
        heros = self.dc:GetTempMyAttackTeamInfo(),
        teamType = 0,
    }
    return info,  _TeamStatus.Enabled
end

function GuildWarChooseTeamUI:on_change_person(t)
    self.dc:ShowCommonFormationUI(self.nodeId, t.float_value)
    GuildWarChooseTeamUI.End()
end

--[[布阵]]
function GuildWarChooseTeamUI:on_embattle(t)
    self.dc:SetEmbattleInfo(true, t.float_value)
    self.dc:ShowEmbattleUI()
end

function GuildWarChooseTeamUI:on_btn_confirm(t)
    local info = self.dc:GetFightInfo()
    local myTeamType, defenceTeamInfo = info.myTeamType, info.defenceTeamInfo
    if myTeamType == nil then
        app.log('myTeamType == nil')
        return
    end
    local tempHeros = self.dc:GetTempMyAttackTeamInfo()
    if defenceTeamInfo ~= nil then
        msg_guild_war.cg_begin_attack(self.nodeId, myTeamType, defenceTeamInfo.playerid, defenceTeamInfo.teamType, tempHeros)
    --沒有防守，直接占领
    else
        msg_guild_war.cg_direct_occupy(self.nodeId, myTeamType, tempHeros)
    end
end

function GuildWarChooseTeamUI:on_begin_attack_result(result)
    if result == 0 then
        GuildWarChooseTeamUI.End()
    else
        --飘字提示
        if result == -101 then
            FloatTip.Float(_UIText[5])
        end
        --变灰
        self.btnConfirm:set_enable(false)
    end
end

function GuildWarChooseTeamUI:on_direct_occupy_result(result)
    if result == 0 then
        GuildWarChooseTeamUI.End()
    else    
        --飘字提示
        if result == -101 then
            FloatTip.Float(_UIText[5])
        end
        --打开据点页面
        self:on_btn_close()
    end
    self.dc:ClearHistoryData()
end