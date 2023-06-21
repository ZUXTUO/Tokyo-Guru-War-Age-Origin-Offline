TargetBuildingEmbattleInfoUI = Class("TargetBuildingEmbattleInfoUI", UiBaseClass)

local uiText = 
{
    [1] = '%s%d积分',
    [2] = '掠夺阵容',
    [3] = '更换阵容',
    [4] = '%s的%s',
}

local SLGTargetBuildingInfoFile = 'SLGTargetBuildingInfoFileSave'

function TargetBuildingEmbattleInfoUI:GetRes()
    return "assetbundles/prefabs/ui/wanfa/slg/ui_2310_slg_university.assetbundle"
end

function TargetBuildingEmbattleInfoUI:Init(data)
    self.pathRes = self:GetRes()
    UiBaseClass.Init(self, data);
end

function TargetBuildingEmbattleInfoUI:RegistFunc()
    UiBaseClass.RegistFunc(self);

    self.bindfunc["OnReponseBeginFightRet"] = Utility.bind_callback(self,self.OnReponseBeginFightRet)
    self.bindfunc["OnServerReponseTargetNotGuard"] = Utility.bind_callback(self,self.OnServerReponseTargetNotGuard)

    self.bindfunc["OnClickClose"] = Utility.bind_callback(self,self.OnClickClose)
    self.bindfunc["OnViewTargetEmbattle"] = Utility.bind_callback(self,self.OnViewTargetEmbattle)
    self.bindfunc["OnClickChangeEmbattle"] = Utility.bind_callback(self,self.OnClickChangeEmbattle)
    self.bindfunc["OnConfirmEmbattle"] = Utility.bind_callback(self,self.OnConfirmEmbattle)
end

function TargetBuildingEmbattleInfoUI:OnClickClose()
    uiManager:PopUi()
end

function TargetBuildingEmbattleInfoUI:OnClickRobbery()
    
end

function TargetBuildingEmbattleInfoUI:OnViewTargetEmbattle()

    local crmgr = CityRobberyMgr.GetInst()
    local targetPlayer = crmgr:GetTargetPlayer()
    local bid = crmgr:GetSelectedBuildingID()
    
    OtherPlayerPanel.ShowPlayer(targetPlayer:GetGID(), CityBuildingID2TeamId[bid]) 
end

function TargetBuildingEmbattleInfoUI:OnClickChangeEmbattle()
    
    local crmgr = CityRobberyMgr.GetInst()
    local bid = crmgr:GetSelectedBuildingID()
    local temmType = CityBuildingID2TeamId[bid]
    if temmType then
        local ui = uiManager:PushUi(EUI.AttackBuildingEmbattleChoseHeroUI)
        ui:SetPlayerGID(g_dataCenter.player.playerid, nil, nil, nil, nil, false)
        ui:SetUseArrange(true)
        ui:SetTeamAndPos(self.currentTeam)
    end
end

