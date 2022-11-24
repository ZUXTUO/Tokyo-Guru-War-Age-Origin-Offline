
ActivityReward = Class("ActivityReward")

function ActivityReward:Init()
	self:initData();    
end

function ActivityReward:initData() 
    -- »î¶¯×´Ì¬£¨ÊÇ·ñ¿ªÆô£¬ ¿ªÊ¼¼°½áÊøÊ±¼ä£©
    self.state = nil
    -- »î¶¯id
    self.loginID = MsgEnum.eactivity_time.eActivityTime_loginReward
    self.hurdleID = MsgEnum.eactivity_time.eActivityTime_hurdleReward

    -- µÇÂ¼½±ÀøÅäÖÃ
    self.rewardConfig = {}
    self.rewardConfig[self.loginID] = {}
    self.rewardConfig[self.hurdleID] = {}
    -- ÊÇ·ñ³õÊ¼»¯ÅäÖÃ
    self.iniConfig = {}
    self.iniConfig[self.loginID]  = false
    self.iniConfig[self.hurdleID] = false

    self.m_is_month_card = false;
    self.m_is_sign_30_red = false;

    self.m_is_level_fund_all = 0;

    -------------- 
    self.m_vec_activity_time = {};

    self.m_is_buy_1 = 0;

    self.m_red_point_states = {};

    self.m_subscribe_state = 0;
    self.m_subscribe_state_list = {};

    self.exchange_item_config = {}
    self.exchange_item_states = nil
    self.vip_bag_buy_states = nil

    self.allServerBuyStates = {}

    self.vending_machine_states = {}
    self:InitScoreHero()
    self:InitGoldenEgg()

    self:initGmConfig()
    self:InitVendingMachineConfig()
    
    self.is_login_data = false;

    self.m_TargetList = {};
end

function ActivityReward:SetTargetData( begin_time, end_time, data, activity_id )
    if not self.m_TargetList[activity_id] then
        self.m_TargetList[activity_id] = {};
    end
    self.m_TargetList[activity_id].begin_time = begin_time;
    self.m_TargetList[activity_id].end_time = end_time;
    self.m_TargetList[activity_id].data = data;
end

function ActivityReward:GetTargetData( activity_id )
    local targetData = self.m_TargetList[activity_id];
    local result = false;
    if targetData and #targetData.data > 0 then
        result = true;
    end
    return result, targetData;
end

function ActivityReward:GetisLoginData( )
    return self.is_login_data;
end

function ActivityReward:SetBuy1State( state )
    self.m_is_buy_1 = state;
end

function ActivityReward:GetBuy1State( )
    return self.m_is_buy_1;
end

function ActivityReward:SetLevelFundAll( state )
    self.m_is_level_fund_all = state;
end

function ActivityReward:GetLevelFundAll( )
    return self.m_is_level_fund_all;
end

-- ³äÖµ£¬´óÐ¡ÔÂ¿¨
function ActivityReward:SetMonthCard( state )
    self.m_is_month_card = state;  
end

function ActivityReward:GetMonthCard( )
    return self.m_is_month_card;
end

-- 30ÈÕÇ©µ½
function ActivityReward:SetSignIn30RedPoint( state )
    self.m_is_sign_30_red = state;
--    app.log("m_is_sign_30_red:" .. tostring(self.m_is_sign_30_red));
    GNoticeGuideTip(Gt_Enum_Wait_Notice.Forced, Gt_Enum.EMain_SignIn30);
end

function ActivityReward:GetSignIn30RedPoint( )
    return self.m_is_sign_30_red;
end

--[[ÅäÖÃÊÇ·ñ³õÊ¼»¯]]
function ActivityReward:isInitConfig(activityId) 
    return self.iniConfig[activityId]
end

--[[»ñÈ¡½±ÀøÊýÁ¿, ¸üÐÂui]]
function ActivityReward:getRewardCount(activityId)
    return table.maxn(self.rewardConfig[activityId])
end

--[[»ñÈ¡½±Àø]]
function ActivityReward:getReward(activityId, pos)
    -- if pos >= self:getRewardCount(activityId) then
    --     return nil
    -- end
    return self.rewardConfig[activityId][pos+1]
end

--[»ñÈ¡¸÷ÖÖ²»Í¬ÑÕÉ«µÄÍâ¿ò]]
function ActivityReward:getFrameName(id, num)
    local name = 'waikuang_x_1'
    if id == IdConfig.Crystal then
        --×Ï
        name = 'waikuang_x_4'
    elseif  id == IdConfig.Gold then
        if num <= 10000 then
            --°×
        elseif num > 10000 and num <= 50000  then
            --ÂÌ
            name = 'waikuang_x_2'
        elseif num > 50000 and num <= 100000  then
            --À¶
            name = 'waikuang_x_3'
        elseif num > 100000  then
            --×Ï
            name = 'waikuang_x_4'
        end
    end
    return name
end

--[[ÉèÖÃÍâ¿ò]]
function ActivityReward:setIconFrame(frame, id, num)
    local frameName = self:getFrameName(id, num)
    if frame and frameName then
        frame:set_sprite_name(frameName)
    end
end

