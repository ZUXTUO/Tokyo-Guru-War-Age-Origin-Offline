--[[
region fight_key_frame_info.lua
date: 2017-1-13
time: 17:41:53
author: Nation
]]
FightKeyFrameInfo = {
    is_begin = false,
    random_seed = 0,
    frame_info = {},
    last_time = 0,
    last_update_time = 0,
    is_time_start = false,
}


function FightKeyFrameInfo.Init()
    do return end
    FightKeyFrameInfo.is_begin = true
    FightKeyFrameInfo.frame_info = {}
    FightKeyFrameInfo.random_seed = math.random(1, 100000)
    FightKeyFrameInfo.last_time = 0
    FightKeyFrameInfo.last_update_time = 0
    FightKeyFrameInfo.is_time_start = false
    PublicFunc.Key_Random_Seed(FightKeyFrameInfo.random_seed)
    if PublicStruct.Fight_Sync_Type == ENUM.EFightSyncType.Single then
        local frame_info = {}
        frame_info.type = ENUM.FightKeyFrameType.FightBegin
        frame_info.integer_params = {}
        frame_info.string_params = {}
        table.placeholder_insert_number(frame_info.integer_params, FightKeyFrameInfo.random_seed)
        table.placeholder_insert_number(frame_info.integer_params, FightScene.GetPlayMethodType())
        table.placeholder_insert_number(frame_info.integer_params, FightScene.GetCurHurdleID())
        FightKeyFrameInfo.AddKeyInfo(frame_info)
    end
end

function FightKeyFrameInfo.AddKeyInfo(info)
    do return end
    if not FightKeyFrameInfo.is_begin then
        --app.log("type = "..info.type)
        return
    end
    if info.type == ENUM.FightKeyFrameType.TimerStart then
        FightKeyFrameInfo.is_time_start = true
    end
    if (info.type == ENUM.FightKeyFrameType.FightPause or info.type == ENUM.FightKeyFrameType.FightResume) and (not FightKeyFrameInfo.is_time_start) then
        return
    end
	if FightKeyFrameInfo.last_time == 0 then
		info.time_pass = 0
	else
		info.time_pass = PublicFunc.QueryDeltaTime(FightKeyFrameInfo.last_time)
	end
	FightKeyFrameInfo.last_time = PublicFunc.QueryCurTime()
    table.insert(FightKeyFrameInfo.frame_info, info)
end

function FightKeyFrameInfo.Destory(is_win, stars)
    do return end
    FightKeyFrameInfo.last_update_time = 0
    FightKeyFrameInfo.Update()
    if PublicStruct.Fight_Sync_Type == ENUM.EFightSyncType.Single then
        local frame_info = {}
        frame_info.type = ENUM.FightKeyFrameType.FightOver
        frame_info.integer_params = {}
        frame_info.string_params = {}
        if is_win then
            table.placeholder_insert_number(frame_info.integer_params, 1)
        else
            table.placeholder_insert_number(frame_info.integer_params, 0)
        end
        table.placeholder_insert_number(frame_info.integer_params, stars)
        FightKeyFrameInfo.AddKeyInfo(frame_info)
    end
    FightKeyFrameInfo.last_update_time = 0
    FightKeyFrameInfo.Update()
    FightKeyFrameInfo.is_begin = false
    FightKeyFrameInfo.frame_info = {}
end

function FightKeyFrameInfo.Update()
    do return end
    if not FightKeyFrameInfo.is_begin then
        return
    end
    if PublicFunc.QueryDeltaTime(FightKeyFrameInfo.last_update_time) >= 5000 then
        FightKeyFrameInfo.last_update_time = PublicFunc.QueryCurTime()
        if #FightKeyFrameInfo.frame_info > 0 then
            msg_hurdle.cg_update_fight_key_frame_info(FightKeyFrameInfo.frame_info)
            FightKeyFrameInfo.frame_info = {}
        end
        
    end
end

--[[endregion]]