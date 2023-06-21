-- region UiAnn.lua
-- Author : EwingChow
-- Date   : 2016/1/8 18:07:28
-- Version: V1.0.0
-- Des    : UiAnn
-- endregion
UiAnn = {
    ui = nil,
    ui_close = nil;--[[有关的UI]]
    ui_ok = nil;--[[有按钮的UI]]
    btn_close = nil,
    btn_ok = nil,
    on_closed = nil,
    this_type = 0;--[[当前打开的TYPE]]
}
UiAnn.Type =
{
    GongGao = 1,
    KeFu = 2,
    RegAgreeMent = 3,
    YinShi = 4,
    FuWu = 5,
    RealNameAuth = 6,
	Protocol = 7;
}
local pathRes = "assetbundles/prefabs/ui/public/panel_url_announcement.assetbundle"
local open_url = nil
-- region 

function UiAnn.Start(v, url,on_closed)
    open_url = url;
    UiAnn.on_closed = on_closed;
    UiAnn.this_type = v;
    if v == UiAnn.Type.GongGao then
        -- url = "http://www.sojump.com/jq/6819519.aspx"
        if nil == url then
            open_url = systems_data.get_game_server_notice();
        end
    elseif v == UiAnn.Type.KeFu then
        if url == nil then
            local playerid = -1;
            local playername = "";
            local accid = 0;
            if g_dataCenter and g_dataCenter.player and g_dataCenter.player.playerid then
                playerid = g_dataCenter.player.playerid;
                playername = g_dataCenter.player.name;
            end
            if UserCenter then
	            accid = UserCenter.get_accountid();
            end

            --[[app_id
            -- server_id
            -- accountid
            -- player_name+player_id :xxxxx_player_id
            -- ]]

            open_url = AppConfig.get_kefu_url(AppConfig.get_app_id(), systems_data.get_enter_server_id(), tostring(accid), tostring(playername .. "_" .. playerid));

            --[[新接口 需要支持图片上传]]
--	        open_url = "http://plat-all-cncs-zs-ucsystem-0001.ppgame.com/?language=cn&openId=123400000&appId=0002000200020020&serverId=100&playerId=cb4fc24c2f4c0b714038796c12b91c5a31ee6681z&playerName=pokong&vip=10";

        end
    elseif v == UiAnn.Type.RegAgreeMent then
        if nil == url then
            --open_url = "无公告"
            open_url = "file:///android_asset/www/index.html"
        end
    elseif v == UiAnn.Type.YinShi then
        if nil == url then
            open_url = Root.get_use_system_url() .. "html/privacy1.html"
        end
    elseif v == UiAnn.Type.FuWu then
        if nil == url then
            open_url = Root.get_use_system_url() .. "html/service1.html"
        end
    elseif v== UiAnn.Type.RealNameAuth then
        if nil == url then
            open_url = AppConfig.get_realname_auth_url(AppConfig.get_app_id(),UserCenter.get_accountid(),0)
        end
    end

    app.log("open_url=" .. open_url);

	UiAnn._asset_loader = systems_func.loader_create("UiAnn_loader")
	UiAnn._asset_loader:set_callback("UiAnn.InitUI")
	UiAnn._asset_loader:load(pathRes);
	UiAnn._asset_loader = nil;
end 

function UiAnn.InitUI(pid, fpath, asset_obj, error_info)
    UiAnn.ui = systems_func.game_object_create(asset_obj);
    UiAnn.ui:set_parent(Root.get_root_ui_2d());
    UiAnn.ui:set_local_scale(1, 1, 1);
    UiAnn.ui:set_local_position(0,0,0)

	UiAnn.ui_close = UiAnn.ui:get_child_by_name("centre_other/animation/sp_di1");
	UiAnn.ui_ok = UiAnn.ui:get_child_by_name("centre_other/animation/sp_di2");
    UiAnn.btn_close = systems_func.ngui_find_button(UiAnn.ui, "centre_other/animation/sp_di1/btn");
	UiAnn.btn_ok = systems_func.ngui_find_button(UiAnn.ui, "centre_other/animation/sp_di2/btn");
	UiAnn.btn_close:set_on_click("UiAnn.on_btn_close");
    UiAnn.btn_ok:set_on_click("UiAnn.on_btn_close");

	-- top left bottom right
	--[[协义需要确认按钮]]
    if UiAnn.this_type ~= UiAnn.Type.RegAgreeMent then
	    UiAnn.ui_ok:set_active(false);
	    WebView.OpenUrl(UiAnn.ui, open_url, 116, 85, 70, 85);
    else
	    UiAnn.ui_close:set_active(false);
	    WebView.OpenUrl(UiAnn.ui, open_url, 116, 85, 160, 85);
    end
end

function UiAnn.on_btn_close()
    if UiAnn.ui ~= nil then
        UiAnn.ui:set_active(false)
    end
    UiAnn.ui = nil
    WebView.Close()

    --执行完就清空
    if UiAnn.on_closed then
        if type(UiAnn.on_closed) == "function" then
            UiAnn.on_closed()
        elseif type(UiAnn.on_closed) == "string" then
            Utility.CallFunc(UiAnn.on_closed)
        end
    end
    UiAnn.on_closed = nil
    --- self:Hide()

--    if UiAnn.this_type == UiAnn.Type.RealNameAuth then
--        UserCenter.check_realname_auth(UserCenter.check_realname);
--    end
end
