SevenSignMuBiao = Class('SevenSignMuBiao', UiBaseClass);

local _text = {
	[1] = "当前进度:";
	[2] = "当前可领";
	[3] = "下档可领";
	[4] = "当前进度";
	[5] = "需进度达到";
	[6] = "领取";
	[7] = "已领取";
}

function SevenSignMuBiao:Init(data)
	self.pathRes = "assetbundles/prefabs/ui/sign/ui_5102_kai_fu.assetbundle";
	-- self.pathRes = "assetbundles/prefabs/ui/sign/ui_200_checkin_month.assetbundle";
	UiBaseClass.Init(self, data);
end

function SevenSignMuBiao:Restart()
    if UiBaseClass.Restart(self, data) then
	--todo 
	end
end

function SevenSignMuBiao:InitData(data)
	UiBaseClass.InitData(self, data);

	self.ui_texts = {};
	self.m_ui_item = nil;

	self.updateTimer = 0;
	self.m_timeLeft = 0;

	self.current_index = 0;
	self.current_score = 0;
end

function SevenSignMuBiao:DestroyUi()
	UiBaseClass.DestroyUi(self);
	if self.m_ui_item then
		self.m_ui_item:DestroyUi();
		self.m_ui_item = nil;
	end

	if self.updateTimer ~= 0 then 
        timer.stop(self.updateTimer);
        self.updateTimer = 0;
   	end


end

function SevenSignMuBiao:Show()
	if UiBaseClass.Show(self) then
	--todo 
	end
end

function SevenSignMuBiao:Hide()
    if UiBaseClass.Hide(self) then
	    
	end
end

function SevenSignMuBiao:RegistFunc()
	UiBaseClass.RegistFunc(self);

	self.bindfunc["on_close"] = Utility.bind_callback(self, self.on_close);
	self.bindfunc["on_award_total_click"] = Utility.bind_callback(self, self.on_award_total_click);

	self.bindfunc["on_get_back_data"] = Utility.bind_callback(self, self.on_get_back_data);
	self.bindfunc["on_get_award_total"] = Utility.bind_callback(self, self.on_get_award_total);

	self.bindfunc["set_deff_time"] = Utility.bind_callback(self, self.set_deff_time);
end

function SevenSignUi:UnRegistFunc()
    UiBaseClass.UnRegistFunc(self);
end

--注册消息分发回调函数
function SevenSignMuBiao:MsgRegist()
	UiBaseClass.MsgRegist(self);

	PublicFunc.msg_regist(msg_sign_in.gc_total_state, self.bindfunc["on_get_back_data"]);
    PublicFunc.msg_regist(msg_sign_in.gc_get_award_total, self.bindfunc["on_get_award_total"]);
end

--注销消息分发回调函数
function SevenSignMuBiao:MsgUnRegist()
	UiBaseClass.MsgUnRegist(self);
    
    PublicFunc.msg_unregist(msg_sign_in.gc_total_state, self.bindfunc["on_get_back_data"]);
	PublicFunc.msg_unregist(msg_sign_in.gc_get_award_total, self.bindfunc["on_get_award_total"]);
end


function SevenSignMuBiao:InitUI(asset_obj)
	UiBaseClass.InitUI(self, asset_obj)
	self.ui:set_parent(Root.get_root_ui_2d());
	self.ui:set_name("seven_sign_mu_biao");
	self.ui:set_local_scale(Utility.SetUIAdaptation());
	self.ui:set_local_position(0,0,0);

	self.btn_close = ngui.find_button(self.ui, "centre_other/animation/content_di_754_458/btn_cha");
	self.btn_close:set_on_click(self.bindfunc["on_close"]);

	--self.btn_award = ngui.find_button(self.ui, "seven_sign_mu_biao/center_other/animation/btn_get");
	--self.btn_award:set_on_click(self.bindfunc["on_award_total_click"]);
	--self.btn_award:set_active(false);
	--self.btn_award_lab = ngui.find_label(self.ui, "seven_sign_mu_biao/center_other/animation/btn_get/animation/lab")

	-- self.sp_yi_ling_qu = ngui.find_sprite(self.ui, "seven_sign_mu_biao/center_other/animation/sp_yi_ling_qu");

	self.lab_time = ngui.find_label(self.ui,"centre_other/animation/lab_describe1");
	self.lab_time:set_text("");

	self.active_dec = ngui.find_label(self.ui, "centre_other/animation/lab_describe2");
	self.active_dec:set_text(gs_sign_in["total_des"] or "");

	-- msg_sign_in.cg_request_total_state();

	local is_get_total, c_score, timeLeft, is_total = g_dataCenter.signin:GetTotal();
	if not is_total then
		msg_sign_in.cg_request_total_state();
	else
		self:on_get_back_data(is_get_total, c_score, timeLeft);
	end
