--
-- Created by IntelliJ IDEA.
-- User: pokong
-- Date: 2017/5/3
-- Time: 16:51
-- To change this template use File | Settings | File Templates.
--
local TagType =
{
	
	recommend = 1,
	server_list = 2,
	recent_login = 3,
}

login_server = {
	path_serverlist = "assetbundles/prefabs/ui/login/login_serverlist.assetbundle";
	listBtnTag = {},
	listBtnTag1 = {},
	curTagType = TagType.recommend,
	choseItem = nil,
	uiPlayer = {},
	commendhead = {},
	lastheadlist = {},
	headlist = {},
	headtexturelist = {};
	lastheadtexturelist = {};
	commheadtexturelist = {};
};

function login_server.Start()
	app.log("login_server begin");

	if login_server.ui == nil then
		login_server._asset_loader = systems_func.loader_create("ResourceLoader_loader")
		login_server._asset_loader:set_callback("login_server.on_load")
		login_server._asset_loader:load(login_server.path_serverlist);
	else
		login_server.show_ui(true);
	end


end

function login_server.on_load(pid, fpath, asset_obj, error_info)
	if fpath == login_server.path_serverlist then
		login_server.ui = systems_func.game_object_create(asset_obj);
		login_server.ui:set_parent(Root.get_root_ui_2d());
		login_server.ui:set_name("login_serverlist");
		login_server.ui:set_local_rotation(0, 0, 0);
		login_server.ui:set_local_scale(1, 1, 1);

		--cj--
		login_server.wrapItem = ngui.find_wrap_content(login_server.ui,"animation/sco_view/panel/wrap_cont");
		login_server.wrapItem:set_on_initialize_item("login_server.initItem");
		login_server.scrItem = ngui.find_scroll_view(login_server.ui,"animation/sco_view/panel");
		login_server.scrItem:reset_position();

		--上次登录和推荐服务器列表
		login_server.wrapItem_one = login_server.ui:get_child_by_name("animation/sco_view2")
		login_server.wrapItem_other = login_server.ui:get_child_by_name("animation/sco_view")
		--上次登录列表
		login_server.last_grid_list = {}
		for i=1,3 do
			login_server.last_grid_list[i] = login_server.ui:get_child_by_name("animation/sco_view2/panel/grid1/btn_recent_"..i)
			login_server.last_grid_list[i]:set_active(false)
		end

		--推荐列表
		login_server.recommend_list = ngui.find_wrap_content(login_server.ui,"animation/sco_view2/panel/wrap_cont");
		login_server.recommend_list:set_on_initialize_item("login_server.initrecommendItem");
		login_server.recommend_scrItem = ngui.find_scroll_view(login_server.ui,"animation/sco_view2/panel");
		login_server.recommend_scrItem:reset_position();

		login_server.wrapTag = ngui.find_wrap_content(login_server.ui,"animation/panel_list/wrap_content");
		login_server.wrapTag:set_on_initialize_item("login_server.initTag");
		login_server.wrapTag:set_min_index(-2);
		login_server.wrapTag:set_max_index(0);
		login_server.wrapTag:reset();
		login_server.scrTag = ngui.find_scroll_view(login_server.ui,"panel_list");

		---
		-- login_server.top_lv = ngui.find_label(login_server.ui,"animation/top_other/cont_down/sp_green/lab")
		-- login_server.top_lv:set_text("流畅")
		-- login_server.top_hong = ngui.find_label(login_server.ui,"animation/top_other/cont_down/sp_red/lab")
		-- login_server.top_hong:set_text("爆满")
		-- login_server.top_hui = ngui.find_label(login_server.ui,"animation/top_other/cont_down/sp_gray/lab")
		-- login_server.top_hui:set_text("维护")

		login_server.ui_close_but = systems_func.ngui_find_button(login_server.ui,"animation/top_other/sp_title/btn_back");
		login_server.ui_close_but:set_on_click("login_server.close");

		if nil ~= login_enter.ui then
			login_enter.ui:set_active(false);
		end
	end

