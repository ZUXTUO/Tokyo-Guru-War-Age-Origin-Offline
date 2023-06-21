SevenSignBackUi = Class('SevenSignBackUi', UiBaseClass);

local _text = {
	[1] = "领取";
	[2] = "前往";
	[3] = "未达到任务条件,不可领取";
	[4] = "活动开启后第%s日开启";
	[5] = "[2F3041FF]已完成[-][00FF73FF]%s[-][2F3041FF]/%s[-]";
}

local _yeka_altlas_name = {
	[1] = "kf_diyi";
	[2] = "kf_dier";
	[3] = "kf_disan";
	[4] = "kf_disi";
	[5] = "kf_diwu";
}

function SevenSignBackUi:Init(data)
	self.pathRes = "assetbundles/prefabs/ui/sign/ui_5101_kai_fu.assetbundle";
	-- self.pathRes = "assetbundles/prefabs/ui/sign/ui_200_checkin_month.assetbundle";
	UiBaseClass.Init(self, data);
end

function SevenSignBackUi:Restart()
	if self.current_type1 and self.current_type2 then
		-- msg_sign_in.cg_request_task_list_back(self.current_type1, self.current_type2);
	end
    if UiBaseClass.Restart(self, data) then
	--todo 
	end
end

function SevenSignBackUi:InitData(data)
	UiBaseClass.InitData(self, data);
	
	self.config_all_data = {};

	self.type1_num = 0;
	self.config_data_type1 = {};

	self.current_type2_num = 0;
	self.current_type2_item_data = {};
	self.current_config_type2 = {};

	self.current_type1 = 1;
	self.current_type2 = 1;

	self.m_current_back_data = {};

	self.listItems = {};
	self.m_task_data = {};
	self.m_item_list = {};
	self.m_type1_item_ui = {};

	self.updateTimer = 0;
	self.m_start_time = 0;
	self.m_end_time = 0;
end

function SevenSignBackUi:DestroyUi()
    
	self.listItems = {};

	for k,v in pairs(self.m_item_list) do
		if v then
			for k1,v1 in pairs(v) do
				if v1 then
					v1:DestroyUi();
					v1 = nil;
				end
			end
			v = nil;
		end
	end
	self.m_item_list = {};

	if self.updateTimer ~= 0 then 
        timer.stop(self.updateTimer);
        self.updateTimer = 0;
    end

	if self.sp_title1_texture then
		self.sp_title1_texture:clear_texture();
	end

   UiBaseClass.DestroyUi(self);
end

function SevenSignBackUi:Show()
	if UiBaseClass.Show(self) then
		if self.current_type1 == 0 then
			self.current_type1 = 1;
		end
		if self.current_type2 == 0 then
			self.current_type2 = 1;
		end
		msg_sign_in.cg_request_task_list_back(self.current_type1, self.current_type2);
	end
end

function SevenSignBackUi:Hide()
    if UiBaseClass.Hide(self) then
	    
	end
end

function SevenSignBackUi:RegistFunc()
	UiBaseClass.RegistFunc(self);

	self.bindfunc["on_set_list_by_data"] = Utility.bind_callback(self, self.on_set_list_by_data);
	self.bindfunc["on_award_back"] = Utility.bind_callback(self, self.on_award_back);
   	
   	self.bindfunc["on_close"] = Utility.bind_callback(self, self.on_close);

   	self.bindfunc["on_switch_right_type1"] = Utility.bind_callback(self, self.on_switch_right_type1);
   	self.bindfunc["on_switch_top_type2"] = Utility.bind_callback(self, self.on_switch_top_type2);
   	self.bindfunc["init_item_wrap_content"] = Utility.bind_callback(self, self.init_item_wrap_content);

   	self.bindfunc["on_btn_click"] = Utility.bind_callback(self, self.on_btn_click);
   	self.bindfunc["on_btn_mu_biao_click"] = Utility.bind_callback(self, self.on_btn_mu_biao_click);

   	self.bindfunc["set_deff_time"] = Utility.bind_callback(self, self.set_deff_time);
   	self.bindfunc['SetUpdateUi'] = Utility.bind_callback(self, self.SetUpdateUi);

   	self.bindfunc["on_get_back_data"] = Utility.bind_callback(self, self.on_get_back_data);
   	self.bindfunc["gc_set_point_states"] = Utility.bind_callback(self, self.UpdateRedPoint);