--[[»ñµÃÍâ¿ò]]
function ActivityReward:GetIconFrame(id, num)
    if id == IdConfig.Crystal or id == IdConfig.Gold then
        return self:getFrameName(id, num)
    else 
        return PublicFunc.GetIconFrame(id, num)
    end
end

----------------------  µÇÂ¼½±Àø ----------------------
function ActivityReward:canGetLoginReward()
    if self:isEnabled(self.loginID) then
        -- ²éÑ¯½±ÀøÁÐ±í
        for _, data in pairs(self.rewardConfig[self.loginID]) do
            if data.canGet then 
                return true
            end
        end
    end
    return false
end

--[[    
    µÇÂ¼ÌìÊý
    ÅäÖÃÊý¾Ý
    ÒÑÁìÈ¡µÄindexs
]]
--[[Éú³É±¾µØµÄ½±ÀøÅäÖÃ]]
function ActivityReward:setLoginData(loginDays, datas, indexs)
    self.is_login_data = true;
    self.iniConfig[self.loginID] = true
    self.rewardConfig[self.loginID] = {} 
    for _,data in pairs(datas) do
        -- ¼ì²éÊÇ·ñÁìÈ¡
        local isGet = 0   
        for _, index in pairs(indexs) do 
            if data.index == index then
                isGet = 1;
                break
            end
        end        
        -- Î´ÁìÈ¡
        -- if isGet == false then            
        local items = {}       -- ½±Àøid, ÊýÁ¿£¬ ÊÇ·ñ¸ßÁÁ
        for i = 1, #data.vecItemID do  
            table.insert(items, {id=data.vecItemID[i], num=data.vecItemCnt[i], light=data.vecLight[i]})
        end 

        table.insert(self.rewardConfig[self.loginID], {index=data.index, days=data.needDays, rewardItems=items, canGet=loginDays>=data.needDays, c_day = loginDays, isGet = isGet})
        -- end
    end
    table.sort(self.rewardConfig[self.loginID], 
        function(a, b) 
            if a.isGet < b.isGet then
                return true;
            elseif a.isGet == b.isGet then
                return a.days < b.days;
            end
        end
        -- return a.days < b.days end
    );
    
    -- ¸üÐÂui
    uiManager:UpdateMsgData(EUI.ActivityUI, "UpdateRewardUI")
    local is_red_point = 0;  
    for k,v in pairs(self.rewardConfig[self.loginID]) do
        if v and v.canGet and v.isGet == 0 then
            is_red_point = 1;
            break;
        end
    end    
    self:SetInitRedPointState({id = ENUM.Activity.activityType_login_award, state = is_red_point});
end

--[[ÁìÈ¡½±Àø»Øµ÷]]
function ActivityReward:loginReward(index, reward)
    --É¾³ýÁìÈ¡µÄitem
    local pos = -1
    for i,data in pairs(self.rewardConfig[self.loginID]) do
        if data.index == index then
            pos = i
            data.isGet = 1;
            break
        end
    end
    -- if pos ~= -1 then 
    --     table.remove(self.rewardConfig[self.loginID], pos)
    --     table.sort(self.rewardConfig[self.loginID], function(a, b) return a.days < b.days end)
    -- end

    table.sort(self.rewardConfig[self.loginID], 
        function(a, b) 
            if a.isGet < b.isGet then
                return true;
            elseif a.isGet == b.isGet then
                return a.days < b.days;
            end
        end
        -- return a.days < b.days end
    );

    -- Õ¹Ê¾½±ÀøÐÅÏ¢
    -- uiManager:UpdateMsgData(EUI.ActivityUI, "RewardCallBack", reward)
    PublicFunc.msg_dispatch("msg_activity.gc_login_get_reward", reward);

    local is_red_point = 0;  
    for k,v in pairs(self.rewardConfig[self.loginID]) do
        if v and v.canGet and v.isGet == 0  then
            is_red_point = 1;
            break;
        end
    end
    self:SetInitRedPointState({id = ENUM.Activity.activityType_login_award, state = is_red_point});
end

----------------------  ´³¹Ø½±Àø ----------------------
function ActivityReward:canGetHurdleReward()
    if self:isEnabled(self.hurdleID) then
        -- »ñÈ¡¹Ø¿¨id
        local currHurdleId = g_dataCenter.hurdle:GetCurFightLevelID()
        if currHurdleId == 0 then
            --app.log_warning('»ñÈ¡¹Ø¿¨idÊ§°Ü')
            return false
        end
        -- ²éÑ¯½±ÀøÁÐ±í
        for _, data in pairs(self.rewardConfig[self.hurdleID]) do
            if currHurdleId > data.hurdleid then 
                return true
            end
        end
    end
    return false
end


