--
-- Created by IntelliJ IDEA.
-- User: PoKong_OS
-- Date: 2015/3/16
-- Time: 18:49
-- To change this template use File | Settings | File Templates.
--

-- 临时变量, 是否使用本地数据
local isLocalData = true

player = { };
-- 客户端到服务器

-- 获取随机的名字
function player.cg_rand_name()
    if not PublicFunc.lock_send_msg(player.cg_rand_name) then return end

    if (isLocalData) then
        g_player_local.cg_rand_name()
    else
        --if not Socket.socketServer then return end
        nplayer.cg_rand_name(Socket.socketServer);
    end
end
local req_set_name = nil;
-- 设置角色名
function player.cg_set_name(name)
    if (isLocalData) then
        g_player_local.cg_set_name();
        req_set_name = name;
    else
        --if not Socket.socketServer then return end
        nplayer.cg_set_name(Socket.socketServer, name);
        req_set_name = name;
    end
end
-- 创建角色
function player.cg_create_player_info(info)
    if (isLocalData) then
        g_player_local.cg_create_player_info();
    else
        --if not Socket.socketServer then return end
        nplayer.cg_create_player_info(Socket.socketServer, info);
    end
end

function player.cg_first_enter_game_complete()
	--if not Socket.socketServer then return end
    if AppConfig.script_recording then
        PublicFunc.RecordingScript("nplayer.cg_first_enter_game_complete(robot_s)")
    end
	nplayer.cg_first_enter_game_complete(Socket.socketServer);
end


--[[发送聊天，私聊
--// 玩家的聊天消息 type:system =1系统 whisper = 2; 私聊 world = 3;世界  alliance =4;联盟
	cg_player_chat(int8 type, string content, string desplayername);
-- ]]
function player.cg_player_chat(type, content, desplayername)
    if (isLocalData) then
        g_player_local.cg_player_chat();
    else
        if type == nil then return end;
        app.log("发送聊天,type=" .. tostring(type) .. ",desplayername=" .. tostring(desplayername));
        --if not Socket.socketServer then return end
        nplayer.cg_player_chat(Socket.socketServer, type, tostring(content), tostring(desplayername));
    end
end

-- 新手引导id
function player.cg_guide_id(id)
    --if not Socket.socketServer then return end
    if AppConfig.script_recording then
        PublicFunc.RecordingScript("nplayer.cg_guide_id(robot_s, "..tostring(id)..")")
    end
    nplayer.cg_guide_id(Socket.socketServer, id);
end

function player.cg_ap_buy()
	--if not Socket.socketServer then return end
	nplayer.cg_ap_buy(Socket.socketServer);
end

--领取首充奖励
function player.cg_get_first_recharge_reward()
    --if not Socket.socketServer then return end
    nplayer.cg_get_first_recharge_reward(Socket.socketServer);
end

function player.cg_select_country(areaid)
    --if not Socket.socketServer then return end
    if AppConfig.script_recording then
        PublicFunc.RecordingScript("nplayer.cg_select_country(robot_s, "..tostring(areaid)..")")
    end
	nplayer.cg_select_country(Socket.socketServer,areaid);
end 

-- 服务器到客户端

-- 返回角色信息
function player.res_player(playerInfo)
    app.log("<color=#E00000ff> ====player.res_player==== </color>");
	Root.push_web_info("sys_060","返回角色信息成功");
    --[[公司日志：游戏启动信息]]
    SystemLog.AppStartClose(60);
    --app.log("playerInfo="..table.tostring(playerInfo))
	g_dataCenter.player:UpdateData(playerInfo);
    g_dataCenter.player:SetIsWaitingPlayerData(false);
	player.get_other_info();--[[副数据申请]]
    g_dataCenter.guildBoss:UpdateFirstPassReward(playerInfo.guild_boss_first_pass_reward_flag);
    g_dataCenter.guildBoss:UpdateChallengeTimes(playerInfo.guild_boss_play_times);
    g_dataCenter.worldBoss:SetChallengeTimes(playerInfo.world_boss_last_times);
    g_dataCenter.worldBoss:SetRewardFlag(playerInfo.world_boss_server_reward_flag1,playerInfo.world_boss_server_reward_flag2);
    g_dataCenter.worldBoss:SetBuyTimes(playerInfo.world_boss_buy_times);
	if g_dataCenter.trial:CanEnter() then 
		g_dataCenter.trial:initServerData();
	end 
    --system.cg_upload_client_info(Root.get_os_type(), AppConfig.get_package_id())
    
    --进入游戏
    --Socket.StartPingPong()
    ---
    -- 检查是否触发新手关卡引导
    GuideManager.CheckRecord(playerInfo.guide)
