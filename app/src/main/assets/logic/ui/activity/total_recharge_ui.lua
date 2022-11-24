TotalRechargeUI = Class("TotalRechargeUI", UiBaseClass)

local _txt = {
	[1] = "累计充值送好礼";
	[2] = "充值%d钻石,获得以下奖励";
	[3] = "领取";
    [4] = "活动日期:%d月%d日%02d:00~%d月%d日%02d:00";
}

function TotalRechargeUI:Init(data)
    self.pathRes = "assetbundles/prefabs/ui/award/ui_1109_award.assetbundle";
    UiBaseClass.Init(self, data);
end

function TotalRechargeUI:InitData(data)
    UiBaseClass.InitData(self, data);
    self.m_back_item_data = {};
    self.m_icon_list = {}
    self.m_end_time = 0;
    self.updateTimer = 0;
end

function TotalRechargeUI:DestroyUi()
    
	-- 释放资源
    if self.m_icon_list then
        for row, rowSmallItemUIs in pairs(self.m_icon_list) do
            for col,smallItemUI in pairs(rowSmallItemUIs) do
                if smallItemUI then
                    smallItemUI:DestroyUi();
                    smallItemUI = nil;
                end
            end
        
        end
        self.m_icon_list = nil
    end

    if self.updateTimer ~= 0 then 
        timer.stop(self.updateTimer);
        self.updateTimer = 0;
    end
    
    if self.m_texture then
        self.m_texture:clear_texture();
        self.m_texture = nil;
    end

    UiBaseClass.DestroyUi(self)	
end

function TotalRechargeUI:RegistFunc()
	UiBaseClass.RegistFunc(self);
    self.bindfunc["init_item"] = Utility.bind_callback(self, self.init_item);
    self.bindfunc["on_get_award"] = Utility.bind_callback(self, self.on_get_award);

    self.bindfunc["gc_back_total_recharge_state"] = Utility.bind_callback(self, self.gc_back_total_recharge_state);
    self.bindfunc["gc_back_total_recharge_award"] = Utility.bind_callback(self, self.gc_back_total_recharge_award);

    self.bindfunc["set_deff_time"] = Utility.bind_callback(self, self.set_deff_time);
    
end

function TotalRechargeUI:MsgRegist()
	PublicFunc.msg_regist("msg_activity.gc_back_total_recharge_state", self.bindfunc["gc_back_total_recharge_state"]);
	PublicFunc.msg_regist("msg_activity.gc_back_total_recharge_award", self.bindfunc["gc_back_total_recharge_award"]);
end

function TotalRechargeUI:MsgUnRegist()
	PublicFunc.msg_unregist("msg_activity.gc_back_total_recharge_state", self.bindfunc["gc_back_total_recharge_state"]);
	PublicFunc.msg_unregist("msg_activity.gc_back_total_recharge_award", self.bindfunc["gc_back_total_recharge_award"]);
end

