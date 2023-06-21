
-- file   : restraint_total_plus_ui.lua -- 克制总加成列表界面
-- author : zzc
-- date   : 2016/08/22

RestraintTotalPlusUi = Class("RestraintTotalPlusUi", UiBaseClass);

local _UIText = {
    [1] = "伤害加成 +",
    [2] = "伤害减免 +",
}

function RestraintTotalPlusUi:Init(data)
    self.pathRes = "assetbundles/prefabs/ui/package/ui_7003_ke_zhi.assetbundle"
    UiBaseClass.Init(self,data);
end

function RestraintTotalPlusUi:Restart(data)
    if data then
        self.roleData = data
    end
    UiBaseClass.Restart(self, data)
end

function RestraintTotalPlusUi:DestroyUi()
    UiBaseClass.DestroyUi(self)
end

function RestraintTotalPlusUi:RegistFunc()
    UiBaseClass.RegistFunc(self)

    self.bindfunc['on_btn_close'] = Utility.bind_callback(self, self.on_btn_close)
end

function RestraintTotalPlusUi:InitUI(obj)
    UiBaseClass.InitUI(self, obj)
    self.ui:set_name('restraint_total_plus_ui')

    local btnClose = ngui.find_button(self.ui, "btn_cha")
    btnClose:set_on_click(self.bindfunc["on_btn_close"])
    self.items = {}
    for i=1, 4 do
        local item = {}
        item.self = self.ui:get_child_by_name("texture_bk_"..i)
        item.title = ngui.find_label(item.self, "lab_title")
        item.txIcon = ngui.find_texture(item.self, "sp_shu_xing")
        item.labPlus = ngui.find_label(item.self, "lan_num1")
        item.labReduce = ngui.find_label(item.self, "lan_num2")

        self.items[i] = item
    end

    self:UpdateUi()
end

function RestraintTotalPlusUi:UpdateUi()
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
    local tl = {"克疾","克坚","克锐","克特"}
    local showIndex = {[1]=3,[2]=2,[3]=1,[4]=4}
    for i=1, 4 do
        local index = showIndex[i]
        self.items[index].title:set_text(tl[index])
        self.items[index].labPlus:set_text(_UIText[1]..plus_tab[i])
        self.items[index].labReduce:set_text(_UIText[2]..reduce_tab[i])
    end
end

function RestraintTotalPlusUi:GetPropertyValue(config)
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

function RestraintTotalPlusUi:Hide()
    UiBaseClass.Hide(self)
end

function RestraintTotalPlusUi:on_btn_close()
    uiManager:PopUi()
end
