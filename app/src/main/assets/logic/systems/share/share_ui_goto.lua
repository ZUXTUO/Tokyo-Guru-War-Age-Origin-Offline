share_ui_goto = {
				path_enter = "assetbundles/prefabs/ui/award/ui_8001_share.assetbundle";
				path_other = "assetbundles/prefabs/ui/award/ui_8002_share.assetbundle";
				share_type = 1;
				ui_type = 1;   --1底部 2other
				share_id =1;  --分享Id(配置)
				}

function share_ui_goto.Start(data)
  	if data then
		if data.share_type then
			share_ui_goto.share_type = tonumber(data.share_type)
		end
		if data.ui_type then
			share_ui_goto.ui_type = tonumber(data.ui_type)
		end

		if data.share_id then
			share_ui_goto.share_id = tonumber(data.share_id)
		end

		if data.callback then
			share_ui_goto.callback = data.callback
		end
	end

  	if share_ui_goto.ui == nil then
	    share_ui_goto._asset_loader = systems_func.loader_create("ResourceLoader_loader")
		share_ui_goto._asset_loader:set_callback("share_ui_goto.on_load")
		
		if share_ui_goto.ui_type == 1 then
			share_ui_goto._asset_loader:load(share_ui_goto.path_enter);
		else
			share_ui_goto._asset_loader:load(share_ui_goto.path_other);
		end

		share_ui_goto._asset_loader = nil;
	end
	
end

function share_ui_goto.on_load(pid, fpath, asset_obj, error_info)
	if share_ui_goto.ui_type == 1 then
		if fpath == share_ui_goto.path_enter then
			share_ui_goto.ui = systems_func.game_object_create(asset_obj);
			share_ui_goto.ui:set_parent(Root.get_root_ui_2d());
			share_ui_goto.ui:set_name("share_ui_goto");
			share_ui_goto.ui:set_local_rotation(0, 0, 0);
			share_ui_goto.ui:set_local_scale(1, 1, 1);

			share_ui_goto.lab_name = ngui.find_label(share_ui_goto.ui,"down_other/animation/lab_name"); --战队名
			share_ui_goto.lab_server = ngui.find_label(share_ui_goto.ui,"down_other/animation/lab_serverlist"); --服务器名
			share_ui_goto.texture_head = share_ui_goto.ui:get_child_by_name("down_other/animation/sp_head_di_item")
			share_ui_goto.code = ngui.find_sprite(share_ui_goto.ui,"down_other/animation/sp_code") --二维码
			--只有官网显示
			local flag = true
			if flag then
				share_ui_goto.code:set_active(true)
			else
				share_ui_goto.code:set_active(false)
			end
			share_ui_goto.update_ui()
		end
	elseif share_ui_goto.ui_type == 2 then
		if fpath == share_ui_goto.path_other then
			share_ui_goto.ui = systems_func.game_object_create(asset_obj);
			share_ui_goto.ui:set_parent(Root.get_root_ui_2d());
			share_ui_goto.ui:set_name("share_ui_goto");
			share_ui_goto.ui:set_local_rotation(0, 0, 0);
			share_ui_goto.ui:set_local_scale(1, 1, 1);

			share_ui_goto.lab_name = ngui.find_label(share_ui_goto.ui,"down_other/animation/lab_name"); --战队名
			share_ui_goto.lab_server = ngui.find_label(share_ui_goto.ui,"down_other/animation/lab_serverlist"); --服务器名
			share_ui_goto.texture_head = share_ui_goto.ui:get_child_by_name("down_other/animation/sp_head_di_item")
			share_ui_goto.code = ngui.find_sprite(share_ui_goto.ui,"down_other/animation/sp_code") --二维码
			--只有官网显示
			local flag = true
			if flag then
				share_ui_goto.code:set_active(true)
			else
				share_ui_goto.code:set_active(false)
			end
			share_ui_goto.update_ui()
		end

	end
end

function share_ui_goto.update_ui()
	--服务器名
	local server_info = ServerListData.get_server_info(login_enter.enter_server_id);
	if server_info ~= nil then
		local servername = systems_func.analyzeName(server_info.name,"_")
		if servername[1] then
			showservername = servername[1]
		end
		if servername[2] then
			showservername = showservername.." "..servername[2]
		end
		share_ui_goto.lab_server:set_text(showservername);
	end

	--玩家名
	if g_dataCenter ~= nil then         
		if g_dataCenter.player ~= nil then
            name = tostring(g_dataCenter.player.name);
            share_ui_goto.lab_name:set_text(name)
            --头像
            share_ui_goto.uiPlayer = UiPlayerHead:new({parent=share_ui_goto.texture_head})
	        share_ui_goto.uiPlayer:SetRoleId(g_dataCenter.player:GetImage())
	        share_ui_goto.uiPlayer:SetVipLevel(g_dataCenter.player.vip)
        end
    end
    --app.log("type============="..tostring(share_ui_goto.share_type))
    
    timer.create("share_ui_goto.to_share_sdk",1000,1)
    timer.create("share_ui_goto.on_close_ui", 3500, 1);
end

function share_ui_goto.to_share_sdk()
	--通过share_ui_goto.share_id配置表读取
	local shareData = ConfigManager.Get(EConfigIndex.t_share,share_ui_goto.share_id)
	local type_list = shareData.type
	local share_url = shareData.web
    local title = gs_share_info[shareData.title]
    local des = gs_share_info[shareData.des]
    local img_path = shareData.png
    local callback = nil
    UserCenter.share_online(share_ui_goto.share_type,type_list,true,img_path,share_url,title,des,callback)
end

function share_ui_goto.on_close_ui()
	
	if share_ui_goto.uiPlayer then
		share_ui_goto.uiPlayer:DestroyUi();
		share_ui_goto.uiPlayer = nil;
	end

	if nil ~= share_ui_goto.ui then
		share_ui_goto.ui:set_active(false);
		share_ui_goto.ui = nil
	end
	
	if uiManager then
		local obj = uiManager:FindUI(EUI.ShareUIActivity)
		if obj then
			if obj:IsShow() then
				uiManager:PopUi();
			end
		end
	end

end

function share_ui_goto.show_ui(is_show)
	if nil ~= share_ui_goto.ui then
		share_ui_goto.ui:set_active(is_show);
	end

	if nil ~= share_ui_goto.ui then
		if is_show then
			share_ui_goto.ui:set_active(false);
		else
			share_ui_goto.ui:set_active(true);
		end
	end
end

