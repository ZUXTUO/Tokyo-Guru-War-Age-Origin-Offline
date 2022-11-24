-- HeroStarUp = Class("HeroStarUp", UiBaseClass);

-- function HeroStarUp:Init(data)
--     self.pathRes = "assetbundles/prefabs/ui/package/ui_602_star_up.assetbundle"
-- 	UiBaseClass.Init(self,data);
-- end

-- function HeroStarUp:Restart(data)
--     self.isShow = false;
--     self.useSouls = 0;
--     if data then
--         self.roleData = data.info;
--     end
--     if not g_dataCenter.activity[MsgEnum.eactivity_time.eActivityTime_tongLinZhiHunDuiHuan]:IsHaveData() then
--         msg_activity.cg_activity_config(MsgEnum.eactivity_time.eActivityTime_tongLinZhiHunDuiHuan);
--     end
--     if UiBaseClass.Restart(self, data) then
        
--     end
-- end

-- function HeroStarUp:InitData(data)
--     UiBaseClass.InitData(self, data);
--     -- self.isShow = false;
--     -- self.useSouls = 0;
--     -- self.roleData = data.info;
--     --self:LoadData(data);

    
-- end

-- function HeroStarUp:DestroyUi()
--     UiBaseClass.DestroyUi(self);
--     -- self.ui = nil
--     -- self.rootui = nil;
--     -- self:MsgUnRegist();
--     -- self:UnRegistFunc();
--     if self.scard then
--         self.scard:DestroyUi();
--         self.scard = nil;
--     end
-- end

-- function HeroStarUp:Show()
--     UiBaseClass.Show(self);
--     if self.ui then
--         if self.isShow == false then
--             self:OnShow();
--         end
--         self.isShow = true;
--         self.ui:set_active(true);
--         --self.equip:set_active(false);
--     end
-- end

-- function HeroStarUp:OnShow()
--     self.useSouls = 0;
--     self:UpdateUi();
-- end

-- function HeroStarUp:Hide()
--     UiBaseClass.Hide(self);
--     if self.ui then
--         self.isShow = false;
--         self.ui:set_active(false);
--         --self.equip:set_active(true);
--     end
-- end

-- function HeroStarUp:IsShow()
--     return self.isShow;
-- end

-- function HeroStarUp:RegistFunc()
--     UiBaseClass.RegistFunc(self);
--     self.bindfunc["on_btn_close"] = Utility.bind_callback(self, HeroStarUp.on_btn_close);
--     self.bindfunc["on_btn_change"] = Utility.bind_callback(self, HeroStarUp.on_btn_change);
--     self.bindfunc["gc_btn_change"] = Utility.bind_callback(self, HeroStarUp.gc_btn_change);
-- end

-- function HeroStarUp:UnRegistFunc()
--     UiBaseClass.UnRegistFunc(self);
-- end

-- --注册消息分发回调函数
-- function HeroStarUp:MsgRegist()
--     UiBaseClass.MsgRegist(self);
--     PublicFunc.msg_regist(msg_cards.gc_change_souls,self.bindfunc['gc_btn_change']);
-- end

-- --注销消息分发回调函数
-- function HeroStarUp:MsgUnRegist()
--     UiBaseClass.MsgUnRegist(self);
--     PublicFunc.msg_unregist(msg_cards.gc_change_souls,self.bindfunc['gc_btn_change']);
-- end

-- -- function HeroStarUp:SetInfo(info)
-- --     self.roleData = info;
-- --     self:UpdateUi();
-- -- end

-- -- function HeroStarUp:LoadData(data)
-- --     if data == nil then return end;

-- --     --if data.loading then self.loading = data.loading end
-- --     --if data.ui      then self.rootui = data.ui end
-- --     if data.info    then self.roleData = data.info end

-- -- end

