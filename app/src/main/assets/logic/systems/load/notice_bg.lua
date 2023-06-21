--
-- Created by IntelliJ IDEA.
-- User: chenlong
-- Date: 2016/4/28
-- Time: 15:20
-- To change this template use File | Settings | File Templates.
--

--[[公告列表]]

notice_bg = {
	data = {"0"};
};


function notice_bg.Start()
	app.log("notice_bg.Start");

	local temp_date = systems_data.get_notice_list()
	for i=1,table.getn(temp_date) do
		table.insert(notice_bg.data,temp_date[i]);
	end

	if table.getn(notice_bg.data) <= 0 then
		app.log("notice_bg.Start  notice_bg.data <= 0");
		do return end;
	end
	notice_bg.clickNum = 1;
	app.log("公告列表 begin");
	notice_bg._asset_loader = systems_func.loader_create("ResourceLoader_loader")
	notice_bg._asset_loader:set_callback("notice_bg.on_load")
	notice_bg._asset_loader:load("assetbundles/prefabs/ui/public/panel_login_announcement.assetbundle");
	notice_bg._asset_loader = nil;
end

function notice_bg.on_load(pid, fpath, asset_obj, error_info)
	notice_bg.ui = systems_func.game_object_create(asset_obj);
	notice_bg.ui:set_parent(Root.get_root_ui_2d());
	notice_bg.ui:set_name("notice_bg");
	notice_bg.ui:set_local_rotation(0, 0, 0);
	notice_bg.ui:set_local_scale(1, 1, 1);

	local t_notice_list = notice_bg.data;
	notice_bg.btnClose = systems_func.ngui_find_button(notice_bg.ui,"center_other/btn1");
	notice_bg.btnClose:set_on_click('notice_bg.on_btn_close');
	notice_bg.labelTitle = ngui.find_label(notice_bg.ui,"center_other/cont1/lab_title");
	notice_bg.labelContent = ngui.find_label(notice_bg.ui,"center_other/sco_view/panel/lab_nature");
	--if t_notice_list[notice_bg.clickNum].title and 
	--	type(t_notice_list[notice_bg.clickNum].title) == "string" then
	--	notice_bg.labelTitle:set_text(t_notice_list[notice_bg.clickNum].title);
		notice_bg.labelTitle:set_text(GameInfoForThis.NoteTital);
	--end
	--if t_notice_list[notice_bg.clickNum].content and 
	--	type(t_notice_list[notice_bg.clickNum].content) == "string" then
	--	notice_bg.labelContent:set_text(t_notice_list[notice_bg.clickNum].content);
		notice_bg.labelContent:set_text(GameInfoForThis.NoteInfo);
	--end
	
	app.log("notice_bg ok");
end

function notice_bg.on_btn_close()
	app.log("点击关闭 公告列表");
	local t_notice_list = notice_bg.data;
	notice_bg.clickNum = notice_bg.clickNum +1;

	if table.getall(t_notice_list) < notice_bg.clickNum then
		notice_bg.Destroy()
		return;
	end
	if t_notice_list[notice_bg.clickNum].title and 
		type(t_notice_list[notice_bg.clickNum].title) == "string" then
		notice_bg.labelTitle:set_text(t_notice_list[notice_bg.clickNum].title);
	end
	if t_notice_list[notice_bg.clickNum].content and 
		type(t_notice_list[notice_bg.clickNum].content) == "string" then
		notice_bg.labelContent:set_text(t_notice_list[notice_bg.clickNum].content);
	end
end

function notice_bg.Destroy()
	app.log("删除 公告列表");
	if nil ~= notice_bg.ui then
		notice_bg.ui:set_active(false);
	end
	notice_bg.ui = nil
	notice_bg.data = {};
end
