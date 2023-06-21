--公会单机数据

local _timerId = nil

local _simpleList = nil;
local _detail = nil
local _members = nil
local _memberActivityRecord = nil
local _applyList = nil
local _guildId = nil
local _ntype = nil
local _playerid = nil
local _param = nil
local _name = nil
local _applyLv = nil
local _needApply = nil
local _declaration = nil
local _icon = nil
local _log = {}

-- 公会列表信息
_simpleList = {
	{
		guildID = 10001,
		guildLevel = 1,
		limitJoinLevel = 20,
		IconIndex = 1,
		createTime = 1447479297,
		szName = "恐龙帮",
		szDeclaration = "恐龙帮最强大",
		szLeaderName = "霸王龙",
		memberCnt = 6,
	},
	{
		guildID = 10002,
		guildLevel = 4,
		limitJoinLevel = 20,
		IconIndex = 1,
		createTime = 1447489297,
		szName = "最强公会",
		szDeclaration = "最强公会",
		szLeaderName = "发烧了",
		memberCnt = 8,
	},
	{
		guildID = 10003,
		guildLevel = 3,
		limitJoinLevel = 30,
		IconIndex = 1,
		createTime = 1447499297,
		szName = "喇叭",
		szDeclaration = "吹个球吹个大气球",
		szLeaderName = "微软",
		memberCnt = 6,
	},
	{
		guildID = 10004,
		guildLevel = 2,
		limitJoinLevel = 20,
		IconIndex = 1,
		createTime = 1447509297,
		szName = "加强幻境",
		szDeclaration = "",
		szLeaderName = "阿德",
		memberCnt = 11,
	},
	{
		guildID = 10005,
		guildLevel = 1,
		limitJoinLevel = 20,
		IconIndex = 1,
		createTime = 1447519297,
		szName = "日本人哦",
		szDeclaration = "",
		szLeaderName = "结合体",
		memberCnt = 12,
	},
	{
		guildID = 10006,
		guildLevel = 1,
		limitJoinLevel = 20,
		IconIndex = 1,
		createTime = 1447529297,
		szName = "天下第一公会",
		szDeclaration = "",
		szLeaderName = "谔谔",
		memberCnt = 10,
	},
	{
		guildID = 10007,
		guildLevel = 4,
		limitJoinLevel = 20,
		IconIndex = 1,
		createTime = 1447539297,
		szName = "玩玩而已",
		szDeclaration = "",
		szLeaderName = "范德萨",
		memberCnt = 10,
	},
}

_applyList = {
	{
		playerid = "200001",
		name = "玩家加工会1",
		player_level = 40,
	},
	{
		playerid = "200002",
		name = "玩家加工会2",
		player_level = 31,
	},
}

_members = {
	{
		playerid = "100001",
		szName = "公会玩家1",
		nLevel = 20,
		job = 1,
		bOnline = true,
		activePoints = 0,
		activeTotalPoints = 0,
		guildMoney = 0,
	},
	{
		playerid = "100002",
		szName = "公会玩家2",
		nLevel = 21,
		job = 2,
		bOnline = true,
		activePoints = 0,
		activeTotalPoints = 0,
		guildMoney = 0,
	},
	{
		playerid = "100003",
		szName = "公会玩家3",
		nLevel = 21,
		job = 3,
		bOnline = false,
		activePoints = 0,
		activeTotalPoints = 0,
		guildMoney = 0,
	},
	{
		playerid = "100004",
		szName = "公会玩家4",
		nLevel = 22,
		job = 4,
		bOnline = true,
		activePoints = 0,
		activeTotalPoints = 0,
		guildMoney = 0,
	},
	{
		playerid = "100005",
		szName = "公会玩家5",
		nLevel = 23,
		job = 4,
		bOnline = true,
		activePoints = 0,
		activeTotalPoints = 0,
		guildMoney = 0,
	},
	{
		playerid = "100006",
		szName = "公会玩家6",
		nLevel = 24,
		job = 4,
		bOnline = true,
		activePoints = 0,
		activeTotalPoints = 0,
		guildMoney = 0,
	},
}

local function _SetMemberMe()
	local member = _members[1]
	member.playerid = g_dataCenter.player.playerid
	member.szName = g_dataCenter.player.name
	member.nLevel = g_dataCenter.player.level
	member.bOnline = true
	member.activePoints = 0
	member.activeTotalPoints = 0