end

function SevenSignMuBiao:ShowNavigationBar()
    return false;
end

function SevenSignMuBiao:on_close( t )
	-- uiManager:RemoveUi(EUI.SevenSignMuBiao);
	uiManager:PopUi(EUI.SevenSignMuBiao);

end

function SevenSignMuBiao:on_award_total_click( t )
	if self.current_index ~= 0 then
		msg_sign_in.cg_get_award_total(self.current_index, self.current_score);
	end
end

function SevenSignMuBiao:set_deff_time( )
	local diffSec = self.m_timeLeft - system.time();
	app.log(diffSec .. "------------ set_deff_time");
	if diffSec > 0 then
		-- self.btn_award:set_enable(false);
		-- self.btn_award:set_active(false);
		self.lab_time:set_active(true);
		local day,hour,min,sec = TimeAnalysis.ConvertSecToDayHourMin(diffSec);
		local timeStr = nil;
	    if self.lab_time then
	    	self.lab_time:set_active(true);
	    	if day <= 0 then
	    		timeStr = string.format("%02d:", hour) .. string.format("%02d:", min) .. string.format("%02d", sec) .. "后可领取";
	    	else
	    		timeStr = day .. "天" .. string.format("%02d:", hour) .. string.format("%02d:", min) .. string.format("%02d", sec) .. "后可领取";
	    	end
	    	self.lab_time:set_text(timeStr);
	    end
	else
		self.lab_time:set_active(false);
		-- if self.current_index == 0 then
		-- 	self.btn_award:set_enable(false);
		-- 	self.btn_award:set_sprite_names("ty_anniu3");
		-- 	self.btn_award_lab:set_text(_text[6]);
		-- else
		-- 	self.btn_award:set_sprite_names("ty_anniu3");
		-- 	self.btn_award:set_enable(true);
		-- 	self.btn_award:set_active(true)
		-- 	self.btn_award_lab:set_text(_text[6]);
		-- end
		if self.updateTimer > 0 then
			timer.stop(self.updateTimer);
        	self.updateTimer = 0;
		end
	end
end