end

function SevenSignBackUi:UnRegistFunc()
    UiBaseClass.UnRegistFunc(self);
end

--注册消息分发回调函数
function SevenSignBackUi:MsgRegist()
	UiBaseClass.MsgRegist(self);

    PublicFunc.msg_regist(msg_sign_in.gc_task_list_back, self.bindfunc["on_set_list_by_data"]);
    PublicFunc.msg_regist(msg_sign_in.gc_get_award_back, self.bindfunc["on_award_back"]);
    PublicFunc.msg_regist(msg_sign_in.gc_set_point_back, self.bindfunc['SetUpdateUi'])

    PublicFunc.msg_regist(msg_sign_in.gc_total_state_back, self.bindfunc["on_get_back_data"]);
    PublicFunc.msg_regist(msg_sign_in.gc_set_point_states_back, self.bindfunc["gc_set_point_states"]);
end

--注销消息分发回调函数
function SevenSignBackUi:MsgUnRegist()
	UiBaseClass.MsgUnRegist(self);
    
    PublicFunc.msg_unregist(msg_sign_in.gc_task_list_back, self.bindfunc["on_set_list_by_data"]);
    PublicFunc.msg_unregist(msg_sign_in.gc_get_award_back, self.bindfunc["on_award_back"]);
    PublicFunc.msg_unregist(msg_sign_in.gc_set_point_back, self.bindfunc['SetUpdateUi'])

    PublicFunc.msg_unregist(msg_sign_in.gc_total_state_back, self.bindfunc["on_get_back_data"]);
    PublicFunc.msg_unregist(msg_sign_in.gc_set_point_states_back, self.bindfunc["gc_set_point_states"]);
end


