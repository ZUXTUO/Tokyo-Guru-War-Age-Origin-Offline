
guild_war_local = {}

local _timerId = nil

local _logs = {
    {
        time = 1479702780,    --2106/11/21 12:33
	    attackerName = "attack2", 
	    attackerGuildName = "attack_guild2", 
	    guardName = "guard1", 
	    guardGuildName = "guard_guild2", 
	    isWin = 1,
	    isLast = 1,
    },
    {
        time = 1479785340,    --2106/11/22 11:29
	    attackerName = "attack1", 
	    attackerGuildName = "attack_guild1", 
	    guardName = "", 
	    guardGuildName = "guard_guild1", 
	    isWin = 1,
	    isLast = 1,
    },    
    {
        time = 1479799500,    --2106/11/22 15:25
	    attackerName = "attack2", 
	    attackerGuildName = "attack_guild2", 
	    guardName = "guard2", 
	    guardGuildName = "guard_guild2", 
	    isWin = 1,
	    isLast = 0,
    },    
    {
        time = 1479799440,    --2106/11/22 15:24
	    attackerName = "attack2", 
	    attackerGuildName = "attack_guild2", 
	    guardName = "guard2", 
	    guardGuildName = "guard_guild2", 
	    isWin = 0,
	    isLast = 0,
    },
    {
        time = 1479799620,    --2106/11/22 15:27
	    attackerName = "attack2", 
	    attackerGuildName = "attack_guild2", 
	    guardName = "guard2", 
	    guardGuildName = "guard_guild2", 
	    isWin = 1,
	    isLast = 1,
    },
    {
        time = 1479799560,    --2106/11/22 15:26
	    attackerName = "attack2", 
	    attackerGuildName = "attack_guild2", 
	    guardName = "guard2", 
	    guardGuildName = "guard_guild2", 
	    isWin = 0,
	    isLast = 1,
    },
}

function guild_war_local.cg_get_node_fight_log(nodeId)
	_timerId = timer.create("guild_war_local.gc_get_node_fight_log", 100, 1);
end

function guild_war_local.gc_get_node_fight_log() 
    timer.stop(_timerId)
	msg_guild_war.gc_get_node_fight_log(0, nil, _logs)
end