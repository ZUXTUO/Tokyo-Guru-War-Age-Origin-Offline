PowerRankUI = Class("PowerRankUI", MultiResUiBaseClass)

local _lab_txt = {
	[1] = "活动奖励";
	[2] = "战力奖励";
	[3] = "战力排行";
	[4] = "角色介绍";
	[5] = "活动规则";

	[6] = "%d";
	[7] = "未上榜",
    [8] = "%s天",
}

local _rank_texture = {
	[1] = "phb_paiming1";
	[2] = "phb_paiming2";
	[3] = "phb_paiming3";
}

local _resList = {
    [1] = "assetbundles/prefabs/ui/award/ui_6101_fight_rank.assetbundle",
    [2] = "assetbundles/prefabs/ui/award/ui_6105_fight_rank.assetbundle",
    [3] = "assetbundles/prefabs/ui/award/ui_6102_fight_rank.assetbundle",
    [4] = "assetbundles/prefabs/ui/award/ui_6104_fight_rank.assetbundle",
    [5] = "assetbundles/prefabs/ui/award/ui_6103_fight_rank.assetbundle",  
    
}

local resType = 
{
    Main = 1,
    Award = 2,
}

function PowerRankUI:Init(data)
    self.pathRes = {
        [resType.Main] = "assetbundles/prefabs/ui/award/ui_6100_fight_rank.assetbundle",
        [resType.Award] = _resList[1],
    }
    MultiResUiBaseClass.Init(self, data)
end

function PowerRankUI:InitData(data)
    MultiResUiBaseClass.InitData(self, data);

    self.m_role_default_id = 0;
    self.m_card_human = nil;

    self.m_yeka_list = {};
    self.m_panel_list = {};
    self.m_current_index = 0;

    self.m_sm_item_list = {};
    self.m_sm_item_ui = {};
    self.m_sm_item_1 = {};

    self.m_my_rank_data = nil;
    self.m_rank_data_list = {};
    self.m_my_uiPlayerHead = nil;
    self.m_uiPlayerHead_list = {};

    self.m_sm_item_award_ui = {};

    self.updateTimer = 0;
    self.is_old_rank = false;

    self.isLoadingRes = false
end

function PowerRankUI:DestroyUi()

	for k,v in pairs(self.m_sm_item_1) do
		for k2,v2 in pairs(v) do
			if v2 then
				for k3,v3 in pairs(v2) do
					v3:DestroyUi();
					v3 = nil;
				end
				v2 = nil;
			end
		end
		v = nil;
	end
	self.m_sm_item_1 = {};

	if self.m_my_uiPlayerHead then
		self.m_my_uiPlayerHead:DestroyUi();
	end

	for k,v in pairs(self.m_uiPlayerHead_list) do
		if v then
			v:DestroyUi();
			v = nil;
		end
	end
	self.m_uiPlayerHead_list = {};

	for k,v in pairs(self.m_sm_item_award_ui) do
		for k2,v2 in pairs(v) do
			if v2 then
				for k3,v3 in pairs(v2) do
                    v3:DestroyUi();
                    v3 = nil;
                end
                v2 = nil;
			end
		end
		v = nil;
	end
	self.m_sm_item_award_ui = {};

	if self.updateTimer ~= 0 then 
        timer.stop(self.updateTimer);
        self.updateTimer = 0;
   end

   if self.m_card_human then
   	self.m_card_human = nil;
   end

    self.is_old_rank = false;

    if self.skill_icon then
        for k, v in pairs(self.skill_icon) do
            if v then
                v:Destroy()
                v = nil
            end
        end
        self.skill_icon = nil
    end
    self.m_panel_list = {}

    -- if self.roleInfo then
    --     self.roleInfo:DestroyUi();
    --     self.roleInfo = nil
    -- end

    MultiResUiBaseClass.DestroyUi(self)	
end

function PowerRankUI:RegistFunc()
	MultiResUiBaseClass.RegistFunc(self);
   	
   	self.bindfunc["on_close"] = Utility.bind_callback(self, self.on_close);
   	self.bindfunc["on_change_yeka"] = Utility.bind_callback(self, self.on_change_yeka);
   	self.bindfunc["on_get_award"] = Utility.bind_callback(self, self.on_get_award);
   	self.bindfunc["on_press_skill"] = Utility.bind_callback(self, self.on_press_skill);
   	self.bindfunc["on_click_other_panel"] = Utility.bind_callback(self, self.on_click_other_panel);
    self.bindfunc["on_sub_res_loaded"] = Utility.bind_callback(self, self.on_sub_res_loaded)
    self.bindfunc["on_click_head_detail"] = Utility.bind_callback(self, self.on_click_head_detail);
    self.bindfunc["on_rule"] = Utility.bind_callback(self, self.on_rule);

   	self.bindfunc["on_item_1"] = Utility.bind_callback(self, self.on_item_1);
   	self.bindfunc["on_item_power"] = Utility.bind_callback(self, self.on_item_power);
   	self.bindfunc["on_item_award"] = Utility.bind_callback(self, self.on_item_award);
   	self.bindfunc["set_deff_time"] = Utility.bind_callback(self, self.set_deff_time);

   	self.bindfunc["gc_rank"] = Utility.bind_callback(self, self.gc_rank);
   	self.bindfunc["gc_back_rank_power_state"] = Utility.bind_callback(self, self.gc_back_rank_power_state);
   	self.bindfunc["gc_back_rank_power_award"] = Utility.bind_callback(self, self.gc_back_rank_power_award);

   	self.bindfunc["gc_change_activity_time"] = Utility.bind_callback(self, self.gc_change_activity_time);
   	self.bindfunc["gc_pause_activity"] = Utility.bind_callback(self, self.gc_pause_activity);