--[[    
    ÅäÖÃÊý¾Ý
    ÒÑÁìÈ¡µÄindexs
]]
--[[Éú³É±¾µØµÄ½±ÀøÅäÖÃ]]
function ActivityReward:setHurdleData(datas, indexs)
    self.iniConfig[self.hurdleID] = true
    self.rewardConfig[self.hurdleID] = {}      

    for _,data in pairs(datas) do
        -- ¼ì²éÊÇ·ñÁìÈ¡
        local isGet = false   
        for _, index in pairs(indexs) do 
            if data.index == index then
                isGet = true;
                break
            end
        end        
        -- Î´ÁìÈ¡
        if isGet == false then            
            local items = {}       -- ½±Àøid, ÊýÁ¿£¬ ÊÇ·ñ¸ßÁÁ
            for i = 1, #data.vecItemID do  
                table.insert(items, {id=data.vecItemID[i], num=data.vecItemCnt[i], light=data.vecLight[i]})
            end 
            
            table.insert(self.rewardConfig[self.hurdleID], {index=data.index, hurdleid=data.hurdleid, rewardItems=items})
        end
    end
    table.sort(self.rewardConfig[self.hurdleID], function(a, b) return a.hurdleid < b.hurdleid end)
    -- ¸üÐÂui
    uiManager:UpdateMsgData(EUI.ActivityUI, "UpdateRewardUI")
end

--[[ÁìÈ¡½±Àø»Øµ÷]]
function ActivityReward:hurdleReward(index, reward)
    --É¾³ýÁìÈ¡µÄitem
    local pos = -1
    for i,data in pairs(self.rewardConfig[self.hurdleID]) do
        if data.index == index then
            pos = i
            break
        end
    end
    if pos ~= -1 then 
        table.remove(self.rewardConfig[self.hurdleID], pos)
        table.sort(self.rewardConfig[self.hurdleID], function(a, b) return a.hurdleid < b.hurdleid end)
    end
    -- Õ¹Ê¾½±ÀøÐÅÏ¢
    uiManager:UpdateMsgData(EUI.ActivityUI, "RewardCallBack", reward)
end

----------------------  »î¶¯×´Ì¬ ----------------------

--[[
    int activity_Index;	//»î¶¯±àºÅ
	int nState;		//×´Ì¬£¬0£¬¹Ø±Õ£¬1¿ªÆô
	string beginTime;	//¿ªÊ¼Ê±¼ä
	string endTime;		//½áÊøÊ±¼ä 
]]
function ActivityReward:setState(stateData)
    self.state = stateData
end

function ActivityReward:hasStateData()
    return self.state ~= nil
end


--[[¸ù¾Ý»î¶¯±àºÅ£¬ ÊÇ·ñ¿ªÆô×´Ì¬]]
function ActivityReward:isOpen(activityId)
    if self.state == nil then 
        return false
    end
    for _,v in pairs(self.state) do
        if activityId == v.activity_Index then
            return v.nState == 1
        end
    end
    return false
end

--[[»î¶¯ÊÇ·ñ¿ÉÓÃ]]
function ActivityReward:isEnabled(activityId)
    -- ÊÇ·ñ¿ªÆô
    local open = self:isOpen(activityId)
    if open == false then 
        return false
    end

    -- Èç¹ûÓÐÅäÖÃÆðÆôÊ±¼ä£¬ÔòÅÐ¶ÏÊÇ·ñÔÚÇø¼äÄÚ
    local beginTime = nil
    local endTime = nil
    for _,v in pairs(self.state) do
        if activityId == v.activity_Index then
            beginTime = v.beginTime
            endTime = v.endTime
            break
        end
    end

    if beginTime ~= nil and (system.time() < tonumber(beginTime)) then
        return false
    end
    if endTime ~= nil and (system.time() > tonumber(endTime)) then
        return false
    end

    -- Èç¹û½±ÀøitemÎª¿Õ£¬²»ÏÔÊ¾ui
    if self:getRewardCount(activityId) == 0 then
        return false
    end
    
    return true;
end

--[[»î¶¯¹ýÆÚÌìÊý]]
function ActivityReward:getExpiredDay(activityId)
    --[[if self:isEnabled() == false then
        return 0
    end
    if self.endTime then
        return math.ceil((self.endTime - os.time())/(24 * 60 * 60))
    else 
        return 0
    end ]]
end

----------------------------- gmÔËÓª»î¶¯--------------------------------

--[[³õÊ¼»¯ ]]
function ActivityReward:initGmConfig()
    self.activityTime = {}
    self.edRechargeData = {config = {}, extAward = {}, canGetDays = {}, todayData = {}}
end

--[[¸üÐÂ»î¶¯Ê±¼ä]]
function ActivityReward:updateGmActivityTime(activityid, begin_time, end_time)
    --app.log('updateGmActivityTime--->' .. tostring(activityid) ..' ' .. tostring(begin_time) .. ' ' .. tostring(end_time))
    self.activityTime[activityid] = {sTime = begin_time, eTime = end_time}
end

--[[»î¶¯ÊÇ·ñ´ò¿ª]]
function ActivityReward:isGmActivityEnabled(activityid)
    --ÊÇ·ñ´ò¿ª
    local config = self.activityTime[activityid]
    if config == nil then return false end
    --ÅÐ¶ÏÊ±¼ä
    if system.time() < tonumber(config.sTime) then
        return false
    end
    if system.time() > tonumber(config.eTime) then
       return false
    end
    return true
end

--[[µÃµ½»î¶¯½áÊøÊ±¼ä]]
function ActivityReward:getGmActivityEndTime(activityid)
    if self.activityTime[activityid] then
        return self.activityTime[activityid].eTime
    end
    return 0   
