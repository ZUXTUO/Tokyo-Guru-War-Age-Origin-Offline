

activity_reward_local = {}

activity_reward_local.fakeState = {
    {activity_Index = 60054019, nState = 1}, 
	{activity_Index = 60054018, nState = 1}, 
}

activity_reward_local.fakeData = {
    loginDays = 20,
    configData = {
        {index = 100, needDays = 1, vecItemID = {1}, vecItemCnt = {10}, vecLight = {1}},
	    {index = 101, needDays = 2, vecItemID = {1,2,3}, vecItemCnt = {10, 5000, 30}, vecLight = {0, 1, 0}},
        {index = 102, needDays = 3, vecItemID = {1,3}, vecItemCnt = {10, 100}, vecLight = {1, 0}},
        {index = 103, needDays = 4, vecItemID = {1,2}, vecItemCnt = {10, 10001}, vecLight = {0, 0}},
        {index = 104, needDays = 5, vecItemID = {1,2,3}, vecItemCnt = {10, 20, 300}, vecLight = {0, 0, 0}},
	    {index = 105, needDays = 6, vecItemID = {1,3}, vecItemCnt = {10, 30}, vecLight = {0, 0}},
        {index = 106, needDays = 7, vecItemID = {1,2,3}, vecItemCnt = {10, 20, 30}, vecLight = {0, 0, 0}},
        {index = 107, needDays = 8, vecItemID = {1,2,3}, vecItemCnt = {10, 20, 30}, vecLight = {0, 0, 0}},
        {index = 108, needDays = 9, vecItemID = {1}, vecItemCnt = {10}, vecLight = {0}},
	    {index = 109, needDays = 10, vecItemID = {1,2,3}, vecItemCnt = {10, 20, 30}, vecLight = {0, 0, 0}},
        {index = 110, needDays = 11, vecItemID = {1,3}, vecItemCnt = {10, 30}, vecLight = {0, 0}},
        {index = 111, needDays = 12, vecItemID = {1,2,3,4}, vecItemCnt = {10, 20, 30, 10}, vecLight = {0, 0, 0, 0}},

	},
    indexs = {}
}

activity_reward_local.fakeReward = {
    {dataid = '0', id = 1, count = 1},
	{dataid = '0', id = 2, count = 1}
}

activity_reward_local.fakeDataH = {
    configData = {
        {index = 100, hurdleid = 60001005, vecItemID = {1,2,3}, vecItemCnt = {10, 20, 30}, vecLight = {0, 0, 0}},
	    {index = 101, hurdleid = 60001029, vecItemID = {1,2,3}, vecItemCnt = {10, 20, 30}, vecLight = {0, 0, 0}},
        {index = 102, hurdleid = 60001054, vecItemID = {1,2,3}, vecItemCnt = {10, 20, 30}, vecLight = {0, 0, 0}},
        {index = 103, hurdleid = 60001097, vecItemID = {1,2,3}, vecItemCnt = {10, 20, 30}, vecLight = {0, 0, 0}}
	},
    indexs = {103}
}

activity_reward_local.fakeRewardH = {
    {dataid = '0', id = 1, count = 1},
	{dataid = '0', id = 2, count = 1}
}


-- ◊¥Ã¨
function activity_reward_local.cg_activity_request_state()
	activity_reward_local._stateTimerId = timer.create("activity_reward_local.gc_activity_request_state", 500, 1);
end

function activity_reward_local.gc_activity_request_state()
    timer.stop(activity_reward_local._stateTimerId)
    msg_activity.gc_activity_request_state(activity_reward_local.fakeState)    
end

--------------------- µ«¬ºΩ±¿¯ ---------------------

-- ªÒ»°≈‰÷√
function activity_reward_local.cg_login_request_my_data()
	activity_reward_local._timerId = timer.create("activity_reward_local.gc_login_request_my_data", 500, 1);
end

function activity_reward_local.gc_login_request_my_data()
    timer.stop(activity_reward_local._timerId)
    msg_activity.gc_login_request_my_data(activity_reward_local.fakeData.loginDays, 
        activity_reward_local.fakeData.configData, activity_reward_local.fakeData.indexs)    
end

-- ¡ÏΩ±
function activity_reward_local.cg_login_get_reward(index)
    activity_reward_local._index = index
	activity_reward_local._timerId = timer.create("activity_reward_local.gc_login_get_reward", 500, 1);
end

function activity_reward_local.gc_login_get_reward()
    timer.stop(activity_reward_local._timerId)
    msg_activity.gc_login_get_reward(0, activity_reward_local._index, activity_reward_local.fakeReward)    
end

--------------------- ¥≥πÿΩ±¿¯ ---------------------

-- ªÒ»°≈‰÷√
function activity_reward_local.cg_hurdle_request_my_data()
	activity_reward_local._hurdleTimerId = timer.create("activity_reward_local.gc_hurdle_request_my_data", 500, 1);
end

function activity_reward_local.gc_hurdle_request_my_data()
    timer.stop(activity_reward_local._hurdleTimerId)
    msg_activity.gc_hurdle_request_my_data(activity_reward_local.fakeDataH.configData, activity_reward_local.fakeDataH.indexs)    
end

-- ¡ÏΩ±
function activity_reward_local.cg_hurdle_get_reward(index)
    activity_reward_local._hurdleIndex = index
	activity_reward_local._hurdleTimerId = timer.create("activity_reward_local.gc_hurdle_get_reward", 500, 1);
end

function activity_reward_local.gc_hurdle_get_reward()
    timer.stop(activity_reward_local._hurdleTimerId)
    msg_activity.gc_hurdle_get_reward(0, activity_reward_local._hurdleIndex, activity_reward_local.fakeRewardH)    
end
