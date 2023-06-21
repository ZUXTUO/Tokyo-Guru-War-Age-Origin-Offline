HeroTrialUI = Class("HeroTrialUI",UiBaseClass);

local _UIText = {
    [1] = "[00FF73FF]%s[-]/%s",
    [2] = "%s日",
    [3] = "已到第二日，需要重新选择角色",
}

local WeekDayText = {
    [1] = "周一",
    [2] = "周二",
    [3] = "周三",
    [4] = "周四",
    [5] = "周五",
    [6] = "周六",
    [7] = "周日",
}

local res = "assetbundles/prefabs/ui/wanfa/hero_trial/ui_5501_jueselilian.assetbundle";

function HeroTrialUI.GetResList()
	return {res}
end

local _local_day = nil

function HeroTrialUI:Init(data)
    self.pathRes = res
    UiBaseClass.Init(self, data);
end

function HeroTrialUI:InitData(data)
    UiBaseClass.InitData(self, data);
end

function HeroTrialUI:Restart()
    self.dataCenter = g_dataCenter.activity[MsgEnum.eactivity_time.eActivityTime_heroTrial]
    local today = PublicFunc.GetWhatDayIsToday()
    if _local_day ~= today then
        _local_day = today
        msg_activity.cg_hero_trial_get_init_info()
    end
    
    UiBaseClass.Restart(self);
end

function HeroTrialUI:OnLoadUI()
    UiBaseClass.PreLoadUIRes(HeroTrial3d, Root.empty_func)
end

function HeroTrialUI:RegistFunc()
    UiBaseClass.RegistFunc(self);
    self.bindfunc["on_day_change"] = Utility.bind_callback(self, self.on_day_change);
    self.bindfunc["on_btn_preview_reward"] = Utility.bind_callback(self, self.on_btn_preview_reward);
    self.bindfunc["on_btn_view_hero"] = Utility.bind_callback(self, self.on_btn_view_hero);
    self.bindfunc["on_btn_box"] = Utility.bind_callback(self, self.on_btn_box);
    self.bindfunc["on_btn_enter"] = Utility.bind_callback(self, self.on_btn_enter);
    self.bindfunc["gc_hero_trial_get_init_info"] = Utility.bind_callback(self, self.gc_hero_trial_get_init_info);
    self.bindfunc["gc_hero_trial_get_week_awards"] = Utility.bind_callback(self, self.gc_hero_trial_get_week_awards);
end

function HeroTrialUI:MsgRegist()
    UiBaseClass.MsgRegist(self);
    PublicFunc.msg_regist(msg_activity.gc_hero_trial_get_init_info, self.bindfunc["gc_hero_trial_get_init_info"])
    PublicFunc.msg_regist(msg_activity.gc_hero_trial_get_week_awards, self.bindfunc["gc_hero_trial_get_week_awards"])
end

function HeroTrialUI:MsgUnRegist()
    UiBaseClass.MsgUnRegist(self);
    PublicFunc.msg_unregist(msg_activity.gc_hero_trial_get_init_info, self.bindfunc["gc_hero_trial_get_init_info"])
    PublicFunc.msg_unregist(msg_activity.gc_hero_trial_get_week_awards, self.bindfunc["gc_hero_trial_get_week_awards"])
end

