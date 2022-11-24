LoginBackRewardUI = Class("LoginBackRewardUI", UiBaseClass)

local _txt = {
	[1] = "累计登录送好礼";
	[2] = "登录[00FF73FF]%d[-]天,获得以下奖励";
	[3] = "领取";
    [4] = "活动日期:%d月%d日%02d:00~%d月%d日%02d:00";
}

function LoginBackRewardUI:Init(data)
    self.pathRes = "assetbundles/prefabs/ui/award/ui_1109_award.assetbundle";
    UiBaseClass.Init(self, data);
end

function LoginBackRewardUI:InitData(data)
    UiBaseClass.InitData(self, data);
    self.m_back_item_data = {};
    self.m_icon_list = {}
    self.smallItemUIs = {}
    self.m_end_time = 0;
    self.updateTimer = 0;
end

function LoginBackRewardUI:DestroyUi()
    
	-- 释放资源
    if self.smallItemUIs then
        for row, rowSmallItemUIs in pairs(self.smallItemUIs) do
            for col,smallItemUIs in pairs(rowSmallItemUIs) do
                for k,v in pairs(smallItemUIs) do
                    if v then
                        v:DestroyUi()
                        v = nil;
                    end
                end
                
            end
        
        end
        self.smallItemUIs = nil
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

function LoginBackRewardUI:RegistFunc()
	UiBaseClass.RegistFunc(self);
    self.bindfunc["init_item"] = Utility.bind_callback(self, self.init_item);
    self.bindfunc["on_get_award"] = Utility.bind_callback(self, self.on_get_award);
    self.bindfunc["on_click_head_detail"] = Utility.bind_callback(self, self.on_click_head_detail);

    self.bindfunc["gc_login_back_get_state"] = Utility.bind_callback(self, self.gc_login_back_get_state);
    self.bindfunc["gc_login_back_get_award"] = Utility.bind_callback(self, self.gc_login_back_get_award);

    self.bindfunc["set_deff_time"] = Utility.bind_callback(self, self.set_deff_time);
    
end

function LoginBackRewardUI:MsgRegist()
	PublicFunc.msg_regist("msg_activity.gc_login_back_get_state", self.bindfunc["gc_login_back_get_state"]);
	PublicFunc.msg_regist("msg_activity.gc_login_back_get_award", self.bindfunc["gc_login_back_get_award"]);
end

function LoginBackRewardUI:MsgUnRegist()
	PublicFunc.msg_unregist("msg_activity.gc_login_back_get_state", self.bindfunc["gc_login_back_get_state"]);
	PublicFunc.msg_unregist("msg_activity.gc_login_back_get_award", self.bindfunc["gc_login_back_get_award"]);
end

