nlogin={};
nlogin.ca_gen_key = function(c)
   --gnet.send(c,102);
end
nlogin.ca_connection = function(c,uid)
   --gnet.send(c,103,uid);
end
nlogin.ca_login = function(c,name,pwd,gameid,groupdid,target_version)
   --gnet.send(c,104,name,pwd,gameid,groupdid,target_version);
end
nlogin.ca_server_list = function(c,gameid,groupdid,target_version)
   --gnet.send(c,105,gameid,groupdid,target_version);
end
nlogin.ca_register_user = function(c,name,pwd)
   --gnet.send(c,106,name,pwd);
end
nlogin.ca_verify_account_p = function(c,game_id,account_id,auth_token,device_uuid,user_platform_id,target_version)
   --gnet.send(c,107,game_id,account_id,auth_token,device_uuid,user_platform_id,target_version);
end
nlogin.ca_trusted_login_for_intranet = function(c,game_id,account_id,auth_token,device_uuid,user_platform_id,target_version)
   --gnet.send(c,108,game_id,account_id,auth_token,device_uuid,user_platform_id,target_version);
end
nlogin.pa_device_login = function(c,session_id,ci)
   --gnet.send(c,109,session_id,ci);
end
nlogin.pa_account_login = function(c,session_id,account,pswd_md5,ci)
   --gnet.send(c,110,session_id,account,pswd_md5,ci);
end
nlogin.pa_3rdparty_login = function(c,session_id,channel_id,open_id,token,ci)
   --gnet.send(c,111,session_id,channel_id,open_id,token,ci);
end
nlogin.pa_reg_account = function(c,session_id,account,pswd_md5_or_verfiy_code,ci)
   --gnet.send(c,112,session_id,account,pswd_md5_or_verfiy_code,ci);
end
nlogin.pa_bind_account = function(c,session_id,account,pswd_md5_or_verfiy_code,target_account_id,token,ci)
   --gnet.send(c,113,session_id,account,pswd_md5_or_verfiy_code,target_account_id,token,ci);
end
nlogin.pa_get_server_list = function(c,session_id,channel_id,ver_flag,account_id,token)
   --gnet.send(c,114,session_id,channel_id,ver_flag,account_id,token);
end
nlogin.pa_check_login = function(c,session_id,account_id,token)
   --gnet.send(c,115,session_id,account_id,token);
end
nlogin.pa_sennd_check_mail = function(c,session_id,account,token,mails)
   --gnet.send(c,116,session_id,account,token,mails);
end
nlogin.pa_check_mail_click = function(c,session_id,mails_info)
   --gnet.send(c,117,session_id,mails_info);
end
nlogin.pa_get_pswd = function(c,session_id,account,verfiy_code,user_data,ci)
   --gnet.send(c,118,session_id,account,verfiy_code,user_data,ci);
end
nlogin.pa_device_details = function(c,deviceInfo)
   --gnet.send(c,119,deviceInfo);
end
nmsg_move={};
nmsg_move.cg_move = function(c,gid,sx,sy,dx,dy)
   --gnet.send(c,1002,gid,sx,sy,dx,dy);
end
nmsg_move.cg_move_multi = function(c,gid,sx,sy,dx1,dy1,dx2,dy2,dx3,dy3)
   --gnet.send(c,1003,gid,sx,sy,dx1,dy1,dx2,dy2,dx3,dy3);
end
nmsg_move.cg_request_real_position = function(c,gid)
   --gnet.send(c,1004,gid);
end
nmsg_move.cg_stand = function(c,gid,x,y)
   --gnet.send(c,1005,gid,x,y);
end
nmsg_move.cg_translate_position = function(c,gid,x,y)
   --gnet.send(c,1006,gid,x,y);
end
nmsg_move.cg_move_home = function(c,gid,sx,sy,dx1,dy1,dx2,dy2,dx3,dy3)
   --gnet.send(c,1007,gid,sx,sy,dx1,dy1,dx2,dy2,dx3,dy3);
end
nmsg_fight={};
nmsg_fight.cg_use_skill = function(c,info,skill_cd_type)
   --gnet.send(c,1202,info,skill_cd_type);
end
nmsg_fight.cg_skill_calculate = function(c,info)
   --gnet.send(c,1203,info);
end
nmsg_fight.cg_skill_calculate_multi = function(c,msg_list)
   --gnet.send(c,1204,msg_list);
end
nmsg_fight.cg_sync_skill_targets = function(c,info)
   --gnet.send(c,1205,info);
end
nmsg_fight.cg_cancel_skill = function(c,user_gid,skill_id)
   --gnet.send(c,1206,user_gid,skill_id);
end
nmsg_fight.cg_scale_ability = function(c,user_gid,target_gid,ability_type,scale,change,multiply,last_time,record_name)
   --gnet.send(c,1207,user_gid,target_gid,ability_type,scale,change,multiply,last_time,record_name);
end
nmsg_fight.cg_change_ability = function(c,user_gid,target_gid,ability_type,value,change,last_time,record_name,add_scale)
   --gnet.send(c,1208,user_gid,target_gid,ability_type,value,change,last_time,record_name,add_scale);
end
nmsg_fight.cg_scale_hp_recover = function(c,target_gid,scale,change,last_time)
   --gnet.send(c,1209,target_gid,scale,change,last_time);
end
nmsg_fight.cg_ai_agent_keep_alive = function(c,target_gid)
   --gnet.send(c,1210,target_gid);
end
nmsg_fight.cg_sync_aperture_pos = function(c,user_gid,x,y,z)
   --gnet.send(c,1211,user_gid,x,y,z);
end
nmsg_fight.cg_trigger_world_item = function(c,item_gid,user_gid,is_begin_trigger)
   --gnet.send(c,1212,item_gid,user_gid,is_begin_trigger);
end
nmsg_fight.cg_change_fight_extra_property = function(c,target_gid,change,type,info,last_time)
   --gnet.send(c,1213,target_gid,change,type,info,last_time);
end
nmsg_fight.cg_start_skill_cd = function(c,user_gid,skill_id)
   --gnet.send(c,1214,user_gid,skill_id);
end
nmsg_fight.cg_stop_skill_cd = function(c,user_gid,skill_id,cd_value,cd_type)
   --gnet.send(c,1215,user_gid,skill_id,cd_value,cd_type);
end
nmsg_fight.cg_relive_follow_hero = function(c,captain_gid)
   --gnet.send(c,1216,captain_gid);
end
nmsg_fight.cg_sync_taunt_target = function(c,user_gid,target_gid,last_time,buff_id,buff_lv,bStart)
   --gnet.send(c,1217,user_gid,target_gid,last_time,buff_id,buff_lv,bStart);
end
nmsg_fight.cg_change_absorb_damage = function(c,target_gid,start,skill_id,type,value,src_buff_id,src_buff_lv,user_gid,broken_buff_id,broken_buff_lv,last_time)
   --gnet.send(c,1218,target_gid,start,skill_id,type,value,src_buff_id,src_buff_lv,user_gid,broken_buff_id,broken_buff_lv,last_time);
end
nmsg_fight.cg_hero_relive_immediately = function(c)
   --gnet.send(c,1219);
end
nmsg_fight.cg_create_world_item = function(c,user_gid,id,x,y,last_time)
   --gnet.send(c,1220,user_gid,id,x,y,last_time);
end
nmsg_fight.cg_del_world_item = function(c,user_gid,id,x,y,last_time)
   --gnet.send(c,1221,user_gid,id,x,y,last_time);
end
nmsg_fight.cg_add_buff = function(c,user_gid,target_gid,buff_id,buff_lv,skill_id,skill_lv)
   --gnet.send(c,1222,user_gid,target_gid,buff_id,buff_lv,skill_id,skill_lv);
end
nmsg_fight.cg_server_search_and_calculate = function(c,user_gid,skill_id,calc_type,calc_info_index,ex_persent,x,y,target_type,radius,length,width,dx,dy,buffid,bufflv)
   --gnet.send(c,1223,user_gid,skill_id,calc_type,calc_info_index,ex_persent,x,y,target_type,radius,length,width,dx,dy,buffid,bufflv);
end
nmsg_fight.cg_calculate_extra_damage_pool = function(c,user_gid,skill_id,multi_cnt,calc_info_index,target_cnt)
   --gnet.send(c,1224,user_gid,skill_id,multi_cnt,calc_info_index,target_cnt);
end
nmsg_fight.cg_clear_extra_damage_pool = function(c,user_gid)
   --gnet.send(c,1225,user_gid);
end
nmsg_fight.cg_lock_property_change_record = function(c,user_gid,record_name,lock)
   --gnet.send(c,1226,user_gid,record_name,lock);
end
nmsg_fight.cg_cancel_daluandou_fight = function(c)
   --gnet.send(c,1227);
end
nmsg_fight.cg_absorb_ability_to_creator = function(c,user_gid,target_gid,change,target_ability_type,scale,user_ability_type,max_user_scale,sequence)
   --gnet.send(c,1228,user_gid,target_gid,change,target_ability_type,scale,user_ability_type,max_user_scale,sequence);
end
nmsg_fight.cg_change_front_scale_damage = function(c,user_gid,skill_id,change,scale,value,value_type,last_time)
   --gnet.send(c,1229,user_gid,skill_id,change,scale,value,value_type,last_time);
end
nmsg_fight.cg_change_angular_velocity = function(c,target_gid,value,last_time,dirx,dirz,change)
   --gnet.send(c,1230,target_gid,value,last_time,dirx,dirz,change);
end
nmsg_weaknet_white={};
nmsg_weaknet_white.cg_ping = function(c)
   --gnet.send(c,1402);
end
nmsg_weaknet_white.cg_receive_server_msg = function(c,seq_num)
   --gnet.send(c,1403,seq_num);
end
nclient_proxy={};
nclient_proxy.cp_enter_game = function(c,inf)
   --gnet.send(c,1602,inf);
end
nclient_proxy.cp_re_enter_game = function(c,inf)
   --gnet.send(c,1603,inf);
end
nclient_proxy.cp_enter_game_no_auth = function(c,inf)
   --gnet.send(c,1604,inf);
end
nproxy_game={};
nproxy_game.pg_register = function(c,server_id,key,ip,port)
   --gnet.send(c,1802,server_id,key,ip,port);
end
nproxy_game.pg_enter_game = function(c,inf)
   --gnet.send(c,1803,inf);
end
nproxy_game.pg_playerid_error = function(c,player_id)
   --gnet.send(c,1804,player_id);
end
nproxy_game.pg_player_offline = function(c,account_id,server_id,player_session_id)
   --gnet.send(c,1805,account_id,server_id,player_session_id);
end
nproxy_game.pg_re_enter_game = function(c,inf)
   --gnet.send(c,1806,inf);
end
nproxy_game.pg_player_position_fight_server = function(c,magic_number,reconnect,player_id,rst)
   --gnet.send(c,1807,magic_number,reconnect,player_id,rst);
end
nproxy_game.pg_server_inf = function(c)
   --gnet.send(c,1808);
end
nproxy_game.pg_client_offline = function(c,player_id)
   --gnet.send(c,1809,player_id);
end
nproxy_fight={};
nproxy_fight.pf_register = function(c,proxy_server_id,game_server_id)
   --gnet.send(c,2002,proxy_server_id,game_server_id);
end
nproxy_fight.pf_disconnect = function(c,proxy_server_id,game_server_id)
   --gnet.send(c,2003,proxy_server_id,game_server_id);
end
nfight_2_fmanager={};
nfight_2_fmanager.fm_regist = function(c,fight_server_id,ip_4_proxy,port_4_proxy)
   --gnet.send(c,2202,fight_server_id,ip_4_proxy,port_4_proxy);
end
nfight_2_fmanager.fm_proxy_server_connected = function(c,proxy_server_id,game_server_id,fight_server_id)
   --gnet.send(c,2203,proxy_server_id,game_server_id,fight_server_id);
end
nfight_2_fmanager.fm_proxy_server_disconnect = function(c,proxy_server_id,game_server_id,fight_server_id)
   --gnet.send(c,2204,proxy_server_id,game_server_id,fight_server_id);
end
nfight_2_fmanager.fm_allocate_fight_scene_rst = function(c,rst,info)
   --gnet.send(c,2205,rst,info);
end
nfight_2_fmanager.fm_world_item_drop = function(c,game_server_id,item_id,player_id,drop_id)
   --gnet.send(c,2206,game_server_id,item_id,player_id,drop_id);
end
nfight_2_fmanager.fm_monster_drop = function(c,game_server_id,monter_id,player_id,drop_id)
   --gnet.send(c,2207,game_server_id,monter_id,player_id,drop_id);
end
nfight_2_fmanager.fm_send_marquee = function(c,game_server_id,ntype,content,parms,is_server_send,cycle_time,interval,bforce,notice_id)
   --gnet.send(c,2208,game_server_id,ntype,content,parms,is_server_send,cycle_time,interval,bforce,notice_id);
end
nfight_2_fmanager.fm_fight_scene_release = function(c,fight_type)
   --gnet.send(c,2209,fight_type);
end
nfight_2_fmanager.fm_world_treasure_box_over = function(c,game_server_id,result_info)
   --gnet.send(c,2210,game_server_id,result_info);
end
nfight_2_fmanager.fm_sync_world_treasure_box_player_result_info = function(c,game_server_id,info,is_end)
   --gnet.send(c,2211,game_server_id,info,is_end);