function TotalRechargeUI:InitUI(asset_obj)
	UiBaseClass.InitUI(self, asset_obj)
	-- self.ui:set_parent(Root.get_root_ui_2d());
    self.ui:set_parent(Root.get_root_ui_2d():get_child_by_name("activity_ui"));
	self.ui:set_name("total_recharge_ui");
	self.ui:set_local_scale(1,1,1);
	self.ui:set_local_position(0,0,0);

    self.lab_big_title = ngui.find_label(self.ui, "center_other/animation/content/lab_big_title");
    if self.lab_big_title then
        self.lab_big_title:set_text(_txt[1]);
    end

    self.sp_di = ngui.find_sprite(self.ui, "total_recharge_ui/center_other/animation/sp_di");
    self.sp_di:set_active(false);
    self.sp_mark = ngui.find_sprite(self.ui, "total_recharge_ui/center_other/animation/sp_mark");
    self.sp_mark:set_active(false);
    -- self.sp_bk = ngui.find_sprite(self.ui, "hurdle_reward_ui/center_other/animation/sp_bk");
    -- self.sp_bk:set_active(false);
    
    self.contentPath = "total_recharge_ui/center_other/animation/content/";
    self.sp_art_font = ngui.find_sprite(self.ui, self.contentPath .. "sp_art_font");
    if self.sp_art_font then
        self.sp_art_font:set_sprite_name("hd_biaoti_chongzhi");
    end

    self.sp_art_font1 = ngui.find_sprite(self.ui, self.contentPath .. "cont2/sp_art_font");
    if self.sp_art_font1 then
    	self.sp_art_font1:set_active(false);
    end

    self.m_play_config = ConfigManager.Get(EConfigIndex.t_activity_play, ENUM.Activity.activityType_recharge_total);
    self.m_texture = ngui.find_texture(self.ui, self.contentPath .. "texture_di");
    local bg = nil;
    if self.m_play_config.bg_img then
        bg = tostring(self.m_play_config.bg_img);
        if bg ~= "0" then
            self.m_texture:set_texture(bg);
        end
    end
    -- self.m_texture:set_texture(self.m_play_config.bg_img);

    self.lab_title1 = ngui.find_label(self.ui, self.contentPath .. "lab_title1");
    self.lab_title1:set_text(tostring(self.m_play_config.activity_info));

    self.lab_title2 = ngui.find_label(self.ui, "center_other/animation/content/lab_title2");--
    self.lab_title2:set_active(false);
    if self.m_play_config and tostring(self.m_play_config.activity_name) ~= "0" and tostring(self.m_play_config.activity_name) ~= "nil" then
        self.lab_title2:set_active(true);
        self.lab_title2:set_text(tostring(self.m_play_config.activity_name));
    end
    
    self.sp_clock = ngui.find_sprite(self.ui, self.contentPath .. "sp_clock");
    if self.sp_clock then
        self.sp_clock:set_active(false);
    end
    self.sp_shuaxin = ngui.find_sprite(self.ui, "animation/content/sp_shuaxin");
    self.sp_shuaxin:set_active(false);
    self.lab_time = ngui.find_label(self.ui, self.contentPath .. "lab_time");
    local activityTime = g_dataCenter.activityReward:GetActivityTimeForActivityID(ENUM.Activity.activityType_recharge_total);
    if activityTime then
        self.sp_shuaxin:set_active(activityTime.is_reset == 1);
        -- self.m_start_time = activityTime.s_time;
        self.m_end_time = activityTime.e_time;
        -- local sysStartTime   = os.date("*t", self.m_start_time);
        -- local sysEndTime = os.date("*t", self.m_end_time);
        -- self.lab_time:set_text(string.format(_txt[4], sysStartTime.month, sysStartTime.day, sysStartTime.hour, sysEndTime.month, sysEndTime.day, sysEndTime.hour));
        self:set_deff_time();
        if self.updateTimer == 0 then
            self.updateTimer = timer.create(self.bindfunc["set_deff_time"], 1000 ,-1);
        end
    end

    self.grid = ngui.find_wrap_content(self.ui,"total_recharge_ui/center_other/animation/panel/wrap_content");
    self.grid:set_on_initialize_item(self.bindfunc["init_item"]);
    self.grid:set_min_index(0);
    self.grid:set_max_index(-1);
    self.grid:reset();
    self.gridScrollView = ngui.find_scroll_view(self.ui, "total_recharge_ui/center_other/animation/panel")

    msg_activity.cg_get_total_recharge_state();
end

function TotalRechargeUI:set_deff_time( )
    local diffSec = self.m_end_time - system.time();
    local day,hour,min,sec = TimeAnalysis.ConvertSecToDayHourMin(diffSec);
    self.lab_time:set_text("活动倒计时:"..day .. "天" .. string.format("%02d:", hour) .. string.format("%02d:", min) .. string.format("%02d", sec));   
    if diffSec <= 0 then
        if self.updateTimer ~= 0 then 
            timer.stop(self.updateTimer);
            self.updateTimer = 0;
        end
         self.lab_time:set_text("活动倒计时:0天00:00:00");
     --    uiManager:RemoveUi(EUI.ActivityUI);
        -- uiManager:ClearStack();
    end
end

