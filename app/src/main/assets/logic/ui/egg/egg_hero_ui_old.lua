-- EggHeroUi = Class('EggHeroUi', UiBaseClass);


-- local uiText = 
-- {
-- 	[1] = '成功购买%s*%d，赠送:',
-- 	[2] = '此角色已经拥有,自动转化为%s*%d,可用于升星和潜能强化。',
-- }


-- function EggHeroUi:Init(data)
-- 	self.pathRes = "assetbundles/prefabs/ui/egg/ui_2601_egg.assetbundle";
-- 	-- self.pathRes = "assetbundles/prefabs/ui/egg/ui_2601_egg_hero.assetbundle";
-- 	UiBaseClass.Init(self, data);
-- end

-- function EggHeroUi:InitData(data)
-- 	UiBaseClass.InitData(self, data);
-- 	self.heroGoldTimeId = nil;
-- 	self.heroCrystalTimeId = nil;
-- 	self.freeGoldTimes = 0;
-- 	self.freeCrystalTimes = 0;
-- 	self.heroGoldCD = 0;
-- 	self.heroCrystalCD = 0;

-- 	self.m_is_destory = true;
-- 	self.m_type = 0;
-- 	------------

-- end

-- function EggHeroUi:RegistFunc()
-- 	UiBaseClass.RegistFunc(self);
-- 	self.bindfunc["on_hero_time_gold"] = Utility.bind_callback(self,EggHeroUi.on_hero_time_gold);
-- 	self.bindfunc["on_hero_time_crystal"] = Utility.bind_callback(self,EggHeroUi.on_hero_time_crystal);
-- 	self.bindfunc["on_gold_buy"] = Utility.bind_callback(self,EggHeroUi.on_gold_buy);
-- 	self.bindfunc["on_crystal_buy"] = Utility.bind_callback(self,EggHeroUi.on_crystal_buy);
-- 	self.bindfunc["on_back"] = Utility.bind_callback(self,EggHeroUi.on_back);
-- 	self.bindfunc["on_rule"] = Utility.bind_callback(self,EggHeroUi.on_rule);

-- 	self.bindfunc["on_btn_hero_1_gold"] = Utility.bind_callback(self,EggHeroUi.on_btn_hero_1_gold);
-- 	self.bindfunc["on_btn_hero_10_gold"] = Utility.bind_callback(self,EggHeroUi.on_btn_hero_10_gold);
-- 	self.bindfunc["on_btn_hero_1_crystal"] = Utility.bind_callback(self,EggHeroUi.on_btn_hero_1_crystal);
-- 	self.bindfunc["on_btn_hero_10_crystal"] = Utility.bind_callback(self,EggHeroUi.on_btn_hero_10_crystal);

-- 	self.bindfunc["on_hero_1"] = Utility.bind_callback(self,EggHeroUi.on_hero_1);
-- 	self.bindfunc["on_hero_10"] = Utility.bind_callback(self,EggHeroUi.on_hero_10);

-- 	self.bindfunc["on_exchange_hero"] = Utility.bind_callback(self,EggHeroUi.on_exchange_hero);
-- 	self.bindfunc["gc_exchange_hero"] = Utility.bind_callback(self,EggHeroUi.gc_exchange_hero);

-- 	self.bindfunc["gc_hero_info_gold"] = Utility.bind_callback(self,EggHeroUi.gc_hero_info_gold);
-- 	self.bindfunc["gc_hero_info_crystal"] = Utility.bind_callback(self,EggHeroUi.gc_hero_info_crystal);
-- 	self.bindfunc["gc_use"] = Utility.bind_callback(self,EggHeroUi.gc_use);

-- 	--------------------
-- 	self.bindfunc["on_anim_change_click"] = Utility.bind_callback(self, self.on_anim_change_click);
-- 	self.bindfunc["on_external"] = Utility.bind_callback(self, self.on_external);

-- 	EggHeroUi.blue = Utility.bind_callback(self, self.onBlueDisplay);
-- 	EggHeroUi.yellow = Utility.bind_callback(self, self.onYellowDisplay);
-- end

-- function EggHeroUi:MsgRegist()
-- 	UiBaseClass.MsgRegist(self);
--     PublicFunc.msg_regist(msg_activity.gc_sync_gold_niudan_role_info,self.bindfunc['gc_hero_info_gold']);
--     PublicFunc.msg_regist(msg_activity.gc_niudan_sync_role_info,self.bindfunc['gc_hero_info_crystal']);
--     PublicFunc.msg_regist(msg_activity.gc_niudan_use,self.bindfunc['gc_use']);
--     PublicFunc.msg_regist(msg_activity.gc_activity_config,self.bindfunc['gc_exchange_hero']);
-- end

