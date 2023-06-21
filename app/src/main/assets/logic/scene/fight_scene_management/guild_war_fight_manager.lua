
GuildWarFightManager = Class("GuildWarFightManager", EmbattleAutoFightManager)

function GuildWarFightManager:InitData()
	EmbattleAutoFightManager.InitData(self)
end

function GuildWarFightManager.InitInstance()
	EmbattleAutoFightManager.InitInstance(GuildWarFightManager)
	return GuildWarFightManager
end

function GuildWarFightManager:ClearUpInstance()
	EmbattleAutoFightManager.ClearUpInstance(self)
end

function GuildWarFightManager:OnStart()
	EmbattleAutoFightManager.OnStart(self)
end

-- function GuildWarFightManager:LoadHero()
--     return true
-- end

function GuildWarFightManager:OnLoadNPC(entity)

end

function GuildWarFightManager:FightOver(is_forced_exit)
	-- add delay time
	if not self._delay_fight_over then
		self._delay_fight_over = Utility.bind_callback(self, GuildWarFightManager.on_delay_fight_over)
		TimerManager.Add(self._delay_fight_over, 2000, 1, is_forced_exit)
		ObjectManager.EnableAllAi(false)
	end
end

function GuildWarFightManager:on_delay_fight_over(is_forced_exit)
	if self._delay_fight_over then
		EmbattleAutoFightManager.FightOver(self, is_forced_exit)
		Utility.unbind_callback(self, self._delay_fight_over)
		self._delay_fight_over = nil
	end
end

function GuildWarFightManager:GetUIAssetFileList(out_file_list)
	FightManager.AddPreLoadRes(MMOMainUI.GetTimerRes(), out_file_list)
	FightManager.AddPreLoadRes(MMOMainUI.GetWorldChatRes(), out_file_list)
	FightManager.AddPreLoadRes(MMOMainUI.GetZouMaDengRes(), out_file_list)
    FightManager.AddPreLoadRes(MMOMainUI.GetTouchMoveCameraRes(), out_file_list)
    FightManager.AddPreLoadRes(NewFightUiCount.GetResList(), out_file_list)
end

function GuildWarFightManager:OnUiInitFinish()
	-- EmbattleAutoFightManager.OnUiInitFinish(self)
	GetMainUI():InitTimer()
	GetMainUI():InitWorldChat()
	GetMainUI():InitZouMaDeng()
    GetMainUI():InitTouchMoveCamera()
    NewFightUiCount.Start()
    local camera = asset_game_object.find("fightCamera")
	AudioManager.SetAudioListenerFollowObj(true, camera)

    self:_SetBuff();

    self:CallFightStart()
end

function GuildWarFightManager:OnFightOver() 
    local _heroHp = {}
    local flags = {g_dataCenter.fight_info.single_friend_flag, g_dataCenter.fight_info.single_enemy_flag}
    for _, flag in pairs(flags) do
        local temp = {}
        local names = g_dataCenter.fight_info:GetHeroList(flag)
        for _, v in pairs(names) do
            local se = ObjectManager.GetObjectByName(v)
            if se.card.index ~= 0 then
                 temp[se.card.index] = se:GetHP()
            end
        end
        _heroHp[flag] = temp
    end
	g_dataCenter.guildWar:SetFightOverHp(_heroHp)
    EmbattleAutoFightManager.OnFightOver(self)
end

function GuildWarFightManager:OnLoadHero(entity)
    if entity.card.index ~= 0 then
        local hp = g_dataCenter.guildWar:GetInitFightHeroHP(entity.card.index)
        if hp then
            entity:SetHP(hp)
        end
    end
    EmbattleAutoFightManager.OnLoadHero(self, entity)    
end

function GuildWarFightManager:_SetBuff()
    local _BuffTimes = g_dataCenter.guildWar:GetBuffLv();
    local cfg = ConfigManager.Get(EConfigIndex.t_guild_war_discrete,1);
    local _BuffValue = {};
    _BuffValue[1] = cfg.crit_value;
    _BuffValue[2] = cfg.attack_value;
    _BuffValue[3] = cfg.defense_value;

    for i=1,3 do
        local buff = g_BuffData[1233].level[i];
        local action = buff.trigger[1].action[1];
        action.value = _BuffTimes[1][i]*_BuffValue[i];

        local buff = g_BuffData[1234].level[i];
        local action = buff.trigger[1].action[1];
        action.value = _BuffTimes[2][i]*_BuffValue[i];
    end

    local hero_list = g_dataCenter.fight_info.hero_list;
    for camp,list in pairs(hero_list) do
        for _,name in pairs(list) do
            local obj = ObjectManager.GetObjectByName(name);
            if camp == 1 then
                obj:AttachBuff(1233,1,obj,obj);
                obj:AttachBuff(1233,2,obj,obj);
                obj:AttachBuff(1233,3,obj,obj);
            else
                obj:AttachBuff(1234,1,obj,obj);
                obj:AttachBuff(1234,2,obj,obj);
                obj:AttachBuff(1234,3,obj,obj);
            end
        end
    end
end