-- function HeroStarUp:InitUI(obj)
--     UiBaseClass.InitUI(self, obj);
--     self.ui:set_parent(Root.get_root_ui_2d());
--     self.ui:set_local_scale(1,1,1);
--     self.ui:set_name('ui_602_star_up');
--     do return end
--     local staticLab = nil;
--     staticLab = ngui.find_label(self.ui, "centre_other/animation/content2/lab1");
--     staticLab:set_text("所持灵魂精华:");
--     staticLab = ngui.find_label(self.ui, "centre_other/animation/content2/lab3");
--     staticLab:set_text("可用碎片数量");
--     --staticLab = ngui.find_label(self.ui, "sp_bk/txt_num")
--     --staticLab:set_text("使用数");
--     staticLab = ngui.find_label(self.ui, "centre_other/animation/sp_bk/btn_sure/txt_sure")
--     staticLab:set_text("兑换");
--     staticLab = ngui.find_label(self.ui, "centre_other/animation/sp_bk/content2/item1/txt_life")
--     staticLab:set_text("生命值");
--     staticLab = ngui.find_label(self.ui, "centre_other/animation/sp_bk/content2/item2/txt_life")
--     staticLab:set_text("物理强度");
--     staticLab = ngui.find_label(self.ui, "centre_other/animation/sp_bk/content2/item3/txt_life")
--     staticLab:set_text("能量强度");
--     staticLab = ngui.find_label(self.ui, "centre_other/animation/sp_bk/content2/item4/txt_life")
--     staticLab:set_text("物理防御");
--     staticLab = ngui.find_label(self.ui, "centre_other/animation/sp_bk/content2/item5/txt_life")
--     staticLab:set_text("能量防御");
    

--     --寻找label
--     self.lab_name = ngui.find_label(self.ui, "centre_other/animation/content1/lab_name")
--     self.lab_level = ngui.find_label(self.ui, "centre_other/animation/content1/txt_describe");
--     self.lab_star_up_describe = ngui.find_label(self.ui, "centre_other/animation/sp_bk/pro_di/txt_exp");
--     self.lab_star_up = ngui.find_label(self.ui, "centre_other/animation/sp_bk/pro_di/lab");
--     self.lab_xibaoqianghua_level = ngui.find_label(self.ui, "centre_other/animation/sp_bk/cont/lab");
--     self.lab_shengxing = ngui.find_label(self.ui, "centre_other/animation/lab");
--     --staticLab = ngui.find_label(self.ui, "content_di/content/lab1");
--     --staticLab:set_text("潜能强化");
--     self.labUseSoul = ngui.find_label(self.ui, "centre_other/animation/sp_bk/bk2/di/lab");
--     self.lab_property = {};
--     for i=1,5 do
--         self.lab_property[i] = ngui.find_label(self.ui, "centre_other/animation/sp_bk/content2/item"..i.."/lab_num");
--     end
--     self.lab_today_soul = ngui.find_label(self.ui, "centre_other/animation/content2/lab4");
--     self.lab_total_soul = ngui.find_label(self.ui, "centre_other/animation/content2/lab2");

--     --寻找sprite
--     self.sp_star_left = {};
--     self.sp_star_right = {};
--     for i=1,5 do
--         self.sp_star_left[i] = ngui.find_sprite(self.ui, "centre_other/animation/sp_bk/cont/content/contain_star_left/sp_star"..i.."/sp");
--         self.sp_star_right[i] = ngui.find_sprite(self.ui, "centre_other/animation/sp_bk/cont/content/contain_star_right/sp_star"..i.."/sp");
--     end

--     --寻找progress
--     self.pro_star_up = ngui.find_progress_bar(self.ui, "centre_other/animation/sp_bk/pro_di");

--     --寻找content
--     self.cont_xibaoqianghua = ngui.find_label(self.ui, "centre_other/animation/sp_bk/cont/lab");
--     self.cont_card = ngui.find_button(self.ui, "centre_other/animation/big_card_item"):get_game_object();
--     self.cont_star = ngui.find_sprite(self.ui, "centre_other/animation/sp_bk/cont/content");
--     --寻找button
--     self.btn_close = ngui.find_button(self.ui, "centre_other/animation/btn_fork");
--     self.btn_close:set_on_click(self.bindfunc["on_btn_close"]);
--     self.btn_exchange = ngui.find_button(self.ui, "centre_other/animation/sp_bk/btn_sure");
--     self.btn_exchange:set_on_click(self.bindfunc["on_btn_change"]);
--     self.btn_sub = ngui.find_button(self.ui, "centre_other/animation/sp_bk/bk2/btn_cut");
--     local bc_sub = ButtonClick:new({obj=self.btn_sub, isUpdatePress = true});
--     bc_sub:SetPress(self.on_btn_add_reduce,false,self);
--     self.btn_add = ngui.find_button(self.ui, "centre_other/animation/sp_bk/bk2/btn_add");
--     local bc_add = ButtonClick:new({obj=self.btn_add, isUpdatePress = true});
--     bc_add:SetPress(self.on_btn_add_reduce,true,self);
--     self:UpdateUi();
-- end