function SevenSignBackUi:InitUI(asset_obj)
	UiBaseClass.InitUI(self, asset_obj)
	self.ui:set_parent(Root.get_root_ui_2d());
	self.ui:set_name("seven_sign_Ui");
	self.ui:set_local_scale(Utility.SetUIAdaptation());
	self.ui:set_local_position(0,0,0);
	
	self.sp_title1_texture = ngui.find_texture(self.ui, "center_other/animation/content/sp_title1")
	self.sp_title1_texture:set_texture("assetbundles/prefabs/ui/image/backgroud/kai_fu/jrkh_wenzidiban.assetbundle");

    self.close_btn = ngui.find_button(self.ui, "center_other/animation/sp_di/btn_cha");
    self.close_btn:set_on_click(self.bindfunc["on_close"]);

    -- self.lab_art_font1 = ngui.find_label(self.ui, "seven_sign_Ui/center_other/animation/content/lab_art_font1");
    -- self.lab_art_font1:set_text(tostring(0));
    self.lab_time = ngui.find_label(self.ui, "center_other/animation/content/lab_title2");

    self.btn_mu_biao = ngui.find_button(self.ui, "center_other/animation/btn_qu_mu_biao");
    self.btn_mu_biao:set_on_click(self.bindfunc["on_btn_mu_biao_click"]);

    self.scroll_view = ngui.find_scroll_view(self.ui, "center_other/animation/panel");
    self.wrap_content = ngui.find_wrap_content(self.ui, "center_other/animation/panel/wrap_content");
    self.wrap_content:set_on_initialize_item(self.bindfunc["init_item_wrap_content"]);
    self.wrap_content:set_min_index(0);
    self.wrap_content:set_max_index(-1);
    self.wrap_content:reset();

    self.current_type1 = 1;
    self.current_type2 = 1;

    --初始本地数据
    self.config_all_data = ConfigManager._GetConfigTable(EConfigIndex.t_sign_in_7_back);
    self:InitType1Config(); 

    self:refeshCurrentType2ConfigByType1(self.current_type1);

    self.m_type1_item_ui = {};
    -- 右边页卡UI
    local basePath = "seven_sign_Ui/center_other/animation/yeka_left/";
    self.yeka_right = self.ui:get_child_by_name("seven_sign_Ui/center_other/animation/yeka_left");
    self.yeka_grid = ngui.find_grid(self.ui, "seven_sign_Ui/center_other/animation/yeka_left");
    self.yeka_obj = self.ui:get_child_by_name(basePath .. "yeka1");

    local yekaText = ngui.find_label(self.ui, basePath .. "yeka" .. 1 .. "/lab");
	yekaText:set_text(self.config_data_type1[1][1].type1_name);
	local suo = ngui.find_sprite(self.yeka_obj,"sp_suo")
	suo:set_active(false)
	local yekaText2 = ngui.find_label(self.ui, basePath .. "yeka" .. 1 .. "/lab1");
	yekaText2:set_text(self.config_data_type1[1][1].type1_name);
    self.m_type1_item_ui[1] = self.yeka_obj ;
    local sp_point = ngui.find_sprite(self.ui, basePath .. "yeka" .. 1 .. "/sp_spint");
    sp_point:set_active(g_dataCenter.signin:GetRedPointStateByType1_back(1));
    local yeka_clone = nil;
    for i = 2, 5 do
    	if i <= self.type1_num then
    		yeka_clone = self.yeka_obj:clone();
    		yeka_clone:set_name("yeka" .. i);
    		self.m_type1_item_ui[i] = yeka_clone;
   
			yekaText = ngui.find_label(self.ui, basePath .. "yeka" .. i .. "/lab");
			yekaText:set_text(self.config_data_type1[i][1].type1_name);
			yekaText2 = ngui.find_label(self.ui, basePath .. "yeka" .. i .. "/lab1");
			yekaText2:set_text(self.config_data_type1[i][1].type1_name);
			suo = ngui.find_sprite(self.ui,basePath.."yeka"..i.."/sp_suo");
			suo:set_active(true)
			sp_point = ngui.find_sprite(self.ui, basePath .. "yeka" .. i .. "/sp_spint");
			sp_point:set_active(g_dataCenter.signin:GetRedPointStateByType1_back(i));

			-- yekaBtn:set_on_click(self.bindfunc["on_switch_right_type1"]);
			-- yekaBtn:set_event_value("", i);

			-- 默认指向第一个页卡
			-- yekaToggle:set_value(i == self.current_type1);
    	end
	end
	self.yeka_grid:reposition_now();

	self:UpdateCurrentType1Button(self.current_type1);
	self:UpdateUIToType2();

	self.m_total_progress_txt = ngui.find_label(self.ui, "center_other/animation/lab_jindu");
	if self.m_total_progress_txt then
		self.m_total_progress_txt:set_text("");
	end

	msg_sign_in.cg_request_task_list_back(self.current_type1, self.current_type2);
	-- msg_sign_in.cg_get_award_back(90000001);

	-- self:set_deff_time();
	msg_sign_in.cg_request_total_state_back();
end