-- function EggHeroUi:MsgUnRegist()
-- 	app.log("--------des " .. tostring(self.m_is_destory));
-- 	-- if self.m_is_destory then
-- 		UiBaseClass.MsgUnRegist(self);
-- 	    PublicFunc.msg_unregist(msg_activity.gc_sync_gold_niudan_role_info,self.bindfunc['gc_hero_info_gold']);
-- 	    PublicFunc.msg_unregist(msg_activity.gc_niudan_sync_role_info,self.bindfunc['gc_hero_info_crystal']);
-- 	    PublicFunc.msg_unregist(msg_activity.gc_niudan_use,self.bindfunc['gc_use']);
-- 	    PublicFunc.msg_unregist(msg_activity.gc_activity_config,self.bindfunc['gc_exchange_hero']);
-- 	-- end
-- end

-- function EggHeroUi:InitUI(asset_obj)
-- 	UiBaseClass.InitUI(self, asset_obj)
-- 	self.ui:set_name("egg_hero_ui")
	
-- 	self.m_panel_1 = self.ui:get_child_by_name("egg_hero_ui/centre_other/animation/sp_di1"); --面板1
-- 	self.m_cont_1 = self.ui:get_child_by_name("egg_hero_ui/centre_other/animation/cont1"); -- 背景1-带动画
-- 	self.m_panel_1_content_1 = self.ui:get_child_by_name("egg_hero_ui/centre_other/animation/sp_di1/content1");--面板1——1
-- 	self.m_panel_1_content_2 = self.ui:get_child_by_name("egg_hero_ui/centre_other/animation/sp_di1/content2"); -- 面板1-2
-- 	local award_gold_see = self.m_panel_1_content_2:get_child_by_name("sp");
-- 	award_gold_see:set_active(false);

-- 	self.m_panel_2 = self.ui:get_child_by_name("egg_hero_ui/centre_other/animation/sp_di2");
-- 	self.m_cont_2 = self.ui:get_child_by_name("egg_hero_ui/centre_other/animation/cont2");
-- 	self.m_panel_2_content_1 = self.ui:get_child_by_name("egg_hero_ui/centre_other/animation/sp_di2/content1");
-- 	self.m_panel_2_content_2 = self.ui:get_child_by_name("egg_hero_ui/centre_other/animation/sp_di2/content2");
-- 	local award_crystal_see = self.m_panel_2_content_2:get_child_by_name("sp");
-- 	award_crystal_see:set_active(false);

-- 	self.m_anim_obj = self.ui:get_child_by_name("egg_hero_ui/centre_other/animation");

-- 	-- do return end
-- 	---------------hero--------------
-- 	local nodeLeft = self.ui:get_child_by_name("egg_hero_ui/centre_other/animation/sp_di1/content2"); -- 金币
-- 	self.spGold_1Cost = ngui.find_sprite(nodeLeft,"sp_di1/sp") -- 金币图标
-- 	self.spGold_1Cost:set_sprite_name("dh_jinbi");
-- 	self.spGold_10Cost = ngui.find_sprite(nodeLeft, "sp_di2/sp") 
-- 	self.spGold_10Cost:set_sprite_name("dh_jinbi");
-- 	self.labGold_1Cost = ngui.find_label(nodeLeft,"sp_di1/lab1") -- 一次金币招募所需金币
-- 	-- self.labGold_1Free = ngui.find_label(nodeLeft,"sp_bk1/lab") -- 免费
-- 	self.labGold_10Cost = ngui.find_label(nodeLeft,"sp_di2/lab1") --10次金币招募所需金币

-- 	self.labGold_1Tips = ngui.find_label(nodeLeft, "sp_bk1/lab"); -- 一次tips
-- 	-- self.labGold_1Tips:set_active(false);
-- 	-- self.labGold_1Tips:set_text("5次后必得角色碎片");
-- 	self.labGold_10Tips = ngui.find_label(nodeLeft,"sp_bk2/lab") -- 必得角色碎片
-- 	self.labGold_1Timer = ngui.find_label(nodeLeft,"lab_num") --免费次数和下次免费时间

-- 	self.spGold_1Cost_1 = ngui.find_sprite(self.m_panel_1_content_1,"sp_bk/sp") -- 金币图标,界面1
-- 	self.spGold_1Cost_1:set_sprite_name("dh_jinbi");
-- 	self.labGold_1Timer_1 = ngui.find_label(self.m_panel_1_content_1, "lab_num"); -- 第一个界面免费次数和下次免费时间
-- 	self.labGold_1Free_1 = ngui.find_label(self.m_panel_1_content_1,"sp_bk/lab") -- 免费， 第一个界面
-- 	self.labGold_1Cost_1 = ngui.find_label(self.m_panel_1_content_1,"sp_bk/lab1") --1次金币招募所需金币，第一个界面
-- 	self.labGold_sp_point = ngui.find_sprite(self.m_panel_1_content_1, "sp_bk/sp_point");-- 小红点

