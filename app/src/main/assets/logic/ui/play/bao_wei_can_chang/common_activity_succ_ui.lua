

CommonActivitySuccUI = Class('CommonActivitySuccUI', MultiResUiBaseClass);


function CommonActivitySuccUI.Start(awardsList, progress, killInfo)
    if CommonActivitySuccUI.cls == nil then
        CommonActivitySuccUI.cls = uiManager:PushUi(EUI.CommonActivitySuccUI, {awardsList = awardsList, progress = progress, killInfo = killInfo})
    end
end

function CommonActivitySuccUI.SetFinishCallback(callback, obj)
    if CommonActivitySuccUI.cls then
        CommonActivitySuccUI.cls.callbackFunc = callback;
		if CommonActivitySuccUI.cls.callbackFunc then
			CommonActivitySuccUI.cls.callbackObj = obj;
		end
    end
end


function CommonActivitySuccUI.Destroy()
    uiManager:RemoveUi(EUI.CommonActivitySuccUI)
    CommonActivitySuccUI.cls = nil
end

local resType = 
{
    Front = 1,
    Back = 2,
}

local resPaths = 
{
    [resType.Front] = 'assetbundles/prefabs/ui/wanfa/defense_house/ui_1002_develop_ap.assetbundle';
    [resType.Back] = 'assetbundles/prefabs/ui/new_fight/panel_jiesuan_item.assetbundle';
}

local _UIText = 
{
    [1] = '点击屏幕任意位置关闭',
}


function CommonActivitySuccUI:Init(data)
	self.pathRes = resPaths
	MultiResUiBaseClass.Init(self, data);
end

function CommonActivitySuccUI:RestartData(data)
	MultiResUiBaseClass.RestartData(self, data);

	CommonClearing.canClose = false
end

function CommonActivitySuccUI:RegistFunc()
    MultiResUiBaseClass.RegistFunc(self);
    self.bindfunc["OnClose"] = Utility.bind_callback(self,self.OnClose);
end

function CommonActivitySuccUI:OnClose()
    if not CommonClearing.canClose or app.get_time() - CommonClearing.reciCanCloseTime < PublicStruct.Const.UI_CLOSE_DELAY then return end

	if self.callbackFunc then
		self.callbackFunc(self.callbackObj);
		self.callbackFunc = nil;
		self.callbackObj = nil;
	end

    CommonActivitySuccUI.Destroy()
end

function CommonActivitySuccUI:InitedAllUI()

	self.backui = self.uis[resPaths[resType.Back]]
	self.frontui = self.uis[resPaths[resType.Front]]
    self.frontParentNode = self.backui:get_child_by_name("add_content")
    self.closeMarkButton = ngui.find_button(self.backui, "mark")
    self.tipCloseLabel = ngui.find_label(self.backui, "txt")
    self.progressLabel = ngui.find_label(self.frontui, "txt/lab")
    self.progressBar = ngui.find_progress_bar(self.frontui, "background")
    self.templateNode = self.frontui:get_child_by_name("new_small_card_item")
    -- self.itemParent = self.templateNode:get_parent()
    self.grid = ngui.find_grid(self.frontui, "grid")
    self.killInfoNameLabel = ngui.find_label(self.frontui, "lab_txt")
    self.killInfoContentLabel = ngui.find_label(self.frontui, "lab_txt/lab_num")

    self.tipCloseLabel:set_text(_UIText[1])
    self.frontui:set_parent(self.frontParentNode)
    self.closeMarkButton:set_on_click(self.bindfunc["OnClose"]);
    local initData = self:GetInitData()
    self.progressLabel:set_text(tostring(math.floor(initData.progress * 100)) .. "%" )
    self.progressBar:set_value(initData.progress)
    self.templateNode:set_active(false)

    local awardsList = initData.awardsList
    awardsList = PublicFunc.MergeNetSummeryNetList(awardsList)
    PublicFunc.ConstructCardAndSort(awardsList)
    self.uiSmallItems = {}
    self.allItemParent = {}
    for k, item in ipairs(awardsList) do
        local parent = self.templateNode:clone()
        parent:set_active(true)
        local nameLab = ngui.find_label(parent, "lab")
        local node = UiSmallItem:new({parent = parent, is_enable_goods_tip = true, delay = 0})
        node:SetData(item.cardinfo)
        node:SetCount(item.count)
		if item.double_radio and item.double_radio > 1 then
			node:SetDouble(item.double_radio);
		end
        nameLab:set_text(item.cardinfo.color_name or item.cardinfo.name)

        self.allItemParent[k] = parent
        self.uiSmallItems[k] = node
    end
    self.grid:reposition_now()

    if initData.killInfo then
        self.killInfoNameLabel:set_text(tostring(initData.killInfo.name))
        self.killInfoContentLabel:set_text(tostring(initData.killInfo.content))
    else
        self.killInfoNameLabel:set_active(false)
    end

	AudioManager.Stop(nil, true)
	AudioManager.PlayUiAudio(81010000)