function SevenSignBackUi:UpdateCurrentType1Button( p_index )
	local sp_san_jiao = nil;
	local yekaText = nil;
	local yekaText2 = nil;
	local sp_point = nil;
	local sp_liang = nil;
	local sp_bg = nil;
	for k,v in pairs(self.m_type1_item_ui) do
		--sp_san_jiao = ngui.find_label(self.yeka_right, "yeka" .. k.."/lab1/lab_arrows");
		yekaText = ngui.find_label(self.yeka_right, "yeka" .. k .. "/lab");
		yekaText2 = ngui.find_label(self.yeka_right, "yeka" .. k .. "/lab1");
		sp_point = ngui.find_sprite(self.yeka_right, "yeka" .. k .. "/sp_spint");
		sp_point:set_active(g_dataCenter.signin:GetRedPointStateByType1_back(k));
		-- sp_liang = ngui.find_sprite(self.yeka_right, "yeka" .. k .. "/sp_liang");
		sp_bg1 = ngui.find_sprite(self.yeka_right, "yeka" .. k .. "/sp1");
		sp_bg2 = ngui.find_sprite(self.yeka_right, "yeka" .. k .. "/sp2");
		sp_suo = ngui.find_sprite(self.yeka_right,"yeka" .. k .. "/sp_suo")
		if p_index == tonumber(k) then
			--sp_san_jiao:set_active(true);
			yekaText:set_active(false);
			yekaText2:set_active(true);
			-- sp_liang:set_sprite_name("kf_anniudian");
			sp_bg1:set_active(true)
			sp_bg2:set_active(false)
		else
			--sp_san_jiao:set_active(false);
			yekaText:set_active(true);
			yekaText2:set_active(false);
			-- sp_liang:set_sprite_name("kf_anniu");

			sp_bg1:set_active(false)
			sp_bg2:set_active(true)

			if self.m_day then
				app.log("self.m_day:" .. self.m_day .. "--k:" .. tostring(k));
			end
			if self.m_day and tonumber(k) > self.m_day then
				--sp_bg:set_sprite_name("hd_yeqian3");
				-- sp_bg1:set_active(false)
				-- sp_bg2:set_active(true)
				sp_suo:set_active(true)
			else
				--sp_bg:set_sprite_name("hd_yeqian2");
				-- sp_bg1:set_active(true)
				-- sp_bg2:set_active(false)
				sp_suo:set_active(false)
			end
		end
	end
end

function SevenSignBackUi:UpdateUiForBackData()

	for k,v in pairs(self.m_item_list) do
		if v then
			for k1,v1 in pairs(v) do
				if v1 then
					v1:DestroyUi();
					v1 = nil;
				end
			end
			v = nil;
		end
	end
	self.m_item_list = {};

	local index_num = 0;
	self.m_task_data = {};
	local temp_get_award_data_1 = {};
	local temp_get_award_data_2 = {};
	local temp_get_award_data_3 = {};
	local is_state = 0;
	for bk, vb in pairs(self.m_current_back_data) do
		index_num = index_num + 1;
		if vb.task_state == 1 then
			table.insert(temp_get_award_data_1, vb);
			if is_state == 0 then
				is_state = 1;
			end
		elseif vb.task_state == 0 then
			table.insert(temp_get_award_data_2, vb);
		else
			table.insert(temp_get_award_data_3, vb);
		end
	end
	
	g_dataCenter.signin:SetRedPoint_back(is_state == 1);

	if #temp_get_award_data_1 > 0 then
		for k,v in pairs(temp_get_award_data_1) do
			table.insert(self.m_task_data, v);
		end
	end

	if #temp_get_award_data_2 > 0 then
		for k,v in pairs(temp_get_award_data_2) do
			table.insert(self.m_task_data, v);
		end
	end

	if #temp_get_award_data_3 > 0 then
		for k,v in pairs(temp_get_award_data_3) do
			table.insert(self.m_task_data, v);
		end
	end

	-- app.log("---------- index_num:" .. index_num);
	self.listItems = {};
	self.wrap_content:set_min_index(-index_num + 1);
    self.wrap_content:set_max_index(0);
    self.wrap_content:reset();
    self.scroll_view:reset_position();
end

