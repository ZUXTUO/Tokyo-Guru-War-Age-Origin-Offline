--保卫喰场界面
UiBaoWeiCanChang = Class('UiBaoWeiCanChang', UiBaseClass);
local rank_texture_path =
{
	[1] = "tujizhan_d1",
	[2] = "tujizhan_c1",
	[3] = "tujizhan_b1",
	[4] = "tujizhan_a1",
	[5] = "tujizhan_a1",
	[6] = "tujizhan_a1",
	[7] = "tujizhan_a1",	
}
function UiBaoWeiCanChang:Init(data)
	self.pathRes = 'assetbundles/prefabs/ui/wanfa/defense_house/ui_1001_lue_duo_wu_zi.assetbundle';
    UiBaseClass.Init(self, data);
    -- self:InitData();
    -- self:Restart();
end

function UiBaoWeiCanChang:Restart(data)
	self.difficultLevel = 1;
	UiBaseClass.Restart(self, data);
	-- if self.ui ~= nil then
 --        return ;
 --    end
 --    self:RegistFunc();
 --    self:InitUI();
end

function UiBaoWeiCanChang:InitData(data)
	UiBaseClass.InitData(self, data);
	-- self.bindfunc = {};
	self.is_unlock = false;           --是否开启关卡
	self.have_challenged = false;	  --是否已经挑战过

	self.btn = {};
	self.texture = {};
	self.cont = {};
	self.lab_open_level = {};
	self.sp_open_level_bk = {};
	self.sp_rank = {};
	self.lab_not_open = {};
	self.obj_reward_parent = {}
	self.sim = {}
end

function UiBaoWeiCanChang:DestroyUi()
    self:Hide();
	UiBaseClass.DestroyUi(self);
 --    if self.timerid then
 --    	timer.stop(self.timerid);
	-- end
	-- self.timerid = nil;
	for k,v in pairs(self.sim) do
		v:DestroyUi();
	end
	for k,v in pairs(self.texture) do
		v:Destroy();
	end

	self.btn = {};
	self.texture = {};
	self.cont = {};
	self.lab_open_level = {};
	self.sp_open_level_bk = {};
	self.sp_rank = {};
	self.lab_not_open = {};
	self.obj_reward_parent = {}
	self.sim = {}
end

function UiBaoWeiCanChang:Show()
	UiBaseClass.Show(self);
end

function UiBaoWeiCanChang:Hide()
	UiBaseClass.Hide(self);
end

function UiBaoWeiCanChang:RegistFunc()
	UiBaseClass.RegistFunc(self);
    self.bindfunc["on_challenge"] = Utility.bind_callback(self, self.on_challenge)
	self.bindfunc["on_have_chanllenged"] = Utility.bind_callback(self, self.on_have_chanllenged)
	self.bindfunc["on_rule"] = Utility.bind_callback(self, self.on_rule)
	self.bindfunc["init_item_wrap_content"] = Utility.bind_callback(self, self.init_item_wrap_content)
	self.bindfunc["on_btn"] = Utility.bind_callback(self, self.on_btn)
end

--注册消息分发回调函数
function UiBaoWeiCanChang:MsgRegist()
    UiBaseClass.MsgRegist(self);
end

--注销消息分发回调函数
function UiBaoWeiCanChang:MsgUnRegist()
    UiBaseClass.MsgUnRegist(self);
end

function UiBaoWeiCanChang:LoadUI()
	UiBaseClass.LoadUI(self);
end

function UiBaoWeiCanChang:InitUI(asset_obj)
	UiBaseClass.InitUI(self, asset_obj);
	self.ui:set_parent(Root.get_root_ui_2d());
	self.ui:set_local_scale(Utility.SetUIAdaptation());
	self.ui:set_name("ui_bao_wei_can_chang");
	
	-- do return end
	---------------------按钮及回调事件绑定------------------------
	--变灰的挑战按钮
	-- self.btnChallengeGray = ngui.find_button(self.ui, "centre_other/animation/di/btn_start_gray");
	-- self.btnChallengeGray:set_active(false);
	-- self.btnChallengeGray:set_on_click(self.bindfunc["on_have_chanllenged"]);
	--开始挑战
	-- self.btnChallenge = ngui.find_button(self.ui,"centre_other/animation/di/btn_start");
	-- self.btnChallenge:set_on_click(self.bindfunc["on_challenge"],"MyButton.NoneAudio");
	--规则说明
	--self.btnRule = ngui.find_button(self.ui,"top_other/btn_rule");
	--self.btnRule:set_on_click(self.bindfunc["on_rule"]);
	--开放倒计时
	-- self.lab_open = ngui.find_label(self.ui, "centre_other/animation/di/content2/txt_title");
	-- self.lab_time = ngui.find_label(self.ui, "centre_other/animation/di/content2/lab_time");
	self.lab_remain_count = ngui.find_label(self.ui, "left_other/animation/sp_di/txt");
	--self.lab_challenge_gray = ngui.find_label(self.ui, "centre_other/animation/di/btn_start_gray/lab_start");
	self.lab_title = ngui.find_label(self.ui, "left_other/animation/sp_title/txt");

	self.scroll_view = ngui.find_scroll_view(self.ui, "left_other/animation/scroll_view/panel_list");
	self.wrap_content = ngui.find_wrap_content(self.ui, "left_other/animation/scroll_view/panel_list/wrap_concent");
	self.wrap_content:set_on_initialize_item(self.bindfunc['init_item_wrap_content']);
	--说明
	--self.lab_describe = ngui.find_label(self.ui, "ui_bao_wei_can_chang/lab");

	self:UpdateUi();