end

function CommonActivitySuccUI:DestroyUi()
	if self.uiSmallItems then
		for k,v in pairs(self.uiSmallItems) do
			v:DestroyUi()
		end
        self.uiSmallItems = nil
	end
    self.allItemParent = nil
    MultiResUiBaseClass.DestroyUi(self)
end


-- --保卫喰场奖励界面
-- UiBaoWeiCanChangAward = Class('UiBaoWeiCanChangAward', MultiResUiBaseClass);

-- local Proportion = ConfigManager.Get(EConfigIndex.t_jie_lue_wu_zi,1).proportion[1];
-- -----------------外部接口---------------------------------
-- --显示保卫喰场奖励界面
-- --param：data = {score = 1500}
-- function UiBaoWeiCanChangAward.ShowAwardUi(data)
-- 	local difficultLevel = g_dataCenter.activity[MsgEnum.eactivity_time.eActivityTime_baoWeiCanChang]:GetDifficultLevel();
-- 	Proportion = ConfigManager.Get(EConfigIndex.t_jie_lue_wu_zi,g_dataCenter.player.level).proportion[difficultLevel];
-- 	if(not UiBaoWeiCanChangAward.awardUi)then
-- 		UiBaoWeiCanChangAward.awardUi = UiBaoWeiCanChangAward:new(data);
-- 	else
-- 		UiBaoWeiCanChangAward.awardUi:Show(data);
-- 	end
-- end

-- --摧毁奖励界面
-- function UiBaoWeiCanChangAward.DestroyAward()
-- 	if(UiBaoWeiCanChangAward.awardUi)then
-- 		UiBaoWeiCanChangAward.awardUi:DestroyUi();
-- 		UiBaoWeiCanChangAward.awardUi = nil;
-- 	end
-- end

-- local _uiText = 
-- {
-- 	[1] = '狙击成功',
-- 	[2] = '',
-- }

-- local resType = 
-- {
--     Front = 1,
--     Back = 2,
-- }

-- local resPaths = 
-- {
-- 	[resType.Front] = 'assetbundles/prefabs/ui/wanfa/defense_house/ui_1002_develop_ap.assetbundle';
--     [resType.Back] = 'assetbundles/prefabs/ui/new_fight/panel_jiesuan_item.assetbundle';
-- }

-- -----------------内部接口---------------------------------
-- function UiBaoWeiCanChangAward:Init(data)
-- 	self.pathRes = resPaths
--     MultiResUiBaseClass.Init(self,data);
-- end

-- function UiBaoWeiCanChangAward:Restart(data)
--     MultiResUiBaseClass.Restart(self, data);
-- end

-- function UiBaoWeiCanChangAward:InitData(data)
-- 	MultiResUiBaseClass.InitData(self, data);
-- 	self.MAX_FRACTION = ConfigManager.Get(EConfigIndex.t_discrete, MsgEnum.ediscrete_id.eDiscreteID_baoWeiCanChangMaxFraction).data;
-- 	self.is_animation = false;
-- 	self.can_touch = false;
-- 	self:SetData(data);
-- end

-- function UiBaoWeiCanChangAward:DestroyUi()
-- 	MultiResUiBaseClass.DestroyUi(self);
-- 	if(self.timerId)then
-- 		timer.stop(self.timerId);
-- 		self.timerId = nil;
-- 	end
-- end

-- function UiBaoWeiCanChangAward:Show(data)
-- 	if not MultiResUiBaseClass.Show(self) then return end
-- 	self:SetData(data);
-- 	self.proScore:set_value(self.maxScore/self.MAX_FRACTION);
-- 	self.labScore:set_text(tostring(self.maxScore));
-- 	self.proAP:set_value(0);
-- 	self.labAP:set_text(tostring(0));
-- 	self.is_animation = false;
-- 	self.can_touch = false;
-- 	self:UpdateUi();
-- end

-- function UiBaoWeiCanChangAward:Hide()
-- 	if not MultiResUiBaseClass.Hide(self) then return end
-- end