function SevenSignBackUi:init_item_wrap_content( obj, b, real_id )
	-- app.log("init_item_wrap_content:" .. b .. "--" .. real_id);
	local index = math.abs(real_id) + 1;
	local index_b = math.abs(b) + 1;

	app.log("index:" .. index_b)

	if #self.m_task_data <= 0 or #self.current_type2_item_data <=0 then
 		return;
 	end

	if self.listItems[index] == nil then
        self.listItems[index] = obj;
    end

    local item_back_data = self.m_task_data[index];
    if not item_back_data then
    	do return; end
    end
    -- local item_config_data = self.current_type2_item_data[index];
    local item_config_data = ConfigManager.Get(EConfigIndex.t_sign_in_7_back, item_back_data.task_id);

    if not item_config_data then
    	return;
    end

    local item_tittle = ngui.find_label(obj, "txt");
    item_tittle:set_text(tostring(item_config_data.task_name));
    local lab_num = ngui.find_label(obj, "lab_number");
    if item_config_data.lock_type == 6 
    	or item_config_data.lock_type == 27
    		or item_config_data.lock_type == 28
    			or item_config_data.lock_type == 35
    				or item_config_data.lock_type == 36 then
    	lab_num:set_text(item_back_data.task_times .. "/" .. item_config_data.lock_params1);
    else
    	lab_num:set_text(item_back_data.task_times .. "/" .. item_config_data.times);
    end

    if self.m_item_list[index_b] == nil then
    	self.m_item_list[index_b] = {};
    end

    local item_award_data = item_config_data.award_items;
    local item_award_num = #item_award_data;
    local small_card_item = nil;
    local itemNum = 1;
    for i=1,4 do
    	small_card_item = obj:get_child_by_name("grid/new_small_card_item" .. i);
    	if i <= item_award_num then
    		small_card_item:set_active(true);
    		itemNum = item_award_data[i].item_num;
    		local carditem = CardProp:new({number = item_award_data[i].item_id});
    		if self.m_item_list[index_b][i] == nil then
	    		self.m_item_list[index_b][i] = UiSmallItem:new({parent = small_card_item, cardInfo = carditem});
	    	else
	    		self.m_item_list[index_b][i]:SetData(carditem);
	    	end
	    	self.m_item_list[index_b][i]:SetCount(itemNum);
	    	-- self.m_item_list[index_b][i]:SetLabNum(true);
	    	-- self.m_item_list[index_b][i]:SetNumberStr(tostring(itemNum));
	    	self.m_item_list[index_b][i]:SetAsReward(item_award_data[i].item_line and item_award_data[i].item_line == 1)
	    	-- local fx = small_card_item:get_child_by_name("fx");
	    	-- if item_award_data[i].item_line and item_award_data[i].item_line == 1 then
	    	-- 	fx:set_active(true);
	    	-- else
	    	-- 	fx:set_active(false);
	    	-- end
    	else
    		small_card_item:set_active(false);
    	end
    end

    local get_button = ngui.find_button(obj, "btn1");
    get_button:reset_on_click();
    get_button:set_on_click(self.bindfunc["on_btn_click"]);

    local btn2 = ngui.find_button(obj, "btn2");
    if btn2 then
    	btn2:set_active(false);
    end

    local get_btn_lab = ngui.find_label(obj, "btn1/animation/lab");
    local get_btn_bg = ngui.find_sprite(obj,"btn1/animation/sp")
    local sp_get = ngui.find_sprite(obj, "sp_get");
    
    if item_back_data.task_state == 0 then
    	get_button:set_active(true);
    	sp_get:set_active(false);
    	lab_num:set_active(true);
    	
    	if tonumber(item_config_data.button_type) == 0 then -- 灰
    		-- get_btn_lab:set_text(_text[1]);
    		-- get_btn_lab:set_effect_color(95/255, 95/255, 95/255, 1);
    		get_btn_lab:set_text("[C6C6C6FF]领取[-]")
    		get_btn_bg:set_sprite_name("ty_anniu5");
    		get_button:set_event_value(tostring(item_back_data.task_id), 3);
    	else
    		-- get_btn_lab:set_text(_text[2]);
    		-- get_btn_lab:set_color(60/255, 75/255, 143/255, 1);
    		get_btn_lab:set_text("[3C4B8FFF]前往[-]");
    		get_btn_bg:set_sprite_name("ty_anniu4");
    		get_button:set_event_value(tostring(item_config_data.system_enter_id), 0);
    	end

	elseif item_back_data.task_state == 1 then
		get_button:set_active(true);
    	sp_get:set_active(false);
    	lab_num:set_active(false);
    	-- get_btn_lab:set_text(_text[1]);
    	-- get_btn_lab:set_color(140/255, 66/255, 19/255, 1);
    	get_btn_lab:set_text("[973900FF]领取[-]");
    	get_btn_bg:set_sprite_name("ty_anniu3");
		get_button:set_event_value(tostring(item_back_data.task_id), 1);
    	
	elseif item_back_data.task_state == 2 then
		get_button:set_active(false);
    	sp_get:set_active(true);
    	lab_num:set_active(false);
		get_button:set_event_value(tostring(item_back_data.task_id), 2);
    	
	end