end

--[[¸üÐÂÃ¿ÈÕ³äÖµ»î¶¯ÅäÖÃ]]
function ActivityReward:updateERConfig(bagConfig, extAward)
    --app.log('bagConfig--->' ..table.tostring(bagConfig))
    --app.log('extAward---->' ..table.tostring(extAward))

    self.edRechargeData.config = {}
    for _, v in pairs(bagConfig) do 
        local day = v.id
        self.edRechargeData.config[day] = {crystal = v.recharge_crystal, awards = v.gift_bag}
    end
    self.edRechargeData.extAward = {}
    self.edRechargeData.extAward = extAward
end

--[[¸üÐÂ¿ÉÁìÈ¡ÌìÊý]]
function ActivityReward:updateERGetDays(days)
    --app.log('days--->' ..table.tostring(days))
    self.edRechargeData.canGetDays = days
    if (#self.edRechargeData.canGetDays) > 0 then
        self:SetRedPointStateByActivityID(ENUM.Activity.activityType_everyday_recharge_total, 1);
    else
        self:SetRedPointStateByActivityID(ENUM.Activity.activityType_everyday_recharge_total, 0);
    end
end

--[[¸üÐÂ½ñÌìÊý¾Ý]]
function ActivityReward:updateERCrystal(day, crystal, isComplete)
    --app.log('updateERCrystal--->' .. tostring(day) .. ' ' .. tostring(crystal) .. ' ' .. tostring(isComplete))
    self.edRechargeData.todayData = {day = day, crystal = crystal, isComplete = isComplete}
end

--[[ÒÑÁìÈ¡µ½µÚ¼¸Ìì]]
function ActivityReward:getERDay()
    return self.edRechargeData.todayData.day
end

--[[µÃµ½½ñÌìÐèÒª³äÖµµÄË®¾§]]
function ActivityReward:getERNeedCrystal(day)
    return self.edRechargeData.config[day].crystal
end

--[[µÃµ½½±Àø]]
function ActivityReward:getERAwards(day)
    return self.edRechargeData.config[day].awards
end

--[[µÃµ½¶îÍâ½±Àø]]
function ActivityReward:getERExtAwards()
    return self.edRechargeData.extAward[1]
end

--[[ÒÑ³äÖµµÄË®¾§]]
function ActivityReward:getERHaveCrystal() 
    return self.edRechargeData.todayData.crystal
end

--[[½ñÈÕÊÇ·ñÍê³É]]
function ActivityReward:isERComplete() 
    return tonumber(self.edRechargeData.todayData.isComplete) == 1
end

--[[ÅÐ¶ÏÊÇ·ñ¿ÉÁìÈ¡]]
function ActivityReward:isERCanGet(day)
    for _, v in pairs(self.edRechargeData.canGetDays) do
        if day == tonumber(v) then
            return true
        end
    end
    return false
end

--[[ÊÇ·ñ¿ÉÁìÈ¡, ÏÔÊ¾Ð¡ºìµã]]
function ActivityReward:isAllERCanGet()
    return (#self.edRechargeData.canGetDays) > 0
end

--- 双倍活动

-- 是否开启双倍活动
function ActivityReward:GetIsDouble( doubleID )
    local double_type = _double_type_id[doubleID];
    return self:GetActivityIsOpenByActivityid(double_type.activity_type);
end

-- 并行条件
-- doubleID:双倍活动功能ID(ENUM.Double)
-- itemID:道具ID
--返回倍率
function ActivityReward:GetDoubleByID( doubleID, itemID )
    local radio = 1;
    local double_type = _double_type_id[doubleID];
    -- app.log("activity_id:" .. _double_type_id[doubleID]);
    local double_config = nil;
    local activity_config = self:GetActivityTimeForActivityID(double_type.activity_type);
    
    if self:GetActivityIsOpenByActivityid(double_type.activity_type) and activity_config ~= nil then

        double_config = ConfigManager.Get(EConfigIndex.t_activity_double, doubleID);
        -- app.log("double_config:" .. table.tostring(double_config));
        -- app.log("activity_config:" .. table.tostring(activity_config))

        if double_config and double_config.double_award ~= "0" then
            if type(double_config.double_award) == "table" then
                for k,v in pairs(double_config.double_award) do
                    if tonumber(v) == tonumber(itemID) then
                        radio = activity_config.extra_num;
                        break;
                    end
                end
            elseif type(double_config.double_award) == "number" or type(double_config.double_award) == "string" then
                if tonumber(double_config.double_award) == tonumber(itemID) then
                    radio = activity_config.extra_num;
                end
            end
        end
    end
    -- app.log("radio:" .. radio);
    return radio;
    -- return 2, 1;
end

function ActivityReward:GetDoubleLimitNum( doubleID )
    local limit = -1;
    local double_type = _double_type_id[doubleID];
    app.log("double_type:" .. table.tostring(double_type) .. "---doubleID:" .. doubleID);
    local double_config = nil;
    if self:GetActivityIsOpenByActivityid(double_type.activity_type) then
        double_config = ConfigManager.Get(EConfigIndex.t_activity_double, doubleID);
        if double_config.is_limit == 1 then
            limit = double_config.limit_num;
        end
    end
    return limit;
end

-------------- 额外次数 ------------------
-- 获取额外次数
function ActivityReward:GetExtraTimesByActivityID( activity_id )
    local res = 0;
    local is_open = self:GetActivityIsOpenByActivityid(activity_id);
    if not is_open then
        return 0;
    end
    local activityTime = self:GetActivityTimeForActivityID(activity_id);
    if activityTime and activityTime.extra_num and activityTime.extra_num ~= 0 then
        res = activityTime.extra_num;
    end
    return res;
end

local _sp_name = {
    [1] = "奖励翻倍";
    [2] = "额外次数";
    
}

local _challenge_double_by_activity_id = {
    [1] = ENUM.Activity.activityType_double_hight_sniper;
    [2] = ENUM.Activity.activityType_double_defend;
    [3] = ENUM.Activity.activityType_double_xiaochoujihua;
    [4] = ENUM.Activity.activityType_double_kuikuliya;
    [5] = ENUM.Activity.activityType_double_church_hook;
}

local _challenge_extra_times_by_activity_id = {
    [1] = ENUM.Activity.activityType_extra_times_hight_sniper;
    [2] = ENUM.Activity.activityType_extra_times_baoweizhang;
    [3] = ENUM.Activity.activityType_extra_times_xiaochoujihua;
}

local _pvp_double_by_activity_id = {
    
}

local _pvp_extra_times_by_activity_id = {
   
}

-- 检测
function ActivityReward:SetChallengeSpriteName( sp )
    -- sp:set_active(false);
    local is_activity = false;
    local sp_name = "";
    for k,v in pairs(_challenge_double_by_activity_id) do
       if self:GetActivityIsOpenByActivityid(v) then
            is_activity = true;
            sp_name = _sp_name[1];
            app.log("--------------- SetChallengeSpriteName:" .. tostring(is_activity) .. "------ sp_name:" .. sp_name)
            break;
       end
    end
    if is_activity == false then
        for k,v in pairs(_challenge_extra_times_by_activity_id) do
           if self:GetActivityIsOpenByActivityid(v) then
                is_activity = true;
                sp_name = _sp_name[2];
                break;
           end
        end
    end
    if sp then
        sp:set_active(is_activity);
        local sp_tex = ngui.find_label(sp:get_parent(), "lab")
        if sp_tex then
            sp_tex:set_text(sp_name);
        end
    end
end

function ActivityReward:SetPvpSpriteName( sp )
    -- sp:set_active(false);
    local is_activity = false;
    local sp_name = "";
    for k,v in pairs(_pvp_double_by_activity_id) do
       if self:GetActivityIsOpenByActivityid(v) then
            is_activity = true;
            sp_name = _sp_name[1];
            break;
       end
    end
    if is_activity == false then
        for k,v in pairs(_pvp_extra_times_by_activity_id) do
           if self:GetActivityIsOpenByActivityid(v) then
                is_activity = true;
                sp_name = _sp_name[2];
                break;
           end
        end
    end
    sp:set_active(is_activity);
    sp:set_sprite_name(sp_name);
end

------------------------
--设置活动开启和关闭时间

function ActivityReward:ResetAllActivityTime()
    self.m_vec_activity_time = {};
end

function ActivityReward:SetActivityTimeForActivityID( activity_id, start_time, end_time, activity_name, extra_num, close_time, is_pause, is_reset, param_1, param_2)
    self.m_vec_activity_time[activity_id] = {
            s_time = start_time, 
            e_time = end_time, 
            activity_name = activity_name, 
            extra_num = extra_num, 
            o_time = close_time, 
            is_pause = is_pause, 
            is_reset = is_reset,
            param_1 = param_1,
            param_2 = param_2
            };

    --同步贩卖机次数
    if activity_id == ENUM.Activity.activityType_vending_machine then
        self:UpdateVendingMachineBuyTimes(tonumber(param_1))
    end
end

function ActivityReward:GetActivityTimeForActivityID( activity_id )
    return self.m_vec_activity_time[activity_id];
end

function ActivityReward:ChangeActivityTimeForActivityID( activity_id, start_time, end_time )
    local activityTime = self:GetActivityTimeForActivityID(activity_id);
    if activityTime then
        self.m_vec_activity_time[activity_id].s_time = start_time;
        self.m_vec_activity_time[activity_id].e_time = end_time;
        --self.m_vec_activity_time[activity_id] = {s_time = start_time, e_time = end_time, activity_name = activityTime.activity_name, extra_num = activityTime.extra_num};
    end

    --更新贩卖机红点
    if activity_id == ENUM.Activity.activityType_vending_machine then
        GNoticeGuideTip(Gt_Enum_Wait_Notice.Forced,Gt_Enum.EMain_Challenge_VendingMachine);
    end
end

function ActivityReward:PauseActivityForActivityID( activity_id, is_pause )
    local activityTime = self:GetActivityTimeForActivityID(activity_id);
    if activityTime then
        self.m_vec_activity_time[activity_id].is_pause = is_pause;
    end
end

function ActivityReward:GetActivityIsOpenByActivityid( activity_id )
    local result = false;
    local activityTime = self:GetActivityTimeForActivityID(activity_id);
    local diff = 0;
    if activityTime then
        if activityTime.is_pause == true or activityTime.is_pause == 1 then
            result = false;
        elseif activityTime.e_time == -1 then
            result = true; 
        else
            s_diff = system.time() - activityTime.s_time;
            e_diff = system.time() - activityTime.e_time;
            if activity_id == ENUM.Activity.activityType_power_rank then
                e_diff = system.time() - activityTime.o_time;
            end
            if s_diff >= 0 and e_diff < 0 then
                result = true;
            end
        end
    end
    return result;
end

function ActivityReward:GetActivityNameByActivityID( activity_id )
    local lab_name = "";
    local activityTime = self:GetActivityTimeForActivityID(activity_id);
    if activityTime then
        lab_name = activityTime.activity_name or "";
    end
    return lab_name;
end

-----------------------
--小红点初始化
function ActivityReward:SetInitRedPointState( red_point_state )
    self.m_red_point_states[red_point_state.id] = red_point_state;
    if tonumber(red_point_state.id) == ENUM.Activity.activityType_sign_in_7 then
        GNoticeGuideTip(Gt_Enum_Wait_Notice.Forced, Gt_Enum.EMain_SignIn7);    
    elseif tonumber(red_point_state.id) == ENUM.Activity.activityType_login_award then
        GNoticeGuideTip(Gt_Enum_Wait_Notice.Forced, Gt_Enum.EMain_LoginAward);
    else
        GNoticeGuideTip(Gt_Enum_Wait_Notice.Forced, Gt_Enum.EMain_Activity);
    end
end

--获取小红点数据
function ActivityReward:GetRedPointStates( )
    return self.m_red_point_states;
end

-- 给某个活动直接设置红点状态
function ActivityReward:SetRedPointStateByActivityID( activity_id, state )
    local red_point_state = self.m_red_point_states[activity_id];
    if red_point_state then
        red_point_state.state = state;
    else
        self.m_red_point_states[activity_id] = {id = activity_id, state = state};
    end
    PublicFunc.msg_dispatch("ActivityReward.update_point_by_activity_id", activity_id);
    

    if activity_id == ENUM.Activity.activityType_login_award then
        GNoticeGuideTip(Gt_Enum_Wait_Notice.Forced, Gt_Enum.EMain_LoginAward);
    elseif activity_id == ENUM.Activity.activityType_lucky_cat then
        GNoticeGuideTip(Gt_Enum_Wait_Notice.Forced, Gt_Enum.EMain_LuckyCat);
    elseif activity_id == ENUM.Activity.activityType_power_rank then
        GNoticeGuideTip(Gt_Enum_Wait_Notice.Forced, Gt_Enum.EMain_PowerRank);
    else
        GNoticeGuideTip(Gt_Enum_Wait_Notice.Forced, Gt_Enum.EMain_Activity);
    end
end

-- 获取是否有小红点
function ActivityReward:GetIsRedPointStateByActivityID( activity_id )
    local result = false;
    local red_point_state = self.m_red_point_states[activity_id];
    if red_point_state and red_point_state.state == 1 then
        result = true;
    end
    return result;
end

function ActivityReward:HasRequestExchangeItemActivityData(activity_id)
   return self.exchange_item_states ~= nil and self.exchange_item_states[activity_id] ~= nil
end

function ActivityReward:SetExchangeItemActConfig(activityid, config)
    self.exchange_item_config[activityid] = self.exchange_item_config[activityid] or {}

    for k,v in pairs(config) do
        self.exchange_item_config[activityid][v.id] = v
    end
end

function ActivityReward:GetExchangeItemActConfig(activityid)
    return self.exchange_item_config[activityid]
end

function ActivityReward:SetExchangeItemAllState(states, activity_id)
    self.exchange_item_states = self.exchange_item_states or {}
    self.exchange_item_states[activity_id] = {}
    local state = self.exchange_item_states[activity_id]

    for k,v in ipairs(states) do
        state[v.id] = v.progress
    end
end

function ActivityReward:GetItemExchangeTimes(activity_id, id)
    local ret = 0
    local times = self.exchange_item_states[activity_id]

    if times then
        ret = times[id] or 0
    end

    return ret
end

function ActivityReward:ExchangeItemSucc(id, times, activity_id)
    local state = self.exchange_item_states[activity_id]
    if state == nil then return end
    local progress = state[id]
    if progress == nil then
        state[id] = times
    else
        state[id] = progress + times
    end
end

function ActivityReward:HasRequestVipBagActivityData()
    return self.vip_bag_buy_states ~= nil
end

function ActivityReward:SetVipBagAllState(states)
    self.vip_bag_buy_states = {}
    for k,v in ipairs(states) do
        self.vip_bag_buy_states[v.id] = v.progress
    end
end

function ActivityReward:GetBuyVipBagTimes(vip)
    local times = self.vip_bag_buy_states[vip]
    if times == nil then
        times = 0
    end

    return times
end

function ActivityReward:VipGiftBuySucc(viplevel, buytimes, timesNum)
    self.vip_bag_buy_states[viplevel] = timesNum
end

--------------------------全服抢购----------------------------

function ActivityReward:SetServerBuyState(day, item_1_num, is_buy_1, item_2_num, is_buy_2)
    self.allServerBuyStates[day] = {
        [1] = {
            count = item_1_num,
            isBuy = is_buy_1
        },
        [2] = {
            count = item_2_num,
            isBuy = is_buy_2
        }
    }
end

function ActivityReward:GetServerBuyState(day) 
    return self.allServerBuyStates[day]
end

---------------------宝箱折扣-----------------------------
-- 是否开启活动
-- 折扣率
-- 次数限制0-不限制
function ActivityReward:GetBoxDiscount( activity_id )
    local is_activity = false;
    local discountNum = 10;
    local limitTimes = 0;
    local activityTime = self:GetActivityTimeForActivityID(activity_id);
    if activityTime then
        is_activity = true;
        discountNum = tonumber(activityTime.param_1);
        limitTimes = tonumber(activityTime.param_2);
    end

    return is_activity, discountNum, limitTimes;
end

---------------------积分英雄-----------------------------------------


function ActivityReward:InitScoreHero()
    self.scoreHeroData = {
        myRank = -1,
        freeTimes = 0,
        myScore = 0,
        isFirst = true,
    }
    self.scoreHeroRankList = {}
    self.ScoreBoxGetMap = {}
end

function ActivityReward:SetScoreHeroData(scorePoint, vecBoxRewardGeted, freeTime, myRankIndex)
    self.scoreHeroData.myRank = myRankIndex
    self.scoreHeroData.freeTimes = freeTime
    self.scoreHeroData.myScore = scorePoint

    self.ScoreBoxGetMap = {}
    if vecBoxRewardGeted then
        for _, _index in pairs(vecBoxRewardGeted) do
            self.ScoreBoxGetMap[_index] = 1
        end
    end
end

function ActivityReward:GetScoreHeroData()
    return self.scoreHeroData
end

function ActivityReward:SetScoreBoxIsGet(index)
    self.ScoreBoxGetMap[index] = 1
end

function ActivityReward:CheckScoreBoxIsGet(index)
    return self.ScoreBoxGetMap[index] ~= nil
end

function ActivityReward:SetScoreHeroRankList(list)
    self.scoreHeroRankList = list
end

function ActivityReward:GetScoreHeroRankList()
    return self.scoreHeroRankList
end

function ActivityReward:GetScoreBoxStatus(index, needScore)
    local isGet = self:CheckScoreBoxIsGet(index)
    if isGet then
        return ENUM.ScoreBoxStatus.Geted
    else
        --比较积分
        if self.scoreHeroData.myScore >= needScore then
            return ENUM.ScoreBoxStatus.CanGet
        end
    end
    return ENUM.ScoreBoxStatus.NotGet
end

function ActivityReward:SetFirstOpenScoreHero(v)
    self.scoreHeroData.isFirst = v
end

function ActivityReward:IsShowScoreHeroTip()
    --第一次
    if self.scoreHeroData.isFirst then
        return true
    end
    --免费次数
    if self.scoreHeroData.freeTimes > 0 then
        return true
    end
    --可领取的宝箱
    local boxRewardCfg = ConfigManager._GetConfigTable(EConfigIndex.t_score_hero_box_reward)
    for i = 1, 7 do
        local status = self:GetScoreBoxStatus(i, boxRewardCfg[i].need_score)
        if status == ENUM.ScoreBoxStatus.CanGet then
            return true
        end
    end
    return false
end

function ActivityReward:SetSubscribeState( state )
    self.m_subscribe_state = state;
end

function ActivityReward:GetSubscribeState( )
    return self.m_subscribe_state;
end

function ActivityReward:SetSubscribeStateList( states )
    self.m_subscribe_state_list = states;

    table.sort(self.m_subscribe_state_list, function ( a, b )
        return a.id < b.id;
    end)
end

function ActivityReward:GetSubscribeStateList( )
    return self.m_subscribe_state_list;
end

function ActivityReward:SetStateById( id, state )
    for k,v in pairs(self.m_subscribe_state_list) do
        if v and v.id == id then
            v.state = state;
        end
    end
end

function ActivityReward:IsShowScoreHero()
    return g_dataCenter.activityReward:GetActivityIsOpenByActivityid(ENUM.Activity.activityType_score_hero)
    and SystemEnterFunc.IsOpenFunc(MsgEnum.eactivity_time.eActivityTime_ScoreHero)
end

---------------------------------------砸金蛋----------------------------------------------------------------------

function ActivityReward:InitGoldenEgg()
    self.goldenEggData = {
        isFirst = true,
        needReset = false
    }
    self.awardMarquee = {}
end

function ActivityReward:GetGoldenEggData()
    return self.goldenEggData
end

function ActivityReward:SetFirstOpenGoldenEgg(v)
    self.goldenEggData.isFirst = v
end

function ActivityReward:IsShowGoldenEgg()
    return self:GetActivityIsOpenByActivityid(ENUM.Activity.activityType_golden_egg)
    and SystemEnterFunc.IsOpenFunc(MsgEnum.eactivity_time.eActivityTime_GoldenEgg)
end

function ActivityReward:IsShowGoldenEggTip()
    if self.goldenEggData.ticket == nil then
        return false
    end
    --第一次
    if self.goldenEggData.isFirst then
        return true
    end
    local _ticket, _diamond = self:GetGoldenEggConsume()
    if _ticket <= self.goldenEggData.ticket and _diamond <= PropsEnum.GetValue(IdConfig.Crystal) then
        return true
    end
    return false
end

function ActivityReward:GetMarquee()
    local data = nil
    if #self.awardMarquee > 0 then
        data = self.awardMarquee[1]
        table.remove(self.awardMarquee, 1)
    end
    return data
end

function ActivityReward:AddMarquee(data)
    local para = {}
    for k, v in ipairs(data.vecParm) do
        para[k] = v
    end
    local content = string.format(gs_string_marquee["golden_egg_award"], para[1], para[2])
    table.insert(self.awardMarquee, 1, content)
    if #self.awardMarquee > 5 then
        table.remove(self.awardMarquee)
    end
end

function ActivityReward:SyncGoldenEgg(ticketCnt, todayProfit, todayCanGetTicketCnt, getRecord)
    self.goldenEggData.ticket = ticketCnt
    self.goldenEggData.todayProfit = todayProfit
    self.goldenEggData.canGetTicket = todayCanGetTicketCnt
    self.goldenEggData.getRecord = getRecord
    self.goldenEggData.needReset = (table.get_num(getRecord) == 0)
end

function ActivityReward:NeedReset()
    return self.goldenEggData.needReset
end

function ActivityReward:IsGetGoldenEgg(index)
    if self.goldenEggData.getRecord then
        return self.goldenEggData.getRecord[index] ~= nil
    end
    return false
end

function ActivityReward:GetGoldenEggConsume()
    local times = table.get_num(self.goldenEggData.getRecord) + 1
    if times > 3 then
        times = 3
    end
    local config = ConfigManager.Get(EConfigIndex.t_golden_egg_cost, times)
    return config.cost_ticket, config.cost_diamond
end

----------------------- 贩卖机 ---------------------
function ActivityReward:InitVendingMachineConfig()
    local lastTimes = nil
    local vipConfig = {}
    for i, v in pairs_key(ConfigManager._GetConfigTable(EConfigIndex.t_vip_data)) do
        if lastTimes == nil or lastTimes < v.vending_machine then
            lastTimes = v.vending_machine
            vipConfig[i] = lastTimes
        end
    end
    self.vending_machine_states.vipConfig = vipConfig
end

function ActivityReward:IsInitVendingMachine()
    return self.vending_machine_states.isInit == true
end

function ActivityReward:SetInitVendingMachine()
    self.vending_machine_states.isInit = true
end

function ActivityReward:UpdateVendingMachineBuyTimes(times)
    self.vending_machine_states.buyTimes = times
end

function ActivityReward:SetVendingMachineNewRecords(records)
    self.vending_machine_states.newRecords = records
end

function ActivityReward:GetVendingMachineBuyTimes()
    return self.vending_machine_states.buyTimes or 0
end

function ActivityReward:GetVendingMachineNewRecords()
    return self.vending_machine_states.newRecords or table.empty()
end

function ActivityReward:GetVendingMachineMaxTimes(isNeedMaxLevel)
    local vip_data = g_dataCenter.player:GetVipData()
    local isMaxLevel = false
    if isNeedMaxLevel then
        local maxVipLevel = table.maxn (ConfigManager._GetConfigTable(EConfigIndex.t_vip_data))
        if maxVipLevel <= g_dataCenter.player.vip then
            isMaxLevel = true
        end
    end
	return vip_data.vending_machine or 1, isMaxLevel
end

function ActivityReward:GetVendingMachineRedPointState()
    if not self:GetActivityIsOpenByActivityid(ENUM.Activity.activityType_vending_machine) then
        return Gt_Enum_Wait_Notice.Forced
    end

    local haveTimes = self:GetVendingMachineBuyTimes()
    local totalTimes, isMaxLevel = self:GetVendingMachineMaxTimes(true)
    if haveTimes >= totalTimes then
        if not isMaxLevel then
            return Gt_Enum_Wait_Notice.Vip_Level
        else
            return Gt_Enum_Wait_Notice.Forced
        end
    else
        if not isMaxLevel then
            local config = ConfigManager.Get(EConfigIndex.t_vending_machine, haveTimes+1)
            if config == nil then
                app.log("贩卖机抽取消耗id=["..tostring(haveTimes+1).."]配置未找到，请检查！")
                return Gt_Enum_Wait_Notice.Forced
            elseif config.cost_num > g_dataCenter.player.crystal then
                return Gt_Enum_Wait_Notice.Crystal
            end
            return Gt_Enum_Wait_Notice.Success
        else
            return Gt_Enum_Wait_Notice.Forced
        end
    end

    return Gt_Enum_Wait_Notice.Success
end

function ActivityReward:GetVendingMachineNeedVip(buyTimes)
    local need_vip = nil
    for lv, times in pairs_key(self.vending_machine_states.vipConfig) do
        if times >= buyTimes then
            need_vip = lv
            break;
        end
    end
    return need_vip
end