end

function PowerRankUI:MsgRegist()
	MultiResUiBaseClass.MsgRegist(self);

	PublicFunc.msg_regist(msg_rank.gc_rank, self.bindfunc["gc_rank"]);
	PublicFunc.msg_regist("msg_activity.gc_back_rank_power_state", self.bindfunc["gc_back_rank_power_state"]);
	PublicFunc.msg_regist("msg_activity.gc_back_rank_power_award", self.bindfunc["gc_back_rank_power_award"]);

	PublicFunc.msg_regist("msg_activity.gc_change_activity_time", self.bindfunc["gc_change_activity_time"]);
	PublicFunc.msg_regist("msg_activity.gc_pause_activity", self.bindfunc["gc_pause_activity"]);
end

function PowerRankUI:MsgUnRegist()
 	MultiResUiBaseClass.MsgUnRegist(self);

 	PublicFunc.msg_unregist(msg_rank.gc_rank, self.bindfunc["gc_rank"]);
 	PublicFunc.msg_unregist("msg_activity.gc_back_rank_power_state", self.bindfunc["gc_back_rank_power_state"]);
	PublicFunc.msg_unregist("msg_activity.gc_back_rank_power_award", self.bindfunc["gc_back_rank_power_award"]);

	PublicFunc.msg_unregist("msg_activity.gc_change_activity_time", self.bindfunc["gc_change_activity_time"]);
	PublicFunc.msg_unregist("msg_activity.gc_pause_activity", self.bindfunc["gc_pause_activity"]);
end

function PowerRankUI:GetUIByType(resType)
    return self.uis[self.pathRes[resType]]
end

function PowerRankUI:Show( )
	
end

function PowerRankUI:InitedAllUI(asset_obj)
    local path = "center_other/animation/"

    self.ui = self:GetUIByType(resType.Main)
	self.ui:set_name("power_rank_ui")
    self.objParent = self.ui:get_child_by_name("center_other/animation")
    local awardUI = self:GetUIByType(resType.Award)
    awardUI:set_parent(self.objParent) 
    awardUI:set_name("content1")

    self.m_panel_list[1] = awardUI

	self.close_btn = ngui.find_button(self.ui, path .. "cont_di/btn_cha");
    self.close_btn:set_on_click(self.bindfunc["on_close"]);

    -- self.m_activity_award_panel = self.ui:get_child_by_name("center_other/animation/content1");
    -- self.m_power_rank_panel = self.ui:get_child_by_name("center_other/animation/content2");
    -- self.m_activity_rule_panel = self.ui:get_child_by_name("center_other/animation/content3");
    -- self.m_role_display_panel = self.ui:get_child_by_name("center_other/animation/content4");
    -- self.m_power_award_panel = self.ui:get_child_by_name("center_other/animation/content5");

    local yeka = nil;
    local yeka_lab_1 = nil;
    local yeka_lab_2 = nil;
    local yeka_btn = nil;
    for i=1,5 do
    	yeka = self.ui:get_child_by_name(path .. "yeka/yeka" .. i);
    	yeka_lab_1 = ngui.find_label(yeka, "sp1/lab1");
    	yeka_lab_1:set_text(_lab_txt[i]);
    	yeka_lab_2 = ngui.find_label(yeka, "sp2/lab2");
    	yeka_lab_2:set_text(_lab_txt[i]);
    	yeka_btn = ngui.find_button(self.ui, path .. "yeka/yeka" .. i);
    	yeka_btn:reset_on_click();
    	yeka_btn:set_event_value("", i);
    	yeka_btn:set_on_click(self.bindfunc["on_change_yeka"]);
    	self.m_yeka_list[i] = yeka;
    	--self.m_panel_list[i] = self.ui:get_child_by_name("center_other/animation/content" .. i);
    end

    self.objTitle = self.ui:get_child_by_name(path .. "texture_title");
    self.m_grid_1 = ngui.find_wrap_content(self.ui, path .. "content1/scroll_view/panel_list/wrap_cont");
	self.m_grid_1:set_on_initialize_item(self.bindfunc["on_item_1"]);
	self.m_grid_1:set_min_index(0);
	self.m_grid_1:set_max_index(-1);
	self.m_grid_1:reset();
	self.m_grid_1_view = ngui.find_scroll_view(self.ui, path .. "content1/scroll_view/panel_list");
	-- self.m_grid_1_view:reset_position();

	self.m_text2 = self.ui:get_child_by_name(path .. "cont_di/txt2");
	self.lab_time = ngui.find_label(self.ui, path .. "cont_di/txt2/lab_time");
	self.lab_time:set_text("");

	local activityTime = g_dataCenter.activityReward:GetActivityTimeForActivityID(ENUM.Activity.activityType_power_rank);
	self.m_end_time = activityTime.e_time;
	self:set_deff_time();
	if self.updateTimer == 0 then
        self.updateTimer = timer.create(self.bindfunc["set_deff_time"], 1000 ,-1);
    end

    self.m_current_index = 1;
    self:SetPanelByIndex(self.m_current_index);

    g_dataCenter.activityReward:SetRedPointStateByActivityID(ENUM.Activity.activityType_power_rank, 0);
