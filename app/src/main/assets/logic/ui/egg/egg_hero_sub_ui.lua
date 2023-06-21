-- EggHeroSubUi = Class("EggHeroSubUi", UiBaseClass);

-- local uiText = 
-- {
--     [1] = '成功购买%s*%d',
--     [2] = '此角色已经拥有,自动转化为%s*%d,可用于升星和潜能强化。',
-- }

-- function EggHeroSubUi:Init(data)
--     self.pathRes = "assetbundles/prefabs/ui/egg/ui_2606_egg.assetbundle";
--     UiBaseClass.Init(self, data);
-- end

-- function EggHeroSubUi:InitData(data)
--     self.heroGoldTimeId = nil;
--     self.heroCrystalTimeId = nil;
--     self.dataCenter = g_dataCenter.egg;
--     self.freeGoldTimes = self.dataCenter.freeHeroTimesGold;
--     self.freeCrystalTimes = self.dataCenter.freeHeroTimes;
--     self.heroGoldCD = self.dataCenter.heroCdTimeGold - system.time();
--     self.heroCrystalCD = self.dataCenter.heroCdTime - system.time();
--     UiBaseClass.InitData(self, data);
-- end

-- function EggHeroSubUi:Restart(data)
--     self.EggType = data.type;
--     if not UiBaseClass.Restart(self, data) then
--         return;
--     end
-- end

-- function EggHeroSubUi:RegistFunc()
--     UiBaseClass.RegistFunc(self);
--     self.bindfunc["gc_hero_info_gold"] = Utility.bind_callback(self,self.gc_hero_info_gold);
--     self.bindfunc["gc_hero_info_crystal"] = Utility.bind_callback(self,self.gc_hero_info_crystal);
--     self.bindfunc["on_hero_time_gold"] = Utility.bind_callback(self, self.on_hero_time_gold);
--     self.bindfunc["on_hero_time_crystal"] = Utility.bind_callback(self, self.on_hero_time_crystal);
--     self.bindfunc["on_click_1"] = Utility.bind_callback(self, self.on_click_1);
--     self.bindfunc["on_click_10"] = Utility.bind_callback(self, self.on_click_10);
--     self.bindfunc["gc_use"] = Utility.bind_callback(self,self.gc_use);
--     self.bindfunc["on_ui_loaded"] = Utility.bind_callback(self, self.on_ui_loaded);
-- end

-- function EggHeroSubUi:MsgRegist()
--     UiBaseClass.MsgRegist(self);
--     PublicFunc.msg_regist(msg_activity.gc_sync_gold_niudan_role_info,self.bindfunc['gc_hero_info_gold']);
--     PublicFunc.msg_regist(msg_activity.gc_niudan_sync_role_info,self.bindfunc['gc_hero_info_crystal']);
--     PublicFunc.msg_regist(msg_activity.gc_niudan_use,self.bindfunc['gc_use']);
-- end

-- function EggHeroSubUi:MsgUnRegist()
--     UiBaseClass.MsgUnRegist(self);
--     PublicFunc.msg_unregist(msg_activity.gc_sync_gold_niudan_role_info,self.bindfunc['gc_hero_info_gold']);
--     PublicFunc.msg_unregist(msg_activity.gc_niudan_sync_role_info,self.bindfunc['gc_hero_info_crystal']);
--     PublicFunc.msg_unregist(msg_activity.gc_niudan_use,self.bindfunc['gc_use']);
-- end

-- function EggHeroSubUi:InitUI(asset_obj)
--     UiBaseClass.InitUI(self, asset_obj);
--     self.bkui = self.ui;
--     self.bkui:set_active(false);
--     self.ui:set_name("EggHeroSubUi");
--     self.parent = self.ui:get_child_by_name("centre_other/animation");
--     self.ui = nil;

--     if self.EggType == ENUM.NiuDanType.Gold then
--         self.res = "assetbundles/prefabs/ui/egg/ui_2603_egg.assetbundle";
--     elseif self.EggType == ENUM.NiuDanType.Hero then
--         self.res = "assetbundles/prefabs/ui/egg/ui_2604_egg.assetbundle";
--     elseif self.EggType == ENUM.NiuDanType.Vip then
--         self.res = "assetbundles/prefabs/ui/egg/ui_2605_egg.assetbundle";
--     end
--     ResourceLoader.LoadAsset(self.res, self.bindfunc['on_ui_loaded'], self.panel_name);
-- end

