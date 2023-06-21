EquipFilterUI = Class('EquipFilterUI', UiBaseClass)


EquipSelectedPos2TypeValue = 
{
    [1] = 1,                        --已装备
    [2] = 0,                        --未装备
    [3] = ENUM.EEquipType.Helmet,       --头盔1
    [4] = ENUM.EEquipType.Armor,     --铠甲2
    [5] = ENUM.EEquipType.Trouser,           --裤子3
    [6] = ENUM.EEquipType.Boots,            --靴子4
    [7] = ENUM.EEquipType.Accessories,      --饰品5
    [8] = ENUM.EEquipRarity.White,         --白1
    [9] = ENUM.EEquipRarity.Green,			--绿2
    [10] = ENUM.EEquipRarity.Blue,			--蓝3
    [11] = ENUM.EEquipRarity.Purple,			--紫4
    [12] = ENUM.EEquipRarity.Gold,		--金5
    --[13] = ENUM.EEquipRarity.Orange,			--橙6
}

local btnPos = 
{
    isEquipBegin = 1,
    isEquipEnd = 2,
    positionBegin = 3,
    positionEnd = 7,
    qualityBegin = 8,
    qualityEnd = 12,
}

function EquipFilterUI:Init(data)
    self.pathRes = "assetbundles/prefabs/ui/public/ui_606_battle.assetbundle";
    UiBaseClass.Init(self, data);
end

function EquipFilterUI:InitData(data)
    UiBaseClass.InitData(self, data);
    
    for i = btnPos.isEquipBegin,btnPos.qualityEnd do
        self['OnToggleChange' .. i] = function(self, isChecked)
            self:OnToggleChange(isChecked, i)
        end
    end

end

function EquipFilterUI:Restart()

    self.isEquippedFilter = {}
    self.equipPositionFilter = {}
    self.equipQualityFilter = {}

    self.__isEquippedFilter = nil
    self.__equipPositionFilter = nil
    self.__equipQualityFilter = nil
    self.defaultState = nil

    UiBaseClass.Restart(self)
end

function EquipFilterUI:SetGroupState(start, e, filter)
    for i = start,e do
        local toggle = self['toggle' .. i]
        if toggle ~= nil then
            local index = table.index_of(filter, EquipSelectedPos2TypeValue[i])
            if index >0 then
                toggle:set_value(true)
            else
                toggle:set_value(false)
            end
        end
    end
end

function EquipFilterUI:SetDefaultState(selectState)
    self.defaultState = selectState
    self:SetDefaultStateImpl()
end

function EquipFilterUI:SetEquippedFilter(filter)
    self.__isEquippedFilter = filter
    
    self:SetGroupState(btnPos.isEquipBegin, btnPos.isEquipEnd, filter)
end

function EquipFilterUI:SetEquipPositionFilter(filter)
    self.__equipPositionFilter = filter

    self:SetGroupState(btnPos.positionBegin, btnPos.positionEnd, filter)
end

function EquipFilterUI:SetEquipQualityFilter(filter)
    self.__equipQualityFilter= filter

    self:SetGroupState(btnPos.qualityBegin, btnPos.qualityEnd, filter)
end

function EquipFilterUI:RegistFunc()
    UiBaseClass.RegistFunc(self);
	
    self.bindfunc["on_back"] = Utility.bind_callback(self,self.on_back);
    self.bindfunc["on_ok"] = Utility.bind_callback(self,self.on_ok);

    for i = 1,12 do
        self.bindfunc['OnToggleChange' .. i] = Utility.bind_callback(self, self['OnToggleChange' .. i])
    end
end

function EquipFilterUI:UnRegistFunc()
    UiBaseClass.UnRegistFunc(self);
end

function EquipFilterUI:OnToggleChange(isChecked, index)
    --app.log('x ' .. tostring(isChecked) .. ' ' .. tostring(index))

    local tab = nil
    local _tab = nil
    if index >=1 and index <= 2 then
        if self.__isEquippedFilter == nil then
            tab = self.isEquippedFilter
        else
            _tab = self.__isEquippedFilter
        end
    elseif index >= 3 and index <= 7 then
        if self.__equipPositionFilter == nil then
            tab = self.equipPositionFilter
        else
            _tab = self.__equipPositionFilter
        end
    elseif index >= 8 and index <= 12 then
        if self.__equipQualityFilter == nil then
            tab = self.equipQualityFilter
        else
            _tab = self.__equipQualityFilter
        end
    end

    local type = EquipSelectedPos2TypeValue[index]
    if _tab ~= nil then
        local isExist = table.index_of(_tab, type)
        local toggle = self['toggle' .. index]
        if isExist > 0 then
            toggle:set_value(true)
        else
            toggle:set_value(false)
        end
        return 
    end

    if tab ~= nil then
        if isChecked then
            local index = table.index_of(tab, type)
            if index <= 0 then
                table.insert(tab, type)
                --app.log('x3 ' .. table.tostring(tab))
            end
        else
            local index = table.index_of(tab, type)
            if index > 0 then
                table.remove(tab, index)
                --app.log('x4 ' .. table.tostring(tab))
            end
        end
    end