end

function SevenSignBackUi:UpdateUIToType2( )
	-- 左边页卡
	basePath = "seven_sign_Ui/center_other/animation/yeka_top/";
	for i = 1, 3 do
    	local yeka_obj = self.ui:get_child_by_name(basePath .. "yeka" .. i);
    	if i <= self.current_type2_num then
    		yeka_obj:set_active(true);
    		local yekaBtn = ngui.find_button(self.ui, basePath .. "yeka" .. i);
			local yekaToggle = ngui.find_toggle(self.ui, basePath .. "yeka" .. i);
			local yekaText = ngui.find_label(self.ui, basePath .. "yeka" .. i .. "/lab1");
			local yekaText2 = ngui.find_label(self.ui, basePath .. "yeka" .. i .. "/lab_hui");
			yekaText:set_text(self.current_config_type2[i][1].type2_name or " ");
			yekaText2:set_text(self.current_config_type2[i][1].type2_name or " ");
			yekaBtn:set_on_click(self.bindfunc["on_switch_top_type2"], "MyButton.NoneAudio");
			yekaBtn:set_event_value("", i);

			-- 默认指向第一个页卡
			yekaToggle:set_value(i == self.current_type2);

			local sp_point = ngui.find_sprite(self.ui, basePath .. "yeka" .. i .. "/sp_point");
			sp_point:set_active(g_dataCenter.signin:GetRedPointStateByType1AndType2_back(self.current_type1, i));
		else
			yeka_obj:set_active(false);
    	end
	end
end

function SevenSignBackUi:InitType1Config( )
	self.config_data_type1 = {};
    local type1 = 0;
    for k,v in pairs(self.config_all_data) do
    	if type1 ~= v.type1 then
    		type1 = v.type1;
    	end

    	if self.config_data_type1[type1] == nil then
    		self.config_data_type1[type1] = {};
    	end

    	table.insert(self.config_data_type1[type1], v); 
    end
    if #self.config_data_type1 >= 5 then
    	self.type1_num = 5;
    else
    	self.type1_num = #self.config_data_type1;
    end

    -- app.log("----" .. self.type1_num .. "--" .. table.tostring(self.config_data_type1));
end

function SevenSignBackUi:refeshCurrentType2ConfigByType1( type1 )
    -- 左边小类
    local c_Config_type1 = self.config_data_type1[type1];
    if c_Config_type1 then
    	self.current_config_type2 = {};
    	local type2 = 0;
    	for k,v in pairs(c_Config_type1) do
	    	if type2 ~= v.type2 then
	    		type2 = v.type2;
	    	end
	    	if self.current_config_type2[type2] == nil then
	    		self.current_config_type2[type2] = {};
	    	end
	    	table.insert(self.current_config_type2[type2], v);
	    end
	    self.current_type2_num = #self.current_config_type2;

	    self.current_type2_item_data = self.current_config_type2[self.current_type2];

	 --    table.sort(self.current_type2_item_data, function ( a, b )
		-- 	return a.task_id < b.task_id;
		-- end);
    end


end


function SevenSignBackUi:on_switch_right_type1( t )
	if t.string_value == "1" then
		if self.current_type1 == t.float_value then
			return
		end
		self.current_type1 = t.float_value;
	-- app.log("--------- self.current_type1:" .. self.current_type1 .. "--self.current_type2:" .. self.current_type2);
		self.current_type2 = 1; -- 切换大标签，小标签重置为1
		self:UpdateCurrentType1Button(self.current_type1);
		self:refeshCurrentType2ConfigByType1(self.current_type1);
		self:UpdateUIToType2();

		msg_sign_in.cg_request_task_list_back(self.current_type1, self.current_type2);
		AudioManager.PlayUiAudio(ENUM.EUiAudioType.Flag);
	else
		FloatTip.Float(string.format(_text[4], t.float_value));
		AudioManager.PlayUiAudio(ENUM.EUiAudioType.MainBtn);
	end
