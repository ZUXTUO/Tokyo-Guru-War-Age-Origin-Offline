
PropertyRestraintUi = Class("PropertyRestraintUi", UiBaseClass);

local _UIText = {
    [1] = "伤害加成",
    [2] = "伤害减免",
}

function PropertyRestraintUi:Init(data)
    self.pathRes = "assetbundles/prefabs/ui/package/ui_602_ke_zhi.assetbundle"
    UiBaseClass.Init(self,data);
end

function PropertyRestraintUi:InitData(data)
    UiBaseClass.InitData(self, data)

    self.roleData = data.info
    self.parent = data.parent
    self.isPlayer = data.isPlayer
end

function PropertyRestraintUi:DestroyUi()

    UiBaseClass.DestroyUi(self)
end

function PropertyRestraintUi:SetInfo(roleData,isPlayer)
    self.roleData = roleData
    self.isPlayer = isPlayer

    self:UpdateUi()
end

function PropertyRestraintUi:RegistFunc()
    UiBaseClass.RegistFunc(self)

    self.bindfunc['goto_upgrade'] = Utility.bind_callback(self, self.goto_upgrade)
end

function PropertyRestraintUi:InitUI(obj)
    UiBaseClass.InitUI(self, obj);
    self.ui:set_name('property_restrain_ui')

    self.items = {{},{},{},{}}
    --1疾2坚3锐4特
    self.items[1].self = self.ui:get_child_by_name("cont_rui")
    self.items[2].self = self.ui:get_child_by_name("cont_jian")
    self.items[3].self = self.ui:get_child_by_name("cont_ji")
    self.items[4].self = self.ui:get_child_by_name("cont_te")
    for i, item in ipairs(self.items) do
        local txtPlus = ngui.find_label(item.self, "lab_num1")
        local txtReduce = ngui.find_label(item.self, "lab_num2")
        txtPlus:set_text(_UIText[1])
        txtReduce:set_text(_UIText[2])

        item.labPlus = ngui.find_label(item.self, "lab_num1/lab_num")
        item.labReduce = ngui.find_label(item.self, "lab_num2/lab_num")
    end

    local btnGoUpgrade = ngui.find_button(self.ui, "btn1")
    btnGoUpgrade:set_on_click(self.bindfunc["goto_upgrade"])

    self:UpdateUi()
end

function PropertyRestraintUi:UpdateUi()
    if self.ui == nil then return end
    if self.roleData == nil then return end
    
    local restrain_valid = self.roleData:GetRestrainValid()
    local plus_tab = {0,0,0,0}
    local reduce_tab = {0,0,0,0}
    for id, level in pairs(restrain_valid) do
        local config = ConfigHelper.GetRestrainConfig(self.roleData.config.restrain, id)
        local value, type_property, type_plus = self:GetPropertyValue(config[level+1])
        if type_plus == true then
            plus_tab[type_property] = plus_tab[type_property] + value
        elseif type_plus == false then
            reduce_tab[type_property] = reduce_tab[type_property] + value
        end
    end
    if plus_tab[0] then
        for i=1, 4 do
            plus_tab[i] = plus_tab[i] + plus_tab[0]
        end
    end
    if reduce_tab[0] then
        for i=1, 4 do
            reduce_tab[i] = reduce_tab[i] + reduce_tab[0]
        end
    end
    --1疾2坚3锐4特
    for i=1, 4 do
        self.items[i].labPlus:set_text("+"..plus_tab[i])
        self.items[i].labReduce:set_text("+"..reduce_tab[i])
    end
end

function PropertyRestraintUi:GetPropertyValue(config)
    local value = 0
    local type_property = 0 -- 0全属性1锐2坚3疾4特
    local type_plus = nil

    if config.restraint1_damage_plus > 0 then
        value = config.restraint1_damage_plus
        type_property = 1
        type_plus = true
    elseif config.restraint2_damage_plus > 0 then
        value = config.restraint2_damage_plus
        type_property = 2
        type_plus = true
    elseif config.restraint3_damage_plus > 0 then
        value = config.restraint3_damage_plus
        type_property = 3
        type_plus = true
    elseif config.restraint4_damage_plus > 0 then
        value = config.restraint4_damage_plus
        type_property = 4
        type_plus = true
    elseif config.restraint_all_damage_plus > 0 then
        value = config.restraint_all_damage_plus
        type_plus = true
    elseif config.restraint1_damage_reduct > 0 then
        value = config.restraint1_damage_reduct
        type_property = 1
        type_plus = false
    elseif config.restraint2_damage_reduct > 0 then
        value = config.restraint2_damage_reduct
        type_property = 2
        type_plus = false
    elseif config.restraint3_damage_reduct > 0 then
        value = config.restraint3_damage_reduct
        type_property = 3
        type_plus = false
    elseif config.restraint4_damage_reduct > 0 then
        value = config.restraint4_damage_reduct
        type_property = 4
        type_plus = false
    elseif config.restraint_all_damage_reduct > 0 then
        value = config.restraint_all_damage_reduct
        type_plus = false
    end 

    return value, type_property, type_plus
end

function PropertyRestraintUi:Show()
    if UiBaseClass.Show(self) then
        self:UpdateUi()
    end
end

function PropertyRestraintUi:Hide()
    if UiBaseClass.Hide(self) then
    end
end

function PropertyRestraintUi:goto_upgrade()
    if PublicFunc.IsOpenRealFunction(MsgEnum.eactivity_time.eActivityTime_Restraint, self.roleData) then
        uiManager:PushUi(EUI.RestraintUi, self.roleData)
    end
end