-- 	local btnGold_1 = ngui.find_button(nodeLeft,"btn_1"); -- 买一次按钮
-- 	local btnGold_10 = ngui.find_button(nodeLeft,"btn_2"); -- 买10次按钮
-- 	btnGold_1:set_on_click(self.bindfunc['on_btn_hero_1_gold'])
-- 	btnGold_10:set_on_click(self.bindfunc['on_btn_hero_10_gold'])

-- 	local nodeRight = self.ui:get_child_by_name("egg_hero_ui/centre_other/animation/sp_di2/content2"); -- 钻石
-- 	self.spCrystal_1Cost = ngui.find_sprite(nodeRight,"sp_di1/sp")
-- 	self.labCrystal_1Cost = ngui.find_label(nodeRight,"sp_di1/lab1")
-- 	-- self.labCrystal_1Free = ngui.find_label(nodeRight,"sp_bk1/lab")
-- 	self.labCrystal_10Cost = ngui.find_label(nodeRight,"sp_di2/lab1")
-- 	self.labCrystal_10Tips = ngui.find_label(nodeRight,"sp_bk2/lab")
-- 	self.labCrystal_1Tips = ngui.find_label(nodeRight,"sp_bk1/lab")
-- 	self.labCrystal_1Timer = ngui.find_label(nodeRight,"lab_num")

-- 	self.labCrystal_1Timer_1 = ngui.find_label(self.m_panel_2_content_1, "lab_num"); -- 第一个界面免费次数和下次免费时间，界面1
-- 	self.labCrystal_1Free_1 = ngui.find_label(self.m_panel_2_content_1,"sp_bk/lab") -- 免费， 界面1
-- 	self.labCrystal_1Cost_1 = ngui.find_label(self.m_panel_2_content_1,"sp_bk/lab1") --1次钻石招募所需钻石，界面1
-- 	self.labCrystal_sp_point = ngui.find_sprite(self.m_panel_2_content_1, "sp_bk/sp_point");-- 小红点

-- 	local btnCrystal_1 = ngui.find_button(nodeRight,"btn_1");
-- 	local btnCrystal_10 = ngui.find_button(nodeRight,"btn_2");
-- 	btnCrystal_1:set_on_click(self.bindfunc['on_btn_hero_1_crystal'])
-- 	btnCrystal_10:set_on_click(self.bindfunc['on_btn_hero_10_crystal'])

-- 	self:SetInitUIState();
-- --	self.labCrystalTotal = ngui.find_label(self.ui, "egg_hero_ui/centre_other/sp_bk1/lab")
-- --	self.labGoldTotal = ngui.find_label(self.ui, "egg_hero_ui/centre_other/sp_bk2/lab")
-- --	local btnCrystalTotal = ngui.find_button(self.ui, "egg_hero_ui/centre_other/sp_bk1")
-- --	local btnGoldTotal = ngui.find_button(self.ui, "egg_hero_ui/centre_other/sp_bk2")
-- --	local btnClose = ngui.find_button(self.ui, "egg_hero_ui/centre_other/btn_fork")
-- --	btnCrystalTotal:set_on_click(self.bindfunc['on_crystal_buy'])
-- --	btnGoldTotal:set_on_click(self.bindfunc['on_gold_buy'])
-- --	btnClose:set_on_click(self.bindfunc['on_back'])

--     -- local btn = ngui.find_button(self.ui, 'btn_exchange')
--     -- btn:set_active(false)

-- 	self:UpdateUi();
-- end

-- function EggHeroUi:GetCost(type, isOne)
-- 	local vipLevel = g_dataCenter.player:GetVip();
	
-- 	local vip = ConfigManager.Get(EConfigIndex.t_vip_data,vipLevel);
-- 	local dis = 1;
-- 	if vip then
-- 		if vip.niudan_dis then
-- 			dis = vip.niudan_dis;
-- 		end
-- 	end

-- 	local config = ConfigManager.Get(EConfigIndex.t_niudan_cost, type);
-- 	local colnumName
-- 	if isOne then
-- 		colnumName = "once_cost"
-- 	else
-- 		colnumName = "ten_cost"
-- 	end

-- 	return config[colnumName] * dis
-- end

-- function EggHeroUi:UpdateUi()
-- 	if self.ui == nil then return end


-- 	-- self.m_panel_1_content_1:set_active(true);
-- 	-- self.m_panel_1_content_2:set_active(false);

