

BuildingEmbattleInfoUI = Class("BuildingEmbattleInfoUI", UiBaseClass)

--local sortByPosFun = function(a, b) return a[1] < b[1] end

local uiText = 
{
    [1] = '该英雄已经用于防守其他物件'
}

function BuildingEmbattleInfoUI:GetRes()
    return "assetbundles/prefabs/ui/wanfa/slg/ui_2308_slg_university.assetbundle"
end

function BuildingEmbattleInfoUI:Init(data)
    self.pathRes = self:GetRes()
    UiBaseClass.Init(self, data);
end

function BuildingEmbattleInfoUI:RegistFunc()
    UiBaseClass.RegistFunc(self);
    self.bindfunc["OnClickChangeHero"]	   = Utility.bind_callback(self, self.OnClickChangeHero)
--    self.bindfunc["OnClickOK"]	   = Utility.bind_callback(self, self.OnClickOK)
--    self.bindfunc["OnClickEmbattle"]	   = Utility.bind_callback(self, self.OnClickEmbattle)
--    self.embattleResultCallback	   = Utility.bind_callback(self, self.OnSetTeamPos)

    self.bindfunc["OnUpdateTeam"] = Utility.bind_callback(self, self.OnUpdateTeam)
end

function BuildingEmbattleInfoUI:MsgRegist()
    UiBaseClass.MsgRegist(self)

    PublicFunc.msg_regist(msg_team.gc_update_team_info, self.bindfunc['OnUpdateTeam'])
end

function BuildingEmbattleInfoUI:MsgUnRegist()
    UiBaseClass.MsgUnRegist(self)

    PublicFunc.msg_unregist(msg_team.gc_update_team_info, self.bindfunc['OnUpdateTeam'])
end

function BuildingEmbattleInfoUI:InitUI(asset_obj)
    UiBaseClass.InitUI(self, asset_obj)

    local cbmgr = CityBuildingMgr.GetInst()
    local bid = cbmgr:GetSelectedBuildingID()
    local level = cbmgr:GetBuildingLevel(bid)

    local label = ngui.find_label(self.ui, 'lab_level')
    label:set_text('Lv.' .. tostring(level))

    self.texName = "sp_cat"
    self.renderTex = self.ui:get_child_by_name(self.texName)
    self.modelRender = RenderTexture:new({ui_obj_root = self.renderTex, ui_texture_name = self.texName, model_id = SLGBuildingModeID[bid]})

    self.teamSmallCards = {}
    for i = 1,3 do
        local node = self.ui:get_child_by_name(string.format('sp_diban%d/big_card_item_80', i))
        self.teamSmallCards[i] = SmallCardUi:new({parent = node, sgroup = 1})
    end
    
    local btn = ngui.find_button(self.ui, 'btn1')
    btn:set_on_click(self.bindfunc["OnClickChangeHero"])

    self:UpdateUi()
end

function BuildingEmbattleInfoUI:Show()
    UiBaseClass.Show(self)

    self:UpdateUi()
end

function BuildingEmbattleInfoUI:UpdateUi()
    local cbmgr = CityBuildingMgr.GetInst()
    local bid = cbmgr:GetSelectedBuildingID()

    local temmType = CityBuildingID2TeamId[bid]
    if temmType == nil then return end

    local guardTeam = g_dataCenter.player:GetTeam(temmType)

    if guardTeam == nil then return end

    for i = 1,3 do
        local cardInfo = g_dataCenter.package:find_card(ENUM.EPackageType.Hero, guardTeam[i])
        self.teamSmallCards[i]:SetData(cardInfo)
    end
    
end

function BuildingEmbattleInfoUI:OnUpdateTeam(info,ret)

    local teamid = info["teamid"];

    local cbmgr = CityBuildingMgr.GetInst()
    local bid = cbmgr:GetSelectedBuildingID()

    local temmType = CityBuildingID2TeamId[bid]

    if tostring(teamid) == tostring(temmType) then
        self:UpdateUi()
    end
end

