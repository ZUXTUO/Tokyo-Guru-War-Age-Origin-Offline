UiTitle = Class("UiTitle", UiBaseClass)

-- function UiTitle.Get

function UiTitle:Init(data)

    self.pathRes = "assetbundles/prefabs/ui/title/ui_player_title.assetbundle"
    UiBaseClass.Init(self, data)
end


function UiTitle:InitData(data)
    UiBaseClass.InitData(self, data)
    self.listItem = { }
    self.title_sprite = { }    
    self.title_cfg_data = {}
    local key = 1
    -- for k,v in pairs(gd_title) do
    for k,v in pairs(ConfigManager._GetConfigTable(EConfigIndex.t_title)) do
        self.title_cfg_data[key] = v
    end
end

function UiTitle:Restart(data)
    if data then

    end
    UiBaseClass.Restart(self, data)
end

function UiTitle:InitUI(asset_obj)
    self.ui = asset_game_object.create(asset_obj);
    self.ui:set_parent(Root.get_root_ui_2d());
    self.ui:set_local_scale(1, 1, 1);
    self.ui:set_local_position(0, 0, 0);
    -- self.ui:set_name('ui_701_level');

    self.current_bg_sprite = ngui.find_sprite(self.ui, "centre_other/animation/sp_bk1/sp_di")
    self.current_f_sprite = ngui.find_sprite(self.ui, "centre_other/animation/sp_bk1/sp_di/sp")
    self.p_label1 = ngui.find_label(self.ui, "centre_other/animation/sp_bk1/lab1")
    self.p_label2 = ngui.find_label(self.ui, "centre_other/animation/sp_bk1/lab2")
    self.p_label3 = ngui.find_label(self.ui, "centre_other/animation/sp_bk1/lab3")
    self.p_label4 = ngui.find_label(self.ui, "centre_other/animation/sp_bk1/lab4")
    self.p_label5 = ngui.find_label(self.ui, "centre_other/animation/sp_bk1/lab5")
    self.p_label6 = ngui.find_label(self.ui, "centre_other/animation/sp_bk1/lab6")

    self.btn_close = ngui.find_button(self.ui, "centre_other/animation/btn_close")
    self.btn_close:set_on_click(self.bindfunc["on_btn_close"])
    self.wrap_content = ngui.find_wrap_content(self.ui, "centre_other/animation/scroll_view/panel_list/wrap_content")
    self.wrap_content:set_on_initialize_item(self.bindfunc["on_item_init"])
    self.wrap_content:reset()
end

function UiTitle:OnLoadUI()

end

function UiTitle:DestroyUi()
    UiBaseClass.DestroyUi(self)
end

function UiTitle:OnBtnClose()
    uiManager:PopUi()
end

function UiTitle:OnItemInit(obj, b, real_id)
    app.log("UiTitle:OnItemInit" .. real_id)
    local index = math.abs(real_id) +1
    local data = self.title_cfg_data[index]
    if data then
        -- 是否装备
        local label_is_worn = ngui.find_label(obj, "sp_title/lab")
        local sprite_item_bg = ngui.find_sprite(obj, "sp_di")
        local sprite_item_fg = ngui.find_sprite(obj, "sp_di/sp")
        local label_p1 = ngui.find_label(obj, "lab1")
        local label_p2 = ngui.find_label(obj, "lab2")
        local label_p3 = ngui.find_label(obj, "lab3")
        local label_p4 = ngui.find_label(obj, "lab4")
        local label_p5 = ngui.find_label(obj, "lab5")
        local label_p6 = ngui.find_label(obj, "lab6")
        local label_act_condition = ngui.find_label(obj, "txt")
        local button_wear = ngui.find_button(obj, "btn_1")
    else
        obj:set_active(false)
    end

end

function UiTitle:OnButtonWear()

end

function UiTitle:RegistFunc()
    UiBaseClass.RegistFunc(self)
    self.bindfunc["on_btn_close"] = Utility.bind_callback(self, self.OnBtnClose)
    self.bindfunc["on_item_init"] = Utility.bind_callback(self, self.OnItemInit)
    self.bindfunc["on_button_wear"] = Utility.bind_callback(self, self.OnButtonWear)
end

-- 注销回调函数
function UiTitle:UnRegistFunc()
    UiBaseClass.UnRegistFunc(self)
end


function UiTitle:MsgRegist()
    UiBaseClass.MsgRegist(self)
end
    


function UiTitle:MsgUnRegist()
    UiBaseClass.MsgUnRegist(self)
end


