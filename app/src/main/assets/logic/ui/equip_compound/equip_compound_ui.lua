


EquipCompoundUI = Class("EquipCompoundUI", UiBaseClass)

local canCompoundMAXRarity = 0

function EquipCompoundUI:Init(data)
	self.pathRes = "assetbundles/prefabs/ui/zhenrong/ui_620_equip_compound.assetbundle";
    UiBaseClass.Init(self, data);
end

function EquipCompoundUI:InitData(data)
    UiBaseClass.InitData(self, data);
    self.equipListIndex2ItemObj = {}
    self.selectItemIndexAndMatIndex = {}
    self.paddingTexture = {}
    self.matUiSmallItems = {}

    canCompoundMAXRarity = ConfigManager.GetDataCount(EConfigIndex.t_equip_composite) 
end

function EquipCompoundUI:RegistFunc()
    UiBaseClass.RegistFunc(self);
    self.bindfunc["OnClickQuckPutIn"]	   = Utility.bind_callback(self, EquipCompoundUI.OnClickQuckPutIn)
    self.bindfunc["OnClickStartCompound"]	   = Utility.bind_callback(self, EquipCompoundUI.OnClickStartCompound)
    self.bindfunc["OnCompoundResult"]	   = Utility.bind_callback(self, EquipCompoundUI.OnCompoundResult)
    self.bindfunc["OnClickFilter"]	   = Utility.bind_callback(self, EquipCompoundUI.OnClickFilter)
    self.bindfunc["OnClickMaterial"]	   = Utility.bind_callback(self, EquipCompoundUI.OnClickMaterial)
    self.bindfunc["EuipListItemInit"]	   = Utility.bind_callback(self, EquipCompoundUI.EuipListItemInit)
    self.bindfunc["OnClickEquipListItem"]	   = Utility.bind_callback(self, EquipCompoundUI.OnClickEquipListItem)
    self.bindfunc["OnFilterEquipResult"]	   = Utility.bind_callback(self, EquipCompoundUI.OnFilterEquipResult)
    self.bindfunc["OnClickRuleBtn"]	   = Utility.bind_callback(self, EquipCompoundUI.OnClickRuleBtn)
end

function EquipCompoundUI:OnClickQuckPutIn()

    --while(true) do
        --self.equipListUI:set_min_index(-1)
        --self.equipListUI:set_max_index(1)
        --self.equipListUI:reset()
        --self.listPanelScrollView:reset_position()
        --return
    --end

    --app.log('OnClickQuckPutIn')
    local count = self:GetSelectItemCount()

    if count >= 5 then
        return
    end

    --local searchQuality = ENUM.EEquipRarity.White
    local result = nil
    if count > 0 then
        searchQuality = self:GetSelectedQuality()
        local needCount = 5 - count
        result = self:SearchNoSelectedEquipIndex(searchQuality, needCount)
        if #result < needCount then
            result = nil
            HintUI.SetAndShow(EHintUiType.zero, gs_misc['tip_have_selected_quailty_no_enough'])
            return
        end
    else
        --Orange equip cann't compound
        for i = 1,canCompoundMAXRarity do
            result = self:SearchNoSelectedEquipIndex(i, 5)
            if #result >= 5 then
                break;
            end
        end
        if #result < 5 then
            HintUI.SetAndShow(EHintUiType.zero, gs_misc['tip_can_compound_num_no_enough'])
            result = nil
            return 
        end
    end

    if result ~= nil then
        for k,v in pairs(result) do
            self:OnClickEquipListItem({float_value = v})
        end
    end

end

function EquipCompoundUI:SearchNoSelectedEquipIndex(quality, count)
    local result = {}
    for k,v in pairs(self.equipList) do
        if v.rarity == quality then
            local isSec = self:CheckEquipIsSelected(k)
            if isSec == false then
                table.insert(result, k)
                if #result >= count then
                    break
                end
            end
        end
    end
    return result
end

