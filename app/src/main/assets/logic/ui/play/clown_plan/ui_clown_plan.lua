UiClownPlan = Class('UiClownPlan', UiBaseClass)

UiClownPlan.UITEXT = {

}

local rank_texture_path =
{
[1] = "tujizhan_d1",
[2] = "tujizhan_c1",
[3] = "tujizhan_b1",
[4] = "tujizhan_a1",
}
function UiClownPlan:Init(data)
	self.pathRes = "assetbundles/prefabs/ui/wanfa/clown_plan/new_fight_ui_xiao_chou4.assetbundle"
	UiBaseClass.Init(self, data)
end

function UiClownPlan:InitData(data)
	UiBaseClass.InitData(self, data)
	self.is_unlock = false;
	-- 是否开启关卡
	self.have_challenged = false;
	-- 是否已经挑战过
	
	self.btn = { };
	self.texture = { };
	self.cont = { };
	self.lab_open_level = { };
	self.sp_open_level_bk = { };
	self.sp_rank = { };
	self.lab_not_open = { };
	self.obj_reward_parent = { }
	self.sim = { }
end


function UiClownPlan:RegistFunc()
	UiBaseClass.RegistFunc(self)
	self.bindfunc["init_item_wrap_content"] = Utility.bind_callback(self, self.init_item_wrap_content)
	self.bindfunc["on_challenge"] = Utility.bind_callback(self, self.on_challenge)
end

function UiClownPlan:MsgRegist()
	UiBaseClass.MsgRegist(self)
	-- PublicFunc.msg_regist(msg_cards.gc_item_sell, self.bindfunc['gc_item_sell']);
	
end

function UiClownPlan:MsgUnRegist()
	UiBaseClass.MsgRegist(self)
	-- PublicFunc.msg_unregist(msg_cards.gc_item_sell, self.bindfunc['gc_item_sell']);
end

function UiClownPlan:Restart(data)
	self.difficultLevel = 1;
	UiBaseClass.Restart(self, data)
end
function UiBaoWeiCanChang:Show()
	UiBaseClass.Show(self);
end

function UiBaoWeiCanChang:Hide()
	UiBaseClass.Hide(self);
end


function UiClownPlan:InitUI(obj)
	UiBaseClass.InitUI(self, obj);
	self.ui:set_parent(Root.get_root_ui_2d());
	self.ui:set_local_scale(Utility.SetUIAdaptation());
	self.ui:set_name("ui_clown_plan");
	
	self.lab_remain_count = ngui.find_label(self.ui, "left_other/animation/sp_di/txt");
	
	
	self.scroll_view = ngui.find_scroll_view(self.ui, "left_other/animation/scroll_view/panel_list");
	self.wrap_content = ngui.find_wrap_content(self.ui, "left_other/animation/scroll_view/panel_list/wrap_concent");
	self.wrap_content:set_on_initialize_item(self.bindfunc['init_item_wrap_content']);
	
	self:UpdateUi();
end

function UiClownPlan:init_item_wrap_content(obj, b, real_id)
	local index = math.abs(real_id) + 1;
	-- app.log("index=="..index.."   b=="..b.."   real_id=="..real_id);
	if not self.btn[b] then
		self.btn[b] = { }
	end
	if not self.btn[b].btn_go then
		self.btn[b].btn_go = ngui.find_button(obj, "cont1/grid/btn1");
	end
	if not self.btn[b].btn_sweep then
		self.btn[b].btn_sweep = ngui.find_button(obj, "cont1/grid/btn2");
		self.btn[b].btn_sweep:set_active(false)
	end
	if not self.cont[b] then
		self.cont[b] = obj:get_child_by_name("cont1");
	end
	if not self.texture[b] then
		self.texture[b] = ngui.find_texture(obj, "texture_human");
	end
		local clown_cfg = ConfigManager.Get(EConfigIndex.t_clown_plan_hurdle, index)
	local texture_path = clown_cfg.path;
	if texture_path then
		self.texture[b]:set_texture(texture_path);
	end
	if not self.sp_open_level_bk[b] then
		self.sp_open_level_bk[b] = obj:get_child_by_name(obj:get_name() .. "/sp_title");
	end
	if not self.lab_open_level[b] then
		self.lab_open_level[b] = ngui.find_label(obj, obj:get_name() .. "/sp_title/lab");
	end
	if not self.sp_rank[b] then
		self.sp_rank[b] = ngui.find_sprite(obj, "sp_effect");
	end
	if not self.lab_not_open[b] then
		self.lab_not_open[b] = ngui.find_label(obj, "texture/txt");
	end

	local spriteName = rank_texture_path[index]
	if spriteName then
		self.sp_rank[b]:set_sprite_name(spriteName);
	end
	if not self.obj_reward_parent[b] then
		self.obj_reward_parent[b] = {}
		
	end
	for i=1,2 do
		if not self.obj_reward_parent[b][i] then
			self.obj_reward_parent[b][i] = obj:get_child_by_name("cont1/sp_di1/new_small_card_item"..i);
		end
	end
	
	if not self.sim[b] then
		self.sim[b] = {}
	end
	for i=1,2 do
		if not self.sim[b][i] then
			local award = clown_cfg.awards;
			if award then
				self.sim[b][i] = UiSmallItem:new( { parent = self.obj_reward_parent[b][i], cardInfo = CardProp:new( { number = award[i] }) });
				self.sim[b][i]:SetLabNum(false);
			end
		end
	end
	
	
	local preDiffPass = true;
	local level = g_dataCenter.player.level;
	
	local open_level = ConfigManager.Get(EConfigIndex.t_clown_plan_hurdle, index).open_level;
	-- 难度大于1的要特殊判断
	if index > 1 then
		preDiffPass = false;
		local flagHelper = g_dataCenter.player:GetFlagHelper();
		if flagHelper then
			local flagInfo = flagHelper:GetNumberFlag(MsgEnum.eactivity_time.eActivityTime_ClownPlan);
			-- 上一难度完成的话
			if flagInfo and PublicFunc.GetBitValue(flagInfo, index - 1) > 0 then
				preDiffPass = true;
			end
		end
	end
	-- 开启
	if level >= open_level and preDiffPass then
		self.cont[b]:set_active(true);
		self.sp_open_level_bk[b]:set_active(false);
		self.lab_not_open[b]:set_active(false);
		self.btn[b].btn_go:reset_on_click();
		self.btn[b].btn_go:set_event_value(tostring(b), index);
		self.btn[b].btn_go:set_on_click(self.bindfunc["on_challenge"]);
		for i=1,2 do
			self.obj_reward_parent[b][i]:set_active(true);
		end
		
		self.texture[b]:set_color(1, 1, 1, 1);
		self.sp_rank[b]:set_color(1, 1, 1, 1);
		-- 未开启
	else
		self.cont[b]:set_active(false);
		self.sp_open_level_bk[b]:set_active(true);
		self.lab_not_open[b]:set_active(true);
		self.lab_open_level[b]:set_text("推倒前一难度并达到" .. open_level .. "级");
		for i=1,2 do
			self.obj_reward_parent[b][i]:set_active(false);
		end
		self.texture[b]:set_color(0, 0, 0, 1);
		self.sp_rank[b]:set_color(0, 0, 0, 1);
	end
