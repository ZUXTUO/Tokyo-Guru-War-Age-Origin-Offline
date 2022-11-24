HeroTrialLevelAwardUI = Class("HeroTrialLevelAwardUI",UiBaseClass);

local res = "assetbundles/prefabs/ui/wanfa/hero_trial/ui_5503_jueselilian.assetbundle";

function HeroTrialLevelAwardUI.GetResList()
	return {res}
end

function HeroTrialLevelAwardUI:Init(data)
    self.pathRes = res
    UiBaseClass.Init(self, data)
end

function HeroTrialLevelAwardUI:RestartData(data)
    if data then
        if data.type == "preview" then
            self.mode = 1
        elseif data.type == "select" then
            self.mode = 2
        end
        self.day = data.day or 1
        self.callback = data.callback
        self.recommendLevel = data.recommendLevel
    else
        self.mode = 1
        self.day = 1
    end

    self.awardsData = {}
    local awardsConfig = ConfigManager.Get(EConfigIndex.t_hero_trial_awards, self.day)
    for i=1, 6 do
        self.awardsData[i] = awardsConfig["show_drop_"..i]
    end
end

function HeroTrialLevelAwardUI:RegistFunc()
    UiBaseClass.RegistFunc(self);
    self.bindfunc["on_btn_confirm"] = Utility.bind_callback(self, self.on_btn_confirm);
    self.bindfunc["on_btn_select"] = Utility.bind_callback(self, self.on_btn_select);
end

function HeroTrialLevelAwardUI:InitUI(obj)
    UiBaseClass.InitUI(self, obj);
	self.ui:set_name("hero_trial_level_award_ui");

    self.contPreview = self.ui:get_child_by_name("cont1")
    self.contSelect = self.ui:get_child_by_name("cont2")
    local btnConfirm = ngui.find_button(self.contPreview, "btn_yellow")
    btnConfirm:set_on_click(self.bindfunc["on_btn_confirm"])

    self.listItems = {}
    local contList = self.ui:get_child_by_name("cont_list")
    for i=1, 3 do
        for j=1, 2 do
            local nodeItem = contList:get_child_by_name("list_"..i.."/sp_di"..j)

            local uiItems = {}
            for k=1, 5 do
                local objParent = nodeItem:get_child_by_name("new_small_card_item"..k)
                uiItems[k] = UiSmallItem:new({parent = objParent, is_enable_goods_tip = true})
            end

            local nodeAward = nodeItem:get_child_by_name("txt_1")

            local index = (i - 1) * 2 + j
            local spStar = nil
            for k=1, 6 do
                spStar = nodeItem:get_child_by_name("sp_star"..k)
                spStar:set_active(k <= index)
            end

            local btnSelect = ngui.find_button(self.contSelect, "list"..i.."/btn"..j)
            btnSelect:set_on_click(self.bindfunc["on_btn_select"])
            btnSelect:set_event_value("", index)
            local nodeRecommendTips = btnSelect:get_game_object():get_child_by_name("sp_hint")

            self.listItems[index] = {}
            self.listItems[index].self = nodeItem
            self.listItems[index].nodeAward = nodeAward
            self.listItems[index].uiItems = uiItems
            self.listItems[index].nodeRecommendTips = nodeRecommendTips
        end
    end

    if self.mode == 1 then
        -- 预览界面将奖励位置做偏移调整
        for i, v in pairs(self.listItems) do
            local x,y,z = v.nodeAward:get_local_position()
            v.nodeAward:set_local_position(x+50,y,z)
        end
    end

    self:UpdateUi()
end

function HeroTrialLevelAwardUI:DestroyUi()
    if self.listItems then
        for i, item in ipairs(self.listItems) do
            for j, uiItem in ipairs(item.uiItems) do
                uiItem:DestroyUi()
            end
        end
        self.listItems = nil
    end
    UiBaseClass.DestroyUi(self);
end

function HeroTrialLevelAwardUI:UpdateUi()
    if self.ui == nil then return end

    if self.mode == 1 then
        self.contPreview:set_active(true)
        self.contSelect:set_active(false)

    elseif self.mode == 2 then
        self.contPreview:set_active(false)
        self.contSelect:set_active(true)
    end

    for i, item in ipairs(self.listItems) do
        local data =  self.awardsData[i]
        if data then
            -- item.self:set_active(true)
            for j, uiItem in ipairs(item.uiItems) do
                if data[j] then
                    uiItem:Show()
                    uiItem:SetDataNumber(data[j][1], data[j][2])
                else
                    uiItem:Hide()
                end
            end
            if i == self.recommendLevel then
                item.nodeRecommendTips:set_active(true)
            end
        else
            -- item.self:set_active(false)
        end
    end
end

function HeroTrialLevelAwardUI:on_btn_confirm(t)
    uiManager:PopUi()
end

function HeroTrialLevelAwardUI:on_btn_select(t)
    if self.callback then
        Utility.CallFunc(self.callback, t.float_value)
    end
    uiManager:PopUi()
end