end

--[[ 副数据申请 ]]
function player.get_other_info()
    -- TODO --[[副数据申请]]
    -- msg_cards.cg_cards_list(Socket.socketServer,0);
    -- msg_hurdle.cg_hurdle_group_info(Socket.socketServer);
    -- msg_team.cg_team_list(Socket.socketServer);

	------------------------sdk info str--------------------------------
--    app.log("getotherinfo =============================")
	--[[提交第三方SDK上报]]
	UserCenter.get_sdk_push_info("enterGame");

	--[[腾讯查询余额]]
	if AppConfig.get_check_tencent() then
		app.log("player message 腾讯查询余额");
		UserCenter.cneent_balance(false);
	end

    msg_activity.cg_get_everyday_recharge_data()-- 改
	------------------------sdk info end--------------------------------

    ------------------------聊天信息str--------------------------------
    msg_chat.cg_cache_chat();
    --[[ 聊天缓存信息 ]]    
    ------------------------聊天信息end--------------------------------
	-- 初始化语音sdk
	--Im.init_sdk(0, AppConfig.get_im_appid(), AppConfig.get_im_is_test());
    -- 初始化紅點提示
    GGuideTipMgrInit();
    --获取特效设置
    if not g_dataCenter.setting:GetRecvServerSetting() then
        local str_device_model = util.get_devicemodel();
        str_device_model = string.gsub(str_device_model, " ","_");
        msg_client_log.cg_get_auto_set_effect(str_device_model);
    end
    


    -- 充值项目数据
    msg_store.cg_request_store_data()
    --[[为了显示小红点提示，在主界面来请求数据]]
    -- 7日签到，月签到数据
    --msg_checkin.cg_get_checkin_info()
    -- 请求活动状态
    -- msg_activity.cg_activity_request_state()
    -- 登录数据
    -- msg_activity.cg_login_request_my_data()-- 改
    -- 闯关数据
    -- msg_activity.cg_hurdle_request_my_data()--暂时没用（废弃）
    -- 升级奖励
    -- LevelUpReward.GetInstance():RequestInitData()--暂时没用（废弃）
    --CityBuildingMgr.GetInst():RequestMyBuildingInfo()

    -- 每日充值活动
   
end

-- 返回随机名字
function player.gc_rand_name(listName)
    PublicFunc.unlock_send_msg(player.cg_rand_name)
    --app.log("返回随机名字=" .. table.tostring(listName));
    if g_dataCenter.player then
        g_dataCenter.player:SetRollNameList(listName)
    end 
    PublicFunc.msg_dispatch(player.gc_rand_name, listName)
end

function player.gc_some_player_info(playerInfo, ret)
    --
    if (ret == MsgEnum.error_code.error_code_success) then
        g_friend[3] = { };
        g_friend[3][1] = playerInfo;
        if (uiManager:GetCurScene().UpdateListUI ~= nil and uiManager:GetCurScene().ui ~= nil) then
            uiManager:GetCurScene():UpdateListUI();
        end
        --
    elseif (ret == MsgEnum.error_code.error_code_not_find_player) then
        g_friend[3] = { };
        if (uiManager:GetCurScene().UpdateListUI ~= nil and uiManager:GetCurScene().ui ~= nil) then
            uiManager:GetCurScene():UpdateListUI();
        end
        HintUI.SetAndShow(EHintUiType.zero, gs_string_friend['no_search_result']);
    end
end

-- function player.gc_displacement(msgstr)
--     local str = ConfigManager.Get(EConfigIndex.t_error_code_cn,MsgEnum.error_code.error_code_player_displacement)
--     if not str then
-- 		str = "帐号在其他调备登录 ";
--     end

-- 	HintUI.SetAndShow(EHintUiType.one, str.tip, {str = "重新进入", func = GameBegin.usercenter_logout_callback}, nil, nil, nil, true);
-- end
-- 创建角色返回
function player.gc_create_player_info(state)
--    app.log("gc_create_player_info##############"..tostring(state))
	if PublicFunc.GetErrorString(state) then
		--[[提交第三方SDK上报]]
		UserCenter.get_sdk_push_info("createRole");
	end
    PublicFunc.msg_dispatch(player.gc_create_player_info, state)