end

function SevenSignBackUi:on_switch_top_type2( t )
	if self.current_type2 == t.float_value then
		return
	end
	AudioManager.PlayUiAudio(ENUM.EUiAudioType.Flag);
	self.current_type2 = t.float_value;
	-- app.log("--------- self.current_type1:" .. self.current_type1 .. "--self.current_type2:" .. self.current_type2);

	self.current_type2_item_data = self.current_config_type2[self.current_type2];
	app.log("----------- type2_data:" .. table.tostring(self.current_type2_item_data));
	-- table.sort(self.current_type2_item_data, function ( a, b )
	-- 		return a.task_id < b.task_id;
	-- 	end);

	msg_sign_in.cg_request_task_list_back(self.current_type1, self.current_type2);
end

function SevenSignBackUi:on_btn_click( t )
	local task_id = tonumber(t.string_value);
	local state = t.float_value;
	app.log(task_id .. "---" .. state);
	if state == 0 then
		if task_id > 0 then
			-- SystemEnterFunc[task_id]();
			SystemEnterFunc.ActivityEnter(task_id);
		end
	elseif state == 1 then
		msg_sign_in.cg_get_award_back(task_id);
	elseif state == 2 then

	elseif state == 3 then
		FloatTip.Float(_text[3]);
	end
end

function SevenSignBackUi:on_btn_mu_biao_click( t )
	uiManager:PushUi(EUI.SevenSignMuBiaoBack);
end

function SevenSignBackUi:on_close( t )
	uiManager:RemoveUi(EUI.SevenSignBackUi);
end

function SevenSignBackUi:set_deff_time( )
	local diffSec = self.m_end_time - system.time();

	local day,hour,min,sec = TimeAnalysis.ConvertSecToDayHourMin(diffSec)
    if self.lab_time then
    	-- self.lab_art_font1:set_text(tostring(day));

    	self.lab_time:set_text("   活动倒计时:" .. day .. "天" .. string.format("%02d:", hour) .. string.format("%02d:", min) .. string.format("%02d", sec) .. "");
    	-- app.log("-------时间: " .. day .. "天-" .. string.format("%02d:", hour) .. string.format("%02d:", min) .. string.format("%02d", sec));

   
    end
end

-------- 数据返回
function SevenSignBackUi:on_set_list_by_data( startTime, endTime, type1, type2, taskList )
	-- app.log("---- back--:type1:" .. type1 .. " type2:" .. type2 .. "taskList:" .. table.tostring(taskList) );
	-- do return end;
	self.m_start_time = startTime;
	self.m_end_time = endTime;
	if self.updateTimer == 0 then
		self:set_deff_time(); 
        self.updateTimer = timer.create(self.bindfunc["set_deff_time"], 1000 ,-1);
    end

    local diffSec = system.time() - self.m_start_time;
    local day = diffSec / 60 / 60 / 24;
    app.log("-------sdfedfwedf-----day: " .. day);
    day = math.ceil(day);
    self.m_day = day;
    -- local day,hour,min,sec = TimeAnalysis.ConvertSecToDayHourMin(diffSec);
    local yekaBtn = nil;
    local sp_suo = nil;
    local yekaObj = nil;
    local yekaText = nil;
    local sp_bg = nil;
    for i=1, #self.m_type1_item_ui do
    	yekaObj = self.m_type1_item_ui[i];
    	yekaBtn = ngui.find_button(yekaObj:get_parent(), "yeka" .. i);
    	yekaBtn:reset_on_click();

    	sp_bg1 = ngui.find_sprite(yekaObj:get_parent(), "yeka" .. i .. "/sp1");
		sp_bg2 = ngui.find_sprite(yekaObj:get_parent(), "yeka" .. i .. "/sp2");

    	--sp_bg = ngui.find_sprite(yekaObj:get_parent(), "yeka" .. i .. "/sp");
    	sp_suo = ngui.find_sprite(yekaObj:get_parent(), "yeka" .. i .. "/sp_suo");
    	-- yekaText = ngui.find_label(yekaObj:get_parent(), "yeka" .. i .. "/lab");
    	if i <= day then
    		yekaBtn:set_event_value("1", i);
    		yekaBtn:set_on_click(self.bindfunc["on_switch_right_type1"], "MyButton.NoneAudio");
    		sp_suo:set_active(false);
    		-- yekaBtn:set_enable(true);
   --  		sp_bg1:set_active(true)
			-- sp_bg2:set_active(false)
    	else
			yekaBtn:set_event_value("2", i);
			yekaBtn:set_on_click(self.bindfunc["on_switch_right_type1"], "MyButton.NoneAudio");
    		sp_suo:set_active(true);
    		-- yekaBtn:set_enable(false);
    		-- yekaText:set_text("   " .. string.gsub(yekaText:get_text(), "^%s*(.-)%s*$", "%1"));

   --  		sp_bg1:set_active(false)
			-- sp_bg2:set_active(true)
   		end
    end

	if self.current_type1 == type1 and self.current_type2 == type2 then
		self.m_current_back_data = taskList;
		-- table.sort(self.m_current_back_data, 
		-- 	function ( a, b )
		-- 		return a.task_id < b.task_id;
		-- 	end
		-- 	);
		self:UpdateUiForBackData();
	end

	self:UpdateRedPoint();
