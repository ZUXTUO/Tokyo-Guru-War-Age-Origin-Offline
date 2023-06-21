CommonFormationUI = Class("CommonFormationUI", UiBaseClass)

--[[
    --类型， 详见ENUM.ETeamType
    teamType = xx 

    --英雄数量
    heroMaxNum = xx

    --初始阵容列表,
    initList = {xx ... }   
    
    --显示血条类型, 见ENUM.RoleCardPlayMethodHPType
    showHPType = xx  

    guildWar = {
        --队伍("队伍x"及"已参战")   
        team = {
            xx, xx, xx, 
            xx, xx, xx, 
            xx, xx, xx, 
        },
        --ENUM.GuildWarPhase
        phase = xx,
        nodeId = xx,
        teamId = xx,
        heroPosList = xx,
    }

    churchPray = {
        --队伍("已出阵")   
        team = {
            xx, xx, xx, 
            xx, xx, xx, 
            xx, xx, xx, 
        },
        showTeamHero = false
    }
    heroLevel = xx,

    --活动关卡
    proAddHurdleid = xx,

    --已参战列表
    joinBattleList = { index = xx ... }

    --保存后回调
    saveCallback = nil
]]

local _UIText = {
    [1] = "下阵",
    [2] = "阵亡",
    [3] = "已参战",
    [4] = "队长位置不能空",
    [5] = "上阵人数已满",
    [6] = "%s队",
    [7] = "已参战",
    [8] = "确定",
    [9] = "取消",
    [10] = "队伍里有角色正在驻防中, 将撤消此角色在原据点的驻防",
    [11] = "驻防三支队伍将无法参与进攻",
    [12] = "进攻后队伍阵容将无法变更, 是否确定用未满3人的队伍发起进攻",
    [13] = "已出阵",

    [14] = "当前阵容未保存, 是否退出?",
    [15] = "出场顺序",
    [16] = "我的战队",
    [17] = "上阵角色",
    [18] = "1号位置不能为空",
 }

function CommonFormationUI:Init(data)
    self.pathRes = "assetbundles/prefabs/ui/zhenrong/ui_5301_shangzhen.assetbundle";
	UiBaseClass.Init(self, data);
end

function CommonFormationUI:Restart(data)
    self.data = data
    if self.data == nil then
        app.log('上阵信息为空')
        return
    end
    if self.data.teamType  == nil then
        app.log('上阵队伍类型为空')
        return
    end

    --app.log('------>heroMaxNum' .. tonumber(self.data.heroMaxNum))

    --上阵英雄数量 
    if self.data.heroMaxNum == nil then
        self.data.heroMaxNum = 3
    end  
        
    --上阵信息
    local _teamInfo = g_dataCenter.player:GetTeam(self.data.teamType)
    if _teamInfo == nil then
        if self.data.teamType == ENUM.ETeamType.arena then
            _teamInfo = g_dataCenter.player:GetTeam(ENUM.ETeamType.normal)
        end
    end
    self.teamData = {} 

    if self.data.teamType == ENUM.ETeamType.guild_war then
        _teamInfo = nil
        for i = 1, 3 do
            if self.data.initList[i] ~= nil then
                self.teamData[i] = g_dataCenter.package:find_card(ENUM.EPackageType.Hero, self.data.initList[i])
            end
        end
    elseif self.data.teamType == ENUM.ETeamType.clone_fight then
        _teamInfo = nil
        self.teamData[2] = g_dataCenter.package:find_card(ENUM.EPackageType.Hero, self.data.initList[1])   
    end  

    if _teamInfo ~= nil then
        if self.data.heroMaxNum == 3 then        
            for i = 1, 3 do
                local id = _teamInfo[i]
                if id then
                    self.teamData[i] = g_dataCenter.package:find_card(ENUM.EPackageType.Hero, id)
                    if self:IsDead(self.teamData[i]) then
                        self.teamData[i] = nil
                    end
                end
            end 
        else
            if _teamInfo[1] then 
                self.teamData[2] = g_dataCenter.package:find_card(ENUM.EPackageType.Hero, _teamInfo[1])
            end
        end
    end   
    if self.data.teamType == ENUM.ETeamType.clone_fight then
        self.teamData[2] = g_dataCenter.package:find_card(ENUM.EPackageType.Hero, self.data.initList[1])
    elseif self:IsChurchPray(self.data.teamType) then
        if self.data.churchPray and self.data.churchPray.showTeamHero == false then 
            --不读取队伍数据
            self.teamData = {} 
        end
    end   

    --找出所有推荐类型    
    if self.data.proAddHurdleid ~= nil then 
        self.addPropConfig = ConfigManager.Get(EConfigIndex.t_hero_type_add_prop, self.data.proAddHurdleid)        
        self.allRecommendProType = {}
        for k, v in ipairs(self.addPropConfig) do
            if 'pro_type' == v.prop_type then
                table.insert(self.allRecommendProType, v.prop_value)
            end
        end 
    end
    

    self.heroDataList = {}    
    --self.heroDataList[ENUM.EProType.All] = PublicFunc.GetAllHero(ENUM.EShowHeroType.Have, nil, nil)
    self.heroDataList[ENUM.EProType.All] = PublicFunc.GetAllHero(ENUM.EShowHeroType.All, nil, nil)
    if self.data.teamType == ENUM.ETeamType.fuzion2 then
        for k, v in pairs(self.heroDataList[ENUM.EProType.All]) do
            --头像设置为金色
            v.realRarity = ENUM.EHeroRarity.Orange
        end

        table.sort(self.heroDataList[ENUM.EProType.All], function(a, b)
            if a.config.aptitude == b.config.aptitude then
                return a.config.id < b.config.id
            else
                return a.config.aptitude > b.config.aptitude
            end
        end)
    end

    self.itemList = {}
    self.headItemList = {}

    self.backupTeam = g_dataCenter.player:GetBackupTeam(self.data.teamType)

    self.heroType = ENUM.EProType.All
    if UiBaseClass.Restart(self, data) then        
	end
