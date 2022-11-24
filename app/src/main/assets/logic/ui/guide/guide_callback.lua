
-- 内部可以用this指向，简化代码
local this = GuideManager

--------------------------等待完成调用函数--------------------------
-- 关卡退出
function GuideManager.OnFightOverBegin(hurdle_id)
	-- if this.IsGuideRuning() then
	-- 	this.StopGuide();
	-- end
end

-- 关卡进入
function GuideManager.OnFightStartBegin(hurdle_id)
	
end

--场景开始切换
function GuideManager.OnSceneChangeEnter()
	if this.IsGuideRuning() then
		this.StopGuide();
	end
end

--切换自动战斗状态
function GuideManager.OnChangeAutoFightMode(auto)
	
end

--选区成功
function GuideManager.OnChangeAreaSuccess()
	this.CheckWaitFunc("change_area_success")
end

-- 关卡UI加载完成触发一下
function GuideManager.OnFightUiLoadComplete(hurdle_id)
	if AppConfig.enable_guide == false then return end

	-- 在mmo场景中
	local in_mmo_scene = false
	if 1000000 > hurdle_id then in_mmo_scene = true end

	if not this.IsGuideRuning() then
		this.Trigger(this.GuideType.SceneLoad, hurdle_id)
	end

	-- 触发主线承接引导
	if not this.IsGuideRuning() and in_mmo_scene then
		-- TODO

	end

	if this.first_flag == nil then
		-- 打开广告界面
		if in_mmo_scene and not this.IsGuideRuning() then
			script.run("logic/systems/load/ad_picture_ui.lua");
   			AdPictureUi.Start();
		end
		this.first_flag = true
	end
end

-- 标记更新
-- function GuideManager.OnUpdatePlayerFlag()
-- 	OutGuideLog(" ### OnUpdatePlayerFlag ")
-- end

function GuideManager.OnScreenTouchBegin(x,y,z)
	this.CheckWaitFunc("wait_screen_click")
end

function GuideManager.OnNiuDanSuccess()
	this.CheckWaitFunc("niudan_success")
end

function GuideManager.OnChangeEquipSuccess()
	this.CheckWaitFunc("changeequip_success")
end

function GuideManager.OnChangeTeamSuccess()
	this.CheckWaitFunc("changeteam_success")
end

function GuideManager.OnGetCommonAddExpBack()
	this.CheckWaitFunc("get_common_add_exp_back")
end

function GuideManager.OnGetCommonAwardBack()
	this.CheckWaitFunc("get_common_award_back")
end

function GuideManager.OnGetCommonHurdleBack()
	this.CheckWaitFunc("get_common_hurdle_back")
end

function GuideManager.OnGetHeroQuaUpShowBack()
	this.CheckWaitFunc("get_hero_qua_up_show_back")
end

function GuideManager.OnGetHeroStarupShowBack()
	this.CheckWaitFunc("get_hero_starup_show_back")
end

function GuideManager.OnGetHurdleRaidsShowBack()
	this.CheckWaitFunc("get_hurdle_raids_show_back")
end

function GuideManager.OnGetFloatTipsShowBack()
	this.CheckWaitFunc("get_float_tips_show_back")
end

function GuideManager.OnGetBattleShowBack(ret)
	this.CheckWaitFunc("get_battle_show_back", ret)
end

function GuideManager.OnGetContactActiveShowBack()
	this.CheckWaitFunc("get_contact_active_show_back")
end

function GuideManager.OnGetNewHeroShowBack()
	this.CheckWaitFunc("get_new_hero_show_back")
end

function GuideManager.OnScreenPlayOver(play_id)
	this.CheckWaitFunc("screen_play_over", play_id)
	if not this.IsGuideRuning() then
		this.Trigger(this.GuideType.PlotEnd, play_id)
	end
end