-- function UiBaoWeiCanChangAward:RegistFunc()
-- 	MultiResUiBaseClass.RegistFunc(self);
--     self.bindfunc["on_touch"] = Utility.bind_callback(self, UiBaoWeiCanChangAward.on_touch)
-- 	self.bindfunc["on_animation"] = Utility.bind_callback(self, UiBaoWeiCanChangAward.on_animation)
-- 	self.bindfunc["begin_animation"] = Utility.bind_callback(self, UiBaoWeiCanChangAward.begin_animation)
-- end

-- --注册消息分发回调函数
-- function UiBaoWeiCanChangAward:MsgRegist()
--     MultiResUiBaseClass.MsgRegist(self);
-- end

-- --注销消息分发回调函数
-- function UiBaoWeiCanChangAward:MsgUnRegist()
--     MultiResUiBaseClass.MsgUnRegist(self);
-- end

-- function UiBaoWeiCanChangAward:LoadUI()
-- 	MultiResUiBaseClass.LoadUI(self);
-- end

-- function UiBaoWeiCanChangAward:InitedAllUI()

--     local backui = self.uis[resPaths[resType.Back]]

-- 	local frontParentNode = backui:get_child_by_name("add_content")
-- 	self.ui = self.uis[resPaths[resType.Front]]
-- 	self.ui:set_name("ui_defense_house_award")
--     self.ui:set_parent(frontParentNode)


--     self.titleSprite = ngui.find_sprite(backui, "sp_art_font")

--     self.effectTitle = backui:get_child_by_name("fx_ui_jiesuan_win");

-- 	---------------------按钮及回调事件绑定------------------------
-- 	self.back = ngui.find_button(backui,"mark");
-- 	self.back:set_on_click(self.bindfunc["on_touch"]);

-- 	-- self.labTitle = ngui.find_label(self.ui, "animation/lab_title");
-- 	self.lbl_progress = ngui.find_label(self.ui,"centre_other/animation/lab")
-- 	--do return end
-- 	--开始挑战
-- 	self.proScore = ngui.find_progress_bar(self.ui,"centre_other/animation/blue/sp_blue");
-- 	self.proScore:set_value(self.maxScore/self.MAX_FRACTION);
-- 	self.labScore = ngui.find_label(self.ui,"centre_other/animation/blue/lab");
-- 	self.labScore:set_text(tostring(self.maxScore));
-- 	--规则说明
-- 	self.proAP = ngui.find_progress_bar(self.ui,"centre_other/animation/gold/sp_blue");
-- 	self.proAP:set_value(0);
-- 	self.labAP = ngui.find_label(self.ui,"centre_other/animation/gold/lab");
-- 	self.labAP:set_text(tostring(0));
	
-- 	self:UpdateUi();
-- 	self._super:InitedAllUI()
-- end

-- function UiBaoWeiCanChangAward:SetData(data)
-- 	if(data)then
-- 		if(data.score)then
-- 			if(data.score> self.MAX_FRACTION)then
-- 				data.score = self.MAX_FRACTION;
-- 			end
-- 			self.curScore = data.score;
-- 			self.maxScore = data.score;
-- 			return;
-- 		end
-- 	end
-- 	self.curScore = 0;
-- 	self.maxScore = 0;
-- end

-- function UiBaoWeiCanChangAward:UpdateUi()
-- 	if(MultiResUiBaseClass.UpdateUi(self))then
-- 		self.titleSprite:set_sprite_name("js_huodongjieshu")
-- 		self.proScore:set_value(self.curScore/self.MAX_FRACTION);
-- 		self.labScore:set_text(tostring(self.curScore));
-- 		self.proAP:set_value((self.maxScore - self.curScore)/self.MAX_FRACTION);
-- 		local difficultLevel = g_dataCenter.activity[MsgEnum.eactivity_time.eActivityTime_baoWeiCanChang]:GetDifficultLevel();
-- 		local Proportion = ConfigManager.Get(EConfigIndex.t_jie_lue_wu_zi,g_dataCenter.player.level).proportion[difficultLevel];
-- 		local gold = (self.maxScore - self.curScore) * Proportion;
-- 		local cf = ConfigManager.Get(EConfigIndex.t_vip_data, g_dataCenter.player:GetVip());
-- 		gold = gold + gold * cf.gsjj_add_money;
-- 		self.labAP:set_text(tostring(math.floor(gold)));
-- 		self.timerIdBeginAni = timer.create(self.bindfunc["begin_animation"],1000,1);
-- 		if self.curScore >= self.MAX_FRACTION then
-- 			self.effectTitle:set_active(true)
-- 		else
-- 			self.effectTitle:set_active(false)
-- 		end
-- 		--app.log("UiBaoWeiCanChangAward:UpdateUi "..tostring(self.curScore) .. "  "..tostring(self.MAX_FRACTION))
-- 		self.lbl_progress:set_text("通关进度："..tostring(math.floor(self.curScore/self.MAX_FRACTION*100)).."%")
-- 	end
-- end

