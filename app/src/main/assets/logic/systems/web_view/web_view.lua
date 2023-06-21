-- region web_view.lua
-- Author : EwingChow
-- Date   : 2016/1/8 18:23:12
-- Version: V1.0.0
-- Des    : web_view
-- endregion
WebView = {
    web_view = ni;
}

function WebView.OpenUrl(ui_ins, url, top, left, bottom, right)
    local web_view = nil
    if ui_ins and url then
        if Root.get_os_type() == 11 or Root.get_os_type() == 8 then
            web_view = uni_web_view_lib.find_web_view(ui_ins, "uni_web_view")
            local s_width = web_view:get_screen_width()
            local s_height = web_view:get_screen_height()
            local t = s_width / 1280

            -- app.log(url);
            web_view:set_url(url)
            -- self.web_view:set_edge_insets(161 * t, 132 * t, 166 * t, 148 * t)
            web_view:set_edge_insets( math.floor(top * t), math.floor(left * t), math.floor(bottom * t), math.floor(right * t))
            web_view:set_load_on_start(true)
            web_view:set_auto_show_on_loaded(true)
            web_view:show()
            web_view:set_on_pause("WebView.Close")
            web_view:set_transparent_background(true)
        else
            app.open_url(url)
        end
    end
    WebView.web_view = web_view
    return web_view;
end

function WebView.Close()
    if WebView.web_view then
        WebView.web_view:close()
        WebView.web_view = nil
    end
end