end

--state=0,   0开服 1繁忙 2瀑满 3维护
--type=1,    0普通 1推荐 2新服

local serverState =
{
	[0] = "",
	[1] = "dl_hot",
	[2] = "",
	[3] = "dl_weihu",
}

local serverType = 
{	[0] = "dl_lv",
	[1] = "dl_hong",
	[2] = "dl_hong",
	[3] = "dl_hui",
}

local serverTag = 
{
	[0] = "",
	[1] = "dl_new",
	[2] = "dl_hot",
}

local TagName = 
{
	[1]="推荐服务器",
	[2]="服务器列表",
	[3]="最近登录",
}




function login_server.initTag(obj,b,real_id)
	local index = math.abs(real_id)+1;
	--app.log("index ========================"..tostring(index))
	local labName = ngui.find_label(obj,"lab");
	local labName1 = ngui.find_label(obj,"lab1")
	labName:set_text(TagName[index]);
	labName1:set_text(TagName[index]);
	local btn = systems_func.ngui_find_button(obj,obj:get_name());
	btn:reset_on_click();
	btn:set_on_click("login_server.SelectTag");
	btn:set_event_value("",index);
	local shine = ngui.find_sprite(obj,"sp1");
	local shine1 = ngui.find_sprite(obj,"sp")
	
	if not login_server.listBtnTag[index] then
		login_server.listBtnTag[index] = {};
	end
	
	if not login_server.listBtnTag1[index] then
		login_server.listBtnTag1[index] = {};
	end
	
	login_server.listBtnTag[index] = shine;
	login_server.listBtnTag1[index] = shine1;

	shine:set_active(false)

	if login_server.curTagType == index then
		login_server.SelectTag({float_value=index});
		login_server.listBtnTag[index]:set_active(true)
		login_server.listBtnTag1[index]:set_active(true)
	end
end

function login_server.SelectTag(t)
	local index = t.float_value;
	app.log("SelectTag.......index"..tostring(index))
	if login_server.choseItem then
		login_server.choseItem:set_active(false)
	end

	
	login_server.choseItem = login_server.listBtnTag[index];
	login_server.choseItem1 = login_server.listBtnTag1[index];
	login_server.choseItem:set_active(true)
	login_server.choseItem1:set_active(true)
	login_server.curTagType = index;
	local list = login_server.GetGameServerList();

	-- app.log("LoginServerList.SelectTag ....list ..."..table.tostring(list))

	if index == 1 then
		login_server.wrapItem_one:set_active(true)
		login_server.wrapItem_other:set_active(false)

		--设置上次登录服务器列表
		login_server:set_last_server_data()
		local rec_list = ServerListData.get_recommend_list()
		--app.log("LoginServerList.SelectTag ....rec_list ..."..table.tostring(rec_list))
		if rec_list then
			login_server.recommend_list:set_active(true)
			local num = #rec_list;
			local numb = math.ceil(num/3)
			--app.log("LoginServerList.SelectTag ....numb ..."..tostring(numb))
			login_server.recommend_list:set_min_index(-numb);
			login_server.recommend_list:set_max_index(0);
			login_server.recommend_list:reset();
			login_server.recommend_scrItem:reset_position();
		else
			login_server.recommend_list:set_active(false)
		end

		for k,v in pairs(login_server.commendhead) do
			systems_func.texture_load(v.path,"login_server.load_comm_head_texture")
		end

	else
		login_server.wrapItem_one:set_active(false)
		login_server.wrapItem_other:set_active(true)
		if list then
			login_server.scrItem:set_active(true);
			local num = #list;
			local numb = math.ceil(num/3)
			--app.log("LoginServerList.SelectTag ....numb ..."..tostring(numb))
			login_server.wrapItem:set_min_index(-numb);
			login_server.wrapItem:set_max_index(0);
			login_server.wrapItem:reset();
			login_server.scrItem:reset_position();
		else
			login_server.scrItem:set_active(false);
		end
	end


	
end