function HeroTrialUI:InitUI(obj)
    UiBaseClass.InitUI(self, obj);
	self.ui:set_name("hero_trial_ui");

    self.today = PublicFunc.GetWhatDayIsToday()
    self.selectDay = 0

    local path = "centre_other/animation/left"
    --------------------------- 左侧 ---------------------------
    self.labHeroTypeTips = ngui.find_label(self.ui, path.."/txt")
    self.tabBubbleTips = {}
    for i=1, 7 do
        local toggle = ngui.find_toggle(self.ui, path.."/yeka/yeka"..i);
        toggle:set_on_change(self.bindfunc["on_day_change"])
        self.tabBubbleTips[i] = toggle:get_game_object():get_child_by_name("sp_hint")

        --设置初始选中
        if self.today == i then
            toggle:set_value(true)
            self.tabBubbleTips[i]:set_active(true)
        end
    end

    self.previewAwards = {}
    for i=1, 5 do
        local itemParent = self.ui:get_child_by_name(path.."/txt1/grid/new_small_card_item"..i)
        self.previewAwards[i] = UiSmallItem:new(
            {parent = itemParent, is_enable_goods_tip = true, prop = {show_number=false}})
        self.previewAwards[i]:Hide()
    end

    local btnPreviewReward = ngui.find_button(self.ui, path.."/txt1/btn_bule118")
    btnPreviewReward:set_on_click(self.bindfunc["on_btn_preview_reward"])

    self.labTicketNumber = ngui.find_label(self.ui, path.."/txt2/lab_num")

    self.labTrialTimes = ngui.find_label(self.ui, path.."/lab_cishu")


    path = "centre_other/animation/right"
    --------------------------- 右侧 ---------------------------
    self.heroInfo = {}
    local nodeDayHero = self.ui:get_child_by_name(path.."/cont_yingxiong_xinxi")
    local nodeAnyHero = self.ui:get_child_by_name(path.."/sp_bar")
    self.heroInfo.labName = ngui.find_label(nodeDayHero, "lab_name")
    -- self.heroInfo.labNameNum = ngui.find_label(nodeDayHero, "lab_num")
    self.heroInfo.spAptitude = ngui.find_sprite(nodeDayHero, "sp_pinjie")
    self.heroInfo.labSimpleDes = ngui.find_label(nodeDayHero, "txt_fight")
    self.heroInfo.spProType = ngui.find_sprite(nodeDayHero, "sp_shuxing")
    self.btnView = ngui.find_button(nodeDayHero, "btn_rule")
    self.btnView:set_on_click(self.bindfunc["on_btn_view_hero"])

    self.heroInfo.nodeDayHero = nodeDayHero
    self.heroInfo.nodeAnyHero = nodeAnyHero

    self.spTouch = ngui.find_sprite(self.ui, path.."/sp_human")


    --------------------------- 底部 ---------------------------
    self.progressBar = ngui.find_progress_bar(self.ui, "down_other/sco_bar")
    self.btnEnter = ngui.find_button(self.ui, "down_other/btn2")
    self.btnEnter:set_on_click(self.bindfunc["on_btn_enter"])

    self.boxList = {}
    local config = ConfigManager._GetConfigTable(EConfigIndex.t_hero_trial_week_awards)
    for i=1, 2 do
        local btnBox = ngui.find_button(self.ui, "down_other/btn_box"..i)
        btnBox:set_on_click(self.bindfunc["on_btn_box"])
        btnBox:set_event_value("", i)
        local objBtn = btnBox:get_game_object()
        local labDay = ngui.find_label(objBtn, "lab_num")
        labDay:set_text(string.format(_UIText[2], config[i].day))

        self.boxList[i] = {}
        self.boxList[i].aniObj = objBtn
        self.boxList[i].spBox = ngui.find_sprite(objBtn, "sp")
        self.boxList[i].spPoint = ngui.find_sprite(objBtn, "sp_point")
    end

    self:UpdateUi()
end

function HeroTrialUI:UpdatePreviewInfo()
    if g_dataCenter.gmCheat:noPlayLimit() then
        PublicFunc.SetButtonShowMode(self.btnEnter, 1)
    else
        if self.selectDay == self.today then
            PublicFunc.SetButtonShowMode(self.btnEnter, 1)
        else
            PublicFunc.SetButtonShowMode(self.btnEnter, 3)
        end
    end

    local selectDay = self.selectDay > 0 and self.selectDay or self.today
    local freeHeroConfig = ConfigManager.Get(EConfigIndex.t_hero_trial_week_use, selectDay)
    self.labHeroTypeTips:set_text(freeHeroConfig.text)

    local awardsConfig = ConfigManager.Get(EConfigIndex.t_hero_trial_awards, selectDay)
    local awardsData = awardsConfig["show_drop"]
    for i, previewReward in ipairs(self.previewAwards) do
        if awardsData[i] then
            previewReward:Show()
            previewReward:SetDataNumber(awardsData[i])
        else
            previewReward:Hide()
        end
    end
