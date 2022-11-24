HeroTrialFormationUI = Class("HeroTrialFormationUI",UiBaseClass);

local res = "assetbundles/prefabs/ui/wanfa/hero_trial/ui_5502_jueselilian.assetbundle";

local _UIText = {
    [1] = "请选择1个英雄",
    [2] = "体验券不足",
    [3] = "%s次",
}

function HeroTrialFormationUI.GetResList()
	return {res}
end

function HeroTrialFormationUI:Init(data)
    self.pathRes = res
    UiBaseClass.Init(self, data);
end

function HeroTrialFormationUI:InitData(data)
    UiBaseClass.InitData(self, data);
end

function HeroTrialFormationUI:Restart(data)
    self.dataCenter = g_dataCenter.activity[MsgEnum.eactivity_time.eActivityTime_heroTrial]
    UiBaseClass.Restart(self, data);
end

function HeroTrialFormationUI:RestartData(data)
    local freeHeroList = nil
    if data then
        self.day = data.day or 1
        freeHeroList = data.free or table.empty()
    else
        self.day = 1
        freeHeroList = table.empty()
    end

    local heroDataList = {}
    --免费体验英雄放到最前面
    for i, v in ipairs(freeHeroList) do
        local config = ConfigManager.Get(EConfigIndex.t_hero_trial_property, v)
        local config_scale = ConfigManager.Get(EConfigIndex.t_hero_trial_property_scale, g_dataCenter.player:GetLevel())
        local freeHeroData = PublicFunc.CreateCardInfo(config.cardNumber)
        freeHeroData.level = config.cardLevel
        freeHeroData.index = tostring(v) -- 构造一个非0的index，战斗中要用
        PublicFunc.UpdateConfigHeroInfo(freeHeroData, config, config_scale)

        freeHeroData.free_hero_mark = v
        table.insert(heroDataList, freeHeroData)
    end

    self.freeHeroCnt = #heroDataList

    --按类型筛选已有英雄 1防 2攻 3技 4ccg 5喰种
    self.heroDataList = {}
    for i, v in ipairs(heroDataList) do
        table.insert(self.heroDataList, v)
    end
    local freeHeroConfig = ConfigManager.Get(EConfigIndex.t_hero_trial_week_use, self.day)
    for i, v in ipairs(self:GetPackageHeroList(freeHeroConfig.ty)) do
        table.insert(self.heroDataList, v)
    end
end

function HeroTrialFormationUI:GetPackageHeroList( hero_type )
    local heroList = g_dataCenter.package:get_hero_card_table()

    local useDataById = self.dataCenter:GetUseHeroCountList()

    local packageHeroList = {}
    for i, v in pairs(heroList) do
        if g_dataCenter.gmCheat:noPlayLimit() then
            v.hero_trial_use_count = 0
        else
            v.hero_trial_use_count = useDataById[v.index] or 0
        end
        if v.hero_trial_use_count < 3 then
            --任意英雄
            if hero_type == 0 then
                table.insert(packageHeroList, v)
            --按职业分
            elseif hero_type <= 3 then
                if v.pro_type == hero_type then
                    table.insert(packageHeroList, v)
                end
            --按阵营分
            else
                if v.ccgType == hero_type - 3 then
                    table.insert(packageHeroList, v)
                end
            end
        end
    end

    local sort_func = function( a, b )
        if a:GetFightValue() > b:GetFightValue() then
            return true;
        elseif a:GetFightValue() < b:GetFightValue() then
            return false;
        end
        if a.realRarity > b.realRarity then
            return true;
        elseif a.realRarity < b.realRarity then
            return false;
        end
        if a.rarity > b.rarity then
            return true;
        elseif a.rarity < b.rarity then
            return false;
        end
        if a.hero_trial_use_count > b.hero_trial_use_count then
            return true
        elseif a.hero_trial_use_count < b.hero_trial_use_count then
            return false
        end
        if a.number < b.number then
            return true;
        elseif a.number > b.number then
            return false;
        end
        return false
    end

    table.sort(packageHeroList, sort_func)

    return packageHeroList
end

function HeroTrialFormationUI:RegistFunc()
    UiBaseClass.RegistFunc(self);
    self.bindfunc["on_btn_cancel_select"] = Utility.bind_callback(self, self.on_btn_cancel_select);
    self.bindfunc["on_btn_select_level"] = Utility.bind_callback(self, self.on_btn_select_level);
    self.bindfunc["on_btn_battle"] = Utility.bind_callback(self, self.on_btn_battle);
    self.bindfunc["on_callback_chose_level"] = Utility.bind_callback(self, self.on_callback_chose_level);
    self.bindfunc["on_init_item"] = Utility.bind_callback(self, self.on_init_item);
    self.bindfunc["on_card_click"] = Utility.bind_callback(self, self.on_card_click);
