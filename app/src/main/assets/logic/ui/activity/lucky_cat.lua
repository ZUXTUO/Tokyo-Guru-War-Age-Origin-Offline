LuckyCatUI = Class("LuckyCatUI", UiBaseClass);


local _lab_txt = {
	[1] = "[活动倒计时:%d天%02d:%02d:%02d]";
	[2] = "活动日期:%d月%d日~%d月%d日";
	[3] = "剩余次数:%d";
	[4] = "恭喜玩家%s运气爆表,在老虎机活动中获得%d钻石\n";
	[5] = "剩余次数:[DD0000FF]%d[-]";
}

function LuckyCatUI:Init(data)
    self.pathRes = "assetbundles/prefabs/ui/award/panel_1132_award_cat.assetbundle";
    UiBaseClass.Init(self, data);
end

function LuckyCatUI:InitData(data)
    UiBaseClass.InitData(self, data);
    self.tiger_labes = {};
    self.updateTimer = 0;
    self.m_start_time = 0;
    self.m_end_time = 0;

    self.m_use_times = 0;
    self.m_castal_num = 0;
    self.m_player_get_castals = {};

    self.m_invert_steep = 0;
    self.m_invert_delay = 0;

    self.m_tigger_labes = {};
    self.m_end_labes = {};
end

function LuckyCatUI:DestroyUi()

	if self.updateTimer ~= 0 then 
        timer.stop(self.updateTimer);
        self.updateTimer = 0;
    end
    self.m_use_times = 0;
    self.m_castal_num = 0;
    self.m_invert_steep = 0;
    UiBaseClass.DestroyUi(self);
end

function LuckyCatUI:RegistFunc()
	UiBaseClass.RegistFunc(self);
    self.bindfunc["on_close"] = Utility.bind_callback(self, self.on_close);
    self.bindfunc["on_rule"] = Utility.bind_callback(self, self.on_rule);
    self.bindfunc["on_get"] = Utility.bind_callback(self, self.on_get);
    self.bindfunc["set_deff_time"] = Utility.bind_callback(self, self.set_deff_time);
    self.bindfunc["set_delay_time"] = Utility.bind_callback(self, self.set_delay_time);
    self.bindfunc["go_to_store"] = Utility.bind_callback(self, self.go_to_store);
    self.bindfunc["on_get_castal"] = Utility.bind_callback(self, self.on_get_castal);

    LuckyCatUI.onAnimationRandomStr = Utility.bind_callback(self, self.onAnimationRandom);
    LuckyCatUI.onAnimationOverStr = Utility.bind_callback(self, self.onAnimationOver);
    LuckyCatUI.onAnimationOverStr1 = Utility.bind_callback(self, self.onAnimationOver1);

    self.bindfunc["gc_luck_cat_state"] = Utility.bind_callback(self, self.gc_luck_cat_state);
    self.bindfunc["gc_luck_cat_castal"] = Utility.bind_callback(self, self.gc_luck_cat_castal);
    self.bindfunc["gc_luck_cat_loop"] = Utility.bind_callback(self, self.gc_luck_cat_loop);
end

function LuckyCatUI:MsgRegist()
	PublicFunc.msg_regist(msg_activity.gc_luck_cat_state, self.bindfunc["gc_luck_cat_state"]);
	PublicFunc.msg_regist(msg_activity.gc_luck_cat_castal, self.bindfunc["gc_luck_cat_castal"]);
	PublicFunc.msg_regist(msg_activity.gc_luck_cat_loop, self.bindfunc["gc_luck_cat_loop"]);
end

function LuckyCatUI:MsgUnRegist()
	PublicFunc.msg_unregist(msg_activity.gc_luck_cat_state, self.bindfunc["gc_luck_cat_state"]);
	PublicFunc.msg_unregist(msg_activity.gc_luck_cat_castal, self.bindfunc["gc_luck_cat_castal"]);
	PublicFunc.msg_unregist(msg_activity.gc_luck_cat_loop, self.bindfunc["gc_luck_cat_loop"]);
end

