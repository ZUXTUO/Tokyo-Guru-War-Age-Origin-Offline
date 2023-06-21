--
-- Created by IntelliJ IDEA.
-- User: PoKong_OS
-- Date: 2015/3/11
-- Time: 17:17
-- To change this template use File | Settings | File Templates.
--

--[[战斗UI入口]]

Fight_main_ui = {
	loader = nil;
	main_ui = nil;
};

function Fight_main_ui.Destroy()
	Fight_main_ui.loader = nil;
	Fight_main_ui.main_ui = nil;
end

function Fight_main_ui.start()
	local ui_path = "assetbundles/prefabs/ui/ui_fight.assetbundle"
	ResourceLoader.LoadAsset(ui_path, Fight_main_ui.asset_loaded);
end

function Fight_main_ui.asset_loaded(pid, fpath, asset_obj, error_info)
	Fight_main_ui.main_ui = asset_game_object.create(asset_obj);
	Fight_main_ui.main_ui:set_parent(Root.get_root_ui_2d());
	Fight_main_ui.main_ui:set_local_scale(Utility.SetUIAdaptation());
	Fight_main_ui.main_ui:set_name("ui_fight");
end

