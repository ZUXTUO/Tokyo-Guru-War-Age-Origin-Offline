
chat_local = {}

local _timerId = nil

--[[一条返回聊天信息]]
local one_msg_info = {
	type = 1,
	content = "",
	sender = {
		playerid = "263549466846461185",  --225839069872028929
		name = "name",
		vip = 1,
		image = "",
	}
}

--[[屏蔽信息]]
local one_shield_info = {
	whisper = true;--[[非好友私聊]]
	players = {
		[1] = {
			type = 2;
			content = "内容";
			info = {
				name = "玩家名字";
				vip = 10;
				image = "xxx.png";
			};
		};
	};
};

--[[发送聊天]]
local cheat_chat = nil
function chat_local.cg_player_chat(type, content, desplayername, speaker)
    cheat_chat = table.deepcopy(one_msg_info)
	cheat_chat.type = type;
	cheat_chat.content = content;
	_timerId = timer.create("chat_local.gc_player_chat", 100, 1);
end

function chat_local.gc_player_chat() 
	msg_chat.gc_add_player_chat(cheat_chat)
end

--[[屏蔽功能]]
local shield_name = "";
function chat_local.cg_shield(type, switch, name)
	shield_name = name;
	_timerId = timer.create("chat_local.gc_shield", 100, 1);
end

function chat_local.gc_shield()
	msg_chat.gc_shield(0, 2, true, shield_name);
end


-- 跑马灯
local marquee_data = {
    {ntype = 0, loopTimes = 2, interval = 3, content = 'gm公告测试gm公告测试！'},
    {ntype = 1, loopTimes = 1, interval = 0, content = '', vecParm = {'玩家1'}},
    {ntype = 1, loopTimes = 1, interval = 0, content = '', vecParm = {'玩家--2'}},
    {ntype = 5, loopTimes = 2, interval = 1, content = '', vecParm = {'玩家1', '1-1关'}},
    {ntype = 5, loopTimes = 1, interval = 0, content = '', vecParm = {'玩家--2', '2-2关'}},
}

function chat_local.cg_marquee()
	_timerId = timer.create("chat_local.gc_marquee", 1000, 1);
end

function chat_local.gc_marquee()
    timer.stop(_timerId)
    _timerId = nil
    for _, v in ipairs(marquee_data) do 
	    msg_chat.gc_marquee(v);
    end
end