end
nfight_2_fmanager.fm_world_treasure_box_open_mysterious_treasure_box_info = function(c,game_server_id,all_players)
   --gnet.send(c,2212,game_server_id,all_players);
end
nfight_2_fmanager.fm_daluandou2_over = function(c,game_server_id,magic_number,playerRank,bcheat)
   --gnet.send(c,2213,game_server_id,magic_number,playerRank,bcheat);
end
nfight_2_fmanager.fm_daluandou2_canel_fight = function(c,game_server_id,magic_number,player_id,rankIndex)
   --gnet.send(c,2214,game_server_id,magic_number,player_id,rankIndex);
end
nfight_2_fmanager.fm_three_to_three_result_info = function(c,game_server_id,magic_number,info)
   --gnet.send(c,2215,game_server_id,magic_number,info);
end
nfight_2_fmanager.fm_guild_boss_killed = function(c,game_server_id,guild_gid,info)
   --gnet.send(c,2216,game_server_id,guild_gid,info);
end
nfight_2_fmanager.fm_sync_guild_boss_hp = function(c,game_server_id,guild_gid,hp)
   --gnet.send(c,2217,game_server_id,guild_gid,hp);
end
nfight_2_fmanager.fm_guild_boss_send_play_reward = function(c,game_server_id,player_gid)
   --gnet.send(c,2218,game_server_id,player_gid);
end
nfight_2_fmanager.fm_guild_boss_send_first_pass_reward = function(c,game_server_id,player_gid,boss_index)
   --gnet.send(c,2219,game_server_id,player_gid,boss_index);
end
nfight_2_fmanager.fm_update_guild_boss_rank_info = function(c,game_server_id,guild_gid,rank_info)
   --gnet.send(c,2220,game_server_id,guild_gid,rank_info);
end
nfight_2_fmanager.fm_world_boss_killed = function(c,game_server_id,info)
   --gnet.send(c,2221,game_server_id,info);
end
nfight_2_fmanager.fm_world_boss_send_damage_reward = function(c,game_server_id,player_gid,weekday,damage)
   --gnet.send(c,2222,game_server_id,player_gid,weekday,damage);
end
nfight_2_fmanager.fm_world_boss_send_luck_attack_reward = function(c,game_server_id,player_gid,weekday,boss_level,last_luck_attack_times)
   --gnet.send(c,2223,game_server_id,player_gid,weekday,boss_level,last_luck_attack_times);
end
nfight_2_fmanager.fm_update_world_boss_player_damage = function(c,game_server_id,player_gid,cur_damage,total_damage)
   --gnet.send(c,2224,game_server_id,player_gid,cur_damage,total_damage);
end
nfight_2_fmanager.fm_update_world_boss_rank_info = function(c,game_server_id,rank_info)
   --gnet.send(c,2225,game_server_id,rank_info);
end
nfight_2_fmanager.fm_sync_world_boss_hp = function(c,game_server_id,weekday,boss_level,hp)
   --gnet.send(c,2226,game_server_id,weekday,boss_level,hp);
end
nfight_2_fmanager.fm_clear_fighting_state = function(c,game_server_id,magic_number,player_gid)
   --gnet.send(c,2227,game_server_id,magic_number,player_gid);
end
nfight_2_fmanager.fm_chat_1v1_over = function(c,game_server_id,magic_number,vecFightResult)
   --gnet.send(c,2228,game_server_id,magic_number,vecFightResult);
end
ngame_2_fmanager={};
ngame_2_fmanager.gf_regist = function(c,game_server_id)
   --gnet.send(c,2402,game_server_id);
end
ngame_2_fmanager.gf_upload_all_proxy_server = function(c,proxy_server_id)
   --gnet.send(c,2403,proxy_server_id);
end
ngame_2_fmanager.gf_add_proxy_server = function(c,proxy_server_id)
   --gnet.send(c,2404,proxy_server_id);
end
ngame_2_fmanager.gf_del_proxy_server = function(c,proxy_server_id)
   --gnet.send(c,2405,proxy_server_id);
end
ngame_2_fmanager.gf_request_new_fight = function(c,request_info)
   --gnet.send(c,2406,request_info);
end
ngame_2_fmanager.gf_push_fight_info = function(c,detail_info,players)
   --gnet.send(c,2407,detail_info,players);
end
ngame_2_fmanager.gf_player_leave_fight_scene = function(c,fight_server_id,fight_unique_id,player_id)
   --gnet.send(c,2408,fight_server_id,fight_unique_id,player_id);
end
ngame_2_fmanager.gf_player_relive_immediately = function(c,fight_server_id,fight_unique_id,player_id,relive_times)
   --gnet.send(c,2409,fight_server_id,fight_unique_id,player_id,relive_times);
end
ngame_2_fmanager.gf_player_disconnect = function(c,fight_server_id,fight_unique_id,player_id)
   --gnet.send(c,2410,fight_server_id,fight_unique_id,player_id);
end
ngame_2_fmanager.gf_player_return_fight = function(c,fight_server_id,fight_unique_id,player_id,proxy_server_id,game_server_id)
   --gnet.send(c,2411,fight_server_id,fight_unique_id,player_id,proxy_server_id,game_server_id);
end
ngame_2_fmanager.gf_close_fight_scene = function(c,fight_server_id,fight_unique_id)
   --gnet.send(c,2412,fight_server_id,fight_unique_id);
end
ngame_2_fmanager.gf_update_world_boss_player_inspire = function(c,fight_server_id,fight_unique_id,player_id,inspire_times)
   --gnet.send(c,2413,fight_server_id,fight_unique_id,player_id,inspire_times);
end
ngame_2_fmanager.gf_gm_set_world_boss_hp = function(c,fight_server_id,fight_unique_id,hp)
   --gnet.send(c,2414,fight_server_id,fight_unique_id,hp);
end
ngame_2_fmanager.gf_create_next_world_boss = function(c,fight_server_id,fight_unique_id,weekday,boss_level,hp,last_luck_attack_times)
   --gnet.send(c,2415,fight_server_id,fight_unique_id,weekday,boss_level,hp,last_luck_attack_times);
end
ngame_2_fmanager.gf_world_boss_new_start = function(c,fight_server_id,fight_unique_id)
   --gnet.send(c,2416,fight_server_id,fight_unique_id);
end
ngame_2_fmanager.gf_upload_world_boss_rank_info = function(c,fight_server_id,fight_unique_id,rank_info)
   --gnet.send(c,2417,fight_server_id,fight_unique_id,rank_info);
end
ngame_2_fmanager.gf_create_next_guild_boss = function(c,fight_server_id,fight_unique_id,boss_index,boss_id,boss_level)
   --gnet.send(c,2418,fight_server_id,fight_unique_id,boss_index,boss_id,boss_level);
end
ngame_2_fmanager.gf_guild_boss_new_week_start = function(c,fight_server_id,fight_unique_id)
   --gnet.send(c,2419,fight_server_id,fight_unique_id);
end
ngame_2_fmanager.gf_update_guild_boss_buff_property = function(c,fight_server_id,fight_unique_id,info)
   --gnet.send(c,2420,fight_server_id,fight_unique_id,info);
end
ngame_2_fmanager.gf_gm_set_guild_boss_hp = function(c,fight_server_id,fight_unique_id,hp)
   --gnet.send(c,2421,fight_server_id,fight_unique_id,hp);
end
ngame_2_fmanager.gf_upload_guild_boss_rank_info = function(c,fight_server_id,fight_unique_id,rank_info)
   --gnet.send(c,2422,fight_server_id,fight_unique_id,rank_info);
end
ngame_2_fmanager.gf_guild_boss_clear_players = function(c,fight_server_id,fight_unique_id)
   --gnet.send(c,2423,fight_server_id,fight_unique_id);
end
nworld_msg={};
nworld_msg.cg_test_enter_world = function(c,world_id)
   --gnet.send(c,2602,world_id);
end
nworld_msg.cg_test_leave_world = function(c,world_id)
   --gnet.send(c,2603,world_id);
end
nworld_msg.cg_load_state = function(c,map_gid,percent,reconnect)
   --gnet.send(c,2604,map_gid,percent,reconnect);
end
nworld_msg.cg_enter_open_world = function(c,world_id)
   --gnet.send(c,2605,world_id);
end
nworld_msg.cg_trigger_translation_point = function(c,user_gid,translantion_id,target_index,src_x,src_y,world_gid)
   --gnet.send(c,2607,user_gid,translantion_id,target_index,src_x,src_y,world_gid);
end
nworld_msg.cg_enter_other_fight_scene = function(c,is_mmo_scene)
   --gnet.send(c,2608,is_mmo_scene);
end
nworld_msg.cg_trigger_npc_translation = function(c,user_gid,translantion_id,target_index,src_x,src_y,npc_id)
   --gnet.send(c,2609,user_gid,translantion_id,target_index,src_x,src_y,npc_id);
end
nworld_msg.cg_leave_open_world = function(c)
   --gnet.send(c,2610);
end
nworld_msg.cg_click_npc = function(c,user_gid,npc_id)
   --gnet.send(c,2624,user_gid,npc_id);
end
nworld_msg.cg_accept_task = function(c,task_id)
   --gnet.send(c,2625,task_id);
end
nworld_msg.cg_complete_task = function(c,task_id)
   --gnet.send(c,2626,task_id);
end
nworld_msg.cg_giveup_task = function(c,task_id)
   --gnet.send(c,2627,task_id);
end
nworld_msg.cg_update_task_condition = function(c,type,param1,param2,param3)
   --gnet.send(c,2628,type,param1,param2,param3);
end
nworld_msg.cg_check_content_id = function(c,content_id,world_id)
   --gnet.send(c,2629,content_id,world_id);
end
nworld_msg.cg_request_transfer = function(c,world_id)
   --gnet.send(c,2630,world_id);
end
nworld_msg.cg_change_skill = function(c,user_gid,skill_id,index)
   --gnet.send(c,2631,user_gid,skill_id,index);
end
nworld_msg.cg_transfrom_to_boss = function(c,boss_id)
   --gnet.send(c,2632,boss_id);
end
nmsg_dailytask={};
nmsg_dailytask.cg_request_my_dailytask_info = function(c)
   --gnet.send(c,3002);
end
nmsg_dailytask.cg_request_dailytask_list = function(c)
   --gnet.send(c,3003);
end
nmsg_dailytask.cg_finish_task = function(c,taskIndexs)
   --gnet.send(c,3004,taskIndexs);
end
nmsg_dailytask.cg_line_finish_task = function(c,taskIndexs)
   --gnet.send(c,3005,taskIndexs);
end
nmsg_dailytask.cg_get_star_reward = function(c,starIndex)
   --gnet.send(c,3006,starIndex);
end
nmsg_dailytask.cg_on_line_task_state = function(c)
   --gnet.send(c,3007);
end
nmsg_dailytask.cg_line_finish_task_all = function(c,taskIndexs)
   --gnet.send(c,3008,taskIndexs);
end
nmsg_dailytask.cg_repair_task = function(c,taskIndex)
   --gnet.send(c,3009,taskIndex);
end
nsystem={};
nsystem.cg_gm_cmd = function(c,cmd)
   --gnet.send(c,3202,cmd);
end
nsystem.cg_cheater_check = function(c,client_time)
   --gnet.send(c,3203,client_time);
end
nsystem.cg_enter_game = function(c,inf)
   --gnet.send(c,3204,inf);
end
nsystem.cg_add_guide_log = function(c,nGuideId,nStep)
   --gnet.send(c,3205,nGuideId,nStep);
end
nsystem.cg_add_custom_log = function(c,strKey,strValue)
   --gnet.send(c,3206,strKey,strValue);
end
nplayer={};
nplayer.cg_rand_name = function(c)
   --gnet.send(c,3402);
end
nplayer.cg_create_player_info = function(c,info)
   --gnet.send(c,3403,info);
end
nplayer.cg_reload = function(c,playerid,verification_code)
   --gnet.send(c,3404,playerid,verification_code);
end
nplayer.cg_guide_id = function(c,id)
   --gnet.send(c,3405,id);
end
nplayer.cg_first_enter_game_complete = function(c)
   --gnet.send(c,3406);
end
nplayer.cg_ap_buy = function(c)
   --gnet.send(c,3407);
end
nplayer.cg_get_first_recharge_reward = function(c)
   --gnet.send(c,3408);
end
nplayer.cg_request_unlock_title = function(c)
   --gnet.send(c,3409);
end
nplayer.cg_use_title = function(c,titleIndex)
   --gnet.send(c,3410,titleIndex);
end
nplayer.cg_buy_item = function(c,id,count)
   --gnet.send(c,3411,id,count);
end
nplayer.cg_invite_friend = function(c,info)
   --gnet.send(c,3412,info);
end
nplayer.cg_invite_state = function(c,state,info)
   --gnet.send(c,3413,state,info);
end
nplayer.cg_get_month_cards_state = function(c)
   --gnet.send(c,3414);
end
nplayer.cg_look_other_player = function(c,playerid,teamType)
   --gnet.send(c,3415,playerid,teamType);
end
nplayer.cg_change_player_image = function(c,heroNumber)
   --gnet.send(c,3416,heroNumber);
end
nplayer.cg_change_name = function(c,name)
   --gnet.send(c,3442,name);
