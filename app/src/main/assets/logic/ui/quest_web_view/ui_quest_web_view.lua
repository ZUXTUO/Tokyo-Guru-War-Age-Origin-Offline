    -- 问卷调查ui
UiQuestWebView = Class("UiQuestWebView", UiBaseClass)
function UiQuestWebView:Init(data)
    self.pathRes = "assetbundles/prefabs/ui/public/panel_com.assetbundle"
    UiBaseClass.Init(self, data);
end

function UiQuestWebView:Restart(data)
    UiBaseClass.Restart(self, data)
end

function UiQuestWebView:InitData(data)
    UiBaseClass.InitData(self, data);
end

function UiQuestWebView:GetUrl()
    local playerId = g_dataCenter.player:GetGID()
    local url = "http://www.sojump.com/jq/6819519.aspx?sojumpparm=" .. tostring(playerId) .. "_" .. g_dataCenter.player.name
    return url
end

function UiQuestWebView:OpenUrl()
    app.open_url(self:GetUrl())
end

function UiQuestWebView:RegistFunc()
    UiBaseClass.RegistFunc(self);

    self.bindfunc["on_btn_close"] = Utility.bind_callback(self, self.on_btn_close)
end

function UiQuestWebView:UnRegistFunc()
    UiBaseClass.UnRegistFunc(self);
end

function UiQuestWebView:InitUI(asset_obj)
    UiBaseClass.InitUI(self, asset_obj)

    self.ui:set_parent(Root.get_root_ui_2d())
    self.ui:set_local_scale(1, 1, 1)

    self.btn_close = ngui.find_button(self.ui, "btn")
    self.btn_close:set_on_click(self.bindfunc["on_btn_close"])
    if Root.get_os_type() == PublicStruct.App_OS_Type.Android or Root.get_os_type() == PublicStruct.App_OS_Type.IPhonePlayer then
        self.web_view = uni_web_view_lib.find_web_view(self.ui, "uni_web_view")
        local s_width = self.web_view:get_screen_width()
        local s_height = self.web_view:get_screen_height()
        local t = s_width / 1280   
        -- app.log(url);
        self.web_view:set_url(self:GetUrl())
        -- self.web_view:set_edge_insets(161 * t, 132 * t, 166 * t, 148 * t)
        self.web_view:set_edge_insets(90 * t, 0, 0, 0)
        self.web_view:set_load_on_start(true)
        self.web_view:set_auto_show_on_loaded(true)
        self.web_view:show()
        self.web_view:set_on_pause(Utility.bind_callback(self, self.on_btn_close))
        -- self.web_view:set_on_receive_keycode(Utility.bind_callback(self, self.on_receive_keycode))
        -- app.log("######" .. self.web_view:get_pid())
    else
        self:OpenUrl()
    end

end

function UiQuestWebView:on_receive_keycode(key_code)
    -- app.log("################key_code:" .. tostring(key_code) .. "@:" ..(key_code.key_code))
    self:on_btn_close()
end

function UiQuestWebView:Show()
    UiBaseClass.Show(self)
end

function UiQuestWebView:Hide()
    UiBaseClass.Hide(self)
end

function UiQuestWebView:on_btn_close()
    uiManager:PopUi(EUI.UiQuestWebView)
end

function UiQuestWebView:DestroyUi()
    UiBaseClass.DestroyUi(self);

    if self.web_view then
        self.web_view:close()
        self.web_view = nil
    end
end