function EquipCompoundUI:OnClickStartCompound()
    --app.log('OnClickStartCompound')

    local compoundEquipList = {}
    for index,v in pairs(self.selectItemIndexAndMatIndex) do
        local equip = self.equipList[index]
        table.insert(compoundEquipList, tostring(equip.index))
    end

    self.loadingId = GLoading.Show(GLoading.EType.ui)
    msg_cards.cg_equip_composite(compoundEquipList, self.bindfunc["OnCompoundResult"])
    --app.log('cg_equip_composite ' .. table.tostring(compoundEquipList))
end

function EquipCompoundUI:GetEquip(items)
    local res = {}
    for k, v in ipairs(items) do
        if not PropsEnum.IsGold(v.id) and not PropsEnum.IsImprovedGems(v.id) then
            table.insert(res, v)
        end
    end
    return res
end

function EquipCompoundUI:GetNotEquip(items)
    local res = {}
    for k, v in ipairs(items) do
        if PropsEnum.IsGold(v.id) or PropsEnum.IsImprovedGems(v.id) then
            table.insert(res, v)
        end
    end
    return res
end

function EquipCompoundUI:ShowSuccessFinish()
    --app.log('EquipCompoundUI:ShowSuccessFinish' .. table.tostring(self.noEquipList))
    if self.noEquipList ~= nil and #self.noEquipList > 0 then
        local awardList = {}
        for key,value in pairs(self.noEquipList) do
            table.insert(awardList, {dataid='0', id=value.id, count = value.count})
        end
        CommonAward.Start(awardList, 1)
    end
end

function EquipCompoundUI:OnCompoundResult(result, equips)
    GLoading.Hide(GLoading.EType.ui, self.loadingId)

    --local show,info = PublicFunc.GetErrorString(result, false);
    local show = true;

    --app.log_warning('OnCompoundResult ' .. tostring(result) .. ' ' .. table.tostring(equips))

    if show then
        self:UpdateEquipListContent(PublicFunc.GetEquipment())

        if #equips == 0 then    
            app.log('equip compound error, do not return equip ')
        end

        local equipList = self:GetEquip(equips)
        self.noEquipList = self:GetNotEquip(equips)
        local awardList = {}
        for key,value in pairs(equipList) do
            table.insert(awardList, {dataid='0', id=value.id, count = value.count})
        end

        CommonAward.Start(awardList, 2)
        CommonAward.SetFinishCallback(EquipCompoundUI.ShowSuccessFinish, self)
        
    else
        if result == MsgEnum.error_code.error_code_fail then

            self:UpdateEquipListContent(PublicFunc.GetEquipment())

            local awardList = {}
            local goldNum = 0
            for key,value in pairs(equips) do
                if PropsEnum.IsGold(value.id) then
                    goldNum = goldNum + value.count
                else
                    table.insert(awardList, {dataid='0', id=value.id, count = value.count})
                end
            end
            if goldNum > 0 then
                table.insert(awardList, {dataid='0', id=IdConfig.Gold, count = goldNum})
            end

            CommonFailAward.Start(awardList);
        else
            HintUI.SetAndShow(EHintUiType.zero, info)
            --app.log('error')
        end
    end

    self:ShowTipInfo()
end

function EquipCompoundUI:OnClickFilter()
    --app.log('OnClickFilter')
    local filterUI = uiManager:PushUi(EUI.EquipFilterUI)
    filterUI:SetFilterResultCallback(self.bindfunc["OnFilterEquipResult"])
    filterUI:SetDefaultState(self._selectState)
    filterUI:SetEquippedFilter({EquipSelectedPos2TypeValue[2]})
end

function EquipCompoundUI:OnClickMaterial(si, param)
    --app.log('EquipCompoundUI:OnClickMaterial ' .. table.tostring(param))
    local equipIndex = self:GetMatEquipIndex(param.float_value)
    if equipIndex < 0 then
        return
    end
    self:OnClickEquipListItem({float_value = equipIndex})
end

