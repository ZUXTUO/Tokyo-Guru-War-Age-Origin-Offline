CommonAwardVip = Class("CommonAwardVip", MultiResUiBaseClass);

--------------------外部接口-------------------------
--awardsList 物品列表 ｛net_summary_item，net_summary_item，net_summary_item｝最多10个
--tType CommonAwardVipEType,默认CommonAwardVipEType.again
--desc 描述文本

CommonAwardVipEType = 
{
    again = 1, 			-- 获得物品
	reset = 3, 			-- 重置成功
	operatorAgain = 6,		--在结算界面再一次操作
	occupySuc = 7,		-- 占领成功
}

local _uiText=
{
	[1] = "重置返还";
	[5] = "再抽%s次";
	[8] = "点击屏幕任意位置关闭";
	[9] = "好感度%d-%d董香的馈赠";
}


-- againOperatorParam = 
-- {
-- 	againFunc = ,
-- 	againParam = ,
-- 	againCostId = ,
-- 	againCostNum = ,
--  againCostOwn = ,
--  againType = , 1-再来1次，10-再来10次
-- }
function CommonAwardVip.Start(data)
	if CommonAwardVip.cls == nil then
		CommonAwardVip.cls = uiManager:PushUi(EUI.CommonAwardVip, {data = data});
	end
end


function CommonAwardVip.SetFinishCallback(callback, obj)
	if CommonAwardVip.cls then
		CommonAwardVip.cls.callbackFunc = callback;
		if CommonAwardVip.cls.callbackFunc then
			CommonAwardVip.cls.callbackObj = obj;
		end
	else
		app.log("类未初始化 请先调用start"..debug.traceback());
	end
end

function CommonAwardVip.Destroy()
	if CommonAwardVip.cls then
		--CommonAwardVip.cls:DestroyUi();
		uiManager:RemoveUi(EUI.CommonAwardVip)
		CommonAwardVip.cls = nil;
	end
end

function CommonAwardVip.OnAnimationEnd()
	local cls = CommonAwardVip.cls
	if cls and cls.uiSmallItems then
		--添加稀有物品特效
		for k, v in pairs(cls.uiSmallItems) do
			local cardInfo = v:GetCardInfo()
			if cardInfo and cardInfo.rarity >= ENUM.EItemRarity.Orange then
				v:SetAsReward(true)
			end
		end
	end

	if GuideUI then
		GuideUI.OnUiAniEnd()
	end
end
--------------------内部接口-------------------------
local resType = 
{
    Front = 1,
    Back = 2,
}

local resPaths = 
{
	-- ui/new_fight
    [resType.Front] = 'assetbundles/prefabs/ui/shop/panel_shop_fight.assetbundle';
    [resType.Back] = 'assetbundles/prefabs/ui/new_fight/panel_jiesuan_item.assetbundle';
}

function CommonAwardVip:Init(data)
	self.pathRes = resPaths
	MultiResUiBaseClass.Init(self, data);
end

function CommonAwardVip:RestartData(data)
	MultiResUiBaseClass.RestartData(self, data);
	--外部数据相关
	self.data = data;
	CommonClearing.canClose = false
end

function CommonAwardVip:RegistFunc()
    MultiResUiBaseClass.RegistFunc(self);
    self.bindfunc["OnDelayClose"] = Utility.bind_callback(self,self.OnDelayClose);
	self.bindfunc["ClickAgainButton"] = Utility.bind_callback(self,self.ClickAgainButton);
	self.bindfunc["BeginShow"] = Utility.bind_callback(self,self.BeginShow);

	self.bindfunc["on_star_time"] = Utility.bind_callback(self, self.on_star_time);
	self.bindfunc["on_star_line_time"] = Utility.bind_callback(self, self.on_star_line_time);
	self.bindfunc["on_up_level_time"] = Utility.bind_callback(self, self.on_up_level_time);
	self.bindfunc["on_up_level_delay_time"] = Utility.bind_callback(self, self.on_up_level_delay_time);
end