end
nplayer.cg_training_group_advance = function(c,gid)
   --gnet.send(c,3444,gid);
end
nplayer.cg_get_bind_awards = function(c)
   --gnet.send(c,3447);
end
nplayer.cg_select_country = function(c,area)
   --gnet.send(c,3448,area);
end
nplayer.cg_set_peekshow = function(c)
   --gnet.send(c,3451);
end
nplayer.cg_reply_return_fight = function(c,return_fight)
   --gnet.send(c,3452,return_fight);
end
nplayer.cg_request_red_point_state = function(c,redIndex)
   --gnet.send(c,3460,redIndex);
end
nplayer.cg_exchange_red_crystal = function(c,count)
   --gnet.send(c,3463,count);
end
nplayer.cg_vip_add_yijian_good = function(c,item_id1,item_id1_num,item_id2,item_id2_num,mod_exp,vip,vipstar,up_vip_level)
   --gnet.send(c,3467,item_id1,item_id1_num,item_id2,item_id2_num,mod_exp,vip,vipstar,up_vip_level);
end
nplayer.cg_get_vip_every_reward = function(c,vip,vipstar)
   --gnet.send(c,3468,vip,vipstar);
end
nplayer.cg_guard_heart_place_hero_in_pos = function(c,dataid,pos)
   --gnet.send(c,3471,dataid,pos);
end
nplayer.cg_guard_heart_pos_promotion = function(c,pos)
   --gnet.send(c,3472,pos);
end
nplayer.cg_guard_heart_buy_pos = function(c,pos)
   --gnet.send(c,3473,pos);
end
nplayer.cg_resource_record = function(c,list)
   --gnet.send(c,3480,list);
end
nmsg_cards={};
nmsg_cards.cg_change_equip_on_role = function(c,role_card_dataid,equip_card_dataid,equip_pos)
   --gnet.send(c,3602,role_card_dataid,equip_card_dataid,equip_pos);
end
nmsg_cards.cg_sell_cards = function(c,role_dataidlist,equip_dataidlist,item_dataidlist)
   --gnet.send(c,3603,role_dataidlist,equip_dataidlist,item_dataidlist);
end
nmsg_cards.cg_takeoff_equip_on_role = function(c,role_card_dataid,equip_pos)
   --gnet.send(c,3604,role_card_dataid,equip_pos);
end
nmsg_cards.cg_change_souls = function(c,heroNumber,count)
   --gnet.send(c,3605,heroNumber,count);
end
nmsg_cards.cg_equip_star_up = function(c,equip_uuid)
   --gnet.send(c,3606,equip_uuid);
end
nmsg_cards.cg_equip_level_up = function(c,equip_uuid,byfast,useItem,byAll)
   --gnet.send(c,3607,equip_uuid,byfast,useItem,byAll);
end
nmsg_cards.cg_breakthrough = function(c,role_dataid,itemList,breakthrough_stage)
   --gnet.send(c,3608,role_dataid,itemList,breakthrough_stage);
end
nmsg_cards.cg_eat_exp = function(c,role_dataid,item_dataid,count)
   --gnet.send(c,3609,role_dataid,item_dataid,count);
end
nmsg_cards.cg_eat_exps = function(c,role_dataid,cur_level,item_cards)
   --gnet.send(c,3610,role_dataid,cur_level,item_cards);
end
nmsg_cards.cg_equip_composite = function(c,equips)
   --gnet.send(c,3611,equips);
end
nmsg_cards.cg_skill_level_up = function(c,role_dataid,skill_id)
   --gnet.send(c,3612,role_dataid,skill_id);
end
nmsg_cards.cg_one_key_skill_level = function(c,role_dataid,skills)
   --gnet.send(c,3613,role_dataid,skills);
end
nmsg_cards.cg_hero_star_up = function(c,role_dataid,count)
   --gnet.send(c,3614,role_dataid,count);
end
nmsg_cards.cg_hero_rarity_up = function(c,role_dataid,materials)
   --gnet.send(c,3615,role_dataid,materials);
end
nmsg_cards.cg_neidan_upgrade = function(c,role_dataid,ntype)
   --gnet.send(c,3616,role_dataid,ntype);
end
nmsg_cards.cg_restrain_unlock = function(c,role_dataid,id)
   --gnet.send(c,3617,role_dataid,id);
end
nmsg_cards.cg_restrain_upgrade = function(c,role_dataid,id)
   --gnet.send(c,3618,role_dataid,id);
end
nmsg_cards.cg_restrain_reset = function(c,role_dataid,id)
   --gnet.send(c,3619,role_dataid,id);
end
nmsg_cards.cg_equip_rarity_up = function(c,equip_uuid,byAll)
   --gnet.send(c,3620,equip_uuid,byAll);
end
nmsg_cards.cg_star_down = function(c,equip_uuid)
   --gnet.send(c,3621,equip_uuid);
end
nmsg_cards.cg_item_sell = function(c,item_dataid,count)
   --gnet.send(c,3622,item_dataid,count);
end
nmsg_cards.cg_item_exchange = function(c,origin_item_id,count)
   --gnet.send(c,3623,origin_item_id,count);
end
nmsg_cards.cg_soul_exchange_hero = function(c,heronumber)
   --gnet.send(c,3624,heronumber);
end
nmsg_cards.cg_illumstration_active = function(c,role_dataid)
   --gnet.send(c,3625,role_dataid);
end
nmsg_cards.cg_illumstration_update = function(c,role_dataid)
   --gnet.send(c,3626,role_dataid);
end
nmsg_cards.cg_use_training_hall_item = function(c,role_dataid,item_dataid,count)
   --gnet.send(c,3627,role_dataid,item_dataid,count);
end
nmsg_cards.cg_training_hall_hero_advance = function(c,role_dataid)
   --gnet.send(c,3628,role_dataid);
end
nmsg_cards.cg_passive_property_level_up = function(c,role_dataid,id)
   --gnet.send(c,3629,role_dataid,id);
end
nmsg_cards.cg_set_card_play_method_cur_hp = function(c,role_dataid,type,hp)
   --gnet.send(c,3630,role_dataid,type,hp);
end
nmsg_cards.cg_halo_property_level_up = function(c,role_dataid)
   --gnet.send(c,3631,role_dataid);
end
nmsg_cards.cg_special_equip_level_up_fast = function(c,equip_uuid,targetLevel,useExpItem)
   --gnet.send(c,3632,equip_uuid,targetLevel,useExpItem);
end
nmsg_hurdle={};
nmsg_hurdle.cg_take_award = function(c,id,index)
   --gnet.send(c,3802,id,index);
end
nmsg_hurdle.cg_hurdle_fight = function(c,hurdle_id,is_auto_fight)
   --gnet.send(c,3803,hurdle_id,is_auto_fight);
end
nmsg_hurdle.cg_hurdle_fight_result = function(c,hurdle_id,use_time,is_auto_fight,star,flags,openedBoxDropIDs)
   --gnet.send(c,3804,hurdle_id,use_time,is_auto_fight,star,flags,openedBoxDropIDs);
end
nmsg_hurdle.cg_hurdle_saodang = function(c,hurdle_id,times,needItems)
   --gnet.send(c,3805,hurdle_id,times,needItems);
end
nmsg_hurdle.cg_hurlde_box = function(c,hurdle_id)
   --gnet.send(c,3806,hurdle_id);
end
nmsg_hurdle.cg_reset_hurdle = function(c,hurdle_id)
   --gnet.send(c,3807,hurdle_id);
end
nmsg_hurdle.cg_update_fight_key_frame_info = function(c,info)
   --gnet.send(c,3808,info);
end
nmsg_hurdle.cg_open_new_group_animation = function(c,hurdleType)
   --gnet.send(c,3809,hurdleType);
end
nmsg_hurdle.cg_attribute_verify_start = function(c,play_method_type,hurdle_id)
   --gnet.send(c,3810,play_method_type,hurdle_id);
end
nmsg_hurdle.cg_attribute_verify_create_hero = function(c,play_method_type,dataid,gid)
   --gnet.send(c,3811,play_method_type,dataid,gid);
end
nmsg_hurdle.cg_attribute_verify_upload = function(c,play_method_type,upload_info)
   --gnet.send(c,3812,play_method_type,upload_info);
end
nmsg_hurdle.cg_attribute_verify_change_info = function(c,play_method_type,change_info)
   --gnet.send(c,3813,play_method_type,change_info);
end
nmsg_hurdle.cg_attribute_verify_over = function(c)
   --gnet.send(c,3814);
end
nmsg_team={};
nmsg_team.cg_team_list = function(c)
   --gnet.send(c,4002);
end
nmsg_team.cg_update_team_info = function(c,info)
   --gnet.send(c,4003,info);
end
nmsg_team.cg_update_team_backup_cards = function(c,teamid,cards_id)
   --gnet.send(c,4004,teamid,cards_id);
end
nmsg_checkin={};
nmsg_checkin.cg_get_checkin_info = function(c)
   --gnet.send(c,4202);
end
nmsg_checkin.cg_checkin = function(c,check_type)
   --gnet.send(c,4203,check_type);
end
nmsg_checkin.cg_get_month_sign_state = function(c)
   --gnet.send(c,4204);
end
nmsg_checkin.cg_sign_in_c_day = function(c,day,vipState)
   --gnet.send(c,4205,day,vipState);
end
nmsg_checkin.cg_get_total = function(c,totalNum)
   --gnet.send(c,4206,totalNum);
end
nmsg_friend={};
nmsg_friend.cg_request_friend_list = function(c)
   --gnet.send(c,4402);
end
nmsg_friend.cg_search_add_friend_list = function(c,search_info)
   --gnet.send(c,4403,search_info);
end
nmsg_friend.cg_request_friend_apply_list = function(c)
   --gnet.send(c,4404);
end
nmsg_friend.cg_del_friend = function(c,vecDel)
   --gnet.send(c,4405,vecDel);
end
nmsg_friend.cg_apply_friend = function(c,vecApply)
   --gnet.send(c,4406,vecApply);
end
nmsg_friend.cg_handle_friend_apply = function(c,vecHandle,agree)
   --gnet.send(c,4407,vecHandle,agree);
end
nmsg_friend.cg_add_black_list = function(c,player_gid)
   --gnet.send(c,4408,player_gid);
end
nmsg_friend.cg_del_black_list = function(c,vecPlayerGID)
   --gnet.send(c,4409,vecPlayerGID);
end
nmsg_friend.cg_request_blacklist_list = function(c)
   --gnet.send(c,4410);
end
nmsg_friend.cg_give_friend_ap = function(c,player_gid)
   --gnet.send(c,4411,player_gid);
end
nmsg_friend.cg_get_friend_ap = function(c,player_gid)
   --gnet.send(c,4412,player_gid);
end
nmsg_friend.cg_give_all_friend_ap = function(c)
   --gnet.send(c,4413);
end
nmsg_friend.cg_get_all_friend_ap = function(c)
   --gnet.send(c,4414);
end
nmsg_friend.cg_request_update_friend_fight_value = function(c)
   --gnet.send(c,4415);
end
ncommon_struct={};
nmsg_mail={};
nmsg_mail.cg_get_maildata = function(c)
   --gnet.send(c,4802);
end
nmsg_mail.cg_mail_detail = function(c,mail_dataid)
   --gnet.send(c,4803,mail_dataid);
end
nmsg_mail.cg_take_accessory = function(c,mail_dataid)
   --gnet.send(c,4804,mail_dataid);
end
nmsg_mail.cg_delete_mail = function(c,mail_dataid)
   --gnet.send(c,4805,mail_dataid);
end
nmsg_mail.cg_take_all_accessory = function(c)
   --gnet.send(c,4806);
end
nmsg_rank={};
nmsg_rank.cg_rank = function(c,rank_type,count)
   --gnet.send(c,5002,rank_type,count);
end
nmsg_rank.cg_my_rank = function(c,rank_type)
   --gnet.send(c,5003,rank_type);
end
nmsg_fight_verify={};
nmsg_fight_verify.gv_begin_new_fight = function(c,info)
   --gnet.send(c,5202,info);
end
nmsg_fight_verify.gv_update_fight_key_frame_info = function(c,player_gid,info)
   --gnet.send(c,5203,player_gid,info);
end
nmsg_fight_verify.gv_regist = function(c,server_id)
   --gnet.send(c,5204,server_id);
end
nmsg_world_boss={};
nmsg_world_boss.cg_enter_world_boss = function(c)
   --gnet.send(c,5402);
end
nmsg_world_boss.cg_leave_world_boss = function(c)
   --gnet.send(c,5403);
end
nmsg_world_boss.cg_world_boss_buy_inspire = function(c,type)
   --gnet.send(c,5404,type);
end
nmsg_world_boss.cg_world_boss_request_fight_report = function(c)
   --gnet.send(c,5405);
end
nmsg_world_boss.cg_request_world_boss_detail_info = function(c)
   --gnet.send(c,5406);
end
nmsg_world_boss.cg_request_world_boss_rank_info = function(c)
   --gnet.send(c,5407);
end
nmsg_world_boss.cg_request_world_boss_rt_rank_info = function(c)
   --gnet.send(c,5408);
end
nmsg_world_boss.cg_get_world_boss_server_reward = function(c,index,is_get_all)
   --gnet.send(c,5409,index,is_get_all);