end

function SevenSignBackUi:on_award_back( task_id )

	local award = {};
	for k,v in pairs(self.current_type2_item_data) do
		if v.task_id == task_id then
			for i, a_value in pairs(v.award_items) do
				table.insert(award, {id = a_value.item_id, count = a_value.item_num});
			end
			break;
		end
	end

	if #award > 0 then
		CommonAward.Start(award);
	end

	msg_sign_in.cg_request_task_list_back(self.current_type1, self.current_type2);
end

function SevenSignBackUi:SetUpdateUi( )
	if g_dataCenter.signin:GetIsOpen_back() == false then
		uiManager:PopUi(EUI.SevenSignBackUi);
	end
end

function SevenSignBackUi:UpdateRedPoint( )
	local sp_point = nil;
	for k,v in pairs(self.m_type1_item_ui) do
		sp_point = ngui.find_sprite(self.yeka_right, "yeka" .. k .. "/sp_spint");
		if sp_point then
			sp_point:set_active(g_dataCenter.signin:GetRedPointStateByType1_back(k));
		end
	end

	local basePath = "seven_sign_Ui/center_other/animation/yeka_top/";
	for i = 1, 3 do
    	local sp_point = ngui.find_sprite(self.ui, basePath .. "yeka" .. i .. "/sp_point");
    	if sp_point then
			sp_point:set_active(g_dataCenter.signin:GetRedPointStateByType1AndType2_back(self.current_type1, i));
		end
	end
end

function SevenSignBackUi:on_get_back_data( is_get_total, c_score, timeLeft )
	app.log("------------ back:" .. c_score .. "--" .. timeLeft);
	local config_award = ConfigManager._GetConfigTable(EConfigIndex.t_sign_in_total_award_back);
	
	local total_scores = 0;
	local last_scores = config_award[#config_award].finish_scores;
	local current_config = nil;
	local next_config = nil;
	local isFind = false;
	self.current_index = 0;
	for k,v in ipairs(config_award) do
		app.log("----------- config_award:" .. table.tostring(config_award))
		if c_score >= v.finish_scores then
			self.current_index = k;			
			current_config = v;
			if config_award[k + 1] then
				next_config = config_award[k + 1]; 
			else
				next_config = v;
			end
		end
		-- total_scores = total_scores + v.finish_scores;
	end

	if self.current_index == 0 then
		current_config = config_award[1];
		next_config = config_award[1];
	end
	total_scores = next_config.finish_scores;

	if self.m_total_progress_txt then
		self.m_total_progress_txt:set_text(string.format(_text[5], c_score, last_scores));
	end
end