function EquipCompoundUI:EuipListItemShine(obj, isShow)
    local shineEffect = ngui.find_sprite(obj, "sp_shine")
    shineEffect:set_active(isShow)
end

function EquipCompoundUI:EuipListItemInit(obj,b,real_id)
    --app.log('real_id ' .. tostring(real_id) .. ' b ' .. tostring(b))
    local equipIndex = math.abs(real_id) + 1
    local equip = self.equipList[equipIndex]
    local id = equip.number
    local sprite  = ngui.find_texture(obj, "sp_equip")
    sprite:set_texture(equip.small_icon);
    local name = obj:get_name()
    if self.paddingTexture[name] ~= nil then
        self.paddingTexture[name]:Destroy()    
    end
    self.paddingTexture[name] = sprite;
    sprite  = ngui.find_sprite(obj, "sp_frame")
    PublicFunc.SetIconFrameSprite(sprite,equip.rarity)

    local label = ngui.find_label(obj, 'lab_equip_name')
    label:set_text(equip.name)
    label = ngui.find_label(obj, 'lab_level')
    label:set_text("LV." .. tostring(equip.level))
    local spLetter = ngui.find_sprite(obj,"sp_letter");
    PublicFunc.SetEquipRaritySprite(spLetter,equip.rarity);

    local star = {}
    for i=1,5 do
        star[i] = ngui.find_sprite(obj,"star/star_di"..i.."/sp_star");
    end
    for i=1,5 do
        if i > equip.star then
            star[i]:set_active(false);
        else
            star[i]:set_active(true);
        end
    end

    obj:get_child_by_name("sp_human_di"):set_active(false)

    local show_shine = false
    if self.selectItemIndexAndMatIndex[equipIndex] ~= nil then
        show_shine = true
    end
    self:EuipListItemShine(obj, show_shine)

    local btn = ngui.find_button(obj, name .. '/sp_di')
    btn:set_event_value(tostring(equipIndex), equipIndex)
    btn:reset_on_click()
    btn:set_on_click(self.bindfunc["OnClickEquipListItem"])

    for k,v in pairs(self.equipListIndex2ItemObj) do
        if v:get_name() == name then
            --app.log('xx ' .. k)
            self.equipListIndex2ItemObj[k] = nil 
        end
    end
    self.equipListIndex2ItemObj[equipIndex] = obj
end

function EquipCompoundUI:CheckEquipIsSelected(equipIndex)
    for k,v in pairs(self.selectItemIndexAndMatIndex) do
        if equipIndex == k then
            return true
        end
    end
    return false
end

function EquipCompoundUI:GetMatEquipIndex(matIndex)
    for k,v in pairs(self.selectItemIndexAndMatIndex) do
        if matIndex == v then
            return k
        end
    end
    return -1
end

function EquipCompoundUI:GetSelectItemCount()
    local count = 0
    for k,v in pairs(self.selectItemIndexAndMatIndex) do
        count = count + 1
    end
    return count
end

function EquipCompoundUI:GetAEmptyMatIndex()
   
    for i = 1,5 do
        local canUse = true  
        for k,v in pairs(self.selectItemIndexAndMatIndex) do
            if v == i then
               canUse = false
               break
            end
        end
        if canUse then
            return i
        end
    end
    return -1
end

function EquipCompoundUI:GetSelectedQuality()
    local quality = -1
    for k,v in pairs(self.selectItemIndexAndMatIndex) do
        quality = self.equipList[k].rarity
        break
    end
    return quality
end

function EquipCompoundUI:CheckCompoundQuality(equipIndex)

    local quality = self:GetSelectedQuality()

    if quality ~= -1 then
        local equip = self.equipList[equipIndex]
        if equip.rarity ~= quality then
            return false
        end
    end

    return true
end