function CommonAwardVip:InitedAllUI()
	local data = self.data.data;
	
	self.backui = self.uis[resPaths[resType.Back]]
	self.frontui = self.uis[resPaths[resType.Front]]

	self.backAnimationNode = self.backui:get_child_by_name("animation")
	self.closeTipText = ngui.find_label(self.backui, "txt")
	self.frontParentNode = self.backui:get_child_by_name("add_content")
	self.titleSprite = ngui.find_sprite(self.backui, "sp_art_font")
	-- self.titleSprite:set_sprite_name("js_dengjitisheng");
	self.closeMarkButton = ngui.find_button(self.backui, "mark")

	self.frontui:set_parent(self.frontParentNode);
	self.vip_txt = ngui.find_label(self.frontui, "sp_heart/lab_v");
	self.vip_txt:set_text("");
	self.vip_star_txt = ngui.find_label(self.frontui, "sp_heart/lab_v2");
	self.vip_star_txt:set_text("");
	self.lab_describe = ngui.find_label(self.frontui, "lab_describe");
	self.lab_describe:set_text("");

	self.sp_heart = self.frontui:get_child_by_name("sp_heart");
	-- self.sp_heart:set_local_position(-300, 0, 0);

	self.m_up_effect_s = self.frontui:get_child_by_name("sp_heart/fx_ui_shop_shengxin2");
	self.m_up_effect_s:set_active(false);
	self.m_up_effect_l = self.frontui:get_child_by_name("sp_heart/fx_ui_shop_shengxin");
	self.m_up_effect_l:set_active(false);
	if self.m_star_ui_list == nil then
		self.m_star_ui_list = {};
	end
	if self.m_star_ui_effect_list == nil then
		self.m_star_ui_effect_list = {};
	end

	local star_ui = nil;
	local star_ui_effect = nil;
	for i=1,9 do
		star_ui = ngui.find_sprite(self.frontui, "grid/sp_heart"..i);
		if star_ui then
			star_ui:set_active(false);
			self.m_star_ui_list[i] = star_ui;

			star_ui_effect = self.frontui:get_child_by_name("grid/sp_heart"..i.."/fx_ui_shop_xin");
			star_ui_effect:set_active(false);
			star_ui_effect:set_local_scale(0, 0, 0);
			self.m_star_ui_effect_list[i] = star_ui_effect;
		end
	end


	if data and data.vip_up_level then
		if data.vip_up_level == 1 then -- 升星
			self:UpStar();
			self.titleSprite:set_sprite_name("js_haogantisheng");
		elseif data.vip_up_level == 2 then
			self:UpLevelDelay();
			self.titleSprite:set_sprite_name("js_haoganshengji");
		end

		AudioManager.PlayUiAudio(81200101);
	end

	self.needWaitCloseEvent = true
	self.closeMarkButton:set_on_click(self.bindfunc["OnDelayClose"]);

	self:Hide()
	self.backAnimationNode:set_animated_speed('ui_jiesuan_win', 0)
	TimerManager.Add(self.bindfunc["BeginShow"], 1)

	GLoading.Show(GLoading.EType.ui)
end

function CommonAwardVip:UpStar(  )
	local vip_data = g_dataCenter.player:GetVipData();
	if vip_data then
		-- self.lab_describe:set_text(tostring(vip_data.des or ""));
		if self.lab_describe then
			self.lab_describe:set_text(string.format(_uiText[9], vip_data.level, vip_data.level_star))
		end

		if self.vip_txt then
			self.vip_txt:set_text(tostring(vip_data.level or ""));
		end

		if self.vip_star_txt then
			self.vip_star_txt:set_text("-"..tostring(vip_data.level_star or ""));
		end
	end

	local max_star = vip_data.level;
	local cur_vipstar = vip_data.level_star;
	for k,v in pairs(self.m_star_ui_list) do
		if v then		
			v:set_active(tonumber(k) <= max_star);	
			if tonumber(k) < cur_vipstar then
				v:set_sprite_name("vip_xin3");
			elseif tonumber(k) == cur_vipstar then
				v:set_sprite_name("vip_xin2");
				self.m_cur_line_star = v;
				self.m_cur_star_effect = self.m_star_ui_effect_list[k];
				if self.m_star_time and  self.m_star_time > 0 then
					timer.stop(self.m_star_time);
					self.m_star_time = 0;
				end
				self.m_star_time = timer.create(self.bindfunc["on_star_time"], 500 ,1);

				if self.m_star_line_time and  self.m_star_line_time > 0 then
					timer.stop(self.m_star_line_time);
					self.m_star_line_time = 0;
				end
				self.m_star_line_time = timer.create(self.bindfunc["on_star_line_time"], 1000 ,1);
			else
				v:set_sprite_name("vip_xin2");
			end
			
		end
	end

	self:UpdateStarUIPos( max_star );
end

function CommonAwardVip:UpLevelDelay(  )
	if self.m_up_level_delay_time and self.m_up_level_delay_time > 0 then
		timer.stop(self.m_up_level_delay_time);
		self.m_up_level_delay_time = 0;
	end 
	self.m_up_level_delay_time = timer.create(self.bindfunc["on_up_level_delay_time"], 500 ,1);
end

function CommonAwardVip:on_up_level_delay_time( )
	if self.m_up_level_delay_time and self.m_up_level_delay_time > 0 then
		timer.stop(self.m_up_level_delay_time);
		self.m_up_level_delay_time = 0;
	end
	self:UpLevel();
end