function LuckyCatUI:InitUI(asset_obj)
	UiBaseClass.InitUI(self, asset_obj)
	self.ui:set_parent(Root.get_root_ui_2d());
	self.ui:set_name("lucky_cat_ui");
	
	self.btn_close = ngui.find_button(self.ui, "center_other/animation/btn_cha");
	self.btn_close:set_on_click(self.bindfunc["on_close"]);

	self.btn_rule = ngui.find_button(self.ui, "center_other/animation/right_content/content/btn_rule");
	self.btn_rule:set_on_click(self.bindfunc["on_rule"]);

	self.btn_get = ngui.find_button(self.ui, "center_other/animation/right_content/btn_di");
	self.btn_get:set_on_click(self.bindfunc["on_get"]);

	self.invert_lab_time = ngui.find_label(self.ui, "center_other/animation/lab_title_time");
	self.invert_lab_time:set_text("");

	self.activity_lab_time = ngui.find_label(self.ui, "center_other/animation/left_content/lab_time");
	self.activity_lab_time:set_text("");

	self.total_castal = ngui.find_label(self.ui, "center_other/animation/right_content/lab1/lab_num");
	self.total_castal:set_text("");

	self.need_castal = ngui.find_label(self.ui, "center_other/animation/right_content/btn_di/lab");
	self.need_castal:set_text("");

	self.lab_times = ngui.find_label(self.ui, "center_other/animation/right_content/lab2");
	self.lab_times:set_text("");

	self.lab_loop = ngui.find_label(self.ui, "center_other/animation/left_content/scroll_view/panel/lab");
	self.lab_loop:set_text("");

	-- local tiger_lab = nil;
	-- for i=1,5 do
	-- 	tiger_lab = ngui.find_label(self.ui, "center_other/animation/right_content/animation_num/lab" .. i);
	-- 	tiger_lab:set_text("/0");
	-- 	table.insert(self.tiger_labes, tiger_lab);
	-- end
	self.m_tigger_animation_obj = self.ui:get_child_by_name("center_other/animation/right_content/panel_num/animation_num");
	self.m_tigger_animation_obj:set_animator_enable(false);
	self.m_tigger_animation_obj:animated_stop("panel_1132_award_cat");
	local lab = nil;
	for i=1,5 do
		-- if self.m_tigger_labes[i] == nil then
		-- 	self.m_tigger_labes[i] = {};
		-- end
		local lab_tile = {};
		for j=1,10 do
			lab = ngui.find_label(self.ui, "center_other/animation/right_content/panel_num/animation_num/content".. j .."/lab" .. i);
			lab:set_text("/" .. j - 1);
			lab_tile[j] = lab;
		end
		self.m_tigger_labes[i] = lab_tile;
	end
	self.m_end_labes = {
		[1] = {start_num = 1, end_num = 2},
		[2] = {start_num = 1, end_num = 3},
		[3] = {start_num = 1, end_num = 4},
		[4] = {start_num = 1, end_num = 5},
		[5] = {start_num = 1, end_num = 6},
	}
	

	local activityTime = g_dataCenter.activityReward:GetActivityTimeForActivityID( ENUM.Activity.activityType_lucky_cat );
	if activityTime then
		self.m_start_time = activityTime.s_time;
		self.m_end_time = activityTime.e_time;
		local m_start_time = os.date('*t',activityTime.s_time);
		local m_end_time = os.date('*t',activityTime.e_time);
		self.activity_lab_time:set_text(string.format(_lab_txt[2],
				m_start_time.month,m_start_time.day,   m_end_time.month,m_end_time.day));
	end
	self.m_invert_steep = 5;
	self:set_deff_time();
	if self.updateTimer == 0 then
        self.updateTimer = timer.create(self.bindfunc["set_deff_time"], 1000 ,-1);
    end
    -- self:UpdateUI();
    msg_activity.cg_get_luck_cat_state();
end