function BuildingEmbattleInfoUI:DestroyUi()
    UiBaseClass.DestroyUi(self)

    if self.modelRender then
        self.modelRender:Destroy()
        self.modelRender = nil
    end

    if self.teamSmallCards then
        for k,v in ipairs(self.teamSmallCards) do
            v:DestroyUi()
        end
        self.teamSmallCards = nil
    end
end

function BuildingEmbattleInfoUI:OnClickChangeHero()

    local cbmgr = CityBuildingMgr.GetInst()
    local bid = cbmgr:GetSelectedBuildingID()

    local temmType = CityBuildingID2TeamId[bid]
    if temmType then
        local ui = uiManager:PushUi(EUI.FormationUi)
        ui:SetPlayerGID(g_dataCenter.player.playerid, temmType, nil, nil, nil, false)
        ui:SetUseArrange(true)
    end
end

--function BuildingEmbattleInfoUI:OnClickChangeHero(paramOri)
--    local param = paramOri
--    if type(param) ~= 'number' then
--        param = paramOri.float_value
--    end

--    self:OnChangeHero(param)
--end

--function BuildingEmbattleInfoUI:OnChangeHero(param)
--    local ui = uiManager:PushUi(EUI.BuildingEmbattleChoseHeroUI)
--    ui:SetHasEmbattleTeam(self.teamEmbattle, param)
--end

--function BuildingEmbattleInfoUI:GetHasEmbattleHeroCount()
--    local num = 0;
--    for k,v in ipairs(self.teamEmbattle) do 
--        if v[1] ~= nil and v[2] ~= nil then
--            num = num + 1
--        end
--    end

--    return num
--end

--function BuildingEmbattleInfoUI:OnSetTeamPos(teamPos,monsterPos)

--    --app.log('OnSetTeamPos old ' .. table.tostring(self.teamEmbattle))
--    for i = 1,3 do
--        if teamPos[i] ~= nil then
--            self.teamEmbattle[i][1] = teamPos[i]

--            for ii = 1, 3 do
--                if i ~= ii then
--                    if self.teamEmbattle[ii][1] == teamPos[i] then
--                        self.teamEmbattle[ii][1] = self:GetUnUsePos()
--                    end                
--                end
--            end


--        end       
--    end
--    --app.log('OnSetTeamPos new ' .. table.tostring(self.teamEmbattle))
--    self:SaveTeamPos()
--end

--function BuildingEmbattleInfoUI:SaveTeamPos()
--    CityBuildingMgr.GetInst():SetBuildingGuardHero(self.teamEmbattle)
--end

--function BuildingEmbattleInfoUI:OnClickEmbattle()
--    if self:GetHasEmbattleHeroCount() == 0 then
--        HintUI.SetAndShow(EHintUiType.zero, gs_misc['embattle_hero_count_less'])
--        return
--    end

--    local heroList = {}
--    local posList = {}
--    for k,v in ipairs(self.teamEmbattle) do 
--        if v[1] ~= nil and v[2] ~= nil then
--            table.insert(posList, v[1])
--            table.insert(heroList, v[2])
--        end
--    end
--    local ui = uiManager:PushUi(EUI.ArrangeBattleUI);
--    ui:SetTeam(heroList, posList)
--    ui:SetResultCallback(self.embattleResultCallback);
--end

--function BuildingEmbattleInfoUI:InitUI(obj)
--	self.ui = asset_game_object.create(obj);
--	self.ui:set_parent(Root.get_root_ui_2d());
--	self.ui:set_name("ui_2309_slg_university");
--	self.ui:set_local_scale(Utility.SetUIAdaptation());
--	self.ui:set_local_position(0,0,0);

--    if BuildingEmbattleChoseHeroUI.GbuildingEmbattleSave ~= nil then

--        self.isLoadEmbattle = true
--        self.teamEmbattle = BuildingEmbattleChoseHeroUI.GbuildingEmbattleSave

--        BuildingEmbattleChoseHeroUI.GbuildingEmbattleSave = nil
--    end
--    self.isLoadEmbattle = false