end

function player.gc_update_my_info(playerinfo)
    g_dataCenter.player:UpdateData(playerinfo);
    local uiMgr = SceneManager.GetUIMgr()
	if uiMgr and uiMgr:GetNavigationBarUi() then
		uiMgr:GetNavigationBarUi():UpdateUi();
	end
end

function player.gc_update_player_exp_level(exp, level)
    g_dataCenter.player:UpdateExpLevel(exp, level);
    local uiMgr = SceneManager.GetUIMgr()
	if uiMgr and uiMgr:GetNavigationBarUi() then
		uiMgr:GetNavigationBarUi():UpdateUi();
	end
    PublicFunc.msg_dispatch(player.gc_update_player_exp_level)
    --if self:IsIllumstration() then
    if PublicFunc.FuncIsOpen(MsgEnum.eactivity_time.eActivityTime_RolePokedex) then
        GNoticeGuideTip(Gt_Enum_Wait_Notice.Forced, Gt_Enum.EMain_BattleTeam_Illustrations);
        GNoticeGuideTip(Gt_Enum_Wait_Notice.Forced, Gt_Enum.EMain_BattleTeam_Illustrations_Main);
        GNoticeGuideTip(Gt_Enum_Wait_Notice.Forced, Gt_Enum.EMain_BattleTeam_Illustrations_CCG);
        GNoticeGuideTip(Gt_Enum_Wait_Notice.Forced, Gt_Enum.EMain_BattleTeam_Illustrations_SSG);
    end
    --end
end

function player.gc_update_player_gold_crystal(gold, crystal, red_crystal)
    local oldGold = g_dataCenter.player.gold;
    local oldCrystal = g_dataCenter.player.crystal;
	g_dataCenter.player:UpdateGoldAndCrystal(gold, crystal, red_crystal);
    local uiMgr = SceneManager.GetUIMgr()
	if uiMgr and uiMgr:GetNavigationBarUi() then
		uiMgr:GetNavigationBarUi():UpdateUi();
	end
    PublicFunc.msg_dispatch(player.gc_update_player_gold_crystal);
    if oldGold ~= tonumber(gold) then
        GNoticeGuideTip(Gt_Enum_Wait_Notice.Gold);
    end
    if oldCrystal ~= tonumber(crystal) then
        NoticeManager.Notice(ENUM.NoticeType.UpdatePlayerCrystal);
    end
end

function player.gc_update_player_ap_bp(ap, bp)
    g_dataCenter.player:UpdateApAndBp(ap, bp);
    local uiMgr = SceneManager.GetUIMgr()
	if uiMgr and uiMgr:GetNavigationBarUi() then
		uiMgr:GetNavigationBarUi():UpdateUi();
	end
    PublicFunc.msg_dispatch(player.gc_update_player_ap_bp);
end

--[[聊天信息返回
-- gc_player_chat_error(int8 type, string content, string desplayername, int8 errorcode);
-- ]]
function player.gc_player_chat_error(type, content, desplayername, errorcode)
    app.log("接收的聊天消息错误，type=" .. tostring(type));
    local temp = { };
    temp.type = type;
    temp.content = content;
    temp.desplayername = desplayername;
    temp.errorcode = errorcode;
    ChatData.AddErrorMessage(temp);
end

--[[
-- 接收的聊天消息
	gc_player_chat(int8 type, string content, string srcplayername, int8 viplevel, int rolecard_number, string date);
-- ]]
function player.gc_player_chat(type, content, srcplayername, targetname, viplevel, rolecard_number, date)
    app.log("接收的聊天消息,type=" .. tostring(type) .. ",srcplayername=" .. tostring(srcplayername) .. ",targetname=" .. tostring(targetname));

    local temp = { };
    temp.type = type;
    temp.content = content;
    temp.srcplayername = srcplayername;
    temp.targetname = targetname;
    temp.viplevel = viplevel;
    temp.rolecard_number = rolecard_number;
    temp.date = date;
    ChatData.AddMessage(temp);
end