end
nmsg_world_boss.cg_buy_world_boss_times = function(c,times)
   --gnet.send(c,5410,times);
end
nmsg_store={};
nmsg_store.cg_request_store_data = function(c)
   --gnet.send(c,5602);
end
nmsg_store.cg_buy_store_goods = function(c,index,id,num,price,discount,appId,serverId,accountId,charId,payType,secondType,bill,ext)
   --gnet.send(c,5603,index,id,num,price,discount,appId,serverId,accountId,charId,payType,secondType,bill,ext);
end
nmsg_store.cg_get_vip_rewards = function(c,level,crystalNum)
   --gnet.send(c,5604,level,crystalNum);
end
nmsg_store.cg_redeem_item = function(c,redeem_code)
   --gnet.send(c,5605,redeem_code);
end
nmsg_store.cg_tencent_balance = function(c,amt,type,openId,openKeyOrToken,pf,pfKey)
   --gnet.send(c,5606,amt,type,openId,openKeyOrToken,pf,pfKey);
end
nmsg_store.cg_tencent_pay = function(c,amt,order_id,type,openId,openkey,pf,pfKey)
   --gnet.send(c,5607,amt,order_id,type,openId,openkey,pf,pfKey);
end
nmsg_store.cg_iap_ios_pay = function(c,state,key,productid,id,receipt)
   --gnet.send(c,5608,state,key,productid,id,receipt);
end
nmsg_three_to_three={};
nmsg_three_to_three.cg_three_to_three_state = function(c)
   --gnet.send(c,5802);
end
nmsg_three_to_three.cg_select_role = function(c,roomId,roleid)
   --gnet.send(c,5803,roomId,roleid);
end
nmsg_three_to_three.cg_sure_select_role = function(c,roomId,roleid)
   --gnet.send(c,5804,roomId,roleid);
end
nmsg_three_to_three.cg_team_room = function(c,nType)
   --gnet.send(c,5805,nType);
end
nmsg_three_to_three.cg_start_match = function(c,nType)
   --gnet.send(c,5806,nType);
end
nmsg_three_to_three.cg_cancel_match = function(c)
   --gnet.send(c,5807);
end
nmsg_three_to_three.cg_del_from_room = function(c,playerid)
   --gnet.send(c,5808,playerid);
end
nmsg_three_to_three.cg_get_top_rank = function(c)
   --gnet.send(c,5809);
end
nmsg_three_to_three.cg_get_integral_award = function(c,id)
   --gnet.send(c,5810,id);
end
nmsg_three_to_three.cg_enter_three_to_three = function(c)
   --gnet.send(c,5811);
end
nmsg_talent={};
nmsg_talent.cg_talent_upgrade = function(c,id)
   --gnet.send(c,6002,id);
end
nmsg_talent.cg_reset_talent = function(c)
   --gnet.send(c,6003);
end
nmsg_world_treasure_box={};
nmsg_world_treasure_box.cg_enter_world_treasure_box = function(c)
   --gnet.send(c,6202);
end
nmsg_world_treasure_box.cg_leave_world_treasure_box = function(c)
   --gnet.send(c,6203);
end
nmsg_world_treasure_box.cg_request_point_rank = function(c)
   --gnet.send(c,6204);
end
nmsg_world_treasure_box.cg_request_world_treasure_box_num = function(c)
   --gnet.send(c,6205);
end
nmsg_world_treasure_box.cg_world_treasure_box_hero_relive_immediately = function(c)
   --gnet.send(c,6206);
end
nmsg_expedition_trial={};
nmsg_expedition_trial.cg_request_expedition_trial_info = function(c)
   --gnet.send(c,6402);
end
nmsg_expedition_trial.cg_trigger_expedition_trial_level = function(c,level)
   --gnet.send(c,6403,level);
end
nmsg_expedition_trial.cg_buy_expedition_trial_treasure_box = function(c,level,times)
   --gnet.send(c,6404,level,times);
end
nmsg_expedition_trial.cg_buy_expedition_trial_buff = function(c,level,index,dataid)
   --gnet.send(c,6405,level,index,dataid);
end
nmsg_expedition_trial.cg_challenge_expedition_trial = function(c,level,difficulty,is_auto_fight)
   --gnet.send(c,6406,level,difficulty,is_auto_fight);
end
nmsg_expedition_trial.cg_expedition_trial_challenge_result = function(c,info)
   --gnet.send(c,6407,info);
end
nmsg_expedition_trial.cg_decide_expedition_trial_sweep = function(c,is_sweep)
   --gnet.send(c,6408,is_sweep);
end
nmsg_expedition_trial.cg_batch_buy_expedition_trial_treasure_box = function(c,times)
   --gnet.send(c,6409,times);
end
nmsg_expedition_trial.cg_get_expedition_trial_points_reward = function(c,index)
   --gnet.send(c,6410,index);
end
nmsg_guild_boss={};
nmsg_guild_boss.cg_enter_guild_boss = function(c)
   --gnet.send(c,6602);
end
nmsg_guild_boss.cg_leave_guild_boss = function(c,is_need_report)
   --gnet.send(c,6603,is_need_report);
end
nmsg_guild_boss.cg_buy_guild_boss_buff = function(c,type)
   --gnet.send(c,6604,type);
end
nmsg_guild_boss.cg_get_guild_boss_first_pass_reward = function(c,boss_index)
   --gnet.send(c,6605,boss_index);
end
nmsg_guild_boss.cg_request_guild_boss_detail_info = function(c)
   --gnet.send(c,6606);
end
nmsg_guild_boss.cg_request_guild_boss_damage_rank_info = function(c)
   --gnet.send(c,6607);
end
nserver_log={};
nserver_log.req_auth = function(c,severid,gameid,groupid,key)
   --gnet.send(c,6802,severid,gameid,groupid,key);
end
nserver_log.req_log = function(c,table)
   --gnet.send(c,6803,table);
end
nserver_log.gl_client_data = function(c,playerid,key,value)
   --gnet.send(c,6804,playerid,key,value);
end
nserver_log.gl_add_log = function(c,logType,vecParm)
   --gnet.send(c,6805,logType,vecParm);
end
nmsg_client_log={};
nmsg_client_log.cg_record_auto_set_effect = function(c,info)
   --gnet.send(c,7002,info);
end
nmsg_client_log.cg_get_auto_set_effect = function(c,device_model)
   --gnet.send(c,7003,device_model);
end
nserver_account={};
nserver_account.ga_register = function(c,gameid,serverid,groupid,name,ip,port,key,target_version)
   --gnet.send(c,7102,gameid,serverid,groupid,name,ip,port,key,target_version);
end
nserver_account.ga_check_token = function(c,accountid,token,uuid,selected_serverid)
   --gnet.send(c,7103,accountid,token,uuid,selected_serverid);
end
nserver_account.ga_update_players = function(c,current_count)
   --gnet.send(c,7104,current_count);
end
nserver_account.ga_verify_token = function(c,user_platform_id,account_id,token,server_id,device_id)
   --gnet.send(c,7105,user_platform_id,account_id,token,server_id,device_id);
end
nserver_account.ga_create_player_inf = function(c,account_id,server_id,playerSummary)
   --gnet.send(c,7106,account_id,server_id,playerSummary);
end
nserver_account.ga_create_player_ok = function(c,account_id,server_id,u3d_uuid,player_id,player_name,package_id)
   --gnet.send(c,7107,account_id,server_id,u3d_uuid,player_id,player_name,package_id);
end
nserver_account.ga_create_player_inf_device = function(c,account_id,server_id,u3d_uuid)
   --gnet.send(c,7111,account_id,server_id,u3d_uuid);
end
nserver_account.ga_get_bind_awards = function(c,account_id,playerid)
   --gnet.send(c,7112,account_id,playerid);
end
nmsg_chat={};
nmsg_chat.cg_player_chat = function(c,type,content,playerid,speaker)
   --gnet.send(c,7402,type,content,playerid,speaker);
end
nmsg_chat.cg_cache_chat = function(c)
   --gnet.send(c,7403);
end
nmsg_activity={};
nmsg_activity.cg_get_level_up_reward_data = function(c)
   --gnet.send(c,7602);
end
nmsg_activity.cg_player_get_level_reward = function(c,level)
   --gnet.send(c,7603,level);
end
nmsg_activity.cg_activity_config = function(c,system_id)
   --gnet.send(c,7604,system_id);
end
nmsg_activity.cg_enter_activity = function(c,system_id,param)
   --gnet.send(c,7605,system_id,param);
end
nmsg_activity.cg_leave_activity = function(c,system_id,isWin,param)
   --gnet.send(c,7606,system_id,isWin,param);
end
nmsg_activity.cg_raids = function(c,system_id,param)
   --gnet.send(c,7607,system_id,param);
end
nmsg_activity.cg_request_kuikuliya_top_list = function(c,rankIndex)
   --gnet.send(c,7608,rankIndex);
end
nmsg_activity.cg_request_kuikuliya_myself_data = function(c)
   --gnet.send(c,7609);
end
nmsg_activity.cg_buy_kuikuliya_times = function(c)
   --gnet.send(c,7610);
end
nmsg_activity.cg_reset_kuikuliya = function(c,ntype)
   --gnet.send(c,7611,ntype);
end
nmsg_activity.cg_saodang_kuikuliya = function(c,bfast)
   --gnet.send(c,7612,bfast);
end
nmsg_activity.cg_kuikuliya_get_box_reward = function(c,ntype,nfloor,openTimes)
   --gnet.send(c,7613,ntype,nfloor,openTimes);
end
nmsg_activity.cg_kuikuliya_get_climb_reward = function(c,nfloor)
   --gnet.send(c,7614,nfloor);
end
nmsg_activity.cg_kuikuliya_request_all_floor_data = function(c)
   --gnet.send(c,7615);
end
nmsg_activity.cg_kuikuliya_saodang_immediately = function(c)
   --gnet.send(c,7616);
end
nmsg_activity.cg_kuikuliya_Get_saodang_reward = function(c)
   --gnet.send(c,7617);
end
nmsg_activity.cg_arena_request_myslef_info = function(c)
   --gnet.send(c,7639);
end
nmsg_activity.cg_arena_request_player_list = function(c,type)
   --gnet.send(c,7640,type);
end
nmsg_activity.cg_arena_request_fight_report = function(c)
   --gnet.send(c,7641);
end
nmsg_activity.cg_arena_buy_challenge_times = function(c,byEnterFight,times)
   --gnet.send(c,7642,byEnterFight,times);
end
nmsg_activity.cg_arena_refresh_challenge_list = function(c)
   --gnet.send(c,7643);
end
nmsg_activity.cg_arena_request_climb_reward_data = function(c)
   --gnet.send(c,7644);
end
nmsg_activity.cg_arena_get_climb_reward = function(c,index)
   --gnet.send(c,7645,index);
end
nmsg_activity.cg_arena_get_day_point_reward = function(c,index)
   --gnet.send(c,7646,index);
end
nmsg_activity.cg_arena_clean_cd = function(c)
   --gnet.send(c,7647);
end
nmsg_activity.cg_niudan_request_role_info = function(c)
   --gnet.send(c,7662);
end
nmsg_activity.cg_niudan_request_equip_info = function(c)
   --gnet.send(c,7663);
end
nmsg_activity.cg_niudan_use = function(c,type,bTen)
   --gnet.send(c,7664,type,bTen);
end
nmsg_activity.cg_niudan_exchange_equip = function(c,index,count)
   --gnet.send(c,7665,index,count);
end
nmsg_activity.cg_activity_request_state = function(c)
   --gnet.send(c,7672);
end
nmsg_activity.cg_hurdle_request_my_data = function(c)
   --gnet.send(c,7674);
end
nmsg_activity.cg_hurdle_get_reward = function(c,index)
   --gnet.send(c,7675,index);
end
nmsg_activity.cg_login_request_my_data = function(c)
   --gnet.send(c,7678);
end
nmsg_activity.cg_login_get_reward = function(c,index)
   --gnet.send(c,7679,index);
end
nmsg_activity.cg_exchange_gold = function(c)
   --gnet.send(c,7682);
end
nmsg_activity.cg_get_everyday_recharge_data = function(c)
   --gnet.send(c,7684);
end
nmsg_activity.cg_get_everyday_recharge_gift_bag = function(c,day)
   --gnet.send(c,7685,day);
end
nmsg_activity.cg_get_level_fund_state = function(c)
   --gnet.send(c,7693);
end
nmsg_activity.cg_buy_level_fund = function(c,crystalNum)
   --gnet.send(c,7694,crystalNum);
end
nmsg_activity.cg_get_level_fund_award = function(c,id)
   --gnet.send(c,7695,id);
end
nmsg_activity.cg_get_recruit_states = function(c)
   --gnet.send(c,7700);
end
nmsg_activity.cg_recruit_get_award = function(c,rID)
   --gnet.send(c,7701,rID);
end
nmsg_activity.cg_get_target_award_states = function(c,activity_id)
   --gnet.send(c,7704,activity_id);
end
nmsg_activity.cg_get_target_award = function(c,t_id,activity_id)
   --gnet.send(c,7705,t_id,activity_id);
end
nmsg_activity.cg_get_buy_1_state = function(c)
   --gnet.send(c,7712);
end
nmsg_activity.cg_get_award = function(c)
   --gnet.send(c,7713);
