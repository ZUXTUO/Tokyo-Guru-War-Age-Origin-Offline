
msg_chat = {};

-- 临时变量, 是否使用本地数据
local isLocalData = true

-- msg_chat.type = nil;
-- msg_chat.content = nil;
-- msg_chat.playerid = nil;
-- msg_chat.speaker = nil;
-- msg_chat.time = nil;

function msg_chat.cg_player_chat(type, content, playerid, speaker)
	--if not Socket.socketServer then return end
    if isLocalData then
        chat_local.cg_player_chat(type, content)
    else

        nmsg_chat.cg_player_chat(Socket.socketServer, type, content, playerid, speaker); 

        -- msg_chat.type = type
        -- msg_chat.content = content
        -- msg_chat.playerid = playerid
        -- msg_chat.speaker = speaker

        -- if msg_chat.time then

        -- else
        --     msg_chat.time = timer.create("msg_chat.recallsend", 1000, -1);
        -- end
    end	
end

function msg_chat.recallsend()
    msg_chat.cg_player_chat(msg_chat.type,msg_chat.content,msg_chat.playerid,msg_chat.speaker)
end

--[[请求缓存]]
function msg_chat.cg_cache_chat()
	--if not Socket.socketServer then return end
    if AppConfig.script_recording then
        PublicFunc.RecordingScript("nmsg_chat.cg_cache_chat(robot_s)")
    end
	nmsg_chat.cg_cache_chat(Socket.socketServer);
end

-----------------------------服务器返回-----------------------------------------------

function msg_chat.gc_player_chat(result, forbid_chat_time)
	app.log("发送消息的返回结果=" .. tostring(result));
    if result == MsgEnum.error_code.error_code_forbid_chat then
        local forbidtime
        if tonumber(forbid_chat_time) > 0 then
            forbidtime = os.date(gs_misc['str_85'], tonumber(forbid_chat_time)+59)
        else
            forbidtime = gs_misc['str_86']
        end
        HintUI.SetAndShow(EHintUiType.zero, forbidtime);
    elseif tonumber(result) ~= 0 then
        PublicFunc.GetErrorString(result)
        return
    end
end

function msg_chat.gc_add_player_chat(chat)
    --chat.time = os.date("%X", os.time());
    --文本类型
    chat.ctype = PublicStruct.Chat_Type.text  
    --测试用chenjia
 --    local content = ''
 --    if Socket.sendtime then
 --        content = " receivetime:"..tostring( os.clock() -Socket.sendtime )
 --    end
    
 --    chat.content = content
	g_dataCenter.chat:add_chat(chat);
    PublicFunc.msg_dispatch(msg_chat.gc_add_player_chat);
end

function msg_chat.gc_cache_chat(result, chats, finish)
    if tonumber(result) ~= 0 then
        PublicFunc.GetErrorString(result)        
        return
    end
    for _, chat in ipairs(chats) do
        --chat.time = os.date("%X",os.time());
        --文本类型
        chat.ctype = PublicStruct.Chat_Type.text 
        g_dataCenter.chat:add_chat(chat)
    end

    --获取缓存消息后，通知刷新
    PublicFunc.msg_dispatch(msg_chat.gc_add_player_chat)

	if finish then		
	end
end

----------------------------------------------------------------------------

--[[//跑马灯
	roll_message_data data

    int ntype;	   //消息类型优先级从高到低
	int loopTimes; //循环次数
	int interval;   //间隔时间
	string content; //内容
	list<string> vecParm;//参数
]]
function msg_chat.gc_marquee(data)
    if data.ntype == MsgEnum.emarquee_msg_type.eRollMessage_type_goldenEgg then
        g_dataCenter.activityReward:AddMarquee(data)
        return
    end
    g_dataCenter.marquee:addMarquee(data);
end

--[[删除跑马灯]]
function msg_chat.gc_delete_marquee(marqueeId)
    g_dataCenter.marquee:deleteMarquee(marqueeId);
end

