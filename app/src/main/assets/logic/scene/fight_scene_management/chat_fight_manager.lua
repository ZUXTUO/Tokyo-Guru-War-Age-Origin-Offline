
ChatFightManager = Class("ChatFightManager", FightManager)


function ChatFightManager.InitInstance()
	FightManager.InitInstance(ChatFightManager)
	return ChatFightManager
end

function ChatFightManager:InitData()
	FightManager.InitData(self)

end

function ChatFightManager:GetHeroAssetFileList(out_file_list)
	for i, v in ipairs(g_dataCenter.chatFight:GetShowFighter()) do
		ObjectManager.GetHeroPreloadList(v.cardNumber, out_file_list)
	end
	out_file_list[PublicStruct.Temp_Model_File] = PublicStruct.Temp_Model_File
end

function ChatFightManager:GetPreLoadPolicy()
	return {preload_hero = true, preload_npc = false}
end

function ChatFightManager:GetUIAssetFileList(out_file_list)
	out_file_list["assetbundles/prefabs/ui/new_fight/panel_start_huihe.assetbundle"] = "assetbundles/prefabs/ui/new_fight/panel_start_huihe.assetbundle";
	FightManager.AddPreLoadRes(MMOMainUI.GetWorldChatRes(), out_file_list)
	FightManager.AddPreLoadRes(MMOMainUI.GetZouMaDengRes(), out_file_list)
	FightManager.AddPreLoadRes(MMOMainUI.GetOptionTipRes(), out_file_list)
	FightManager.AddPreLoadRes(MMOMainUI.GetJoystickRes(), out_file_list)
	FightManager.AddPreLoadRes(MMOMainUI.GetSkillInputRes(), out_file_list)
	FightManager.AddPreLoadRes(MMOMainUI.GetChatFightRes(), out_file_list)
end

function ChatFightManager:OnUiInitFinish()

	local cf = ConfigHelper.GetHurdleConfig(FightScene.GetCurHurdleID());
	local configIsAuto = cf.is_auto > 0;
	local configIsShowStarTip = (cf.is_show_star_tip == 1)
	--local configIsSwitchTarget = cf.is_switch_target > 0;

	GetMainUI():InitWorldChat()
	GetMainUI():InitZouMaDeng()
	GetMainUI():InitOptionTip(configIsShowStarTip, configIsAuto)
	GetMainUI():InitJoystick()
	GetMainUI():InitSkillInput(configIsSwitchTarget)
	GetMainUI():InitChatFight()

	--self:StartTime();
end

function ChatFightManager:OnLoadHero(entity)
	entity:HideHP(true);
	entity:SetConfig("view_radius", 100)
	entity:SetConfig("act_radius", 100)

	if entity:GetOwnerPlayerGID() == g_dataCenter.player:GetGID() then
		if g_dataCenter.fight_info:GetCaptainIndex() == nil then
			g_dataCenter.player:ChangeCaptain(1, nil, false, true)
		else
			entity:SetAI(ENUM.EAI.FollowHero)
			--GetMainUI():UpdateHeadData();
		end
	else
		entity:SetAI(115)
	end
end