end
nmsg_activity.cg_churchpray_request_myslef_info = function(c)
   --gnet.send(c,7717);
end
nmsg_activity.cg_request_church_fight_record = function(c)
   --gnet.send(c,7718);
end
nmsg_activity.cg_churchpray_unlock = function(c,index)
   --gnet.send(c,7719,index);
end
nmsg_activity.cg_look_for_rival = function(c,nstar,myPrayIndex)
   --gnet.send(c,7720,nstar,myPrayIndex);
end
nmsg_activity.cg_get_fightRecord_vigor = function(c,dataid,byFast)
   --gnet.send(c,7721,dataid,byFast);
end
nmsg_activity.cg_get_churchpray_reward = function(c,prayIndex)
   --gnet.send(c,7722,prayIndex);
end
nmsg_activity.cg_buy_churchpray_vigor = function(c)
   --gnet.send(c,7723);
end
nmsg_activity.cg_get_total_recharge_state = function(c)
   --gnet.send(c,7733);
end
nmsg_activity.cg_get_total_recharge_award = function(c,tId)
   --gnet.send(c,7734,tId);
end
nmsg_activity.cg_get_total_consume_state = function(c)
   --gnet.send(c,7737);
end
nmsg_activity.cg_get_total_consume_award = function(c,tId)
   --gnet.send(c,7738,tId);
end
nmsg_activity.cg_get_rank_power_state = function(c)
   --gnet.send(c,7741);
end
nmsg_activity.cg_get_rank_power_award = function(c,rid)
   --gnet.send(c,7742,rid);
end
nmsg_activity.cg_old_rank = function(c)
   --gnet.send(c,7743);
end
nmsg_activity.cg_get_luck_cat_state = function(c)
   --gnet.send(c,7747);
end
nmsg_activity.cg_get_luck_cat_castal = function(c,use_times)
   --gnet.send(c,7748,use_times);
end
nmsg_activity.cg_get_luck_cat_loop = function(c)
   --gnet.send(c,7749);
end
nmsg_activity.cg_get_all_buy_state = function(c,day)
   --gnet.send(c,7753,day);
end
nmsg_activity.cg_all_buy_item = function(c,day,option)
   --gnet.send(c,7754,day,option);
end
nmsg_activity.cg_get_exchange_config = function(c,activity_id)
   --gnet.send(c,7757,activity_id);
end
nmsg_activity.cg_get_exchange_item_state = function(c,activity_id)
   --gnet.send(c,7758,activity_id);
end
nmsg_activity.cg_exchange_item_exchange = function(c,id,times,activity_id)
   --gnet.send(c,7759,id,times,activity_id);
end
nmsg_activity.cg_login_back_get_state = function(c)
   --gnet.send(c,7763);
end
nmsg_activity.cg_login_back_get_award = function(c,id)
   --gnet.send(c,7764,id);
end
nmsg_activity.cg_vip_gift_get_state = function(c)
   --gnet.send(c,7767);
end
nmsg_activity.cg_vip_gift_buy = function(c,vipLevel,buy_times)
   --gnet.send(c,7768,vipLevel,buy_times);
end
nmsg_activity.cg_discount_buy_times = function(c)
   --gnet.send(c,7771);
end
nmsg_activity.cg_discount_buy_buy = function(c,id)
   --gnet.send(c,7772,id);
end
nmsg_activity.cg_share_activity_state = function(c)
   --gnet.send(c,7775);
end
nmsg_activity.cg_share_activity_complete = function(c,id)
   --gnet.send(c,7776,id);
end
nmsg_activity.cg_share_activity_get_award = function(c,id)
   --gnet.send(c,7777,id);
end
nmsg_activity.cg_score_hero_get_box_reward = function(c,index)
   --gnet.send(c,7781,index);
end
nmsg_activity.cg_requset_score_hero_data = function(c)
   --gnet.send(c,7782);
end
nmsg_activity.cg_request_score_hero_rankList = function(c)
   --gnet.send(c,7783);
end
nmsg_activity.cg_every_recharge_back_state = function(c)
   --gnet.send(c,7787);
end
nmsg_activity.cg_every_recharge_back_get_award = function(c,day)
   --gnet.send(c,7788,day);
end
nmsg_activity.cg_get_time_limit_gift_bag_config = function(c,localSaveTime)
   --gnet.send(c,7791,localSaveTime);
end
nmsg_activity.cg_get_time_limit_gift_bag_state = function(c)
   --gnet.send(c,7792);
end
nmsg_activity.cg_buy_time_limit_gift_bag_item = function(c,id,buyTimes,currencyType)
   --gnet.send(c,7793,id,buyTimes,currencyType);
end
nmsg_activity.cg_welfare_treasure_box_get_config = function(c,localSaveTime)
   --gnet.send(c,7798,localSaveTime);
end
nmsg_activity.cg_welfare_treasure_box_get_state = function(c)
   --gnet.send(c,7799);
end
nmsg_activity.cg_welfare_treasure_box_buy_item = function(c,id,num)
   --gnet.send(c,7800,id,num);
end
nmsg_activity.cg_welfare_treasure_box_open_box = function(c,id)
   --gnet.send(c,7801,id);
end
nmsg_activity.cg_hero_trial_get_init_info = function(c)
   --gnet.send(c,7806);
end
nmsg_activity.cg_hero_trial_get_week_awards = function(c,index)
   --gnet.send(c,7807,index);
end
nmsg_activity.cg_hero_trial_get_fight_box_awards = function(c)
   --gnet.send(c,7808);
end
nmsg_activity.cg_subscribe_get_state_list = function(c)
   --gnet.send(c,7812);
end
nmsg_activity.cg_subscribe_set_state = function(c)
   --gnet.send(c,7813);
end
nmsg_activity.cg_subscribe_get_award = function(c,id)
   --gnet.send(c,7814,id);
end
nmsg_activity.cg_golden_egg_use = function(c,index)
   --gnet.send(c,7819,index);
end
nmsg_activity.cg_vending_machine_get_state = function(c)
   --gnet.send(c,7822);
end
nmsg_activity.cg_vending_machine_get_buy_record = function(c)
   --gnet.send(c,7823);
end
nmsg_activity.cg_vending_machine_buy = function(c)
   --gnet.send(c,7824);
end
nmsg_client_data={};
nmsg_client_data.cg_client_data = function(c,key,value)
   --gnet.send(c,8202,key,value);
end
nmsg_guild={};
nmsg_guild.cg_create_guild = function(c,szName,nIcon,nLimitLevel,ApproveRule,szDeclaration)
   --gnet.send(c,8402,szName,nIcon,nLimitLevel,ApproveRule,szDeclaration);
end
nmsg_guild.cg_request_guild_list = function(c,nIndex)
   --gnet.send(c,8403,nIndex);
end
nmsg_guild.cg_apply_join = function(c,guildID)
   --gnet.send(c,8404,guildID);
end
nmsg_guild.cg_request_my_guild_data = function(c)
   --gnet.send(c,8405);
end
nmsg_guild.cg_request_actviity_record = function(c,ntype)
   --gnet.send(c,8406,ntype);
end
nmsg_guild.cg_guild_operation = function(c,ntype,playerid,parm)
   --gnet.send(c,8407,ntype,playerid,parm);
end
nmsg_guild.cg_quit_guild = function(c)
   --gnet.send(c,8408);
end
nmsg_guild.cg_change_guild_name = function(c,szName)
   --gnet.send(c,8409,szName);
end
nmsg_guild.cg_update_guild_config = function(c,limitJoinLevel,ApproveRule,szDeclaration,nIcon)
   --gnet.send(c,8410,limitJoinLevel,ApproveRule,szDeclaration,nIcon);
end
nmsg_guild.cg_dealwith_apply_join = function(c,playerid,ntype)
   --gnet.send(c,8411,playerid,ntype);
end
nmsg_guild.cg_look_for_guild = function(c,serchid,szName)
   --gnet.send(c,8412,serchid,szName);
end
nmsg_guild.cg_guild_tech_donate = function(c,id)
   --gnet.send(c,8413,id);
end
nmsg_guild.cg_sync_guild_level_info = function(c)
   --gnet.send(c,8414);
end
nmsg_guild.cg_sync_guild_tech_level_info = function(c,type)
   --gnet.send(c,8415,type);
end
nmsg_guild.cg_send_guild_mail = function(c,szTitle,szText)
   --gnet.send(c,8416,szTitle,szText);
end
nmsg_guild.cg_request_all_log = function(c)
   --gnet.send(c,8417);
end
nmsg_guild.cg_request_all_apply_data = function(c)
   --gnet.send(c,8418);
end
nmsg_shop={};
nmsg_shop.cg_shop_item_info = function(c,shop_id)
   --gnet.send(c,8602,shop_id);
end
nmsg_shop.cg_buy_shop_item = function(c,shop_item_id)
   --gnet.send(c,8603,shop_item_id);
end
nmsg_shop.cg_refresh_shop = function(c,shop_id)
   --gnet.send(c,8604,shop_id);
end
nmsg_shop.cg_sell_item_for_sell = function(c,vecItemIndex)
   --gnet.send(c,8605,vecItemIndex);
end
nmsg_daluandou={};
nmsg_daluandou.cg_request_my_daluandou_data = function(c)
   --gnet.send(c,8802);
end
nmsg_daluandou.cg_request_top_rank = function(c)
   --gnet.send(c,8803);
end
nmsg_daluandou.cg_request_champion_list = function(c)
   --gnet.send(c,8804);
end
nmsg_daluandou.cg_start_match = function(c,cardid)
   --gnet.send(c,8805,cardid);
end
nmsg_daluandou.cg_cancel_match = function(c,roomid)
   --gnet.send(c,8806,roomid);
end
nmsg_web_account={};
nmsg_web_account.wg_get_server_list = function(c)
   --gnet.send(c,9002);
end
nmsg_web_account.wg_add_server = function(c,serverid,channel,name,ip,port,state)
   --gnet.send(c,9003,serverid,channel,name,ip,port,state);
end
nmsg_web_account.wg_del_server = function(c,serverid)
   --gnet.send(c,9004,serverid);
end
nmsg_web_account.wg_update_server_state = function(c,serverData)
   --gnet.send(c,9005,serverData);
end
nmsg_center_server={};
nmsg_center_server.gct_auth = function(c,serverid)
   --gnet.send(c,9202,serverid);
end
nmsg_center_server.gct_redeem_item = function(c,pid,redeem_code,accountid,channelid,osType,packageid,currentLevel)
   --gnet.send(c,9203,pid,redeem_code,accountid,channelid,osType,packageid,currentLevel);
end
nmsg_center_server.gct_create_player_inf = function(c,account_id,server_id,playerSummary)
   --gnet.send(c,9204,account_id,server_id,playerSummary);
end
nmsg_center_server.gct_create_player_ok = function(c,account_id,server_id,u3d_uuid,player_id,player_name,package_id,channel_id)
   --gnet.send(c,9205,account_id,server_id,u3d_uuid,player_id,player_name,package_id,channel_id);
end
nmsg_center_server.gtc_request_account_online_time = function(c,account)
   --gnet.send(c,9206,account);
end
nmsg_center_server.gtc_player_offline = function(c,account,onlineTime)
   --gnet.send(c,9207,account,onlineTime);
end
nmsg_gm_account={};
nmsg_gm_account.gma_update_server_list = function(c,server_inf)
   --gnet.send(c,9402,server_inf);
end
nmsg_gm_account.gma_get_server_runtime_inf = function(c,server_id)
   --gnet.send(c,9403,server_id);
end
nmsg_gm_account.gma_set_notice_url = function(c,url,channel_list)
   --gnet.send(c,9404,url,channel_list);
end
nmsg_gm_account.gma_set_gm_account = function(c,account_id,gm_level)
   --gnet.send(c,9405,account_id,gm_level);
end
nmsg_gm_account.gma_block_account = function(c,account_id,time)
   --gnet.send(c,9406,account_id,time);
end
nmsg_gm_account.gma_get_account_id = function(c,acc,account_id)
   --gnet.send(c,9407,acc,account_id);
end
nmsg_gm_account.gma_open_login_ip_filter = function(c,ip_list)
   --gnet.send(c,9408,ip_list);
end
nmsg_gm_account.gma_close_login_ip_filter = function(c)
   --gnet.send(c,9409);
end
nmsg_gm_account.gma_check_login_ip_filter_is_open = function(c)
   --gnet.send(c,9410);
end
nmsg_gm_center_server={};
nmsg_gm_center_server.wc_genterate_redeem_code = function(c,param)
   --gnet.send(c,9602,param);
end
nmsg_gm_center_server.wc_append_redeem_code = function(c,batchNumber,count)
   --gnet.send(c,9603,batchNumber,count);
end
nmsg_gm_center_server.wc_query_genterate_state = function(c,batchNumber)
   --gnet.send(c,9604,batchNumber);
end
nmsg_gm_center_server.wc_update_redeem_code_batch_property = function(c,param)
   --gnet.send(c,9605,param);
end
nmsg_gm_center_server.wc_discard_batch_redeem_code = function(c,batchNumber,discard)
   --gnet.send(c,9606,batchNumber,discard);
end
nmsg_gm_center_server.wc_discard_redeem_code = function(c,redeem_code,discard)
   --gnet.send(c,9607,redeem_code,discard);
