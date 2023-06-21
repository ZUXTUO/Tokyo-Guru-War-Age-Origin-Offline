NavbarUI = Class('NavbarUI', UiBaseClass);

function NavbarUI:Init(data)
	self.pathRes = "assetbundles/prefabs/ui/main/nav_and_back.assetbundle";
	UiBaseClass.Init(self, data);
end

--重新开始
function NavbarUI:Restart(data)
	if UiBaseClass.Restart(self, data) then
	end
end

--初始化数据
function NavbarUI:InitData(data)
	UiBaseClass.InitData(self, data);
    self.showBackground = nil;
    self.showNavBar = nil;
    self.showRuleId = nil;
	self.showLock = false;
	self.showExit = true;
	self.updateInfoFlag = false

	self.external_back_handler = nil;
end

function NavbarUI:DestroyUi()
	if self.txApIcon then
		self.txApIcon:Destroy()
		self.txApIcon = nil
	end
    if self.bgScreenTexture then
    	self.bgScreenTexture:Destroy()
    	self.bgScreenTexture = nil
    end
    
    self.navigateBar = nil
    self.updateInfoFlag = false
	TimerManager.Remove(self.bindfunc['check_chat_fight_request'])
	UiBaseClass.DestroyUi(self);
end

function NavbarUI:Show()
    if UiBaseClass.Show(self) then
	end
end

function NavbarUI:Hide()
    if UiBaseClass.Hide(self) then
	end
end

function NavbarUI:RegistFunc()
    UiBaseClass.RegistFunc(self);
    self.bindfunc["on_home"] = Utility.bind_callback(self, self.on_home)
    self.bindfunc["on_exchange"] = Utility.bind_callback(self, self.on_exchange)
    self.bindfunc["on_ap"] = Utility.bind_callback(self, self.on_ap)
	self.bindfunc["on_bp"] = Utility.bind_callback(self, self.on_bp)
	self.bindfunc["on_gold"] = Utility.bind_callback(self, self.on_gold)
	self.bindfunc["on_crystal"] = Utility.bind_callback(self, self.on_crystal)
	self.bindfunc["on_back"] = Utility.bind_callback(self, self.on_back)
	self.bindfunc["on_rule"] = Utility.bind_callback(self, self.on_rule)
	self.bindfunc["on_item_data_change"] = Utility.bind_callback(self, self.on_item_data_change);

	self.bindfunc['check_chat_fight_request'] = Utility.bind_callback(self, self.check_chat_fight_request)
	self.bindfunc['on_chat_fight_request'] = Utility.bind_callback(self, self.on_chat_fight_request)
	self.bindfunc['on_chat_fight_cancel'] = Utility.bind_callback(self, self.on_chat_fight_cancel)
end

function NavbarUI:UnRegistFunc()
    UiBaseClass.UnRegistFunc(self);
end

--注册消息分发回调函数
function NavbarUI:MsgRegist()
	UiBaseClass.MsgRegist(self);
	NoticeManager.BeginListen(ENUM.NoticeType.CardItemChange, self.bindfunc["on_item_data_change"]);
end

--注销消息分发回调函数
function NavbarUI:MsgUnRegist()
	UiBaseClass.MsgUnRegist(self);
	NoticeManager.EndListen(ENUM.NoticeType.CardItemChange, self.bindfunc["on_item_data_change"]);
end

--加载UI
function NavbarUI:LoadUI()
	if UiBaseClass.LoadUI(self) then
	end
end