function login_server.analyzeName(str, split_char)
	local sub_str_tab = { };

    while (true) do
        local pos = string.find(str, split_char);
        if (not pos) then
            sub_str_tab[#sub_str_tab + 1] = str;
            break;
        end
        local sub_str = string.sub(str, 1, pos - 1);
        sub_str_tab[#sub_str_tab + 1] = sub_str;
        str = string.sub(str, pos + 1, #str);
    end

--    app.log("sub_str_tab=========="..table.tostring(sub_str_tab))

    return sub_str_tab;
end

function login_server.set_last_server_data()
	app.log("set_last_server_data")
	if login_enter.local_file_data ~= nil and table.getn(login_enter.local_file_data) > 0 then
		app.log("last_server_id"..table.tostring(login_enter.local_file_data))
		for i=1,3 do
			if login_enter.local_file_data[i] then
				local info = ServerListData.get_server_info(login_enter.local_file_data[i])
				--app.log("server_info......"..table.tostring(info))
				login_server.last_grid_list[i]:set_active(true)
				local head_comm = login_server.ui:get_child_by_name("animation/sco_view2/panel/grid1/btn_recent_"..i.."/sp_frame")
				head_comm:set_active(false)
				local headitem = systems_func.ngui_find_texture(login_server.ui,"animation/sco_view2/panel/grid1/btn_recent_"..i.."/sp_frame/texture_human") 
				local btn = systems_func.ngui_find_button(login_server.ui,"animation/sco_view2/panel/grid1/btn_recent_"..i);
				btn:reset_on_click();
				btn:set_on_click("login_server.SelectServer");
				btn:set_event_value(info.name,info.server_id);
				local lab = ngui.find_label(login_server.ui,"animation/sco_view2/panel/grid1/btn_recent_"..i.."/txt1");
				local lab1 = ngui.find_label(login_server.ui,"animation/sco_view2/panel/grid1/btn_recent_"..i.."/txt2")
				local server_info = login_server.analyzeName(info.name,"_")
				if server_info[1] then
					lab:set_text(server_info[1]);
				end
				if server_info[2] then
					lab1:set_text(server_info[2])
				else
					lab1:set_text("")
				end

				local sp = ngui.find_sprite(login_server.ui,"animation/sco_view2/panel/grid1/btn_recent_"..i.."/sp_art_font");
				local level = ngui.find_label(login_server.ui,"animation/sco_view2/panel/grid1/btn_recent_"..i.."/lab_level")
				level:set_text("")
				local spState = ngui.find_sprite(login_server.ui,"animation/sco_view2/panel/grid1/btn_recent_"..i.."/sp_yuan_dian");
				--app.log("inof-=----------"..table.tostring(info))
				local prolist = info.pro_list
				if #prolist > 0 then
					sp:set_sprite_name(serverState[info.type]);
					spState:set_sprite_name(serverType[info.state]);
				else
					sp:set_sprite_name(serverState[3]);
					spState:set_sprite_name(serverType[3]);
				end
				
				local server_player_info = UserCenter.get_player_info_id(info.server_id)
				--app.log("server_player_info..."..table.tostring(server_player_info))
				if server_player_info ~= {} and server_player_info ~= nil then
					--人物头像等级
					local head_data = login_head.get_head(server_player_info.player_image)
					if head_data ~= nil and head_data ~= '' then
						local id = 500000+i
						login_server.commendhead[id] = {obj = headitem, path = head_data }

						--systems_func.texture_load(head_data,"login_server.load_comm_head_texture")
						
						level:set_text(tostring(server_player_info.player_lv))
						--sp:set_active(false)
						head_comm:set_active(true)
					end
				end
			end
		end
	end
end

function login_server.initrecommendItem(obj,b,real_id)
	local index = math.abs(real_id);

	local list = ServerListData.get_recommend_list();

	--app.log("list================"..tostring(index))

	for i=1,3 do
		local id = index*3+i;
		local item = obj:get_child_by_name("btn_recent_"..i);

		local headitem = systems_func.ngui_find_texture(item,"sp_frame/texture_human")
		local head_comm = item:get_child_by_name("sp_frame")
		head_comm:set_active(false)
		if list then
			--app.log("id================="..tostring(id))
			local info = list[id];
			--app.log("info------------"..table.tostring(info))
			if info then
				item:set_active(true);
				local btn = systems_func.ngui_find_button(item,item:get_name());
				btn:reset_on_click();
				btn:set_on_click("login_server.SelectServer");
				btn:set_event_value(info.name,info.server_id);
				local lab = ngui.find_label(item,"txt1");
				local lab1 = ngui.find_label(item,"txt2")
				local server_info = login_server.analyzeName(info.name,"_")
				if server_info[1] then
					lab:set_text(server_info[1]);
				end
				if server_info[2] then
					lab1:set_text(server_info[2])
				else
					lab1:set_text("")
				end

				local sp = ngui.find_sprite(item,"sp_art_font");
				local level = ngui.find_label(item,"lab_level")
				level:set_text("")
				local spState = ngui.find_sprite(item,"sp_yuan_dian");
				--app.log("inof-=----------"..table.tostring(info))
				local prolist = info.pro_list
				if #prolist > 0 then
					sp:set_sprite_name(serverState[info.type]);
					spState:set_sprite_name(serverType[info.state]);
				else
					sp:set_sprite_name(serverState[3]);
					spState:set_sprite_name(serverType[3]);
				end
				

				local server_player_info = UserCenter.get_player_info_id(info.server_id)
				--app.log("server_player_info..."..table.tostring(server_player_info))
				if server_player_info ~= {} and server_player_info ~= nil then
					--人物头像等级
					local head_data = login_head.get_head(server_player_info.player_image)
					--app.log("initrecommendItem head_data...."..tostring(head_data).."   id----------"..tostring(id))
					if head_data ~= nil and head_data ~= '' then
						login_server.commendhead[id] = { obj = headitem,path = head_data}
						--systems_func.texture_load(head_data,"login_server.load_comm_head_texture")
						level:set_text(tostring(server_player_info.player_lv))
						--sp:set_active(false)
						head_comm:set_active(true)
					end
				end
			else
				item:set_active(false);
			end
		else
			item:set_active(false);
		end
	end

	local grid = ngui.find_grid(obj, obj:get_name());
	grid:reposition_now();

end


function login_server.load_comm_head_texture(pid, fpath, asset_obj, error_info)
	app.log("login_server.load_comm_head_texture")
	for k,v in pairs(login_server.commendhead) do
		if v.path == fpath then
			if asset_obj then
				login_server.commheadtexturelist[k] = asset_obj
				v.obj:set_texture(asset_obj);
			end
		end
	end
end

function login_server.load_last_head_texture(pid, fpath, asset_obj, error_info)
	for k,v in pairs(login_server.lastheadlist) do
		if v.path == fpath then
			if asset_obj then
				login_server.lastheadtexturelist[k] = asset_obj
				v.obj:set_texture(asset_obj);
			end
		end
	end
end

function login_server.load_head_texture(pid, fpath, asset_obj, error_info)
	for k,v in pairs(login_server.headlist) do
		if v.path == fpath then
			if asset_obj then
				login_server.headtexturelist[k] = asset_obj
				v.obj:set_texture(asset_obj);
			end
		end
	end
end

function login_server.initItem(obj,b,real_id)

	local index = math.abs(real_id);

	local list = login_server.GetGameServerList();
	-- app.log("serverlist==============="..tostring(#list))
	for i=1,3 do
		local id = index*3+i;
		local item = obj:get_child_by_name("btn_recent_"..i);
		
		local headitem = systems_func.ngui_find_texture(item,"sp_frame/texture_human")
		local head_comm = item:get_child_by_name("sp_frame")
		head_comm:set_active(false)
		if list then
			--app.log("id================="..tostring(id))
			local info = list[id];
			--app.log("info------------"..table.tostring(info))
			if info then
				item:set_active(true);
				local btn = systems_func.ngui_find_button(item,item:get_name());
				btn:reset_on_click();
				btn:set_on_click("login_server.SelectServer");
				btn:set_event_value(info.name,info.server_id);
				local lab = ngui.find_label(item,"txt1");
				local lab1 = ngui.find_label(item,"txt2")
				local server_info = login_server.analyzeName(info.name,"_")
				if server_info[1] then
					lab:set_text(server_info[1]);
				end
				if server_info[2] then
					lab1:set_text(server_info[2])
				else
					lab1:set_text("")
				end

				local sp = ngui.find_sprite(item,"sp_art_font");
				local level = ngui.find_label(item,"lab_level")
				level:set_text("")
				local spState = ngui.find_sprite(item,"sp_yuan_dian");
				--app.log("inof-=----------"..table.tostring(info))
				local prolist = info.pro_list
				if #prolist > 0 then
					sp:set_sprite_name(serverState[info.type]);
					spState:set_sprite_name(serverType[info.state]);
				else
					sp:set_sprite_name(serverState[3]);
					spState:set_sprite_name(serverType[3]);
				end
				
				local server_player_info = UserCenter.get_player_info_id(info.server_id)
				--app.log("server_player_info..."..table.tostring(server_player_info))
				if server_player_info ~= {} and server_player_info ~= nil then
					--人物头像等级
					local head_data = login_head.get_head(server_player_info.player_image)
					if head_data ~= nil and head_data ~= '' then 
						app.log("initItem head_data...."..tostring(server_player_info.player_lv))
						login_server.headlist[id] = {obj = headitem,path = head_data}
						systems_func.texture_load(head_data,"login_server.load_head_texture")
						
						level:set_text(tostring(server_player_info.player_lv))
						--sp:set_active(false)
						head_comm:set_active(true)
					end
				end

			else
				item:set_active(false);
			end
		else
			item:set_active(false);
		end
	end

	local grid = ngui.find_grid(obj, obj:get_name());
	grid:reposition_now();
end

function login_server.GetGameServerList()
	if login_server.curTagType == TagType.have_role then
		local tab =  systems_data.get_played_server_info();
		local list = {};
		
		return list;
	elseif login_server.curTagType == TagType.recent_login then
		local list = {};
		
		local id = login_enter.get_local_server_list()
		--app.log("id==============="..table.tostring(id))
		local all = ServerListData.get_proxy_data_list()

		for k,v in pairs(id) do
			for kk,vv in pairs(all) do
				if v == vv.server_id then
					table.insert(list,vv)
				end
			end
		end

		return list;
	elseif login_server.curTagType == TagType.recommend then
		return ServerListData.get_recommend_list()
	else
		return ServerListData.get_proxy_data_list();
	end
end

function login_server.SelectServer(t)

	login_enter.set_enter_server_id( t.float_value);

	--[[得到服务器信息]]
	local server_info = ServerListData.get_server_info(login_enter.enter_server_id);
	if server_info ~= nil then
		--		app.log("@@@@@@@>"..server_info.state);
		--[[是不是维护中]]
		if server_info.state == 3 then
			--[[判断维护公告]]
			ServerListData.get_server_notice_info_cb(login_enter.enter_server_id,login_enter.enter_notice_callback);
		end
	end

	login_server.close();
end

function login_server.close()
	login_server.show_ui(false);
end

function login_server.show_ui(is_show)
	if nil ~= login_server.ui then
		login_server.ui:set_active(is_show);
	end

	if nil ~= login_enter.ui then
		if is_show then
			login_enter.ui:set_active(false);
		else
			login_enter.ui:set_active(true);
		end
	end
end

function login_server.Destroy()
	login_server.show_ui(false);
	login_server.ui = nil
	login_server.choseItem = nil;
	login_server.choseItem1 = nil;

	for k,v in pairs(login_server.commheadtexturelist) do
		v = nil;
	end
	login_server.commheadtexturelist = {};

	for k,v in pairs(login_server.headtexturelist) do
		v = nil;
	end

	login_server.headtexturelist = {};
end