function CommonAwardVip:UpLevel(  )
	local old_vip = g_dataCenter.player.vip - 1;
	if old_vip <= 0 then
		old_vip = 0;
	end
	local cur_vipstar_max = g_dataCenter.player:GetVipData().level;
	self:UpdateStarUIPos(cur_vipstar_max);

	local old_vip_data = g_dataCenter.player:GetVipDataConfigByLevel(old_vip);
	local old_vipstar_max = 0;
	if old_vip_data then	
		old_vipstar_max = old_vip_data.level;
		for k,v in pairs(self.m_star_ui_list) do
			if v then		
				v:set_active(tonumber(k) <= old_vipstar_max);	
				v:set_sprite_name("vip_xin3");
			end
		end

		if self.lab_describe then
			-- self.lab_describe:set_text(tostring(old_vip_data.des or ""));
		end

		if self.vip_txt then
			self.vip_txt:set_text(tostring(old_vip_data.level or ""));
		end

		if old_vipstar_max <= 4 then
			self.m_up_effect_s:set_active(true);
		else
			self.m_up_effect_l:set_active(true);
		end
		if self.m_up_level_time and self.m_up_level_time > 0 then
			timer.stop(self.m_up_level_time);
			self.m_up_level_time = 0;
		end

		self.m_up_level_time = timer.create(self.bindfunc["on_up_level_time"], 600 ,1);

	else
		self:UpStar();
	end
	
end

function CommonAwardVip:on_star_time( )
	if self.m_star_time and  self.m_star_time > 0 then
		timer.stop(self.m_star_time);
		self.m_star_time = 0;
	end
	if self.m_cur_star_effect then
		self.m_cur_star_effect:set_active(true);
		self.m_cur_star_effect:set_local_scale(1, 1, 1);
	end
end

function CommonAwardVip:on_star_line_time(  )
	if self.m_star_line_time and  self.m_star_line_time > 0 then
		timer.stop(self.m_star_line_time);
		self.m_star_line_time = 0;
	end
	if self.m_cur_line_star then
		self.m_cur_line_star:set_sprite_name("vip_xin3");
	end
end

function CommonAwardVip:on_up_level_time( )
	-- self:UpdateUi();
	self:UpStar();
end

function CommonAwardVip:UpdateStarUIPos( max_star )
	local cur_pos = -300 + (9-max_star) * 30;
	app.log("max_star:".. max_star .. "cur_pos:" .. cur_pos);
	self.sp_heart:set_local_position(cur_pos, 100, 0);
end

function CommonAwardVip:BeginShow()
	GLoading.Hide(GLoading.EType.ui)
	if not self.backui then return end
	--util.begin_sample('CommonAwardVip:BeginShow')
	self:Show()
	self.backAnimationNode:set_animated_speed('ui_jiesuan_win', 1)
	AudioManager.PlayUiAudio(ENUM.EUiAudioType.ComReward);
	--util.end_sample()
end

function CommonAwardVip:Show()
	if not self.backui then return end

	self.backui:set_local_position(0, 0, 0)
end

function CommonAwardVip:Hide()
	if not self.backui then return end

	self.backui:set_local_position(100000, 0, 0)
end

function CommonAwardVip:ClickAgainButton()

	if not CommonClearing.canClose then return end

	local data = self.data

	self:OnClose()

	if data and data.againOperParam then
		local againOperParam = data.againOperParam

		againOperParam.againFunc(againOperParam.againParam)
	end
end

function CommonAwardVip:OnDelayClose()
	if self.needWaitCloseEvent then
		if not CommonClearing.canClose or app.get_time() - CommonClearing.reciCanCloseTime < PublicStruct.Const.UI_CLOSE_DELAY then return end
	else
		if not CommonClearing.canClose then return end
	end

	self:OnClose()
end

function CommonAwardVip:OnClose(t)

	self.data = nil;
	--ui相关
	CommonAwardVip.Destroy()

	--内部变量相关
	local oldCallback = self.callbackFunc;
	local oldCallObj = self.callbackObj;
	app.log("type:" .. type(self.callbackFunc))
	if self.callbackFunc and type(self.callbackFunc) == "string" then
		-- self.callbackFunc(self.callbackObj);
		Utility.call_func(self.callbackFunc, self.callbackObj);
		self.callbackFunc = nil;
		self.callbackObj = nil;
	end

	NoticeManager.Notice(ENUM.NoticeType.GetCommonAwardVipBack)

	return true
end

function CommonAwardVip:DestroyUi()
	
	if self.CostItemTexture then
		self.CostItemTexture:Destroy()
	end

	if self.uiSmallItems then
		for k,v in pairs(self.uiSmallItems) do
			v:DestroyUi()
		end
		self.uiSmallItems = nil
	end

	self.backui = nil

	MultiResUiBaseClass.DestroyUi(self)
end