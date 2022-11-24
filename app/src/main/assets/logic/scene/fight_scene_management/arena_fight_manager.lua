
ArenaFightManager = Class("ArenaFightManager", EmbattleAutoFightManager)

function ArenaFightManager:InitData()
	EmbattleAutoFightManager.InitData(self)
end

function ArenaFightManager.InitInstance()
	EmbattleAutoFightManager.InitInstance(ArenaFightManager)
	return ArenaFightManager
end

function ArenaFightManager:ClearUpInstance()
	EmbattleAutoFightManager.ClearUpInstance(self)
end

function ArenaFightManager:OnStart()
	EmbattleAutoFightManager.OnStart(self)
end

-- function ArenaFightManager:LoadHero()
--     return true
-- end

function ArenaFightManager:OnLoadNPC(entity)

end

function ArenaFightManager:GetUIAssetFileList(out_file_list)
	FightManager.AddPreLoadRes(MMOMainUI.GetTimerRes(), out_file_list)
	FightManager.AddPreLoadRes(MMOMainUI.GetWorldChatRes(), out_file_list)
	FightManager.AddPreLoadRes(MMOMainUI.GetZouMaDengRes(), out_file_list)
    FightManager.AddPreLoadRes(MMOMainUI.GetTouchMoveCameraRes(), out_file_list)
    -- FightManager.AddPreLoadRes(NewFightUiCount.GetResList(), out_file_list)
    FightManager.AddPreLoadRes(FightStartUI.GetResList(), out_file_list)
    FightManager.AddPreLoadRes(MMOMainUI.GetMMOFightUIClickRes(), out_file_list)
    FightManager.AddPreLoadRes(MMOMainUI.GetTeamCanChangeRes(), out_file_list)
end

function ArenaFightManager:OnUiInitFinish()
	-- EmbattleAutoFightManager.OnUiInitFinish(self)
	
    local camera = asset_game_object.find("fightCamera")
	AudioManager.SetAudioListenerFollowObj(true,camera)

    GetMainUI():InitWorldChat()
    GetMainUI():InitZouMaDeng()
    GetMainUI():InitTouchMoveCamera()
    GetMainUI():InitMMOFightUIClick();
    GetMainUI():InitTeamCanChange(false, false, true)
    GetMainUI():InitTimer()
    GetMainUI():InitOptionTip(false, false)

	FightStartUI.Show({need_pause=true})
    FightStartUI.SetEndCallback(self.CallFightStart, self)
end

function ArenaFightManager:OnLoadHero(entity)
    EmbattleFightManager.OnLoadHero(self, entity)
    entity:SetDontReborn(true)

    entity:SetConfig("view_radius", 1000)
    entity:SetConfig("act_radius", 2000)

    entity:SetAI(151)
end