function EquipCompoundUI:OnClickEquipListItem(param)
    --app.log('OnClickEquipListItem ' .. param.float_value)

    if self:CheckCompoundQuality(param.float_value) == false then
        HintUI.SetAndShow(EHintUiType.zero, gs_misc['tip_need_same_quality_equip'])
        return
    end

    local equip = self.equipList[param.float_value]
    --equip.rarity = ENUM.EEquipRarity.Orange
    if equip.rarity > canCompoundMAXRarity then
        HintUI.SetAndShow(EHintUiType.zero, gs_misc['tip_rarity_cannot_compound'])
        return
    end

    local shine = false
    if self.selectItemIndexAndMatIndex[param.float_value] == nil then
        if self:GetSelectItemCount() < 5 then
            shine = true
            local matIndex = self:GetAEmptyMatIndex()
            --app.log('x2x ' .. matIndex .. ' ' .. table.tostring(self.selectItemIndexAndMatIndex) )
            self.selectItemIndexAndMatIndex[param.float_value] = matIndex

            self:SetMaterialContent(matIndex, param.float_value)
        end
    else
        self:SetMaterialContent(self.selectItemIndexAndMatIndex[param.float_value])
        self.selectItemIndexAndMatIndex[param.float_value] = nil
    end

    local obj = self.equipListIndex2ItemObj[param.float_value]
    if obj ~= nil then
        self:EuipListItemShine(obj, shine)
    end

    if self:GetSelectItemCount() >= 5 then
        self.btnQuickPutIn:set_active(false)
        self.btnStartCompound:set_active(true)
    else
        self.btnQuickPutIn:set_active(true)
        self.btnStartCompound:set_active(false)
    end

    self:ShowTipInfo()
end

function EquipCompoundUI:ShowTipInfo()

    if self:GetSelectItemCount() >= 5 then
        self.costGoldNode:set_active(true)
        self.probabilityShowNode:set_active(true)

        self.selectTipLabel:set_active(false)
        self.compoundResultTipNode:set_active(false)

        local quality = self:GetSelectedQuality()
        local compoundConfig = ConfigManager.Get(EConfigIndex.t_equip_composite,quality)
        if compoundConfig == nil then
            local max = 0
            -- for k,v in pairs(gd_equip_composite) do
            for k,v in pairs(ConfigManager._GetConfigTable(EConfigIndex.t_equip_composite)) do
                if v.rarity > max then
                    max = v.rarity
                end
            end
            compoundConfig = ConfigManager.Get(EConfigIndex.t_equip_composite,max)
        end
        if compoundConfig ~= nil then
            self.costGoldLabel:set_text(tostring(compoundConfig.gold))
        end

        local compoundRate = ConfigManager.Get(EConfigIndex.t_equip_composite_rate,quality)
        if compoundRate == nil then
            local max = 0
            -- for key,value in pairs(gd_equip_composite_rate) do
            for key,value in pairs(ConfigManager._GetConfigTable(EConfigIndex.t_equip_composite_rate)) do
                if value.rarity > max then
                    max = value.rarity
                end
            end
            compoundRate = ConfigManager.Get(EConfigIndex.t_equip_composite_rate,max)
        end

        if compoundRate ~= nil then
            --app.log('xx ' .. table.tostring(compoundRate))
            self.probabilityShowLabel:set_text(tostring(compoundRate[1].equip_rate) .. '%')
        end
    else
        self.costGoldNode:set_active(false)
        self.probabilityShowNode:set_active(false)

        self.selectTipLabel:set_active(true)
        self.compoundResultTipNode:set_active(true)
    end

end

function EquipCompoundUI:OnFilterEquipResult(equipList, selectState)
    self:UpdateEquipListContent(equipList, true)
    self._selectState = selectState
end

function EquipCompoundUI:OnClickRuleBtn()
    UiRuleDes.Start(ENUM.ERuleDesType.ZhuangBeiHeCheng)
end