end

function UiBaoWeiCanChang:UpdateUi()
	if not self.ui then return end
	local dataCenter = g_dataCenter.activity[MsgEnum.eactivity_time.eActivityTime_baoWeiCanChang];
	local timeFinishNumber = dataCenter:GetChallengeNumber() or 0;
	local hurdle_id = MsgEnum.eactivity_time.eActivityTime_baoWeiCanChang;
	local all_number = ConfigManager.Get(EConfigIndex.t_activity_time,hurdle_id).number_restriction;
	if not all_number then
		all_number = 0;
	else
		all_number = all_number["d"]
	end
	self.lab_remain_count:set_text("今日剩余次数:"..tostring(all_number - timeFinishNumber).."/"..all_number);

	self.lab_title:set_text(tostring(gs_misc['gao_su_zu_ji_description']));
	if timeFinishNumber >= all_number then
		self.times_up = true;
		-- self.btnChallengeGray:set_active(true);
		-- self.btnChallenge:set_active(false);
	else
		self.times_up = false;
		-- self.btnChallengeGray:set_active(false);
		-- self.btnChallenge:set_active(true);
	end
	local cnt = 0;
	-- for k,v in pairs(gd_jie_lue_wu_zi_difficult) do
	for k,v in pairs(ConfigManager._GetConfigTable(EConfigIndex.t_jie_lue_wu_zi_difficult)) do
		cnt = cnt + 1;
	end
	self.wrap_content:set_min_index(0);
	self.wrap_content:set_max_index(cnt-1);
	self.wrap_content:reset();
end

function UiBaoWeiCanChang:init_item_wrap_content(obj,b,real_id)
	local index = math.abs(real_id)+1;
	-- app.log("index=="..index.."   b=="..b.."   real_id=="..real_id);
	if not self.btn[b] then
		self.btn[b] = ngui.find_button(obj, "cont/btn2");
	end
	if not self.cont[b] then
		self.cont[b] = obj:get_child_by_name("cont");
	end
	if not self.texture[b] then
		self.texture[b] = ngui.find_texture(obj, "texture");
	end
	local texture_path = ConfigManager.Get(EConfigIndex.t_jie_lue_wu_zi_difficult,index).texture_path;
	if texture_path then
		self.texture[b]:set_texture(texture_path);
	end
	if not self.sp_open_level_bk[b] then
		self.sp_open_level_bk[b] = obj:get_child_by_name(obj:get_name().."/sp_title");
	end
	if not self.lab_open_level[b] then
		self.lab_open_level[b] = ngui.find_label(obj, obj:get_name().."/sp_title/lab");
	end
	if not self.sp_rank[b] then
		self.sp_rank[b] = ngui.find_sprite(obj, "sp_effect");
	end
	if not self.lab_not_open[b] then
		self.lab_not_open[b] = ngui.find_label(obj, "txt");
	end
	self.sp_rank[b]:set_sprite_name(rank_texture_path[index]);

	if not self.obj_reward_parent[b] then
		self.obj_reward_parent[b] = obj:get_child_by_name("new_small_card_item1");
	end
	if not self.sim[b] then
		self.sim[b] = UiSmallItem:new({parent=self.obj_reward_parent[b], cardInfo = CardProp:new({number=2})});
		self.sim[b]:SetLabNum(false);
	end
	-- if index == self.difficultLevel then
	-- 	self.cur_select_b = b;
	-- self.sp_shine[b]:set_active(true);
	-- else
	-- 	self.sp_shine[b]:set_active(false);
	-- end
	local preDiffPass = true;
	local level = g_dataCenter.player.level;
	local open_level = ConfigManager.Get(EConfigIndex.t_jie_lue_wu_zi_difficult,index).open_level;
	--难度大于1的要特殊判断
	if index > 1 then
		preDiffPass = false;
		local flagHelper = g_dataCenter.player:GetFlagHelper();
		if flagHelper then
			local flagInfo = flagHelper:GetNumberFlag(MsgEnum.eactivity_time.eActivityTime_baoWeiCanChang);
			--上一难度完成的话
			if flagInfo and PublicFunc.GetBitValue(flagInfo, index-1) > 0 then
				preDiffPass = true;
			end
		end
	end
	--开启
	if level >= open_level and preDiffPass then
		self.cont[b]:set_active(true);
		self.sp_open_level_bk[b]:set_active(false);
		self.lab_not_open[b]:set_active(false);
		self.btn[b]:reset_on_click();
		self.btn[b]:set_event_value(tostring(b),index);
		self.btn[b]:set_on_click(self.bindfunc["on_challenge"]);
		self.obj_reward_parent[b]:set_active(true);
		self.texture[b]:set_color(1, 1, 1, 1);
		self.sp_rank[b]:set_color(1, 1, 1, 1);
	--未开启
	else
		self.cont[b]:set_active(false);
		self.sp_open_level_bk[b]:set_active(true);
		self.lab_not_open[b]:set_active(true);
		self.lab_open_level[b]:set_text("推倒前一难度并达到"..open_level.."级");
		self.obj_reward_parent[b]:set_active(false);
		self.texture[b]:set_color(0, 0, 0, 1);
		self.sp_rank[b]:set_color(0, 0, 0, 1);
	end
end

function UiBaoWeiCanChang:on_btn(t)
	local index = t.float_value;
	-- if index == self.difficultLevel then return end
	-- self.difficultLevel = index;
	-- self.sp_shine[self.cur_select_b]:set_active(false);
	-- self.cur_select_b = tonumber(t.string_value);
	-- self.sp_shine[self.cur_select_b]:set_active(true);
end
