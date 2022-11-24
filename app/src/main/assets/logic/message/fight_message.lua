--[[
region fight_message.lua
date: 2015-9-30
time: 17:31:47
author: Nation
]]
msg_fight = msg_fight or {}

local function _3v3DataCenter()
    return g_dataCenter.activity[MsgEnum.eactivity_time.eActivityTime_threeToThree];
end

function msg_fight.gc_use_skill(info)
    --app.log("使用技能..user_gid="..info.user_gid.." skill_id="..info.skill_id.." default_target_gid="..info.default_target_gid.." targets_key="..info.targets_key.." targets_gid="..table.tostring(info.targets_gid))
    local user = ObjectManager.GetObjectByGID(info.user_gid)
    if user then
        user:OnRecUseSkillMessage(info)
    end
end

function msg_fight.gc_show_calculate_value(user_gid, target_gid, value, crit, cur_hp, skill_id)
    local target = ObjectManager.GetObjectByGID(target_gid)
    if target then
        local attackEntity = ObjectManager.GetObjectByGID(user_gid);
        target:SetProperty(ENUM.EHeroAttribute.cur_hp, cur_hp)
        if value ~= 0 then
            local skill_info = ConfigManager.Get(EConfigIndex.t_skill_info, skill_id)

            --跟自己相关 TODO:server不下发
            if target:GetHeadInfoControler():Check(attackEntity) then
                target:GetHeadInfoControler():ShowHP(value, crit,(skill_info and (skill_info.type ~= eSkillType.Normal) or false))
            end

        end
        if value < 0 then
            if attackEntity then
                target._AttackerName = attackEntity:GetName()
            end
            if user_gid ~= target_gid then
                target:OnHitted()
            end

            --显示连击数
            if attackEntity and FightManager.GetMyCaptain() == attackEntity --[[attackEntity:IsMyControl()]] then
                HeadInfoControler.ShowCombo()
            end
        end

        --如果被攻击者是基地且是本方阵营  就给提示
        if target:IsBasis() and not target:IsEnemy() then
            GetMainUI():InitTips(nil, 1);
        end

        --boss显示的血条
      
       
        if attackEntity then
            if value < 0 then
                target:CallBeAttackedCallbackFunc(attackEntity)                
                --怪物伤血的血条放到各自的manager中处理
                FightScene.GetFightManager():MonsterBloodReduce(target, attackEntity);
            end
            -- if attackEntity:IsMyControl() then
            --     if value < 0 and target:IsBoss() then
            --         GetMainUI():InitBosshp(2, target:GetName());
            --     end
            -- end
            if cur_hp == 0 then
                target:SetKillerName(attackEntity:GetName())
            end
        end
        
        if value < 0 then
            if attackEntity then
                attackEntity.mmo_fight_state_begin_time = PublicFunc.QueryCurTime()
            end
            if target then
                target.mmo_fight_state_begin_time = PublicFunc.QueryCurTime()
            end
        end

        if target:IsMyControl() then
            if cur_hp == 0 then
                target._buffManager:CheckRemove(eBuffPropertyType.RemoveOnDead)
                target:SetHandleState(EHandleState.Die)
                app.log_warning("my control dead "..target.name)
                if target:GetName() == g_dataCenter.fight_info:GetCaptainName() and FightScene.GetPlayMethodType() == MsgEnum.eactivity_time.eActivityTime_openWorld then
                    g_dataCenter.player:ChangeFightMode(false)
                end
            end
            GetMainUI():UpdateHeadData();
        else
            if cur_hp == 0 then
                target._buffManager:CheckRemove(eBuffPropertyType.RemoveOnDead)
                target:SetState(ESTATE.Die)
            end
        end

        if cur_hp == 0 and attackEntity and (attackEntity:IsMyControl() or attackEntity:IsAIAgent())then
            attackEntity:SetAttackTarget(nil)
            --app.log("name="..attackEntity:GetName().." id="..tostring(attackEntity:GetBuffManager()._killTargetAddBuffID).." lv="..tostring(attackEntity:GetBuffManager()._killTargetAddBuffLv).." skillid="..tostring(attackEntity:GetBuffManager()._killTargetAddBuffSkillID).." skill="..skill_id)
            if attackEntity:GetBuffManager()._killTargetAddBuffID and attackEntity:GetBuffManager()._killTargetAddBuffLv then
                if attackEntity:GetBuffManager()._killTargetAddBuffSkillID == nil or attackEntity:GetBuffManager()._killTargetAddBuffSkillID == skill_id then
                    local buffID = attackEntity:GetBuffManager()._killTargetAddBuffID
                    local buffLv = attackEntity:GetBuffManager()._killTargetAddBuffLv
                    local overlap = 1
                    if target:IsHero() then
                        overlap = attackEntity:GetBuffManager()._killTargetHeroAddBuffOverLap
                    elseif target:IsBoss() then
                        overlap = attackEntity:GetBuffManager()._killTargetBossAddBuffOverLap
                    else
                        overlap = attackEntity:GetBuffManager()._killTargetNotBossAddBuffOverLap
                    end
                    
                    attackEntity:AttachBuff(buffID, buffLv, attackEntity.name, attackEntity.name, nil, 0, nil, 0, 0, 0, nil, nil, false, overlap)
                end
            end
        end
        if attackEntity and attackEntity:IsMyControl() then
            GAddWorldBossAttack();
        end
