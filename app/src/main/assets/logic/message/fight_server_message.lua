msg_fight_server = {};
function msg_fight_server.cg_register_fight_server()
    if not Socket.socketCenterServer then return end
    nmsg_fight_server.cg_register_fight_server(Socket.socketCenterServer);
end

function msg_fight_server.gc_register_fight_server_rst(rst)
    app.log("战斗客户端注册成功")
    app.set_time_scale(10);
end

function msg_fight_server.gc_create_fight()
    app.log("开始一场战斗")
	local fs = FightStartUpInf:new()
    PublicStruct.Fight_Sync_Type = ENUM.EFightSyncType.Single
    fs:SetLevelIndex(60120004)
    fs:SetPlayMethod(MsgEnum.eactivity_time.eActivityTime_OfflineFight)
    --构建左方
    local player1 = Player:new();
    local player_info1 = {}
    player_info1.playerid = "1";
	player_info1.name = "左方";
	player_info1.level = 1;
	player1:UpdateData(player_info1);
	local package1 = Package:new();
	local card1 = {}
	card1.dataid = 1
	card1.number = 30001308
	card1.level = 1
	card1.cur_exp = 0
	card1.skill_info = {}
	card1.passivity_property_info = {}
	card1.play_method_hp = {}
	card1.property = {}
	card1.property[ENUM.EHeroAttribute.cur_hp-ENUM.min_property_id] = 0
	card1.property[ENUM.EHeroAttribute.max_hp-ENUM.min_property_id] = 10000
	card1.property[ENUM.EHeroAttribute.atk_power-ENUM.min_property_id] = 1000
	card1.property[ENUM.EHeroAttribute.def_power-ENUM.min_property_id] = 0
	card1.property[ENUM.EHeroAttribute.crit_rate-ENUM.min_property_id] = 0
	card1.property[ENUM.EHeroAttribute.anti_crite-ENUM.min_property_id] = 0
	card1.property[ENUM.EHeroAttribute.crit_hurt-ENUM.min_property_id] = 0
	card1.property[ENUM.EHeroAttribute.broken_rate-ENUM.min_property_id] = 0
	card1.property[ENUM.EHeroAttribute.parry_rate-ENUM.min_property_id] = 0
	card1.property[ENUM.EHeroAttribute.parry_plus-ENUM.min_property_id] = 0
	card1.property[ENUM.EHeroAttribute.move_speed-ENUM.min_property_id] = 4
	package1:AddCard(ENUM.EPackageType.Hero, card1);
	player1:SetPackage(package1);
	local defTeam1 = {}
	defTeam1[1] = card1.dataid
	local team_info1 = {};
	team_info1[1] = {}
	team_info1[1].index = card1.dataid
	team_info1[1].pos = 6
    fs:AddFightPlayer(g_dataCenter.fight_info.single_friend_flag, player1, package1, EFightPlayerType.human, defTeam1, {teamPos =team_info1})
    --构建右方
    local player2 = Player:new();
    local player_info2 = {}
    player_info2.playerid = "1";
	player_info2.name = "左方";
	player_info2.level = 1;
	player2:UpdateData(player_info2);
	local package2 = Package:new();
	local card2 = {}
	card2.dataid = 2
	card2.number = 30001308
	card2.level = 1
	card2.cur_exp = 0
	card2.skill_info = {}
	card2.passivity_property_info = {}
	card2.play_method_hp = {}
	card2.property = {}
	card2.property[ENUM.EHeroAttribute.cur_hp-ENUM.min_property_id] = 0
	card2.property[ENUM.EHeroAttribute.max_hp-ENUM.min_property_id] = 10000
	card2.property[ENUM.EHeroAttribute.atk_power-ENUM.min_property_id] = 1000
	card2.property[ENUM.EHeroAttribute.def_power-ENUM.min_property_id] = 0
	card2.property[ENUM.EHeroAttribute.crit_rate-ENUM.min_property_id] = 0
	card2.property[ENUM.EHeroAttribute.anti_crite-ENUM.min_property_id] = 0
	card2.property[ENUM.EHeroAttribute.crit_hurt-ENUM.min_property_id] = 0
	card2.property[ENUM.EHeroAttribute.broken_rate-ENUM.min_property_id] = 0
	card2.property[ENUM.EHeroAttribute.parry_rate-ENUM.min_property_id] = 0
	card2.property[ENUM.EHeroAttribute.parry_plus-ENUM.min_property_id] = 0
	card2.property[ENUM.EHeroAttribute.move_speed-ENUM.min_property_id] = 4
	package2:AddCard(ENUM.EPackageType.Hero, card2);
	player2:SetPackage(package2);
	local defTeam2 = {}
	defTeam2[1] = card2.dataid
	local team_info2 = {};
	team_info2[1] = {}
	team_info2[1].index = card2.dataid
	team_info2[1].pos = 6
    fs:AddFightPlayer(g_dataCenter.fight_info.single_enemy_flag, player2, package2, EFightPlayerType.human, defTeam2, {teamPos =team_info2})



    SceneManager.PushScene(FightScene,fs)
end