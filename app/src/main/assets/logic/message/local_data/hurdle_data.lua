--[[
	邮件单机数据
]]
--声明timer, 延迟返回使用
local _timerId = nil

-------------------------------------返回邮件列表-------------------------------------
local _hurdleData = {}
--[[
struct hurdle_net
{
	uint hurdleid;				// 关卡编号
	uint8 star_num;				// 通关星数
	string period_post_times;	// 周期通关次数
	string award_collected_info;// 奖励领取情况
}
]]
_hurdleData.hurdle_net={
	[1]={
		hurdleid=0,
		star_num="6172017417708437506",
		period_post_times="标题",
		award_collected_info=1437034788,
	},
}
_hurdleData.curgroupid = 1
_hurdleData.mailcount = 7
_hurdleData.ret = 0
_hurdleData.page = 0

gc_hurdle_group_info = {}
function gc_hurdle_group_info.cg()
 	_timerId = timer.create("gc_hurdle_group_info.gc", 1000, 1);
end 

function gc_hurdle_group_info.gc()
	msg_mail.gc_hurdle_group_info(_hurdleData.curgroupid);
	timer.stop(_timerId)
end


gc_hurdle_group_list = {}
function gc_hurdle_group_list.cg()
 	_timerId = timer.create("gc_hurdle_group_list.gc", 1000, 1);
end 

function gc_hurdle_group_list.gc()
	msg_mail.gc_hurdle_group_list(_hurdleData.hurdle_net, _hurdleData.award_group);
	timer.stop(_timerId)
end


gc_take_award = {}
function gc_take_award.cg()
 	_timerId = timer.create("gc_take_award.gc", 1000, 1);
end 

function gc_take_award.gc()
	msg_mail.gc_take_award(_hurdleData.result, _hurdleData.type, _hurdleData.id, _hurdleData.param, _hurdleData.net_summary_item);
	timer.stop(_timerId)
end

gc_hurdle_fight = {}
function gc_hurdle_fight.cg()
 	_timerId = timer.create("gc_hurdle_fight.gc", 1000, 1);
end 

function gc_hurdle_fight.gc()
	msg_mail.gc_hurdle_fight(_hurdleData.hurdle_id, _hurdleData.result);
	timer.stop(_timerId)
end

gc_hurdle_fight_result = {}
function gc_hurdle_fight_result.cg()
 	_timerId = timer.create("gc_hurdle_fight_result.gc", 1000, 1);
end 

function gc_hurdle_fight_result.gc()
	msg_mail.gc_hurdle_fight_result(_hurdleData.hurdle_id, _hurdleData.result,_hurdleData.net_summary_item);
	timer.stop(_timerId)
end


