--        if crit and attackEntity and attackEntity:IsMyControl() then
--            target:GetHeadInfoControler():ShowCrit()
--        end
    end
end

function msg_fight.gc_show_calculate_value_multi(msg_list)
   -- app.log_warning("gc_show_calculate_value_multi. cnt:"..table.getn(msg_list))
    for i=1,table.getn(msg_list) do
        local msg = msg_list[i]
        if msg then
            msg_fight.gc_show_calculate_value(msg.user_gid, msg.target_gid, msg.value, msg.crit, msg.cur_hp, msg.skill_id)
        end
    end
end

function msg_fight.gc_sync_skill_targets(info)
    --app.log("技能目标..user_gid="..info.user_gid.." targets_key="..info.targets_key.." targets_gid="..table.tostring(info.targets_gid))
    FightScene.AddSkillTargets(info.user_gid, info.skill_id, info.buff_id, info.trigger_index, info.action_index, info.action_ref, info.targets_gid)
end

function msg_fight.gc_cancel_skill(user_gid, skill_id)
    local user = ObjectManager.GetObjectByGID(user_gid)
    if user then
        user:OnRecCancelSkillMessage(skill_id)
    end
end

function msg_fight.gc_sync_ability(target_gid, ability_type, value)
    local target = ObjectManager.GetObjectByGID(target_gid)
    if target then
        local real_type = ability_type+1+ENUM.min_property_id
        target:SetPropertyFromServer(real_type, value)
    end
end

function msg_fight.gc_change_ai_agent(target_gid, bind)
    local target = ObjectManager.GetObjectByGID(target_gid)
    if target then
        if bind then
            if not g_dataCenter.fight_info.ai_agent_target_gid[target_gid] then
                target:EnableBehavior(true)
                target:KeepNormalAttack(true)
                FightScene.BeginAIAgentKeepAlive()
                g_dataCenter.fight_info.ai_agent_target_gid[target_gid] = target_gid
            end
        else
            g_dataCenter.fight_info.ai_agent_target_gid[target_gid] = nil
            target:EnableBehavior(false)
            target:KeepNormalAttack(false)
            if Utility.getTableEntityCnt(g_dataCenter.fight_info.ai_agent_target_gid) == 0 then
                FightScene.StopAIAgentKeepAlive()
            end
            target:SetAI(115)
        end
    else
        if bind then
            app.log("找不到AI代理的目标")
        end
    end
    --[[if target then
        if bind then
            app.log("成为"..target.name.."的AI代理")
        else
            app.log("取消"..target.name.."的AI代理")
        end
    else
        if bind then
            app.log("成为"..target_gid.."的AI代理")
        else
            app.log("取消"..target_gid.."的AI代理")
        end
    end]]
end