function NavbarUI:InitUI(asset_obj)
	UiBaseClass.InitUI(self, asset_obj)
	self.ui:set_parent(Root.get_root_ui_2d());
	self.ui:set_local_scale(1,1,1);
	self.ui:set_name("ui_navbar_and_background");

	self.coinCfg = nil;	--特殊货币配置
	
	local path = "ui_navigate/navigate/content/"
	---------------------按钮及回调事件绑定------------------------
	self.nodeGold = self.ui:get_child_by_name("btn_gold")
	self.nodeCrystal = self.ui:get_child_by_name("btn_crystal")
	self.nodeOther = self.ui:get_child_by_name("btn_tili")
	self.topContent = self.ui:get_child_by_name(path)
	--体力
	self.btnAp = ngui.find_button(self.nodeOther, "btn_1");
	self.btnAp:set_on_click(self.bindfunc["on_ap"]);
	--钻石
	self.btnCrystal = ngui.find_button(self.nodeCrystal, "btn_1");
	self.btnCrystal:set_on_click(self.bindfunc["on_crystal"]);
	--金币
	self.btnGold = ngui.find_button(self.nodeGold, "btn_1");
	self.btnGold:set_on_click(self.bindfunc["on_gold"]);

	self.txApIcon = ngui.find_texture(self.nodeOther, "texture")

	self.labAp = ngui.find_label(self.nodeOther, "lab")
	self.labGold = ngui.find_label(self.nodeGold, "lab")
	self.labCrystal = ngui.find_label(self.nodeCrystal, "lab")
	self.labTitle1 = ngui.find_label(self.topContent, "lab_biaoti")
	self.labTitle2 = ngui.find_label(self.topContent, "lab_biaoti/lab")


	--规则
	self.btnRule = ngui.find_button(self.topContent, "btn_rule" );
	self.btnRule:set_on_click(self.bindfunc["on_rule"]);
	

	path = "ui_navigate/navigate/right_top_other/"
	--返回
	self.btnBack = ngui.find_button(self.ui, path.."btn_back" );
	self.btnBack:set_on_click(self.bindfunc["on_back"],"MyButton.BackBtn");

	--精英关卡动画
	self.animHurdleElite = self.ui:get_child_by_name("ui_navigate/animation");
	---------------------图片文字等------------------------	
	self.bgScreenTexture = ngui.find_texture(self.ui, "panel_bk/texture")
	-- self.bgTop = ngui.find_texture(self.ui, "ui_navigate/navigate/bg_top");
	-- self.bgDown = ngui.find_texture(self.ui, "ui_navigate/navigate/bg_down");
    self.navigateBar = self.ui:get_child_by_name("ui_navigate")

    self.rightContent = self.ui:get_child_by_name(path)

	if self.showTitle ~= nil then
		PublicFunc.SetSinkText(self.showTitle or "", self.labTitle1, self.labTitle2)
		self.showTitle = nil
	end

	if self.showRuleId ~= nil then
		self.btnRule:set_active(self.showRuleId ~= 0)
		self.btnRule:set_event_value("", self.showRuleId)
		self.showRuleId = nil
	end

    --初始隐藏导航条
    if not self.updateInfoFlag then
		self:SetNavBarActive(false)
		self:setBackgroundActive(false);
	else
		if self.showBackground ~= nil then
			self:setBackgroundActive(self.showBackground);
		end
		if self.showNavBar ~= nil then
			self.navigateBar:set_active(self.showNavBar)
		end
	end
	
    self:setExitActive(self.showExit);

	self:InitChatFightUI()

	self:UpdateUi();
end

function NavbarUI:setTitle(title)
	if self.ui then
		local showTitle = title
		PublicFunc.SetSinkText(showTitle, self.labTitle1, self.labTitle2)
	else
		self.showTitle = title
	end
end

function NavbarUI:setRuleId(ruleId)
	if self.ui then
		self.btnRule:set_active(ruleId ~= 0)
		self.btnRule:set_event_value("", ruleId)
	else
		self.showRuleId = ruleId
	end
end

function NavbarUI:setCoinCfg(coinCfg)
	self.coinCfg = coinCfg
	if self.ui then
		self:UpdateCoin()
	end
end

function NavbarUI:setExitActive(is_show)
	if self.ui then
		if is_show then
			local is_show_nav_bar = uiManager:GetNavLayerCnt() > 0
			self:SetNavBarActive(is_show_nav_bar)
			self.btnBack:set_active(is_show_nav_bar)
		else
			self.btnBack:set_active(false)
		end
		--隐藏导航条
		if self.showState == 1 then
			self.topContent:set_active(false)
			self.rightContent:set_active(false)
		elseif self.showState == 2 then
			self.topContent:set_active(true)
			self.rightContent:set_active(true)
			self:SetCurrencyFieldActive(false)
		else
			self.topContent:set_active(true)
			self.rightContent:set_active(true)
			self:SetCurrencyFieldActive(true)
		end
    end
end

function NavbarUI:SetCurrencyFieldActive(is_show)
	if is_show then
		self.nodeGold:set_active(true)
		self.nodeCrystal:set_active(true)
		self.nodeOther:set_active(true)
	else
		self.nodeGold:set_active(false)
		self.nodeCrystal:set_active(false)
		self.nodeOther:set_active(false)
	end
end

function NavbarUI:setBackgroundActive(is_show)
	local resBg = self.resTexturePath or ENUM.PublicBgImage.DLD;
	if self.bgScreenTexture then
		self.bgScreenTexture:set_active(is_show);
		self:SetBkTexture(resBg)
	else
		self.showBackground = is_show;
	end
end

function NavbarUI:SetNavBarActive(is_show)
    if self.navigateBar then
        self.navigateBar:set_active(is_show)
    else
        self.showNavBar = is_show
    end
    --关闭开启3d摄像机
    if FightScene.GetPlayMethodType() == MsgEnum.eactivity_time.eActivityTime_MainCity then
        local c = CameraManager.GetLoginBackGroundCamera();
        --if nil == c then
        --local c =  asset_game_object.find("login_background");
          --  CameraManager.SetLoginBackGroundCamera(c);
        --end
        if nil ~= c then
        	if not is_show then
        		CameraManager.CloseMainCamera();
            end
            c:set_active(not is_show);
        end
        c = CameraManager.GetSceneCameraObj()
        if nil ~= c then
        	c:set_active(false);
        end
    end
