-- --
-- local EConcentration = 
-- {
-- 	[3] = "蓝色",
-- 	[4] = "紫色",
-- 	[5] = "金色",
-- }
-- function UiEquipStarUp:on_btn_sure()
-- 	if g_dataCenter.player.gold < self.cardInfo.starup_gold then
-- 		HintUI.SetAndShow(EHintUiType.zero, "你的金钱不够");
-- 		return;
-- 	elseif self.jewel_count < self.cardInfo.starup_material_num then
-- 		HintUI.SetAndShow(EHintUiType.zero, "你的强化石不够");
-- 		return;
-- 	elseif self.cardInfo.star >= 5 then
-- 		HintUI.SetAndShow(EHintUiType.zero, "已经是最大星数");
-- 		return;
-- 	else
-- 		if self.use_concentration then
-- 			HintUI.SetAndShow(EHintUiType.two, "使用"..self.cardInfo.starup_success_concentration.."点"..EConcentration[self.cardInfo.rarity].."集中度，将升星成功率提升到100%，是否花费"..tostring(self.cardInfo.starup_gold).."金币来升星该装备",
-- 							  {str="确定",func=self.bindfunc['StarUp']},{str="取消"});
-- 		else
-- 			if self.cardInfo.starup_success_rate < 100 then
-- 			-- HintUI.SetAndShow(EHintUiType.two, "升星有风险，如果失败装备星级会减1，同时获得"..tostring(self.cardInfo.starup_fail_concentration).."个"..EConcentration[self.cardInfo.rarity].."集中度,是否花费"..tostring(self.cardInfo.starup_gold).."金币来升星该装备",
-- 							  -- {str="确定",func=self.bindfunc['StarUp']},{str="取消"});
-- 				if self.isFirst then
-- 					HintUI.SetAndShow(EHintUiType.two, "升星有风险，如果失败将会损失本次强化所用全部强化石，是否花费"..tostring(self.cardInfo.starup_gold).."金币进行装备升星",
-- 									  {str="确定",func=self.bindfunc['StarUp']},{str="取消"});
-- 					self.isFirst = false;
-- 				else
-- 					self:StarUp();
-- 				end
-- 			else
-- 				self:StarUp();
-- 			end
-- 		end
-- 	end
-- end

-- -- function UiEquipStarUp:on_btn_cost_concentration()

-- -- 	if self.concentration.count < self.cardInfo.starup_success_concentration then
-- -- 		self.lab_gouxuan:set_active(false);
-- -- 		HintUI.SetAndShow(EHintUiType.one,"你的集中度不够",{str = "确定",func = self.bindfunc['SetToggleFalse']});
-- -- 	else
-- -- 		if self.can_use_concentration then
-- -- 			if self.use_concentration then
-- -- 				self.use_concentration = false;
-- -- 				self.lab_gouxuan:set_active(true);
-- -- 				self.lab_succeed:set_text(tostring(self.cardInfo.starup_success_rate).."%");
-- -- 				self.lab_all_focus:set_text("x"..tostring(self.concentration.count));
-- -- 			else
-- -- 				self.lab_gouxuan:set_active(false);
-- -- 				self.use_concentration = true;
-- -- 				self.lab_all_focus:set_text("x"..tostring(self.concentration.count-self.cardInfo.starup_success_concentration));
-- -- 				self.lab_succeed:set_text("100%");
-- -- 			end
-- -- 		end
-- -- 	end
-- -- end

-- function UiEquipStarUp:on_btn_close()
-- 	uiManager:PopUi();    
-- end

-- function UiEquipStarUp:on_rule()
-- 	UiRuleDes.Start(ENUM.ERuleDesType.ZhuangBeiShengXin)
-- end