function msg_fight.gc_sync_aperture_pos(user_gid, x, y, z)
    local user = ObjectManager.GetObjectByGID(user_gid)
    if user and user.aperture_manager then
        user.aperture_manager.syncRTPosition = {}
        user.aperture_manager.syncRTPosition.x = x
        user.aperture_manager.syncRTPosition.z = z
        user.aperture_manager.syncRTPosition.y = y
    end
end

function msg_fight.gc_change_obj_gid(old_gid, new_gid)
    ObjectManager.ChangeObjectGID(old_gid, new_gid)
end


-- 倒计时间通知
function msg_fight.gc_sync_fight_last_time(last_time)
    if not FightScene.GetStartUpEnv() then return end
    

    FightScene.GetFightManager():SynFightLastTime(last_time);
end

function msg_fight.gc_add_buff(target_gid, buff_id, buff_lv, user_gid, skill_id, skill_lv, action_odds)
    local target = ObjectManager.GetObjectByGID(target_gid)
    if target then
        local skill_creator = target:GetName()
        local buff_creator = target:GetName()
        if user_gid then
            local user = ObjectManager.GetObjectByGID(user_gid)
            if user then
                skill_creator = user:GetName()
                buff_creator = user:GetName()
            end
        end
        target:AttachBuff(buff_id, buff_lv, skill_creator, buff_creator, nil, 0, nil, 0, skill_id, skill_lv, nil, nil, false, nil, action_odds)
    end
end

function msg_fight.gc_del_buff(target_gid, buff_id, buff_lv)
    local target = ObjectManager.GetObjectByGID(target_gid)
    if target then
        target:DetachBuff(buff_id, buff_lv, true)
    end
end
-------------------------------------------------------------------
function msg_fight.cg_use_skill(skill_use_info,skill_cd_type)
    --if not Socket.socketServer then return end
    nmsg_fight.cg_use_skill(Socket.socketServer, skill_use_info,skill_cd_type)
end

function msg_fight.cg_skill_calculate(info)
    --if not Socket.socketServer then return end
    nmsg_fight.cg_skill_calculate(Socket.socketServer, info)
    --暂时屏蔽拼包，发送顺序会导致计算错误

    --[[table.insert(FightScene.msg_skill_calculate_list,
        {user_gid=user_gid, 
        target_gid=target_gid, 
        skill_id=skill_id, 
        skill_type=skill_type, 
        calc_type=calc_type, 
        calc_info_index=calc_info_index,
        ex_persent=ex_persent})]]

    -- app.log("cg_skill_calculate-----"..table.tostring(FightScene.msg_skill_calculate_list))
end

function msg_fight.cg_skill_calculate_multi(msg_list)
    --if not Socket.socketServer then return end
    nmsg_fight.cg_skill_calculate_multi(Socket.socketServer, msg_list)
end

function msg_fight.cg_sync_skill_targets(skill_targets_info)
    --if not Socket.socketServer then return end
    nmsg_fight.cg_sync_skill_targets(Socket.socketServer, skill_targets_info)
end

function msg_fight.cg_cancel_skill(user_gid, skill_id)
    --if not Socket.socketServer then return end
    nmsg_fight.cg_cancel_skill(Socket.socketServer, user_gid, skill_id)
end

function msg_fight.cg_scale_ability(user_gid, target_gid, ability_type, scale, change, multiply, last_time, record_name)
    --if not Socket.socketServer then return end
    nmsg_fight.cg_scale_ability(Socket.socketServer, user_gid, target_gid, ability_type, scale, change, multiply, last_time, record_name)
end

function msg_fight.cg_change_ability(user_gid, target_gid, ability_type, value, change, last_time, record_name, add_scale)
    --if not Socket.socketServer then return end
    nmsg_fight.cg_change_ability(Socket.socketServer, user_gid, target_gid, ability_type, value, change, last_time, record_name, add_scale)
end

function msg_fight.cg_scale_hp_recover(target_gid, scale, change, last_time)
    --if not Socket.socketServer then return end
    nmsg_fight.cg_scale_hp_recover(Socket.socketServer, target_gid, scale, change, last_time)