--[[ 更新玩家的商城卡信息
-- gc_update_player_store_card_info(int8 card1, int card1_last_day, int8 card2, int card2_last_day);
--]]
function player.gc_update_player_store_card_info(card1, card1_last_day, card2, card2_last_day)
    -- app.log(card1, card1_last_day);
    g_dataCenter.player:UpdateStoreCard(card1, card1_last_day, card2, card2_last_day);
    PublicFunc.msg_dispatch(player.gc_update_player_store_card_info);
end

--[[ 更新玩家VIP等级、VIP经验以及VIP奖励的领取信息
-- gc_update_player_vip_info(int8 vip_level, int vip_exp, int vip_reward_flag);
--]]
function player.gc_update_player_vip_info(viplevel, vipexp, viprewardFlag, vipstar, vip_every_get)
    g_dataCenter.player:UpdateVIP(viplevel, vipexp, viprewardFlag, vipstar, vip_every_get);
    local uiMgr = SceneManager.GetUIMgr()
	if uiMgr and uiMgr:GetNavigationBarUi() then
		uiMgr:GetNavigationBarUi():UpdateUi();
	end

    PublicFunc.msg_dispatch(player.gc_update_player_vip_info)
end

function player.gc_ap_buy(result)
	if PublicFunc.GetErrorString(result) then
		PublicFunc.msg_dispatch("player.gc_ap_buy");
		--FloatTip.Float(tostring(PublicFunc.GetErrorString(result)));
	end
end

--首充标志
function player.gc_first_recharge_flag(flag)
    g_dataCenter.player:SetFirstRechargeFlag(flag);
    PublicFunc.msg_dispatch(player.gc_first_recharge_flag,flag);
    GNoticeGuideTip(Gt_Enum_Wait_Notice.Forced, Gt_Enum.EMain_FirstRecharge);
end

--领取首充奖励
function player.gc_get_first_recharge_reward(result, awards)
    if PublicFunc.GetErrorString(result) then
        PublicFunc.msg_dispatch(player.gc_get_first_recharge_reward,result, awards);
    end
end

--[[当天传送次数]]
function player.gc_update_player_cur_transform_to_boss_num(cnt)
    --app.log("gc_update_player_cur_transform_to_boss_num -->" .. cnt)
    g_dataCenter.player:SetTransformCnt(cnt)
end

--更新角色体验卷
function player.gc_update_hero_trial_ticket(cnt)
    g_dataCenter.player:SetHeroTrialTicket(cnt)
end

function player.cg_buy_item(id, count)
    --if not Socket.socketServer then return end
    nplayer.cg_buy_item(Socket.socketServer, id, count);
end

function player.gc_buy_item(result)
    if PublicFunc.GetErrorString(result) then
        PublicFunc.msg_dispatch(player.gc_buy_item,result);
    end
end

--邀请好友
function player.cg_invite_friend(info)
    --if not Socket.socketServer then return end
    GLoading.Show(GLoading.EType.msg)
    nplayer.cg_invite_friend(Socket.socketServer, info);
end

function player.gc_invite_friend(result, info)
    GLoading.Hide(GLoading.EType.msg)
    app.log("===== gc_invite_friend:"..table.tostring({result, info}))
    if tonumber(result) ~= 0 then
        PublicFunc.GetErrorString(result)   
        return
    end
    PublicFunc.msg_dispatch(player.gc_invite_friend, info);
end

--邀请确定状态 state 0接受 1拒绝
function player.cg_invite_state(state, info)
    --if not Socket.socketServer then return end
    if state == 0 then GLoading.Show(GLoading.EType.msg) end
    nplayer.cg_invite_state(Socket.socketServer, state, info);
end

--返回确定结果
function player.gc_invite_state(result, state, info)
    app.log("===== gc_invite_state: "..table.tostring({result, state, info}))
    if state == 0 then GLoading.Hide(GLoading.EType.msg) end
    if PublicFunc.GetErrorString(result) then
        PublicFunc.msg_dispatch(player.gc_invite_state, result, state, info);
    end
end

--同步新增邀请数据
function player.gc_get_invite(info)
    app.log("===== gc_get_invite:"..table.tostring(info))
    --聊天消息
    local chat = g_dataCenter.invite:BuildChatMsg(info)
    msg_chat.gc_add_player_chat(chat)
    --g_dataCenter.player:AddInvite(info)
    --PublicFunc.msg_dispatch(player.gc_get_invite, info);
end

