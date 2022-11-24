--
-- Created by IntelliJ IDEA.
-- User: pokong
-- Date: 2015/12/15
-- Time: 15:20
-- To change this template use File | Settings | File Templates.
--

--[[菊花独立背景]]

loading_bg = {
	call_back = nil;
};


function loading_bg.Start(func)
	app.log("loading_bg begin");
	loading_bg._asset_loader = systems_func.loader_create("ResourceLoader_loader")
	loading_bg._asset_loader:set_callback("loading_bg.on_load")
	loading_bg._asset_loader:load("assetbundles/prefabs/ui/logo/logo_2.assetbundle");
	loading_bg._asset_loader = nil;

	if func ~= nil and type(func) == "function" then
		loading_bg.call_back = func;
	end
end

function loading_bg.on_load(pid, fpath, asset_obj, error_info)
	loading_bg.ui = systems_func.game_object_create(asset_obj);
	loading_bg.ui:set_parent(Root.get_root_ui_2d());
	loading_bg.ui:set_name("loading_bg");
	loading_bg.ui:set_local_rotation(0, 0, 0);
	loading_bg.ui:set_local_scale(1, 1, 1);
	app.log("loading_bg ok");

	if loading_bg.call_back ~= nil then
		loading_bg.call_back();
	end

end

function loading_bg.Destroy()
	app.log("删除loading背景");
	if nil ~= loading_bg.ui then
		loading_bg.ui:set_active(false);
	end
	loading_bg.ui = nil
end