function LoginBackRewardUI:InitUI(asset_obj)
	UiBaseClass.InitUI(self, asset_obj)
	-- self.ui:set_parent(Root.get_root_ui_2d());
    self.ui:set_parent(Root.get_root_ui_2d():get_child_by_name("activity_ui"));
	self.ui:set_name("login_back_award_ui");
	self.ui:set_local_scale(1,1,1);
	self.ui:set_local_position(0,0,0);

    self.lab_big_title = ngui.find_label(self.ui, "center_other/animation/content/lab_big_title");
    if self.lab_big_title then
        self.lab_big_title:set_text(_txt[1]);
    end

    self.sp_di = ngui.find_sprite(self.ui, "center_other/animation/sp_di");
    self.sp_di:set_active(false);
    self.sp_mark = ngui.find_sprite(self.ui, "center_other/animation/sp_mark");
    self.sp_mark:set_active(false);
    -- self.sp_bk = ngui.find_sprite(self.ui, "hurdle_reward_ui/center_other/animation/sp_bk");
    -- self.sp_bk:set_active(false);
    
    self.contentPath = "center_other/animation/content/";
    self.sp_art_font = ngui.find_sprite(self.ui, self.contentPath .. "sp_art_font");
    if self.sp_art_font then
        self.sp_art_font:set_sprite_name("hd_biaoti_chongzhi");
    end

    self.sp_art_font1 = ngui.find_sprite(self.ui, self.contentPath .. "cont2/sp_art_font");
    if self.sp_art_font1 then
    	self.sp_art_font1:set_active(false);
    end

    self.m_play_config = ConfigManager.Get(EConfigIndex.t_activity_play, ENUM.Activity.activityType_login_award_back_time);
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
    local t_info = tostring(self.m_play_config.activity_info);
    if t_info == "0" or t_info == "nil" then
        t_info = "";
    end
    self.lab_title1:set_text(t_info);

    self.lab_title2 = ngui.find_label(self.ui, self.contentPath .. "lab_title2");
    self.lab_title2:set_active(false);

    if self.m_play_config and tostring(self.m_play_config.activity_name) ~= "0" and tostring(self.m_play_config.activity_name) ~= "nil" then
        self.lab_title2:set_active(true);
        self.lab_title2:set_text(tostring(self.m_play_config.activity_name));
    end

    self.sp_clock = ngui.find_sprite(self.ui, self.contentPath .. "sp_clock");
    if self.sp_clock then
        self.sp_clock:set_active(false);
    end
    self.lab_time = ngui.find_label(self.ui, self.contentPath .. "lab_time");
    self.lab_time:set_text("");

    self.sp_shuaxin = ngui.find_sprite(self.ui, "animation/content/sp_shuaxin");

    local activityTime = g_dataCenter.activityReward:GetActivityTimeForActivityID(ENUM.Activity.activityType_login_award_back_time);
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

    self.grid = ngui.find_wrap_content(self.ui,"center_other/animation/panel/wrap_content");
    self.grid:set_on_initialize_item(self.bindfunc["init_item"]);
    self.grid:set_min_index(0);
    self.grid:set_max_index(-1);
    self.grid:reset();
    self.gridScrollView = ngui.find_scroll_view(self.ui, "center_other/animation/panel")

    msg_activity.cg_login_back_get_state();
end

function LoginBackRewardUI:set_deff_time( )
    local diffSec = self.m_end_time - system.time();
    local day,hour,min,sec = TimeAnalysis.ConvertSecToDayHourMin(diffSec);
    self.lab_time:set_text("活动倒计时:"..day .. "天" .. string.format("%02d:", hour) .. string.format("%02d:", min) .. string.format("%02d", sec));   
    if diffSec <= 0 then
        if self.updateTimer ~= 0 then 
            timer.stop(self.updateTimer);
            self.updateTimer = 0;
        end
     --    uiManager:RemoveUi(EUI.ActivityUI);
        -- uiManager:ClearStack();
    end
end

