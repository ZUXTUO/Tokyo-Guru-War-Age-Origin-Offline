--编号	key值	备注
g_Config.t_hfsm_key_ = {
	id=1,
	keys=2,
}
g_Config.t_hfsm = {
	[100] = "{100,{character_behavior='monster_behavior',fight_attack='actor_stand_patrol',con_check_enemy_key='AI_DetectedEnemy',monster_fight_key='fight_object_pursuit_base'},}",
	[101] = "{101,{base_id=100, fight_attack='actor_random_patrol'},}",
	[102] = "{102,{base_id=100, no_back2home='1',fight_attack='actor_along_path_patrol_exit'},}",
	[103] = "{103,{base_id=100, no_back2home='1',fight_attack='actor_along_path_patrol_exit',con_check_enemy_key='AI_DetectedEnemyJustAccordingToType'},}",
	[104] = "{104,{},}",
	[105] = "{105,{base_id=102, be_attack_max_interval=5,con_check_enemy_key='AI_DetectedEnemyInActiveAttack'},}",
	[106] = "{106,{hfsm_file='follow_hero',follow_hero_fight='follow_hero_fight',fight_attack='follow_hero_behavior',con_check_enemy_key='AI_HeroDetectedMonster'},}",
	[107] = "{107,{base_id=100, con_check_enemy_key='AI_DetectedOtherSideHero'},}",
	[108] = "{108,{},}",
	[109] = "{109,{character_behavior='character_fight',fight_attack='main_hero_auto_fight_behavior'},}",
	[110] = "{110,{hfsm_file='main_hero_fight',is_tower='1'},}",
	[111] = "{111,{base_id=100, con_check_enemy_key='AI_DetectedEnemyInActiveAttack'},}",
	[112] = "{112,{base_id=100, not_reset_hp=1},}",
	[113] = "{113,{base_id=102, con_check_enemy_key='AI_DetectedEnemyFistAttackType',when_lock_type_donot_change_target=1},}",
	[114] = "{114,{hfsm_file='character_fight', fight_attack='main_hero_fight'},}",
	[115] = "{115,{hfsm_file='character_fight'},}",
	[116] = "{116,{hfsm_file='slg_dian_zhang_behavior'},}",
	[117] = "{117,{character_behavior='character_fight',con_check_enemy_key='AI_DetectedEnemy',fight_attack='ai_hero_fight_behavior', actor_patrol_key='AI_State_Patrol'},}",
	[118] = "{118,{hfsm_file='actor_random_patrol', random_move_stand_time=0},}",
	[119] = "{119,{hfsm_file='main_city_scene_virtual_hero'},}",
	[120] = "{120,{base_id=100, con_check_enemy_key='AI_DetectedTargetByBeAttackOrder'},}",
	[121] = "{121,{},}",
	[122] = "{122,{base_id=100, fight_attack='actor_random_patrol',con_check_enemy_key='AI_DetectedEnemyInActiveAttack'},}",
	[123] = "{123,{character_behavior='character_fight', fight_attack='chown_monster'},}",
	[124] = "{124,{hfsm_file='stand_inplace_attack'},}",
	[125] = "{125,{base_id=102, not_reset_hp=1,con_check_enemy_key='AI_DetectEnemyUseOrderMonsterHeroBase'},}",
	[126] = "{126,{character_behavior='character_fight',fight_attack='three_v_three_behavior', con_check_enemy_key='AI_DetectEnemyUseOrderHeroMonsterBase', actor_patrol_key='AI_State_TowWayMobaMoveToNextFightPosition'},}",
	[127] = "{127,{hfsm_file='beginning_move_along_face_direction',beginning_move_len=2,beginning_move_next_ai=112},}",
	[128] = "{128,{character_behavior='character_fight', fight_attack='chown_monster_move_according_to_time'},}",
	[129] = "{129,{hfsm_file='obstacle_gap_attacker'},}",
	[130] = "{130,{hfsm_file='obstacle_gap_attacker', is_obstacle=1},}",
	[131] = "{131,{hfsm_file='obstacle_roadblock'},}",
	[132] = "{132,{hfsm_file='roadblock_switch'},}",
	[133] = "{133,{base_id=102, con_check_enemy_key='AI_DetectedEnemyInActiveAttack'},}",
	[134] = "{134,{base_id=100, monster_fight_key='fight_change_target_by_hatred_value'},}",
	[135] = "{135,{hfsm_file='obstacle_gap_attacker', is_obstacle=1,is_single_use=1, change_can_be_attack=1},}",
	[136] = "{136,{character_behavior='character_fight',fight_attack='main_hero_auto_fight_behavior',move_one_by_one=1},}",
	[137] = "{137,{hfsm_file='droped_key'},}",
	[138] = "{138,{hfsm_file='obstacle_gap_attacker', is_obstacle=1,is_switch_control=1,is_ghost=1},}",
	[139] = "{139,{hfsm_file='obstacle_gap_attacker', is_obstacle=1,is_switch_control=1,is_fake=1},}",
	[140] = "{140,{character_behavior='defensive_tower_fight'},}",
	[141] = "{141,{character_behavior='character_fight', fight_attack='robot_three_v_three_behavior', actor_patrol_key = 'AI_State_3v3MoveToNextFightPosition'},}",
	[142] = "{142,{character_behavior='character_fight', fight_attack='robot_three_v_three_behavior', actor_patrol_key = 'AI_State_3v3MoveToNextFightPosition',is_player_operator=1},}",
	[143] = "{143,{base_id=100, attack_move=1},}",
	[144] = "{144,{character_behavior='obstacle_roadblock', can_be_attack = 1},}",
	[145] = "{145,{character_behavior='be_escort_character_behavior', con_check_enemy_key = 'AI_BeEscortEnterFightState', fight_key = 'be_attack_escape', fight_exit_check_key='AI_BeEscortLeaveFightState'},}",
	[146] = "{146,{character_behavior='be_escort_character_behavior', con_check_enemy_key = 'AI_BeEscortEnterFightState', fight_key = 'charactor_continue_fight', fight_exit_check_key='AI_SubFSMIsEnd'},}",
	[147] = "{147,{character_behavior='character_fight', fight_attack = 'check_escape_or_fight', con_check_enemy_key='AI_DetectedEnemy', move_one_by_one=1},}",
	[148] = "{148,{base_id=100, fight_attack='actor_along_path_patrol_exit'},}",
	[149] = "{149,{character_behavior='character_fight', fight_attack='follow_npc_behavior', con_check_enemy_key='AI_HeroDetectedMonster'},}",
	[150] = "{150,{hfsm_file='ai_run_action', action_key='AI_State_ChangeToSceneProp'},}",
	[151] = "{151,{base_id=100, priority_use_skill=1},}",
	[152] = "{152,{base_id=106, con_check_enemy_key='AI_DetectEnemyUseOrderHeroMonsterBase'},}",
	[153] = "{153,{base_id=100, con_check_enemy_key='AI_DetectEnemyUseOrderHeroMonsterBase'},}",
}
return {key = g_Config.t_hfsm_key_, data = g_Config.t_hfsm } 
 -- 