end

function HeroTrialUI:UpdateHeroInfo()
    self.freeHeroData = nil
    self.freeHeroList = self.dataCenter:GetUseFreeHeroList()

    if #self.freeHeroList == 1 then
        local config = ConfigManager.Get(EConfigIndex.t_hero_trial_property, self.freeHeroList[1])
        self.freeHeroData = PublicFunc.CreateCardInfo(config.cardNumber)
        self.freeHeroData.level = config.cardLevel
        PublicFunc.UpdateConfigHeroInfo(self.freeHeroData, config)
    end

    if self.freeHeroData then
        self.heroInfo.nodeDayHero:set_active(true)
        self.heroInfo.nodeAnyHero:set_active(false)

        -- local nameStr, numStr = PublicFunc.FormatHeroNameAndNumber(self.freeHeroData.name)

        -- self.heroInfo.labName:set_text(nameStr)
        -- self.heroInfo.labNameNum:set_text(numStr)
        self.heroInfo.labName:set_text(self.freeHeroData.name)
        self.heroInfo.labSimpleDes:set_text(tostring(self.freeHeroData.config.simple_describe))
        
        PublicFunc.SetProTypePic(self.heroInfo.spProType, self.freeHeroData.pro_type)
        PublicFunc.SetAptitudeSprite(self.heroInfo.spAptitude, self.freeHeroData.config.aptitude, true)

        self.btnView:set_active(true)
        self.btnView:set_event_value("", self.freeHeroData.number)

    else
        self.heroInfo.nodeDayHero:set_active(false)
        self.heroInfo.nodeAnyHero:set_active(true)

        self.btnView:set_active(false)
    end

    local heroNumber = nil
    if self.freeHeroData then
        heroNumber = self.freeHeroData.number
    elseif #self.freeHeroList > 0 then
        heroNumber = 0
    end

    local data = {
        number = heroNumber,
        spTouch = self.spTouch,
    }
    HeroTrial3D.SetAndShow(data)
end

function HeroTrialUI:PlayBoxOpening(index)
    if self.ui == nil then return end

    local data = self.boxList[index]
    if data then
        data.spPoint:set_active(false)
        if index == 1 then
            data.spBox:set_sprite_name("gq_baoxiang1_2")
        else
            data.spBox:set_sprite_name("gq_baoxiang3_2")
        end
        data.aniObj:animated_stop("ui_701_level_down_btnbox_sp")
    end
end

function HeroTrialUI:UpdateUi()
    if self.ui == nil then return end

    self.labTrialTimes:set_text(
        string.format(_UIText[1], self.dataCenter:GetUnusedChanllengeCnt(), self.dataCenter:GetMaxChanllengeCnt()))
    self.labTicketNumber:set_text(tostring(g_dataCenter.player:GetHeroTrialTicket()))

    self.progressBar:set_value( self.dataCenter:GetTotalBoxDay() / 7 )

    local flag, boxGetState = self.dataCenter:IsThereBoxUnTaken()
    for k, v in pairs(boxGetState) do
        if self.boxList[k] then
            if v == 0 then
                self.boxList[k].spPoint:set_active(false)
                if k == 1 then
                    self.boxList[k].spBox:set_sprite_name("gq_baoxiang1")
                else
                    self.boxList[k].spBox:set_sprite_name("gq_baoxiang3")
                end
                self.boxList[k].aniObj:animated_stop("ui_701_level_down_btnbox_sp")
            elseif v == 1 then
                self.boxList[k].spPoint:set_active(true)
                if k == 1 then
                    self.boxList[k].spBox:set_sprite_name("gq_baoxiang1")
                else
                    self.boxList[k].spBox:set_sprite_name("gq_baoxiang3")
                end
                self.boxList[k].aniObj:animated_play("ui_701_level_down_btnbox_sp")
            elseif v == 2 then
                self.boxList[k].spPoint:set_active(false)
                if k == 1 then
                    self.boxList[k].spBox:set_sprite_name("gq_baoxiang1_2")
                else
                    self.boxList[k].spBox:set_sprite_name("gq_baoxiang3_2")
                end
                self.boxList[k].aniObj:animated_stop("ui_701_level_down_btnbox_sp")
            end
        end
    end

    self:UpdateHeroInfo()
    self:UpdatePreviewInfo()