end

function CommonFormationUI:InitData(data)
    UiBaseClass.InitData(self, data) 
    self.proTypeConfig = {ENUM.EProType.All, ENUM.EProType.Gong, ENUM.EProType.Fang, ENUM.EProType.Ji}
end

function CommonFormationUI:DestroyUi()
    for k, v in pairs(self.itemList) do
        for _, vv in pairs(v) do
            if vv.heroCard then
                vv.heroCard:DestroyUi()
                vv.heroCard = nil
            end
        end
    end
    for _, v in pairs(self.headItemList) do
        if v.bigCard then
            v.bigCard:DestroyUi()
            v.bigCard = nil
        end
    end
    self.itemList = {}
    self.teamData = {}
    UiBaseClass.DestroyUi(self)   
end

function CommonFormationUI:RegistFunc()
    UiBaseClass.RegistFunc(self)
    self.bindfunc["on_click_tab"] = Utility.bind_callback(self, self.on_click_tab)
    self.bindfunc["on_init_item"] = Utility.bind_callback(self, self.on_init_item)
    self.bindfunc["on_choose_hero"] = Utility.bind_callback(self,self.on_choose_hero)
    self.bindfunc["on_down_formation"] = Utility.bind_callback(self,self.on_down_formation) 
    self.bindfunc["on_big_card_click"] = Utility.bind_callback(self,self.on_big_card_click) 

    self.bindfunc["on_save_formation"] = Utility.bind_callback(self,self.on_save_formation) 
    self.bindfunc["on_update_team"] = Utility.bind_callback(self,self.on_update_team)
    self.bindfunc["set_choose_hero"] = Utility.bind_callback(self,self.set_choose_hero) 
    self.bindfunc["on_save_guild_war_team"] = Utility.bind_callback(self,self.on_save_guild_war_team) 
    self.bindfunc["gc_get_my_team_ret"] = Utility.bind_callback(self,self.gc_get_my_team_ret)   

    self.bindfunc["on_pop_ui"] = Utility.bind_callback(self,self.on_pop_ui)
    -- self.bindfunc["on_set_team_pos"] = Utility.bind_callback(self,self.on_set_team_pos);
end

function CommonFormationUI:MsgRegist()
    UiBaseClass.MsgRegist(self);  
    PublicFunc.msg_regist(msg_team.gc_update_team_info, self.bindfunc['on_update_team'])
    PublicFunc.msg_regist(msg_guild_war.gc_get_my_team_ret, self.bindfunc['gc_get_my_team_ret'])
end

function CommonFormationUI:MsgUnRegist()
    UiBaseClass.MsgUnRegist(self);
    PublicFunc.msg_unregist(msg_team.gc_update_team_info, self.bindfunc['on_update_team'])
    PublicFunc.msg_unregist(msg_guild_war.gc_get_my_team_ret, self.bindfunc['gc_get_my_team_ret'])
end

function CommonFormationUI:SetTitle()
    local _txt = _UIText[17]
    --[[if self.data.heroMaxNum == 3 then 
        if self.data.teamType == ENUM.ETeamType.fuzion2 then
            _txt = _UIText[15]
        else
            _txt = _UIText[16]
        end
    else
        _txt = _UIText[17]
    end]]
    self.lblTitle:set_text(_txt)
end

