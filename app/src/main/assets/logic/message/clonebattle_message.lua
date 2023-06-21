msg_clone_fight = msg_clone_fight or { }
msg_clone_fight.allow = 0;
-- 请求每天挑战的英雄ID
function msg_clone_fight.cg_get_challenge_hero()
    --if not Socket.socketServer then return end
        nmsg_clone_fight.cg_get_challenge_hero(Socket.socketServer);
        
end
--获取队伍信息
function msg_clone_fight.cg_get_team_info()
    --if not Socket.socketServer then return end
	nmsg_clone_fight.cg_get_team_info(Socket.socketServer )
    
end

--创建队伍
function msg_clone_fight.cg_create_team(id)
    --if not Socket.socketServer then return end
	nmsg_clone_fight.cg_create_team(Socket.socketServer,id )
    
end

--请求加入队伍
function msg_clone_fight.cg_join_team(roomid ,heroid)
    --if not Socket.socketServer then return end
	nmsg_clone_fight.cg_join_team( Socket.socketServer,roomid ,heroid )
end

--快速加入
function msg_clone_fight.cg_quick_join( heroid )
    --if not Socket.socketServer then return end
	nmsg_clone_fight.cg_quick_join( Socket.socketServer,heroid )
end

--退出队伍
function msg_clone_fight.cg_exit_team( )
    GLoading.Show(GLoading.EType.msg)
    --if not Socket.socketServer then return end
	nmsg_clone_fight.cg_exit_team( Socket.socketServer )
end

--队伍是否允许快速加入
function msg_clone_fight.cg_allow_quick_join( allow )
    --if not Socket.socketServer then return end
	nmsg_clone_fight.cg_allow_quick_join( Socket.socketServer,allow )
        msg_clone_fight.allow = allow;
end

--开始战斗
function msg_clone_fight.cg_begin_fight( )
    --app.log("cg_begin_fight############################")
    --if not Socket.socketServer then return end
        if not PublicFunc.lock_send_msg(msg_clone_fight.cg_begin_fight, 'msg_clone_fight.cg_begin_fight') then return end
	nmsg_clone_fight.cg_begin_fight( Socket.socketServer )
end

--结束战斗
function msg_clone_fight.cg_end_fight( iswin, use_time )
    --app.log("cg_end_fight####################")
    --if not Socket.socketServer then return end
	nmsg_clone_fight.cg_end_fight( Socket.socketServer ,iswin, use_time)
end

--结束战斗
function msg_clone_fight.cg_open_box( )
    --if not Socket.socketServer then return end
	nmsg_clone_fight.cg_open_box( Socket.socketServer )
end

function msg_clone_fight.cg_change_hero( roleDataId )
    --app.log("cg_change_hero###########################"..roleDataId)
    --if not Socket.socketServer then return end
	nmsg_clone_fight.cg_change_hero( Socket.socketServer ,roleDataId)
end

function msg_clone_fight.gc_change_hero( result,roleDataId )
    
    local show = PublicFunc.GetErrorString(result);
    if show then
       --app.log("change_hero###########################"..roleDataId)
       g_dataCenter.CloneBattle:setroleDataid(roleDataId)
       PublicFunc.msg_dispatch(msg_clone_fight.gc_change_hero,roleDataId)
    end
end

-- 返回数据
function msg_clone_fight.gc_get_challenge_hero( result,herolist )
    
    local show = PublicFunc.GetErrorString(result);
    if show then
       g_dataCenter.CloneBattle:setHerolist(herolist)
       --uiManager:PushUi(EUI.CloneBattleUI);
    end
end

--返回队伍信息
function msg_clone_fight.gc_get_team_info( TeamInfo )

    g_dataCenter.CloneBattle:SetTeamInfo(TeamInfo)
    --app.log("gc_get_team_info##########################"..table.tostring(TeamInfo))
    if string.len(TeamInfo.roomid) > 0 then
        local flag = g_dataCenter.CloneBattle:GetIsForce1()
        if flag then
            g_dataCenter.CloneBattle:EndGame1(false)
        else
            uiManager:PushUi(EUI.CloneBattleTeamUI);
        end
        --PublicFunc.msg_dispatch(msg_clone_fight.gc_get_team_info)
    else
        --msg_clone_fight.cg_get_challenge_hero()
        uiManager:PushUi(EUI.CloneBattleUI);
        --msg_clone_fight.cg_get_challenge_hero()
    end

end

--返回创建队伍
function msg_clone_fight.gc_create_team( result,TeamInfo )
    local show = PublicFunc.GetErrorString(result);
    if show then
        --app.log("gc_create_team##########################"..table.tostring(TeamInfo))
        --g_dataCenter.Institute:unLock( index )
        --PublicFunc.msg_dispatch(msg_clone_fight.gc_unLock_laboratory)
        g_dataCenter.CloneBattle:SetTeamInfo(TeamInfo)
        FloatTip.Float( "创建队伍成功" );
        uiManager:PopUi()
        uiManager:PushUi(EUI.CloneBattleTeamUI);
    end