function player.gc_sync_skill_point_info(point ,cd)
    g_dataCenter.player:UpdateSkillPointCD(point,cd);
    PublicFunc.msg_dispatch(player.gc_sync_skill_point_info, point,cd);
end


------技能点购买
function player.cg_buy_skill_point()
    --if not Socket.socketServer then return end
    nplayer.cg_buy_skill_point(Socket.socketServer); 
end

function player.gc_buy_skill_point(result)
    if 84206174 == result then
        uiManager:PushUi(EUI.StoreUI);
    end
    if PublicFunc.GetErrorString(result) then
        PublicFunc.msg_dispatch(player.gc_buy_skill_point, result);
    end
end

function player.cg_get_month_cards_state()
    --if not Socket.socketServer then return end
    if AppConfig.script_recording then
        PublicFunc.RecordingScript("nplayer.cg_get_month_cards_state(robot_s)")
    end
    nplayer.cg_get_month_cards_state(Socket.socketServer);
end

function player.gc_get_month_cards_state( is_active_month, card_1_state, card_1_day, crad_2_state, card_2_day, progress1, progress2 )
    app.log("大小月卡状态：" .. table.tostring({is_active_month , card_1_state , card_1_day, crad_2_state, card_2_day, progress1, progress2}));
    PublicFunc.msg_dispatch(player.gc_get_month_cards_state, is_active_month, card_1_state, card_1_day, crad_2_state, card_2_day, progress1, progress2 );
end

function player.cg_look_other_player(playerid,teamType)
    if Socket.socketServer then
        nplayer.cg_look_other_player(Socket.socketServer,playerid,teamType)
    end
end

function player.gc_look_other_player(result,playerid,teamType,otherPlayerData)
    PublicFunc.msg_dispatch(player.gc_look_other_player,result,playerid,teamType,otherPlayerData);
end

--[[玩家头像更改结果]]
function player.gc_change_player_image( result, heroNumber)
	app.log("玩家头像更改结果："..tostring(result)..",heroNumber = "..tostring(heroNumber));
    if result == 0 then 
        g_dataCenter.player.image = heroNumber;
		--PublicFunc.msg_dispatch(player.gc_change_player_image, heroNumber);
		FloatTip.Float("修改玩家头像成功");
    end 
    app.log("当前玩家头像："..tostring(g_dataCenter.player.image));
end

function player.gc_update_get_friend_ap_times(times)
    g_dataCenter.player:UpdateGetFriendAPTimes(times);
    PublicFunc.msg_dispatch(player.gc_update_get_friend_ap_times);
end

function player.cg_change_name( name )
    --if not Socket.socketServer then return end
    nplayer.cg_change_name(Socket.socketServer,name); 
end

function player.gc_change_name(result,name)

    if PublicFunc.GetErrorString(result) then
        g_dataCenter.player.name = name;
        g_dataCenter.player.change_name_times = g_dataCenter.player.change_name_times + 1
        PublicFunc.msg_dispatch(player.gc_change_name, name);
        FloatTip.Float("修改战队名称成功");
        NoticeManager.Notice(ENUM.NoticeType.PlayerNameChange);
    end
end

function player.gc_sync_training_group_advacne_level(groupsLevel)
    --app.log("gc_sync_training_group_advacne_level")
    g_dataCenter.trainning:set_saveBattleLvl(groupsLevel)
    GNoticeGuideTip(Gt_Enum_Wait_Notice.Forced,Gt_Enum.Emain_BattleTeam_trainning_daren);
    GNoticeGuideTip(Gt_Enum_Wait_Notice.Forced,Gt_Enum.Emain_BattleTeam_trainning_info_daren);
end

function player.cg_training_group_advance( gid )
    --if not Socket.socketServer then return end
        nplayer.cg_training_group_advance(Socket.socketServer,gid);
end

function player.gc_training_group_advance(result,gid,newLevel)
    
    local show = PublicFunc.GetErrorString(result);
    if show then
       --app.log("###########################"..tostring(gid).." ###########################"..tostring(newLevel))
       g_dataCenter.trainning:set_BattleLvl(gid,newLevel)
       PublicFunc.msg_dispatch(player.gc_training_group_advance,gid,newLevel);
       GNoticeGuideTip(Gt_Enum_Wait_Notice.Forced,Gt_Enum.Emain_BattleTeam_trainning_daren);
       GNoticeGuideTip(Gt_Enum_Wait_Notice.Forced,Gt_Enum.Emain_BattleTeam_trainning_info_daren);
    end
    