function TotalRechargeUI:init_item(obj, b, real_id)
    -- app.log_warning("------------" .. b .. '|' .. real_id)
    local index = math.abs(real_id) + 1;
    local index_b = math.abs(b) + 1;

    local item_back_data = self.m_back_item_data[index];
    --local item_config_data = ConfigManager.Get(EConfigIndex.t_total_recharge, item_back_data.id);
    local task_type_config = ConfigManager.Get(EConfigIndex.t_activity_task_types, tonumber(item_back_data.task_type_id));    

    local sp_di = ngui.find_sprite(obj, "sp_di");
    sp_di:set_active(true);

    local sp_get = ngui.find_sprite(obj, "sp_art_font");

    local lab_num = ngui.find_label(obj, "lab_progress");
    local progress_num = tonumber(item_back_data.finish_progress);
    if progress_num > tonumber(item_back_data.finish_need) then
        progress_num = item_back_data.finish_need;      
    end
    lab_num:set_text(progress_num .. "/" .. item_back_data.finish_need);
    lab_num:set_active(true);
   
    -- 标题
    local title = ngui.find_label(obj, "lab")
    local str = string.format(_txt[2], item_back_data.finish_need);
    title:set_text(str)
   
    local btn_get = ngui.find_button(obj, "btn1");
    local btn_get_lab = ngui.find_label(obj, "btn1/lab"); 
    local btn2 = ngui.find_button(obj, "btn2")
    if btn2 then
        btn2:set_active(false);
    end
    btn_get:reset_on_click();
    if item_back_data.state == 2 then
		sp_get:set_active(false);
		-- btn_get_lab:set_text(_txt[3]);
  --       btn_get_lab:set_effect_color(198/255, 198/255, 198/255, 1);
        btn_get_lab:set_text("[C6C6C6FF]领取[-]");
		btn_get:set_event_value("0", item_back_data.id);
		btn_get:set_on_click(self.bindfunc["on_get_award"]);
		btn_get:set_sprite_names("ty_anniu5");
		lab_num:set_active(true);
        btn_get:set_active(false);
	elseif item_back_data.state == 1 then
		sp_get:set_active(false);
		lab_num:set_active(true);
        btn_get:set_active(true);
		-- btn_get_lab:set_text(_txt[3]);
  --       btn_get_lab:set_effect_color(150/255, 57/255, 0/255, 1);
        btn_get_lab:set_text("[5E2B91FF]领取[-]");
		btn_get:set_event_value("1", item_back_data.id);
		btn_get:set_on_click(self.bindfunc["on_get_award"]);
		btn_get:set_sprite_names("ty_anniu3");
	else
		sp_get:set_active(true);
		btn_get:set_active(false);
		lab_num:set_active(true);
	end

    if self.m_icon_list[index_b] == nil then
        self.m_icon_list[index_b] = {};
    end
    
    local small_card_item = nil;
    local carditem = nil;
    local award_item = nil;
    local award_list = Utility.lua_string_split(item_back_data.award_list, ",");
    for i = 1, 3 do
        small_card_item = obj:get_child_by_name("new_small_card_item" .. i);
        small_card_item:set_active(true);
        award_item = award_list[i];
        if award_item and award_item ~= "" then
            local signAwardList = Utility.lua_string_split(award_item, "#");
            carditem = CardProp:new({number = tonumber(signAwardList[1]), count = tonumber(signAwardList[2])});
            if self.m_icon_list[index_b][i] == nil then
                self.m_icon_list[index_b][i] = UiSmallItem:new({parent = small_card_item, cardInfo = carditem});
            else
                self.m_icon_list[index_b][i]:SetData(carditem);
            end
            self.m_icon_list[index_b][i]:SetCount(tonumber(signAwardList[2]));
            self.m_icon_list[index_b][i]:SetAsReward(signAwardList[3] and tonumber(signAwardList[3]) == 1);
            -- local fx = small_card_item:get_child_by_name("fx");
            -- fx:set_active(false);
            -- if signAwardList[3] and tonumber(signAwardList[3]) == 1 then
            --     fx:set_active(true);
            -- end
            
        else
            small_card_item:set_active(false);
        end            
    end
end


function TotalRechargeUI:UpdateRewardUI()
    --app.log_warning('------------HurdleRewardUI:UpdateRewardUI ')
    if self.grid == nil then return end
    self.grid:set_min_index(-#self.m_back_item_data + 1)
    self.grid:set_max_index(0)
    self.grid:reset()
    self.gridScrollView:reset_position()
end

function TotalRechargeUI:Restart(data)
    self:InitData(data)
    if UiBaseClass.Restart(self, data) then
        
    end
end

function TotalRechargeUI:on_get_award( t )
	if t.string_value == "1" then
		msg_activity.cg_get_total_recharge_award(t.float_value);
	end
end

function TotalRechargeUI:gc_back_total_recharge_state( start_time, end_time, vecStates )
	self.m_back_item_data = vecStates;
	local is_red_point_state = 0;
    for k,v in pairs(self.m_back_item_data) do
    	if v.state == 1 then
    		is_red_point_state = 1;
    		break;
    	end
    end
    g_dataCenter.activityReward:SetRedPointStateByActivityID(ENUM.Activity.activityType_recharge_total, is_red_point_state);
	app.log("------------- self.m_back_item_data:" .. table.tostring(self.m_back_item_data));
	table.sort( self.m_back_item_data, function( a, b )
		if a.state < b.state then
			return true;
		elseif a.state == b.state then
			return a.id < b.id;
		end
	end );
	self:UpdateRewardUI();
end

function TotalRechargeUI:gc_back_total_recharge_award( tId, award )
	-- local item_config_data = ConfigManager.Get(EConfigIndex.t_total_recharge, tId);
	-- local award = {};
	-- for k,v in pairs(item_config_data.award) do
	-- 	table.insert(award, {id = v.item_id, count = v.item_num});
	-- end
	CommonAward.Start(award);

	msg_activity.cg_get_total_recharge_state();
end