function CommonFormationUI:InitUI(obj)
    UiBaseClass.InitUI(self, obj);    
    self.ui:set_name('common_formation_ui')  

    local lPath = "left_other/animation/" 
    for i = 1, 4 do
        local btnTab = ngui.find_button(self.ui, lPath .. "cont/yeka" .. i)
        btnTab:reset_on_click()
        btnTab:set_event_value("", self.proTypeConfig[i])
        btnTab:set_on_click(self.bindfunc["on_click_tab"],"MyButton.Flag")
        if i ~= 1 then
            local spRecommend = ngui.find_sprite(self.ui, lPath .. "cont/yeka" .. i ..'/sp_tuijian')
            local rst = self:IsRecommendProType(self.proTypeConfig[i])
            spRecommend:set_active(rst)
        end
    end

    local panelPath = lPath .. "scroll_view/panel_list"
    self.scrollView = ngui.find_scroll_view(self.ui, panelPath)
    self.wrapContent = ngui.find_wrap_content(self.ui, panelPath .. "/wrap_content")
    self.wrapContent:set_on_initialize_item(self.bindfunc["on_init_item"])      

    local rPath = "right_other/animation/" 
    self.lblTitle = ngui.find_label(self.ui, rPath .. "sp_title/txt")
    self:SetTitle()
    
    for i = 1, 3 do
        local headPath = rPath .. "sp_di" .. i .. "/"

        local bigCard = nil
        if self.data.teamType == ENUM.ETeamType.fuzion2 then
            bigCard = UiBigCard:new({
                parent = self.ui:get_child_by_name(headPath .. 'cont_big_item'),
                infoType = 1,
                showAddButton = false,
                showStar = false,
                showLvl = false,
                showFight = false,
                useWhiteName = true,
            })
        else
            bigCard = UiBigCard:new({
                parent = self.ui:get_child_by_name(headPath .. 'cont_big_item'),
                infoType = 1,
                showAddButton = false,
                showAptitude = false,
            })
        end

        --队伍位置信息
        if self.data.teamType == ENUM.ETeamType.fuzion2 then
            bigCard:SetTeamPos(i)
        else
            if i == 1 then
                bigCard:SetTeamPos(0)
            else
                bigCard:SetTeamPos(-1)
            end
        end
        bigCard:SetCallback(self.bindfunc["on_big_card_click"])
        bigCard:SetParam(i)

        --下阵
        local btnSp = ngui.find_button(self.ui, headPath .. "btn")
        btnSp:reset_on_click()
        btnSp:set_event_value("", i)
        btnSp:set_on_click(self.bindfunc["on_down_formation"])

        self.headItemList[i] = {
            obj = self.ui:get_child_by_name(headPath), 
            bigCard = bigCard,
            btn = btnSp,
            pro = ngui.find_progress_bar(self.ui, headPath .. 'pro_di'),
            txt = ngui.find_label(self.ui, headPath .. 'txt')
        }
    end

    local downPath = "down_other/animation/" 
    self.totalFightValue = ngui.find_label(self.ui, downPath .. "sp_fight/lab_fight")
    local btnSave = ngui.find_button(self.ui, downPath .. "btn")
    btnSave:set_on_click(self.bindfunc["on_save_formation"])

    self:UpdateUI()
end

function CommonFormationUI:on_big_card_click(bigCard, cardInfo, para)
    self:on_down_formation({float_value = para})
end

function CommonFormationUI:UpdateUI()
    self:SetHeroDataList()
    self:UpdateHeroPackage()
    self:UpdateFormationInfo()
    self:UpdateTotalFightValue() 
end        

function CommonFormationUI:on_click_tab(t)
     if t.float_value ~= self.heroType then
        self.heroType = t.float_value
        self:UpdateUI()
    end
end

function CommonFormationUI:on_init_item(obj, b, real_id)
    local index = math.abs(real_id)
    local row = math.abs(b) + 1 

    for i = 1, 4 do 
        local objItem = obj:get_child_by_name("item" .. i)
        local pos = index * 4 + i
        local heroData = self:GetHeroDataByIndex(pos)
        if heroData ~= nil then
            objItem:set_active(true)
            self:SetItemData(objItem, heroData, pos, row, i)
        else
            objItem:set_active(false)
        end
    end
end

