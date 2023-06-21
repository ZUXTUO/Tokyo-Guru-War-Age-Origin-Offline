share_ui_button = {
				path_enter = "assetbundles/prefabs/ui/award/ui_8000_share.assetbundle";
				share_type = 1;  --1 weixin 2 QQ 3weibo
				ui_type = 1;		--1 底部 2 other
				callback = nil;
				share_id = 1;
				}

function share_ui_button.Start(data,id)
  	
  	if share_ui_button.ui == nil then
	    share_ui_button._asset_loader = systems_func.loader_create("ResourceLoader_loader")
		share_ui_button._asset_loader:set_callback("share_ui_button.on_load")
		share_ui_button._asset_loader:load(share_ui_button.path_enter);
		share_ui_button._asset_loader = nil;
	end

	if data then
		share_ui_button.ui_type = tonumber(data)
	end

	if id then
		share_ui_button.share_id = tonumber(id)
	end
end

function share_ui_button.on_load(pid, fpath, asset_obj, error_info)
	if fpath == share_ui_button.path_enter then
		share_ui_button.ui = systems_func.game_object_create(asset_obj);
		share_ui_button.ui:set_parent(Root.get_root_ui_2d());
		share_ui_button.ui:set_name("share_ui_button");
		share_ui_button.ui:set_local_rotation(0, 0, 0);
		share_ui_button.ui:set_local_scale(1, 1, 1);
		
		share_ui_button.share_back = systems_func.ngui_find_button(share_ui_button.ui,"right_top_other/animation/btn_back");
		share_ui_button.ui_share_weixin = systems_func.ngui_find_button(share_ui_button.ui,"down_other/animation/btn_weixin");
		share_ui_button.ui_share_qq = systems_func.ngui_find_button(share_ui_button.ui,"down_other/animation/btn_friend");
		share_ui_button.ui_share_weibo = systems_func.ngui_find_button(share_ui_button.ui,"down_other/animation/btn_sina");

		share_ui_button.share_back:set_on_click("share_ui_button.close")
		share_ui_button.ui_share_weixin:set_on_click("share_ui_button.on_btn_weixin");
		share_ui_button.ui_share_qq:set_on_click("share_ui_button.on_btn_qq");
		share_ui_button.ui_share_weibo:set_on_click("share_ui_button.on_btn_weibo");

		--ui类型
		-- share_ui_button.texturesmall = systems_func.ngui_find_texture(share_ui_button.ui,"centre_other/animation/Texture_small")
		-- share_ui_button.texturebig = systems_func.ngui_find_texture(share_ui_button.ui,"centre_other/animation/Texture_big")

		-- share_ui_button.cont_jjc = share_ui_button.ui:get_child_by_name("centre_other/animation/cont_jjc")
		-- share_ui_button.cont_jjc:set_active(false)
		-- share_ui_button.cont_fight = share_ui_button.ui:get_child_by_name("centre_other/animation/cont_fight")
		-- share_ui_button.cont_fight:set_active(false)
		-- share_ui_button.cont_level = share_ui_button.ui:get_child_by_name("centre_other/animation/cont_level")
		-- share_ui_button.cont_level:set_active(false)
		
		-- if share_ui_button.ui_type == 1 then

		-- elseif share_ui_button.ui_type == 2 then
		-- 	share_ui_button.cont_fight:set_active(true)
		-- 	--share_ui_button.texturesmall:set_texture("assetbundles/prefabs/ui/image/backgroud/huo_dong/huodong_fen_xiang/hd_fenxianghuodong_dengji_zl.assetbundle")
		-- 	systems_func.texture_load("assetbundles/prefabs/ui/image/backgroud/huo_dong/huodong_fen_xiang/hd_fenxianghuodong_dengji_zl.assetbundle", "share_ui_button.texture_on_load")
		-- elseif share_ui_button.ui_type == 3 then
		-- 	share_ui_button.cont_level:set_active(true)
		-- 	share_ui_button.texturesmall:set_texture("assetbundles/prefabs/ui/image/backgroud/huo_dong/huodong_fen_xiang/hd_fenxianghuodong_dj.assetbundle")
		-- elseif share_ui_button.ui_type == 4 then
		-- 	share_ui_button.texturebig:set_texture("assetbundles/prefabs/ui/image/backgroud/huo_dong/huodong_fen_xiang/hd_yongyoujuese.assetbundle")
		-- elseif share_ui_button.ui_type == 5 then
		-- 	share_ui_button.cont_jjc:set_active(true)
		-- 	share_ui_button.texturesmall:set_texture("assetbundles/prefabs/ui/image/backgroud/huo_dong/huodong_fen_xiang/hd_fenxianghuodong_dengji_jjc.assetbundle")
		-- end
	end
end

-- function share_ui_button.texture_on_load(pid, fpath, asset_obj, error_info)
-- 	share_ui_button.texturesmall:set_texture(asset_obj)
-- end

function share_ui_button.on_btn_weixin(t)
	--share_ui_button.share_type = 1
	local data ={
				share_type = 1;
				ui_type = share_ui_button.ui_type;
				share_id =share_ui_button.share_id;
				}
	if uiManager then
		local obj = uiManager:FindUI(EUI.ShareUIActivity)
		if obj then
			share_ui_button.hideui()
		else
			share_ui_button.close()
		end
	else
		share_ui_button.close()
	end

	share_ui_goto.Start(data)
end

function share_ui_button.on_btn_qq(t)
	local data ={
				share_type = 2;
				ui_type = share_ui_button.ui_type;
				share_id =share_ui_button.share_id;
				}
	if uiManager then
		local obj = uiManager:FindUI(EUI.ShareUIActivity)
		if obj then
			share_ui_button.hideui()
		else
			share_ui_button.close()
		end
	else
		share_ui_button.close()
	end
	
	share_ui_goto.Start(data)
end

function share_ui_button.on_btn_weibo(t)
	local data ={
				share_type = 3;
				ui_type = share_ui_button.ui_type;
				share_id =share_ui_button.share_id;
				}

	if uiManager then
		local obj = uiManager:FindUI(EUI.ShareUIActivity)
		if obj then
			share_ui_button.hideui()
		else
			share_ui_button.close()
		end
	else
		share_ui_button.close()
	end
				
	share_ui_goto.Start(data)
end

function share_ui_button.hideui()
	share_ui_button.ui:set_active(false);
	share_ui_button.ui = nil
end

function share_ui_button.close()
	share_ui_button.Destroy()
	--share_ui_button.show_ui(false);
end

function share_ui_button.show_ui(is_show)
	if nil ~= share_ui_button.ui then
		share_ui_button.ui:set_active(is_show);
	end

	if nil ~= share_ui_button.ui then
		if is_show then
			share_ui_button.ui:set_active(false);
		else
			share_ui_button.ui:set_active(true);
		end
	end
end

function share_ui_button.Destroy()
	share_ui_button.ui:set_active(false);
	share_ui_button.ui = nil
	if uiManager then
		local obj = uiManager:FindUI(EUI.ShareUIActivity)
		if obj then
			if obj:IsShow() then
				uiManager:PopUi();
			end
		end
	end
end