end

function msg_fight.cg_ai_agent_keep_alive(target_gid)
    --if not Socket.socketServer then return end
    nmsg_fight.cg_ai_agent_keep_alive(Socket.socketServer, target_gid)
end

function msg_fight.cg_sync_aperture_pos(user_gid, x, y, z)
    --if not Socket.socketServer then return end
    nmsg_fight.cg_sync_aperture_pos(Socket.socketServer, user_gid, x, y, z)
end

function msg_fight.cg_trigger_world_item(item_gid, user_gid, is_begin_trigger)
    --if not Socket.socketServer then return end
    nmsg_fight.cg_trigger_world_item(Socket.socketServer, item_gid, user_gid, is_begin_trigger)
end

function msg_fight.cg_change_fight_extra_property(target_gid, change, type, info, last_time)
    --if not Socket.socketServer then return end
    nmsg_fight.cg_change_fight_extra_property(Socket.socketServer, target_gid, change, type, info, last_time)
end

function msg_fight.cg_start_skill_cd(user_gid, skill_id)
    --if not Socket.socketServer then return end
    nmsg_fight.cg_start_skill_cd(Socket.socketServer, user_gid, skill_id)
end

function msg_fight.cg_stop_skill_cd(user_gid, skill_id, cd_value, cd_type)
    --if not Socket.socketServer then return end
    nmsg_fight.cg_stop_skill_cd(Socket.socketServer, user_gid, skill_id, cd_value, cd_type)
end

function msg_fight.cg_relive_follow_hero(captain_gid)
    --if not Socket.socketServer then return end
    nmsg_fight.cg_relive_follow_hero(Socket.socketServer, captain_gid)
end

function msg_fight.cg_create_world_item(user_gid, id, x, y, last_time)
    --if not Socket.socketServer then return end
    nmsg_fight.cg_create_world_item(Socket.socketServer, user_gid, id, x, y, last_time)
end

function msg_fight.cg_del_world_item(user_gid, id, x, y, last_time)
    --if not Socket.socketServer then return end
    nmsg_fight.cg_del_world_item(Socket.socketServer, user_gid, id, x, y, last_time)
end

function msg_fight.cg_add_buff(user_gid, target_gid, buff_id, buff_lv, skill_id, skill_lv)
    --if not Socket.socketServer then return end
    nmsg_fight.cg_add_buff(Socket.socketServer, user_gid, target_gid, buff_id, buff_lv, skill_id, skill_lv)
end

-- //ret:见EReliveFollowHeroState
function msg_fight.gc_relive_follow_hero_state(ret)
    --if not Socket.socketServer then return end

    -- app.log('cg_relive_follow_hero=========== ' .. tostring(ret))
    PublicFunc.msg_dispatch(msg_fight.gc_relive_follow_hero_state, ret)
end

function msg_fight.cg_sync_taunt_target(user_gid, target_gid, last_time, buff_id, buff_lv, bStart)
    --if not Socket.socketServer then return end
    nmsg_fight.cg_sync_taunt_target(Socket.socketServer, user_gid, target_gid, last_time, buff_id, buff_lv, bStart)
end

function msg_fight.gc_sync_taunt_target(user_gid, target_gid, buff_id, buff_lv)
    local obj = ObjectManager.GetObjectByGID(user_gid)
    if obj and (obj:IsMyControl() or obj:IsAIAgent()) then
        if target_gid == 0 then
            if obj:GetBuffManager()._tauntTarget then
                obj:DetachBuff(obj:GetBuffManager()._tauntBuffID, obj:GetBuffManager()._tauntBuffLv, false)
                local tauntTarget = ObjectManager.GetObjectByGID(obj:GetBuffManager()._tauntTarget)
                if tauntTarget then
                    tauntTarget.taunt_list[user_gid] = nil
                end
            end
            obj:GetBuffManager()._tauntTarget = nil
        else
            obj:GetBuffManager()._tauntTarget = target_gid
            obj:GetBuffManager()._tauntBuffID = buff_id
            obj:GetBuffManager()._tauntBuffLv = buff_lv
            local tauntTarget = ObjectManager.GetObjectByGID(obj:GetBuffManager()._tauntTarget)
            if tauntTarget then
                tauntTarget.taunt_list[user_gid] = 1
            end
        end
        if obj:GetBuffManager()._tauntTarget then
            obj:PostEvent("BeTaunt")
        else
            obj:PostEvent("FinishBeTaunt")
        end
    end