function GuideManager.OnPushUi(scene_id, scene)
	-- 检查等待条件
    if this.IsGuideRuning() then
		--特殊处理：排除战斗的主界面
		if scene_id ~= EUI.MMOMainUI or FightScene.GetPlayMethodType() == MsgEnum.eactivity_time.eActivityTime_MainCity then
			this.CheckWaitFunc( "push_ui", scene_id )
		end
        return;
    end

	this.CheckPushUI(scene_id)
end

function GuideManager.OnPopUi(scene_id)
	if this.IsGuideRuning() then
		-- TODO 暂时处理为退出（考虑隐藏）
		if GuideUI.CheckPopOwnUi(scene_id) then
			-- this.StopGuide();
		-- 检查pop_ui等待条件
		else
			this.CheckWaitFunc( "pop_ui", scene_id )
		end
	end
	
	this.CheckMainUI()
end

function GuideManager.OnUiManagerRestart(scene_id)
	if this.IsGuideRuning() then
		this.CheckWaitFunc( "restart_ui", scene_id )
	end

	--从战斗场景中切换到主场景，战队升级引导检查
	app.log("从战斗场景中切换到主场景，战队升级引导检查")
	local playType = FightScene.GetPlayMethodType()
	local isMainCity = playType == MsgEnum.eactivity_time.eActivityTime_MainCity
	if isMainCity then
		local levelUpInFight = this.levelUpInFight
		this.levelUpInFight = nil

		if this.playerLevelFunctionId or this.playerLevelFunctionId then
			--不中断当前引导
			if this.IsGuideRuning() then
				return
			end
			--回到主界面触发引导
			uiManager:SetStackSize(1)
			return
		end

		if levelUpInFight and this.playPreOpenMark[ g_dataCenter.player:GetLevel() ] then
			--回到主界面触发预告
			uiManager:SetStackSize(1)
			return
		end
	end
end

function GuideManager.OnPlayerLevelUp(level)
	this.playerLevelGuideId, this.playerLevelFunctionId = this.GetPlayerLevelConditon(level)
end

function GuideManager.OnPlayerLevelupUiFinish()
	--主场景中战队升级引导检查
	local playType = FightScene.GetPlayMethodType()
	local isMainCity = (playType == MsgEnum.eactivity_time.eActivityTime_MainCity)
	if isMainCity then
		if this.playerLevelFunctionId or this.playerLevelFunctionId then
			--不中断当前引导
			if this.IsGuideRuning() then
				return
			end
			--回到主界面触发引导
			uiManager:SetStackSize(1)
			return
		end

		if this.playPreOpenMark[ g_dataCenter.player:GetLevel() ] then
			--回到主界面触发预告
			uiManager:SetStackSize(1)
			return
		end
	else
		this.levelUpInFight = true
	end
end

function GuideManager.OnFightStartEnd()
	this.CheckWaitFunc( "wait_fight_start_end", id )
end

function GuideManager.OnBackToUiDailyTask()
	this.CheckWaitFunc( "back_to_ui_daily_task" )
end

function GuideManager.OnRegionSelectRivalOK()
	this.CheckWaitFunc( "region_select_rival_ok" )
end

function GuideManager.OnNetReceiveHook(hook_name)
	this.CheckWaitFunc( hook_name )
end

function GuideManager.OnAutoOpenFunc(id, open_level)
	if not this.IsGuideRuning() then
		this.Trigger(this.GuideType.OpenFunctionUI, id)
	end
end

function GuideManager.OnOpenFuncEffectShowEnd(id)
	-- 清除临时标记
	if this.playerLevelFunctionId == id then
		this.playerLevelFunctionId = nil
	end
	this.CheckWaitFunc( "wait_open_func_show_end", id )
end

function GuideManager.OnMainSceneBtnClick(id)
	this.CheckWaitFunc( "main_scene_btn_click", id )
end

function GuideManager.OnGuidePlayGuideUiBack()
	this.CheckWaitFunc( "guide_play_guide_ui_back" )
end

function GuideManager.OnFarTrialChooseDiff()
	this.CheckWaitFunc( "open_far_trial_choose_diff" )
end

