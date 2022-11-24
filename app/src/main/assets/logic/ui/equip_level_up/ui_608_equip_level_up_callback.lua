--
function UiEquipLevelUp:on_btn_upgrade()
	local player_level = g_dataCenter.player.level;
	if self.cardInfo.level < player_level then
		if g_dataCenter.player.gold < CardHuman.GetLevelConfig(self.cardInfo.number, self.cardInfo.level, self.cardInfo.config).cost_gold then
			HintUI.SetAndShow(EHintUiType.zero, "你的金币不够",{func = self.bindfunc['GoldExchangeUI']});
		else
			GLoading.Show(GLoading.EType.msg);
			msg_cards.cg_equip_level_up(Socket.socketServer,self.cardInfo.index,1)
		end
	else
		HintUI.SetAndShow(EHintUiType.zero, "装备等级不能超过玩家等级");
	end
end

function UiEquipLevelUp:GoldExchangeUI()
	uiManager:PushUi(EUI.GoldExchangeUI);
end

--
function UiEquipLevelUp:on_btn_max_level()
	local player_level = g_dataCenter.player.level;
	local cardlevel = self.cardInfo.level;

	-- local levelcfg = self.cardInfo.config.level_config;

	-- TODO: kevin self.cardInfo 是什么结构？
	local levelcfg = CardEquipment.GetLevelConfig(nil, cardlevel, self.cardInfo.config)

	local maxlevel = #levelcfg;
	local adv_level = maxlevel;
	for i=cardlevel,maxlevel do
		if levelcfg[i].adv_materials and levelcfg[i].adv_materials ~= 0 then
			adv_level = i;
			break;
		end
	end
	if self.cardInfo.level < player_level then
		if player_level > adv_level then
			player_level = adv_level;
		end
		self.level_count = 0;
		local cost = 0;
		local level = self.cardInfo.level;
		local level_diff = player_level - level;
		for i=1, level_diff do
			local _cost = cost + CardHuman.GetLevelConfig(self.cardInfo.number, level, self.cardInfo.config).cost_gold;
			if _cost > g_dataCenter.player.gold then
				break;
			else
				cost = _cost;
				level = level + 1;
				self.level_count = self.level_count + 1;
			end
		end
		if self.level_count > 0 then
			HintUI.SetAndShow(EHintUiType.two, 
			"从"..self.cardInfo.level.."级到"..(self.cardInfo.level + self.level_count).."级将消耗"..PublicFunc.NumberToStringByCfg(cost).."的金币",
			{str="确定",func = self.bindfunc['LevelUp']},
			{str="取消"});
			--msg_cards.cg_equip_level_up(Socket.socketServer,self.cardInfo.index,level_count);
		else
			HintUI.SetAndShow(EHintUiType.zero, "你的金币不够",{func = self.bindfunc['GoldExchangeUI']});
		end
	else
		HintUI.SetAndShow(EHintUiType.zero, "装备等级不能超过玩家等级");
	end
end

--
function UiEquipLevelUp:on_btn_close()
	uiManager:PopUi();
end

function UiEquipLevelUp:on_btn_advance()
	local player_level = g_dataCenter.player.level;
	if self.cardInfo.level < player_level then
		if g_dataCenter.player.gold < CardHuman.GetLevelConfig(self.cardInfo.number, self.cardInfo.level, self.cardInfo.config).cost_gold then
			HintUI.SetAndShow(EHintUiType.zero, "你的金币不够",{func = self.bindfunc['GoldExchangeUI']});
		else
			if self.materials_enough then
				GLoading.Show(GLoading.EType.msg);
				msg_cards.cg_equip_level_up(Socket.socketServer,self.cardInfo.index,1);
			else
				HintUI.SetAndShow(EHintUiType.two, "装备进阶材料不足,是否花费"..self.need_crystal.."钻石进行升阶",
					{str="确定",func = self.bindfunc['ShengJie']},
					{str="取消"});
			end
		end
	else
		HintUI.SetAndShow(EHintUiType.zero, "装备等级不能超过玩家等级");
	end
end

function UiEquipLevelUp:ShengJie()
	local have_crystal = g_dataCenter.player.crystal;
	if have_crystal < self.need_crystal then
		HintUI.SetAndShow(EHintUiType.two, "钻石不足！请前往充值！",
					{str="前往充值",func = self.bindfunc['goto_recharge']},
					{str="取消"});
	else
		GLoading.Show(GLoading.EType.msg);
		msg_cards.cg_equip_level_up(Socket.socketServer,self.cardInfo.index,1);
	end
end

function UiEquipLevelUp:goto_recharge()
	uiManager:PushUi(EUI.StoreUI);
end

function UiEquipLevelUp:on_rule()
	UiRuleDes.Start(ENUM.ERuleDesType.EquipLevelUp)
end