end
nmsg_gm_center_server.wc_update_redeem_code_use_times = function(c,redeem_code,times)
   --gnet.send(c,9608,redeem_code,times);
end
nmsg_pay={};
nmsg_pay.ga_req_order = function(c,pay_inf,client_inf,info)
   --gnet.send(c,9802,pay_inf,client_inf,info);
end
nmsg_pay.ga_get_order_success = function(c,order_id)
   --gnet.send(c,9803,order_id);
end
nmsg_pay.ga_tencent_balance = function(c,_sdk_info)
   --gnet.send(c,9804,_sdk_info);
end
nmsg_pay.ga_tencent_pay = function(c,_sdk_info,amt,order_id)
   --gnet.send(c,9805,_sdk_info,amt,order_id);
end
nmsg_pay.ga_tencent_cancel_pay = function(c,_sdk_info,amt,billno)
   --gnet.send(c,9806,_sdk_info,amt,billno);
end
nmsg_pay.ga_iap_ios_pay = function(c,state,key,productid,id,receipt,player_id,serverid)
   --gnet.send(c,9807,state,key,productid,id,receipt,player_id,serverid);
end
nmsg_pay.ga_buy_goods = function(c,bSuccess,pay_inf)
   --gnet.send(c,9808,bSuccess,pay_inf);
end
nmsg_pay_agent={};
nmsg_pay_agent.pa_alipay_rst = function(c,session_id,info)
   --gnet.send(c,10002,session_id,info);
end
nmsg_pay_agent.pa_qihupay_rst = function(c,session_id,info)
   --gnet.send(c,10003,session_id,info);
end
nmsg_pay_agent.pa_3rdpay_callback = function(c,session_id,cb)
   --gnet.send(c,10004,session_id,cb);
end
nmsg_pay_agent.pa_tencent_balance_callback = function(c,balance,player_id,serverid)
   --gnet.send(c,10005,balance,player_id,serverid);
end
nmsg_pay_agent.pa_tencent_pay_callback = function(c,result,billno,balance,order_id,player_id,serverid)
   --gnet.send(c,10006,result,billno,balance,order_id,player_id,serverid);
end
nmsg_pay_agent.pa_tencent_cancel_pay_callback = function(c,result,player_id,serverid)
   --gnet.send(c,10007,result,player_id,serverid);
end
nmsg_pay_agent.pa_reg_agent = function(c,agent_type,agent_id)
   --gnet.send(c,10008,agent_type,agent_id);
end
nmsg_pay_agent.pa_iap_ios_paycheck_callback = function(c,status,key,productid,id,info,player_id,serverid)
   --gnet.send(c,10009,status,key,productid,id,info,player_id,serverid);
end
ngm_game_operate={};
ngm_game_operate.regist_game_server = function(c,server_id)
   --gnet.send(c,10246,server_id);
end
ngm_game_operate.ggm_kick_player = function(c,result,session_pid,player,time)
   --gnet.send(c,10247,result,session_pid,player,time);
end
ngm_game_operate.ggm_forbid_speak = function(c,result,session_pid,player,time)
   --gnet.send(c,10248,result,session_pid,player,time);
end
ngm_game_operate.ggm_freeze_player = function(c,result,session_pid,player,time)
   --gnet.send(c,10249,result,session_pid,player,time);
end
ngm_game_operate.ggm_play_method_reset = function(c,result,session_pid,player,time)
   --gnet.send(c,10250,result,session_pid,player,time);
end
ngm_game_operate.ggm_send_email = function(c,result,session_pid,sender,info,server_id)
   --gnet.send(c,10251,result,session_pid,sender,info,server_id);
end
ngm_game_operate.ggm_send_marquee = function(c,result,op_id,session_pid,noticeID,content,cycleTime,interval,time,server_id)
   --gnet.send(c,10252,result,op_id,session_pid,noticeID,content,cycleTime,interval,time,server_id);
end
ngm_game_operate.ggm_send_system_chat = function(c,result,op_id,session_pid,content,time,server_id,id)
   --gnet.send(c,10253,result,op_id,session_pid,content,time,server_id,id);
end
ngm_game_operate.ggm_query_player = function(c,result,op_id,session_pid,info,time,freeze_player_time,forbid_speak_time)
   --gnet.send(c,10254,result,op_id,session_pid,info,time,freeze_player_time,forbid_speak_time);
end
ngm_game_operate.ggm_role_package = function(c,result,op_id,session_pid,player_id,name,info,finish,time)
   --gnet.send(c,10255,result,op_id,session_pid,player_id,name,info,finish,time);
end
ngm_game_operate.ggm_equip_package = function(c,result,op_id,session_pid,player_id,name,info,finish,time)
   --gnet.send(c,10256,result,op_id,session_pid,player_id,name,info,finish,time);
end
ngm_game_operate.ggm_item_package = function(c,result,op_id,session_pid,player_id,name,info,finish,time)
   --gnet.send(c,10257,result,op_id,session_pid,player_id,name,info,finish,time);
end
ngm_game_operate.ggm_talent_info = function(c,result,op_id,session_pid,player_id,name,talent_info,time)
   --gnet.send(c,10258,result,op_id,session_pid,player_id,name,talent_info,time);
end
ngm_game_operate.ggm_laboratory_info = function(c,result,op_id,session_pid,player_id,name,laboratory_info,time)
   --gnet.send(c,10259,result,op_id,session_pid,player_id,name,laboratory_info,time);
end
ngm_game_operate.ggm_player_login = function(c,account_id,player_id)
   --gnet.send(c,10260,account_id,player_id);
end
ngm_game_operate.ggm_delete_marquee = function(c,op_id,session_pid,result,noticeID)
   --gnet.send(c,10261,op_id,session_pid,result,noticeID);
end
ngm_game_operate.ggm_player_by_accountid = function(c,op_id,session_pid,result,account_id,info)
   --gnet.send(c,10262,op_id,session_pid,result,account_id,info);
end
ngm_game_operate.ggm_get_accountid = function(c,op_id,session_pid,result,player_id,name,account_id)
   --gnet.send(c,10263,op_id,session_pid,result,player_id,name,account_id);
end
ngm_game_operate.ggm_get_role_property = function(c,op_id,session_pid,result,role_dataid,rp)
   --gnet.send(c,10264,op_id,session_pid,result,role_dataid,rp);
end
ngm_game_operate.ggm_get_discrete = function(c,op_id,session_pid,result,player_id,info)
   --gnet.send(c,10265,op_id,session_pid,result,player_id,info);
end
ngm_game_operate.ggm_get_slg_info = function(c,op_id,session_pid,result,player_id,info)
   --gnet.send(c,10266,op_id,session_pid,result,player_id,info);
end
ngm_game_operate.ggm_get_team_info = function(c,op_id,session_pid,result,player_id,info)
   --gnet.send(c,10267,op_id,session_pid,result,player_id,info);
end
ngm_game_operate.ggm_query_player_detail_info = function(c,result,op_id,session_pid,info)
   --gnet.send(c,10268,result,op_id,session_pid,info);
end
ngm_game_operate.ggm_query_player_activity_info = function(c,result,op_id,session_pid,info)
   --gnet.send(c,10269,result,op_id,session_pid,info);
end
ngm_game_operate.ggm_query_player_dailytask_info = function(c,result,op_id,session_pid,info)
   --gnet.send(c,10270,result,op_id,session_pid,info);
end
ngm_game_operate.ggm_set_activity_config = function(c,result,op_id,session_pid,server_id,activity_id)
   --gnet.send(c,10271,result,op_id,session_pid,server_id,activity_id);
end
ngm_game_operate.ggm_change_activity_config_time = function(c,result,op_id,session_pid,begin_time,end_time,server_id,activity_id)
   --gnet.send(c,10272,result,op_id,session_pid,begin_time,end_time,server_id,activity_id);
end
ngm_game_operate.ggm_pause_activity = function(c,result,op_id,session_pid,is_pause,server_id,activity_id)
   --gnet.send(c,10273,result,op_id,session_pid,is_pause,server_id,activity_id);
end
ngm_game_operate.ggm_set_faction_fight_award_id = function(c,result,op_id,session_pid,server_id)
   --gnet.send(c,10274,result,op_id,session_pid,server_id);
end
ngm_game_operate.ggm_record_effect_set = function(c,u3d_uuid,device_model,average_fps,effect_level,system_id)
   --gnet.send(c,10275,u3d_uuid,device_model,average_fps,effect_level,system_id);
end
ngm_game_operate.ggm_unbind = function(c,result,session_pid,player,time)
   --gnet.send(c,10276,result,session_pid,player,time);
end
ngm_game_operate.ggm_ordered_account_login = function(c,account_id,player_id,server_id)
   --gnet.send(c,10277,account_id,player_id,server_id);
end
ngm_game_operate.ggm_send_official_order_gift_email = function(c,result,account_id,gift_id,server_id)
   --gnet.send(c,10278,result,account_id,gift_id,server_id);
end
ngm_game_operate.ggm_get_auto_set_effect = function(c,device_model,playerid)
   --gnet.send(c,10279,device_model,playerid);
end
ngm_game_operate.ggm_kick_all_player = function(c,result,op_id,session_pid)
   --gnet.send(c,10280,result,op_id,session_pid);
end
ngm_game_operate.ggm_set_welfare_treasuebox_config = function(c,result,op_id,session_pid,server_id)
   --gnet.send(c,10281,result,op_id,session_pid,server_id);
end
ngm_game_operate.ggm_change_welfare_treasuebox_time = function(c,result,op_id,session_pid,begin_time,end_time,server_id)
   --gnet.send(c,10282,result,op_id,session_pid,begin_time,end_time,server_id);
end
ngm_game_operate.ggm_pause_welfare_treasuebox = function(c,result,op_id,session_pid,is_pause,server_id)
   --gnet.send(c,10283,result,op_id,session_pid,is_pause,server_id);
end
ngm_game_operate.ggm_set_limit_gift_bag_config = function(c,result,op_id,session_pid,server_id)
   --gnet.send(c,10284,result,op_id,session_pid,server_id);
end
ngm_game_operate.ggm_change_limit_gift_bag_time = function(c,result,op_id,session_pid,begin_time,end_time,server_id)
   --gnet.send(c,10285,result,op_id,session_pid,begin_time,end_time,server_id);
end
ngm_game_operate.ggm_pause_limit_gift_bag = function(c,result,op_id,session_pid,is_pause,server_id)
   --gnet.send(c,10286,result,op_id,session_pid,is_pause,server_id);
end
ngm_game_operate.ggm_pass_guide = function(c,result,session_pid,player,guide_id)
   --gnet.send(c,10287,result,session_pid,player,guide_id);
end
ngm_game_operate.ggm_set_exchange_activity_config = function(c,result,op_id,session_pid,acticity_id,server_id)
   --gnet.send(c,10288,result,op_id,session_pid,acticity_id,server_id);
end
ngm_game_operate.ggm_change_exchange_activity_time = function(c,result,op_id,session_pid,begin_time,end_time,server_id,activity_id)
   --gnet.send(c,10289,result,op_id,session_pid,begin_time,end_time,server_id,activity_id);
end
ngm_game_operate.ggm_pause_exchange_activity = function(c,result,op_id,session_pid,is_pause,server_id,activity_id)
   --gnet.send(c,10290,result,op_id,session_pid,is_pause,server_id,activity_id);
end
ngm_game_operate.ggm_big_store_card_lifelong = function(c,result,session_pid,player,is_lifelong)
   --gnet.send(c,10291,result,session_pid,player,is_lifelong);
end
ngm_game_operate.ggm_set_first_recharge_switch = function(c,result,session_pid,player,can_get)
   --gnet.send(c,10292,result,session_pid,player,can_get);
end
nweb_gm_operate={};
nweb_gm_operate.wgm_kick_player = function(c,base_info,player)
   --gnet.send(c,10402,base_info,player);
end
nweb_gm_operate.wgm_forbid_speak = function(c,base_info,player,second)
   --gnet.send(c,10403,base_info,player,second);
end
nweb_gm_operate.wgm_freeze_player = function(c,base_info,player,second)
   --gnet.send(c,10404,base_info,player,second);
end
nweb_gm_operate.wgm_play_method_reset = function(c,base_info,player,play_method_id_list)
   --gnet.send(c,10405,base_info,player,play_method_id_list);
end
nweb_gm_operate.wgm_send_email = function(c,base_info,mail)
   --gnet.send(c,10406,base_info,mail);
end
nweb_gm_operate.wgm_send_timer_email = function(c,base_info,mail_id)
   --gnet.send(c,10407,base_info,mail_id);
end
nweb_gm_operate.wgm_cancel_timer_email = function(c,base_info,mail_id)
   --gnet.send(c,10408,base_info,mail_id);
end
nweb_gm_operate.wgm_send_marquee = function(c,base_info,noticeID,content,cycleTime,interval,isServerSend,bForce)
   --gnet.send(c,10409,base_info,noticeID,content,cycleTime,interval,isServerSend,bForce);
end
nweb_gm_operate.wgm_send_timer_marquee = function(c,base_info,marquee_id)
   --gnet.send(c,10410,base_info,marquee_id);
end
nweb_gm_operate.wgm_cancel_timer_marquee = function(c,base_info,marquee_id)
   --gnet.send(c,10411,base_info,marquee_id);
end
nweb_gm_operate.wgm_send_system_chat = function(c,base_info,content)
   --gnet.send(c,10412,base_info,content);