end

function msg_fight.gc_sync_kidnap_target(user_gid, target_gid, type, bChange)
    local obj = ObjectManager.GetObjectByGID(target_gid)
    if obj  then
        if bChange then
            --app.log("收到开始抓取消息")
            obj:KidnapByGID(user_gid, type)
        else
            --app.log("收到停止抓取消息")
            obj:KidnapByGID()
        end
    end
end

function msg_fight.cg_change_absorb_damage(target_gid, start, skill_id, type, value, src_buff_id, src_buff_lv, user_gid, broken_buff_id, broken_buff_lv, last_time)
    --if not Socket.socketServer then return end
    nmsg_fight.cg_change_absorb_damage(Socket.socketServer, target_gid, start, skill_id, type, value, src_buff_id, src_buff_lv, user_gid, broken_buff_id, broken_buff_lv, last_time)
end

--MMO立即复活
function msg_fight.cg_hero_relive_immediately()
    --if not Socket.socketServer then return end
    nmsg_fight.cg_hero_relive_immediately(Socket.socketServer);
end

--MMO立即复活
function msg_fight.gc_hero_relive_immediately(result)
    PublicFunc.msg_dispatch(msg_fight.gc_hero_relive_immediately, result)
end

--飘战斗美术字
function msg_fight.gc_show_artistic_text(target_gid, type)
    local obj = ObjectManager.GetObjectByGID(target_gid)
    if obj then
        obj:GetHeadInfoControler():ShowArtisticText(type)
    end
end

--开始场景道具触发计时
function msg_fight.gc_trigger_world_item_delay(item_gid)
    PublicFunc.msg_dispatch(msg_fight.gc_trigger_world_item_delay, item_gid)
end

--打断场景道具触发计时
function msg_fight.gc_break_trigger_world_item_delay(item_gid)
    PublicFunc.msg_dispatch(msg_fight.gc_break_trigger_world_item_delay, item_gid)
end

--成功打开场景计时道具
function msg_fight.gc_success_trigger_world_delay_item(item_gid)
    PublicFunc.msg_dispatch(msg_fight.gc_success_trigger_world_delay_item, item_gid)
end

--播放宝箱打开动画
function msg_fight.gc_play_treasure_box_open_anim(item_gid)
    local obj = ObjectManager.GetObjectByGID(item_gid)
    if obj then
        GetMainUI():GetWorldTreasureBox():on_out_treasure_box(obj);
        obj.is_item_open = true
        obj:PlayAnimate(EANI.die)
    end
end

function msg_fight.cg_server_search_and_calculate(user_gid,skill_id,calc_type,calc_info_index,ex_persent,x,y,target_type,radius,length,width,dx,dz,buffid,bufflv)
    --if not Socket.socketServer then return end
    nmsg_fight.cg_server_search_and_calculate(Socket.socketServer, user_gid,skill_id,calc_type,calc_info_index,ex_persent,x,y,target_type,radius,length,width,dx,dz,buffid,bufflv)
end

function msg_fight.gc_sync_world_boss_rank_info(info)
    g_dataCenter.worldBoss:SaveRankInfo(info);
end

function msg_fight.gc_sync_world_boss_rt_info(bossInfo)
    --local clsMinimap = nil 
    if  GetMainUI() then
        clsMinimap = GetMainUI():GetMinimap();
    else
        return
    end
    for i=1, #bossInfo do
        if clsMinimap and clsMinimap.UpdateBossPos then
            clsMinimap:UpdateBossPos(bossInfo[i].boss_gid, bossInfo[i].boss_config_id, bossInfo[i].x*PublicStruct.Coordinate_Scale_Decimal, bossInfo[i].y*PublicStruct.Coordinate_Scale_Decimal, bossInfo[i].state);
        end
            g_dataCenter.worldBoss:SetBossSyncInfo( bossInfo[i].boss_gid, bossInfo[i].boss_config_id, bossInfo[i].x*PublicStruct.Coordinate_Scale_Decimal, bossInfo[i].y*PublicStruct.Coordinate_Scale_Decimal, bossInfo[i].state );
    end
        if GetMainUI() and GetMainUI():GetBossHeartHP() then
            GetMainUI():GetBossHeartHP():UpdateBossInfo( {bossInfo} );
        end