-- function EggHeroSubUi:on_ui_loaded(pid, filepath, asset_obj, error_info)
--     if filepath ~= self.res then
--         return;
--     end
--     self:InitInfoUI(asset_obj);
--     if self.loadedCallBack then
--         self.loadedCallBack() 
--         self.loadedCallBack = nil
--     end
-- end

-- function EggHeroSubUi:InitInfoUI(asset_obj)
--     if asset_obj then
--         self.ui = asset_game_object.create(asset_obj);
--         if self.EggType == ENUM.NiuDanType.Gold then
--             self.ui:set_name("ui_2603_egg")
--         elseif self.EggType == ENUM.NiuDanType.Hero then
--             self.ui:set_name("ui_2604_egg")
--         elseif self.EggType == ENUM.NiuDanType.Vip then
--             self.ui:set_name("ui_2605_egg")
--         end
--     end
--     self.bkui:set_active(true);
--     self.ui:set_parent(self.parent);
--     self.ui:set_position(0,0,0);
--     if type(self._initData) == 'table' and self._initData.scale ~= nil then
--         sx = self._initData.scale.x
--         sy = self._initData.scale.y
--         sz = self._initData.scale.z
--     else
--         sx,sy,sz = Utility.SetUIAdaptation()
--     end
--     self.ui:set_local_scale(sx,sy,sz);

--     -- self.labTitle1 = ngui.find_label(self.ui,"animation/cont_left/sp_bk/lab");
--     -- self.labTitle2 = ngui.find_label(self.ui,"animation/cont_left/sp_bk/lab/lab1");

--     self.labCost1 = ngui.find_label(self.ui,"animation/cont_left/sp_bk1/sp_bar/lab");
--     self.btnCost1 = ngui.find_button(self.ui,"animation/cont_left/btn_1");
--     self.btnCost1:set_on_click(self.bindfunc["on_click_1"]);
--     -- self.spCost1 = ngui.find_sprite(self.ui,"animation/cont_left/sp_bk1/sp_bar/sp");
--     self.labTips1 = ngui.find_label(self.ui,"animation/cont_left/sp_bk1/lab");
--     self.labTime1 = ngui.find_label(self.ui,"animation/cont_left/sp_bk1/lab_num");
--     -- self.spRedPoint = ngui.find_sprite(self.ui,"animation/cont_left/btn_1/animation/sp_point");

--     self.labCost10 = ngui.find_label(self.ui,"animation/cont_left/sp_bk2/sp_di2/lab");
--     self.btnCost10 = ngui.find_button(self.ui,"animation/cont_left/btn_2");
--     self.btnCost10:set_on_click(self.bindfunc["on_click_10"]);
--     -- self.labBtnCost10 = ngui.find_label(self.ui,"animation/cont_left/btn_2/animation/lab");
--     -- self.spCost10 = ngui.find_sprite(self.ui,"animation/cont_left/sp_bk2/sp_di2/sp");
--     self.labTips10 = ngui.find_label(self.ui,"animation/cont_left/sp_bk2/lab");
--     self.spTips10 = ngui.find_sprite(self.ui,"animation/cont_left/sp_bk2/sp_s");

--     self:UpdateUi();
-- end

-- function EggHeroSubUi:UpdateUi()
--     if not UiBaseClass.UpdateUi(self) then
--         return;
--     end

--     if self.EggType == ENUM.NiuDanType.Gold then
--         self:UpdateGoldUi();
--         self:StartGoldTimer();
--         -- self.spCost1:set_sprite_name("dh_jinbi");
--         -- self.spCost10:set_sprite_name("dh_jinbi");
--     elseif self.EggType == ENUM.NiuDanType.Hero then
--         self:UpdateCrystalUi();
--         self:StartCrystalTimer();
--         -- self.spCost1:set_sprite_name("dh_hongshuijing");
--         -- self.spCost10:set_sprite_name("dh_hongshuijing");
--     elseif self.EggType == 3 then
--         self:UpdateVipUi();
--     end
-- end

-- function EggHeroSubUi:Show()
--     self.showed = true
--     if not self.ui then
--         return false;
--     end
--     self.ui:set_active(true);
--     self.bkui:set_active(true);
--     return true;
-- end

-- function EggHeroSubUi:Hide()
--     self.showed = false
--     if not self.ui then
--         return false;
--     end
--     self.ui:set_active(false);
--     self.bkui:set_active(false);
--     return true;
-- end

