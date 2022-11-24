--进入功能的条件检查
PacakgeUse = {}

local _UIText = {
    [1] = '%s级后开启该功能'
}

PacakgeUse.RelationData = {
--道具ID = Package.Data
--英雄升星
[MsgEnum.eactivity_time.eActivityTime_RoleUpgradeStar] = {
condition_func = function()
	--英雄升星开启条件
	--1、找一个拥有的英雄(直接进入队长英雄)
	--2、检查是否能升星
end
},
}

--itemNumebr 道具编号
function PacakgeUse.Use(itemNumber)
	if not itemNumber then return end

	local exchange_data = ConfigManager.Get(EConfigIndex.t_item_exchange,itemNumber)
	if not exchange_data then
		return
	end

    --开启等级检查
    if exchange_data.exchange_id ~= 0 then
        local functionid = 0
    	local cfg = ConfigManager.Get(EConfigIndex.t_play_vs_data, exchange_data.exchange_id);
		if cfg then 
			if g_dataCenter.player.level < cfg.open_level then
                FloatTip.Float(string.format(_UIText[1], cfg.open_level))
				return
			end
		end
    end

	--角色碎片
	if PropsEnum.IsRoleSoul(itemNumber) and exchange_data.exchange_id == 0 then
		--碎片
		--1、若未拥有该英雄，则点击使用按钮后不关闭背包界面，打开英雄列表界面且选中对应英雄
		--2、若拥有该英雄且英雄未满6星，则点击使用按钮后不关闭背包界面，打开对应角色的升星界面
		--3、若拥有该英雄且英雄已满6星，则点击使用按钮后不关闭背包界面，打开对应角色的潜能强化界面
		local item_data = ConfigManager.Get(EConfigIndex.t_item,itemNumber) or {}
		local hero_number = item_data.hero_number or 0
		if hero_number == 0 then
			--app.log("没有找到对应的英雄编号 itemNumber="..tostring(itemNumber))
			return
		end
		local cardInfo = g_dataCenter.package:find_card_for_num(ENUM.EPackageType.Hero,hero_number)
		if cardInfo then
			--拥有英雄->升星
			uiManager:PushUi(EUI.BattleUI, {defToggle = MsgEnum.eactivity_time.eActivityTime_RoleUpgradeStar,cardInfo=cardInfo,is_player=true});
		else
			--拥有英雄->没有英雄到合成英雄界面
			uiManager:PushUi(EUI.HeroPackageUI, {gotoId=hero_number});
		end
		return;
	elseif exchange_data.exchange_id == MsgEnum.eactivity_time.eActivityTime_EquipLevel then
		--帽子
		if itemNumber == 20000117 or itemNumber == 20000118 or itemNumber == 20000119 then
			local isLock, level = PublicFunc.IsSpecEquipLevelLock(ENUM.EEquipPosition.Helmet)
			if isLock then
				FloatTip.Float(string.format(_UIText[1], level))
				return
			end
			uiManager:PushUi(EUI.EquipPackageUI, {equipPos = 6});

		--饰品
		elseif itemNumber == 20000120 or itemNumber == 20000121 or itemNumber == 20000122 then
			local isLock, level = PublicFunc.IsSpecEquipLevelLock(ENUM.EEquipPosition.Accessories)
			if isLock then
				FloatTip.Float(string.format(_UIText[1], level))
				return
			end
			uiManager:PushUi(EUI.EquipPackageUI, {equipPos = 5});

        else
            EnterSystemFunction(exchange_data.exchange_id)
        end
    elseif exchange_data.exchange_id == MsgEnum.eactivity_time.eActivityTime_Trainning then --训练馆
    	local group = g_dataCenter.trainning:computitemToHero(itemNumber)
    	if group ~= "" then
    		app.log("group ----------------"..group)
    		uiManager:PushUi(EUI.TrainningInfo, {group = group});
    	else
    		app.log("物品配置错误~")
    	end
    else
        EnterSystemFunction(exchange_data.exchange_id)
	end
end