--    self:_SetBuildingGuardEmbattle()

--    self.fightShowRole = {}
--    local sp = ngui.find_sprite(self.ui, 'sp_di1/sp_leader'):get_parent()
--    local cardInfo = nil
--    if self.teamEmbattle[1][2] ~= nil then
--        cardInfo = g_dataCenter.package:find_card(1,self.teamEmbattle[1][2]);
--        if cardInfo == nil then
--            self.teamEmbattle[1][2] = nil
--        end
--    end
--    self.fightShowRole[#self.fightShowRole + 1] = FightShowRole:new({obj=sp, info= cardInfo, isLeader = nil, isChange = true})
--    self.fightShowRole[#self.fightShowRole]:SetParam(#self.fightShowRole)
--    self.fightShowRole[#self.fightShowRole]:SetOnClickAddButton(self.bindfunc["OnClickChangeHero"])
--    self.fightShowRole[#self.fightShowRole]:SetOnClickChangeButton(self.bindfunc["OnClickChangeHero"])

--    sp = ngui.find_sprite(self.ui, 'sp_di2/sp_leader'):get_parent()
--    cardInfo = nil
--    if self.teamEmbattle[2][2] ~= nil then
--        cardInfo = g_dataCenter.package:find_card(1,self.teamEmbattle[2][2]);
--        if cardInfo == nil then
--            self.teamEmbattle[2][2] = nil
--        end
--    end
--    self.fightShowRole[#self.fightShowRole + 1] = FightShowRole:new({obj=sp, info= cardInfo, isLeader = nil, isChange = true})
--    self.fightShowRole[#self.fightShowRole]:SetParam(#self.fightShowRole)
--    self.fightShowRole[#self.fightShowRole]:SetOnClickAddButton(self.bindfunc["OnClickChangeHero"])
--    self.fightShowRole[#self.fightShowRole]:SetOnClickChangeButton(self.bindfunc["OnClickChangeHero"])

--    sp = ngui.find_sprite(self.ui, 'sp_di3/sp_leader'):get_parent()
--    cardInfo = nil
--    if self.teamEmbattle[3][2] ~= nil then
--        cardInfo = g_dataCenter.package:find_card(1,self.teamEmbattle[3][2]);
--        if cardInfo == nil then
--            self.teamEmbattle[3][2] = nil
--        end
--    end
--    self.fightShowRole[#self.fightShowRole + 1] = FightShowRole:new({obj=sp, info= cardInfo, isLeader = nil, isChange = true})
--    self.fightShowRole[#self.fightShowRole]:SetParam(#self.fightShowRole)
--    self.fightShowRole[#self.fightShowRole]:SetOnClickAddButton(self.bindfunc["OnClickChangeHero"])
--    self.fightShowRole[#self.fightShowRole]:SetOnClickChangeButton(self.bindfunc["OnClickChangeHero"])

--    for i = 1, 3 do
--        local btnAddHero = ngui.find_button(self.ui,"cont/sp_bk"..i);
--        btnAddHero:set_event_value(tostring(i), i)
--        btnAddHero:set_on_click(self.bindfunc["OnClickChangeHero"]);
--    end

--    --local btn = ngui.find_button(self.ui, 'btn_start')
--    --btn:set_on_click(self.bindfunc["OnClickOK"])
--    sp = ngui.find_sprite(self.ui, 'content1/sp_lock')
--    sp:set_active(false)
--    sp = ngui.find_sprite(self.ui, 'content1/sp_point')
--    sp:set_active(false)

--    local btn = ngui.find_button(self.ui, 'content1')
--    btn:set_on_click(self.bindfunc["OnClickEmbattle"])

--    btn = ngui.find_button(self.ui, 'content2')
--    btn:set_active(false)

--    btn = ngui.find_button(self.ui, 'content3')
--    btn:set_active(false)

--    btn = ngui.find_button(self.ui, 'btn_left_arrows')
--    btn:set_active(false)

--    btn = ngui.find_button(self.ui, 'btn_right_arrows')
--    btn:set_active(false)

--    self:InitLeftUIContent()

--    self.uiCount = uiManager:GetUICount()

--    local label = ngui.find_label(self.ui, 'sp_title_content/txt')
--    label:set_text(gs_misc['str_29'])
--end

--function BuildingEmbattleInfoUI:Show()
--    if not self.ui then
--        return
--    end

--    UiBaseClass.Show(self)
--    self:UpdateUi()
--end

--function BuildingEmbattleInfoUI:UpdateUi()
--    for i = 1,3  do
--        local cardInfo = nil
--        if self.teamEmbattle[i][2] ~= nil then
--            cardInfo = g_dataCenter.package:find_card(1,self.teamEmbattle[i][2]);
--        end

--        local sr = self.fightShowRole[i]
--        if sr:GetInfo() ~= cardInfo  then
--            sr:SetInfo(cardInfo)
--        end
--    end

--end

--function BuildingEmbattleInfoUI:InitLeftUIContent()

----    local cbmgr = CityBuildingMgr.GetInst()
----    local bid = cbmgr:GetSelectedBuildingID()
----    local level = cbmgr:GetBuildingLevel(bid)
----    local buildingConfig = cbmgr:GetBuildingConfigFromID(bid)

----    local label = ngui.find_label(self.ui, 'lab1')
----    label:set_text(buildingConfig.name)
----    label = ngui.find_label(self.ui, 'lab2')
----    label:set_text('LV.' .. tostring(level))

----    local sp = ngui.find_sprite(self.ui, 'sp_house')
----    sp:set_sprite_name(BuildingID2SpriteName[bid])
--end

--function BuildingEmbattleInfoUI:_SetBuildingGuardEmbattle()
--    if self.isLoadEmbattle == true then
--        return
--    end

--    self:SetBuildingGuardEmbattle()

--    self.isLoadEmbattle = true
--end

--function BuildingEmbattleInfoUI:SetBuildingGuardEmbattle()

--    local cbmgr = CityBuildingMgr.GetInst()
--    local bid = cbmgr:GetSelectedBuildingID()
--    local guardHero = cbmgr:GetBuildingGuardHero(bid)
--    if guardHero ~= nil then
----        local heros = Utility.lua_string_split(guardHero, ';')
----        for k,v in ipairs(heros) do
----            local pos2Hero = Utility.lua_string_split(v, '=')
----            if #pos2Hero == 2 then
----                local pos = tonumber(pos2Hero[1])
----                if pos >=0 and pos <=12 then
----                    table.insert(self.teamEmbattle, {pos, pos2Hero[2]})
----                end
----            end
----        end
--        self.teamEmbattle = CityBuildingMgr.embattleStrToTable(guardHero)
--    end

--    for i=1,3  do
--        if self.teamEmbattle[i] ==nil then
--            self.teamEmbattle[i] = {self:GetUnUsePos(),nil}
--        end
--    end

--    -- table.sort(self.teamEmbattle, sortByPosFun)

--end

--function BuildingEmbattleInfoUI:GetUnUsePos()

--    local posOrder = {7, 3, 11, 0, 1, 2, 4, 5, 6, 8, 9, 10, 12}

--    for index = 1,13 do
--        local canUse = true
--        local pos = posOrder[index]
--        for k,v in pairs(self.teamEmbattle) do
--            if pos == v[1] then
--                canUse = false
--                break
--            end
--        end

--        if canUse == true then
--            return pos
--        end
--    end

--    return nil;
--end

--function BuildingEmbattleInfoUI:DestroyUi()

--    if self.ui ~= nil then
--        for k,v in ipairs(self.fightShowRole) do 
--            v:Destroy()
--        end

--        if self.uiCount >= uiManager:GetUICount() then
--            self.isLoadEmbattle = false
--        end
--    end

--    UiBaseClass.DestroyUi(self);

--    Utility.unbind_callback(self, self.embattleResultCallback)
--    self.embattleResultCallback = nil
--end