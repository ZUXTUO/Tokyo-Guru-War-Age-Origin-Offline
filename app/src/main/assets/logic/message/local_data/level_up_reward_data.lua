

level_up_reward_fake_data = {
    haveGetMaxLevel=0,
    config = {
        {level = 1,reward_items = {{id  =  10000020, num  =  1,},},},
	    {level = 10,reward_items = {{id  =  20000001, num  =  1,},},},
	    {level = 20,reward_items = {{id  =  20000001, num  =  1,},{id  =  10000001, num  =  3,},{id   =  10000001, num  =  3,},},},
	    {level = 30,reward_items = {{id  =  20000001, num  =  1,},{id  =  10000020, num  =  3,},},},
	    {level = 40,reward_items = {{id  =  20000001, num  =  1,},{id  =  10000001, num  =  3,},{id  =  10000001, num  =  3,},{id  =  10000001, num  =  6,},},},
	    {level = 50,reward_items = {{id  =  20000001, num  =  1,},{id  =  10000001, num  =  3,},{id  =  10000001, num  =  3,},},},
    },
    expireTime = 0
}
function level_up_reward_fake_data.client_request()
	level_up_reward_fake_data._timerId=timer.create("level_up_reward_fake_data.server_response",500,1);
end

function level_up_reward_fake_data.server_response()

    timer.stop(level_up_reward_fake_data._timerId)
    level_up_reward_fake_data.beginTime = os.time() - 24 *60 * 60
    level_up_reward_fake_data.endTime = os.time() + 24 *60 * 60
    msg_activity.server_response_data(level_up_reward_fake_data)
    
end