end

function UiClownPlan:UpdateUi()
	if not self.ui then return end
	local dataCenter = g_dataCenter.activity[MsgEnum.eactivity_time.eActivityTime_ClownPlan];
	local timeFinishNumber = dataCenter:GetChallengeNumber() or 0;
	local hurdle_id = MsgEnum.eactivity_time.eActivityTime_ClownPlan;
		local all_number = ConfigManager.Get(EConfigIndex.t_activity_time, hurdle_id).number_restriction;
	if not all_number then
		all_number = 0;
	else
		all_number = all_number["d"]
	end
	self.lab_remain_count:set_text("今日参与次数:" .. timeFinishNumber .. "/" .. all_number);
	if timeFinishNumber >= all_number then
		self.times_up = true;
	else
		self.times_up = false;
	end
	local cnt = 0;
	for k, v in pairs(ConfigManager._GetConfigTable(EConfigIndex.t_clown_plan_hurdle)) do
		cnt = cnt + 1;
	end
	self.wrap_content:set_min_index(0);
	self.wrap_content:set_max_index(cnt - 1);
	self.wrap_content:reset();
end

function UiClownPlan:DestroyUi()
	self:Hide();
	UiBaseClass.DestroyUi(self);
	
	for k, v in pairs(self.sim) do
		for kk,vv in pairs(v) do
			vv:DestroyUi();
		end
	end
	for k, v in pairs(self.texture) do
		v:Destroy();
	end
	
	self.btn = { };
	self.texture = { };
	self.cont = { };
	self.lab_open_level = { };
	self.sp_open_level_bk = { };
	self.sp_rank = { };
	self.lab_not_open = { };
	self.obj_reward_parent = { }
	self.sim = { }
end


-- 开始挑战
function UiClownPlan:on_challenge(t)
	
	local index = t.float_value;
	self.difficultLevel = index;
	local level = g_dataCenter.player.level;
	local hurdle_data = ConfigManager.Get(EConfigIndex.t_clown_plan_hurdle, self.difficultLevel)
	local difficult_open_level = hurdle_data.open_level;
	-- TODO：临时注释
	if not g_dataCenter.gmCheat:noPlayLimit() then
		if level < difficult_open_level then
			HintUI.SetAndShow(EHintUiType.zero, "等级不足");
			return;
		end
		if self.times_up then
			HintUI.SetAndShow(EHintUiType.zero, "今日参与次数已用完，请明天再来");
			return;
		end
	end
	
	local fs = g_dataCenter.activity[MsgEnum.eactivity_time.eActivityTime_ClownPlan]
	
	
	-- 玩法ID修改后需要注意
	
	fs:SetLevelIndex(hurdle_data.level)
	fs:SetDifficultLevel(self.difficultLevel);
	fs:SetPlayMethod(MsgEnum.eactivity_time.eActivityTime_ClownPlan);
	
	fs:AddFightPlayer(g_dataCenter.fight_info.single_friend_flag, g_dataCenter.player, g_dataCenter.package, EFightPlayerType.human, g_dataCenter.player:GetDefTeam())
	
	
	--msg_activity.cg_enter_activity(MsgEnum.eactivity_time.eActivityTime_ClownPlan, fs:Tostring())
end