function TargetBuildingEmbattleInfoUI:InitUI(asset_obj)
    UiBaseClass.InitUI(self, asset_obj)

    local cbmgr = CityBuildingMgr.GetInst()
    local crmgr = CityRobberyMgr.GetInst()
    local targetPlayer = crmgr:GetTargetPlayer()
    local bid = crmgr:GetSelectedBuildingID()

    local buildingConfig = cbmgr:GetBuildingConfigFromID(bid)
    local bi = crmgr:GetTargetBuildingInfo(bid)

    local label = ngui.find_label(self.ui, 'lab_level')
    label:set_text('Lv.' .. tostring(targetPlayer:GetLevel()))

    label = ngui.find_label(self.ui, 'sp_title/lab')
    label:set_text(string.format(uiText[4], tostring(targetPlayer:GetName()), buildingConfig.name))

    local texName = "sp_cat"
    local renderTex = self.ui:get_child_by_name(texName)
    self.modelRender = RenderTexture:new({ui_obj_root = renderTex, ui_texture_name = texName, model_id = SLGBuildingModeID[bid]})

    self.totalNumTex = ngui.find_texture(self.ui, 'txt1/sp_gold')
    self.totalNumTex:set_texture(SLGiconsPath[bid])
    label = ngui.find_label(self.ui, 'txt1/lab_num')
    label:set_text(tostring(bi.resource))

    self.canRobberyNumTex = ngui.find_texture(self.ui, 'txt2/sp_gold')
    self.canRobberyNumTex:set_texture(SLGiconsPath[bid])
    label = ngui.find_label(self.ui, 'txt2/lab_num')
    local robberyNum = bi.resource * 0.2
    if robberyNum > ConfigManager.Get(EConfigIndex.t_building,bid).max_robbery_num then
        robberyNum = ConfigManager.Get(EConfigIndex.t_building,bid).max_robbery_num
    end
    label:set_text(string.format("%d", robberyNum))

    local scoreAddLab = ngui.find_label(self.ui, 'txt3')
    local scoreMinusLab = ngui.find_label(self.ui, 'txt4')
    if bid == CityBuildingID.teachingBuildID and not crmgr:HasRobbedMainBuilding() then
        local w,l = crmgr:GetWinAndLostScoreChange()
        label = ngui.find_label(self.ui, 'txt3/lab_num')
        label:set_text(string.format(uiText[1], '+', w))
        label = ngui.find_label(self.ui, 'txt4/lab_num')
        label:set_text(string.format(uiText[1], '', l))
    else
        label = ngui.find_label(self.ui, 'txt3')
        label:set_active(false)
        label = ngui.find_label(self.ui, 'txt4')
        label:set_active(false)
    end

    local node = self.ui:get_child_by_name('sp_di2')
    node:set_active(false)
    label = ngui.find_label(self.ui, 'sp_title/lab_name')
    label:set_text(uiText[2])
    label = ngui.find_label(self.ui, 'sp_bk/btn1/lab')
    label:set_text(uiText[3])

    local btn = ngui.find_button(self.ui, 'btn_cha')
    btn:set_on_click(self.bindfunc["OnClickClose"])

    btn = ngui.find_button(self.ui, 'btn1')
    btn:set_on_click(self.bindfunc["OnViewTargetEmbattle"])

    btn = ngui.find_button(self.ui, 'sp_bk/btn1')
    btn:set_on_click(self.bindfunc["OnClickChangeEmbattle"])

    btn = ngui.find_button(self.ui, 'btn2')
    btn:set_on_click(self.bindfunc["OnConfirmEmbattle"])

    self:ReadSaveTeam()

    self.teamSmallCards = {}
    for i =1, 3 do
        local node = self.ui:get_child_by_name(string.format('sp_diban%d/big_card_item_80', i))

        self.teamSmallCards[i] = SmallCardUi:new({parent = node, sgroup = 1})
    end
    
    self:UpdateUi()
end

function TargetBuildingEmbattleInfoUI:Show()
    UiBaseClass.Show(self)

    self:UpdateUi()
end

function TargetBuildingEmbattleInfoUI:UpdateUi()

    if self.ui == nil then return end

    local team = self.currentTeam.team
    --app.log('------------- ' .. table.tostring(self.currentTeam))
    for i = 1,3 do
        local cardInfo = g_dataCenter.package:find_card(ENUM.EPackageType.Hero, team[i])
        self.teamSmallCards[i]:SetData(cardInfo)
    end
end

function TargetBuildingEmbattleInfoUI:ReadSaveTeam()

--[[
    self.currentTeam = 
    {
        team = {dataid, dataid, dataid},
        pos = {pos, pos, pos},
    }
]]
    self.currentTeam = nil
    if file.exist(SLGTargetBuildingInfoFile) then
        local fileHandler = file.open(SLGTargetBuildingInfoFile,4);
        local embattleStr = ''
        if fileHandler then
            embattleStr = fileHandler:read_string()
            fileHandler:close()
        end
       -- app.log('------------- ' .. embattleStr)
        local k = loadstring(embattleStr)
        if k then
            local saveTable = k()
            if type(saveTable) == 'table' then
                self.currentTeam = saveTable

                --app.log('------------- 2')
            else
                --app.log('SLGTargetBuildingInfoFile type error! ' .. tostring(saveTable))
            end
        else
            --app.log('SLGTargetBuildingInfoFile format error!')
        end
    end
    if self.currentTeam == nil then
        self.currentTeam = {team = {}, pos = {7, 3, 11}}
    end

    local hasDeadHero = CityRobberyMgr.GetInst():GetHasDeadHeros()
    for k,v in pairs(self.currentTeam.team) do
        if hasDeadHero[v] == true then
            self.currentTeam.team[k] = nil
        end
    end

    return team
end

function TargetBuildingEmbattleInfoUI:WriteSaveTeam()
    if file.exist(SLGTargetBuildingInfoFile) then
        file.delete(SLGTargetBuildingInfoFile)
    end

    local file_handler = file.open(SLGTargetBuildingInfoFile,4);
    if file_handler and self.currentTeam then
        file_handler:write_string('return ' .. table.toLuaString(self.currentTeam));
	    file_handler:close();
    end