end

--[[本地模拟发送]]
function player.gc_check_realname_auth()
   PublicFunc.msg_dispatch(player.gc_check_realname_auth)
end

function player.gc_update_fight_value(value, histroyMaxFv)
    local old_value = g_dataCenter.player:GetFightValue()
    if old_value ~= value then
        g_dataCenter.player:SetFightValue(value, histroyMaxFv)
        if FightScene.GetPlayMethodType() == nil then
            g_dataCenter.hurdle.showFightValue = true;
            g_dataCenter.hurdle.oldFightValue = old_value;
            g_dataCenter.hurdle.newFightValue = value;
        else
            FightValueChangeUI.ShowChange(ENUM.FightingType.Team, value, old_value)
        end
    end

    PublicFunc.msg_dispatch(player.gc_update_fight_value)
    GNoticeGuideTip(Gt_Enum_Wait_Notice.Player_FightValue)
end

function player.gc_select_country(result,areaid)
	--FloatTip.Float("选择了区域id:"..tostring(areaid));
	local show = PublicFunc.GetErrorString(result);
	if show then 
        g_dataCenter.player.country_id = areaid;
        --语音聊天
        Im.handle_voice_area()
        PublicFunc.msg_dispatch(player.gc_select_country, areaid);
        NoticeManager.Notice(ENUM.NoticeType.ChangeAreaSuccess, areaid);
	end
end 
--领取绑定奖励
function player.cg_get_bind_awards()
    --if not Socket.socketServer then return end
        nplayer.cg_get_bind_awards(Socket.socketServer);
end

function player.gc_get_bind_awards(result,awardslist)
    local show = PublicFunc.GetErrorString(result);
    app.log("awardslist################"..table.tostring(awardslist))
    if show then
        g_dataCenter.player:SetBindAwardsFlag()
        PublicFunc.msg_dispatch(player.gc_get_bind_awards,awardslist);
    end
end

function player.cg_set_peekshow()
    --if not Socket.socketServer then return end
    if AppConfig.script_recording then
        PublicFunc.RecordingScript("nplayer.cg_set_peekshow(robot_s)")
    end
    nplayer.cg_set_peekshow(Socket.socketServer);
end

function player.gc_set_peekshow(result)
    
end

--同步玩家所有标记
function player.gc_sync_player_flag_list(flaglist)
    app.log("同步玩家所有标记"..table.tostring(flaglist))
    for k,v in pairs(flaglist) do
        g_dataCenter.player_flag[v.key] = v
    end
    NoticeManager.Notice(ENUM.NoticeType.UpdatePlayerFlag)
end

--同步玩家所有标记
function player.gc_sync_single_player_flag(flag)
    app.log("更新玩家标记"..table.tostring(flag))
    if flag.key then
        g_dataCenter.player_flag[flag.key] = flag
    else
        -- app.log("更新玩家标记"..table.tostring(flag))
    end
    if FightScene.GetFightManager() and FightScene.GetFightManager().checkUpdateNpcTag then
        FightScene.GetFightManager():checkUpdateNpcTag()
    end
    PublicFunc.msg_dispatch(world_msg.gc_sync_single_player_flag, flag);
end

function player.gc_fight_server_crash()
    if PublicStruct.Fight_Sync_Type == ENUM.EFightSyncType.StateSync then
        local btn1Data = {str="确定", func=function()
            if FightScene.GetFightManager() then
                FightScene.GetFightManager():FightOver(false, true);
            end
        end}
        HintUI.SetAndShow(EHintUiType.one, "战斗异常！请重新尝试", btn1Data);
    else
        uiManager:RemoveUi(EUI.QingTongJiDiHeroChoseUI);
        uiManager:RemoveUi(EUI.MobaMatchingUI);
        uiManager:RemoveUi(EUI.MobaReadyEnterUI);
        uiManager:RemoveUi(EUI.QingTongJiDiRoomUI);
        FloatTip.Float("战斗异常！")
    end
end

--开启宝箱结果
function player.gc_open_treasure_box_reward(result,sItem)
    --if result == 0 then
        app.log("开启成功")
        --CommonAward.Start(sItem)
        for k,v in pairs(sItem) do
            local data = {}
            data.priority = 1
            data.number = v.id
            data.count = v.count
            UiRollMsg.PushMsg(data)
        end
    -- else
    --     HintUI.SetAndShow(EHintUiType.one, "宝箱已被拾取或消失",
    --        {str = "退出"}
    --    );