function LuckyCatUI:UpdateUI( )
	local vip_data = g_dataCenter.player:GetVipData();
	local is_vip_level_total = false;
	if vip_data then
		self.btn_get:set_enable(true);
		self.btn_get:reset_on_click();
		self.btn_get:set_on_click(self.bindfunc["on_get"]);
		local last_num = vip_data.lucky_cat_times - self.m_use_times;
		if last_num > 0 then
			self.lab_times:set_text(string.format(_lab_txt[3], last_num));
			self.btn_get:set_event_value("1", 0);
		else
			self.lab_times:set_text(string.format(_lab_txt[5], last_num));
			-- self.btn_get:set_enable(false);
			local current_vip_times = vip_data.lucky_cat_times;
			local next_vip = 0;
			local vip_data_all = ConfigManager._GetConfigTable(EConfigIndex.t_vip_data);
			table.sort( vip_data_all, function ( a, b )
				return a.level < b.level;
			end )
			
			for k,v in ipairs(vip_data_all) do
				if v.lucky_cat_times > current_vip_times then
					next_vip = v.level;
					break;
				end
			end
			if next_vip > 0 then
				-- self.lab_times:set_text(string.format("提升至V%d可增加次数", next_vip));
				self.btn_get:set_event_value("0", next_vip);
			else
				self.btn_get:set_event_value("2", 0);
				is_vip_level_total = true;				
			end
			g_dataCenter.activityReward:SetRedPointStateByActivityID(ENUM.Activity.activityType_lucky_cat, 0);
		end
	end

	local config_data
	if is_vip_level_total then
		config_data = ConfigManager.Get(EConfigIndex.t_lucky_cat, vip_data.lucky_cat_times);--记录从0开始，表从1开始
	else
		config_data = ConfigManager.Get(EConfigIndex.t_lucky_cat, (self.m_use_times + 1));--记录从0开始，表从1开始
	end
	if config_data and config_data[1] then
		self.total_castal:set_text(tostring(config_data[1].total));
		self.need_castal:set_text(tostring(config_data[1].consume));
	end

	-- self.m_castal_num = 3577;
	-- self:refshTiggerLab();
	-- if self.m_castal_num ~= 0 then
	-- 	self.m_castal_num = tostring(self.m_castal_num);
	-- 	local strLen = string.len(self.m_castal_num);
	-- 	local step_num = 5 - strLen;
	-- 	local cur_num = 0;
	-- 	local tiger_lab = nil;
	-- 	for i = 1, 5 do			
	-- 		tiger_lab = self.tiger_labes[i + step_num];
	-- 		cur_num = string.sub(self.m_castal_num, i, i);
	-- 		if cur_num and tiger_lab then
	-- 			tiger_lab:set_text("/" .. cur_num);
	-- 		end
	-- 	end
	-- end
end

function LuckyCatUI:set_deff_time( )
	local diffSec = self.m_end_time - system.time();
	local day,hour,min,sec = TimeAnalysis.ConvertSecToDayHourMin(diffSec);
	self.invert_lab_time:set_text(string.format(_lab_txt[1], day, hour, min, sec));   
	if diffSec <= 0 then
	    -- if self.updateTimer ~= 0 then 
	    --     timer.stop(self.updateTimer);
	    --     self.updateTimer = 0;
	    -- end
	    self.invert_lab_time:set_text("");
	end

	self.m_invert_steep = self.m_invert_steep + 1;
	if self.m_invert_steep % 6 == 0 then
		msg_activity.cg_get_luck_cat_loop();
	end
end

function LuckyCatUI:gc_luck_cat_state( use_times )
	self.m_use_times = use_times;
	app.log("------------- use_times:" .. use_times);
	self:UpdateUI();
end

function LuckyCatUI:gc_luck_cat_castal( use_times, castal_num )
	self.m_use_times = use_times;
	self.m_castal_num = castal_num;
	-- 这里应该有个动画，现在暂时延迟3秒
	-- self.m_invert_delay = timer.create(self.bindfunc["set_delay_time"], 2000, 1);
	self:playTiggerAnimation();
end

function LuckyCatUI:set_delay_time( )

	-- 动画结束
	
	HintUI.SetAndShow(EHintUiType.one, string.format("获得%d钻石", self.m_castal_num), {str = "确定", func = self.bindfunc["on_get_castal"]});

	-- self:UpdateUI();
	
end