function CommonFormationUI:SetItemData(objItem, heroData, pos, row, i)  
    if self.itemList[row] == nil then
        self.itemList[row] = {}
    end
    if self.itemList[row][i] == nil then
        local temp = {}
        --已参战/已出战
        temp.spDesc = ngui.find_sprite(objItem, "item" .. i .. "/sp_yi_canzhan")
        temp.txtDesc = ngui.find_label(objItem, "item" .. i .. "/sp_yi_canzhan/lab")
        --队伍
        temp.lblTeam = ngui.find_label(objItem, "item" .. i .. "/lab")

        local _stypes = nil
        if self.data.teamType == ENUM.ETeamType.fuzion2 then
            _stypes = { SmallCardUi.SType.Texture, SmallCardUi.SType.Aptitude, SmallCardUi.SType.Rarity}
        else
            _stypes = {
                SmallCardUi.SType.Texture,
                SmallCardUi.SType.Level,
                SmallCardUi.SType.Star,
                SmallCardUi.SType.Rarity,
                SmallCardUi.SType.Qh
            }
        end
        temp.heroCard = SmallCardUi:new(
        {   
            parent = objItem:get_child_by_name("big_card_item_80"),
            info = heroData,
            stypes = _stypes,
			isShine	= (pos == self.selectedPos)		
        })      
        temp.heroCard:SetCallback(self.bindfunc["on_choose_hero"])
        --
        self.itemList[row][i] = temp
    end

    local item = self.itemList[row][i]    
    item.heroCard:SetParam(pos) 
    item.heroCard:SetData(heroData)
    
    local _turnGray = false --self:IsGray(heroData)
    item.spDesc:set_active(false)
    item.lblTeam:set_active(false)

    --社团战队伍
    if self.data.teamType == ENUM.ETeamType.guild_war then
        local info = self:GetGuildWarTeamInfo(heroData.index)
        if info ~= "" then
            if self.data.guildWar.phase == ENUM.GuildWarPhase.Defence then
                item.lblTeam:set_active(true)
                item.lblTeam:set_text(info)
            else
                item.spDesc:set_active(true)
                item.txtDesc:set_text(info)
                _turnGray = true
            end           
        end
    end

    --教学挂机
    if self:IsChurchPray(self.data.teamType) then
        local info = self:GetChurchPrayTeamInfo(heroData.index)
        if info ~= "" then
            item.spDesc:set_active(true)
            item.txtDesc:set_text(info)
            _turnGray = true
        end
    end

    --英雄等级
    if self:HeroLevelNotReach(heroData) or self:IsBackupTeam(heroData) then
        _turnGray = true
    end
    --阵亡
    if self:IsDead(heroData) then
        _turnGray = true
        item.heroCard:SetDead(true)
    else
        item.heroCard:SetDead(false)
    end
	item.heroCard:ChoseItem(pos == self.selectedPos)
    --
    item.heroCard:SetRecommend(self:IsRecommend(heroData))
	
    --上阵图标
    item.heroCard:SetFormationIcon(self:IsChecked(heroData))
    --血条
    self:HandleHP(item.heroCard, heroData)
    --变灰
    item.heroCard:SetGray(_turnGray)

    if g_dataCenter.guardHeart:IsMutexTeam(self.data.teamType) then
        if g_dataCenter.guardHeart:IsGuardHeartHero(heroData.index) then
            item.heroCard:SetGuardHeart(true)
        else
            item.heroCard:SetGuardHeart(false)
        end
    end
end

function CommonFormationUI:IsChurchPray(type)
    if type >= ENUM.ETeamType.churchpray1_1 and type <= ENUM.ETeamType.churchpray4_2 then
        return true
    end
    return false
end

function CommonFormationUI:GetChurchPrayTeamInfo(dataId)
    if self.data.churchPray == nil or self.data.churchPray.team == nil then
        return ""
    end
    for k,v in pairs(self.data.churchPray.team) do
        if v ~= nil and v ~= 0 and v == dataId then
            return _UIText[13]
        end
    end
    return ""
end

function CommonFormationUI:IsGray(cardData)    
    if self:IsTeamMemberFull() then
        --没有选中
        if self:IsChecked(cardData) then
            return false
        else
            return true
        end        
    end
    return false
end

function CommonFormationUI:HeroLevelNotReach(cardData)    
    if self.data.heroLevel ~= nil then
        if cardData.level < self.data.heroLevel then
            return true
        end
    end
    return false
end

function CommonFormationUI:IsBackupTeam(cardData)
    if self.backupTeam then
        for k, v in pairs(self.backupTeam) do
            if cardData.index == v then
                return true
            end
        end
    end
    return false
end

function CommonFormationUI:IsRecommend(cardData)
    if self.data.proAddHurdleid == nil then
        return false
    end
    if self:IsRecommendProType(cardData.pro_type) then
        return true
    end
    if self:IsProAdd(cardData) then
        return true
    end
    return false
end

function CommonFormationUI:IsRecommendProType(pro_type)
    if self.allRecommendProType == nil then
        return false
    end
    for _, v in pairs(self.allRecommendProType) do
        if pro_type == v then
            return true
        end
    end
    return false
end

--[[属性加成]]
--ENUM.ETeamType.guild_gaosujuj
--ENUM.ETeamType.guild_Defend_war
--ENUM.ETeamType.Clown_plan
function CommonFormationUI:IsProAdd(cardData)
    for k, v in ipairs(self.addPropConfig) do
        if cardData.config[v.prop_type] == v.prop_value then
            return true
        end
    end
    return false
end

function CommonFormationUI:IsDead(cardData)
    if self.data.showHPType then
        local _value = self:GetHPProgressValue(cardData)
        return _value == 0
    end
    return false
end

function CommonFormationUI:IsChecked(cardData)
    local isHave = false
    if cardData == nil then
        return isHave
    end
    for k, v in pairs(self.teamData) do
        if cardData.index == v.index then
            app.log("IsChecked 检查队伍角色"..tostring(cardData.index));
            isHave = true
            break
        end
    end
    app.log("IsChecked 检查输出"..tostring(isHave));
    return isHave
end

--[[社团战队伍]]
function CommonFormationUI:GetGuildWarTeamInfo(dataId)
    if self.data.guildWar.team ~= nil then
        for k,v in ipairs(self.data.guildWar.team) do
            if v ~= nil and v ~= 0 and v == dataId then
                if self.data.guildWar.phase == ENUM.GuildWarPhase.Defence then
                    return string.format(_UIText[6], math.ceil(k/3))
                else
                    return _UIText[7]
                end
            end
        end
    end
    return ""