end

function PowerRankUI:set_deff_time( )
	local diffSec = self.m_end_time - system.time();
	local day,hour,min,sec = TimeAnalysis.ConvertSecToDayHourMin(diffSec)
    if self.lab_time then
    	if diffSec > 0 then
    		self.m_text2:set_active(true);
	    	self.lab_time:set_text(string.format(_lab_txt[8], day) .. string.format("%02d:", hour) .. string.format("%02d:", min) .. string.format("%02d", sec))
	    	--app.log("-------时间: " .. day .. "天-" .. string.format("%02d:", hour) .. string.format("%02d:", min) .. string.format("%02d", sec));
    	else
    		self.m_text2:set_active(false);
    		self.lab_time:set_text("");
    		if self.updateTimer ~= 0 then 
		        timer.stop(self.updateTimer);
		        self.updateTimer = 0;
		   end
   		end
    end
end

function PowerRankUI:on_close( t )
	uiManager:RemoveUi(EUI.PowerRankUI);
end

function PowerRankUI:on_change_yeka( t )
	app.log("t.float_value:" .. t.float_value);
	if self.m_current_index ~= t.float_value then
		self.m_current_index = t.float_value;

		self:SetPanelByIndex(self.m_current_index);
	end
end

function PowerRankUI:SetPanelByIndex( indexNum )
    if self.isLoadingRes then
        return
    end
    --加载资源
    if self.m_panel_list[indexNum] == nil then
        self.isLoadingRes = true
        ResourceLoader.LoadAsset(_resList[indexNum], self.bindfunc['on_sub_res_loaded'], self.panel_name);
        return
    end
	for k,v in pairs(self.m_panel_list) do
		if tonumber(k) == tonumber(indexNum) then
			v:set_active(true);
		else
			v:set_active(false);
		end
	end
    self.objTitle:set_active(true)
	self:SetPanelDataByIndex(indexNum);
end

function PowerRankUI:on_sub_res_loaded(pid, filepath, asset_obj, error_info)
    if filepath == _resList[self.m_current_index] then
        local __ui = asset_game_object.create(asset_obj)
        __ui:set_parent(self.objParent)
        __ui:set_name("content" .. self.m_current_index)
        local sx,sy,sz = Utility.SetUIAdaptation()
        __ui:set_local_scale(sx,sy,sz);
        __ui:set_local_position(0,0,0)

        self.m_panel_list[self.m_current_index] = __ui

        local path = "center_other/animation/"
        if self.m_current_index == 3 then
            self.m_my_power_item = self.ui:get_child_by_name(path .. "content3/item1");
	        self.m_power_grid = ngui.find_wrap_content(self.ui, path .. "content3/scroll_view/panel_list/wrap_cont");
	        self.m_power_grid:set_on_initialize_item(self.bindfunc["on_item_power"]);
	        self.m_power_grid:set_min_index(0);
	        self.m_power_grid:set_max_index(-1);
	        self.m_power_grid:reset();
	        self.m_power_view = ngui.find_scroll_view(self.ui, path .. "content3/scroll_view/panel_list");
	        self:SetPowerTileInit(self.m_my_power_item);

        elseif self.m_current_index == 5 then
            self.m_activity_rule_txt = ngui.find_label(self.ui, path .. "content5/scroll_view/panel_list/lab_word");
	        self.m_activity_rule_txt:set_text("");

        elseif self.m_current_index == 2 then
            --self.m_my_award_item = self.ui:get_child_by_name(path .. "content5/item");
	        self.m_award_grid = ngui.find_wrap_content(self.ui, path .. "content2/scroll_view/panel_list/wrap_cont");
	        self.m_award_grid:set_on_initialize_item(self.bindfunc["on_item_award"]);
	        self.m_award_grid:set_min_index(0);
	        self.m_award_grid:set_max_index(-1);
	        self.m_award_grid:reset();
	        self.m_award_view = ngui.find_scroll_view(self.ui, path .. "content2/scroll_view/panel_list");
        end
	   
        self.isLoadingRes = false
        self:SetPanelByIndex(self.m_current_index)
    end