-- ------------ 金币 -------------
-- function EggHeroSubUi:UpdateGoldUi()
--     self.labCost10:set_text(""..EggHeroUi.GetCost(ENUM.NiuDanType.Gold, false));
--     self.labCost1:set_text(""..EggHeroUi.GetCost(ENUM.NiuDanType.Gold, true));
--     local maxTimes = ConfigManager.Get(EConfigIndex.t_discrete, 83000070).data;
--     if self.heroGoldCD > 0 then
--         local str = "[ffffff]"..PublicFunc.FormatLeftSecondsEx(self.heroGoldCD,true).."[-]后免费抽取";
--         self.labTime1:set_text(str);
--         self.labCost1:set_text(""..EggHeroUi.GetCost(ENUM.NiuDanType.Gold, true));
--         -- self.spRedPoint:set_active(false);
--     elseif self.freeGoldTimes > 0 then
--         local curTimes = self.freeGoldTimes;
--         self.labTime1:set_text("免费次数: "..curTimes.."/"..maxTimes);
--         self.labCost1:set_text("免费");
--         -- self.spRedPoint:set_active(true);
--     else
--         self.labTime1:set_text("");
--         self.labCost1:set_text(""..EggHeroUi.GetCost(ENUM.NiuDanType.Gold, true));
--         -- self.spRedPoint:set_active(false);
--     end

--     local heroOnceRestCntGold = g_dataCenter.egg:surplusMustGetHeroCntGold();
--     if heroOnceRestCntGold == 10 then
--         self.labTips1:set_text("本次必得角色碎片");
--     else
--         self.labTips1:set_text(heroOnceRestCntGold.."次后必得角色碎片");
--     end
--     -- self.labTips10:set_text("必得角色碎片");
--     -- self.labBtnCost10:set_text("购买10个");
--     -- self.labTitle1:set_text("经验药水");
--     -- self.labTitle2:set_text("(小)");
-- end

-- function EggHeroSubUi:StopGoldTimer()
--     if self.heroGoldTimeId then
--         timer.stop(self.heroGoldTimeId );
--         self.heroGoldTimeId = nil;
--     end
-- end

-- function EggHeroSubUi:StartGoldTimer()
--     self:StopGoldTimer();
--     if self.heroGoldCD > 0 then
--         self.heroGoldTimeId = timer.create(self.bindfunc["on_hero_time_gold"],1000,-1);
--     end
-- end

-- -------------------钻石 ----------
-- function EggHeroSubUi:UpdateCrystalUi()
--     self.labCost10:set_text(""..EggHeroUi.GetCost(ENUM.NiuDanType.Hero, false));
--     if self.heroCrystalCD > 0 then
--         local str = "[ffffff]"..PublicFunc.FormatLeftSecondsEx(self.heroCrystalCD,true).."[-]后免费抽取";
--         self.labTime1:set_text(str);
--         self.labCost1:set_text(""..EggHeroUi.GetCost(ENUM.NiuDanType.Hero, true));
--         -- self.spRedPoint:set_active(false);
--     elseif self.freeCrystalTimes > 0 then
--         self.labTime1:set_text("免费次数: "..self.freeCrystalTimes.."次");
--         self.labCost1:set_text("免费");
--         -- self.spRedPoint:set_active(true);
--     else
--         self.labTime1:set_text("");
--         self.labCost1:set_text(""..EggHeroUi.GetCost(ENUM.NiuDanType.Hero, true));
--         -- self.spRedPoint:set_active(false);
--     end
--     local heroOnceRestCnt = g_dataCenter.egg:surplusMustGetHeroCnt();
--     if heroOnceRestCnt == 10 then
--         self.labTips1:set_text("本次必得角色");
--     else
--         self.labTips1:set_text(heroOnceRestCnt.."次后必得角色");
--     end
--     local useHeroTenCnt = g_dataCenter.egg:GetUseHeroTenCnt();
--     if useHeroTenCnt == 0 then
--         self.labTips10:set_text("必得     级角色整卡");
--         self.spTips10:set_active(true);
--     else
--         self.labTips10:set_text("必得角色整卡");
--         self.spTips10:set_active(false);
--     end
--     -- self.labBtnCost10:set_text("购买10个");
--     -- self.labTitle1:set_text("经验药水");
--     -- self.labTitle2:set_text("(大)");
-- end

-- function EggHeroSubUi:StopCrystalTimer()
--     if self.heroCrystalTimeId then
--         timer.stop(self.heroCrystalTimeId );
--         self.heroCrystalTimeId = nil;
--     end
-- end

-- function EggHeroSubUi:StartCrystalTimer()
--     self:StopCrystalTimer();
--     if self.heroCrystalCD > 0 then
--         self.heroCrystalTimeId = timer.create(self.bindfunc["on_hero_time_crystal"],1000,-1);
--     end
-- end