end

function HeroTrialUI:DestroyUi()
    
    if self.previewAwards then
        for k, v in pairs(self.previewAwards) do
            v:DestroyUi()
        end
        self.previewAwards = nil
    end
    if self.heroInfo then
        self.heroInfo = nil
    end
    self.dataCenter = nil
    self.freeHeroData = nil

    HeroTrial3D.Destroy()

    UiBaseClass.DestroyUi(self);
end

function HeroTrialUI:Show()
    if UiBaseClass.Show(self) then
        local instance = HeroTrial3D.GetInstance()
        if instance then
            instance:Show()
        end
    end
end

function HeroTrialUI:Hide()
    if UiBaseClass.Hide(self) then
        local instance = HeroTrial3D.GetInstance()
        if instance then
            instance:Hide()
        end
    end
end

function HeroTrialUI:on_day_change(value, name)
    if value then
        self.selectDay = tonumber(string.sub(name, -1))
        self:UpdatePreviewInfo()
    end
end

function HeroTrialUI:on_btn_preview_reward(t)
    local data = {
        type = "preview",
        day = self.today,
    }
    uiManager:PushUi(EUI.HeroTrialLevelAwardUI,data)
end

function HeroTrialUI:on_btn_view_hero(t)
    
    local data = 
    {   info = self.freeHeroData,
        isPlayer = false,
        heroDataList = table.empty(),
    }

    uiManager:PushUi(EUI.BattleRoleInfoUI,data)
end

function HeroTrialUI:on_btn_box(t)
    local value = t.float_value
    local config = ConfigManager.Get(EConfigIndex.t_hero_trial_week_awards, value)
    if self.dataCenter:GetTotalBoxDay() >= config.day then
        local takenList = self.dataCenter:GetTakenBoxList()
        if takenList[value] == nil then
            msg_activity.cg_hero_trial_get_week_awards(value)
        else
            uiManager:PushUi(EUI.HeroTrialSignBoxUI, {index=value,got=true})
        end
    else
        uiManager:PushUi(EUI.HeroTrialSignBoxUI, {index=value,got=false})
    end
end

function HeroTrialUI:on_btn_enter(t)
    if g_dataCenter.chatFight:CheckMyRequest() then
        return
    end
    if g_dataCenter.gmCheat:noPlayLimit() then
        uiManager:PushUi(EUI.HeroTrialFormationUI, {free=self.freeHeroList, day=self.selectDay})
    else
        if self.selectDay == self.today then
            uiManager:PushUi(EUI.HeroTrialFormationUI, {free=self.freeHeroList, day=self.today})
        end
    end
end

function HeroTrialUI:gc_hero_trial_get_init_info()
    self:UpdateUi()
end

function HeroTrialUI:gc_hero_trial_get_week_awards(index, awards)
    --重置了累计天数
    if self.dataCenter:GetTotalBoxDay() == 0 then
        CommonAward.Start(awards)
        self:UpdateUi()
    else
        CommonAward.Start(awards)
        self:PlayBoxOpening(index)
    end
end

function HeroTrialUI:gc_enter_activity_error()
    uiManager:RemoveUi(EUI.HeroTrialFormationUI)

    _local_day = PublicFunc.GetWhatDayIsToday()
    msg_activity.cg_hero_trial_get_init_info()
    -- 检查是否已经跨天
    if self.ui and self.today ~= _local_day then
        FloatTip.Float(_UIText[3])

        self.tabBubbleTips[self.today]:set_active(false)
        self.tabBubbleTips[_local_day]:set_active(true)
        self.today = _local_day
    end
end
