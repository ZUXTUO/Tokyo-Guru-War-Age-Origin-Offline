--[[
region pvp_common_fight_manager.lua
date: 2015-10-10
time: 12:28:15
author: Nation
]]
PvPCommonFightManager = Class("PvPCommonFightManager", FightManager)

function PvPCommonFightManager:InitData()
	FightManager.InitData(self)
end

function PvPCommonFightManager.InitInstance()
	FightManager.InitInstance(PvPCommonFightManager)
	return PvPCommonFightManager
end

function PvPCommonFightManager:ClearUpInstance()
	FightManager.ClearUpInstance(self)
end

function PvPCommonFightManager:LoadUI()
	FightManager.LoadUI(self)
end

function PvPCommonFightManager:OnStart()
	FightManager.OnStart(self)
end

function PvPCommonFightManager:LoadHero()
    return true
end

--[[function PvPCommonFightManager:LoadMonster()
    return true
end]]

function PvPCommonFightManager:OnLoadHero(entity)
    if entity:GetOwnerPlayerGID() == g_dataCenter.player:GetGID() then
        if g_dataCenter.fight_info:GetCaptainIndex() == nil then
            g_dataCenter.player:ChangeCaptain(1, nil, false, true)
        else
            entity:SetAI(ENUM.EAI.FollowHero)
            GetMainUI():UpdateHeadData();
        end
    else
         entity:SetAI(115)
    end
end

function PvPCommonFightManager:GetHeroAssetFileList(out_file_list)
    out_file_list[PublicStruct.Temp_Model_File] = PublicStruct.Temp_Model_File
end

function PvPCommonFightManager:GetNPCAssetFileList(out_file_list)
end

function PvPCommonFightManager:FightOver(is_set_exit, is_forced_exit)
    world_msg.cg_test_leave_world(1);
    FightManager.FightOver(self, is_set_exit, is_forced_exit)
end
--[[endregion]]