end

function CommonFormationUI:IsTeamMemberFull()
    if self.data.heroMaxNum == 3 then
        return self:GetTeamMemberCount() == 3
    else
        return self.teamData[2] ~= nil
    end
end

function CommonFormationUI:GetTeamMemberCount()
    local count = 0
    for k, v in pairs(self.teamData) do
        count = count + 1
    end
    return count
end

local teamInfo = {
    [1] = 999,
    [2] = 999,
    [3] = 999,
}

function CommonFormationUI:on_choose_hero(obj, info, pos)
    --已选(下阵)
    if self:IsChecked(info) then
        local isHave = false;
        if teamInfo[1] == pos or teamInfo[2] == pos or teamInfo[3] == pos then
            isHave = true;
        end
        if isHave then
            for i = 1, 3 do
                local cardData = self.teamData[i]
                if cardData and cardData.index == info.index then
                    app.log("on_choose_hero 已选(下阵)队伍："..i);
                    if teamInfo[1] == pos then
                        teamInfo[1] = 999;
                        self:on_down_formation({float_value = 1})
                    elseif teamInfo[2] == pos then
                        teamInfo[2] = 999;
                        self:on_down_formation({float_value = 2})
                    elseif teamInfo[3] == pos then
                        teamInfo[3] = 999;
                        self:on_down_formation({float_value = 3})
                    end
                    break
                end
            end
            return
        end
    end
    --阵亡/等级不足/已驻阵
    if self:IsDead(info) or self:HeroLevelNotReach(info) or self:IsBackupTeam(info) then
        return
    end
    --已出阵
    if self:IsChurchPray(self.data.teamType) then
        local retInfo = self:GetChurchPrayTeamInfo(info.index)
        app.log("on_choose_hero 已出阵："..retInfo);
        if retInfo ~= "" then
            return
        end
    end
    --已满
    if self:IsTeamMemberFull() then
        FloatTip.Float(_UIText[5])
        return
    end

    local _param = {info = info, pos = pos}
    --队伍x/已参战
    if self.data.teamType == ENUM.ETeamType.guild_war then
        local retInfo = self:GetGuildWarTeamInfo(info.index)
        local isIn = self:InInitList(info.index)
        if (not isIn) and retInfo ~= "" then
            if self.data.guildWar.phase == ENUM.GuildWarPhase.Defence then
                HintUI.SetAndShow(EHintUiType.two, _UIText[10], {str = _UIText[8], func = self.bindfunc["set_choose_hero"], param = _param},
                {str = _UIText[9]})
            end
            return
        end
    end

    self:set_choose_hero(_param)
end

function CommonFormationUI:InInitList(index)
    if self.data.initList ~= nil then
        for _, v in pairs(self.data.initList) do
            if v == index then
                return true
            end
        end
    end
    return false
end

function CommonFormationUI:gc_get_my_team_ret(teamType)
    self:on_navbar_back(true, teamType)
end

function CommonFormationUI:set_choose_hero(_param)
    self.selectedPos = _param.pos
    app.log("set_choose_hero_param_pos:------"..tostring(_param.pos));
    --选中
    for _, v in pairs(self.itemList) do
        for _, vv in pairs(v) do
            local flag = vv.heroCard:GetParam() == self.selectedPos
            vv.heroCard:ChoseItem(flag)
            if flag then
                --打勾
                vv.heroCard:SetFormationIcon(true)
                AudioManager.PlayUiAudio(ENUM.EUiAudioType.InsertTeam);
            else
                --不打勾
                vv.heroCard:SetFormationIcon(false)
                AudioManager.PlayUiAudio(ENUM.EUiAudioType.InsertTeam);
            end
        end
    end
    if self.data.heroMaxNum == 3 then
        for i = 1, 3 do
            if self.teamData[i] == nil then
                self.teamData[i] = _param.info
                self:UpdateSingleHero(i, _param.info)
                --储存位置
                teamInfo[i] = _param.pos;
                break
            end
        end
    else
        if self.teamData[2] == nil then
            self.teamData[2] = _param.info
            self:UpdateSingleHero(2, _param.info)
        end
    end
    self:UpdateTotalFightValue()
    --self:UpdateCardGrayOrNot()    
end

--[[更新阵容]]
function CommonFormationUI:UpdateFormationInfo()
    if self.data.heroMaxNum == 3 then
        for i = 1, 3 do
            local cardData = self.teamData[i]
            self:UpdateSingleHero(i, cardData)
        end
    else
        self.headItemList[1].obj:set_active(false)
        self.headItemList[3].obj:set_active(false)
        self:UpdateSingleHero(2, self.teamData[2])
    end
end

function CommonFormationUI:UpdateSingleHero(uiIndex, cardData)
    local itemData = self.headItemList[uiIndex]
    local bigCard = itemData.bigCard
    itemData.btn:set_active(cardData ~= nil)
    itemData.txt:set_active(cardData == nil)
    itemData.pro:set_active(false)

    if cardData == nil then
        bigCard:SetData(nil, 1)
        bigCard:SetRecommend(false)
        return
    end
    --血条
    if self.data.showHPType then
        local _value = self:GetHPProgressValue(cardData)
        itemData.pro:set_active(true)
        itemData.pro:set_value(_value)
    end
    bigCard:SetData(cardData, 1)
    bigCard:SetRecommend(self:IsRecommend(cardData))