-- 	-- self.m_panel_1_content_1:set_active(true);
-- 	-- self.m_panel_1_content_2:set_active(false);
-- --	self.labGoldTotal:set_text(tostring(PropsEnum.GetValue(IdConfig.Gold)))
-- --	self.labCrystalTotal:set_text(tostring(PropsEnum.GetValue(IdConfig.Crystal)))

-- -- 	local level = g_dataCenter.player:GetLevel();
-- -- 	local vip = ConfigManager.Get(EConfigIndex.t_vip_data,level);
-- -- 	local dis = 1;
-- -- 	if vip then
-- -- 		if vip.niudan_dis then
-- -- 			dis = vip.niudan_dis;
-- -- 		end
-- -- 	end

-- 	--local config = ConfigManager.Get(EConfigIndex.t_niudan_cost, ENUM.NiuDanType.Hero);
-- 	-- self.labCrystal_10Cost:set_text(""..config.ten_cost*dis);
-- 	-- self.labCrystal_1Cost:set_text(""..config.once_cost*dis);
-- 	-- self.labCrystal_1Cost_1:set_text(""..config.once_cost*dis);
-- 	self.labCrystal_10Cost:set_text(""..self:GetCost(ENUM.NiuDanType.Hero, false));
-- 	self.labCrystal_1Cost:set_text(""..self:GetCost(ENUM.NiuDanType.Hero, true));
-- 	self.labCrystal_1Cost_1:set_text(""..self:GetCost(ENUM.NiuDanType.Hero, true));
-- 	--config = ConfigManager.Get(EConfigIndex.t_niudan_cost, ENUM.NiuDanType.Gold);
-- 	-- self.labGold_10Cost:set_text(""..config.ten_cost*dis);
-- 	-- self.labGold_1Cost:set_text(""..config.once_cost*dis);
-- 	-- self.labGold_1Cost_1:set_text(""..config.once_cost*dis);
-- 	self.labGold_10Cost:set_text(""..self:GetCost(ENUM.NiuDanType.Gold, false));
-- 	self.labGold_1Cost:set_text(""..self:GetCost(ENUM.NiuDanType.Gold, true));
-- 	self.labGold_1Cost_1:set_text(""..self:GetCost(ENUM.NiuDanType.Gold, true));

-- 	local max = ConfigManager.Get(EConfigIndex.t_discrete,83000040).data or 1;
-- 	local heroOnceRestCnt = g_dataCenter.egg:surplusMustGetHeroCnt();
-- 	if heroOnceRestCnt == 10 then
-- 		self.labCrystal_1Tips:set_text("本次必得角色");
-- 	else
-- 		self.labCrystal_1Tips:set_text(heroOnceRestCnt.."次后必得角色");
-- 	end

-- 	local heroOnceRestCntGold = g_dataCenter.egg:surplusMustGetHeroCntGold();
-- 	if heroOnceRestCntGold == 10 then
-- 		self.labGold_1Tips:set_text("本次必得角色碎片");
-- 	else
-- 		self.labGold_1Tips:set_text(heroOnceRestCntGold.."次后必得角色碎片");
-- 	end

-- 	local useHeroTenCnt = g_dataCenter.egg:GetUseHeroTenCnt();
-- 	if useHeroTenCnt == 0 then
-- 		self.labCrystal_10Tips:set_text("必得S级角色");
-- 	else
-- 		self.labCrystal_10Tips:set_text("必得角色");
-- 	end

-- 	self.labGold_10Tips:set_text("必得角色碎片");
	

-- 	self:UpdateGoldTime();
-- 	self:UpdateCrystalTime();
-- end

-- function EggHeroUi:UpdateGoldTime()
-- 	if not self.ui then return end

-- 	if self.heroGoldCD > 0 then
-- 		local str = "[ffffff]"..self:_GetTime(self.heroGoldCD).."[-]后免费抽取";
-- 		self.labGold_1Timer:set_text(str)
-- 		self.labGold_1Timer_1:set_text(str);
-- 		-- self.labGold_1Free:set_active(false)
-- 		self.labGold_1Free_1:set_active(false);
-- 		self.labGold_1Cost:set_active(true)
-- 		self.labGold_1Cost_1:set_active(true)
-- 		self.spGold_1Cost:set_active(true)
-- 		self.labGold_sp_point:set_active(false);
-- 	elseif self.freeGoldTimes > 0 then
-- 		self.labGold_1Timer:set_text("今日免费次数："..self.freeGoldTimes)
-- 		self.labGold_1Timer_1:set_text("今日免费次数："..self.freeGoldTimes)
-- 		-- self.labGold_1Free:set_active(true)
-- 		self.labGold_1Free_1:set_active(true)
-- 		self.labGold_1Cost:set_active(true);
-- 		self.labGold_1Cost_1:set_active(false);
-- 		self.labGold_1Cost:set_text("免费  ");
-- 		self.spGold_1Cost:set_active(false)
-- 		self.labGold_sp_point:set_active(true);
-- 	else
-- 		self.labGold_1Timer:set_text("")
-- 		self.labGold_1Timer_1:set_text("");
-- 		-- self.labGold_1Free:set_active(false)
-- 		self.labGold_1Free_1:set_active(false)
-- 		self.labGold_1Cost:set_active(true)
-- 		self.labGold_1Cost_1:set_active(true);
-- 		self.spGold_1Cost:set_active(true)
-- 		self.labGold_sp_point:set_active(true);
-- 	end
-- end