end

function PowerRankUI:SetPanelDataByIndex( indexNum )
	
	local data_config = nil;
	if indexNum == 1 then
		data_config = ConfigManager._GetConfigTable(EConfigIndex.t_rank_activity_award);
		local num = 0;
		for k,v in pairs(data_config) do
			num = num + 1;
		end
		self.m_grid_1:set_min_index(-num + 1);
		self.m_grid_1:set_max_index(0);
		self.m_grid_1:reset();
		self.m_grid_1_view:reset_position();
	elseif indexNum == 3 then -- 战斗力排行
		-- msg_rank.cg_rank(1, 50);
		local activityTime = g_dataCenter.activityReward:GetActivityTimeForActivityID(ENUM.Activity.activityType_power_rank);
		local diffeSec = activityTime.e_time - system.time();
		if system.time() <= activityTime.e_time then
			msg_rank.cg_rank(17, 50);
		elseif system.time() > activityTime.e_time and system.time() < activityTime.o_time then
			self.is_old_rank = true;
			msg_activity.cg_old_rank();
		end
	elseif indexNum == 5 then
		local s_data_config = ConfigManager.Get(EConfigIndex.t_activity_other, 3);
		-- app.log("------------" .. table.tostring(s_data_config));
		if s_data_config then
			self.m_activity_rule_txt:set_text(s_data_config.parm_9);
		end
	elseif indexNum == 4 then
        self.objTitle:set_active(false)
		self:SetPanelDataByRoleDisplay();
	elseif indexNum == 2 then
		app.log("----------- 289")
		-- msg_activity.cg_get_rank_power_state();

        data_config = ConfigManager._GetConfigTable(EConfigIndex.t_rank_power_award);
        local num = 0;
        for k,v in pairs(data_config) do
            num  = num + 1;
        end
        -- app.log("m_vecStates = " .. table.tostring(self.m_vecStates));
        self.m_award_grid:set_min_index(-num + 1);
        self.m_award_grid:set_max_index(0);
        self.m_award_grid:reset();
        self.m_award_view:reset_position();
	end
end


-- 活动奖励
function PowerRankUI:on_item_1( obj, b, real_id )
	local index = math.abs(real_id) + 1;
	local index_b = math.abs(b) + 1;

	if self.m_sm_item_ui[index_b] == nil then
		self.m_sm_item_ui[index_b] = obj;
	end

	if self.m_sm_item_1[index_b] == nil then
		self.m_sm_item_1[index_b] = {};
	end
	-- app.log(index .. "------" .. index_b)
	local item_config_data = ConfigManager.Get(EConfigIndex.t_rank_activity_award, index);

	local sp_rank = ngui.find_sprite(obj, "sp_one");
    local sp_bk = ngui.find_sprite(obj, "sp_bk");
	local lab_level = ngui.find_label(obj, "lab_rank_num");
	lab_level:set_text("");
	if tonumber(item_config_data.limit_lower) == tonumber(item_config_data.limit_upper) then
		if tonumber(item_config_data.limit_lower) <= 3 then
			sp_rank:set_active(true);
            sp_bk:set_active(true)
			lab_level:set_active(false);
			sp_rank:set_sprite_name(_rank_texture[item_config_data.limit_lower]);
		else
			sp_rank:set_active(false);
            sp_bk:set_active(false);
			lab_level:set_active(true);
			lab_level:set_text(tostring(item_config_data.limit_lower));
		end
	else		
		sp_rank:set_active(false);
		lab_level:set_active(true);
		lab_level:set_text(tostring(item_config_data.limit_lower) .. "-" .. tostring(item_config_data.limit_upper));
	end
	
	local item_award_data = item_config_data.award;
	local small_card_item = nil;
    local item_award_num = #item_award_data;
    local itemNum = 1;
    local itemId = 1;
    for i=1,4 do
    	small_card_item = obj:get_child_by_name("grid/new_small_card_item" .. i);
    	if item_award_data[i] then
    		small_card_item:set_active(true);
    		itemId = item_award_data[i].item_id;
    		itemNum = item_award_data[i].item_num;

    		if self.m_sm_item_1[index_b][i] == nil then
    			self.m_sm_item_1[index_b][i] = {};
    		end

    		if PropsEnum.IsRole(itemId) then
    			if self.m_sm_item_1[index_b][i][2] == nil then
    				self.m_sm_item_1[index_b][i][2] = SmallCardUi:new({parent = small_card_item, as_reward = true, info = CardHuman:new({number = tonumber(itemId)}), stypes = {1,6,9}});
    			end
    			self.m_sm_item_1[index_b][i][2]:Show();
    			self.m_sm_item_1[index_b][i][2]:SetDataNumber(itemId, itemNum);
    			self.m_sm_item_1[index_b][i][2]:SetCallback(self.bindfunc["on_click_head_detail"]);

    			if self.m_sm_item_1[index_b][i][1] then
    				self.m_sm_item_1[index_b][i][1]:Hide();
    			end
    		else
    			if self.m_sm_item_1[index_b][i][1] == nil then
    				self.m_sm_item_1[index_b][i][1] = UiSmallItem:new({obj=nil, parent = small_card_item, cardInfo = nil, delay = 500});
    			end
    			self.m_sm_item_1[index_b][i][1]:Show();
    			self.m_sm_item_1[index_b][i][1]:SetDataNumber(itemId, itemNum);
    			self.m_sm_item_1[index_b][i][1]:SetEnablePressGoodsTips(true);

    			if self.m_sm_item_1[index_b][i][2] then
    				self.m_sm_item_1[index_b][i][2]:Hide();
    			end
    		end

    		-- local carditem = CardProp:new({number = item_award_data[i].item_id});
    		-- if self.m_sm_item_1[index_b][i] == nil then
	    	-- 	self.m_sm_item_1[index_b][i] = UiSmallItem:new({parent = small_card_item, cardInfo = carditem});
	    	-- else
	    	-- 	self.m_sm_item_1[index_b][i]:SetData(carditem);
	    	-- end
	    	-- self.m_sm_item_1[index_b][i]:SetCount(itemNum);
	    	

	    	local fx = small_card_item:get_child_by_name("fx");
	    	if fx and item_award_data[i].is_line and item_award_data[i].is_line == 1 then
	    		fx:set_active(true);
	    	elseif fx then
	    		fx:set_active(false);
	    	end
    	else
    		small_card_item:set_active(false);
    	end
    end
    