end

--[[更新总战力]]
function CommonFormationUI:UpdateTotalFightValue()
    local totalValue = 999999
    self.totalFightValue:set_text(tostring(totalValue))
    --[[
    local totalValue = 0
    local teamId = ENUM.ETeamType.unknow
    if not self:IsChurchPray(self.data.teamType) then
        teamId = self.data.teamType
    end

    for _, v in pairs(self.teamData) do
        if v then
            totalValue = totalValue + v:GetFightValue()
        end
    end
    self.totalFightValue:set_text(tostring(totalValue))
    --]]
end

--[[是否显示血条]]
function CommonFormationUI:HandleHP(heroCard, cardData)
    if heroCard == nil then
        return
    end
    if self.data.showHPType and cardData then
        local _value = self:GetHPProgressValue(cardData)
        heroCard:SetLifeBar(true, _value)
    else
        heroCard:SetLifeBar(false)
    end
end

--[[血量进度条值]]
function CommonFormationUI:GetHPProgressValue(cardData)
    if cardData == nil then
        app.log("cardData is nil "..debug.traceback())
        return 0
    end
    local _currValue = cardData:GetPlayMethodCurHP(self.data.showHPType)
    if _currValue == nil then
        return 1
    else
        local _maxValue = cardData:GetPropertyVal(ENUM.EHeroAttribute.max_hp)
        if _currValue >=  _maxValue then
            return 1
        else
            return _currValue / _maxValue
        end
    end
end

function CommonFormationUI:UpdateHeroPackage()
    self.selectedPos = -1
    local count = self:GetHeroDataCount()
    self.wrapContent:set_min_index(- math.ceil(count / 4) + 1);
    self.wrapContent:set_max_index(0);
    self.wrapContent:reset();
    self.scrollView:reset_position()
end

function CommonFormationUI:GetHeroDataByIndex(pos)
    return self.heroDataList[self.heroType][pos]
end

function CommonFormationUI:GetHeroDataCount()
    return #self.heroDataList[self.heroType]
end

function CommonFormationUI:SetHeroDataList()
    if self.heroDataList[self.heroType] == nil then
        local temp = {}
        for k,v in ipairs(self.heroDataList[ENUM.EProType.All]) do
            if v.pro_type == self.heroType then
                table.insert(temp, v);
            end
        end
        self.heroDataList[self.heroType] = temp;
    end
end

--[[
function CommonFormationUI:UpdateCardGrayOrNot()
    --所有变灰
    if self:IsTeamMemberFull() then
        for _, v in pairs(self.itemList) do
            for _, vv in pairs(v) do
                if self:IsChecked(vv.heroCard:GetCardInfo()) then
                else
                    vv.heroCard:SetGray(true)
                    PublicFunc.SetUISpriteGray(vv.spBlood)
                end
            end
        end  
    --所有恢复
    else
        for _, v in pairs(self.itemList) do
            for _, vv in pairs(v) do
                if self:IsDead(vv.heroCard:GetCardInfo()) then
                else
                    vv.heroCard:SetGray(false)
                    PublicFunc.SetUISpriteWhite(vv.spBlood)
                end
            end
        end        
    end
end
]]

--[[下阵]]
function CommonFormationUI:on_down_formation(t)
    local cardData = self.teamData[t.float_value]
    if cardData ~= nil then
        self.teamData[t.float_value]  = nil
        self:UpdateSingleHero(t.float_value, nil)
        self:UpdateTotalFightValue()
        --self:UpdateCardGrayOrNot()
        --取消勾
        for _, v in pairs(self.itemList) do
            for _, vv in pairs(v) do
                local _cardData = vv.heroCard:GetCardInfo()
                if _cardData and _cardData.index == cardData.index then
                    vv.heroCard:SetFormationIcon(false)
                    break
                end
            end
        end
    end
end

function CommonFormationUI:on_navbar_back(_showEmbattleUI, teamType)
    if self.data.teamType == ENUM.ETeamType.fuzion2 then
        if self:IsFormationChanged(self.data.teamType) then
            HintUI.SetAndShow(EHintUiType.two, _UIText[14], {str = _UIText[9]},
            {str = _UIText[8], func = self.bindfunc["on_pop_ui"]})
            return true
        end
    elseif self.data.teamType == ENUM.ETeamType.guild_war then
        uiManager:PopUi()
        if _showEmbattleUI == nil then
            _showEmbattleUI = false
        end
        g_dataCenter.guildWar:SetEmbattleInfo(_showEmbattleUI, teamType)
        PublicFunc.msg_dispatch("guild_war_close_common_formation_ui", self.data.guildWar.phase)
        return true
    end
    return false
end

function CommonFormationUI:on_pop_ui()
    uiManager:PopUi()