-- function EggHeroUi:UpdateCrystalTime()
-- 	if not self.ui then return end

-- 	-- do return end
-- 	if self.heroCrystalCD > 0 then
-- 		local str = "[ffffff]"..self:_GetTime(self.heroCrystalCD).."[-]后免费抽取";
-- 		self.labCrystal_1Timer:set_text(str)
-- 		self.labCrystal_1Timer_1:set_text(str);
-- 		-- self.labCrystal_1Free:set_active(false)
-- 		self.labCrystal_1Free_1:set_active(false)
-- 		self.labCrystal_1Cost:set_active(true)
-- 		self.labCrystal_1Cost_1:set_active(true);
-- 		self.spCrystal_1Cost:set_active(true)
-- 		self.labCrystal_sp_point:set_active(false);
-- 	elseif self.freeCrystalTimes > 0 then
-- 		self.labCrystal_1Timer:set_text("免费")
-- 		self.labCrystal_1Timer_1:set_text("免费")
-- 		-- self.labCrystal_1Free:set_active(true)
-- 		self.labCrystal_1Free_1:set_active(true)
-- 		self.labCrystal_1Cost:set_active(true);
-- 		self.labCrystal_1Cost_1:set_active(false);
-- 		self.labCrystal_1Cost:set_text("免费  ")
-- 		self.spCrystal_1Cost:set_active(false)
-- 		self.labCrystal_sp_point:set_active(true);
-- 	else
-- 		self.labCrystal_1Timer:set_text("")
-- 		self.labCrystal_1Timer_1:set_text("")
-- 		-- self.labCrystal_1Free:set_active(false)
-- 		self.labCrystal_1Free_1:set_active(false)
-- 		self.labCrystal_1Cost:set_active(true)
-- 		self.labCrystal_1Cost_1:set_active(true);
-- 		self.spCrystal_1Cost:set_active(true)
-- 		self.labCrystal_sp_point:set_active(true);
-- 	end
-- end

-- function EggHeroUi:on_gold_buy()
-- 	uiManager:PushUi(EUI.GoldExchangeUI)
-- end

-- function EggHeroUi:on_crystal_buy()
-- 	uiManager:PushUi(EUI.StoreUI)
-- end

-- function EggHeroUi:on_back()
-- 	uiManager:PopUi();
-- end

-- function EggHeroUi:on_rule(t)
-- 	UiRuleDes.Start(t.float_value);
-- end

-- function EggHeroUi:on_btn_hero_1_gold()
-- 	msg_activity.cg_niudan_use(ENUM.NiuDanType.Gold,false);
-- end

-- function EggHeroUi:on_btn_hero_1_crystal()
-- 	msg_activity.cg_niudan_use(ENUM.NiuDanType.Hero,false);
-- end

-- function EggHeroUi:on_hero_1()
-- 	msg_activity.cg_niudan_use(ENUM.NiuDanType.Hero,false);
-- end

-- function EggHeroUi:on_btn_hero_10_gold()
-- 	msg_activity.cg_niudan_use(ENUM.NiuDanType.Gold,true);
-- end

-- function EggHeroUi:on_btn_hero_10_crystal()
-- 	msg_activity.cg_niudan_use(ENUM.NiuDanType.Hero,true);
-- end

-- function EggHeroUi:on_hero_10()
-- 	msg_activity.cg_niudan_use(ENUM.NiuDanType.Hero,true);
-- end

-- function EggHeroUi:on_exchange_hero()
-- 	msg_activity.cg_activity_config(MsgEnum.eactivity_time.eActivityTime_tongLinZhiHunDuiHuan)
-- 	--uiManager:PushUi(EUI.UiHeroStarUpEgg);
-- end

-- function EggHeroUi:gc_exchange_hero(result, system_id, cf)
-- 	uiManager:PushUi(EUI.UiHeroStarUpEgg);
-- end

-- function EggHeroUi:on_hero_time_gold()
-- 	self.heroGoldCD = math.max(0, self.heroGoldCD - 1);
-- 	if self.heroGoldCD <= 0 then
-- 		self:StopGoldTimer();
-- 	end
-- 	self:UpdateGoldTime();
-- end