function GuideManager.OnFarTrialChooseRole()
	this.CheckWaitFunc( "open_far_trial_choose_role" )
end

function GuideManager.OnGuideCareMsgSend(msg_id)
	if this.need_server_confirm == true then
		this.need_server_confirm = msg_id
	end
end

function GuideManager.OnGuideCareMsgReceive(msg_id)
	if this.need_server_confirm == msg_id then
		this.need_server_confirm = nil
		this.ExecuteGuideStep()
	end
end

-- 返回指定难度difficulty_index指定关卡level_index项 right_other/animation/res_obj_level_line_item(Clone)(Clone)/level_1/1/level_content
function GuideManager.get_hurdle_item(difficulty_index, level_index)
	local ui = uiManager:FindUI(EUI.UiLevel)
	if ui and ui.GetLevelItemUi then
		return ui:GetLevelItemUi(difficulty_index, level_index)
	end
end

-- 返回指定关卡第index宝箱（章节确定）
function GuideManager.get_hurdle_box(index)
	local ui = uiManager:FindUI(EUI.UiLevel)
	if ui and ui.GetLevelBoxUi then
		return ui:GetLevelBoxUi(index)
	end
end

-- 返回英雄装备列表第index项 battle_ui/centre_other/animation/right_content/content2/panel_list/wrap_content/
function GuideManager.get_hero_equip_item(index)
	-- 从ui_manager里面查找
	local ui = uiManager:FindUI(EUI.BattleUI)
	if ui and ui.equipList and ui.equipList.GetEquipItemUi then
		return ui.equipList:GetEquipItemUi(index)
	end
end
-- 返回英雄装备列表第index项的button组件 battle_ui/centre_other/animation/right_content/content2/panel_list/wrap_content/
function GuideManager.get_hero_equip_item_button(index)
	-- 从ui_manager里面查找
	local ui = uiManager:FindUI(EUI.BattleUI)
	if ui and ui.equipList and ui.equipList.GetEquipItemBtn then
		return ui.equipList:GetEquipItemBtn(index)
	end
end
-- 返回扭蛋界面列表第index项 ui_2601_egg/centre_other/animation/grid/sp_di[x]
function GuideManager.get_egg_hero_item(index)
	local ui = uiManager:FindUI(EUI.EggHeroUi)
	if ui and ui.GetItemObjByIndex then
		return ui:GetItemObjByIndex(index)
	end
end
-- 返回指定index玩法列表项
function GuideManager.get_play_list_item_by_index(index)
	local ui1 = uiManager:FindUI(EUI.AthleticEnterUI)
	local ui2 = uiManager:FindUI(EUI.ChallengeEnterUI)
	local ui3 = uiManager:FindUI(EUI.DuelEnterUI)
	local ui = nil
	if ui1 and ui1.ui then
		ui = ui1
	end
	if ui2 and ui2.ui then
		ui = ui2
	end
	if ui3 and ui3.ui then
		ui = ui3
	end
	if ui and ui.GetListItemObj then
		return ui:GetListItemObj(index)
	end
end
-- 返回每日任务列表项领取按钮 
function GuideManager.get_daily_task_item_btn_by_index(index)
	local ui = uiManager:FindUI(EUI.UiDailyTask)
	if ui and ui.GetItemBtnByIndex then
		return ui:GetItemBtnByIndex(index)
	end
end
-- 返回每日任务列表项领取按钮
function GuideManager.get_daily_task_item_btn_by_id(id)
	local ui = uiManager:FindUI(EUI.UiDailyTask)
	if ui and ui.GetItemBtnById then
		return ui:GetItemBtnById(id)
	end
end
-- 获取角色详情界面指定功能id页签的列表项 battle_ui/
function GuideManager.get_role_view_yeka_by_id(id)
	local ui = uiManager:FindUI(EUI.BattleUI)
	if ui and ui.GetToggleBtnUi then
		return ui:GetToggleBtnUi(id)
	end
end
-- 获取角色详情界面指定英雄配置编号id的列表项 battle_ui/
function GuideManager.get_role_view_hero_item_by_id(id)
	return this._get_view_hero_item_by_id(EUI.BattleUI, id)