end

function EquipFilterUI:on_back()
    uiManager:PopUi();
end

function EquipFilterUI:on_ok()

    if self._filterResultCallback ~= nil and _G[self._filterResultCallback] ~= nil then
        local res, selectState = self:GetSelectTypEquip()
        --app.log('filter result ' .. table.tostring(res))
        _G[self._filterResultCallback](res, selectState)
    end

    uiManager:PopUi();
end

function EquipFilterUI:InitUI(asset_obj)
    UiBaseClass.InitUI(self, asset_obj)
	
	self.ui:set_parent(Root.get_root_ui_2d());
	self.ui:set_name("ui_606_battle");
	self.ui:set_local_scale(Utility.SetUIAdaptation());
	self.ui:set_local_position(0,0,0);

    local _btn = ngui.find_button(self.ui,"sp_mark");
    _btn:set_on_click(self.bindfunc["on_back"]);
    _btn = ngui.find_button(self.ui, "btn_fork")
    _btn:set_on_click(self.bindfunc["on_back"]);
    _btn = ngui.find_button(self.ui, "btn_sure")
    _btn:set_on_click(self.bindfunc["on_ok"]);

    for i = 1, 12 do
        self['toggle' .. i] = ngui.find_toggle(self.ui, 'yeka' .. i .. '/sp')
        self['toggle' .. i]:set_on_change(self.bindfunc['OnToggleChange' .. i])
        self['toggle' .. i]:set_value(true);
    end

    self:SetDefaultStateImpl()
end

function EquipFilterUI:SetDefaultStateImpl()
    
    if self.ui == nil then
        return
    end
    if type(self.defaultState)=='table' then
        if type(self.defaultState.isEquippedFilter)=='table' then
            self.isEquippedFilter = self.defaultState.isEquippedFilter
            self:SetGroupState(btnPos.isEquipBegin, btnPos.isEquipEnd, self.isEquippedFilter)
        end

        if type(self.defaultState.equipPositionFilter)=='table' then
            self.equipPositionFilter = self.defaultState.equipPositionFilter
            self:SetGroupState(btnPos.positionBegin, btnPos.positionEnd, self.equipPositionFilter)
        end

        if type(self.defaultState.equipQualityFilter)=='table' then
            self.equipQualityFilter = self.defaultState.equipQualityFilter
            self:SetGroupState(btnPos.qualityBegin, btnPos.qualityEnd, self.equipQualityFilter)
        end
    end
    self.defaultState = nil
end

function EquipFilterUI:SetFilterResultCallback(fun)
    self._filterResultCallback = fun
end

function EquipFilterUI:Show()
	UiBaseClass.Show(self)
end

function EquipFilterUI:Hide()
	UiBaseClass.Hide(self)
end

function EquipFilterUI:GetSelectTypEquip()
    local equipList = PublicFunc.GetEquipment()
    local resultList = {}
    local selectState = {}
    selectState.isEquippedFilter = self.__isEquippedFilter or self.isEquippedFilter
    selectState.equipPositionFilter = self.__equipPositionFilter or self.equipPositionFilter
    selectState.equipQualityFilter = self.__equipQualityFilter or self.equipQualityFilter
    for k,v in pairs(equipList) do
        local isEquiped = 1
        if v.roleid == nil or v.roleid == tostring(0) then
            isEquiped = 0
        end
        local isEquipedTest = true
        local equipPositionTest = true
        local qualityTest = true
        if self.__isEquippedFilter == nil then
            isEquipedTest = table.index_of(self.isEquippedFilter, isEquiped) > 0
        else
            isEquipedTest = table.index_of(self.__isEquippedFilter, isEquiped) > 0
        end
        if self.__equipPositionFilter == nil then
            equipPositionTest = table.index_of(self.equipPositionFilter, v.position) > 0
        else
            equipPositionTest = table.index_of(self.__equipPositionFilter, v.position) > 0
        end

        if self.__equipQualityFilter == nil then
            qualityTest = table.index_of(self.equipQualityFilter, v.rarity) > 0
        else
            qualityTest = table.index_of(self.__equipQualityFilter, v.rarity) > 0
        end

        --app.log('x44 ' .. tostring(isEquipedTest) .. ' ' .. tostring(equipPositionTest) .. ' ' .. tostring(qualityTest) .. ' ' .. tostring(isEquiped))
        if isEquipedTest and equipPositionTest and qualityTest then
            table.insert(resultList, v)
        end
    end

    return resultList, selectState
end

function EquipFilterUI:DestroyUi()
    if self.ui then
        for i = 1, 12 do
            self['toggle' .. i] = nil
        end
    end

    UiBaseClass.DestroyUi(self);
end