-- function EggHeroUi:on_hero_time_crystal()
-- 	self.heroCrystalCD = math.max(0, self.heroCrystalCD - 1);
-- 	if self.heroCrystalCD <= 0 then
-- 		self:StopCrystalTimer();
-- 	end
-- 	self:UpdateCrystalTime();
-- end

-- function EggHeroUi:gc_hero_info_gold(byfreeTime,CDLeftTime,useOnceTimes,userTenTimes)
-- 	self.heroGoldCD = CDLeftTime;
-- 	self.freeGoldTimes = byfreeTime;
-- 	self:StopGoldTimer();
-- 	if self.heroGoldCD > 0 then
-- 		self.heroGoldTimeId = timer.create(self.bindfunc["on_hero_time_gold"],1000,-1);
-- 	end
-- 	self:UpdateGoldTime();
-- end

-- function EggHeroUi:gc_hero_info_crystal(byfreeTime,CDLeftTime,useOnceTimes,userTenTimes)
-- 	self.heroCrystalCD = CDLeftTime;
-- 	self.freeCrystalTimes = byfreeTime;
-- 	self:StopCrystalTimer();
-- 	if self.heroCrystalCD > 0 then
-- 		self.heroCrystalTimeId = timer.create(self.bindfunc["on_hero_time_crystal"],1000,-1);
-- 	end
-- 	self:UpdateCrystalTime();
-- end

-- function EggHeroUi:GetDesString(discreteid, factor)
-- 	local des = nil
-- 	local expItemData = ConfigManager.Get(EConfigIndex.t_discrete,discreteid).data[1];
-- 	if expItemData then
-- 		local itemConfig = ConfigManager.Get(EConfigIndex.t_item, expItemData.number);
-- 		--app.log('-------------- ' .. tostring(expItemData.number) .. ' ' .. table.tostring(itemConfig))
-- 		if itemConfig then
-- 			des = string.format(uiText[1], itemConfig.name, expItemData.count * factor)
-- 		end
-- 	end
-- 	return des
-- end

-- function EggHeroUi:gc_use(result, egg_type, bTen, vecReward, vecItem)
-- 	app.log("gc_niudan_use " .. tostring(result) .. "-" )
-- 	-- 英雄
-- 	if bTen then