--  if BigMap.UpdateBossPos then
--      BigMap.UpdateBossPos(gid, boss_id, x*PublicStruct.Coordinate_Scale_Decimal, y*PublicStruct.Coordinate_Scale_Decimal, state);
--  end
   
end

function msg_fight.gc_sync_world_boss_player_damage(singleDamage, damage)
    g_dataCenter.worldBoss:SetDemage(damage, singleDamage);
end

--[世界宝箱]同步下一波宝箱刷新时间
function msg_fight.gc_sync_world_treasure_box_next_step_box_born_cd(seconds)
    g_dataCenter.worldTreasureBox:SetNextStepBoxBornCD(seconds)
    PublicFunc.msg_dispatch(msg_fight.gc_sync_world_treasure_box_next_step_box_born_cd)
end

--[世界宝箱]同步宝箱的数量
function msg_fight.gc_sync_world_treasure_box_num(smalBoxCnt, bigBoxCnt)
    g_dataCenter.worldTreasureBox:SetTreasureBoxNum(smalBoxCnt, bigBoxCnt)
    PublicFunc.msg_dispatch(msg_fight.gc_sync_world_treasure_box_num)
end

--[世界宝箱]某人正在打开神秘宝箱
function msg_fight.gc_somebody_try_open_mysterious_treasure_box(name, country_id)
    local country_name = ConfigManager.Get(EConfigIndex.t_country_info, country_id).name;
    FloatTip.Float(tostring(country_name).."."..name.."正在开启神秘宝箱")
end

--[世界宝箱]同步积分排名
function msg_fight.gc_sync_world_treasure_box_point_rank(rank_info, open_mysterious_box_country)
    g_dataCenter.worldTreasureBox:SetPointRankInfo(rank_info, open_mysterious_box_country)
    PublicFunc.msg_dispatch(msg_fight.gc_sync_world_treasure_box_point_rank)
end

--[世界宝箱]同步神秘宝箱信息
function msg_fight.gc_sync_mysterious_treasure_box_info(seconds, x, y)
    g_dataCenter.worldTreasureBox:SetMyteriousTreasureBoxInfo(seconds, x, y)
    PublicFunc.msg_dispatch(msg_fight.gc_sync_mysterious_treasure_box_info)
end

--[世界宝箱]同步个人相关信息
function msg_fight.gc_sync_world_treasure_box_player_info(openSmallBoxCnt, openBigBoxCnt, killEnemyCnt, points, reliveTimes)
    g_dataCenter.worldTreasureBox:SetPlayerInfo(openSmallBoxCnt, openBigBoxCnt, killEnemyCnt, points, reliveTimes)
    PublicFunc.msg_dispatch(msg_fight.gc_sync_world_treasure_box_player_info)
end

--[世界宝箱]打开复活面板
function msg_fight.gc_open_treasure_box_relive_panel(seconds, killer_type, killer_param1, killer_param2)
    g_dataCenter.worldTreasureBox:OpenTreasureBoxRelivePanel(seconds, killer_type, killer_param1, killer_param2)
end

--[世界宝箱]神秘宝箱冷却中
function msg_fight.gc_mysterious_treasure_box_not_free()
    FloatTip.Float(gs_string_world_treasure_box["mysterious_treasure_box_not_free"])
end

--[世界宝箱]开启数量达到上限
function msg_fight.gc_open_treasure_box_limit()
    FloatTip.Float(gs_string_world_treasure_box["open_treasure_box_limit"])
end