function LoginBackRewardUI:init_item(obj, b, real_id)
    -- app.log_warning("------------" .. b .. '|' .. real_id)
    local index = math.abs(real_id) + 1;
    local index_b = math.abs(b) + 1;

    local item_back_data = self.m_back_item_data[index];
    -- local task_type_config = ConfigManager.Get(EConfigIndex.t_activity_task_types, tonumber(item_back_data.id));   
    local config_data =  ConfigManager.Get(EConfigIndex.t_login_reward_back, tonumber(item_back_data.id));   

    local sp_di = ngui.find_sprite(obj, "sp_di");
    sp_di:set_active(true);

    local sp_get = ngui.find_sprite(obj, "sp_art_font");

    local lab_num = ngui.find_label(obj, "lab_progress");
    local progress_num = tonumber(item_back_data.progress);
    if progress_num > tonumber(config_data.times) then
        progress_num = config_data.times;
    end
    lab_num:set_text(progress_num .. "/" .. config_data.times);
    lab_num:set_active(true);
   
    -- 标题
    local title = ngui.find_label(obj, "lab")
    local str = string.format(_txt[2], config_data.times);
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
        -- btn_get_lab:set_effect_color(95/255, 95/255, 95/255, 1);
		-- btn_get:set_event_value("0", item_back_data.id);
		-- btn_get:set_on_click(self.bindfunc["on_get_award"]);
		-- btn_get:set_sprite_names("ty_anniu5");
		lab_num:set_active(true);
        btn_get:set_active(false);
	elseif item_back_data.state == 1 then
		sp_get:set_active(false);
		lab_num:set_active(true);
		-- btn_get_lab:set_text(_txt[3]);
        -- btn_get_lab:set_effect_color(174/255, 65/255, 40/255, 1);
        btn_get_lab:set_text("[973900FF]领取[-]");
		btn_get:set_event_value("1", item_back_data.id);
		btn_get:set_on_click(self.bindfunc["on_get_award"]);
		btn_get:set_sprite_names("ty_anniu3");
        btn_get:set_active(true);
	else
		sp_get:set_active(true);
		btn_get:set_active(false);
		lab_num:set_active(true);
	end

    local needCnt = #config_data.award;
    local items = {}

    local pathPre = "new_small_card_item"
    for i = 1, 3 do
        items[i] = obj:get_child_by_name(pathPre .. i)
        items[i]:set_active(i <= needCnt)
    end

    local rowName = obj:get_name()
    self.smallItemUIs[rowName] = self.smallItemUIs[rowName] or {}
    -- »ñÈ¡itemsÕ¹Ê¾ÄÚÈÝ
    -- app.log("index = "..tonumber(index).." rewardItems = \n"..table.tostring(reward.rewardItems));
    for k, v in ipairs(config_data.award) do
        local id = v.item_id
        local num = v.item_num
        local light = v.is_line

        if items[k] == nil then
            break
        end
        local newItem = items[k]
        local colName = newItem:get_name()
        local smallItemUI = nil;

        if self.smallItemUIs[rowName][colName] == nil then
            self.smallItemUIs[rowName][colName] = {};
        end

        if PropsEnum.IsItem(id) then 
            if self.smallItemUIs[rowName][colName][1] == nil then
                self.smallItemUIs[rowName][colName][1] = UiSmallItem:new({obj=nil, parent = newItem, cardInfo = nil, delay = 500});
            end
            self.smallItemUIs[rowName][colName][1]:Show();
            self.smallItemUIs[rowName][colName][1]:SetDataNumber(id, num);
            self.smallItemUIs[rowName][colName][1]:SetEnablePressGoodsTips(true);
            self.smallItemUIs[rowName][colName][1]:SetAsReward(light==1);

            if self.smallItemUIs[rowName][colName][2] then
                self.smallItemUIs[rowName][colName][2]:Hide();
            end            
        elseif PropsEnum.IsRole(id) then
            if self.smallItemUIs[rowName][colName][2] == nil then
                self.smallItemUIs[rowName][colName][2] = SmallCardUi:new({parent = newItem, info = CardHuman:new({number = tonumber(id)}), stypes = {1,6,9}});
            end
            self.smallItemUIs[rowName][colName][2]:Show();
            self.smallItemUIs[rowName][colName][2]:SetDataNumber(id, num);
            self.smallItemUIs[rowName][colName][2]:SetCallback(self.bindfunc["on_click_head_detail"])
            self.smallItemUIs[rowName][colName][2]:SetAsReward(true)
            -- self.smallItemUIs[rowName][colName][2]:SetRewardEffectScale(0.42, 0.42, 0.42)
            self.smallItemUIs[rowName][colName][2]:SetAsReward(light==1);
            -- light = 0

            -- self.smallItemUIs[rowName][colName][2]:SetEnablePressGoodsTips(true);

            if self.smallItemUIs[rowName][colName][1] then
                self.smallItemUIs[rowName][colName][1]:Hide();
            end     



   --          if self.smallItemUIs[rowName][colName][2] then
   --               smallItemUI = self.smallItemUIs[rowName][colName][2]
   --          end
            -- -- if smallItemUI and  smallItemUI._className == "UiSmallItem" then 
            -- --   smallItemUI:DestroyUi();
            -- --   smallItemUI = nil;
            -- -- end
   --          if self.smallItemUIs[rowName][colName][1] then
   --              self.smallItemUIs[rowName][colName][1]:Hide();
   --          end

            -- if smallItemUI == nil then
            --  smallItemUI = SmallCardUi:new({parent = newItem, info = CardHuman:new({number = tonumber(id)}), stypes = {1,6,9}});
   --              smallItemUI:Show();
            --  self.smallItemUIs[rowName][colName][2] = smallItemUI
            -- else 
            --  smallItemUI:SetDataNumber(tonumber(id));
            -- end 
   --          smallItemUI:SetCallback(self.bindfunc["on_click_head_detail"])
        else    
            if self.smallItemUIs[rowName][colName][1] == nil then
                self.smallItemUIs[rowName][colName][1] = UiSmallItem:new({obj=nil, parent = newItem, cardInfo = nil, delay = 500});
            end
            self.smallItemUIs[rowName][colName][1]:Show();
            self.smallItemUIs[rowName][colName][1]:SetDataNumber(id, num);
            self.smallItemUIs[rowName][colName][1]:SetEnablePressGoodsTips(true);
            self.smallItemUIs[rowName][colName][1]:SetAsReward(light==1);

            if self.smallItemUIs[rowName][colName][2] then
                self.smallItemUIs[rowName][colName][2]:Hide();
            end     
        end

        
