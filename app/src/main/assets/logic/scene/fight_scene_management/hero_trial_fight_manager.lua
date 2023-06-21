
HeroTrialFightManager = Class("HeroTrialFightManager", FightManager)

function HeroTrialFightManager:InitData()
    FightManager.InitData(self)
    self.showKillUi = false
    self.showWaveUi = false
    local config = ConfigManager.Get(EConfigIndex.t_hero_trial_hurdle_info, FightScene.GetCurHurdleID())
    if config then
        if config.show_ui == 1 then
            self.showKillUi = true
        elseif config.show_ui == 2 then
            self.showWaveUi = true
        end
    end
end

function HeroTrialFightManager.InitInstance()
	FightManager.InitInstance(HeroTrialFightManager)
	return HeroTrialFightManager
end

function HeroTrialFightManager:ClearUpInstance()
	FightManager.ClearUpInstance(self)
end

function HeroTrialFightManager:OnFightOver()
    FightManager.OnFightOver(self)

    if self.showKillUi then
        HeroTrialFightKillUI.Destroy()
    end
end

-- 各玩法战斗管理器重新改方法
function HeroTrialFightManager:GetMonsterLevel()
	return g_dataCenter.player:GetLevel()
end

function HeroTrialFightManager:OnEvent_ObjDead(killer, target)
    FightManager.OnEvent_ObjDead(self, killer, target)

    if self.showKillUi then
        local friend_camp_flag = g_dataCenter.fight_info.single_friend_flag
        if killer:GetCampFlag() == friend_camp_flag then
            local killMonster = FightRecord.GetKillTotalNumber(friend_camp_flag)
            HeroTrialFightKillUI.SetData(killMonster)
        end
    end
end

function HeroTrialFightManager:OnBeginWave(cur_wave,max_wave)
    if not self.showWaveUi then return end

    if GetMainUI() then
        GetMainUI():GetComponent(EMMOMainUICOM.MainUIShowFightWave):UpdateWave(cur_wave,max_wave)
    end
end

function HeroTrialFightManager:GetUIAssetFileList(out_file_list)
    FightManager.GetUIAssetFileList(self, out_file_list)
    
    if self.showKillUi then
        FightManager.AddPreLoadRes(HeroTrialFightKillUI.GetResList(), out_file_list)
    end
    if self.showWaveUi then
        FightManager.AddPreLoadRes(MMOMainUI.GetShowFightWaveRes(), out_file_list)
    end
end

function HeroTrialFightManager:OnUiInitFinish()
    if self.showKillUi then
        HeroTrialFightKillUI.Start()
    end
    if self.showWaveUi then
        GetMainUI():InitShowFightWave()
    end
    
	FightManager.OnUiInitFinish(self)
end

