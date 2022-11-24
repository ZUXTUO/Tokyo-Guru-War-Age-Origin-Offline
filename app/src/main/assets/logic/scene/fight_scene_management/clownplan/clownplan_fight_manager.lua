ClownPlanFightManager = Class("ClownPlanFightManager", FightManager)

local _AUDIO_IDS= 
{	
	[1]=81500029,
	[2]=81500030
}

local pieceAnimations = 
{
	{aniName = "facepiece", dummyNode = "facepiece_position01"},
	{aniName = "facepiece02", dummyNode = "facepiece_position02"},
	{aniName = "facepiece03", dummyNode = "facepiece_position03"}
}

function ClownPlanFightManager:GetRandomAudioId()
	return _AUDIO_IDS[math.random(1,2)]
end

function ClownPlanFightManager:InitData()
	FightManager.InitData(self)
	-- 造成总伤害
	self.total_damage = 0
	self.clownPlanFightOver = nil

end

function ClownPlanFightManager:InitInstance()
	FightManager.InitInstance(ClownPlanFightManager)
	return ClownPlanFightManager;
end

function ClownPlanFightManager:Start()
	FightManager.Start(self)
end

function ClownPlanFightManager:LoadUI()
	FightManager.LoadUI(self)
	UiClownPlanFightShow.ShowUi()
end

function ClownPlanFightManager:OnStart()
	FightManager.OnStart(self)
	--NewFightUiCount.Start()
end

function ClownPlanFightManager:OnLoadMonster(entity)
	FightManager.OnLoadMonster(self, entity)
	g_dataCenter.activity[MsgEnum.eactivity_time.eActivityTime_ClownPlan]:SetBossMaxHp(entity:GetPropertyVal("max_hp"))
	--entity:SetAI(123)
	--GetMainUI():GetComponent(EMMOMainUICOM.NewFightUiBosshp);
	-- 123
	--app.log("ClownPlanFightManager:OnLoadMonster child")
end


function ClownPlanFightManager:CheckPassCondition()
	if self:IsFightOver() then
		return
	end


	self.passCondition.good.flag = false
	self.passCondition.perfect.flag = false

	-- app.log("win condition:"..self.passCondition.win)
	--app.log("FightManager:CheckPassCondition " .. table.tostring(self.passCondition.win.check))
	self.passCondition.win.flag = self:__checkConditionOr(self.passCondition.win.check)

	if self.passCondition.win.flag then		 
		self:FightOver()
	end
	--app.log("FightManager:CheckPassCondition child win_flag=" .. tostring(self.passCondition.win.flag))
end

function ClownPlanFightManager:OnEvent_TimeOut()
	FightManager.OnEvent_TimeOut(self)

end

function ClownPlanFightManager:OnEvent_OnInjured(obj, attack, hp)
	if obj:IsEnemy() then
		self:OnDamage(obj, hp)
	end
	--FightManager.OnEvent_OnInjured(self, obj, attack, hp)
	if not ClownPlanFightManager.last_voice_time then
		ClownPlanFightManager.last_voice_time = 0
	end
	local a_time = app.get_time()
	if a_time - ClownPlanFightManager.last_voice_time > 5 then
		AudioManager.Play3dAudio(self:GetRandomAudioId(), AudioManager.GetUiAudioSourceNode(), true, true)
		ClownPlanFightManager.last_voice_time  = a_time
	end
end


