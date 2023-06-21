BaoWeiZhanFightManager = Class("BaoWeiZhanFightManager", FightManager)

function BaoWeiZhanFightManager:InitData()
	FightManager.InitData(self)
	--<region: member field >
	self.teamInfo = {}
	self.heroIndex = 1;
	self.curHeroNum = 0;
	self.bigWave = 0;
	self.smallWave = 0;
	self.boss_entity_name = nil;
	self.deadNum = 0;
	self.waitNum = 0;
	-- self.dataCenter = nil;
	--</region:member field>
end

function BaoWeiZhanFightManager.InitInstance()
	BaoWeiZhanFightManager._super.InitInstance(BaoWeiZhanFightManager)
	return BaoWeiZhanFightManager;
end


function BaoWeiZhanFightManager:ClearUpInstance()
	FightManager.ClearUpInstance(self)
	-- GaoSuJuJiFightUI.Destroy()
	---
end

function BaoWeiZhanFightManager:Start()
	--self:_OnStart()

    --self.followHeroUsedAI = self:GetFightScript().hero_id
	FightManager.Start(self)
end

function BaoWeiZhanFightManager:OnLoadMonster(entity)
	if not entity:IsEnemy() then
        self.diaoxiangEntityName = entity:GetName()
		-- self.boss_entity_name = entity:GetName();
		-- if self.dataCenter.bigWave ~= 0 and self.dataCenter:GetBossHP() ~= 0 then
		-- 	entity:SetProperty('cur_hp',self.dataCenter:GetBossHP());
		-- end
	end
end

function BaoWeiZhanFightManager:OnUiInitFinish()
    FightManager.OnUiInitFinish(self);

	local optionTipCom = GetMainUI():GetOptionTipUI()
	if optionTipCom then
		local count = nil
		if self.monsterLoader then
			count = self.monsterLoader:GetMonsterWaveMaxWaveCnt()
		end
		optionTipCom:ShowMonsterWaveInfo(count)
	end

    if self.diaoxiangEntityName then
        local obj = GetObj(self.diaoxiangEntityName)
		if obj then
			obj.ui_hp:SetName(true, "守护目标", 2)
		end
    end
end

function BaoWeiZhanFightManager:OnBeginWave(cur_wave,max_wave)
	local optionTipCom = GetMainUI():GetOptionTipUI()
	if optionTipCom then
		optionTipCom:UpdateMonsterWaveInfo(cur_wave,max_wave)
	end
end

-- function BaoWeiZhanFightManager:GetMainHeroAutoFightAI()
--     return 112
-- end

function BaoWeiZhanFightManager:OnLoadHero(entity)
	FightManager.OnLoadHero(self, entity);
	entity:SetHomePosition(entity:GetPosition(true, true))
end
