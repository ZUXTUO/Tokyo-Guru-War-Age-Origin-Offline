TrialBuyBuff = Class('TrialBuyBuff',UiBaseClass)

local _UIText = {
    [1] = "恢复血量",
}

function TrialBuyBuff.PopPanel(buffInfo)
	TrialBuyBuff.instance = TrialBuyBuff:new(buffInfo);
	if TrialScene.instance ~= nil then 
		Tween.pause(TrialScene.instance.modelPlayer);
	end 
end 

--重新开始
function TrialBuyBuff:Restart(data)
    --app.log("TrialBuyBuff:Restart");
	--app.log("buffs :"..table.tostring(data));
    UiBaseClass.Restart(self, data);
	if self.buffInfo == nil then 
		self.buffInfos = data;
		self.buffInfo = table.remove(self.buffInfos,1)
	end 
end

function TrialBuyBuff:InitData(data)
    --app.log("TrialBuyBuff:InitData");
    UiBaseClass.InitData(self, data);
	--app.log("buffs :"..table.tostring(data));
	if self.buffInfo == nil then 
		self.buffInfos = data;
		self.buffInfo = table.remove(self.buffInfos,1)
	end 
end

function TrialBuyBuff:RegistFunc()
	----app.log("TrialBuyBuff:RegistFunc");
    self.bindfunc['on_main_ui_loaded'] = Utility.bind_callback(self, self.on_main_ui_loaded);
	self.bindfunc['load_main_ui'] = Utility.bind_callback(self, self.___LoadUI);
	self.bindfunc['onClickCard1'] = Utility.bind_callback(self, self.onClickCard1);
	self.bindfunc['onClickCard2'] = Utility.bind_callback(self, self.onClickCard2);
	self.bindfunc['onClickCard3'] = Utility.bind_callback(self, self.onClickCard3);
	self.bindfunc['onCloseClick'] = Utility.bind_callback(self, self.onCloseClick);
	self.bindfunc['onClickNext'] = Utility.bind_callback(self, self.onClickNext);
	self.bindfunc['onTrialBuffInfoChange'] = Utility.bind_callback(self, self.onTrialBuffInfoChange);
	self.bindfunc['onPressCard'] = Utility.bind_callback(self, self.onPressCard);
	self.bindfunc['onStarNumChange'] = Utility.bind_callback(self, self.onStarNumChange);
end