end
nweb_gm_operate.wgm_send_timer_system_chat = function(c,base_info,chat_id)
   --gnet.send(c,10413,base_info,chat_id);
end
nweb_gm_operate.wgm_cancel_timer_system_chat = function(c,base_info,chat_id)
   --gnet.send(c,10414,base_info,chat_id);
end
nweb_gm_operate.wgm_query_player = function(c,base_info,player_id,name)
   --gnet.send(c,10415,base_info,player_id,name);
end
nweb_gm_operate.wgm_role_package = function(c,base_info,player_id,name)
   --gnet.send(c,10416,base_info,player_id,name);
end
nweb_gm_operate.wgm_equip_package = function(c,base_info,player_id,name)
   --gnet.send(c,10417,base_info,player_id,name);
end
nweb_gm_operate.wgm_item_package = function(c,base_info,player_id,name)
   --gnet.send(c,10418,base_info,player_id,name);
end
nweb_gm_operate.wgm_talent_info = function(c,base_info,player_id,name)
   --gnet.send(c,10419,base_info,player_id,name);
end
nweb_gm_operate.wgm_laboratory_info = function(c,base_info,player_id,name)
   --gnet.send(c,10420,base_info,player_id,name);
end
nweb_gm_operate.wgm_account_gift = function(c,base_info,gift_info)
   --gnet.send(c,10421,base_info,gift_info);
end
nweb_gm_operate.wgm_account_gift_check = function(c,base_info,check_result,reason,check_user)
   --gnet.send(c,10422,base_info,check_result,reason,check_user);
end
nweb_gm_operate.wgm_change_account_gift_time = function(c,base_info,last_op_id,begin_time,end_time)
   --gnet.send(c,10423,base_info,last_op_id,begin_time,end_time);
end
nweb_gm_operate.wgm_delete_marquee = function(c,base_info,noticeID)
   --gnet.send(c,10424,base_info,noticeID);
end
nweb_gm_operate.wgm_player_by_accountid = function(c,base_info,account_id)
   --gnet.send(c,10425,base_info,account_id);
end
nweb_gm_operate.wgm_get_accountid = function(c,base_info,player_id,name)
   --gnet.send(c,10426,base_info,player_id,name);
end
nweb_gm_operate.wgm_get_role_property = function(c,base_info,role_dataid)
   --gnet.send(c,10427,base_info,role_dataid);
end
nweb_gm_operate.wgm_get_discrete = function(c,base_info,player_id)
   --gnet.send(c,10428,base_info,player_id);
end
nweb_gm_operate.wgm_get_slg_info = function(c,base_info,player_id)
   --gnet.send(c,10429,base_info,player_id);
end
nweb_gm_operate.wgm_get_team_info = function(c,base_info,player_id,name)
   --gnet.send(c,10430,base_info,player_id,name);
end
nweb_gm_operate.wgm_query_player_detail_info = function(c,base_info,player_id,name)
   --gnet.send(c,10431,base_info,player_id,name);
end
nweb_gm_operate.wgm_query_player_activity_info = function(c,base_info,player_id,name)
   --gnet.send(c,10432,base_info,player_id,name);
end
nweb_gm_operate.wgm_query_player_dailytask_info = function(c,base_info,player_id,name)
   --gnet.send(c,10433,base_info,player_id,name);
end
nweb_gm_operate.wgm_ask_game_server_curtime = function(c,base_info)
   --gnet.send(c,10434,base_info);
end
nweb_gm_operate.wgm_set_activity_config = function(c,base_info,activity_config)
   --gnet.send(c,10435,base_info,activity_config);
end
nweb_gm_operate.wgm_set_activity_config_check = function(c,base_info,check_result,reason,check_user,activity_id)
   --gnet.send(c,10436,base_info,check_result,reason,check_user,activity_id);
end
nweb_gm_operate.wgm_change_activity_config_time = function(c,base_info,begin_time,end_time,activity_id)
   --gnet.send(c,10437,base_info,begin_time,end_time,activity_id);
end
nweb_gm_operate.wgm_pause_activity = function(c,base_info,is_pause,activity_id)
   --gnet.send(c,10438,base_info,is_pause,activity_id);
end
nweb_gm_operate.wgm_set_faction_fight_award_id = function(c,base_info,award_id)
   --gnet.send(c,10439,base_info,award_id);
end
nweb_gm_operate.wgm_unbind = function(c,base_info,player)
   --gnet.send(c,10440,base_info,player);
end
nweb_gm_operate.wgm_set_official_order_gift = function(c,base_info,info)
   --gnet.send(c,10441,base_info,info);
end
nweb_gm_operate.wgm_set_official_order_gift_check = function(c,base_info,check_result,reason,check_user,gift_id)
   --gnet.send(c,10442,base_info,check_result,reason,check_user,gift_id);
end
nweb_gm_operate.wgm_change_auto_set_effect = function(c,base_info,info)
   --gnet.send(c,10443,base_info,info);
end
nweb_gm_operate.wgm_kick_all_player = function(c,base_info)
   --gnet.send(c,10444,base_info);
end
nweb_gm_operate.wgm_set_welfare_treasuebox_config = function(c,base_info,box_info)
   --gnet.send(c,10445,base_info,box_info);
end
nweb_gm_operate.wgm_check_welfare_treasuebox = function(c,base_info,check_result,reason,check_user)
   --gnet.send(c,10446,base_info,check_result,reason,check_user);
end
nweb_gm_operate.wgm_change_welfare_treasuebox_time = function(c,base_info,begin_time,end_time)
   --gnet.send(c,10447,base_info,begin_time,end_time);
end
nweb_gm_operate.wgm_pause_welfare_treasuebox = function(c,base_info,is_pause)
   --gnet.send(c,10448,base_info,is_pause);
end
nweb_gm_operate.wgm_set_limit_gift_bag_config = function(c,base_info,gift_info)
   --gnet.send(c,10449,base_info,gift_info);
end
nweb_gm_operate.wgm_check_limit_gift_bag = function(c,base_info,check_result,reason,check_user)
   --gnet.send(c,10450,base_info,check_result,reason,check_user);
end
nweb_gm_operate.wgm_change_limit_gift_bag_time = function(c,base_info,begin_time,end_time)
   --gnet.send(c,10451,base_info,begin_time,end_time);
end
nweb_gm_operate.wgm_pause_limit_gift_bag = function(c,base_info,is_pause)
   --gnet.send(c,10452,base_info,is_pause);
end
nweb_gm_operate.wgm_pass_guide = function(c,base_info,player,guide_id)
   --gnet.send(c,10453,base_info,player,guide_id);
end
nweb_gm_operate.wgm_set_exchange_activity_config = function(c,base_info,info)
   --gnet.send(c,10454,base_info,info);
end
nweb_gm_operate.wgm_check_exchange_activity = function(c,base_info,activity_id,check_result,reason,check_user)
   --gnet.send(c,10455,base_info,activity_id,check_result,reason,check_user);
end
nweb_gm_operate.wgm_change_exchange_activity_time = function(c,base_info,begin_time,end_time,activity_id)
   --gnet.send(c,10456,base_info,begin_time,end_time,activity_id);
end
nweb_gm_operate.wgm_pause_exchange_activity = function(c,base_info,is_pause,activity_id)
   --gnet.send(c,10457,base_info,is_pause,activity_id);
end
nweb_gm_operate.wgm_big_store_card_lifelong = function(c,base_info,player,is_lifelong)
   --gnet.send(c,10458,base_info,player,is_lifelong);
end
nweb_gm_operate.wgm_set_first_recharge_switch = function(c,base_info,player,can_get)
   --gnet.send(c,10459,base_info,player,can_get);
end
nweb_gm_operate.wgm_update_server_list = function(c,base_info,server_inf)
   --gnet.send(c,10518,base_info,server_inf);
end
nweb_gm_operate.wgm_get_server_runtime_inf = function(c,base_info,server_id)
   --gnet.send(c,10519,base_info,server_id);
end
nweb_gm_operate.wgm_set_notice_url = function(c,base_info,url,channel_list)
   --gnet.send(c,10520,base_info,url,channel_list);
end
nweb_gm_operate.wgm_set_gm_account = function(c,base_info,account_id,gm_level)
   --gnet.send(c,10521,base_info,account_id,gm_level);
end
nweb_gm_operate.wgm_block_account = function(c,base_info,account_id,time)
   --gnet.send(c,10522,base_info,account_id,time);
end
nweb_gm_operate.wgm_get_account_id = function(c,base_info,acc,account_id)
   --gnet.send(c,10523,base_info,acc,account_id);
end
nweb_gm_operate.wgm_open_login_ip_filter = function(c,base_info,ip_list)
   --gnet.send(c,10524,base_info,ip_list);
end
nweb_gm_operate.wgm_close_login_ip_filter = function(c,base_info)
   --gnet.send(c,10525,base_info);
end
nweb_gm_operate.wgm_check_login_ip_filter_is_open = function(c,base_info)
   --gnet.send(c,10526,base_info);
end
nweb_gm_operate.wgm_get_account_detail_info = function(c,base_info,acc,account_id)
   --gnet.send(c,10527,base_info,acc,account_id);
end
nweb_gm_operate.wgm_get_account_player_info = function(c,base_info,account_id)
   --gnet.send(c,10528,base_info,account_id);
end
nweb_gm_operate.wgm_genterate_redeem_code = function(c,base_info,param)
   --gnet.send(c,10540,base_info,param);
end
nweb_gm_operate.wgm_genterate_redeem_code_check = function(c,base_info,batchNumber,result,reason,checkuser)
   --gnet.send(c,10541,base_info,batchNumber,result,reason,checkuser);
end
nweb_gm_operate.wgm_append_redeem_code = function(c,base_info,batchNumber,count)
   --gnet.send(c,10542,base_info,batchNumber,count);
end
nweb_gm_operate.wgm_query_genterate_state = function(c,base_info,batchNumber)
   --gnet.send(c,10543,base_info,batchNumber);
end
nweb_gm_operate.wgm_update_redeem_code_batch_property = function(c,base_info,param)
   --gnet.send(c,10544,base_info,param);
end
nweb_gm_operate.wgm_discard_batch_redeem_code = function(c,base_info,batchNumber,discard,reason,checkuser)
   --gnet.send(c,10545,base_info,batchNumber,discard,reason,checkuser);
end
nweb_gm_operate.wgm_download_redeem_code = function(c,base_info,batchNumber)
   --gnet.send(c,10546,base_info,batchNumber);
end
nweb_gm_operate.wgm_recive_send_redeem_code = function(c,base_info,batchNumber,sendIndex)
   --gnet.send(c,10547,base_info,batchNumber,sendIndex);
end
ngm_account_operate={};
ngm_account_operate.regist_account_server = function(c,server_id)
   --gnet.send(c,10613,server_id);
end
ngm_account_operate.agm_update_server_list_ret = function(c,op_id,session_pid,ret_code)
   --gnet.send(c,10614,op_id,session_pid,ret_code);
end
ngm_account_operate.agm_get_server_runtime_inf_ret = function(c,op_id,session_pid,server_id,inf)
   --gnet.send(c,10615,op_id,session_pid,server_id,inf);
end
ngm_account_operate.agm_set_notice_url_ret = function(c,op_id,session_pid,ret_code)
   --gnet.send(c,10616,op_id,session_pid,ret_code);
end
ngm_account_operate.agm_set_gm_account_ret = function(c,op_id,session_pid,ret_code,account_id,gm_level)
   --gnet.send(c,10617,op_id,session_pid,ret_code,account_id,gm_level);
end
ngm_account_operate.agm_block_account = function(c,op_id,session_pid,ret_code,account_id,time)
   --gnet.send(c,10618,op_id,session_pid,ret_code,account_id,time);
end
ngm_account_operate.agm_get_account_id = function(c,op_id,session_pid,result,account_id,device_id,mobile_phone,email,mixed_3rd_account,acc_name)
   --gnet.send(c,10619,op_id,session_pid,result,account_id,device_id,mobile_phone,email,mixed_3rd_account,acc_name);
end
ngm_account_operate.agm_open_login_ip_filter_ret = function(c,op_id,session_pid,ret_code)
   --gnet.send(c,10620,op_id,session_pid,ret_code);
end
ngm_account_operate.agm_close_login_ip_filter_ret = function(c,op_id,session_pid,ret_clode)
   --gnet.send(c,10621,op_id,session_pid,ret_clode);
end
ngm_account_operate.agm_check_login_ip_filter_is_open_ret = function(c,op_id,session_pid,is_open)
   --gnet.send(c,10622,op_id,session_pid,is_open);
end
ngm_account_operate.agm_get_account_detail_info = function(c,op_id,session_pid,ret_code,info)
   --gnet.send(c,10623,op_id,session_pid,ret_code,info);
end
ngm_account_operate.agm_get_account_player_info = function(c,op_id,session_pid,ret_code,info)
   --gnet.send(c,10624,op_id,session_pid,ret_code,info);
end
nmsg_laboratory={};
nmsg_laboratory.cg_request_all_laboratory_data = function(c)
   --gnet.send(c,10802);
end
nmsg_laboratory.cg_unLock_laboratory = function(c,index)
   --gnet.send(c,10803,index);
end
nmsg_laboratory.cg_train = function(c,index,type,bten)
   --gnet.send(c,10804,index,type,bten);