end

function PowerRankUI:on_click_head_detail( cardUI )
    app.log("--------------- 点击头像" .. tostring(cardUI.cardInfo.number));
    RecruitDetalUI:new(cardUI.cardInfo.number);
end

-- 战力排行
function PowerRankUI:SetPanelDataByPowerRank( )
	
end

function PowerRankUI:on_item_power( obj, b, real_id )
	local index = math.abs(real_id) + 1;
	local index_b = math.abs(b) + 1;

	self:SetPowerTile(obj, self.m_rank_data_list[index], index_b)
end

function PowerRankUI:SetPowerTileInit(obj)
	local lab_level = ngui.find_label(obj, "lab_level");
	lab_level:set_text("");

	local lab_name = ngui.find_label(obj, "lab_name");
	lab_name:set_text("");

	local sp_one = ngui.find_sprite(obj, "sp_one");
	if sp_one then
		sp_one:set_active(false);
	end

	local vip_sp_art_font = ngui.find_label(obj, "sp_art_font");
    if vip_sp_art_font then
	   vip_sp_art_font:set_active(false);
    end

	local txt_guild = ngui.find_label(obj, "txt_guild");
	txt_guild:set_active(false);

	local lab_fight = ngui.find_label(obj, "lab_fight");
	lab_fight:set_text("");
end

function PowerRankUI:SetPowerTile( obj, data, index )
	if data == nil then
		do return; end
	end
	app.log("---------- ranklist:" .. table.tostring(data))
	local btn_obj = ngui.find_button(obj:get_parent(), obj:get_name());
	if index ~= 0 and btn_obj then
		-- app.log("------------- sp_di" .. data.id)
		btn_obj:reset_on_click();
		btn_obj:set_on_click(self.bindfunc["on_click_other_panel"]);
		btn_obj:set_event_value(tostring(data.id), 0);
	end

	local lab_level = ngui.find_label(obj, "lab_level");
	lab_level:set_active(data.ranking > 3);
	lab_level:set_text("" .. data.ranking);
	local sp_one = ngui.find_sprite(obj, "sp_one");
	if sp_one then
		sp_one:set_active(tonumber(data.ranking) <= 3 and data.ranking_num >= 20000 );
		if tonumber(data.ranking) <= 3 and tonumber(data.ranking) > 0 then
			sp_one:set_sprite_name(_rank_texture[data.ranking]);
		end

		if tonumber(data.ranking) == 0 then
			sp_one:set_active(false);
		end
	end
	if index == 0 and data.ranking_num < 20000 then
		lab_level:set_text(_lab_txt[7]);
		lab_level:set_active(true);
	end

	local lab_name = ngui.find_label(obj, "lab_name_juese");
    if lab_name then
	   lab_name:set_text(data.name);
    end

	local vip_sp_art_font = ngui.find_label(obj, "sp_art_font");
    if vip_sp_art_font then
        vip_sp_art_font:set_active(false)
    end
	-- local vip_lab = ngui.find_label(obj, "sp_art_font/lab_num");
	-- vip_sp_art_font:set_active(tonumber(data.param2) > 0);
	-- PublicFunc.SetImageVipLevel(vip_sp_art_font, data.param2)

	local txt_guild = ngui.find_label(obj, "txt_guild");
	local txt_guild_lab = ngui.find_label(obj, "txt_guild/lab_name");
	txt_guild:set_active(tostring(data.addition_name) ~= "");
	txt_guild_lab:set_text(tostring(data.addition_name));

	local lab_fight = ngui.find_label(obj, "lab_fight");
	lab_fight:set_text("" .. data.ranking_num);

	-- do return end;
	local cardObj = obj:get_child_by_name("sp_head_di_item");
	if index == 0 then
		if self.m_my_uiPlayerHead then
			self.m_my_uiPlayerHead:DestroyUi();
			self.m_my_uiPlayerHead = nil;
		end
		self.m_my_uiPlayerHead = UiPlayerHead:new({parent=cardObj});
		self.m_my_uiPlayerHead:SetRoleId(tonumber(data.param3));
	else
		if self.m_uiPlayerHead_list[index] == nil then
			self.m_uiPlayerHead_list[index] = UiPlayerHead:new({parent=cardObj});
		end
		self.m_uiPlayerHead_list[index]:SetRoleId(tonumber(data.param3));
	end