function TrialBuyBuff:InitUI(asset_obj)
	--app.log("TrialBuyBuff:InitUI");
	UiBaseClass.InitUI(self, asset_obj);
    self.ui:set_name('TrialBuyBuff');
	self.vs = {};
	--self.vs.title = ngui.find_label(self.ui,"centre_other/animation/lab_title");
	self.vs.floorRemainLab = ngui.find_label(self.ui,"centre_other/animation/txt");
	if self.vs.floorRemainLab ~= nil then 
		self.vs.floorRemainLab:set_text("剩余");
	end 
	self.vs.starNumLab = ngui.find_label(self.ui,"centre_other/animation/txt/lab_num");
	self.vs.btnNext = ngui.find_button(self.ui,"centre_other/animation/btn_yellow");
	if self.vs.btnNext then 
		self.vs.btnNext:set_on_click(self.bindfunc['onClickNext'])
	end 
	self.vs.card1 = self.ui:get_child_by_name("centre_other/animation/sp_big_bk1");
	self.vs.card2 = self.ui:get_child_by_name("centre_other/animation/sp_big_bk2");
	self.vs.card3 = self.ui:get_child_by_name("centre_other/animation/sp_big_bk3");
	self.vs.cardbg1 = ngui.find_sprite(self.vs.card1,"sp_bg");
	self.vs.cardbg2 = ngui.find_sprite(self.vs.card2,"sp_bg");
	self.vs.cardbg3 = ngui.find_sprite(self.vs.card3,"sp_bg");
	self.vs.cardbg1:set_on_ngui_click(self.bindfunc['onClickCard1']);
	self.vs.cardbg2:set_on_ngui_click(self.bindfunc['onClickCard2']);
	self.vs.cardbg3:set_on_ngui_click(self.bindfunc['onClickCard3']);
	self.vs.cardbg1:set_on_ngui_press(self.bindfunc['onPressCard']);
	self.vs.cardbg2:set_on_ngui_press(self.bindfunc['onPressCard']);
	self.vs.cardbg3:set_on_ngui_press(self.bindfunc['onPressCard']);
    self.vs.cardTitle1 = ngui.find_label(self.ui,"centre_other/animation/sp_big_bk1/lab_gongji")
	self.vs.cardTitle2 = ngui.find_label(self.ui,"centre_other/animation/sp_big_bk2/lab_gongji")
	self.vs.cardTitle3 = ngui.find_label(self.ui,"centre_other/animation/sp_big_bk3/lab_gongji")
	self.vs.sp_ling1 = ngui.find_sprite(self.ui,"centre_other/animation/txt/sp_ling1");
	self.sp_ling1Px,self.sp_ling1Py,self.sp_ling1Pz = self.vs.sp_ling1:get_position();
	--self.vs.cardTitle1 = ngui.find_sprite(self.ui,"centre_other/animation/sp_big_bk1/sp_art_font1")
	--self.vs.cardTitle2 = ngui.find_sprite(self.ui,"centre_other/animation/sp_big_bk2/sp_art_font1")
	--self.vs.cardTitle3 = ngui.find_sprite(self.ui,"centre_other/animation/sp_big_bk3/sp_art_font1")
	self.vs.cardIsBuy1 = ngui.find_sprite(self.ui,"centre_other/animation/sp_big_bk1/sp_yishou")
	self.vs.cardIsBuy2 = ngui.find_sprite(self.ui,"centre_other/animation/sp_big_bk2/sp_yishou")
	self.vs.cardIsBuy3 = ngui.find_sprite(self.ui,"centre_other/animation/sp_big_bk3/sp_yishou")
	self.vs.cardIcon1 = ngui.find_sprite(self.ui,"centre_other/animation/sp_big_bk1/sp_buff_icon");
	self.vs.cardIcon2 = ngui.find_sprite(self.ui,"centre_other/animation/sp_big_bk2/sp_buff_icon");
	self.vs.cardIcon3 = ngui.find_sprite(self.ui,"centre_other/animation/sp_big_bk3/sp_buff_icon");
	self.vs.cardIconBg1 = ngui.find_sprite(self.ui,"centre_other/animation/sp_big_bk1/sp_di1/sp_red");
	self.vs.cardIconBg2 = ngui.find_sprite(self.ui,"centre_other/animation/sp_big_bk2/sp_di1/sp_red");
	self.vs.cardIconBg3 = ngui.find_sprite(self.ui,"centre_other/animation/sp_big_bk3/sp_di1/sp_red");
	--[[self.vs.cardEffectNum1 = ngui.find_label(self.ui,"centre_other/animation/sp_big_bk1/sp_di1/lab_name")
	self.vs.cardEffectNum2 = ngui.find_label(self.ui,"centre_other/animation/sp_big_bk2/sp_di1/lab_name")
	self.vs.cardEffectNum3 = ngui.find_label(self.ui,"centre_other/animation/sp_big_bk3/sp_di1/lab_name")--]]
	self.vs.cardEffectDesc1 = ngui.find_label(self.ui,"centre_other/animation/sp_big_bk1/sp_di1/txt1")
	self.vs.cardEffectDesc2 = ngui.find_label(self.ui,"centre_other/animation/sp_big_bk2/sp_di1/txt1")
	self.vs.cardEffectDesc3 = ngui.find_label(self.ui,"centre_other/animation/sp_big_bk3/sp_di1/txt1")
	self.vs.cardStarCost1 = ngui.find_label(self.ui,"centre_other/animation/sp_big_bk1/sp_di1/sp_di/lab_num")
	self.vs.cardStarCost2 = ngui.find_label(self.ui,"centre_other/animation/sp_big_bk2/sp_di1/sp_di/lab_num")
	self.vs.cardStarCost3 = ngui.find_label(self.ui,"centre_other/animation/sp_big_bk3/sp_di1/sp_di/lab_num")
	self.vs.labNumFloor = ngui.find_label(self.ui,"centre_other/animation/txt");
	self.vs.btnClose = ngui.find_button(self.ui,"centre_other/animation/content_di_1004_564/btn_cha");
	self.vs.btnClose:set_on_click(self.bindfunc['onCloseClick']);
	self:UpdateUI();