end


_log.count = 0
_log.data = {
	{
		time = 1447480297,
		ntype = 1,
		parms = {"恐龙侠"},
	},
	{
		time = 1447490297,
		ntype = 2,
		parms = {"恐龙侠", "屠龙者"},
	},
	{
		time = 1447550297,
		ntype = 3,
		parms = {"屠龙者", "恐龙侠", "20000025"},
	},
	{
		time = 1447670297,
		ntype = 4,
		parms = {"屠龙者", "1"},
	},
}

-- 本公会详细数据
_detail = {
	guildID = 10001,
	guildLevel = 1,
	limitJoinLevel = 20,
	IconIndex = 1,
	createTime = 1447479297,
	szName = "恐龙帮",
	szDeclaration = "恐龙帮最强大",
	szLeaderName = "霸王龙",
	memberCnt = 5,
	ApproveRule = 0,
	guildExp = 0,
	activePoints = 1,
	vecMember = _members,
	vecLog = _log.data,
	vecApplyList = _applyList,
}

-- 公会成员的活动记录
_memberActivityRecord = {
	[1] = {
		{playerid = "100002", vecActiveData = {{times=1,pointValue=0},{times=1,pointValue=0},{times=1,pointValue=0}}},
		{playerid = "100003", vecActiveData = {{times=1,pointValue=0},{times=1,pointValue=0},{times=1,pointValue=0}}},
		{playerid = "100004", vecActiveData = {{times=1,pointValue=0},{times=1,pointValue=0},{times=1,pointValue=0}}},
		{playerid = "100005", vecActiveData = {{times=1,pointValue=0},{times=1,pointValue=0},{times=1,pointValue=0}}},
		{playerid = "100006", vecActiveData = {{times=1,pointValue=0},{times=1,pointValue=0},{times=1,pointValue=0}}},
	},
	[2] = {
		{playerid = "100002", vecActiveData = {{times=2,pointValue=0},{times=2,pointValue=0},{times=2,pointValue=0}}},
		{playerid = "100003", vecActiveData = {{times=1,pointValue=0},{times=1,pointValue=0},{times=1,pointValue=0}}},
		{playerid = "100004", vecActiveData = {{times=2,pointValue=0},{times=2,pointValue=0},{times=2,pointValue=0}}},
		{playerid = "100005", vecActiveData = {{times=3,pointValue=0},{times=3,pointValue=0},{times=3,pointValue=0}}},
		{playerid = "100006", vecActiveData = {{times=4,pointValue=0},{times=4,pointValue=0},{times=4,pointValue=0}}},
	},
	[3] = {
		{playerid = "100002", vecActiveData = {{times=20,pointValue=0},{times=20,pointValue=0},{times=20,pointValue=0}}},
		{playerid = "100003", vecActiveData = {{times=10,pointValue=0},{times=10,pointValue=0},{times=10,pointValue=0}}},
		{playerid = "100004", vecActiveData = {{times=12,pointValue=0},{times=12,pointValue=0},{times=12,pointValue=0}}},
		{playerid = "100005", vecActiveData = {{times=15,pointValue=0},{times=15,pointValue=0},{times=15,pointValue=0}}},
		{playerid = "100006", vecActiveData = {{times=14,pointValue=0},{times=14,pointValue=0},{times=14,pointValue=0}}},
	},
}


guild_data_local = {}

-------------------------------------创建公会-------------------------------------
function guild_data_local.cg_create_guild(szName, nIcon, nLimitLevel, ApproveRule)
 	_timerId = timer.create("guild_data_local.gc_create_guild", 1000, 1);
end 

function guild_data_local.gc_create_guild()
	msg_guild.gc_create_guild(0);
	timer.stop(_timerId)
end


-------------------------------------返回公会列表-------------------------------------
function guild_data_local.cg_request_guild_list()
 	_timerId = timer.create("guild_data_local.gc_request_guild_list", 1000, 1);
end 

function guild_data_local.gc_request_guild_list()
	msg_guild.gc_request_guild_list(_simpleList);
	timer.stop(_timerId)
end