function ClownPlanFightManager:OnDamage(obj, hp)


	local g_data = g_dataCenter.activity[MsgEnum.eactivity_time.eActivityTime_ClownPlan]
	local targetPosition = g_data:GetGoldTargetPosition()
	local diff_level = tonumber(g_data:GetDifficultLevel())
	
	local level_data = ConfigManager.Get(EConfigIndex.t_clown_plan_hurdle, diff_level)
	
	local gain_hp = PublicFunc.AttrInteger(math.abs(hp))

	local _total_damage = ClownPlanFightManager.total_damage
	local _new_damage = ClownPlanFightManager.total_damage + gain_hp
	if _new_damage > g_data:GetBossMaxHp() then
		_new_damage = g_data:GetBossMaxHp()
	end	

	ClownPlanFightManager.total_damage = _new_damage
	UiClownPlanFightShow.SetDamageNumber(_new_damage)	

	local oldObtainNum = self:CalTotalNum(_total_damage)
	local newObtainNum = self:CalTotalNum(_new_damage)

	local diffNum = newObtainNum - oldObtainNum

	--if newObtainNum - oldObtainNum < 1 then return end
	--app.log("#hyg#num ========== " .. tostring(newObtainNum - oldObtainNum))

	local orix, oriy, oriz = obj:GetPositionXYZ()

	for i = 1, 6 do	
		--local addNum = oldObtainNum + i
		local captain = FightManager.GetMyCaptain()
		if captain == nil then return end

		OGM.GetGameObject("assetbundles/prefabs/fx/fx_scene/fx_facepiece01/fx_facepiece01.assetbundle", function(gObject)

			local obj_Id = gObject:GetId()
			local go = gObject:GetGameObject()

			go:set_position(orix, oriy, oriz)

			local angle = math.random(0, 360)
			go:set_local_rotation(0, angle, 0)

			local aniInfo = pieceAnimations[math.random(1, #pieceAnimations)]
			local aniNode = go:get_child_by_name("facepiece")
			aniNode:animated_play(aniInfo.aniName)

			TimerManager.Add( function ()

				local gObject = OGM.GetGObject(obj_Id)
				if gObject  == nil then return end
				local go = gObject:GetGameObject()

				local dummyNode = go:get_child_by_name(aniInfo.dummyNode)
				local dummyX, dummyY, dummZ = dummyNode:get_local_position()
				local qx,qy,qz,qw = util.quaternion_euler(0, angle, 0)
				dummyX, dummyY, dummZ = util.quaternion_multiply_v3(qx,qy,qz,qw, dummyX, dummyY, dummZ)

				Tween.addTween(go, 0.6, {}, Transitions.EASE_IN, 0, nil,
				function(progress)

					local gObject = OGM.GetGObject(obj_Id)
					if gObject  == nil then return end
					local go = gObject:GetGameObject()
					
					local captain = FightManager.GetMyCaptain()
					if captain == nil then return end

					local cx, cy, cz = captain:GetPositionXYZ()
					cy = cy + 1
					cx, cy, cz = cx - dummyX, cy - dummyY, cz - dummZ

					go:set_position(
						algorthm.NumberLerp(orix, cx, progress), 
						algorthm.NumberLerp(oriy, cy, progress), 
						algorthm.NumberLerp(oriz, cz, progress))
				end,
				function(progress)
					OGM.UnUse(obj_Id)

					if diffNum > 0 then
						UiClownPlanFightShow.SetGoldNumber(newObtainNum)
						UiClownPlanFightShow.PlayGainAni()
					end
				end
				)
			end
			, 1200, 1)

		end, 1)
	end
end

function ClownPlanFightManager:CalTotalNum(damage)
	local g_data = g_dataCenter.activity[MsgEnum.eactivity_time.eActivityTime_ClownPlan]
	local diff_level = tonumber(g_data:GetDifficultLevel())
	local level_data = ConfigManager.Get(EConfigIndex.t_clown_plan_hurdle, diff_level)

	if type(level_data.base_drop_item) ~= 'table' or #level_data.base_drop_item < 1 then
		return 0
	end
	if type(level_data.base_drop_item[1]) ~= 'table' then
		app.log("config format errro!")
		return 0
	end

	if type(level_data.drop_id_factor) ~= 'table' or #level_data.drop_id_factor < 1 then
		return 0
	end
	if type(level_data.drop_id_factor[1]) ~= 'table' then
		app.log("config format errro!")
		return 0
	end

	local clown_plan_award_add = g_dataCenter.player:GetVipData().clown_plan_award_add;
	if not clown_plan_award_add then
		clown_plan_award_add = 0
	end
	--clown_plan_award_add = 0
	local totalNum = 0

	for k, v in ipairs(level_data.base_drop_item) do
		totalNum = totalNum + PublicFunc.AttrInteger(v[3] * (1 + clown_plan_award_add/100))
	end	

	for k, v in ipairs(level_data.drop_id_factor) do
		totalNum = totalNum + PublicFunc.AttrInteger(damage * v[3] * (1 + clown_plan_award_add/100))
	end

	return totalNum
end

function ClownPlanFightManager:GetMainHeroAutoFightViewAndActRadius()
    return 1000,1000
end

function ClownPlanFightManager:MonsterBloodReduce(entity, attacker)	 
	 FightManager.MonsterBloodReduce(self,entity,attacker)
	 local mainUI = GetMainUI()
	 if mainUI and mainUI.GetBosshp then
     	local bossHp = mainUI:GetBosshp()
     	if bossHp then
     		bossHp:SetLevelActive(false)
     	else
     		GetMainUI():InitBosshp(2, entity:GetName())
     	end
     end
end

function ClownPlanFightManager:OnFightOver()
	self:OnShowFightResultUI()
end

function ClownPlanFightManager:FightOver(is_set_exit, is_forced_exit)

	if self.clownPlanFightOver then
		return
	end

	self.clownPlanFightOver = true
	ObjectManager.EnableAllAi(false)
	UiClownPlanFightShow.DestroyUi()
	if GetMainUI() then
	    GetMainUI():OnFightOver()
	end

	if not is_set_exit and not is_forced_exit then
		local damage = ClownPlanFightManager.total_damage or 0
		local gainNum = self:CalTotalNum(damage)
		self:SetConditionWinFlag(gainNum > 0)

		local flag = nil
		if self.passCondition.win.flag == true then
			flag = true
		elseif self.passCondition.lose.flag == true then
			flag = false
		end
		ObjectManager.OnFightOver(flag);

		if not ScreenPlay.IsRun() then
			self:__FightOver(is_set_exit, is_forced_exit)
		else
			ScreenPlay.SetCallback(function ()
			self:__FightOver(is_set_exit, is_forced_exit)
			end);
		end
	else
		self:__FightOver(is_set_exit, is_forced_exit)
	end

end

function ClownPlanFightManager:__FightOver(is_set_exit, is_forced_exit)

	local boss = g_dataCenter.fight_info:GetBoss(EFightInfoFlag.flag_b)	 
	local boss_dead = boss == nil or boss:IsDead()
	local func_over = function()
		FightManager.FightOver(self,is_set_exit, is_forced_exit)	
	end
	if boss_dead == true then
		CommonKuikuliyaWinUI.Start()
		CommonKuikuliyaWinUI.SetEndCallback(function()
			func_over()	
		end)
	else
		func_over()
	end
end

function ClownPlanFightManager:OnUiInitFinish()
	local hurdle = ConfigHelper.GetHurdleConfig(FightScene.GetLevelID());
	local str = hurdle.tips_string;
	local time = hurdle.tips_last;

	local cf = ConfigHelper.GetHurdleConfig(FightScene.GetCurHurdleID());
	local configIsAuto = cf.is_auto > 0;
	local configIsSwitchTarget = cf.is_switch_target > 0;
	local configIsClickMove = (cf.is_click_move == 1)
	GetMainUI():InitWorldChat()
	GetMainUI():InitZouMaDeng()
	GetMainUI():InitOptionTip(false, configIsAuto)
	GetMainUI():InitJoystick()
	GetMainUI():InitSkillInput(configIsSwitchTarget)
	GetMainUI():InitProgressBar()
	GetMainUI():InitTriggerOperator()
	GetMainUI():InitMMOFightUIClick();
    if true or pmi then
        GetMainUI():InitTeamCanChange()
    else
        GetMainUI():InitTeamCannotChange()
    end

	GetMainUI():InitTimer()

	FightStartUI.Show({need_pause=true})
	FightStartUI.SetEndCallback(self.CallFightStart, self)
end
 