-- function UiBaoWeiCanChangAward:begin_animation()
-- 	self.timerId = timer.create(self.bindfunc["on_animation"],10,-1);
-- 	self.can_touch = true;
-- 	self.is_animation = true;
-- end

-- function UiBaoWeiCanChangAward:on_animation()
-- 	self.curScore = self.curScore - 20;
-- 	local cf = ConfigManager.Get(EConfigIndex.t_vip_data, g_dataCenter.player:GetVip());
-- 	if(self.curScore <= 0)then
-- 		self.curScore = 0
-- 		self.proScore:set_value(self.curScore/self.MAX_FRACTION);
-- 		self.labScore:set_text(tostring(self.curScore));
-- 		self.proAP:set_value((self.maxScore - self.curScore)/self.MAX_FRACTION);
-- 		-- local Proportion = ConfigManager.Get(EConfigIndex.t_jie_lue_wu_zi,g_dataCenter.player.level).proportion;
-- 		local gold = (self.maxScore - self.curScore) * Proportion;
-- 		gold = gold + gold * cf.gsjj_add_money;
-- 		self.labAP:set_text(tostring(math.floor(gold)));
-- 		timer.stop(self.timerId);
-- 		self.is_animation = false;
-- 	end
-- 	self.proScore:set_value(self.curScore/self.MAX_FRACTION);
-- 	self.labScore:set_text(tostring(self.curScore));
-- 	self.proAP:set_value((self.maxScore - self.curScore)/self.MAX_FRACTION);
-- 	-- local Proportion = ConfigManager.Get(EConfigIndex.t_jie_lue_wu_zi,g_dataCenter.player.level).proportion;
-- 	local gold = (self.maxScore - self.curScore) * Proportion;
-- 	gold = gold + gold * cf.gsjj_add_money;
-- 	self.labAP:set_text(tostring(math.floor(gold)));
-- end


-- function UiBaoWeiCanChangAward:on_touch()
-- 	if(self.can_touch)then
-- 		local cf = ConfigManager.Get(EConfigIndex.t_vip_data, g_dataCenter.player:GetVip());
-- 		if(self.is_animation)then
-- 			self.curScore = 0
-- 			self.proScore:set_value(self.curScore/self.MAX_FRACTION);
-- 			self.labScore:set_text(tostring(self.curScore));
-- 			self.proAP:set_value((self.maxScore - self.curScore)/self.MAX_FRACTION);
-- 			-- local Proportion = ConfigManager.Get(EConfigIndex.t_jie_lue_wu_zi,g_dataCenter.player.level).proportion;
-- 			local gold = (self.maxScore - self.curScore) * Proportion;
-- 			gold = gold + gold * cf.gsjj_add_money;
-- 			self.labAP:set_text(tostring(math.floor(gold)));
-- 			timer.stop(self.timerId);
-- 			self.is_animation = false;
-- 		else
-- 			self.timerId = nil;
-- 			self:Hide();
-- 			local awardsList = {};
-- 			awardsList.id = 2;
-- 			-- local Proportion = ConfigManager.Get(EConfigIndex.t_jie_lue_wu_zi,g_dataCenter.player.level).proportion;
-- 			awardsList.count = self.maxScore * Proportion;
-- 			awardsList.count = awardsList.count + awardsList.count * cf.gsjj_add_money;
-- 			-- 双倍
-- 			awardsList.double_radio = g_dataCenter.activityReward:GetDoubleByID(ENUM.Double.hight_sniper, awardsList.id);

-- 			if awardsList.count > 0 then
-- 				CommonAward.Start({awardsList}, 1);
-- 				CommonAward.SetFinishCallback(UiBaoWeiCanChangAward.on_over, self);
-- 			else
-- 				UiFightBaoWeiCanChang.DestroyFightUi()
-- 				SceneManager.PopScene(FightScene)
-- 			end
-- 			--UiFightBaoWeiCanChang.DestroyFightUi()
-- 			--SceneManager.PopScene(FightScene)
-- 			--FightScene.GetFightManager():FightOver();
-- 		end
-- 	end
-- end

-- function UiBaoWeiCanChangAward:on_over()
-- 	UiFightBaoWeiCanChang.DestroyFightUi()
-- 	SceneManager.PopScene(FightScene)
-- end