-- function HeroStarUp:on_btn_close(t)
--     uiManager:PopUi();
-- end

-- function HeroStarUp:on_btn_change()
--     local count = PropsEnum.GetValue(IdConfig.PsychicSoul);
--     if self.useSouls == 0 or count < self.useSouls then
--         HintUI.SetAndShow(EHintUiType.zero, "当前的灵魂精华不足");
--         return;
--     end
--     local dataCenter = g_dataCenter.activity[MsgEnum.eactivity_time.eActivityTime_tongLinZhiHunDuiHuan];
--     if dataCenter == nil then
--         return;
--     end
--     local curChangeSouls = g_dataCenter.player:GetChangeSouls();
--     if curChangeSouls + self.useSouls > dataCenter.maxChangeCount then
--         HintUI.SetAndShow(EHintUiType.zero, "你兑换的数量已经超过今日最大兑换数量，请充值vip");
--         return;
--     end
--     if not self.roleData.is_have then
--         return;
--     end
--     self.olduseSouls = self.useSouls;
--     msg_cards.cg_change_souls(Socket.socketServer, self.roleData.index, self.useSouls);

-- end

-- function HeroStarUp:gc_btn_change(result)
--     local id = ConfigManager.Get(EConfigIndex.t_item.roleIdToItemId,self.roleData.default_rarity);
--     local item = {id = id, count = self.olduseSouls};
--     CommonAward.Start({item}, 1)
--     self:UpdateSceneInfo();
--     CommonAward.SetFinishCallback(UiStarUpAnimation.SetAndShow, {cardinfo = self.roleData})
-- end

-- function HeroStarUp:on_btn_add_reduce(x, y, state, param)
--     if state then
--         if param == true then
--             local dataCenter = g_dataCenter.activity[MsgEnum.eactivity_time.eActivityTime_tongLinZhiHunDuiHuan];
--             if dataCenter == nil then
--                 return;
--             end
--             local total_soul = PropsEnum.GetValue(IdConfig.PsychicSoul) --拥有的通灵之魂总数
--             if self.useSouls >= total_soul then
--                 HintUI.SetAndShow(EHintUiType.zero, "超过你拥有的灵魂精华总数");
--                 return
--             end
--             local tempSouls = g_dataCenter.player:GetChangeSouls();  --今日已兑换通灵之魂数
--             local maxSouls = dataCenter.maxChangeCount;   --最大通灵之魂数

--             local remain_soul_today = maxSouls - tempSouls;  --今日剩余可兑换通灵之魂数
--             if self.useSouls >= remain_soul_today then
--                 HintUI.SetAndShow(EHintUiType.zero, "超过今日剩余可兑换灵魂精华总数");
--                 return
--             end

--             if self.useSouls >= 90 then
--                 HintUI.SetAndShow(EHintUiType.zero, "一次最多可兑换90个灵魂精华");
--                 return
--             end
--             self.useSouls = self.useSouls + 1;
--             local tempSouls = g_dataCenter.player:GetChangeSouls();
--             local maxSouls = dataCenter.maxChangeCount;
--             if self.useSouls > maxSouls - tempSouls then
--                 self.useSouls = maxSouls - tempSouls;
--             end
--             self:UpdateUi();
--         elseif param == false then
--             self.useSouls = self.useSouls - 1;
--             if self.useSouls < 0 then
--                 self.useSouls = 0;
--             end
--             self:UpdateUi();
--         end
--     end
-- end



-- function HeroStarUp:UpdateSceneInfo()
--     self.useSouls = 0;
--     self:UpdateUi();
--     -- app.log("bbbbb    "..debug.traceback());
--     -- local id = ConfigManager.Get(EConfigIndex.t_item.roleIdToItemId,self.roleData.default_rarity);
--     -- local item = {id = id, count = 4};
--     -- CommonAward.Start({item}, 1)
-- end