end

function CommonFormationUI:IsFormationChanged(_teamType)
    --上阵信息
    local _teamInfo = g_dataCenter.player:GetTeam(_teamType)
    --[[
    if self.data.heroMaxNum == 3 then
        for i = 1, 3 do
            local oldIndex = nil
            if _teamInfo and _teamInfo[i] then
                oldIndex = _teamInfo[i]
            end
            local newIndex = nil
            if self.teamData[i] then
                newIndex = self.teamData[i].index
            end
            if newIndex ~= oldIndex then
                return true
            end
        end
    else

    end
    return false
    ]]
    if teamInfo[1] == 999 then
        return true;
    elseif teamInfo[2] == 999 then
        return true;
    elseif teamInfo[3] == 999 then
        return true;
    else
        return false;
    end
end

function CommonFormationUI:on_save_guild_war_team()
    local _ids = self:GetSavedHeroIds(nil)
    local useDefault = false
    --布阵默认值 6,7,8
    local heroList = {}

    --选择了其它队伍，使用默认布阵
    if self.data.guildWar.phase == ENUM.GuildWarPhase.Defence then
        for k, v in ipairs(_ids) do
            local retInfo = self:GetGuildWarTeamInfo(v)
            local isIn = self:InInitList(v)
            if (not isIn) and retInfo ~= "" then
                useDefault = true
                break
            end
        end
    end

    for k, v in ipairs(_ids) do
        local _pos = k + 5
        if useDefault then
        else
            if self.data.guildWar.heroPosList[k] ~= nil then
                _pos = self.data.guildWar.heroPosList[k]
            end
        end
        table.insert(heroList, {dataid = v, pos =_pos})
    end
    if self.data.guildWar.phase == ENUM.GuildWarPhase.Defence then
        msg_guild_war.cg_set_guard_team(self.data.guildWar.nodeId, self.data.guildWar.teamId, heroList)
    else
        g_dataCenter.guildWar:SetTempMyAttackTeamInfo(heroList)
        self:on_navbar_back(true, 0)
    end
end

function CommonFormationUI:GetSavedHeroIds(idDefault)
    local _ids = {}
    local updatePos = false
    if self.data.heroMaxNum == 3 then
        --第二个位置为空，第三个位置不为空，移动到第二个位置
        if self.teamData[2] == nil and self.teamData[3] ~= nil then
            self.teamData[2] = self.teamData[3]
            self.teamData[3] = nil
            updatePos = true
        end
        for i = 1, self.data.heroMaxNum do
            if self.teamData[i] then
                _ids[i] = self.teamData[i].index
            else
                _ids[i] = idDefault
            end
        end
    else
        --第一个位置(ui第二个位置)
        _ids[1] = self.teamData[2].index
    end
    return _ids, updatePos
end