end

-- 活动规则
function PowerRankUI:SetPanelDataByActivityRule( )
	
end

-- 角色展示
function PowerRankUI:SetPanelDataByRoleDisplay( )
	local panel_ui = self.m_panel_list[4];
	local item_config = ConfigManager.Get(EConfigIndex.t_activity_other, 3);

	local progress = nil;
	local txt = nil;
	-- progress = ngui.find_progress_bar(panel_ui, "sco_bar1");
	-- txt = ngui.find_label(panel_ui, "sco_bar1/lab");
	-- progress:set_value(item_config.parm_3 / 100);
	-- txt:set_text(tostring(item_config.parm_6));

	-- progress = ngui.find_progress_bar(panel_ui, "sco_bar2");
	-- txt = ngui.find_label(panel_ui, "sco_bar2/lab");
	-- progress:set_value(item_config.parm_4 / 100);
	-- txt:set_text(tostring(item_config.parm_7));
	
	-- progress = ngui.find_progress_bar(panel_ui, "sco_bar3");
	-- txt = ngui.find_label(panel_ui, "sco_bar3/lab");
	-- progress:set_value(item_config.parm_4 / 100);
	-- txt:set_text(tostring(item_config.parm_8));

	self.m_role_default_id = tonumber(item_config.parm_2);
	self.m_card_human = CardHuman:new( { number = self.m_role_default_id});
	self.role_config = ConfigHelper.GetRole(tonumber(item_config.parm_2));
	self.skill_config = nil;
	-- local skill_sprite = nil;

    if self.skill_icon == nil then
        self.skill_icon = {};
        for i = 1, 3 do
		    self.skill_icon[i] = ngui.find_texture(panel_ui, "texture_" .. i)
        end
    end
	local btn_skill = nil;
	for i = 1, 3 do
		self.skill_config = ConfigManager.Get(EConfigIndex.t_skill_info, self.role_config.spe_skill[i][1]);
		btn_skill = ngui.find_button(panel_ui, "texture_" .. i);
		btn_skill:set_on_ngui_press(self.bindfunc["on_press_skill"]);
        self.skill_icon[i]:set_texture(self.skill_config.small_icon);  	
	end
			
	local btn_rule = ngui.find_button(panel_ui, "btn_xiangqing");
	btn_rule:reset_on_click();
	btn_rule:set_on_click(self.bindfunc["on_rule"]);	
end

function PowerRankUI:on_rule( )
	--app.log("------------ on_rule"..table.tostring(self.m_card_human));
	--self.roleInfo = BattleRoleInfoUI:new({info = self.m_card_human, isPlayer = true, heroDataList = {[1] = self.m_card_human}});
    local roleid = self.m_role_default_id
    local flag = g_dataCenter.package:HavedHeroCard(roleid)
    --app.log("roleid====================="..tostring(roleid))

    local roleInfo = nil;
    
    if flag then
        roleInfo = g_dataCenter.package:find_card_for_num(1,roleid)
    else
        roleInfo = CardHuman:new( { number = roleid});
    end

    if not roleInfo then
        do return end
    end

    --app.log("roleInfo====================="..table.tostring(roleInfo))

    local data = 
    {   info = roleInfo,
        isPlayer = true,
        heroDataList = {},
    }

    uiManager:PushUi(EUI.BattleRoleInfoUI,data)
end

-- 战力奖励
function PowerRankUI:SetPanelDataByPowerAward( )
	
end