-- 		--把必出英雄随机到一个位置
-- 		local randomPos = math.random(1, #vecReward)
-- 		local first = vecReward[1]
-- 		table.remove(vecReward, 1)
-- 		table.insert(vecReward, randomPos, first)
-- 		first = vecItem[1]
-- 		table.remove(vecItem, 1)
-- 		table.insert(vecItem, randomPos, first)

-- 		--CommonHeroAward.Start(vecReward,vecItem,10,true);
-- 		if egg_type == ENUM.NiuDanType.Gold then

-- 			local des = self:GetDesString(MsgEnum.ediscrete_id.eDiscreteID_gold_niudan_fix_reward, 10)

-- 			EggHeroGetTen.Start({vecReward = vecReward, vecItem = vecItem, description = des})
-- 			EggHeroGetTen.SetCallback(self.on_btn_hero_10_gold, self,self.UpdateUi,self);
-- 		elseif egg_type == ENUM.NiuDanType.Hero then

-- 			local des = self:GetDesString(MsgEnum.ediscrete_id.eDiscreteID_crystal_niudan_fix_reward, 10)

-- 			EggHeroGetTen.Start({vecReward = vecReward, vecItem = vecItem, description = des})
-- 			EggHeroGetTen.SetCallback(self.on_btn_hero_10_crystal, self,self.UpdateUi,self);
-- 		end
-- 	else
-- 		--CommonHeroAward.Start(vecReward,vecItem,1,true);
-- 		if vecReward[1] then
-- 			app.log("gc_niudan_use " .. table.tostring(vecReward[1]))
-- 			self.showGetItemsDescription = nil
-- 			if egg_type == ENUM.NiuDanType.Gold then
-- 				self.showGetItemsDescription = self:GetDesString(MsgEnum.ediscrete_id.eDiscreteID_gold_niudan_fix_reward, 1)
-- 			elseif egg_type == ENUM.NiuDanType.Hero then
-- 				self.showGetItemsDescription = self:GetDesString(MsgEnum.ediscrete_id.eDiscreteID_crystal_niudan_fix_reward, 1)
-- 			end

--             self._egg_type = egg_type
--             self.vecReward = vecReward
--             self.vecItem = vecItem

-- 			if PropsEnum.IsRole(vecReward[1].id) then
--                 local ch = CardHuman:new({number = vecReward[1].id, level=1});
-- 				local isNow = vecReward[1].id == vecItem[1].id
-- 				local heroDes = nil
-- 				if not isNow then
-- 					local itemConfig = ConfigManager.Get(EConfigIndex.t_item, vecItem[1].id)
-- 					local name = itemConfig.name
-- 					heroDes = string.format(uiText[2], tostring(name), vecItem[1].count)
-- 				end
--                 EggGetHero.Start(ch, isNow, heroDes)
--                 EggGetHero.SetFinishCallback(EggHeroUi.ShowGetHeroEnd, self)

-- 			else
-- --				CommonAward.Start(vecReward, 1, self.showGetItemsDescription);
-- --				CommonAward.SetFinishCallback(self.UpdateUi, self);
--                 self:ShowGetHeroEnd()
-- 			end
-- 		else
-- 			app.log("奖励列表为空:"..table.tostring(vecReward));
-- 			self:UpdateUi();
-- 		end
-- 	end
-- end

-- function EggHeroUi:ShowGetHeroEnd()
-- 	if not self._egg_type then return end

--     local againCallback = nil
-- 	local costId = nil
-- 	local costNum = nil
--     if self._egg_type == ENUM.NiuDanType.Gold then
--         againCallback = self.on_btn_hero_1_gold

-- 		costId = IdConfig.Gold
-- 		costNum = self:GetCost(ENUM.NiuDanType.Gold, true)
--     elseif self._egg_type == ENUM.NiuDanType.Hero then
--         againCallback = self.on_btn_hero_1_crystal

-- 		costId = IdConfig.Crystal
-- 		costNum = self:GetCost(ENUM.NiuDanType.Hero, true)
--     end
--     EggHeroGetOne.Start({vecReward = self.vecReward, vecItem = self.vecItem, description = self.showGetItemsDescription
-- 		,costItemId = costId, costItemNum = costNum
-- 		});
--     EggHeroGetOne.SetCallback(againCallback, self,self.UpdateUi,self);

--     self._egg_type = nil
--     self.vecReward = nil
--     self.vecItem = nil
-- 	self.showGetItemsDescription = nil
-- end

-- function EggHeroUi:_GetTime(sec)
-- 	local day,hour,min,sec = TimeAnalysis.ConvertSecToDayHourMin(sec);
-- 	local str;
-- 	if tonumber(day) ~= 0 then
-- 		str = string.format("%d天 %02d:%02d:%02d",tonumber(day),tonumber(hour),tonumber(min),tonumber(sec));
-- 		-- str = day.."澶?"..hour..":"..min..":"..sec;
-- 	else
-- 		str = string.format("%02d:%02d:%02d",tonumber(hour),tonumber(min),tonumber(sec));
-- 		-- str = hour..":"..min..":"..sec;
-- 	end
-- 	return str;
-- end

-- function EggHeroUi:StopGoldTimer()
-- 	if self.heroGoldTimeId then
--     	timer.stop(self.heroGoldTimeId );
--     	self.heroGoldTimeId = nil;
--     end
-- end

-- function EggHeroUi:StopCrystalTimer()
-- 	if self.heroCrystalTimeId then
--     	timer.stop(self.heroCrystalTimeId );
--     	self.heroCrystalTimeId = nil;
--     end
-- end

-- function EggHeroUi:on_anim_change_click( t )
-- 	app.log("t:" .. t.float_value);
-- 	self.m_type = t.float_value;
-- 	if t.float_value == 1 then
-- 		uiManager:PushUIStack(EUI.EggHeroUi);
-- 		uiManager:Show();
-- 		self.m_is_destory = false;

-- 		self.m_panel_2:set_active(false);
-- 		self.m_cont_2:set_active(false);

-- 		self.m_panel_1:set_active(true);
-- 		self.m_panel_1_content_1:set_active(false);
-- 		self.m_panel_1_content_2:set_active(true);
-- 		self.m_cont_1:set_active(true);
-- 		self.m_anim_obj:animated_play("ui_2601_egg_blue");

-- 		-- 清除事件
-- 		local panel_1_button = ngui.find_button(self.ui, "egg_hero_ui/centre_other/animation/sp_di1");
-- 		panel_1_button:reset_on_click();
-- 		-- panel_1_button:set_event_value("", 0);
-- 		-- panel_1_button:set_on_click(self.bindfunc["on_anim_change_click"]);
-- 	elseif t.float_value == 2 then
		
-- 		uiManager:PushUIStack(EUI.EggHeroUi);
-- 		uiManager:Show();
-- 		self.m_is_destory = false;

-- 		self.m_panel_1:set_active(false);
-- 		self.m_cont_1:set_active(false);

-- 		self.m_panel_2_content_1:set_active(false);
-- 		self.m_panel_2_content_2:set_active(true);
-- 		self.m_cont_2:set_active(true);
-- 		self.m_anim_obj:animated_play("ui_2601_egg_yellow");

-- 		-- 清除事件
-- 		local panel_2_button = ngui.find_button(self.ui, "egg_hero_ui/centre_other/animation/sp_di2");
-- 		panel_2_button:reset_on_click();
-- 		-- panel_2_button:set_event_value("", 2);
-- 		-- panel_2_button:set_on_click(self.bindfunc["on_anim_change_click"]);
-- 	end
-- end

-- function EggHeroUi:SetInitUIState( )

-- 	self.m_panel_1:set_active(true);
-- 	self.m_panel_2:set_active(true);

-- 	self.m_panel_1_content_1:set_active(true);
-- 	self.m_panel_2_content_1:set_active(true);

-- 	local sp_1_texture = ngui.find_texture(self.m_panel_2_content_1, "Texture");
-- 	sp_1_texture:set_active(true);

-- 	self.m_panel_1_content_2:set_active(false);
-- 	self.m_panel_2_content_2:set_active(false);

-- 	self.m_cont_1:set_active(false);
-- 	self.m_cont_2:set_active(false);


-- 	local panel_1_button = ngui.find_button(self.ui, "egg_hero_ui/centre_other/animation/sp_di1");
-- 	panel_1_button:reset_on_click();
-- 	panel_1_button:set_event_value("", 1);
-- 	panel_1_button:set_on_click(self.bindfunc["on_anim_change_click"]);

-- 	local panel_2_button = ngui.find_button(self.ui, "egg_hero_ui/centre_other/animation/sp_di2");
-- 	panel_2_button:reset_on_click();
-- 	panel_2_button:set_event_value("", 2);
-- 	panel_2_button:set_on_click(self.bindfunc["on_anim_change_click"]);
-- end

-- function EggHeroUi:SetInitUIStateAnim(  )
-- 	if self.m_type == 1 then
-- 		self.m_panel_1:set_active(true);
-- 		self.m_anim_obj:animated_play("ui_2601_egg_blue_back");
-- 	elseif self.m_type == 2 then
-- 		self.m_anim_obj:animated_play("ui_2601_egg_yellow_back");
-- 		self.m_panel_2:set_active(true);
-- 	end
-- 	self.m_is_destory = true;

-- 	self.m_panel_1_content_1:set_active(true);
-- 	self.m_panel_2_content_1:set_active(true);

-- 	local sp_1_texture = ngui.find_texture(self.m_panel_2_content_1, "Texture");
-- 	sp_1_texture:set_active(true);

-- 	self.m_panel_1_content_2:set_active(false);
-- 	self.m_panel_2_content_2:set_active(false);

-- 	-- self.m_cont_1:set_active(false);
-- 	-- self.m_cont_2:set_active(false);


-- 	local panel_1_button = ngui.find_button(self.ui, "egg_hero_ui/centre_other/animation/sp_di1");
-- 	panel_1_button:reset_on_click();
-- 	panel_1_button:set_event_value("", 1);
-- 	panel_1_button:set_on_click(self.bindfunc["on_anim_change_click"]);

-- 	local panel_2_button = ngui.find_button(self.ui, "egg_hero_ui/centre_other/animation/sp_di2");
-- 	panel_2_button:reset_on_click();
-- 	panel_2_button:set_event_value("", 2);
-- 	panel_2_button:set_on_click(self.bindfunc["on_anim_change_click"]);
-- end

-- function EggHeroUi:onBlueDisplay( )
-- 	self.m_panel_1:set_active(true);
-- end

-- function EggHeroUi:onYellowDisplay( )
-- 	self.m_panel_2:set_active(true);
-- end

-- function EggHeroUi:on_navbar_back(  )
-- 	if self.m_is_destory == false then
-- 		uiManager:PopUIStack();
-- 		uiManager:Show();
-- 		self:SetInitUIStateAnim();
-- 		return true;
-- 	else
-- 		return false;
-- 	end
-- end

-- function EggHeroUi:DestroyUi()
--     self:StopGoldTimer()
--     self:StopCrystalTimer()
--     EggHeroUi.yellow = nil;
--     EggHeroUi.blue = nil;
--     UiBaseClass.DestroyUi(self);
-- end

-- function EggHeroUi:Restart(data)
-- 	if UiBaseClass.Restart(self, data) then
-- 		msg_activity.cg_niudan_request_role_info();
-- 	end
-- end

-- function EggHeroUi.onAnimaBlueOver (  )
-- 	app.log("onAnimaBlueOver");
-- 	-- eggHeroUi:onYellowDisplay();
-- 	Utility.call_func(EggHeroUi.yellow);
-- end

-- function EggHeroUi.onAnimaYellowOver (  )
-- 	app.log("onAnimaYellowOver");
-- 	Utility.call_func(EggHeroUi.blue);
-- end

-- return eggHeroUi