--[[保存阵容]]
function CommonFormationUI:on_save_formation(t)

    if teamInfo[1] == 999 or teamInfo[2] == 999 or teamInfo[3] == 999 then
        app.log("有空数据");
        return
    end

    self.teamData[1] = g_dataCenter.package:AddCard(ENUM.EPackageType.Hero, self:GetHeroDataByIndex(teamInfo[1]));
    self.teamData[2] = g_dataCenter.package:AddCard(ENUM.EPackageType.Hero, self:GetHeroDataByIndex(teamInfo[2]));
    self.teamData[3] = g_dataCenter.package:AddCard(ENUM.EPackageType.Hero, self:GetHeroDataByIndex(teamInfo[3]));
    
    --[[
    g_dataCenter.package:AddCard(ENUM.EPackageType.Hero, CommonFormationUI:GetHeroDataByIndex(1));
    g_dataCenter.package:AddCard(ENUM.EPackageType.Hero, CommonFormationUI:GetHeroDataByIndex(2));
    g_dataCenter.package:AddCard(ENUM.EPackageType.Hero, CommonFormationUI:GetHeroDataByIndex(3));
    g_dataCenter.package:AddCard(ENUM.EPackageType.Hero, CommonFormationUI:GetHeroDataByIndex(4));
    g_dataCenter.package:AddCard(ENUM.EPackageType.Hero, CommonFormationUI:GetHeroDataByIndex(5));
    g_dataCenter.package:AddCard(ENUM.EPackageType.Hero, CommonFormationUI:GetHeroDataByIndex(6));
    g_dataCenter.package:AddCard(ENUM.EPackageType.Hero, CommonFormationUI:GetHeroDataByIndex(7));
    g_dataCenter.package:AddCard(ENUM.EPackageType.Hero, CommonFormationUI:GetHeroDataByIndex(8));
    g_dataCenter.package:AddCard(ENUM.EPackageType.Hero, CommonFormationUI:GetHeroDataByIndex(9));
    g_dataCenter.package:AddCard(ENUM.EPackageType.Hero, CommonFormationUI:GetHeroDataByIndex(10));
    g_dataCenter.package:AddCard(ENUM.EPackageType.Hero, CommonFormationUI:GetHeroDataByIndex(11));
    g_dataCenter.package:AddCard(ENUM.EPackageType.Hero, CommonFormationUI:GetHeroDataByIndex(12));
    g_dataCenter.package:AddCard(ENUM.EPackageType.Hero, CommonFormationUI:GetHeroDataByIndex(13));
    g_dataCenter.package:AddCard(ENUM.EPackageType.Hero, CommonFormationUI:GetHeroDataByIndex(14));
    g_dataCenter.package:AddCard(ENUM.EPackageType.Hero, CommonFormationUI:GetHeroDataByIndex(15));
    g_dataCenter.package:AddCard(ENUM.EPackageType.Hero, CommonFormationUI:GetHeroDataByIndex(16));
    g_dataCenter.package:AddCard(ENUM.EPackageType.Hero, CommonFormationUI:GetHeroDataByIndex(17));
    g_dataCenter.package:AddCard(ENUM.EPackageType.Hero, CommonFormationUI:GetHeroDataByIndex(18));
    g_dataCenter.package:AddCard(ENUM.EPackageType.Hero, CommonFormationUI:GetHeroDataByIndex(19));
    g_dataCenter.package:AddCard(ENUM.EPackageType.Hero, CommonFormationUI:GetHeroDataByIndex(20));
    g_dataCenter.package:AddCard(ENUM.EPackageType.Hero, CommonFormationUI:GetHeroDataByIndex(21));
    g_dataCenter.package:AddCard(ENUM.EPackageType.Hero, CommonFormationUI:GetHeroDataByIndex(22));
    g_dataCenter.package:AddCard(ENUM.EPackageType.Hero, CommonFormationUI:GetHeroDataByIndex(23));
    g_dataCenter.package:AddCard(ENUM.EPackageType.Hero, CommonFormationUI:GetHeroDataByIndex(24));
    g_dataCenter.package:AddCard(ENUM.EPackageType.Hero, CommonFormationUI:GetHeroDataByIndex(25));
    g_dataCenter.package:AddCard(ENUM.EPackageType.Hero, CommonFormationUI:GetHeroDataByIndex(26));
    g_dataCenter.package:AddCard(ENUM.EPackageType.Hero, CommonFormationUI:GetHeroDataByIndex(27));
    g_dataCenter.package:AddCard(ENUM.EPackageType.Hero, CommonFormationUI:GetHeroDataByIndex(28));
    ]]

    local leaderData = nil
    --3个英雄
    if self.data.heroMaxNum == 3 then
        leaderData = self.teamData[1]
        app.log("选择英雄1");
    --1个英雄
    else
        leaderData = self.teamData[2]
        app.log("选择英雄2");
    end
    if leaderData == nil then
        if self.data.teamType == ENUM.ETeamType.fuzion2 then
            FloatTip.Float(_UIText[18])
        else
            FloatTip.Float(_UIText[4])
        end
        return
    end

    --[[if self.data.teamType == ENUM.ETeamType.guild_war then
        if self.data.guildWar.phase == ENUM.GuildWarPhase.Attack then
            if not self:IsTeamMemberFull() then
                HintUI.SetAndShow(EHintUiType.two, _UIText[12], {str = _UIText[8], func = self.bindfunc["on_save_guild_war_team"]},
                {str = _UIText[9]})
                return
            end
        else
            local _heroIds = {}
            for k, v in pairs(self.teamData) do
                table.insert(_heroIds, v.index)
            end
            if self.data.guildWar.teamId == 0 and g_dataCenter.guildWar:HaveThreeDenfenceTeam(_heroIds) then
                HintUI.SetAndShow(EHintUiType.two, _UIText[11], {str = _UIText[8], func = self.bindfunc["on_save_guild_war_team"]},
                {str = _UIText[9]})
                return
            end
        end
        self:on_save_guild_war_team()
        return
    end]]

    --local _team =
    --{
    --    ["teamid"] = self.data.teamType or 0,
    --    cards = self:GetSavedHeroIds(0),
    --}

    --msg_team.cg_update_team_info(_team)
    --
    --if self.data.teamType == ENUM.ETeamType.clone_fight then
    --    msg_clone_fight.cg_change_hero(self.teamData[2].index)
    --end

    
    GameInfoForThis.teams[self.data.teamType] = self.teamData;

    g_dataCenter.player:AddTeam(self.data.teamType, 1, self.teamData[1]);
    g_dataCenter.player:AddTeam(self.data.teamType, 2, self.teamData[2]);
    g_dataCenter.player:AddTeam(self.data.teamType, 3, self.teamData[3]);
    g_dataCenter.player:AddTeamPos(self.data.teamType, 1, self.teamData[1]);
    g_dataCenter.player:AddTeamPos(self.data.teamType, 2, self.teamData[2]);
    g_dataCenter.player:AddTeamPos(self.data.teamType, 3, self.teamData[3]);

    self:on_navbar_back(true, self.data.teamType)

    app.log("储存完成");
end

function CommonFormationUI:on_update_team()
    uiManager:PopUi()
    if self.data.saveCallback then
        Utility.CallFunc(self.data.saveCallback)
    end
end