function PowerRankUI:on_item_award( obj, b, real_id )

    local data_config = ConfigManager._GetConfigTable(EConfigIndex.t_rank_power_award);
	local index = #data_config - math.abs(real_id);
	local index_b = math.abs(b) + 1;

	app.log(index .. "-" .. index_b);

	-- local item_back_data = self.m_vecStates[index];

	local item_data_config = ConfigManager.Get(EConfigIndex.t_rank_power_award, index);

	local lab_fight = ngui.find_label(obj, "lab_title");
    lab_fight:set_text(string.format(_lab_txt[6], item_data_config.need))

	if self.m_sm_item_award_ui[index_b] == nil then
		self.m_sm_item_award_ui[index_b] = {};
	end
	local new_small_card_item = nil;
	local item_award_data = nil;
    local itemId = 0;
	local itemNum = 0;
	local carditem = nil;
	local fx = nil;

	for i=1,4 do
		new_small_card_item = obj:get_child_by_name("grid/new_small_card_item" .. i);
		item_award_data = item_data_config.award[i];
		if item_award_data then
			new_small_card_item:set_active(true);
            itemId = item_award_data.item_id;
			itemNum = item_award_data.item_num;

            if self.m_sm_item_award_ui[index_b][i] == nil then
                self.m_sm_item_award_ui[index_b][i] = {};
            end

            if PropsEnum.IsRole(itemId) then
                if self.m_sm_item_award_ui[index_b][i][2] == nil then
                    self.m_sm_item_award_ui[index_b][i][2] = SmallCardUi:new({parent = new_small_card_item, as_reward = true, info = CardHuman:new({number = tonumber(itemId)}), stypes = {1,6,9}});
                end
                self.m_sm_item_award_ui[index_b][i][2]:Show();
                self.m_sm_item_award_ui[index_b][i][2]:SetDataNumber(itemId, itemNum);
                self.m_sm_item_award_ui[index_b][i][2]:SetCallback(self.bindfunc["on_click_head_detail"]);

                if self.m_sm_item_award_ui[index_b][i][1] then
                    self.m_sm_item_award_ui[index_b][i][1]:Hide();
                end
            else
                if self.m_sm_item_award_ui[index_b][i][1] == nil then
                    self.m_sm_item_award_ui[index_b][i][1] = UiSmallItem:new({obj=nil, parent = new_small_card_item, cardInfo = nil, delay = 500});
                end
                self.m_sm_item_award_ui[index_b][i][1]:Show();
                self.m_sm_item_award_ui[index_b][i][1]:SetDataNumber(itemId, itemNum);
                self.m_sm_item_award_ui[index_b][i][1]:SetEnablePressGoodsTips(true);

                if self.m_sm_item_award_ui[index_b][i][2] then
                    self.m_sm_item_award_ui[index_b][i][2]:Hide();
                end
            end


			-- carditem = CardProp:new({number = item_award_data.item_id});
			-- if self.m_sm_item_award_ui[index_b][i] == nil then
			-- 	self.m_sm_item_award_ui[index_b][i] = UiSmallItem:new({parent = new_small_card_item, cardInfo = carditem});
			-- else
			-- 	self.m_sm_item_award_ui[index_b][i]:SetData(carditem);
			-- end
			-- self.m_sm_item_award_ui[index_b][i]:SetCount(itemNum);

			fx = new_small_card_item:get_child_by_name("fx");
	    	if fx and item_award_data.is_line and item_award_data.is_line == 1 then
	    		fx:set_active(true);
	    	elseif fx then
	    		fx:set_active(false);
	    	end
		else
			new_small_card_item:set_active(false);
		end
	end

	-- local sp_get = ngui.find_sprite(obj, "sp_art_font");
	-- local btn_get = ngui.find_button(obj, "btn1"); 
 --    btn_get:reset_on_click();

    -- if item_back_data.state == 1 then
    	-- btn_get:set_active(false);
		-- sp_get:set_active(false);
		-- btn_get:set_event_value("1", item_back_data.id);
		-- btn_get:set_on_click(self.bindfunc["on_get_award"]);
		-- btn_get:set_sprite_names("ty_anniu3");
    -- elseif item_back_data.state == 2 then
    	-- btn_get:set_active(false);
		-- sp_get:set_active(false);
		-- btn_get:set_event_value("0", item_back_data.id);
		-- btn_get:set_on_click(self.bindfunc["on_get_award"]);
		-- btn_get:set_sprite_names("ty_anniu5");
	-- elseif item_back_data.state == 3 then
		-- sp_get:set_active(false);
		-- btn_get:set_active(false);
	-- end

end

function PowerRankUI:on_get_award( t )
	if t.string_value == "1" then
		msg_activity.cg_get_rank_power_award(t.float_value);
	end
end

function PowerRankUI:on_press_skill( name, state, x, y, go_obj )
	local skill_index = string.match(name, "%d");
	-- app.log("skill_index:" .. skill_index .. "-- role_id = " .. self.m_role_default_id);

	if self.skill_config and self.m_role_default_id ~= 0 and self.m_card_human ~= nil then
		if state then
			-- if tonumber(name) <= 3 then
			-- 	SkillTips.EnableSkillTips(true, "skill" .. (skill_index + 3), 1, self.m_card_human:GetPropertyVal(ENUM.EHeroAttribute.atk_power), x, y, 300, self.m_role_default_id);

			-- else
			-- 	skill_config = ConfigManager.Get(EConfigIndex.t_skill_info,  "skill" .. (skill_index + 3));
			-- 	SkillTips.EnableSkillTips(true, skill_config.id, 1, self.m_card_human:GetPropertyVal(ENUM.EHeroAttribute.atk_power), x, y, 300);
			-- end
			SkillTips.EnableSkillTips(true, self.role_config.spe_skill[tonumber(skill_index)][1], 1, self.m_card_human:GetPropertyVal(ENUM.EHeroAttribute.atk_power), x, y, 300);
				
		else
			SkillTips.EnableSkillTips(false);
		end
	end