--[3v3]场景中击杀显示
function msg_fight.gc_three_to_three_update_killinfo(info)
--    app.log("===3v3=== gc_three_to_three_update_killinfo : "..table.tostring(info))
    _3v3DataCenter():gc_update_killinfo(info);
    PublicFunc.msg_dispatch(msg_fight.gc_update_killinfo, info);
end
--[3v3]同步3v3魂值
function msg_fight.gc_three_to_three_update_soul_value(leftSoulValue, rightSoulValue, killInfoList)
    -- app.log("===3v3=== gc_three_to_three_update_soul_value : "..table.tostring(killInfoList))
    _3v3DataCenter():gc_update_soul_value(leftSoulValue, rightSoulValue, killInfoList);
end

function msg_fight.cg_calculate_extra_damage_pool(user_gid, skill_id, multi_cnt, calc_info_index, target_cnt)
    --if not Socket.socketServer then return end
    nmsg_fight.cg_calculate_extra_damage_pool(Socket.socketServer, user_gid, skill_id, multi_cnt, calc_info_index, target_cnt)
end

function msg_fight.cg_clear_extra_damage_pool(user_gid)
    --if not Socket.socketServer then return end
    nmsg_fight.cg_clear_extra_damage_pool(Socket.socketServer, user_gid)
end

function msg_fight.cg_lock_property_change_record(user_gid, record_name, lock)
    --if not Socket.socketServer then return end
    nmsg_fight.cg_lock_property_change_record(Socket.socketServer, user_gid, record_name, lock)
end
-- 大乱斗
-- 更新战斗过程数据
-- struct daluandou_kill_data
-- {
    -- string playerid;
    -- uint fighter_gid;
    -- int deadTimes;
    -- int killPlayerCnt;
    -- int continuousKillPlayerCnt;
    -- int surviveTime;     //存活时间
-- }
function msg_fight.gc_update_fighter_kill_data(vecKilldata)
    g_dataCenter.fuzion2:UpdateFighterKillData(vecKilldata)
end
function msg_fight.cg_cancel_daluandou_fight(roomid)
    --if not Socket.socketServer then return end
    nmsg_fight.cg_cancel_daluandou_fight(Socket.socketServer, roomid)
end

function msg_fight.cg_absorb_ability_to_creator(user_gid, target_gid, change, target_ability_type, scale, user_ability_type, max_user_scale, sequence)
    --if not Socket.socketServer then return end
    nmsg_fight.cg_absorb_ability_to_creator(Socket.socketServer, user_gid, target_gid, change, target_ability_type, scale, user_ability_type, max_user_scale, sequence);
end

function msg_fight.gc_sync_world_boss_inspire_times(inspire_times)
    g_dataCenter.worldBoss:SetInsprireTimes(inspire_times);
end

function msg_fight.cg_change_front_scale_damage(user_gid, skill_id, change, scale, value, value_type, last_time)
    --if not Socket.socketServer then return end
    nmsg_fight.cg_change_front_scale_damage(Socket.socketServer, user_gid, skill_id, change, scale, value, value_type, last_time)
end

--改变角速度
function msg_fight.cg_change_angular_velocity(target_gid, value, last_time, dirx, dirz, change)
    --if not Socket.socketServer then return end
    nmsg_fight.cg_change_angular_velocity(Socket.socketServer, target_gid, value, last_time, dirx, dirz, change)
end

function msg_fight.gc_change_angular_velocity(target_gid, value, dirx, dirz)
    local entity = ObjectManager.GetObjectByGID(target_gid)
    if entity then
        entity:SetAngularSpeed(value);
        entity:GetObject():set_forward(dirx, 0, dirz)
    end
end
-- //[社团BOSS]同步即时伤害排名信息
function msg_fight.gc_sync_guild_boss_rt_damage_rank(info)
    g_dataCenter.guildBoss:SetCurGuildBossRank(info);
end
-- //[社团BOSS]同步自己的排名和伤害
function msg_fight.gc_sync_guild_boss_player_damage(damage, rank)
    g_dataCenter.guildBoss:SetDamage(damage, rank);
end