function EquipCompoundUI:InitUI(asset_obj)
	UiBaseClass.InitUI(self, asset_obj)
	self.ui:set_parent(Root.get_root_ui_2d());
	self.ui:set_name("ui_620_equip_compound");
	self.ui:set_local_scale(Utility.SetUIAdaptation());
	self.ui:set_local_position(0,0,0);

    self.btnQuickPutIn = ngui.find_button(self.ui, "btn_putin")
    self.btnQuickPutIn:set_on_click(self.bindfunc["OnClickQuckPutIn"])
    self.btnStartCompound = ngui.find_button(self.ui, "btn_start")
    self.btnStartCompound:set_on_click(self.bindfunc["OnClickStartCompound"])
    self.btnQuickPutIn:set_active(true)
    self.btnStartCompound:set_active(false)
    self.btnFilter = ngui.find_button(self.ui, "btn_anniu")
    self.btnFilter:set_on_click(self.bindfunc["OnClickFilter"])

    for i=1,5 do
        self:InitMaterialGrid(i)
        self:SetMaterialContent(i)
    end

    self.equipListPanel = ngui.find_panel(self.ui, 'right_other/panel')
    self.equipListPanel:set_active(true)
    self.equipListUI = ngui.find_wrap_content(self.ui, 'right_other/panel/warp_content')
    self.equipListUI:set_on_initialize_item(self.bindfunc["EuipListItemInit"])
    self.equipListTip = ngui.find_label(self.ui, "right_other/sp_background/lab_tips")
    self.equipListTip:set_active(false)
    self.listPanelScrollView = ngui.find_scroll_view(self.ui, "right_other/panel")

    local label = ngui.find_sprite(self.ui, 'contaniner_cost (1)')
    if label ~= nil then
        label:set_active(false)
    end

    self.costGoldNode = self.ui:get_child_by_name('contaniner_cost')
    self.costGoldNode:set_active(false)
    self.costGoldLabel = ngui.find_label(self.ui, 'contaniner_cost/lab_cost')

    self.selectTipLabel = ngui.find_label(self.ui, 'txt_tips1')
    self.selectTipLabel:set_active(true)

    self.compoundResultTipNode = self.ui:get_child_by_name('container_part1')
    self.compoundResultTipNode:set_active(true)

    self.probabilityShowNode = self.ui:get_child_by_name('container_part2')
    self.probabilityShowNode:set_active(false)
    self.probabilityShowLabel = ngui.find_label(self.ui, 'container_part2/lab_success')


    self:UpdateEquipListContent(PublicFunc.GetEquipment())

    local btn = ngui.find_button(self.ui, "btn_rule")
    btn:set_on_click(self.bindfunc["OnClickRuleBtn"])

    self._selectState = nil
end

function EquipCompoundUI:InitMaterialGrid(matIndex)
--    local btn = ngui.find_button(self.ui, 'container_material' .. matIndex.."/small_card_item/sp_back")
--    btn:set_event_value(tostring(matIndex), matIndex)
--    btn:set_on_click(self.bindfunc["OnClickMaterial"])
    local parent = self.ui:get_child_by_name('container_material' .. tostring(matIndex))
    if parent and self.matUiSmallItems[matIndex] == nil then
        local si = UiSmallItem:new({obj=nil, parent = parent, delay = 1000, emptyBorder = 'waikuang_x_1'})
        si:SetLabNum(false);
        si:SetCallBack(self.OnClickMaterial, self)
        si:SetCallBackParam({float_value = matIndex})
        self.matUiSmallItems[matIndex] = si
    end
end

function EquipCompoundUI:SetMaterialContent(matIndex, equipIndex)

    local equipNameLabel = ngui.find_label(self.ui, 'container_material' .. matIndex.."/lab_equipname1")
    local ownLabel = ngui.find_label(self.ui, 'container_material' .. matIndex .. '/txt_own')
    local ownNumLabel = ngui.find_label(self.ui, 'container_material' .. matIndex.."/lab_own_num1")
    local addSprite = ngui.find_sprite(self.ui, 'container_material' .. matIndex.."/sp_mask/addible_container/sp_add")
    local sp_mark = ngui.find_sprite(self.ui, 'container_material' .. matIndex.."/sp_mask");

    if equipIndex == nil then
        equipNameLabel:set_active(false)
        ownLabel:set_active(false)
        ownNumLabel:set_active(false)
        addSprite:set_active(true)
        sp_mark:set_active(true);
        
        self.matUiSmallItems[matIndex]:SetData(nil)
    else
        equipNameLabel:set_active(true)
        ownLabel:set_active(true)
        ownNumLabel:set_active(true)
        addSprite:set_active(false)
        sp_mark:set_active(false);
    
        local equip = self.equipList[equipIndex]
        equipNameLabel:set_text(equip.name)
        ownNumLabel:set_text('' .. self:GetEquipCount(equip.number))

        self.matUiSmallItems[matIndex]:SetData(equip)
    end