end

--返回加入队伍
function msg_clone_fight.gc_join_team(result,TeamInfo)
    
    local show = PublicFunc.GetErrorString(result);
    if show then
        PublicFunc.msg_dispatch(msg_clone_fight.gc_train)
    end
end

--返回快速加入
function msg_clone_fight.gc_quick_join(result,TeamInfo)
    
    --app.log("gc_quick_join##########################"..table.tostring(TeamInfo))
    local show = PublicFunc.GetErrorString(result);
    if show then
        g_dataCenter.CloneBattle:SetTeamInfo(TeamInfo)
        if #TeamInfo.members == 1 then
            FloatTip.Float( "创建队伍成功" );
        else
            FloatTip.Float( "加入队伍成功" );
        end
        
        uiManager:PopUi()
        uiManager:PushUi(EUI.CloneBattleTeamUI);  
    end
end

--返回离开队伍
function msg_clone_fight.gc_exit_team(result)
    
    local show = PublicFunc.GetErrorString(result);
    if show then
        uiManager:PopUi()
        uiManager:PushUi(EUI.CloneBattleUI);
    end
    
    GLoading.Hide(GLoading.EType.msg)
end

--返回快速加入开关
function msg_clone_fight.gc_allow_quick_join(result)
    
    local show = PublicFunc.GetErrorString(result);
    if show then
        --app.log("allow is#################"..tostring(msg_clone_fight.allow))
        g_dataCenter.CloneBattle:setQuickJoin(msg_clone_fight.allow)
    end
end

--返回开始战斗
function msg_clone_fight.gc_begin_fight(result,monstersid,otherRoles)
    --app.log("gc_begin_fight#########################")
    PublicFunc.unlock_send_msg(msg_clone_fight.cg_begin_fight, 'msg_clone_fight.cg_begin_fight')
    local show = PublicFunc.GetErrorString(result);
    if show then
        --msg_clone_fight.cg_end_fight( 1 )
        g_dataCenter.CloneBattle:BeginFight(monstersid,otherRoles)   
    end
    GLoading.Hide(GLoading.EType.msg)
end

--返回结束战斗
function msg_clone_fight.gc_end_fight(result, isWin)
    local show = PublicFunc.GetErrorString(result);
    if show then
        local flag = g_dataCenter.CloneBattle:GetIsForce()
        if flag then
            FightScene.ExitFightScene()
            g_dataCenter.CloneBattle:EndGame(false)
        else
            --中途退出
            if isWin == -1 then
                SceneManager.PopScene()
            --赢
            elseif isWin > 0 then
                uiManager:PushUi(EUI.CloneAreward);
            --输
            else
                --失败弹出失败界面
                local callback = function()
                    SceneManager.PopScene()
                --ChurchBotTip:DestroyUi()
                end 
                
                CommonLeave.Start({ENUM.ELeaveType.PlayerLevelUp, ENUM.ELeaveType.EquipLevelUp, ENUM.ELeaveType.HeroEgg})
                CommonLeave.SetFinishCallback(callback,nil)
                --SceneManager.PopScene()
            end
        end
    end
end

function msg_clone_fight.gc_update_team(teamInfo)
    --app.log("gc_update_team#########################"..table.tostring(teamInfo))
    g_dataCenter.CloneBattle:SetTeamInfo(teamInfo)
    PublicFunc.msg_dispatch(msg_clone_fight.gc_update_team)
end

--返回开箱子
function msg_clone_fight.gc_open_box(result,rewards)
    --app.log("gc_open_box#######################"..table.tostring(rewards))
    local show = PublicFunc.GetErrorString(result);
    GLoading.Hide(GLoading.EType.msg)
    if show then
        g_dataCenter.CloneBattle:setrewardlist(rewards)
        PublicFunc.msg_dispatch(msg_clone_fight.gc_open_box)
    end
end

function msg_clone_fight.cg_notice_partener_finish_challenge(teamInfo)
    --if not Socket.socketServer then return end
	nmsg_clone_fight.cg_notice_partener_finish_challenge( Socket.socketServer )
end

function msg_clone_fight.gc_notice_partener_finish_challenge(result)
    local show = PublicFunc.GetErrorString(result);
    
    if show then
        --app.log("gc_notice_partener_finish_challenge")
        FloatTip.Float( "已经成功通知队友" );
    end
end

function msg_clone_fight.gc_sync_room_summery(FinishTimes, teamMemberCount)
    --app.log("CloneFristData###########################")
    g_dataCenter.CloneBattle:CloneFristData(FinishTimes,teamMemberCount)
end


return msg_clone_fight;