end
nmsg_laboratory.cg_save = function(c,index,bSave)
   --gnet.send(c,10805,index,bSave);
end
nmsg_clone_fight={};
nmsg_clone_fight.cg_get_challenge_hero = function(c)
   --gnet.send(c,11002);
end
nmsg_clone_fight.cg_get_team_info = function(c)
   --gnet.send(c,11003);
end
nmsg_clone_fight.cg_create_team = function(c,heroid)
   --gnet.send(c,11004,heroid);
end
nmsg_clone_fight.cg_change_hero = function(c,roleDataId)
   --gnet.send(c,11005,roleDataId);
end
nmsg_clone_fight.cg_join_team = function(c,roomid,heroid)
   --gnet.send(c,11006,roomid,heroid);
end
nmsg_clone_fight.cg_quick_join = function(c,heroid)
   --gnet.send(c,11007,heroid);
end
nmsg_clone_fight.cg_exit_team = function(c)
   --gnet.send(c,11008);
end
nmsg_clone_fight.cg_allow_quick_join = function(c,refuseQuickJoin)
   --gnet.send(c,11009,refuseQuickJoin);
end
nmsg_clone_fight.cg_begin_fight = function(c)
   --gnet.send(c,11010);
end
nmsg_clone_fight.cg_end_fight = function(c,isWin,use_time)
   --gnet.send(c,11011,isWin,use_time);
end
nmsg_clone_fight.cg_open_box = function(c)
   --gnet.send(c,11012);
end
nmsg_clone_fight.cg_notice_partener_finish_challenge = function(c)
   --gnet.send(c,11013);
end
nmsg_sign_in={};
nmsg_sign_in.cg_request_task_list = function(c,type1,type2)
   --gnet.send(c,11202,type1,type2);
end
nmsg_sign_in.cg_get_award = function(c,task_id)
   --gnet.send(c,11203,task_id);
end
nmsg_sign_in.cg_request_total_state = function(c)
   --gnet.send(c,11204);
end
nmsg_sign_in.cg_get_award_total = function(c,t_index,c_score)
   --gnet.send(c,11205,t_index,c_score);
end
nmsg_sign_in.cg_request_task_list_back = function(c,type1,type2)
   --gnet.send(c,11212,type1,type2);
end
nmsg_sign_in.cg_get_award_back = function(c,task_id)
   --gnet.send(c,11213,task_id);
end
nmsg_sign_in.cg_request_total_state_back = function(c)
   --gnet.send(c,11214);
end
nmsg_sign_in.cg_get_award_total_back = function(c,t_index,c_score)
   --gnet.send(c,11215,t_index,c_score);
end
ngm_center_operate={};
ngm_center_operate.gmc_auth = function(c,serverid)
   --gnet.send(c,11402,serverid);
end
ngm_center_operate.gmc_genterate_redeem_code = function(c,op_id,session_pid,param)
   --gnet.send(c,11403,op_id,session_pid,param);
end
ngm_center_operate.gmc_append_redeem_code = function(c,op_id,session_pid,batchNumber,count)
   --gnet.send(c,11404,op_id,session_pid,batchNumber,count);
end
ngm_center_operate.gmc_query_genterate_state = function(c,op_id,session_pid,batchNumber)
   --gnet.send(c,11405,op_id,session_pid,batchNumber);
end
ngm_center_operate.gmc_update_redeem_code_batch_property = function(c,op_id,session_pid,param)
   --gnet.send(c,11406,op_id,session_pid,param);
end
ngm_center_operate.gmc_discard_batch_redeem_code = function(c,op_id,session_pid,batchNumber,discard)
   --gnet.send(c,11407,op_id,session_pid,batchNumber,discard);
end
ngm_center_operate.gmc_discard_redeem_code = function(c,op_id,session_pid,redeem_code,discard)
   --gnet.send(c,11408,op_id,session_pid,redeem_code,discard);
end
ngm_center_operate.gmc_update_redeem_code_use_times = function(c,op_id,session_pid,redeem_code,times)
   --gnet.send(c,11409,op_id,session_pid,redeem_code,times);
end
ngm_center_operate.gmc_query_all_batchnumber = function(c,op_id,session_pid)
   --gnet.send(c,11410,op_id,session_pid);
end
ngm_center_operate.gmc_download_redeem_code = function(c,op_id,session_pid,batchNumber)
   --gnet.send(c,11411,op_id,session_pid,batchNumber);
end
ngm_center_operate.gmc_recive_send_redeem_code = function(c,batchNumber,sendIndex)
   --gnet.send(c,11412,batchNumber,sendIndex);
end
ngm_center_operate.gmc_get_account_detail_info = function(c,op_id,session_pid,acc,account_id)
   --gnet.send(c,11413,op_id,session_pid,acc,account_id);
end
ngm_center_operate.gmc_get_account_player_info = function(c,op_id,session_pid,account_id)
   --gnet.send(c,11414,op_id,session_pid,account_id);
end
nmsg_daluandou2={};
nmsg_daluandou2.cg_request_my_daluandou2_data = function(c)
   --gnet.send(c,11602);
end
nmsg_daluandou2.cg_start_match = function(c)
   --gnet.send(c,11603);
end
nmsg_daluandou2.cg_cancel_match = function(c,roomid)
   --gnet.send(c,11604,roomid);
end
nmsg_area={};
nmsg_area.cg_request_area_fight_value_top3 = function(c)
   --gnet.send(c,11802);
end
nmsg_area.cg_request_area_data = function(c)
   --gnet.send(c,11803);
end
nmsg_area.cg_worship = function(c,rankIndex)
   --gnet.send(c,11804,rankIndex);
end
nmsg_area.cg_upgrade_military_rank = function(c)
   --gnet.send(c,11805);
end
nmsg_area.cg_get_military_rank_reward = function(c)
   --gnet.send(c,11806);
end
nmsg_guild_war={};
nmsg_guild_war.cg_get_season_info = function(c)
   --gnet.send(c,12002);
end
nmsg_guild_war.cg_get_guard_info = function(c)
   --gnet.send(c,12003);
end
nmsg_guild_war.cg_get_guard_teams = function(c,nodeId)
   --gnet.send(c,12004,nodeId);
end
nmsg_guild_war.cg_set_guard_team = function(c,nodeId,teamType,herosDataid)
   --gnet.send(c,12005,nodeId,teamType,herosDataid);
end
nmsg_guild_war.cg_cancel_guard_team = function(c,nodeId,teamType)
   --gnet.send(c,12006,nodeId,teamType);
end
nmsg_guild_war.cg_get_my_team = function(c)
   --gnet.send(c,12007);
end
nmsg_guild_war.cg_set_node_is_key = function(c,nodeId,isKey)
   --gnet.send(c,12008,nodeId,isKey);
end
nmsg_guild_war.cg_get_attack_info = function(c)
   --gnet.send(c,12009);
end
nmsg_guild_war.cg_get_attack_guard_teams = function(c,nodeId)
   --gnet.send(c,12010,nodeId);
end
nmsg_guild_war.cg_begin_attack = function(c,nodeId,attackTeamId,guardPlayerId,guardTeamId,heros)
   --gnet.send(c,12011,nodeId,attackTeamId,guardPlayerId,guardTeamId,heros);
end
nmsg_guild_war.cg_end_attack = function(c,isWin,mySideHerosHp,otherSideHerosHp)
   --gnet.send(c,12012,isWin,mySideHerosHp,otherSideHerosHp);
end
nmsg_guild_war.cg_direct_occupy = function(c,nodeId,teamType,heros)
   --gnet.send(c,12013,nodeId,teamType,heros);
end
nmsg_guild_war.cg_change_team_pos = function(c,teamType,herosDataid)
   --gnet.send(c,12014,teamType,herosDataid);
end
nmsg_guild_war.cg_awards = function(c)
   --gnet.send(c,12015);
end
nmsg_guild_war.cg_get_node_fight_log = function(c,nodeid)
   --gnet.send(c,12016,nodeid);
end
nmsg_guild_war.cg_get_guild_deployment_info = function(c)
   --gnet.send(c,12017);
end
nmsg_guild_war.cg_buy_buff = function(c,type)
   --gnet.send(c,12018,type);
end
nmsg_guild_war.cg_get_buy_buff_times = function(c)
   --gnet.send(c,12019);
end
nmsg_xunzhaolishi={};
nmsg_xunzhaolishi.cg_request_my_data = function(c)
   --gnet.send(c,12202);
end
nmsg_xunzhaolishi.cg_request_report = function(c)
   --gnet.send(c,12203);
end
nmsg_xunzhaolishi.cg_reset = function(c)
   --gnet.send(c,12204);
end
nmsg_xunzhaolishi.cg_open = function(c,index)
   --gnet.send(c,12205,index);
end
nmsg_mask={};
nmsg_mask.cg_eat_mask_exp = function(c,index,id,count)
   --gnet.send(c,12402,index,id,count);
end
nmsg_mask.cg_upgrade_mask = function(c,index)
   --gnet.send(c,12403,index);
end
nmsg_mask.cg_mask_rarity_up = function(c,index)
   --gnet.send(c,12404,index);
end
nmsg_mask.cg_mask_star_up = function(c,index)
   --gnet.send(c,12405,index);
end
nproxy_account={};
nproxy_account.pa_register = function(c,gameid,serverid,proxy_id,ip,port,key)
   --gnet.send(c,12602,gameid,serverid,proxy_id,ip,port,key);
end
nproxy_account.pa_verify_token = function(c,user_platform_id,account_id,token,server_id,device_id)
   --gnet.send(c,12603,user_platform_id,account_id,token,server_id,device_id);
end
nproxy_account.pa_update_online = function(c,total,online,login,timeout)
   --gnet.send(c,12604,total,online,login,timeout);
end
nproxy_account.pa_login_ret = function(c,info,bSucc)
   --gnet.send(c,12605,info,bSucc);
end
nproxy_account.pa_login_limit_check = function(c,account_id)
   --gnet.send(c,12606,account_id);
end
nproxy_center={};
nproxy_center.pc_auth = function(c,serverid)
   --gnet.send(c,12652,serverid);
end
nproxy_center.pc_login_ret = function(c,info,bSucc)
   --gnet.send(c,12653,info,bSucc);
end
nproxy_center.pc_login_limit_check = function(c,account_id)
   --gnet.send(c,12654,account_id);
end
nmsg_web_2_info={};
nmsg_web_2_info.req_auth = function(c,server_id,key)
   --gnet.send(c,12702,server_id,key);
end
nmsg_web_2_info.req_set_intro_flag = function(c,session_id,openid,token,flag)
   --gnet.send(c,12703,session_id,openid,token,flag);
end
nmsg_web_2_info.req_get_intro_flag = function(c,session_id,openid,token)
   --gnet.send(c,12704,session_id,openid,token);
end
nmsg_web_2_info.req_get_player_list = function(c,session_id,openid,device_uuid,token)
   --gnet.send(c,12705,session_id,openid,device_uuid,token);
end
nmsg_game_2_info={};
nmsg_game_2_info.req_auth = function(c,serverid,key)
   --gnet.send(c,12802,serverid,key);
end
nmsg_game_2_info.req_set_player_inf = function(c,info)
   --gnet.send(c,12803,info);
end
nmsg_game_2_info.req_set_device_login_inf = function(c,deviceid,accountid)
   --gnet.send(c,12804,deviceid,accountid);
end
nmsg_1v1={};
nmsg_1v1.cg_random_match = function(c)
   --gnet.send(c,12902);
end
nmsg_1v1.cg_cancel_match = function(c,roomid)
   --gnet.send(c,12903,roomid);
end
nmsg_1v1.cg_challenge_player = function(c,playerid)
   --gnet.send(c,12904,playerid);
end
nmsg_1v1.cg_send_notice = function(c,content)
   --gnet.send(c,12905,content);
end
nmsg_1v1.cg_answer_challenge = function(c,bAgree,playerid)
   --gnet.send(c,12906,bAgree,playerid);
end
nmsg_1v1.cg_cancel_fight_count_down = function(c,roomid)
   --gnet.send(c,12907,roomid);
end
nmsg_1v1.cg_select_choose = function(c,roomid,nstate,vecParam,bfinally)
   --gnet.send(c,12908,roomid,nstate,vecParam,bfinally);
end
nmsg_1v1.cg_set_1v1_function_state = function(c,bshield)
   --gnet.send(c,12909,bshield);
end
nmsg_1v1.cg_cancel_challenge = function(c,playerid)
   --gnet.send(c,12910,playerid);
end
nmsg_1v1.cg_get_week_reward = function(c,ntype,times)
   --gnet.send(c,12911,ntype,times);
end
npay={};
npay.client_register = function(c,appId,serverId,secret)
   --gnet.send(c,70001,appId,serverId,secret);
end
npay.req_send_pay = function(c,info)
   --gnet.send(c,70002,info);
end
npay.req_pay_result_confirm = function(c,orderId)
   --gnet.send(c,70003,orderId);
end
nproxy_dtree={};
nproxy_dtree.req_auth = function(c,proxy_baseinfo,key)
   --gnet.send(c,70501,proxy_baseinfo,key);
end
nproxy_dtree.update_proxy_info = function(c,proxy_updateinfo)
   --gnet.send(c,70502,proxy_updateinfo);
end