end

function TargetBuildingEmbattleInfoUI:ShowNavigationBar()
    return false
end

function TargetBuildingEmbattleInfoUI:DestroyUi()
    UiBaseClass.DestroyUi(self);

    if self.modelRender then
        self.modelRender:Destroy()
        self.modelRender = nil
    end

    if self.totalNumTex then
        self.totalNumTex:Destroy()
        self.totalNumTex = nil
    end

    if self.canRobberyNumTex then
        self.canRobberyNumTex:Destroy()
        self.canRobberyNumTex = nil
    end
end

--function TargetBuildingEmbattleInfoUI:RegistFunc()
--	BuildingEmbattleInfoUI.RegistFunc(self)
--    self.bindfunc["OnReponseBeginFightRet"] = Utility.bind_callback(self,self.OnReponseBeginFightRet)
--    self.bindfunc["OnServerReponseTargetNotGuard"] = Utility.bind_callback(self,self.OnServerReponseTargetNotGuard)

--    self.bindfunc["OnViewTargetEmbattle"] = Utility.bind_callback(self,self.OnViewTargetEmbattle)
--    self.bindfunc["OnConfirmEmbattle"] = Utility.bind_callback(self,self.OnConfirmEmbattle)
--    self.bindfunc["OnClickBack"] = Utility.bind_callback(self,self.OnClickBack)
--    self.bindfunc["OnClickRuleBtn"] = Utility.bind_callback(self, self.OnClickRuleBtn);
--end

--function TargetBuildingEmbattleInfoUI:ShowNavigationBar()
--    return false
--end

--function TargetBuildingEmbattleInfoUI:OnChangeHero(param)

--    local ui = uiManager:PushUi(EUI.AttackBuildingEmbattleChoseHeroUI)
--    ui:SetHasEmbattleTeam(self.teamEmbattle, param)
--end

--function TargetBuildingEmbattleInfoUI:SaveTeamPos()
--    app.log('================= TargetBuildingEmbattleInfoUI:SaveTeamPos')
--end

--function TargetBuildingEmbattleInfoUI:SetBuildingGuardEmbattle()

----    for i=1,3  do
----        self.teamEmbattle[i] = {self:GetUnUsePos(),nil}
----    end

--    if file.exist(SLGTargetBuildingInfoFile) then
--        local fileHandler = file.open(SLGTargetBuildingInfoFile,4);
--        local embattleStr = ''
--        if fileHandler then
--            embattleStr = fileHandler:read_string()
--            fileHandler:close()
--        end
--        --app.log(embattleStr .. '333')
--        self.teamEmbattle = CityBuildingMgr.embattleStrToTable(embattleStr)

--        local hasDeadHero = CityRobberyMgr.GetInst():GetHasDeadHeros()
--        for i = #self.teamEmbattle,1,-1 do
--            if hasDeadHero[self.teamEmbattle[i][2]] == true then
--                table.remove(self.teamEmbattle, i)
--            end
--        end
--    end

--    local needCount = 3 - #self.teamEmbattle
--    if needCount > 0 then
--        for i=1,needCount do
--            table.insert(self.teamEmbattle, {self:GetUnUsePos(),nil})
--        end
--    end
--end

--function TargetBuildingEmbattleInfoUI:InitLeftUIContent()

--    if self.ui ~= nil then
--        local cbmgr = CityBuildingMgr.GetInst()
--        local crmgr = CityRobberyMgr.GetInst()
--        local targetPlayer = crmgr:GetTargetPlayer()
--        local bid = crmgr:GetSelectedBuildingID()

--        local buildingConfig = cbmgr:GetBuildingConfigFromID(bid)
--        local bi = crmgr:GetTargetBuildingInfo(bid)

--        local label = ngui.find_label(self.ui, 'lab_name')
--        label:set_text(string.format(gs_misc['str_14'], tostring(targetPlayer:GetName()), tostring(buildingConfig.name)))

--        label = ngui.find_label(self.ui, 'lab_level')
--        label:set_text('LV.' .. tostring(targetPlayer:GetLevel()))

--        local btn = ngui.find_button(self.ui, 'center_other/btn_rule')
--        btn:set_on_click(self.bindfunc["OnViewTargetEmbattle"])

--        btn = ngui.find_button(self.ui, 'btn_start')
--        btn:set_on_click(self.bindfunc["OnConfirmEmbattle"])