--        -- Ôö¼ÓpressÊÂ¼þ
--        local btn = ngui.find_button(newItem, "sp_back")
--        local bc = ButtonClick:new({obj = btn})
--        bc:SetPress(GoodsTips.BCShow, {id = id, count=num});
--        -- moveÊ±¹Ø±Õtips
--        btn:set_on_ngui_drag_move("GoodsTips.BCHidden")

--        if PublicFunc.IdToConfig(id) ~= nil then
--            local iconPath = PublicFunc.IdToConfig(id).small_icon;
--            if iconPath ~= nil then
--                self.textures[row][k]:set_texture(iconPath)
--            end
--        end

        -- ¸ßÁÁÌØÐ§
        -- local effect = ngui.find_sprite(newItem, "fx/sp_fx");
        -- local effect = newItem:get_child_by_name("fx_checkin_month_right");
        -- if effect then
        --     effect:set_active(light == 1)
        -- end

--        local shine  = ngui.find_sprite(newItem, "sp_back/human/sp_shine")
--        shine:set_active(false)
--        local mark  = ngui.find_sprite(newItem, "sp_back/sp_mark")
--        mark:set_active(false)


        -- ÉèÖÃÍâ¿òÑÕÉ«
        -- if smallItemUI.SetFrame ~= nil then 
        --  local frameName = self.reward:GetIconFrame(id, num)
        --  smallItemUI:SetFrame(frameName)
        -- end 
--        -- ÉèÖÃÍâ¿òÑÕÉ«
--        local frame = ngui.find_sprite(newItem, "sp_back/sp_frame")
--        self.reward:setIconFrame(frame, id, num)

--        -- ÊýÁ¿
--        label = ngui.find_label(newItem, "sp_back/lab")
--        label:set_text('x ' .. num)
    end
end


function LoginBackRewardUI:UpdateRewardUI()
    --app.log_warning('------------HurdleRewardUI:UpdateRewardUI ')
    app.log("self.m_back_item_data:" .. table.tostring(self.m_back_item_data))
    if self.grid == nil then return end
    self.grid:set_min_index(-#self.m_back_item_data + 1)
    self.grid:set_max_index(0)
    self.grid:reset()
    self.gridScrollView:reset_position()
end

function LoginBackRewardUI:Restart(data)
    self:InitData(data)
    if UiBaseClass.Restart(self, data) then
        
    end
end

function LoginBackRewardUI:on_click_head_detail( cardUI )
    app.log("--------------- 点击头像" .. tostring(cardUI.cardInfo.number));
    RecruitDetalUI:new(cardUI.cardInfo.number);
end

function LoginBackRewardUI:on_get_award( t )
	if t.string_value == "1" then
		msg_activity.cg_login_back_get_award(t.float_value);
	end
end

function LoginBackRewardUI:gc_login_back_get_state(  vecStates )
	self.m_back_item_data = vecStates;
	local is_red_point_state = 0;
    for k,v in pairs(self.m_back_item_data) do
    	if v.state == 1 then
    		is_red_point_state = 1;
    		break;
    	end
    end
    g_dataCenter.activityReward:SetRedPointStateByActivityID(ENUM.Activity.activityType_login_award_back_time, is_red_point_state);
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

function LoginBackRewardUI:gc_login_back_get_award( award )
	CommonAward.Start(award);

	msg_activity.cg_login_back_get_state();
end