function LuckyCatUI:gc_luck_cat_loop( player_get_castals )
	self.m_player_get_castals = player_get_castals;
	local loopStr = "";
	for k,v in pairs(self.m_player_get_castals) do
		loopStr = loopStr .. string.format(_lab_txt[4], v.player_name, v.castal_num);
	end
	self.lab_loop:set_text(loopStr);
end

function LuckyCatUI:on_get_castal( )
	self:UpdateUI();
end
 
function LuckyCatUI:on_get( t )
	app.log("----------- t.string_value" .. tostring(t.string_value))
	if t.string_value == "1" then
		local vip_data = ConfigManager.Get(EConfigIndex.t_vip_data, g_dataCenter.player.vip); 
		if vip_data then
			if self.m_use_times < vip_data.lucky_cat_times then
				msg_activity.cg_get_luck_cat_castal(self.m_use_times);
				self.btn_get:set_enable(false);
				self.m_invert_steep = 0;
			end
		end	
	elseif t.string_value == "0" then
		HintUI.SetAndShowNew(EHintUiType.two, "提示", string.format("招财猫次数已用完,提升到V%d可增加次数", t.float_value),nil,{str="确定",func = self.bindfunc["go_to_store"]},{str = "取消"});
	elseif t.string_value == "2" then
		FloatTip.Float("次数已用完");
	end
end

function LuckyCatUI:on_close( t )
	uiManager:RemoveUi(EUI.LuckyCatUI);
end

function LuckyCatUI:on_rule( t )
	UiRuleDes.Start(ENUM.ERuleDesType.LuckyCat);
end

function LuckyCatUI:go_to_store()
	uiManager:PushUi(EUI.StoreUI);
end

function LuckyCatUI:playTiggerAnimation( )
	self.m_tigger_animation_obj:set_animator_enable(true);
	self.m_tigger_animation_obj:animated_play("panel_1132_award_cat");
end

function LuckyCatUI:onAnimationRandom( )
	app.log("---------------- LuckyCatUIAnimationRandom ------------ 1");
	local lab = nil;
	local random_num = 0;
	for i=1,5 do
		for j=1,10 do
			random_num = math.random(0, 9);
			lab = self.m_tigger_labes[i][j];
			lab:set_text("/" .. random_num);
		end
	end
end

function LuckyCatUI:onAnimationOver1( )
	app.log("---------------- LuckyCatUIAnimationOver1 -------------- 1");
	if self.m_castal_num ~= 0 then
		local castal_str = string.format("%05d", self.m_castal_num);
		app.log("------------------ castal_str:" .. castal_str);
		local lab = nil;
		local cur_num = 0;
		local cur_tex_num = 0;
		local cur_tex_num1 = 0;
		local steep_num = 0;
		for i=1,5 do
			-- local steep = self.m_end_labes.end_num - self.m_end_labes.start_num;

			steep_num = 0;
			for j=self.m_end_labes[i].end_num, self.m_end_labes[i].start_num, -1 do
				steep_num = steep_num + 1;
				if j <= 0 then
					j = j + 9;
				end
				lab = self.m_tigger_labes[i][j];
				cur_num = string.sub(castal_str, i, i);
				cur_tex_num = tonumber(cur_num) + (steep_num - 1);
				cur_tex_num1 = string.sub(cur_tex_num, 1, -1);
				lab:set_text("/" .. cur_tex_num1);				
			end
		end
	end
end

function LuckyCatUI:onAnimationOver( )
	app.log("---------------- LuckyCatUIAnimationOver -------------- 1");
	self:set_delay_time();
end

function LuckyCatUIAnimationRandom( )
	app.log("---------------- LuckyCatUIAnimationRandom");
	Utility.call_func(LuckyCatUI.onAnimationRandomStr);
end

function LuckyCatUIAnimationOver1( )
	app.log("---------------- LuckyCatUIAnimationOver1");
	Utility.call_func(LuckyCatUI.onAnimationOverStr1);
end

function LuckyCatUIAnimationOver( )
	app.log("---------------- LuckyCatUIAnimationOver");
	Utility.call_func(LuckyCatUI.onAnimationOverStr);
end