--        app.log("开启失败")
    -- end

end
function player._send_agree_return_fight()
    --if not Socket.socketServer then return end
    nplayer.cg_reply_return_fight(Socket.socketServer, true)
end

function player._send_refuse_return_fight()
    --if not Socket.socketServer then return end
    nplayer.cg_reply_return_fight(Socket.socketServer, false)
end

function player.cg_reply_return_fight(return_fight)
    --if not Socket.socketServer then return end
    nplayer.cg_reply_return_fight(Socket.socketServer,return_fight)
end

function player.gc_ask_return_fight(active_type)
    if active_type == MsgEnum.eactivity_time.eActivityTime_fuzion then
        HintUI.SetAndShow(EHintUiType.two, "当前正在大乱斗中，是否返回", {str = "确定",func = player._send_agree_return_fight},{str = "取消",func = player._send_refuse_return_fight,time=30})
    elseif active_type == MsgEnum.eactivity_time.eActivityTime_fuzion2 then
        HintUI.SetAndShow(EHintUiType.two, "当前正在大乱斗中，是否返回", {str = "确定",func = player._send_agree_return_fight},{str = "取消",func = player._send_refuse_return_fight,time=30})
    elseif active_type == MsgEnum.eactivity_time.eActivityTime_pvptest then
        HintUI.SetAndShow(EHintUiType.two, "当前正在PVP测试地图，是否返回", {str = "确定",func = player._send_agree_return_fight},{str = "取消",func = player._send_refuse_return_fight,time=30})
    elseif active_type == MsgEnum.eactivity_time.eActivityTime_threeToThree then
        -- HintUI.SetAndShow(EHintUiType.two, "当前正在3v3地图中，是否返回", {str = "确定",func = player._send_agree_return_fight},{str = "取消",func = player._send_refuse_return_fight,time=30})
        uiManager:PushUi(EUI.MobaEnterTipsUI, {name = "re_enter_tip", callback = player._send_agree_return_fight})

    elseif active_type == MsgEnum.eactivity_time.eActivityTime_1v1 then
        HintUI.SetAndShow(EHintUiType.two, "当前正在喰场对决中，是否返回", {str = "确定",func = player._send_agree_return_fight},{str = "取消",func = player._send_refuse_return_fight,time=30})

    else
        player._send_refuse_return_fight()
        --HintUI.SetAndShow(EHintUiType.two, "当前正在未知PVP玩法中，是否返回", {str = "确定",func = player._send_agree_return_fight},{str = "取消",func = player._send_refuse_return_fight,time=30})
    end
end

--获取怪物掉落物品
function player.gc_monster_drop_item(sItem)
    for k, v in pairs(sItem) do
        local data = {priority = 1, number = v.id, count = v.count};
        UiRollMsg.PushMsg(data);
    end
end

function player.gc_set_red_point_state(redIndex, state)
    GGuideTipForceSetState(redIndex, state);
end

function player.cg_exchange_red_crystal(count)
    --if not Socket.socketServer then return end
    nplayer.cg_exchange_red_crystal(Socket.socketServer, count)
end

function player.gc_exchange_red_crystal(result, count)
    if PublicFunc.GetErrorString(result) then
        -- PublicFunc.msg_dispatch(world_msg.gc_exchange_red_crystal);
        FloatTip.Float("兑换成功！");
    end
    PublicFunc.msg_dispatch(player.gc_exchange_red_crystal);
end

function player.gc_real_name_limit(result,TodayOnlineTime)
    --do return end;

    --result 0.在时间内允许登录 1.超过时间   TodayOnlineTime 今天时间
    if result == 0 then
        g_dataCenter.player:SetRunGameTime(TodayOnlineTime)
    else
        if UserCenter.get_web_realname() ~= 0  then
            PlayerEnterUITimesCurDay.SetGameTimeDate(true)
            if not Socket.isLogin then   --控制登录读条过程中 不弹窗口
                if LoginReNameUI then
                    if not LoginReNameUI.isShow then
                        LoginReNameUI.Show(1)
                        g_dataCenter.player:SetRunGameTime(TodayOnlineTime)
                        --PlayerEnterUITimesCurDay.RunGame("gametime")                   
                    end
                end
            end
        end
    end