-- [社团BOSS]同步当前的BUFF效果
function msg_fight.gc_sync_guild_boss_buy_buff_property(property)
    g_dataCenter.guildBoss:SetCurrentAddBuff(property);
    PublicFunc.msg_dispatch(msg_fight.gc_sync_guild_boss_buy_buff_property, property)
end

-- [社团BOSS]同步人数BUFF触发状态
function msg_fight.gc_sync_group_damage_scale_state(active)
    g_dataCenter.guildBoss:SetGroupDamageScaleState(active);
    PublicFunc.msg_dispatch(msg_fight.gc_sync_group_damage_scale_state, active)
end

-- //[社团BOSS]战斗结算
-- //type 1:击杀结算 2:时间限制 主动退出 全部死亡 3:每日更新
function msg_fight.gc_guild_boss_fight_report(type, boss_index, is_first_pass, is_killer, damage)
    app.log("#lhf#{type, boss_index, is_first_pass, is_killer}:"..table.tostring({type, boss_index, is_first_pass, is_killer}));
    local bossList = ConfigManager._GetConfigTable(EConfigIndex.t_guild_boss_monster);
    CommonAwardGuildBoss.Start(type, boss_index, is_first_pass, is_killer, damage);
    if type~=1 or boss_index == #bossList then
        CommonAwardGuildBoss.SetFinishCallback(function ()
                                                    FightScene.OnFightOver()
                                                    FightScene.ExitFightScene();
                                                    msg_guild_boss.cg_leave_guild_boss(false);
                                                end);
    end
    PublicFunc.msg_dispatch(msg_fight.gc_guild_boss_fight_report, type, boss_index, is_first_pass, is_killer)
end
-- //[社团BOSS]单队伍英雄死完
function msg_fight.gc_guild_boss_sigle_team_dead()
    for i=1,3 do
        local name = g_dataCenter.fight_info:GetControlHeroName(i);
        if name then
            FightScene.DeleteObj(name, 0);
        end
    end
    g_dataCenter.fight_info.control_hero_list = {};
    g_dataCenter.fight_info.captain_index = nil;
    FightScene.GetFightManager().hero_index = 0;
end

-- //[世界BOSS]战斗结算
function msg_fight.gc_world_boss_fight_report(damage)
    CommonAwardWroldBoss.Start(damage);
    CommonAwardWroldBoss.SetFinishCallback(function ()
                                            FightScene.OnFightOver()
                                            FightScene.ExitFightScene();
                                            end);
end

-- //[世界BOSS]世界BOSS被击杀
function msg_fight.gc_world_boss_killed(killer_name)
    if GetMainUI() and GetMainUI():GetWorldBossRank() then
        GetMainUI():GetWorldBossRank():SetReviveUI(20, killer_name);
    end
    if GetMainUI() and GetMainUI():GetBossHeartHP() then
        GetMainUI():GetBossHeartHP():UpdateBossInfo();
    end
end

-- //[世界BOSS]世界BOSS幸运一击
function msg_fight.gc_world_boss_luck_attack()
    GAddWorldBossLuckAttack();
    if FightManager.GetMyCaptain() and FightManager.GetMyCaptain():GetHeadInfoControler() then
        FightManager.GetMyCaptain():GetHeadInfoControler():ShowArtisticText(ENUM.EHeadInfoShowType.LuckAttack);
    end
end

--[[1v1单局结束]]
function msg_fight.gc_chat_1v1_round_end(roundIndex, winerid)
    local round = roundIndex + 1
    g_dataCenter.chatFight:SyncRoundResult(round, winerid)
    PublicFunc.msg_dispatch(msg_fight.gc_chat_1v1_round_end, round)
end

function msg_fight.gc_chat_1v1_player_return(vecWinerid)
    for k, v in ipairs(vecWinerid) do
        g_dataCenter.chatFight:SyncRoundResult(k, v)
    end
end

function msg_fight.gc_daluandou2_sync_refresh_buff_monster_data(vecRefreshData)
    PublicFunc.msg_dispatch(msg_fight.gc_daluandou2_sync_refresh_buff_monster_data, vecRefreshData)
end