-- --------------------vip -----------
-- function EggHeroSubUi:UpdateVipUi()
--     self.labCost10:set_text(""..EggHeroUi.GetCost(ENUM.NiuDanType.Vip, false));
--     self.labCost1:set_text(""..EggHeroUi.GetCost(ENUM.NiuDanType.Vip, true));
--     -- self.labTips10:set_text("可获得热点角色碎片");
--     -- self.labTips1:set_text("可获得热点角色碎片");
--     -- self.labTime1:set_text("");
--     -- self.labBtnCost10:set_text("购买5个");
--     -- self.labTitle1:set_text("强者降临");
--     -- self.labTitle2:set_text("");
-- end

-- function EggHeroSubUi:DestroyUi()
--     if self.bkui then
--         self.bkui:set_active(false);
--         self.bkui = nil;
--     end
--     UiBaseClass.DestroyUi(self);
--     self:StopGoldTimer();
--     self:StopCrystalTimer();
-- end

-- function EggHeroSubUi:gc_hero_info_gold(byfreeTime,CDLeftTime,useOnceTimes,userTenTimes)
--     self.heroGoldCD = CDLeftTime;
--     self.freeGoldTimes = byfreeTime;
--     self:StartGoldTimer();
--     self:UpdateGoldUi();
-- end

-- function EggHeroSubUi:gc_hero_info_crystal(byfreeTime,CDLeftTime,useOnceTimes,userTenTimes)
--     self.heroCrystalCD = CDLeftTime;
--     self.freeCrystalTimes = byfreeTime;
--     self:StartCrystalTimer();
--     self:UpdateCrystalUi();
-- end

-- function EggHeroSubUi:on_hero_time_gold()
--     self.heroGoldCD = math.max(0, self.heroGoldCD - 1);
--     if self.heroGoldCD <= 0 then
--         self:StopGoldTimer();
--     end
--     self:UpdateGoldUi();
-- end

-- function EggHeroSubUi:on_hero_time_crystal()
--     self.heroCrystalCD = math.max(0, self.heroCrystalCD - 1);
--     if self.heroCrystalCD <= 0 then
--         self:StopCrystalTimer();
--     end
--     self:UpdateCrystalUi();
-- end

-- function EggHeroSubUi:on_click_1()

--     --新手引导假扭蛋
--     if g_dataCenter.egg.useOnceHeroTimes == 0 and GuideManager.IsGuideRuning() then
--         local heroCid = ConfigManager.Get(EConfigIndex.t_discrete,MsgEnum.ediscrete_id.eDiscreteID_guide_first_egg_hero_id).data -- 第一个英雄
--         local hero = g_dataCenter.package:find_card_for_num(ENUM.EPackageType.Hero, heroCid)
--         if hero and LocalFile.GetHeroEggRecord(hero.index) == false then
--             LocalFile.WriteHeroEggRecord(hero.index)

--             NoticeManager.Notice(ENUM.NoticeType.NiuDanSuccess, 0, false)

--             local rewardData = {{id=heroCid, dataid="", count=1}}
--             self.vecReward = rewardData
--             self.vecItem = rewardData
--             self.showGetItemsDescription = nil

--             local ch = CardHuman:new({number = heroCid, level=1});
--             EggGetHero.Start(ch, true, nil)
--             EggGetHero.SetFinishCallback(self.ShowGetHeroEnd, self)

--             return
--         end
--     end

--     msg_activity.cg_niudan_use(self.EggType,false);
-- end

-- function EggHeroSubUi:on_click_10()
--     msg_activity.cg_niudan_use(self.EggType,true);
-- end