end
-- 获取角色详情界面指定索引index列表项 battle_ui/
function GuideManager.get_role_view_hero_item_by_index(index)
	return this._get_view_hero_item_by_index(EUI.BattleUI, index)
end
-- 获取装备详情界面指定英雄配置编号id的列表项 ui_604_battle/
function GuideManager.get_equip_view_hero_item_by_id(id)
	return this._get_view_hero_item_by_id(EUI.EquipPackageUI, id)
end
-- 获取装备详情界面指定索引index列表项 ui_604_battle/
function GuideManager.get_equip_view_hero_item_by_index(index)
	return this._get_view_hero_item_by_index(EUI.EquipPackageUI, index)
end
-- 获取阵容详情界面指定英雄配置编号id的列表项 formation_ui/
function GuideManager.get_team_view_hero_item_by_id(id)
	return this._get_view_hero_item_by_id(EUI.FormationUi2, id)
end
-- 获取阵容详情界面指定索引index列表项 formation_ui/
function GuideManager.get_team_view_hero_item_by_index(index)
	return this._get_view_hero_item_by_index(EUI.FormationUi2, index)
end
function GuideManager._get_view_hero_item_by_id(eui, id)
	local ui = uiManager:FindUI(eui)
	if ui and ui.GetHeroListUi then
		local list = ui:GetHeroListUi()
		if list and list.GetCardUiByHeroId then
			return list:GetCardUiByHeroId(id)
		end
	end
end
function GuideManager._get_view_hero_item_by_index(eui, index)
	local ui = uiManager:FindUI(eui)
	if ui and ui.GetHeroListUi then
		local list = ui:GetHeroListUi()
		if list and list.GetCardUiByIndex then
			return list:GetCardUiByIndex(index)
		end
	end
end

-- 获取角色列表界面指定索引index列表项 ui_602_5/
function GuideManager.get_role_item_btn1_by_index(index)
	return this.get_role_item_by_index(index, 1) 
end
function GuideManager.get_role_item_btn2_by_index(index)
	return this.get_role_item_by_index(index, 2)
end
function GuideManager.get_role_item_btn3_by_index(index)
	return this.get_role_item_by_index(index, 3)
end

-- 获取角色列表界面指定英雄id列表项 ui_602_5/
function GuideManager.get_role_item_btn1_by_id(id)
	return this.get_role_item_by_id(id, 1)
end
function GuideManager.get_role_item_btn2_by_id(id)
	return this.get_role_item_by_id(id, 2)
end
function GuideManager.get_role_item_btn3_by_id(id)
	return this.get_role_item_by_id(id, 3)
end

-- 获取角色列表界面指定索引index列表项 功能按钮 ui_602_5/
function GuideManager.get_role_item_by_index(index, type)
	local ui = uiManager:FindUI(EUI.HeroPackageUI)
	if ui and ui.GetHeroListUiByIndex then
		return ui:GetHeroListUiByIndex(index, type)
	end
end

-- 获取角色列表界面指定英雄id列表项 功能按钮 ui_602_5/
function GuideManager.get_role_item_by_id(id, type)
	local ui = uiManager:FindUI(EUI.HeroPackageUI)
	if ui and ui.GetHeroListUiById then
		return ui:GetHeroListUiById(id, type)
	end
end

-- 获取角色列表界面第一个上阵英雄列表项 - 装备按钮
function GuideManager.get_role_item_btn1_by_formation()
	local defTeam = g_dataCenter.player:GetDefTeam()
	if defTeam and defTeam[1] then
		local card = g_dataCenter.package:find_card(ENUM.EPackageType.Hero, defTeam[1])
		if card then
			return this.get_role_item_by_id(card.default_rarity, 1)
		end
	end
