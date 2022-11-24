--[[
region offline_battle_fight_manager.lua
date: 2016-10-9
time: 15:55:47
author: Nation
]]
--[[endregion]]
OfflineBattleFightManager = Class("OfflineBattleFightManager", EmbattleAutoFightManager)
function OfflineBattleFightManager:InitData()
	EmbattleAutoFightManager.InitData(self)
end

function OfflineBattleFightManager.InitInstance()
	EmbattleAutoFightManager.InitInstance(OfflineBattleFightManager)
	return OfflineBattleFightManager
end

function OfflineBattleFightManager:ClearUpInstance()
	EmbattleAutoFightManager.ClearUpInstance(self)
end

function OfflineBattleFightManager:OnStart()
	EmbattleAutoFightManager.OnStart(self)
end

function OfflineBattleFightManager:OnLoadNPC(entity)

end

function OfflineBattleFightManager:FightOver(is_set_exit, is_forced_exit)
	EmbattleAutoFightManager.FightOver(self, is_set_exit, is_forced_exit)
end

function OfflineBattleFightManager:OnLoadHero(entity)
    EmbattleAutoFightManager.OnLoadHero(self, entity)
    --[[if entity:GetOwnerPlayerGID() == g_dataCenter.player:GetGID() then
        if g_dataCenter.fight_info:GetCaptainIndex() == nil then
            g_dataCenter.fight_info:SetCaptain(1)
        end
    end]]
end

function OfflineBattleFightManager:GetUIAssetFileList(out_file_list)
end

function OfflineBattleFightManager:OnUiInitFinish()
end