
-- file   : restraint_ui.lua -- 克制系统界面
-- author : zzc
-- date   : 2016/08/22

RestraintUi = Class("RestraintUi", UiBaseClass);

local _local = {}
_local.UnlockType = {
    ["team_level"]  = 1,    --战队等级
    ["role_qua"]    = 2,    --角色品质
}

_local.UIText = {
    [1] = "[ffa127]已学习[-][0bbdf9]%s[-]",
    [2] = "%s不足, 无法升级",
    [3] = "[ffa127]可解锁[-]",
    [4] = "已升至满级",
    [5] = "重置成功",
    [6] = "开启条件: ",
    [7] = "升级消耗: ",
    [8] = "升级",
    [9] = "解锁",
    [10] = "战队等级达到%s级",
    [11] = "角色达到%s品质",
    [12] = "[0bbdf9]等级[-] %s/%s",
    [13] = "重置全部",
    [14] = "重置单层",
    [15] = "重置全部需消耗|item:%s|%s\n重置按一定比例返还所消耗克制点，是否继续？",
    [16] = "重置该层需消耗|item:%s|%s\n重置按一定比例返还本层所消耗克制点，是否继续？",
    [17] = "点击将返还部分消耗的克制点",
    [18] = "克制层数大于一层时才可进行全部重置",
}

_local.send_msg_reset = function(data)
    if data.recharge then
        PublicFunc.GotoRecharge() -- 前往充值
    else
        msg_cards.cg_restrain_reset(data.role_dataid, data.id)
    end
end

function RestraintUi:Init(data)
    self.pathRes = "assetbundles/prefabs/ui/package/ui_7001_ke_zhi.assetbundle"
    UiBaseClass.Init(self,data);
end

function RestraintUi:Restart(data)
    if data then
        self.roleData = data
    end
    UiBaseClass.Restart(self, data)
end

function RestraintUi:DestroyUi()
    if self.heroListUi then
        self.heroListUi:DestroyUi()
        self.heroListUi = nil
    end

    if self.uiBigCard then
        self.uiBigCard:DestroyUi()
        self.uiBigCard = nil
    end

    if self.pnInfo then
        for i, cost in pairs(self.pnInfo.toUpgrade.cost) do
            cost.txCost:Destroy()
        end
        self.pnInfo.txIcon:Destroy()
        self.pnInfo = nil
    end

    if self.listItems then
        for i, item in pairs(self.listItems) do
            for j, icon in pairs(item.arrIcon) do
                icon.txIcon:Destroy()
            end
        end
        self.listItems = nil
    end

    UiBaseClass.DestroyUi(self)
end

function RestraintUi:RegistFunc()
    UiBaseClass.RegistFunc(self)

    self.bindfunc['on_init_item'] = Utility.bind_callback(self, self.on_init_item)
    self.bindfunc['on_btn_item'] = Utility.bind_callback(self, self.on_btn_item)
    self.bindfunc['update_choose_hero'] = Utility.bind_callback(self, self.update_choose_hero)
    self.bindfunc['on_btn_upgrade'] = Utility.bind_callback(self, self.on_btn_upgrade)
    self.bindfunc['on_btn_unlock'] = Utility.bind_callback(self, self.on_btn_unlock)
    self.bindfunc["on_btn_reset"] = Utility.bind_callback(self, self.on_btn_reset)
    self.bindfunc["on_btn_total_plus"] = Utility.bind_callback(self, self.on_btn_total_plus)
    self.bindfunc['gc_restrain_unlock'] = Utility.bind_callback(self, self.gc_restrain_unlock)
    self.bindfunc['gc_restrain_upgrade'] = Utility.bind_callback(self, self.gc_restrain_upgrade)
    self.bindfunc['gc_restrain_reset'] = Utility.bind_callback(self, self.gc_restrain_reset)
    self.bindfunc['on_update_card_info'] = Utility.bind_callback(self, self.on_update_card_info)
end