end

function NavbarUI:UpdateUi()
    if UiBaseClass.UpdateUi(self) then

		self.labGold:set_text(PublicFunc.NumberToStringByCfg(g_dataCenter.player.gold));
		-- self.labCrystal:set_text(PublicFunc.NumberToStringByCfg(g_dataCenter.player.crystal));
		self.labCrystal:set_text(tostring(g_dataCenter.player.crystal));

		self:UpdateCoin()
    end
end

function NavbarUI:UpdateCoin()
	if not self.ui then return end
	--app.log("self.coinCfg:"..table.tostring(self.coinCfg))
	if self.coinCfg ~= nil and self.coin_cfg_ignore ~= true then
		--app.log("self.coinCfg.id#############"..tostring(self.coinCfg.id))
		local count = PropsEnum.GetValue(self.coinCfg.id)
		--app.log("count##############"..tostring(count))
		self.btnAp:set_active(self.coinCfg.get_way)
		if  self.coinCfg.id ==  10 then
			--app.log("churchVigor====="..tostring(g_dataCenter.player.churchVigor))
			local allcount = PublicFunc.NumberToStringByCfg(ConfigManager.Get(EConfigIndex.t_discrete,83000128).data)--PublicFunc.NumberToStringByCfg(g_dataCenter.player:GetMaxSP(g_dataCenter.player.level))
			self.labAp:set_text(tostring(g_dataCenter.player.churchVigor).."/"..PublicFunc.NumberToStringByCfg(allcount));
		else
			self.labAp:set_text(PublicFunc.NumberToStringByCfg(count));
		end
		PublicFunc.SetItemTexture(self.txApIcon, self.coinCfg.id)
	else
		--local dis = ConfigManager.Get(EConfigIndex.t_discrete,MsgEnum.ediscrete_id.eDiscreteId_apMax)
		local vipCfg = g_dataCenter.player:GetVipData();
		local ap = PublicFunc.NumberToStringByCfg(g_dataCenter.player.ap)
		--local apmax = PublicFunc.NumberToStringByCfg(tonumber(dis.data) + tonumber(vipCfg.max_ap))
        local apmax = PublicFunc.NumberToStringByCfg(g_dataCenter.player:GetMaxAP(g_dataCenter.player.level))
		self.btnAp:set_active(true)
		self.labAp:set_text(ap.."/"..apmax);
		PublicFunc.SetItemTexture(self.txApIcon, IdConfig.Ap)
	end
end

-- 货币栏3显示的内部开关
function NavbarUI:SetCoinCfgIgnore(flag)
	self.coin_cfg_ignore = flag
	self:UpdateCoin()
end

function NavbarUI:SetBkTexture(path)
	if self.bgScreenTexture then
		self.bgScreenTexture:set_callback(self.callbackTexture)
		self.bgScreenTexture:set_texture(path);
	end
end

function NavbarUI:UpdateInfo(uiCfg, uiObj, tex_callback, set_BG)
	self.updateInfoFlag = true
	if uiCfg.showLast == false then
		self:setRuleId(uiCfg.ruleId or 0)
		self:setTitle(uiCfg.title or "")
		if uiObj and uiObj.GetNavigationTitle ~= nil then
			self:setTitle(uiObj:GetNavigationTitle())
		end

		-- if uiObj.GetNavigationTopAndDown ~= nil then
		-- 	self.bgTop:set_active(true);
		-- 	self.bgDown:set_active(true);
		-- else
		-- 	self.bgTop:set_active(false);
		-- 	self.bgDown:set_active(false);
		-- end

		if uiCfg.showState ~= nil then
			self.showState = uiCfg.showState
		else
			self.showState = 0
		end

		if uiCfg.btnBack then
			self.showExit = true
		else
			self.showExit = false
		end
	end

	if set_BG == nil or set_BG then
		self.resTexturePath = nil
		if type(uiCfg.resBg) == "string" and file.read_exist(uiCfg.resBg) then
			self.resTexturePath = uiCfg.resBg
		end
		self.callbackTexture = tex_callback;
		self:setBackgroundActive(uiCfg.background);
	end
	self:setCoinCfg(uiCfg.coin);
	self:setExitActive(self.showExit)
end

function NavbarUI:IsShow()
	if self.navigateBar then
		return self.navigateBar:get_active();
	else
		self.showNavBar = self.showNavBar or false;
		return self.showNavBar;
	end
end

function NavbarUI:SetHurdleElite(isShow)
	if self.animHurdleElite then
		self.animHurdleElite:set_active(isShow);
	end
end

return NavbarUI;