end

function PowerRankUI:on_click_other_panel( t )
	-- app.log("str_value:" .. t.string_value);
	OtherPlayerPanel.ShowPlayer(t.string_value);
end

function PowerRankUI:gc_rank( rank_type, my_rank, ranklist )
	self.m_my_rank_data = my_rank;
	app.log("-----------" .. table.tostring(my_rank))
	self.m_rank_data_list = {};
	for k,v in pairs(ranklist) do
		if my_rank.id == v.id then
			if self.is_old_rank then
				self.m_my_rank_data.ranking_num = v.ranking_num;
				self.m_my_rank_data.ranking = v.ranking;
			end			
		end
		if v.ranking_num >= 20000  then
            table.insert(self.m_rank_data_list, v);
        end
		-- if v.ranking <= 10 then
		-- 	if v.ranking_num >= 20000  then
		-- 		table.insert(self.m_rank_data_list, v);
		-- 	end
		-- else
		-- 	table.insert(self.m_rank_data_list, v);
		-- end
	end
	table.sort( self.m_rank_data_list, function ( a, b )
		return a.ranking < b.ranking;
	end )
	
	-- self.m_rank_data_list = ranklist;
	if self.m_current_index == 3 then
		self:SetPowerTile(self.m_my_power_item, self.m_my_rank_data, 0);
		app.log("len:" .. #self.m_rank_data_list)
		self.m_power_grid:set_min_index(-#self.m_rank_data_list + 1);
		self.m_power_grid:set_max_index(0);
		self.m_power_grid:reset();
		self.m_power_view:reset_position();
	elseif self.m_current_index == 2 then
		-- self:SetPowerTile(self.m_my_award_item, self.m_my_rank_data, 0);
	end

	
end

function PowerRankUI:gc_back_rank_power_state( start_time, end_time, vecStates )
	if self.m_current_index == 2 then
		if self.m_my_rank_data then
			-- self:SetPowerTile(self.m_my_award_item, self.m_my_rank_data, 0);
		else
			local activityTime = g_dataCenter.activityReward:GetActivityTimeForActivityID(ENUM.Activity.activityType_power_rank);
			local diffeSec = activityTime.e_time - system.time();
			if system.time() <= activityTime.e_time then
				msg_rank.cg_rank(17, 50);
			elseif system.time() > activityTime.e_time and system.time() < activityTime.o_time then
				self.is_old_rank = true;
				msg_activity.cg_old_rank();
			end
		end
		app.log("--------- vecStates:" .. table.tostring(vecStates));
		self.m_start_time = start_time;
		self.m_end_time = end_time;
		self.m_vecStates = vecStates;

		-- table.sort( self.m_vecStates, function( a, b )
		-- 	if a.state < b.state then
		-- 		return true;
		-- 	elseif a.state == b.state then
		-- 		return a.id < b.id;
		-- 	end
		-- end )

		table.sort(self.m_vecStates, function ( a, b )
			return a.id < b.id;
		end)

		local num = 0;
		for k,v in pairs(self.m_vecStates) do
			num  = num + 1;
		end
		-- app.log("m_vecStates = " .. table.tostring(self.m_vecStates));
		self.m_award_grid:set_min_index(-num + 1);
		self.m_award_grid:set_max_index(0);
		self.m_award_grid:reset();
		self.m_award_view:reset_position();
	end
end

function PowerRankUI:gc_back_rank_power_award( rid )
	local item_config_data = ConfigManager.Get(EConfigIndex.t_rank_power_award, rid);
	local award = {};
	for k,v in pairs(item_config_data.award) do
		table.insert(award, {id = v.item_id, count = v.item_num});
	end
	CommonAward.Start(award);

	msg_activity.cg_get_rank_power_state();
end

function PowerRankUI:gc_change_activity_time()
	if g_dataCenter.activityReward:GetActivityIsOpenByActivityid(ENUM.Activity.activityType_power_rank) == false then
		uiManager:RemoveUi(EUI.PowerRankUI);
		PublicFunc.msg_dispatch(msg_activity.gc_check_is_buy_1);
	end
end

function PowerRankUI:gc_pause_activity()
	if g_dataCenter.activityReward:GetActivityIsOpenByActivityid(ENUM.Activity.activityType_power_rank) == false then
		uiManager:RemoveUi(EUI.PowerRankUI);
		PublicFunc.msg_dispatch(msg_activity.gc_check_is_buy_1);
	end
end