end

function EquipCompoundUI:GetEquipCount(id)
    local count = 0
    for k,v in ipairs(self.equipList) do
        if v.number == id then
            count = count + 1
        end
    end
    return count
end

function EquipCompoundUI:ResetUIContent()
    for i=1,5 do
        self:SetMaterialContent(i)
    end

    for k,v in pairs(self.selectItemIndexAndMatIndex) do
        if self.equipListIndex2ItemObj[k] ~=nil then
            self:EuipListItemShine(self.equipListIndex2ItemObj[k], false)
        end
    end

    self.btnQuickPutIn:set_active(true)
    self.btnStartCompound:set_active(false)

    --self.equipListIndex2ItemObj = {}
    self.selectItemIndexAndMatIndex = {}
end

local equipASCOrderFunc = function (a,b)
		if tonumber(a.roleid) == 0 and tonumber(b.roleid) ~= 0 then
			return false;
		elseif tonumber(a.roleid) ~= 0 and tonumber(b.roleid) == 0 then
			return true;
		end
		if a.rarity < b.rarity then
			return true;
		elseif a.rarity > b.rarity then
			return false;
		end
		if a.star < b.star then
			return true;
		elseif a.star > b.star then
			return false;
		end
		if a.level < b.level then
			return true;
		elseif a.level > b.level then
			return false;
		end
		if a.number < b.number then
			return true;
		end
		return false;
	end

function EquipCompoundUI:UpdateEquipListContent(elist, isFilterResult)
    self:ResetUIContent()

    self.equipList = {}
    --app.log('x ' .. table.tostring(elist))
    for k,v in pairs(elist) do
        if (v.roleid == nil or tonumber(v.roleid) == 0) then
            table.insert(self.equipList, v)
        end
    end

    table.sort(self.equipList, equipASCOrderFunc)
    --app.log('x2 ' .. table.tostring(self.equipList))
    --app.log('equip list: ' .. table.tostring(self.equipList))

    self.equipCount = #self.equipList
    --app.log('12x ' .. self.equipCount)
    if self.equipCount ==0 then
        self.equipListUI:set_active(false)
        --self.equipListTip:set_active(true)
        self:ShowTip(true)
        local tipTxt = gs_misc['no_equip_text']
        if isFilterResult == true then
            tipTxt = gs_misc['no_quality_equip_text']
        end
        self.equipListTip:set_text(tipTxt)
    else
        self.equipListUI:set_active(true)
        --self.equipListTip:set_active(false)
        self:ShowTip(false)
        self.equipListUI:set_min_index(-self.equipCount + 1)
        self.equipListUI:set_max_index(0)
        self.equipListUI:reset()
        self.listPanelScrollView:reset_position()
    end
end

function EquipCompoundUI:ShowTip(show)
    local parant = self.equipListTip:get_parent()
    self.equipListTip:set_active(show)
    parant:set_active(show)
end

function EquipCompoundUI:DestroyUi()
    UiBaseClass.DestroyUi(self);

    for k,v in pairs(self.matUiSmallItems) do
        v:DestroyUi()
    end
    self.matUiSmallItems = {}

    for k,v in pairs(self.paddingTexture) do
        v:Destroy()
    end
    self.paddingTexture = {}
    
    
    self:InitData()
end

function EquipCompoundUI:Restart(data)
    UiBaseClass.Restart(self, data)
end