-------------------------------------申请加入公会-------------------------------------
function guild_data_local.cg_apply_join(guildID)
	_guildId = guildID
 	_timerId = timer.create("guild_data_local.gc_apply_join", 1000, 1);
end 

function guild_data_local.gc_apply_join()
	msg_guild.gc_apply_join(0, _guildId);
	timer.stop(_timerId)
end


-------------------------------------处理玩家申请消息-------------------------------------
function guild_data_local.cg_dealwith_apply_join(playerid, ntype)
	_playerid = playerid
	_ntype = ntype
	_timerId = timer.create("guild_data_local.gc_dealwith_apply_join", 1000, 1);
end 

function guild_data_local.gc_dealwith_apply_join()
	-- 同意
	if _ntype == 0 then
		
	-- 拒绝
	elseif _ntype == 1 then
		
	end
	msg_guild.gc_update_apply_data(1, {playerid=_playerid});
	msg_guild.gc_dealwith_apply_join(0, _playerid, _ntype);
	timer.stop(_timerId)
end


-------------------------------------返回我的公会数据-------------------------------------
function guild_data_local.cg_request_my_guild_data()
	_timerId = timer.create("guild_data_local.gc_sync_my_guild_data", 1000, 1);
end

function guild_data_local.gc_sync_my_guild_data()
	_SetMemberMe()	-- 初始化玩家数据

	msg_guild.gc_sync_my_guild_data(_detail);
	timer.stop(_timerId)
end


-------------------------------------返回公会活动记录-------------------------------------
function guild_data_local.cg_request_actviity_record(ntype)
	_ntype = ntype
	_timerId = timer.create("guild_data_local.gc_request_actviity_record", 1000, 1);
end

function guild_data_local.gc_request_actviity_record()
	msg_guild.gc_request_actviity_record(0, _ntype, _memberActivityRecord[_ntype + 1]);
	timer.stop(_timerId)
end


-------------------------------------公会成员管理-------------------------------------
function guild_data_local.cg_guild_operation(ntype, playerid, param)
	_ntype = ntype
	_playerid = playerid
	_param = param
	_timerId = timer.create("guild_data_local.gc_guild_operation", 1000, 1);
end

function guild_data_local.gc_guild_operation()
	-- 0,踢人，1继承，2职位变更,3解散
	if _ntype == 0 then

	elseif _ntype == 3 then

	end
	msg_guild.gc_guild_operation(0, _ntype, _playerid, _param);
	timer.stop(_timerId)
end


-------------------------------------退出公会-------------------------------------
function guild_data_local.cg_quit_guild()
	_timerId = timer.create("guild_data_local.gc_quit_guild", 1000, 1);
end

function guild_data_local.gc_quit_guild()
	msg_guild.gc_quit_guild(0);
	timer.stop(_timerId)
end


-------------------------------------公会改名-------------------------------------
function guild_data_local.cg_change_guild_name(szName)
	_name = szName
	_timerId = timer.create("guild_data_local.gc_change_guild_name", 1000, 1);
end

function guild_data_local.gc_change_guild_name()
	msg_guild.gc_change_guild_name(0, _name);
	timer.stop(_timerId)
end


-------------------------------------修改公会信息-------------------------------------
function guild_data_local.cg_update_guild_config(limitJoinLevel, ApproveRule, szDeclaration, nIcon)
	_applyLv = limitJoinLevel
	_needApply = ApproveRule
	_declaration = szDeclaration
	_icon = nIcon
	_timerId = timer.create("guild_data_local.gc_update_guild_config", 1000, 1);
end

function guild_data_local.gc_update_guild_config()
	msg_guild.gc_update_guild_config(0, _applyLv, _needApply, _declaration, _icon);
	timer.stop(_timerId)
end


-------------------------------------模拟Push消息-------------------------------------
-- 模拟发送指令 0,加入一个成员，1删除一个成员，2成员状态改变
function guild_data_local.gc_update_member_data(ntype, playerid)
	if ntype == 0 then


	elseif ntype == 1 then


	elseif ntype == 2 then


	end
end

-- 模拟添加日志
function guild_data_local.gc_change_guild_name()
	if _log.count < 3 then
		_log.count = _log.count + 1
		msg_guild.gc_change_guild_name(_log.data[_log.count]);
		if _log.count == 3 then _log.count = 0 end
	end
end