end
-- 获取角色列表界面第一个上阵英雄列表项 - 强化按钮
function GuideManager.get_role_item_btn2_by_formation()
	local defTeam = g_dataCenter.player:GetDefTeam()
	if defTeam and defTeam[1] then
		local card = g_dataCenter.package:find_card(ENUM.EPackageType.Hero, defTeam[1])
		if card then
			return this.get_role_item_by_id(card.number, 2)
		end
	end
end

-- 获取角色列表界面战力第一的英雄列表项 - 装备按钮
function GuideManager.get_role_item_btn1_by_fight_value()
	local heroList = g_dataCenter.package:get_hero_card_table()
	local fight_value = 0
	local temp_value = 0
	local card_id = nil
	for i, v in pairs(heroList) do
		temp_value = v:GetFightValue()
		if temp_value > fight_value then
			fight_value = temp_value
			card_id = v.default_rarity
		end
	end
	return this.get_role_item_by_id(card_id, 1)
end
-- 获取角色列表界面战力第一的英雄列表项 - 强化按钮
function GuideManager.get_role_item_btn2_by_fight_value()
	local heroList = g_dataCenter.package:get_hero_card_table()
	local fight_value = 0
	local temp_value = 0
	local card_id = nil
	for i, v in pairs(heroList) do
		temp_value = v:GetFightValue()
		if temp_value > fight_value then
			fight_value = temp_value
			card_id = v.default_rarity
		end
	end
	return this.get_role_item_by_id(card_id, 2)
end

-- 获取竞技场前面那个对手的挑战按钮
function GuideManager.get_arena_player_ahead_fight_btn()
	local ui = uiManager:FindUI(EUI.ArenaMainUI)
	if ui and ui.GetPlayerAheadFightBtnUi then
		return ui:GetPlayerAheadFightBtnUi()
	end
end

-- 获取战队列表界面指定索引index进入按钮（同时定位）
function GuideManager.get_clan_list_item_btn_by_index(index)
	local ui = uiManager:FindUI(EUI.ClanUI)
	if ui and ui.SetListItemBtnUiByIndex and ui:SetListItemBtnUiByIndex(index) and ui.GetListItemBtnUiByIndex then
		return ui:GetListItemBtnUiByIndex(index)
	end
end

-- 获取主界面指定name按钮组件
function GuideManager.get_main_ui_btn_by_name(name)
	local ui = GetMainUI():GetPlayerMenu()
	if ui and ui.GetBtnUiByName then
		return ui:GetBtnUiByName(name)
	end
end

-- 获取主界面场景中按钮组件
function GuideManager.get_main_scene_btn_by_id(id)
	if MainUIPlayerMenu and MainUIPlayerMenu.Get3dSceneBtnObj then
		return MainUIPlayerMenu.Get3dSceneBtnObj(id)
	end
end

-- 获取角色历练引导英雄（第一个）
function GuideManager.get_hero_trial_item()
	local ui = uiManager:FindUI(EUI.HeroTrialFormationUI)
	if ui and ui.GetGuideHeroItem then
		return ui:GetGuideHeroItem()
	end
end

-- 获取远征第一个关卡
function GuideManager.get_expedition_trial_map_level1()
	local ui = uiManager:FindUI(EUI.ExpeditionTrialMap)
	if ui and ui.GetSpTouchTip1 then
		local obj = ui:GetSpTouchTip1()
		if obj then
			this._set_disable_move_expedition_trial_map(true)
			-- this._expedition_trial_fix = true -- 现在不需要修正偏移了...
			return obj
		end
	end
end

function GuideManager._set_disable_move_expedition_trial_map(bool)
	local ui = uiManager:FindUI(EUI.ExpeditionTrialMap)
	if ui and ui.SetDisableMove then
		ui:SetDisableMove(bool)
	end
end

-------------------------------条件函数-----------------------------
function GuideManager.condition_passed_section_ani(sectionId)
	if sectionId == nil then return true end -- 动画回调通知

    local result = g_dataCenter.hurdle:IsHaveNewGroupAnim(sectionId)
    if not result then
        result = UiLevelNewGroup.IsPlaying() --正在播放中
    end
    return not result
end