--        btn = ngui.find_button(self.ui, 'top_other/btn_back')
--        btn:set_on_click(self.bindfunc["OnClickBack"])

--        label = ngui.find_label(self.ui, 'txt1/lab_num')
--        label:set_text(tostring(bi.resource))
--        self.totoalResourceTex = ngui.find_texture(self.ui, 'txt1/sp_gold')
--        self.totoalResourceTex:set_texture(SLGiconsPath[bid])

--        label = ngui.find_label(self.ui, 'txt2/lab_num')
--        local robberyNum = bi.resource * 0.2
--        if robberyNum > ConfigManager.Get(EConfigIndex.t_building,bid).max_robbery_num then
--            robberyNum = ConfigManager.Get(EConfigIndex.t_building,bid).max_robbery_num
--        end
--        label:set_text(string.format("%d", robberyNum))
--        self.canRobberyResourceTex = ngui.find_texture(self.ui, 'txt2/sp_gold')
--        self.canRobberyResourceTex:set_texture(SLGiconsPath[bid])

--        label = ngui.find_label(self.ui, 'txt3')
--        label:set_active(false)

--        self.texName = "sp_house"
--        self.renderTex = self.ui:get_child_by_name(self.texName)
--        self.modelRender = RenderTexture:new({ui_obj_root = self.renderTex, ui_texture_name = self.texName, model_id = SLGBuildingModeID[bid]})

--        local btn = ngui.find_button(self.ui, 'btn_rule')
--        btn:set_on_click(self.bindfunc["OnClickRuleBtn"])

--    end
--end

--function TargetBuildingEmbattleInfoUI:OnClickRuleBtn()
--    uiManager:PushUi(EUI.UiRuleDesNoNavBar,ENUM.ERuleDesType.XiaoYuanJianSheLueDuo)
--end

--function TargetBuildingEmbattleInfoUI:OnClickBack()
--    uiManager:PopUi()
--end

--function TargetBuildingEmbattleInfoUI:OnViewTargetEmbattle()

--    local teamType = 
--    {
--        [CityBuildingID.teachingBuildID] = ENUM.ETeamType.city_building_teaching_build;
--        [CityBuildingID.diningRoomID] = ENUM.ETeamType.city_building_dining_room;
--        [CityBuildingID.libraryID] = ENUM.ETeamType.city_building_library;
--    }

--    local crmgr = CityRobberyMgr.GetInst()
--    local targetPlayer = crmgr:GetTargetPlayer()
--    local gid = targetPlayer:GetGID()
--    local bid = crmgr:GetSelectedBuildingID()

--    local ui = uiManager:PushUi(EUI.FormationUi,1);
--    ui:SetPlayerGID(gid,teamType[bid]);  
--end

function TargetBuildingEmbattleInfoUI:OnConfirmEmbattle()

    if table.get_num(self.currentTeam.team) < 1 then
        HintUI.SetAndShow(EHintUiType.zero, gs_misc['embattle_hero_count_less'])
        return
    end

    local crmgr = CityRobberyMgr.GetInst()
    local bid = crmgr:GetSelectedBuildingID()

    local bi = crmgr:GetTargetBuildingInfo(bid)

    local hero = {}
	for k,v in pairs(self.currentTeam.team) do
        if v ~= nil then
            table.insert(hero, v)

            -- todo hyg test
            -- crmgr:AddHasDeadHero(v)
        end
    end
    self:WriteSaveTeam()
    if string.len(bi.guardHero) < 1 then 
        self.loadingId = GLoading.Show(GLoading.EType.ui) 
        --app.log('xxx ' .. table.tostring(self.teamEmbattle))
        msg_city_building.cg_robbery_target_not_guard(bid, hero, self.bindfunc["OnServerReponseTargetNotGuard"])
    else
        msg_city_building.cg_begin_robbery_fight(bid, hero, self.bindfunc["OnReponseBeginFightRet"])
        self.loadingId = GLoading.Show(GLoading.EType.ui) 
    end
end