function RestraintUi:MsgRegist()
    PublicFunc.msg_regist(msg_cards.gc_restrain_unlock, self.bindfunc['gc_restrain_unlock'])
    PublicFunc.msg_regist(msg_cards.gc_restrain_upgrade, self.bindfunc['gc_restrain_upgrade'])
    PublicFunc.msg_regist(msg_cards.gc_restrain_reset, self.bindfunc['gc_restrain_reset'])
    -- PublicFunc.msg_regist(msg_cards.gc_change_role_card_property, self.bindfunc['on_update_card_info'])
    PublicFunc.msg_regist(msg_cards.gc_update_role_cards,self.bindfunc["on_update_card_info"]);
end

function RestraintUi:MsgUnRegist()
    PublicFunc.msg_unregist(msg_cards.gc_restrain_unlock, self.bindfunc['gc_restrain_unlock'])
    PublicFunc.msg_unregist(msg_cards.gc_restrain_upgrade, self.bindfunc['gc_restrain_upgrade'])
    PublicFunc.msg_unregist(msg_cards.gc_restrain_reset, self.bindfunc['gc_restrain_reset'])
    -- PublicFunc.msg_unregist(msg_cards.gc_change_role_card_property, self.bindfunc['on_update_card_info'])
    PublicFunc.msg_unregist(msg_cards.gc_update_role_cards,self.bindfunc["on_update_card_info"]);
end

