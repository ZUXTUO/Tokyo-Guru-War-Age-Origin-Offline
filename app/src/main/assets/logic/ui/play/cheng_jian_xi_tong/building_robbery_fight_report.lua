
BuildingRobberyFightReport = Class("BuildingRobberyFightReport", UiBaseClass)

function BuildingRobberyFightReport:Init(data)
    --ui/wanfa/slg
	self.pathRes = "assetbundles/prefabs/ui/wanfa/slg/ui_2304_slg_fight_report.assetbundle";
	UiBaseClass.Init(self, data);
end

function BuildingRobberyFightReport:Restart(data)
	if UiBaseClass.Restart(self, data) then
	--todo 
	end
end

function BuildingRobberyFightReport:InitData(data)
	UiBaseClass.InitData(self, data);
    self.reportCache = {}
    self.smallCardItems = {}
end

function BuildingRobberyFightReport:DestroyUi()
    UiBaseClass.DestroyUi(self);
    GLoading.Hide(GLoading.EType.ui, self.loadingId);
    self.reportCache = {}

    for k,v in pairs(self.smallCardItems) do
        for ik,smallItem in ipairs(v) do
            smallItem:DestroyUi()
        end
    end
end

function BuildingRobberyFightReport:RegistFunc()
	UiBaseClass.RegistFunc(self);
    self.bindfunc["OnServerReponseFightReport"]	   = Utility.bind_callback(self, BuildingRobberyFightReport.OnServerReponseFightReport);
    self.bindfunc["InitWrapContentItem"]	   = Utility.bind_callback(self, BuildingRobberyFightReport.InitWrapContentItem);
    self.bindfunc["OnGuardTabToggleChange"] = Utility.bind_callback(self, BuildingRobberyFightReport.OnGuardTabToggleChange);
    self.bindfunc["OnClickShowPlayerInfo"] = Utility.bind_callback(self, BuildingRobberyFightReport.OnClickShowPlayerInfo);
    self.bindfunc["OnClickClose"] = Utility.bind_callback(self, BuildingRobberyFightReport.OnClickClose);
end

function BuildingRobberyFightReport:OnClickClose()
    uiManager:PopUi()
end

function BuildingRobberyFightReport:OnClickShowPlayerInfo(param)
--    local ui = uiManager:PushUi(EUI.FormationUiNoHomeBtn,1);
--    ui:SetPlayerGID(param.string_value,ENUM.ETeamType.city_building_teaching_build);  
    OtherPlayerPanel.ShowPlayer(param.string_value, ENUM.ETeamType.city_building_teaching_build) 
end


function BuildingRobberyFightReport:InitUI(asset_obj)
    self.isFristEnter = true;
    
    UiBaseClass.InitUI(self, asset_obj)

    self.toggle = ngui.find_toggle(self.ui, 'yeka1')
    self.toggle:set_on_change(self.bindfunc["OnGuardTabToggleChange"])
--    toggle = ngui.find_toggle(self.ui, 'left_other/yeka2/sp')
--    toggle:set_on_change(self.bindfunc["OnAttackTabToggleChange"])

    self.wrapContentUI = ngui.find_wrap_content(self.ui, 'wrap_content')
    self.wrapContentUI:set_on_initialize_item(self.bindfunc["InitWrapContentItem"])

    --local btn = ngui.find_button(self.ui, 'btn_fork')
    --btn:set_on_click(self.bindfunc["OnClickClose"])

--    local sp = ngui.find_sprite(self.ui, 'yeka1/sp_prompt')
--    if sp then
--        sp:set_active(false)
--    end
--    local sp1 = ngui.find_sprite(self.ui, 'yeka2/sp_prompt')
--    if sp1 then
--        sp1:set_active(false)
--    end
end

function BuildingRobberyFightReport:OnServerReponseFightReport(ret, isAttack, report)
    --app.log('OnServerReponseFightReport ' .. ret .. '  ' .. table.tostring(report))
    GLoading.Hide(GLoading.EType.ui, self.loadingId);

    if ret == 0 then 

        self.reportCache[isAttack] = report
        self.currentReport = report

        local count = #report
        if count > 0 then
            self:UpdateFightReport()
        end
    end
end

function BuildingRobberyFightReport:UpdateFightReport()
    local count = #self.currentReport
    --app.log('InitWrapContentItem ' .. tostring(count))
    self.wrapContentUI:set_active(true)
    self.wrapContentUI:set_max_index(0)
    self.wrapContentUI:set_min_index(-count + 1)
    self.wrapContentUI:reset()
end

function BuildingRobberyFightReport:InitWrapContentItem(obj, b, realID)
    local index = math.abs(realID)
    local reportItem = self.currentReport[index + 1]

    local label = ngui.find_label(obj, 'btn_name/lab_name')
    label:set_text(reportItem.otherPlayerName)
    label = ngui.find_label(obj, 'lab_level')
    label:set_text("Lv." .. tostring(reportItem.otherPlayerLevel))