function SevenSignMuBiao:on_get_back_data( is_get_total, c_score, timeLeft )
	app.log("------------ back:" .. c_score .. "--" .. timeLeft);
	self.current_score = c_score;
	self.is_get_total = is_get_total;
    -- do return end;
	local config_award = ConfigManager._GetConfigTable(EConfigIndex.t_sign_in_total_award);
	-- table.sort(config_award, function ( a, b )
	-- 	return a.finish_scores < b.finish_scores;
	-- end)
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

	local item_id = 0;
	local item_num = config_award[#config_award].award_items[1].item_num;
	local c_item_num = 0;
	if current_config.award_items ~= "0" then
		item_id = current_config.award_items[1].item_id;
		c_item_num = current_config.award_items[1].item_num;
		local small_card_item = self.ui:get_child_by_name("centre_other/animation/new_small_card_item");
		local carditem = CardProp:new({number = item_id, count = item_num});
		if self.m_ui_item == nil then
			self.m_ui_item = UiSmallItem:new({parent = small_card_item, cardInfo = carditem});
		else
			self.m_ui_item:SetData(carditem);
		end
		self.m_ui_item:SetLabNum(true);
		self.m_ui_item:SetNumberStr(tostring(item_num));

	end

	local tex_res = "centre_other/animation/content/";
	local text_k = nil;
	local text_v = nil;

	-- 总进度
	text_k = ngui.find_label(self.ui, tex_res .. "txt" .. 1);
	text_k:set_text(_text[1]);
	text_v = ngui.find_label(self.ui, tex_res .. "txt" .. 1 .. "/pro_di/lab_num");
	text_v:set_text("[974D04FF]"..c_score .. "[-][7463C9FF]/" .. last_scores.."[-]");
	local t_progress = ngui.find_progress_bar(self.ui, tex_res .. "txt1/pro_di");
	t_progress:set_value(tonumber(c_score/last_scores));

	-- 当前可领
	text_k = ngui.find_label(self.ui, tex_res .. "txt" .. 2);
	text_k:set_text(_text[2]);
	text_v = ngui.find_label(self.ui, tex_res .. "txt" .. 2 .. "/lab1");
	if self.current_index == 0 then
		text_v:set_text(tostring(0));
	else
		text_v:set_text(tostring(c_item_num));
	end

	-- 下档可领
	text_k = ngui.find_label(self.ui, tex_res .. "txt" .. 3);
	text_k:set_text(_text[3]);
	text_v = ngui.find_label(self.ui, tex_res .. "txt" .. 3 .. "/lab1");
	text_v:set_text(tostring(next_config.award_items[1].item_num));

	-- 当前进度
	text_k = ngui.find_label(self.ui, tex_res .. "txt" .. 4);
	text_k:set_text(_text[4]);
	text_v = ngui.find_label(self.ui, tex_res .. "txt" .. 4 .. "/lab1");
	-- if self.current_index == 0 then
	-- 	text_v:set_text("0%");
	-- else
	-- 	text_v:set_text(math.floor(c_score / last_scores * 100)  .. "%");
	-- end
	text_v:set_text(math.floor(c_score / last_scores * 100)  .. "%");

	-- 需进度达到
	text_k = ngui.find_label(self.ui, tex_res .. "txt" .. 5);
	text_k:set_text(_text[5]);
	text_v = ngui.find_label(self.ui, tex_res .. "txt" .. 5 .. "/lab1");
	text_v:set_text(math.ceil(next_config.finish_scores / last_scores * 100) .. "%");

	if self.is_get_total == 0 then
		-- self.btn_award:set_active(true);
		-- self.btn_award:set_enable(true);
		-- self.btn_award:set_sprite_names("ty_anniu3");
		-- self.btn_award_lab:set_text(_text[6]);
		-- self.sp_yi_ling_qu:set_active(false);
		local late_day = current_config.get_time;
		local late_sec = (late_day - 1) * 24 * 60 * 60;
		self.m_timeLeft = timeLeft + late_sec;
		-- self:set_deff_time();
		-- if self.updateTimer == 0 then 
	 --        self.updateTimer = timer.create(self.bindfunc["set_deff_time"], 1000 ,-1);
	 --    end
	else
		-- self.btn_award:set_enable(false);
		-- self.btn_award:set_active(true);
		-- self.btn_award:set_sprite_names("ty_anniu5");
		-- self.btn_award_lab:set_text(_text[7]);
		self.lab_time:set_active(false);
		-- self.sp_yi_ling_qu:set_active(true);
	end
end

function SevenSignMuBiao:on_get_award_total( t_index )
	local config_data = ConfigManager.Get(EConfigIndex.t_sign_in_total_award, t_index);
	local award = {};
	if config_data and config_data.award_items ~= "0" then
		-- app.log("---" .. table.tostring(config_data.award_items));
		table.insert(award, {id = config_data.award_items[1].item_id, count = config_data.award_items[1].item_num});
		CommonAward.Start(award);

		-- msg_sign_in.cg_request_total_state();
		-- self.btn_award:set_enable(false);
		-- self.btn_award:set_active(true);
		-- self.btn_award:set_sprite_names("ty_anniu5");
		-- self.btn_award_lab:set_text(_text[7]);
		self.lab_time:set_active(false);
		-- self.sp_yi_ling_qu:set_active(true);
	end
end