-- function EggHeroSubUi:gc_use(result, egg_type, bTen, vecReward, vecItem)
--     if bTen then
--         --把必出英雄随机到一个位置
--         if egg_type ~= ENUM.NiuDanType.Vip then
--             local randomPos = math.random(1, #vecReward)
--             local first = vecReward[1]
--             table.remove(vecReward, 1)
--             table.insert(vecReward, randomPos, first)
--             first = vecItem[1]
--             table.remove(vecItem, 1)
--             table.insert(vecItem, randomPos, first)
--         end

--         if egg_type == ENUM.NiuDanType.Gold then

--             local des = self:GetDesString(MsgEnum.ediscrete_id.eDiscreteID_gold_niudan_fix_reward, 10)
--             local costId = IdConfig.Gold

--             EggHeroGetTen.Start({vecReward = vecReward, vecItem = vecItem, costItemNum = EggHeroUi.GetCost(self.EggType, false), costItemId = costId, description = des})
--             EggHeroGetTen.SetCallback(self.on_click_10, self,self.UpdateUi,self);
--         elseif egg_type == ENUM.NiuDanType.Hero then
--             local costId = IdConfig.Crystal
--             local des = self:GetDesString(MsgEnum.ediscrete_id.eDiscreteID_crystal_niudan_fix_reward, 10)

--             EggHeroGetTen.Start({vecReward = vecReward, vecItem = vecItem, costItemNum = EggHeroUi.GetCost(self.EggType, false), costItemId = costId, description = des})
--             EggHeroGetTen.SetCallback(self.on_click_10, self,self.UpdateUi,self);
--         elseif egg_type == ENUM.NiuDanType.Vip then
--             -- local des = self:GetDesString(MsgEnum.ediscrete_id.eDiscreteID_hunxia_niudan_fix_reward, 5)
--             EggHunXiaAwardUI.Start({vecReward = vecReward, vecItem = vecItem, costItemNum = EggHeroUi.GetCost(self.EggType, false), description = des});
--             EggHunXiaAwardUI.SetCallback(self.on_click_10, self,self.UpdateUi,self);
--         end
--     else
--         if egg_type == ENUM.NiuDanType.Vip then
--             -- local des = self:GetDesString(MsgEnum.ediscrete_id.eDiscreteID_hunxia_niudan_fix_reward, 5)
--             EggHunXiaAwardUI.Start({vecReward = vecReward, vecItem = vecItem, costItemNum = EggHeroUi.GetCost(self.EggType, true), description = des});
--             EggHunXiaAwardUI.SetCallback(self.on_click_1, self,self.UpdateUi,self);
--             return;
--         end
--         if vecReward[1] then
--             app.log("gc_niudan_use " .. table.tostring(vecReward[1]))
--             self.showGetItemsDescription = nil
--             if egg_type == ENUM.NiuDanType.Gold then
--                 self.showGetItemsDescription = self:GetDesString(MsgEnum.ediscrete_id.eDiscreteID_gold_niudan_fix_reward, 1)
--             elseif egg_type == ENUM.NiuDanType.Hero then
--                 self.showGetItemsDescription = self:GetDesString(MsgEnum.ediscrete_id.eDiscreteID_crystal_niudan_fix_reward, 1)
--             end
--             self.vecReward = vecReward
--             self.vecItem = vecItem
--             if PropsEnum.IsRole(vecReward[1].id) then
--                 local ch = CardHuman:new({number = vecReward[1].id, level=1});
--                 local isNow = vecReward[1].id == vecItem[1].id
--                 local heroDes = nil
--                 if not isNow then
--                     local itemConfig = ConfigManager.Get(EConfigIndex.t_item, vecItem[1].id)
--                     local name = itemConfig.name
--                     heroDes = string.format(uiText[2], tostring(name), vecItem[1].count)
--                 end
--                 EggGetHero.Start(ch, isNow, heroDes)
--                 EggGetHero.SetFinishCallback(self.ShowGetHeroEnd, self)
--             else
--                 self:ShowGetHeroEnd()
--             end
--         else
--             app.log("奖励列表为空:"..table.tostring(vecReward));
--             self:UpdateUi();
--         end
--     end
-- end

-- function EggHeroSubUi:ShowGetHeroEnd()
--     if not self.EggType then return end

--     local costId = nil
--     if self.EggType == ENUM.NiuDanType.Gold then
--         costId = IdConfig.Gold
--     elseif self.EggType == ENUM.NiuDanType.Hero then
--         costId = IdConfig.Crystal
--     end
--     EggHeroGetOne.Start({vecReward = self.vecReward, vecItem = self.vecItem, description = self.showGetItemsDescription
--         ,costItemId = costId, costItemNum = EggHeroUi.GetCost(self.EggType, true)
--         });
--     EggHeroGetOne.SetCallback(self.on_click_1, self,self.UpdateUi,self);

--     self.vecReward = nil
--     self.vecItem = nil
--     self.showGetItemsDescription = nil
-- end

-- function EggHeroSubUi:GetDesString(discreteid, factor)
--     local des = nil
--     local expItemData = ConfigManager.Get(EConfigIndex.t_discrete,discreteid).data[1];
--     if expItemData then
--         local itemConfig = ConfigManager.Get(EConfigIndex.t_item, expItemData.number);
--         if itemConfig then
--             des = string.format(uiText[1], itemConfig.name, expItemData.count * factor)
--         end
--     end
--     return des
-- end