--    label = ngui.find_label(obj, 'sp_di1/lab1')
--    label:set_text(tostring(reportItem.otherfightScore))

    local btn = ngui.find_button(obj, 'btn_name')
    btn:reset_on_click()
    btn:set_event_value(reportItem.otherPlayerid, 0)
    btn:set_on_click(self.bindfunc["OnClickShowPlayerInfo"])

    -- '20000021=2;20000022=10'--
    local itemNumsStr = reportItem.expItems
    local itemAndNumStr = Utility.lua_string_split(itemNumsStr, ';')
    local frameNode = {}
    for i = 4,1,-1 do 
        frameNode[i] = obj:get_child_by_name('frame' .. i)
        frameNode[i]:set_active(false)     
    end

    local rowName = obj:get_name()
    if self.smallCardItems[rowName] == nil then
        self.smallCardItems[rowName] = {}
    end

    for k,v in ipairs(itemAndNumStr) do 
        local itemAndNum = Utility.lua_string_split(v, '=')
        if #itemAndNum == 2 then 
            local id = tonumber(itemAndNum[1])
            if id ~= nil then
                frameNode[k]:set_active(true)

                local cardinfo = CardProp:new({number = id,count = itemAndNum[2]});
                if self.smallCardItems[rowName][k] == nil then
                    self.smallCardItems[rowName][k] = UiSmallItem:new({obj = nil, parent = frameNode[k], cardInfo = cardinfo})
                else
                    self.smallCardItems[rowName][k]:SetData(cardinfo)
                end

                
            end
        end
    end
           
    local sp = ngui.find_sprite(obj, 'sp_di1')
    sp:set_active(false)

    label = ngui.find_label(obj, 'sp_di3/lab1')
    label:set_text(tostring(reportItem.resourceNum))

    label = ngui.find_label(obj, 'sp_di2/lab1')
    label:set_text(tostring(reportItem.goldNum))
   
    local sp = ngui.find_button(obj, 'btn1')
    sp:set_active(false)
    sp = ngui.find_button(obj, 'btn2')
    sp:set_active(false)
    label = ngui.find_label(obj, 'txt2')
    if reportItem.scoreChange ~= 0 then
        label:set_text(string.format("%s: %d", gs_misc['str_28'], reportItem.scoreChange))
    else
        label:set_text(gs_misc['str_7'])
    end

    local showStar = reportItem.star
    --app.log('x ' .. showStar)

--    local starsps = {}
--    for i=1,3 do
--        starsps[i] = ngui.find_sprite(obj, 'contain_star/sp_star' .. i .. '/sp')
--        starsps[i]:set_active(true)     
--    end

--    for i=3,1,-1 do
--        if i == showStar then 
--            break;
--        end

--        starsps[i]:set_active(false)    
--    end
    for i = 1,3 do
        sp = ngui.find_sprite(obj, 'contain_star/sp_star' .. tostring(i))
        if i <= showStar then
            -- sp:set_sprite_name('xingxing1')
            sp:set_active(true)
        else
            -- sp:set_sprite_name('xingxing3')
            sp:set_active(false)
        end
    end
    

    label = ngui.find_label(obj, 'lab_time')
    local robberyTime = tostring(reportItem.robberyTime)    
    local nowTime = system.time()

    local showStr = nil
    local diffTime = nowTime - robberyTime
    if diffTime > 3 * 24 * 3600 then --³¬¹ýÈýÌì
        showStr = gs_misc['str_1']
    elseif diffTime > 24 * 3600 then
        showStr = string.format(gs_misc['str_2'], diffTime/(24 * 3600), (diffTime%(24 * 3600))/3600)
    elseif diffTime > 3600 then
        showStr = string.format(gs_misc['str_3'], diffTime/3600, (diffTime%3600)/60)
    else
        showStr = string.format(gs_misc['str_4'], diffTime/60)
    end
    label:set_text(showStr)

--    local labellose = ngui.find_label(obj, 'lab_zhan_bai')
--    local labelwin = ngui.find_label(obj, 'lab_zhan_sheng')
--    if reportItem.mainBuildingResult == 1 then 
--        labelwin:set_active(true)
--        labellose:set_active(false)
--    else
--        labelwin:set_active(false)
--        labellose:set_active(true)
--    end
    sp = ngui.find_sprite(obj, 'sp_right_bk/sp')
    if reportItem.mainBuildingResult == 1 then 
        sp:set_sprite_name('zb_win')
    else
        sp:set_sprite_name('zb_lose')
    end
end

function BuildingRobberyFightReport:OnGuardTabToggleChange(isCheck)
    if self.isFristEnter then
        self.isFristEnter = false;
    else
        AudioManager.PlayUiAudio(ENUM.EUiAudioType.MainBtn)
    end
    --app.log('BuildingRobberyFightReport:OnGuardTabToggleChange ' .. tostring(isCheck))
    self.isAttackReport = 1
    if not isCheck then 
        self.isAttackReport = 0
    end
    self.wrapContentUI:set_active(false)
    if self.reportCache[self.isAttackReport] == nil then  
        self.loadingId = GLoading.Show(GLoading.EType.ui);
        msg_city_building.cg_get_fight_report(self.isAttackReport, self.bindfunc["OnServerReponseFightReport"]) 
    else
        self.currentReport = self.reportCache[self.isAttackReport]
        self:UpdateFightReport();
    end
end

--function BuildingRobberyFightReport:OnAttackTabToggleChange(isCheck)
--    app.log('BuildingRobberyFightReport:OnAttackTabToggleChange ' .. tostring(isCheck))
--end