function RestraintUi:InitUI(obj)
    UiBaseClass.InitUI(self, obj)
    self.ui:set_name('restraint_ui')

    self.restrain_valid = self.roleData:GetRestrainValid()
    self.restrainGroup = ConfigHelper.GetRestrainGroup(self.roleData.config.restrain)
    self.restrainIdGroup = ConfigHelper.GetRestrainIdGroup(self.roleData.config.restrain)
    self.currentId = self.restrainGroup[1][1] -- 初始选中项
    self.currentCfg = nil
    self.listItems = {}    -- 保存初始化的克制列表项


    local path = "centre_other/animation/left_content/"
    -------------------------------- 英雄信息 ---------------------------------
    self.uiBigCard = UiBigCard:new({parent=self.ui:get_child_by_name(path.."cont_big_item")})

    local btnTotalPlus = ngui.find_button(self.ui, path.."btn1")
    btnTotalPlus:set_on_click(self.bindfunc["on_btn_total_plus"])


    path = "centre_other/animation/center_content/"
    -------------------------------- 克制列表 ---------------------------------
    self.btnResetAll = ngui.find_button(self.ui, path.."btn1")
    self.spResetAll = ngui.find_sprite(self.ui, path.."btn1/animation/sp_red_title")
    self.labResetAll = ngui.find_label(self.ui, path.."btn1/animation/lab") 
    self.labResetAllTips = ngui.find_label(self.ui, path.."lab") 
    self.scrollView = ngui.find_scroll_view(self.ui, path.."scro_view/panel")
    self.wrapContent = ngui.find_wrap_content(self.ui, path.."scro_view/panel/wrap_content")
    self.wrapContent:set_on_initialize_item(self.bindfunc['on_init_item']);

    self.btnResetAll:set_on_click(self.bindfunc["on_btn_reset"])
    self.btnResetAll:set_event_value("", 0)

    self.aniUnlock = self.ui:get_child_by_name("sp_title1/sp_frame/animation")
    self.aniUnlock:set_animator_enable(false)
    self.fxUpgrade = self.ui:get_child_by_name("fx_ui_7001_kezhi")
    self.fxUpgrade:set_active(false)

    self.labResetAllTips:set_text(_local.UIText[17])

    path = "centre_other/animation/right_content/"
    -------------------------------- 克制信息 ---------------------------------
    local pnInfo = {}
    pnInfo.txIcon = ngui.find_texture(self.ui, path.."sp_title1/sp_frame/sp_shu_xing")
    pnInfo.labName = ngui.find_label(self.ui, path.."sp_title1/lab")
    pnInfo.labTitle = ngui.find_label(self.ui, path.."down/sp_title/lab")
    pnInfo.labLevel = ngui.find_label(self.ui, path.."down/sp_title/lab_level")
    pnInfo.labPropertyDesc = ngui.find_label(self.ui, path.."down/sp_bk1/lab1")
    pnInfo.labEffectDesc = ngui.find_label(self.ui, path.."down/sp_bk1/lab2")

    pnInfo.sub = {}
    for i=1, 5  do
        pnInfo.sub[i] = self.ui:get_child_by_name(path.."down/sp_bk2/cont"..i)
    end

    --可解锁
    pnInfo.toUnLock = {}
    pnInfo.toUnLock.cond = {{},{}}
    pnInfo.toUnLock.cond[1].self = pnInfo.sub[1]:get_child_by_name("sp2")
    pnInfo.toUnLock.cond[1].labCont = ngui.find_label(pnInfo.sub[1], "sp2/lab")
    pnInfo.toUnLock.cond[2].self = pnInfo.sub[1]:get_child_by_name("sp3")
    pnInfo.toUnLock.cond[2].labCont = ngui.find_label(pnInfo.sub[1], "sp3/lab")
    pnInfo.toUnLock.cond[1].labCont:set_color(1,1,1,1) -- 恢复默认颜色
    pnInfo.toUnLock.cond[2].labCont:set_color(1,1,1,1) -- 恢复默认颜色
    pnInfo.toUnLock.btnUnlock = ngui.find_button(pnInfo.sub[1], "btn")
    pnInfo.toUnLock.btnUnlock:set_on_click(self.bindfunc["on_btn_unlock"])

    --已满级

    --不可解锁
    pnInfo.notUnLock = {}
    pnInfo.notUnLock.cond = {{},{}}
    pnInfo.notUnLock.cond[1].self = pnInfo.sub[3]:get_child_by_name("sp2")
    pnInfo.notUnLock.cond[1].labCont = ngui.find_label(pnInfo.sub[3], "sp2/lab")
    pnInfo.notUnLock.cond[2].self = pnInfo.sub[3]:get_child_by_name("sp3")
    pnInfo.notUnLock.cond[2].labCont = ngui.find_label(pnInfo.sub[3], "sp3/lab")
    pnInfo.notUnLock.cond[1].labCont:set_color(1,1,1,1) -- 恢复默认颜色
    pnInfo.notUnLock.cond[2].labCont:set_color(1,1,1,1) -- 恢复默认颜色

    --可升级
    pnInfo.toUpgrade = {}
    pnInfo.toUpgrade.cost = {{},{}}
    pnInfo.toUpgrade.cost[1].self = pnInfo.sub[4]:get_child_by_name("sp2")
    pnInfo.toUpgrade.cost[1].txCost = ngui.find_texture(pnInfo.sub[4], "sp2/texture")
    pnInfo.toUpgrade.cost[1].labCost = ngui.find_label(pnInfo.sub[4], "sp2/lab")
    pnInfo.toUpgrade.cost[2].self = pnInfo.sub[4]:get_child_by_name("sp3")
    pnInfo.toUpgrade.cost[2].txCost = ngui.find_texture(pnInfo.sub[4], "sp3/texture")
    pnInfo.toUpgrade.cost[2].labCost = ngui.find_label(pnInfo.sub[4], "sp3/lab")
    pnInfo.toUpgrade.cost[1].labCost:set_color(1,1,1,1) -- 恢复默认颜色
    pnInfo.toUpgrade.cost[2].labCost:set_color(1,1,1,1) -- 恢复默认颜色
    pnInfo.toUpgrade.btnUpgrade = ngui.find_button(pnInfo.sub[4], "btn")
    pnInfo.toUpgrade.btnUpgrade:set_on_click(self.bindfunc["on_btn_upgrade"])

    --已学习其他
    pnInfo.otherUnLock = {}
    pnInfo.otherUnLock.labContent = ngui.find_label(pnInfo.sub[5], "lab")
    
    self.pnInfo = pnInfo

    self.heroListUi = CommonHeroListUI:new({
        parent = self.ui,
        isRestraintUi = true,
        tipType = SmallCardUi.TipType.Restraint,
        callback = {
            update_choose_hero = self.bindfunc["update_choose_hero"],
        }
    })
    if self.roleData then
        self.heroListUi:SetRoleNumber(self.roleData.number);
        self.heroListUi:UpdateUi();

        local ui = uiManager:FindUI(EUI.BattleUI)
        if ui and ui.GetHeroListUi then
            self.heroListUi:SetRelatedList(ui:GetHeroListUi());
        end
    end

    self.wrapContent:set_min_index(1 - #self.restrainGroup)
    self.wrapContent:set_max_index(0)
    self.wrapContent:reset()

    self:UpdateUi()
end

function RestraintUi:UpdateUi()
    if self.ui == nil then return end
    
    self:UpdateRoleInfo()
    self:UpdateRestraintView()
    self:UpdateRestraintList()

    if self.heroListUi then
        self.heroListUi:UpdateCurrHero()
        self.heroListUi:UpdateHeroTips()
    end
end

function RestraintUi:UpdateRoleInfo()
    if self.roleData == nil then return end

    self.uiBigCard:SetData(self.roleData)
end

function RestraintUi:UpdateRestraintView()
    if self.roleData == nil then return end

    local level = self.restrain_valid[self.currentId] or 0
    self.currentCfg = ConfigHelper.GetRestrainConfig(self.roleData.config.restrain, self.currentId)[level + 1]
    self.pnInfo.txIcon:set_texture(self.currentCfg.icon)
    self.pnInfo.labName:set_text(self.currentCfg.name)

    local levelStr = string.format(_local.UIText[12], level, 
        ConfigHelper.GetRestrainMaxLevel(self.roleData.config.restrain, self.currentId))
    self.pnInfo.labLevel:set_text(levelStr)
    -- self.pnInfo.labPropertyDesc:set_text(self:GetPropertyDesc(self.currentCfg))
    self.pnInfo.labEffectDesc:set_text(self.currentCfg.des)

    --未开启灰显
    if self.restrain_valid[self.currentId] then
        -- PublicFunc.SetUISpriteWhite(self.pnInfo.txIcon)
        self.pnInfo.labPropertyDesc:set_text(self:GetPropertyDesc(self.currentCfg))
    else
        -- PublicFunc.SetUISpriteGray(self.pnInfo.txIcon)
        self.pnInfo.labPropertyDesc:set_text(tostring(self.currentCfg.pro_des0))
    end
    
    local state, value = self:GetRestrainState(self.currentId)
    self:SetRestraintViewState(state, value)
end

function RestraintUi:UpdateRestraintList()
    if self.roleData == nil then return end

    if table.get_num(self.restrain_valid) > 1 then
        -- self.btnResetAll:set_active(true)
        -- self.labResetAllTips:set_active(true)
        
        self.spResetAll:set_sprite_name("ty_anniu4")
        self.labResetAll:set_effect_color(29/255,85/255,160/255,1)
    else
        -- self.btnResetAll:set_active(false)
        -- self.labResetAllTips:set_active(false)
        
        self.spResetAll:set_sprite_name("ty_anniu5")
        self.labResetAll:set_effect_color(141/255,141/255,141/255,1)
    end

    --
    for b, item in pairs(self.listItems) do
        self:LoadItem(item, item.index)
    end
end

function RestraintUi:Show()
    if UiBaseClass.Show(self) then
        self.fxUpgrade:set_active(false)
        self.aniUnlock:set_animator_enable(false)
    end
end

function RestraintUi:Hide()
    UiBaseClass.Hide(self)
end

function RestraintUi:SetRestraintViewState(state, value)
    --1已解锁(注意这里是同层解锁 value为解锁id) 2可解锁 3战队等级不足 4英雄品质不足
    --将state转换-->1条件不足 2可解锁 3同层已解锁 4可升级 5已满级
    if state > 2 then
        state = 1
    elseif state == 2 then
        state = 2
    elseif state == 1 then
        if value == self.currentId then
            if self.restrain_valid[self.currentId] < 
                ConfigHelper.GetRestrainMaxLevel(self.roleData.config.restrain, self.currentId) then
                state = 4
            else
                state = 5
            end
        else
            state = 3
        end
    end
    
    local showIndex = {[1]=3, [2]=1, [3]=5, [4]=4, [5]=2}
    for i, sub in pairs(self.pnInfo.sub) do
        sub:set_active(showIndex[state] == i)
    end

    --待解锁
    if showIndex[state] == 1 then
        local conditons = self:GetRestrainCondition(self.currentId);
        for i=1, 2 do
            local str = conditons[i]
            if str then
                self.pnInfo.toUnLock.cond[i].self:set_active(true)
                self.pnInfo.toUnLock.cond[i].labCont:set_text(str)
            else
                self.pnInfo.toUnLock.cond[i].self:set_active(false)
            end
        end
        self.pnInfo.toUnLock.btnUnlock:set_event_value("", self.currentId)
    end

    --已满级
    if showIndex[state] == 2 then
        --无
    end

    --不可解锁
    if showIndex[state] == 3 then
        local conditons = self:GetRestrainCondition(self.currentId);
        for i=1, 2 do
            local str = conditons[i]
            if str then
                self.pnInfo.notUnLock.cond[i].self:set_active(true)
                self.pnInfo.notUnLock.cond[i].labCont:set_text(str)
            else
                self.pnInfo.notUnLock.cond[i].self:set_active(false)
            end
        end
    end

    --可升级
    if showIndex[state] == 4 then
        local costData = self:GetUpdateCostData(self.currentId)
        for i=1, 2 do
            if costData[i] then
                self.pnInfo.toUpgrade.cost[i].self:set_active(true)
                --不足
                if PropsEnum.GetValue(costData[i].id) < costData[i].num then
                    costStr = string.format("[ff0000]%s[-]", costData[i].num)
                else
                    costStr = string.format("[0bbdf9]%s[-]", costData[i].num)
                end
                self.pnInfo.toUpgrade.cost[i].labCost:set_text(costStr)
                PublicFunc.SetItemTexture(self.pnInfo.toUpgrade.cost[i].txCost, costData[i].id)
            else
                self.pnInfo.toUpgrade.cost[i].self:set_active(false)
            end
        end
        self.pnInfo.toUpgrade.btnUpgrade:set_event_value("", self.currentId)
    end

    --已学习其他
    if showIndex[state] == 5 then
        local config = ConfigHelper.GetRestrainConfig(self.roleData.config.restrain, value)
        self.pnInfo.otherUnLock.labContent:set_text(string.format(_local.UIText[1], config[1].name))
    end
end

function RestraintUi:GetPropertyDesc(config)
    local value = 0
    if config.restraint1_damage_plus > 0 then
        value = config.restraint1_damage_plus
    elseif config.restraint2_damage_plus > 0 then
        value = config.restraint2_damage_plus
    elseif config.restraint3_damage_plus > 0 then
        value = config.restraint3_damage_plus
    elseif config.restraint4_damage_plus > 0 then
        value = config.restraint4_damage_plus
    elseif config.restraint_all_damage_plus > 0 then
        value = config.restraint_all_damage_plus
    elseif config.restraint1_damage_reduct > 0 then
        value = config.restraint1_damage_reduct
    elseif config.restraint2_damage_reduct > 0 then
        value = config.restraint2_damage_reduct
    elseif config.restraint3_damage_reduct > 0 then
        value = config.restraint3_damage_reduct
    elseif config.restraint4_damage_reduct > 0 then
        value = config.restraint4_damage_reduct
    elseif config.restraint_all_damage_reduct > 0 then
        value = config.restraint_all_damage_reduct
    end

    return string.format(config.pro_des, value)
end

function RestraintUi:GetRestrainCondition(id)
    local result = {}
    local config = ConfigHelper.GetRestrainConfig(self.roleData.config.restrain, id)[1]
    if config then
        local need_level, need_hero_qua = self:GetOpenCondition(config)
        if need_level then
            local str = string.format(_local.UIText[10], need_level)
            if need_level <= g_dataCenter.player.level then
                str = string.format("[0bbdf9]%s[-]", str)
            else
                str = string.format("[8b8b8b]%s[-]", str)
            end
            table.insert(result, str)
        end
        if need_hero_qua then
            local str = string.format(_local.UIText[11], PublicFunc.GetHeroRarityStr(need_hero_qua))
            if need_hero_qua <= self.roleData.config.real_rarity then
                str = string.format("[0bbdf9]%s[-]", str)
            else
                str = string.format("[8b8b8b]%s[-]", str)
            end
            table.insert(result, str)
        end
    end
    return result
end

function RestraintUi:GetOpenCondition(config)
    local need_level, need_hero_qua = nil, nil
    for i, open_condition in pairs(PublicFunc.GetConfigDataValue(config.open_condition)) do
        if open_condition[_local.UnlockType["team_level"]] then
            need_level = open_condition[_local.UnlockType["team_level"]]
        elseif open_condition[_local.UnlockType["role_qua"]] then
            need_hero_qua = open_condition[_local.UnlockType["role_qua"]]
        end
    end
    return need_level, need_hero_qua
end

function RestraintUi:GetFloorState(group)
    return self:GetRestrainState(group[1])
end

function RestraintUi:GetRestrainState(id)
    local result = 0    --1已解锁(注意这里是同层解锁 value为解锁id) 2可解锁 3战队等级不足 4英雄品质不足
    local value = nil

    local config = ConfigHelper.GetRestrainConfig(self.roleData.config.restrain, id)[1]
    local need_level, need_hero_qua = self:GetOpenCondition(config)
    if need_level and need_level > g_dataCenter.player.level then
        result = 3
    elseif need_hero_qua and need_hero_qua > self.roleData.config.real_rarity then
        result = 4
    else
        if self.restrain_valid[id] then
            result = 1
            value = id
        else
            local floorIndex = self.restrainIdGroup[id]
            for index, _id in pairs(self.restrainGroup[floorIndex]) do
                if self.restrain_valid[_id] then
                    value = _id
                    break;
                end
            end
            if value then
                result = 1
            else
                result = 2
            end
        end
    end

    return result, value
end

function RestraintUi:GetUpdateCostData(upgradeId)
    local costData = {}
    local level = self.restrain_valid[upgradeId] or 0
    local config = ConfigHelper.GetRestrainConfig(self.roleData.config.restrain, upgradeId)
    if config then
        for i, cost in pairs(PublicFunc.GetConfigDataValue(config[level+1].upgrade_cost)) do
            local id, num = next(cost)
            table.insert(costData, {id=id, num=num})
        end
    end
    return costData
end

function RestraintUi:GetResetCostData(resetId)
    local costData = {id=IdConfig.Crystal, num=0} --只消费钻石
    if resetId == 0 then
        --总花费=各项之和*折扣系数
        for k, v in pairs(self.restrain_valid) do
            local config = ConfigHelper.GetRestrainConfig(self.roleData.config.restrain, k)
            local id, num = next(config[v + 1].reset_cost)
            costData.id = id
            costData.num =  costData.num + num
        end
        local discount = PublicFunc.GetDiscreteConfig(MsgEnum.ediscrete_id.eDiscreteId_restrainAllReset, 100)
        costData.num = math.floor(costData.num * discount / 100)
    else
        local config = ConfigHelper.GetRestrainConfig(self.roleData.config.restrain, resetId)
        if config then
            costData.id, costData.num = next(config[self.restrain_valid[resetId] + 1].reset_cost)
        end
    end
    return costData
end

function RestraintUi:LoadItem(item, index)
    item.index = index

    local data = self.restrainGroup[index]
    if data then
        local state, value = self:GetFloorState(data)

        item.spLock:set_active(state > 2)
        item.labLock:set_active(state > 2)
        item.labText:set_active(state <= 2)
        -- item.spBorder:set_active(state == 2)
        item.spMask:set_active(state > 2)
        item.btnReset:set_active(state == 1)

        if type(value) == "number" then
            item.btnReset:set_event_value("", value)
        end

        if state == 1 then
            local config = ConfigHelper.GetRestrainConfig(self.roleData.config.restrain, value)
            item.labText:set_text(string.format(_local.UIText[1], config[1].name))
        elseif state == 2 then
            item.labText:set_text(_local.UIText[3])
        else
            local conditonStr = table.concat(self:GetRestrainCondition(data[1]), " ");
            item.labLock:set_text(conditonStr)
        end

        for i, icon in pairs(item.arrIcon) do
            local id = data[i]
            if id then
                icon.self:set_active(true)
                local config = ConfigHelper.GetRestrainConfig(self.roleData.config.restrain, id)
                icon.txIcon:set_texture(config[1].icon)
                icon.btn:set_event_value("", id)

                if self.restrain_valid[id] then
                    icon.bgText:set_active(true)
                    icon.labText:set_active(true)
                    if self.restrain_valid[id] < ConfigHelper.GetRestrainMaxLevel(self.roleData.config.restrain, id) then
                        icon.labText:set_text("Lv."..self.restrain_valid[id])
                    else
                        icon.labText:set_text("MAX")
                    end
                else
                    icon.bgText:set_active(false)
                    icon.labText:set_active(false)
                end

                --选中效果
                icon.spFocus:set_active(self.currentId == id)
                
                if state > 2 then
                    icon.spMask:set_active(false) -- 已有整体蒙版
                else
                    --未开启的加单个蒙版
                    if self.restrain_valid[id] then
                        -- PublicFunc.SetUISpriteWhite(icon.txIcon)
                        icon.spMask:set_active(false)
                    else
                        -- PublicFunc.SetUISpriteGray(icon.txIcon)
                        icon.spMask:set_active(true)
                    end
                end
            else
                icon.self:set_active(false)
            end
        end
    end
end

function RestraintUi:on_init_item(obj, b, real_id)	
    local index = math.abs(real_id) + 1

    local item = self.listItems[b]
    if not item then
        item = {}

        item.arrIcon = {}
        for i=1, 3 do
            item.arrIcon[i] = {}
            item.arrIcon[i].self = obj:get_child_by_name("shu_xing"..i)
            item.arrIcon[i].btn = ngui.find_button(item.arrIcon[i].self, item.arrIcon[i].self:get_name())
            item.arrIcon[i].txIcon = ngui.find_texture(item.arrIcon[i].self, "sp_shu_xing1")
            item.arrIcon[i].bgText = item.arrIcon[i].self:get_child_by_name("sp_max")
            item.arrIcon[i].labText = ngui.find_label(item.arrIcon[i].bgText, "lab")
            item.arrIcon[i].spFocus = item.arrIcon[i].self:get_child_by_name("sp_kuang1")
            item.arrIcon[i].spMask = ngui.find_sprite(item.arrIcon[i].self, "sp_mengban")

            item.arrIcon[i].btn:set_on_click(self.bindfunc["on_btn_item"])
        end
        -- item.spBorder = ngui.find_sprite(obj, "sp_bk1")
        item.spMask = ngui.find_sprite(obj, "sp_bk2")
        item.labText = ngui.find_label(obj, "lab1")
        item.labLock = ngui.find_label(obj, "lab2")
        item.spLock = ngui.find_sprite(obj, "sp_suo")
        item.btnReset = ngui.find_button(obj, "btn1")
        item.btnReset:set_on_click(self.bindfunc["on_btn_reset"])

        self.listItems[b] = item
    end

    self:LoadItem(item, index)
end

function RestraintUi:on_btn_upgrade(t)
    local upgradeId = t.float_value
    local costData = self:GetUpdateCostData(upgradeId)
    for i, data in pairs(costData) do
        local count = PropsEnum.GetValue(data.id)
        --消耗道具不足
        if count < data.num then
            local itemCfg = ConfigManager.Get(EConfigIndex.t_item, data.id)
            FloatTip.Float(string.format(_local.UIText[2], itemCfg.name))
            return;
        end
    end
    msg_cards.cg_restrain_upgrade(self.roleData.index, upgradeId)
end

function RestraintUi:on_btn_unlock(t)
    local unlockId = t.float_value
    msg_cards.cg_restrain_unlock(self.roleData.index, unlockId)
end

function RestraintUi:on_btn_reset(t)
    local openCount = table.get_num(self.restrain_valid)
    if openCount == 0 then
        return
    end

    local resetId = t.float_value
    local costData = self:GetResetCostData(resetId)
    local lack = (PropsEnum.GetValue(costData.id) < costData.num)

    -- 不满足全部重置条件
    if openCount == 1 and resetId == 0 then
        FloatTip.Float(_local.UIText[18])
        return
    end

    -- 没有重置消耗
    if costData.num == 0 then
        _local.send_msg_reset({role_dataid=self.roleData.index, id=resetId})
        return
    end

    local btn1 = {};
    btn1.str = "确定";
    btn1.func = _local.send_msg_reset
    btn1.param = {role_dataid=self.roleData.index, id=resetId, recharge=lack}

    local btn2 = {};
    btn2.str = "取消";

    local costNumStr = lack and string.format("[ff0000]%s[-]", costData.num) or costData.num
    --重置全部
    if resetId == 0 then
        local content = string.format(_local.UIText[15], costData.id, costNumStr)
        HintUI.SetAndShowHybrid(2, _local.UIText[13], content, nil, btn1, btn2)
    else
        local content = string.format(_local.UIText[16], costData.id, costNumStr)
        HintUI.SetAndShowHybrid(2, _local.UIText[14], content, nil, btn1, btn2)
    end
end

function RestraintUi:on_btn_item(t)
    self.currentId = t.float_value

    self:UpdateUi()
end

function RestraintUi:on_btn_total_plus()
    uiManager:PushUi(EUI.RestraintTotalPlusUi, self.roleData)
end

function RestraintUi:gc_restrain_unlock(role_dataid, id)
    if self.roleData.index ~= role_dataid then return end

    self.aniUnlock:set_animator_enable(true)
    self.aniUnlock:animator_play("ui_7001_ke_zhi")
    self.fxUpgrade:set_active(false)
    self.fxUpgrade:set_active(true)
    AudioManager.PlayUiAudio(ENUM.EUiAudioType.RestraintNormal)
    self:UpdateUi()
end

function RestraintUi:gc_restrain_upgrade(role_dataid, id)
    if self.roleData.index ~= role_dataid then return end

    self.aniUnlock:set_animator_enable(true)
    self.aniUnlock:animator_play("ui_7001_ke_zhi")
    self.fxUpgrade:set_active(false)
    self.fxUpgrade:set_active(true)
    AudioManager.PlayUiAudio(ENUM.EUiAudioType.RestraintNormal)
    self:UpdateUi()
end

function RestraintUi:gc_restrain_reset(role_dataid, id, costBack)
    if self.roleData.index ~= role_dataid then return end

    FloatTip.Float(_local.UIText[5])

    -- 表现返还的金币以及克制点
    if costBack and #costBack > 0 then
        CommonAward.Start(costBack, CommonAwardEType.reset)
    end

    self:UpdateUi()
end

--英雄属性改变
function RestraintUi:on_update_card_info(cardInfo)
    self:UpdateUi()
end

function RestraintUi:update_choose_hero(roleData)
    self.roleData = roleData
    self.restrain_valid = self.roleData:GetRestrainValid()
    self.restrainGroup = ConfigHelper.GetRestrainGroup(self.roleData.config.restrain)
    self.restrainIdGroup = ConfigHelper.GetRestrainIdGroup(self.roleData.config.restrain)

    self:UpdateUi()
end