end

function TrialBuyBuff:UpdateUI()
	--app.log("TrialBuyBuff:UpdateUI self.buffInfo = "..table.tostring(self.buffInfo));
	if self.buffInfo ~= nil then 
		if #self.buffInfos > 0 then 
			if self.vs.btnNext then 
				self.vs.btnNext:set_active(true);
			end 
			self.vs.labNumFloor:set_active(true);
			self.vs.labNumFloor:set_text("还剩"..tostring(#self.buffInfos).."层可以购买");
			self.vs.floorRemainLab:set_text(tostring(#self.buffInfos).."层剩余");
			
		else
			if self.vs.btnNext then 
				self.vs.btnNext:set_active(false); 
			end 
			self.vs.labNumFloor:set_active(true);
			self.vs.labNumFloor:set_text("");
			self.vs.sp_ling1:set_position(self.sp_ling1Px+188,self.sp_ling1Py,self.sp_ling1Pz);
		end 
		for i = 1,3 do 
			local buffConfig = ConfigManager.Get(EConfigIndex.t_expedition_trial_buff,self.buffInfo.buff_data[i].buffid);
			--app.log("buffInfo:"..table.tostring(self.buffInfo.buff_data));
			--app.log("buffConfig:"..table.tostring(buffConfig));
			if self.buffInfo.buff_data[i].sell == false then 
				self.vs["cardIsBuy"..tostring(i)]:set_active(false);
				self.vs["cardbg"..tostring(i)]:set_color(1,1,1,1);
				self.vs["cardIcon"..tostring(i)]:set_color(1,1,1,1);
			else 
				self.vs["cardIsBuy"..tostring(i)]:set_active(true);
				self.vs["cardbg"..tostring(i)]:set_color(0,0,0,1);
				self.vs["cardIcon"..tostring(i)]:set_color(0,0,0,1);
			end
			self.buffConfig = self.buffConfig or {}
			self.buffConfig[i] = buffConfig;
			--buffConfig.type
			--buffConfig.effect
			--buffConfig.stars_price
            local cardTitle = self.vs["cardTitle"..tostring(i)]

			if buffConfig.type == 0 then
				self.vs["cardIcon"..tostring(i)]:set_sprite_name("yzsl_shengminghuifutu");
                cardTitle:set_text(_UIText[1])
				--self.vs["cardTitle"..tostring(i)]:set_sprite_name("yzsl_huifuxueliang");
				self.vs["cardIconBg"..tostring(i)]:set_sprite_name("yzsl_diguang3");
				--self.vs["cardEffectNum"..tostring(i)]:set_text(tostring(buffConfig.effect*100).."%");
				self.vs["cardStarCost"..tostring(i)]:set_text(tostring(buffConfig.stars_price));
				self.vs["cardEffectDesc"..tostring(i)]:set_text("恢复选定角色"..tostring(buffConfig.effect*100).."%生命值");
			elseif buffConfig.type == 1 then 
				self.vs["cardIcon"..tostring(i)]:set_sprite_name("yzsl_shengminghuifutu");
                cardTitle:set_text(_UIText[1])
				--self.vs["cardTitle"..tostring(i)]:set_sprite_name("yzsl_huifuxueliang");
				self.vs["cardIconBg"..tostring(i)]:set_sprite_name("yzsl_diguang3");
				--self.vs["cardEffectNum"..tostring(i)]:set_text(tostring(buffConfig.effect*100).."%");
				self.vs["cardStarCost"..tostring(i)]:set_text(tostring(buffConfig.stars_price));
				self.vs["cardEffectDesc"..tostring(i)]:set_text("恢复全体角色"..tostring(buffConfig.effect*100).."%生命值");
			else 
				local name = gs_string_property_name[buffConfig.type];
                cardTitle:set_text(tostring(name))
				if buffConfig.type == ENUM.EHeroAttribute.atk_power then 
					self.vs["cardIcon"..tostring(i)]:set_sprite_name("yzsl_gongjitu");
					--self.vs["cardTitle"..tostring(i)]:set_sprite_name("yzsl_gongji");
					self.vs["cardIconBg"..tostring(i)]:set_sprite_name("yzsl_diguang1");
				elseif buffConfig.type == ENUM.EHeroAttribute.def_power then 
					self.vs["cardIcon"..tostring(i)]:set_sprite_name("yzsl_fangyutu");
					--self.vs["cardTitle"..tostring(i)]:set_sprite_name("yzsl_fangyu");
					self.vs["cardIconBg"..tostring(i)]:set_sprite_name("yzsl_diguang2");
				elseif buffConfig.type == ENUM.EHeroAttribute.parry_rate then 
					self.vs["cardIcon"..tostring(i)]:set_sprite_name("yzsl_gedangtu");
					--self.vs["cardTitle"..tostring(i)]:set_sprite_name("yzsl_gedang");
					self.vs["cardIconBg"..tostring(i)]:set_sprite_name("yzsl_diguang3");
				elseif buffConfig.type == ENUM.EHeroAttribute.crit_rate then 
					self.vs["cardIcon"..tostring(i)]:set_sprite_name("yzsl_baoji");
					--self.vs["cardTitle"..tostring(i)]:set_sprite_name("yzsl_baojilv");
					self.vs["cardIconBg"..tostring(i)]:set_sprite_name("yzsl_diguang1");
				elseif buffConfig.type == ENUM.EHeroAttribute.anti_crite then 
					self.vs["cardIcon"..tostring(i)]:set_sprite_name("yzsl_mianbaolvtu");
					--self.vs["cardTitle"..tostring(i)]:set_sprite_name("yzsl_mianbaolv");
					self.vs["cardIconBg"..tostring(i)]:set_sprite_name("yzsl_diguang2");
				elseif buffConfig.type == ENUM.EHeroAttribute.crit_hurt then 
					self.vs["cardIcon"..tostring(i)]:set_sprite_name("yzsl_baoshangjiachengtu");
					--self.vs["cardTitle"..tostring(i)]:set_sprite_name("yzsl_baoshangjiacheng");
					self.vs["cardIconBg"..tostring(i)]:set_sprite_name("yzsl_diguang1");
				elseif buffConfig.type == ENUM.EHeroAttribute.broken_rate then 
					self.vs["cardIcon"..tostring(i)]:set_sprite_name("yzsl_pojilvtu");
					--self.vs["cardTitle"..tostring(i)]:set_sprite_name("yzsl_pojilv");
					self.vs["cardIconBg"..tostring(i)]:set_sprite_name("yzsl_diguang1");
				elseif buffConfig.type == ENUM.EHeroAttribute.parry_plus then 
					self.vs["cardIcon"..tostring(i)]:set_sprite_name("yzsl_gedangshanghaitu");
					--self.vs["cardTitle"..tostring(i)]:set_sprite_name("yzsl_gedangshanghai");
					self.vs["cardIconBg"..tostring(i)]:set_sprite_name("yzsl_diguang2");
				elseif buffConfig.type == ENUM.EHeroAttribute.bloodsuck_rate then 
					self.vs["cardIcon"..tostring(i)]:set_sprite_name("yzsl_xixuetu");
					--self.vs["cardTitle"..tostring(i)]:set_sprite_name("yzsl_xixuelv");
					self.vs["cardIconBg"..tostring(i)]:set_sprite_name("yzsl_diguang3");
				elseif buffConfig.type == ENUM.EHeroAttribute.rally_rate then 
					self.vs["cardIcon"..tostring(i)]:set_sprite_name("yzsl_fantanlvtu");
					--self.vs["cardTitle"..tostring(i)]:set_sprite_name("yzsl_fantanlv");
					self.vs["cardIconBg"..tostring(i)]:set_sprite_name("yzsl_diguang1");
				elseif buffConfig.type == ENUM.EHeroAttribute.max_hp then 
					self.vs["cardIcon"..tostring(i)]:set_sprite_name("yzsl_shengmingzhitu");
					--self.vs["cardTitle"..tostring(i)]:set_sprite_name("yzsl_shengmingzhi");
					self.vs["cardIconBg"..tostring(i)]:set_sprite_name("yzsl_diguang3");
				end 
				--self.vs["cardEffectNum"..tostring(i)]:set_text(tostring(math.floor(buffConfig.effect*100)).."%");
				self.vs["cardStarCost"..tostring(i)]:set_text(tostring(buffConfig.stars_price));
				if name == nil then 
					app.log("未知的属性名称 type = "..tostring(buffConfig.type));
					name = "属性"..tostring(buffConfig.type);
				end
				self.vs["cardEffectDesc"..tostring(i)]:set_text("提高"..tostring(name)..tostring(math.floor(buffConfig.effect*100)).."%");
			end 
		end 
		--[[if self.buffInfo.buff_data[1].sell == true and self.buffInfo.buff_data[1].sell == true and self.buffInfo.buff_data[1].sell == true then 
			self:onCloseClick();
		end--]]
	end
	self.vs.starNumLab:set_text(tostring(g_dataCenter.trial:get_star()));
end 

function TrialBuyBuff:onPressCard(name,isStart,x,y,obj)
	if isStart then 
		Tween.addTween(obj,0.1,{["local_scale"] = {1.05,1.05,1.05}},Transitions.EASE_OUT);
	else 
		Tween.addTween(obj,0.1,{["local_scale"] = {1,1,1}},Transitions.EASE_IN_OUT);
	end
end 

function TrialBuyBuff:onClickNext()
	self.buffInfo = table.remove(self.buffInfos,1);
	self:UpdateUI();
end 

function TrialBuyBuff:onClickCard1()
	if self.buffInfo ~= nil and self.buffInfo.buff_data[1].sell == false then 
		if g_dataCenter.trial:get_star() >= self.buffConfig[1].stars_price then 
			if self.buffConfig[1].type == 0 then 
				TrialRecoverRole.PopPanel(self.buffInfo.levelid,0);
			else 
				g_dataCenter.trial:buy_buff(self.buffInfo.levelid,0);
			end 
		else 
			FloatTip.Float("细胞浓度不足");
		end
	end 
end 

function TrialBuyBuff:onClickCard2()
	if self.buffInfo ~= nil and self.buffInfo.buff_data[2].sell == false then 
		if g_dataCenter.trial:get_star() >= self.buffConfig[2].stars_price then 
			if self.buffConfig[2].type == 0 then 
				TrialRecoverRole.PopPanel(self.buffInfo.levelid,1);
			else 
				g_dataCenter.trial:buy_buff(self.buffInfo.levelid,1);
			end 
		else 
			FloatTip.Float("细胞浓度不足");
		end
	end 
end 

function TrialBuyBuff:onClickCard3()
	if self.buffInfo ~= nil and self.buffInfo.buff_data[3].sell == false then 
		if g_dataCenter.trial:get_star() >= self.buffConfig[3].stars_price then 
			if self.buffConfig[3].type == 0 then 
				TrialRecoverRole.PopPanel(self.buffInfo.levelid,2);
			else 
				g_dataCenter.trial:buy_buff(self.buffInfo.levelid,2);
			end 
		else 
			FloatTip.Float("细胞浓度不足");
		end
	end 
end 

function TrialBuyBuff:onStarNumChange()
	self.vs.starNumLab:set_text(tostring(g_dataCenter.trial:get_star()));
end 

function TrialBuyBuff:onTrialBuffInfoChange()
	if self.buffInfo ~= nil and g_dataCenter.trial.buffInfo ~= nil then 
		for k,v in pairs(g_dataCenter.trial.buffInfo) do 
			if v.levelid == self.buffInfo.levelid then 
				self.buffInfo = v;
				--app.log("buff购买刷新："..table.tostring(self.buffInfo));
				self:UpdateUI();
				break;
			end
		end
	end
end 

function TrialBuyBuff:onCloseClick()
	local function doClose()
		self:Hide();
		self:DestroyUi();
	end
	if #self.buffInfos > 0 then 
		HintUI.SetAndShowNew(EHintUiType.two,"提示","还有BUFF可购买，是否放弃购买？",nil,{str = "确定",func = doClose},{str = "取消"});
	else 
		if self.buffInfo.buff_data[1].sell == false and g_dataCenter.trial:get_star() >= self.buffConfig[1].stars_price or 
			self.buffInfo.buff_data[2].sell == false and g_dataCenter.trial:get_star() >= self.buffConfig[2].stars_price or 
			self.buffInfo.buff_data[3].sell == false and g_dataCenter.trial:get_star() >= self.buffConfig[3].stars_price
		then 
			HintUI.SetAndShowNew(EHintUiType.two,"提示","还有BUFF可购买，是否放弃购买？",nil,{str = "确定",func = doClose},{str = "取消"});
		else 
			doClose();
		end
	end 
	
end 

function TrialBuyBuff:Init(data)
	--app.log("TrialBuyBuff:Init");
    self.pathRes = "assetbundles/prefabs/ui/expedition_trial/ui_6006_yuan_zheng.assetbundle";
	UiBaseClass.Init(self, data);
end

function TrialBuyBuff.Destroy()
	if TrialBuyBuff.instance ~= nil then 
		TrialBuyBuff.instance:Hide();
		TrialBuyBuff.instance:DestroyUi();
	end
end 

--析构函数
function TrialBuyBuff:DestroyUi()
	--app.log("TrialBuyBuff:DestroyUi");
	TrialBuyBuff.instance = nil;
	if self.vs ~= nil then 
		self.vs = nil;
	end 
    UiBaseClass.DestroyUi(self);
	if TrialScene.instance ~= nil then 
		Tween.continue(TrialScene.instance.modelPlayer);
	end 
    --Root.DelUpdate(self.Update, self)
end

function TrialBuyBuff.ShowInstance()
	if TrialBuyBuff.instance then 
		TrialBuyBuff.instance:Show();
	end
end 

function TrialBuyBuff.HideInstance()
	if TrialBuyBuff.instance then 
		TrialBuyBuff.instance:Hide();
	end
end 
--显示ui
function TrialBuyBuff:Show()
	--app.log("TrialBuyBuff:Show");
    UiBaseClass.Show(self);
end

--隐藏ui
function TrialBuyBuff:Hide()
	--app.log("TrialBuyBuff:Hide");
    UiBaseClass.Hide(self);
	if TrialScene.instance ~= nil then 
		Tween.continue(TrialScene.instance.modelPlayer);
	end 
end

--注册消息分发回调函数
function TrialBuyBuff:MsgRegist()
	--app.log("TrialBuyBuff:MsgRegist");
	PublicFunc.msg_regist("trial.serverBuffList",self.bindfunc['onTrialBuffInfoChange']);
	PublicFunc.msg_regist("trial.setStarNum",self.bindfunc['onStarNumChange']);
    UiBaseClass.MsgRegist(self);
end

--注销消息分发回调函数
function TrialBuyBuff:MsgUnRegist()
	--app.log("TrialBuyBuff:MsgUnRegist");
	PublicFunc.msg_unregist("trial.serverBuffList",self.bindfunc['onTrialBuffInfoChange']);
	PublicFunc.msg_unregist("trial.setStarNum",self.bindfunc['onStarNumChange']);
    UiBaseClass.MsgUnRegist(self);
end