end
--更新教堂挂机精力
function player.gc_sync_church_vigor(num)
    g_dataCenter.player:UpdateChurchVigor(num)
    local uiMgr = SceneManager.GetUIMgr()
    if uiMgr and uiMgr:GetNavigationBarUi() then
        uiMgr:GetNavigationBarUi():UpdateUi();
    end
end

-------------------- vip -----------------------
function player.cg_vip_add_yijian_good( item_id1, item_id1_num, item_id2, item_id2_num, mod_exp, vip, vipstar, up_vip_level )
    --if not Socket.socketServer then return end
    nplayer.cg_vip_add_yijian_good(Socket.socketServer, item_id1, item_id1_num, item_id2, item_id2_num, mod_exp, vip, vipstar, up_vip_level);
end

function player.gc_vip_add_yijian_good( result, vip_up_level )
    if result == 0 then
        PublicFunc.msg_dispatch(player.gc_vip_add_yijian_good, vip_up_level);
    else

    end
end

function player.cg_get_vip_every_reward( vip, vipstar )
     --if not Socket.socketServer then return end
     nplayer.cg_get_vip_every_reward(Socket.socketServer, vip, vipstar);
end

function player.gc_get_vip_every_reward( result, vip, vipstar )
    if result == 0 then
        PublicFunc.msg_dispatch(player.gc_get_vip_every_reward, vip, vipstar);
    end
end

function player.cg_guard_heart_place_hero_in_pos(dataID, pos)
    --if not Socket.socketServer then return end
    --app.log("#hyg#OnSelectedRole " .. tostring(dataID) .. ' ' .. tostring(pos))
    nplayer.cg_guard_heart_place_hero_in_pos(Socket.socketServer, dataID, pos)
end

function player.cg_guard_heart_pos_promotion(pos)
    --if not Socket.socketServer then return end
    nplayer.cg_guard_heart_pos_promotion(Socket.socketServer, pos)
end

function player.gc_guard_heart_place_hero_in_pos(ret, pos)
    if PublicFunc.GetErrorString(ret) then
        PublicFunc.msg_dispatch(player.gc_guard_heart_place_hero_in_pos, pos)

        GNoticeGuideTip(Gt_Enum_Wait_Notice.Guard_Heart)
    end
end

function player.gc_guard_heart_pos_promotion(ret, pos)
    if PublicFunc.GetErrorString(ret) then
        PublicFunc.msg_dispatch(player.gc_guard_heart_pos_promotion, pos)

        GNoticeGuideTip(Gt_Enum_Wait_Notice.Guard_Heart)
    end
end

function player.gc_sync_guard_heart_data(isAll, datas)
    --app.log("#hyg#gc_sync_guard_heart_data " .. tostring(isAll) .. ' ' .. table.tostring(datas))
    g_dataCenter.guardHeart:SetData(isAll, datas)
end

function player.gc_guard_heart_remove_hero(pos)
    --app.log("#hyg#gc_guard_heart_remove_hero " .. table.tostring(pos))
    g_dataCenter.guardHeart:RemovePosHero(pos)

    PublicFunc.msg_dispatch(player.gc_guard_heart_remove_hero, pos)
end

function player.cg_guard_heart_buy_pos(pos)
    --app.log("#hyg#cg_guard_heart_buy_pos " .. tostring(pos))
    nplayer.cg_guard_heart_buy_pos(Socket.socketServer, pos)
end

function player.gc_guard_heart_buy_pos(ret, pos)
    if PublicFunc.GetErrorString(ret) then
        g_dataCenter.guardHeart:AddOneBoughtPos(pos)

        GNoticeGuideTip(Gt_Enum_Wait_Notice.Guard_Heart)
    end
end

function player.gc_sync_guard_heart_bought_pos(boughtPos)
    --app.log("#hyg#gc_sync_guard_heart_bought_pos " .. table.tostring(boughtPos))
    g_dataCenter.guardHeart:SetHasBoughtPos(boughtPos)
end

--------------------------------资源记录--------------------------------

function player.cg_resource_record(list)
    --if not Socket.socketServer then return end
    nplayer.cg_resource_record(Socket.socketServer, list)
end

function player.gc_resource_record(result)
    if tonumber(result) ~= 0 then
        PublicFunc.GetErrorString(result)
        return
    end
    ResourceRecord.ClearUploadRecord()
end


return player;