function TargetBuildingEmbattleInfoUI:OnServerReponseTargetNotGuard(ret, sr)
    GLoading.Hide(GLoading.EType.ui, self.loadingId)
    local show,info = PublicFunc.GetErrorString(ret, false);
    if show then
        local crmgr = CityRobberyMgr.GetInst()
        crmgr:AddHasRobberyBuildingID(sr.buildingid)

        local hero = {}
	    for k,em in pairs(self.currentTeam.team) do
            if em ~= nil then
                table.insert(hero, em)
            end
        end
        for k,v in ipairs(hero) do
            crmgr:AddPlayerHasUsedHero(v)
        end

        crmgr:SetHasRobbedAnyBuilding(true)
        if sr.buildingid == CityBuildingID.teachingBuildID then
            crmgr:SetHasRobbedMainBuilding(true)
        end

        crmgr:SetIsRobbingBuildingID(sr.buildingi)
        crmgr:SetCurrentBothSideFightHero()

        ChengJianRobberyFightManager.OnEndRobberyFightShowSettlement(ret, sr)

        uiManager:PopUi()

        if crmgr:HasRobberyAllResource() then
            --uiManager:PopUi()
            crmgr:ClearTarget()
            return 
        end
    else
        HintUI.SetAndShow(EHintUiType.zero, info)
    end
end

function TargetBuildingEmbattleInfoUI:OnReponseBeginFightRet(ret, buildingid)
    self.loadingId = GLoading.Hide(GLoading.EType.ui)
    if ret == 0 then
        local crmgr = CityRobberyMgr.GetInst()
        crmgr:SetHasRobbedAnyBuilding(true)
        if buildingid == CityBuildingID.teachingBuildID then
            crmgr:SetHasRobbedMainBuilding(true)
        end
        self:OnBeginFight()
    else
        HintUI.SetAndShow(EHintUiType.zero, "OnReponseBeginFightRet Failed:" .. ret)
    end
end

--function TargetBuildingEmbattleInfoUI:SaveAttackHeros()
--    local embattleStr = CityBuildingMgr.embattleTableToStr(self.teamEmbattle)
--    local fileHandler = file.open(SLGTargetBuildingInfoFile,2);
--    if fileHandler then
--        fileHandler:write_string(embattleStr)
--        fileHandler:close()
--    end
--end

function TargetBuildingEmbattleInfoUI:OnBeginFight()

    local hero = {}
    local embattle = {}
	for k,em in pairs(self.currentTeam.team) do
        if em ~= nil then
            table.insert(hero, em)
            table.insert(embattle, {index =em, pos = self.currentTeam.pos[k]})
        end
    end

    uiManager:PopUi(nil, true)

    local fs = FightStartUpInf:new()

    fs:SetPlayMethod(MsgEnum.eactivity_time.eActivityTime_SLG)
    --玩法ID修改后需要注意
    fs:SetLevelIndex(60106000)
    local fs1res = fs:AddFightPlayer(g_dataCenter.fight_info.single_friend_flag, g_dataCenter.player, nil, EFightPlayerType.human, hero, {teamPos = embattle})

    --local heroList = PublicFunc.GetAllHero(ENUM.EShowHeroType.Have);
    local heroList = PublicFunc.GetAllHero(ENUM.EShowHeroType.All);
    local targetHero = {}
    local targetEmbattle = {}

    local crmgr = CityRobberyMgr.GetInst()
    local bid = crmgr:GetSelectedBuildingID()
    local bi = crmgr:GetTargetBuildingInfo(bid)
    local te = CityBuildingMgr.embattleStrToTable(bi.guardHero)
    for k,v in pairs(te) do
        table.insert(targetHero, v[2])
        table.insert(targetEmbattle, {index =v[2], pos = v[1] })
    end
    local targetPlaeyr = crmgr:GetTargetPlayer()
    local fs2res = fs:AddFightPlayer(g_dataCenter.fight_info.single_enemy_flag, targetPlaeyr, nil, EFightPlayerType.human, targetHero, {teamPos = targetEmbattle})
    if fs1res == true and fs2res == true then
        SceneManager.PushScene(FightScene,fs)

        crmgr:SetIsRobbingBuildingID(bid)
        crmgr:SetCurrentBothSideFightHero(hero, targetHero)
        for k,v in ipairs(hero) do
            crmgr:AddPlayerHasUsedHero(v)
        end

    else
        app.log('begin fight scene error')
    end
end

--function TargetBuildingEmbattleInfoUI:DestroyModel()

--    if self.ui ~= nil then
--        self.totoalResourceTex:Destroy()
--        self.totoalResourceTex = nil
--        self.canRobberyResourceTex:Destroy()
--        self.canRobberyResourceTex = nil
--    end
--    if self.modelRender then
--        self.modelRender:Destroy()
--        self.modelRender = nil
--    end
--end

--function TargetBuildingEmbattleInfoUI:DestroyUi()
--    BuildingEmbattleInfoUI.DestroyUi(self)

--    self:DestroyModel()
--end