-- function HeroStarUp:UpdateUi()
--     if not self.ui or not self.roleData then
--         app.log_warning("还未初始化完成  HeroStarUp");
--         return;
--     end
--     local dataCenter = g_dataCenter.activity[MsgEnum.eactivity_time.eActivityTime_tongLinZhiHunDuiHuan];
--     if not dataCenter then
--         return;
--     end
--     if not self.scard then
--         self.scard = SmallCardUi:new( { obj = self.cont_card, info = self.roleData, res_group=self.panel_name });
--     else
--         self.scard:SetData(self.roleData);
--     end
--     self.scard:SetTeamPosIcon(0);
--     --FightShowRole:new({obj=self.cont_card:get_game_object(), info = self.roleData, isLeader = false, isBottom = false});

--     local max_star = ConfigManager.Get(EConfigIndex.t_discrete,MsgEnum.ediscrete_id.eDiscreteId_upgradeStarMaxLevel).data;
--     --当前攻击力,物理攻击强度，能量攻击强度，物理防御强度，能量防御强度
--     local max_hp = self.roleData:GetPropertyVal("max_hp");
--     local phy_at_power = self.roleData:GetPropertyVal("phy_at_power");
--     local energy_at_power = self.roleData:GetPropertyVal("energy_at_power");
--     local phy_def_power = self.roleData:GetPropertyVal("phy_def_power");
--     local energy_def_power = self.roleData:GetPropertyVal("energy_def_power");

--     local tempSouls = g_dataCenter.player:GetChangeSouls();  --今日已兑换通灵之魂数
--     local maxSouls = dataCenter.maxChangeCount;   --最大通灵之魂数

--     if self.roleData.rarity >= max_star then --如果当前星级大于等于5星，就进行细胞强化
--         self.lab_shengxing:set_text("潜能强化");
--         self.cont_xibaoqianghua:set_active(true);
--         self.cont_star:set_active(false);
--         --self.lab_star_up_describe:set_text("强化进度");
--         self.lab_xibaoqianghua_level:set_text("潜能强化等级"..tostring(self.roleData.neidan_level));
--         self.lab_property[1]:set_text(tostring(max_hp));
--         self.lab_property[2]:set_text(tostring(phy_at_power));
--         self.lab_property[3]:set_text(tostring(energy_at_power));
--         self.lab_property[4]:set_text(tostring(phy_def_power));
--         self.lab_property[5]:set_text(tostring(energy_def_power));
--     else  --否则进行升星
--         self.lab_shengxing:set_text("英雄升星");
--         self.cont_xibaoqianghua:set_active(false);
--         self.cont_star:set_active(true);
--         --self.lab_star_up_describe:set_text("升星进度");
--         self.lab_property[1]:set_text(tostring(max_hp));
--         self.lab_property[2]:set_text(tostring(phy_at_power));
--         self.lab_property[3]:set_text(tostring(energy_at_power));
--         self.lab_property[4]:set_text(tostring(phy_def_power));
--         self.lab_property[5]:set_text(tostring(energy_def_power));
--         for i = 1, 5 do
--             self.sp_star_left[i]:set_active(i <= self.roleData.rarity);
--             self.sp_star_right[i]:set_active(i <= self.roleData.rarity+1);
--         end
--     end
--     local souls = self.roleData.souls;
--     local need = nil;
--     if self.roleData.neidan_level <= 0 then
--         need = self.roleData.config.soul_count;
--     else
--         local config = ConfigManager.Get(EConfigIndex.t_neidan,self.roleData.neidan_level);
--         need = config.souls;
--     end
--     self.lab_star_up:set_text(tostring(souls).."/"..tostring(need));
--     self.lab_total_soul:set_text(tostring(PropsEnum.GetValue(IdConfig.PsychicSoul)));
--     self.labUseSoul:set_text(tostring(self.useSouls));
--     self.lab_name:set_text(tostring(self.roleData.name));
--     self.lab_level:set_text("Lv."..tostring(self.roleData.level));
--     self.lab_today_soul:set_text(tostring(tempSouls).."/"..tostring(maxSouls));
--     self.pro_star_up:set_value(self.roleData:GetSoulsProgress());

--     if self.useSouls <= 0 then
--         self.btn_sub:set_enable(false);
--         self.btn_exchange:set_enable(false);
--     else
--         self.btn_sub:set_enable(true);
--         self.btn_exchange:set_enable(true);
--     end

-- end