end

function HeroTrialFormationUI:InitUI(obj)
    UiBaseClass.InitUI(self, obj);
	self.ui:set_name("hero_trial_formation_ui");

    self.selectHeroData = nil
    self.curHeroData = 0 -- 赋一个值与selectHeroData不同来初始化界面
    self.selectLevel = 0
    self.recommendLevel = 0
    self.curLevel = 0
    self.itemGrid = {}
    self.heroTrialTicket = g_dataCenter.player:GetHeroTrialTicket()

    local path = "centre_other/animation/left"
    --------------------------- 左侧 ---------------------------
    self.scrollView = ngui.find_scroll_view(self.ui, path.."/scroll_view/panel_list")
    self.wrapContent = ngui.find_wrap_content(self.ui, path.."/scroll_view/panel_list/wrap_content")
    self.wrapContent:set_on_initialize_item(self.bindfunc["on_init_item"]);

    self.labTicketNumber = ngui.find_label(self.ui, path.."/txt2/lab_num")

    path = "centre_other/animation/right"
    --------------------------- 右侧 ---------------------------
    local nodeHeroInfo = self.ui:get_child_by_name(path.."/sp_di1")
    local btnCancelSelect = ngui.find_button(nodeHeroInfo, "btn_cha")
    btnCancelSelect:set_on_click(self.bindfunc["on_btn_cancel_select"])
    self.heroInfoSelect = {}
    self.heroInfoSelect.btnCancel = btnCancelSelect
    self.heroInfoSelect.labName = ngui.find_label(nodeHeroInfo, "lab_name")
    self.heroInfoSelect.nodeFightValue = nodeHeroInfo:get_child_by_name("sp_fight")
    self.heroInfoSelect.nodeFreeTips = nodeHeroInfo:get_child_by_name("txt_tiyan")
    self.heroInfoSelect.nodeUseTicket = nodeHeroInfo:get_child_by_name("txt_xiaohao")

    local labUseTicketNum = ngui.find_label(self.heroInfoSelect.nodeUseTicket, "lab_num")
    labUseTicketNum:set_text("1")
    -- if self.heroTrialTicket < 1 then
    --     PublicFunc.SetUiSpriteColor(labUseTicketNum, 1, 0, 0, 1)
    -- else
    --     PublicFunc.SetUiSpriteColor(labUseTicketNum, 0, 1, 115/255, 1)
    -- end
    
    self.heroInfoSelect.labFightValue = ngui.find_label(nodeHeroInfo, "sp_fight/lab_fight")
    local objParent = nodeHeroInfo:get_child_by_name("big_card_item_80")
    self.heroInfoSelect.uiCard = SmallCardUi:new({parent=objParent, stypes={1,2,6,7,9}})
    local nodeDifficult = self.ui:get_child_by_name(path.."/sp_di2")
    local btnDifficultSelect = ngui.find_button(nodeDifficult, "btn_bule")
    btnDifficultSelect:set_on_click(self.bindfunc["on_btn_select_level"])
    self.nodeRecommendTips = nodeDifficult:get_child_by_name("sp_hint")
    self.difficultAwards = {uiCards={}}
    for i=1, 5 do
        objParent = nodeDifficult:get_child_by_name("new_small_card_item"..i)
        self.difficultAwards.uiCards[i] = UiSmallItem:new(
            {parent = objParent, is_enable_goods_tip = true})
        self.difficultAwards.uiCards[i]:Hide()
    end

    self.spStars = {}
    for i=1, 6 do
        self.spStars[i] = nodeDifficult:get_child_by_name("sp_star"..i)
    end

    --------------------------- 底部 ---------------------------
    local btnBattle = ngui.find_button(self.ui, "down_other/btn2")
    btnBattle:set_on_click(self.bindfunc["on_btn_battle"])
    local labBattleTips = ngui.find_label(self.ui, "down_other/lab")
    local freeHeroConfig = ConfigManager.Get(EConfigIndex.t_hero_trial_week_use, self.day)
    labBattleTips:set_text(freeHeroConfig.text)

    --- 默认选中当天能出战的战力最高英雄（不算体验英雄）
    self.selectLevel = 1
    self.recommendLevel = 1
    if #self.heroDataList > self.freeHeroCnt then
        self.selectHeroData = self.heroDataList[self.freeHeroCnt+1]
        self.recommendLevel = self.dataCenter:GetRecommendPowerLevel(self.selectHeroData)
        self.selectLevel = self.recommendLevel
    end

    self.wrapContent:set_min_index(1 - math.ceil(#self.heroDataList/4));
    self.wrapContent:set_max_index(0);
    self.wrapContent:reset();

    self:UpdateUi()
end

function HeroTrialFormationUI:DestroyUi()
    if self.itemGrid then
        for k, v in pairs(self.itemGrid) do
            for kk, vv in pairs(v) do
                vv.uiCard:DestroyUi()
            end
        end
        self.itemGrid = nil
    end
    if self.heroInfoSelect then
        self.heroInfoSelect.uiCard:DestroyUi()
        self.heroInfoSelect = nil
    end
    if self.difficultAwards then
        for k, v in pairs(self.difficultAwards.uiCards) do
            v:DestroyUi()
        end
        self.difficultAwards = nil
    end
    self.selectHeroData = nil
    self.curHeroData = nil
    self.selectLevel = 0
    self.recommendLevel = 0
    self.curLevel = 0
    self.dataCenter = nil
    UiBaseClass.DestroyUi(self);
end

function HeroTrialFormationUI:UpdateHeroInfo()
    if self.selectHeroData == self.curHeroData then return end

    self.curHeroData = self.selectHeroData

    if self.selectHeroData then
        self.heroInfoSelect.btnCancel:set_active(true)
        -- self.heroInfoSelect.labName:set_active(true)
        -- self.heroInfoSelect.nodeFightValue:set_active(true)
        if self.selectHeroData.free_hero_mark then
            self.heroInfoSelect.nodeFreeTips:set_active(true)
            self.heroInfoSelect.nodeUseTicket:set_active(true)

            self.labTicketNumber:set_text(tostring(self.heroTrialTicket - 1))
        else
            self.heroInfoSelect.nodeFreeTips:set_active(false)
            self.heroInfoSelect.nodeUseTicket:set_active(false)

            self.labTicketNumber:set_text(tostring(self.heroTrialTicket))
        end

        self.heroInfoSelect.labName:set_text(self.selectHeroData.name)
        self.heroInfoSelect.labFightValue:set_text(tostring(self.selectHeroData:GetFightValue()))
        self.heroInfoSelect.uiCard:SetData(self.selectHeroData)
    else
        self.heroInfoSelect.btnCancel:set_active(false)
        -- self.heroInfoSelect.labName:set_active(false)
        -- self.heroInfoSelect.nodeFightValue:set_active(false)
        self.heroInfoSelect.nodeFreeTips:set_active(false)
        self.heroInfoSelect.nodeUseTicket:set_active(false)

        self.heroInfoSelect.labName:set_text("")
        self.heroInfoSelect.labFightValue:set_text(" 0")
        self.heroInfoSelect.uiCard:SetData(nil)

        self.labTicketNumber:set_text(tostring(self.heroTrialTicket))
    end
end

function HeroTrialFormationUI:UpdateLevelAwards()
    if self.selectLevel == self.curLevel then return end
    
    self.curLevel = self.selectLevel

    local awardsConfig = ConfigManager.Get(EConfigIndex.t_hero_trial_awards, self.day)
    local awardsData = {}
    local drop_list = ConfigManager.Get(EConfigIndex.t_drop_something, awardsConfig["drop_id_"..self.curLevel]);
    for k, v in pairs(drop_list) do
        if v.goods_show_number > 0 then
            table.insert(awardsData, {id=v.goods_show_number, num=v.goods_number})
        end
    end

    for i, v in ipairs(self.difficultAwards.uiCards) do
        if awardsData[i] then
            v:Show()
            v:SetDataNumber(awardsData[i].id, awardsData[i].num)
        else
            v:Hide()
        end
    end

    for i, v in ipairs(self.spStars) do
        v:set_active(self.selectLevel >= i)
    end

    if self.selectLevel ~= self.recommendLevel then
        self.nodeRecommendTips:set_active(true)
    else
        self.nodeRecommendTips:set_active(false)
    end
end

function HeroTrialFormationUI:UpdateUi()
    if self.ui == nil then return end

    self:UpdateHeroInfo()
    self:UpdateLevelAwards()
end

function HeroTrialFormationUI:on_init_item(obj, b, real_id)
    local lineIndex = math.abs(real_id)
    
    local itemGrid = self.itemGrid[b]
    if itemGrid == nil then
        itemGrid = {}
        for i=1, 4 do
            local objItem = obj:get_child_by_name("item"..i)
            local objParent = objItem:get_child_by_name("big_card_item_80")
            itemGrid[i] = {}
            itemGrid[i].self = objItem
            itemGrid[i].uiCard = SmallCardUi:new({parent=objParent, stypes={1,2,6,7,9}})
            itemGrid[i].freeTips = objItem:get_child_by_name("sp_tiyan")
            itemGrid[i].countTips = objItem:get_child_by_name("sp_cishu")
            itemGrid[i].labUseCount = ngui.find_label(objItem, "sp_cishu/lab")
            itemGrid[i].labFightValue = ngui.find_label(objItem, "txt_fight/lab_fight")

            itemGrid[i].uiCard:SetCallback(self.bindfunc["on_card_click"])
        end

        self.itemGrid[b] = itemGrid
    end

    for i=1, #itemGrid do
        local index = lineIndex*4 + i
        local data = self.heroDataList[index]
        self:LoadItem(itemGrid[i], index, data)
    end
end

function HeroTrialFormationUI:LoadItem(item, index, data)
    item.source_data = data

    if data then
        item.index = index
        item.self:set_active(true)
        item.labFightValue:set_text(tostring(data:GetFightValue()))
        item.uiCard:SetData(data)
        if data == self.selectHeroData then
            item.uiCard:SetBattleSpEx(true)
            item.uiCard:showSelectFrame()
        else
            item.uiCard:SetBattleSpEx(false)
            item.uiCard:hideSelectFrame()
        end
        
        if data.free_hero_mark and self.heroTrialTicket <= 0 then
            item.uiCard:SetBattleSpEx(false)
            item.uiCard:SetGray(true)
        else
            item.uiCard:SetBattleSpEx(data == self.selectHeroData)
            item.uiCard:SetGray(false)
        end

        if data.free_hero_mark then
            item.freeTips:set_active(true)
            item.countTips:set_active(false)
        elseif data.hero_trial_use_count > 0 then
            item.freeTips:set_active(false)
            item.countTips:set_active(true)
            item.labUseCount:set_text(string.format(_UIText[3],data.hero_trial_use_count))
        else
            item.freeTips:set_active(false)
            item.countTips:set_active(false)
        end
    else
        item.self:set_active(false)
    end
end

function HeroTrialFormationUI:UpdateSelectHeroState()
    for k, v in pairs(self.itemGrid) do
        for kk, vv in pairs(v) do
            if self.selectHeroData and vv.source_data == self.selectHeroData then
                vv.uiCard:SetBattleSpEx(true)
                vv.uiCard:showSelectFrame()
            else
                vv.uiCard:SetBattleSpEx(false)
                vv.uiCard:hideSelectFrame()
            end
        end
    end
end

function HeroTrialFormationUI:on_btn_battle(t)
    if self.selectHeroData == nil then
        FloatTip.Float(_UIText[1])
        return
    elseif self.selectHeroData.free_hero_mark then
        if self.heroTrialTicket <= 0 then
            FloatTip.Float(_UIText[2])
            return
        end
    end

    local freeHeroConfig = ConfigManager.Get(EConfigIndex.t_hero_trial_week_use, self.day)
    self.dataCenter:StartBattle(self.selectHeroData, self.selectLevel, freeHeroConfig["hurdle_"..self.selectLevel], self.day)
end

function HeroTrialFormationUI:on_btn_cancel_select(t)
    self.selectHeroData = nil
    self:UpdateSelectHeroState()
    self:UpdateUi()
end

function HeroTrialFormationUI:on_btn_select_level(t)
    local data = {
        type = "select",
        day = self.day,
        recommendLevel = self.recommendLevel,
        callback = self.bindfunc["on_callback_chose_level"],
    }
    uiManager:PushUi(EUI.HeroTrialLevelAwardUI,data)
end

function HeroTrialFormationUI:on_card_click(uiCard, cardInfo)
    if cardInfo.free_hero_mark and self.heroTrialTicket <= 0 then
        FloatTip.Float(_UIText[2])
        return
    end

    self.selectHeroData = cardInfo
    self:UpdateSelectHeroState()

    self.recommendLevel = self.dataCenter:GetRecommendPowerLevel(cardInfo)
    self.selectLevel = self.recommendLevel
    self:UpdateUi()
end

function HeroTrialFormationUI:on_callback_chose_level(level)
    self.selectLevel = level
    self:UpdateLevelAwards()
end

-------------------------新手引导调用-----------------------------
--第一个列表项英雄
function HeroTrialFormationUI:GetGuideHeroItem()
    if self.itemGrid == nil then return end

    local uiCard = nil
    for b, v in pairs(self.itemGrid) do
        for kk, vv in pairs(v) do
            if vv.index == 1 then
                uiCard = vv.uiCard
                break;
            end
        end
    end
    if uiCard and uiCard.btnRoot then
        return uiCard.btnRoot:get_game_object()
    end
end