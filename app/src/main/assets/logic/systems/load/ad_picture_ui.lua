--	AdPictureUi
--	author: chenlong
--	create: 2016-4-28

AdPictureUi = {
	data = {};
};

function AdPictureUi.Start()
	AdPictureUi.data = {};
	AdPictureUi.clickNum = 1;
	--app.log("-----广告列表 begin");

	local t_ad_picture_list = systems_data.get_ad_picture_list()
	--app.log("-----"..table.tostring(t_ad_picture_list));
	if t_ad_picture_list == nil or table.getn(t_ad_picture_list) == 0 then
		--app.log("空资源");
		AdPictureUi.Destroy()
		return;
	end

	for i=1,table.getn(t_ad_picture_list) do
		local path = t_ad_picture_list[i]
		--app.log("path="..path);
		if file.exist(path) then
			local temp = {};
			temp.path = path;
			temp.texture = nil;
			table.insert(AdPictureUi.data,temp)
		end
	end
	--app.log("---data="..table.tostring(AdPictureUi.data));
	if table.getn(AdPictureUi.data) == 0 then
		AdPictureUi.Destroy()
		return
	end

	AdPictureUi._asset_loader = systems_func.loader_create("ResourceLoader_loader")
	AdPictureUi._asset_loader:set_callback("AdPictureUi.on_load")
	AdPictureUi._asset_loader:load("assetbundles/prefabs/ui/public/panel_main_announcement.assetbundle");
	AdPictureUi._asset_loader = nil;
end

function AdPictureUi.on_load(pid, fpath, asset_obj, error_info)
	AdPictureUi.ui = systems_func.game_object_create(asset_obj);
	AdPictureUi.ui:set_parent(Root.get_root_ui_2d());
	AdPictureUi.ui:set_name("AdPictureUi");
	AdPictureUi.ui:set_local_rotation(0, 0, 0);
	AdPictureUi.ui:set_local_scale(1, 1, 1);

	AdPictureUi.btnClose = systems_func.ngui_find_button(AdPictureUi.ui,"center_other/btn");
	AdPictureUi.btnClose:set_on_click('AdPictureUi.on_btn_close');
	AdPictureUi.Texture = systems_func.ngui_find_texture(AdPictureUi.ui, "center_other/Texture");

	if AdPictureUi.data[AdPictureUi.clickNum] and type(AdPictureUi.data[AdPictureUi.clickNum].path) == "string" then
		systems_func.texture_load(AdPictureUi.data[AdPictureUi.clickNum].path, "AdPictureUi.texture_on_load");
	end

end

function AdPictureUi.texture_on_load(pid, fpath, asset_obj, error_info)
	for i=1,table.getn(AdPictureUi.data) do
		local temp = AdPictureUi.data[i];
		if temp.path == fpath then
			AdPictureUi.data[i].texture = asset_obj;
			AdPictureUi.Texture:set_texture(asset_obj);
			return;
		end
	end
end

function AdPictureUi.on_btn_close()
	--app.log("点击关闭 广告列表");
	AdPictureUi.clickNum = AdPictureUi.clickNum +1;

	if table.getn(AdPictureUi.data) < AdPictureUi.clickNum then
		AdPictureUi.Destroy()
		return;
	end

	if AdPictureUi.data[AdPictureUi.clickNum] and type(AdPictureUi.data[AdPictureUi.clickNum].path) == "string" then
		systems_func.texture_load(AdPictureUi.data[AdPictureUi.clickNum].path, "AdPictureUi.texture_on_load");
	end
end

function AdPictureUi.Destroy()
	--app.log("删除 广告列表");

	for i=1,table.getn(AdPictureUi.data) do
		AdPictureUi.data[i].texture = nil;
	end

	if AdPictureUi.Texture ~= nil then
		AdPictureUi.Texture = nil;
	end

	if nil ~= AdPictureUi.ui then
		AdPictureUi.ui:set_active(false);
	end
	AdPictureUi.ui = nil

	AdPictureUi.data = {};
end

