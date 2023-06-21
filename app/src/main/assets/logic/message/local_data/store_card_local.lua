--[[
	商城单机数据
]]
--声明timer, 延迟返回使用
local _timerId = nil

-------------------------------------返回商城钻石列表-------------------------------------
local _storeCard = {}

_storeCard.list={
	[1]={
		index = 1,
		name="月卡",
		type=2,
		id = 1,
		num = 1,
		price = 100,
		discount = 100,
		icon='hongshuijing',
		describe="一二三四五, 上山打老虎.一二三四五, 上山打老虎.一二三四五, 上山打老虎.一二三四五, 上山打老虎.一二三四五, 上山打老虎.一二三四五, 上山打老虎.一二三四五, 上山打老虎.",
		tag=ENUM.EStoreCardMark.Null,
	},
	[2]={
		index = 2,
		name="尊享卡",
		type=2,
		id = 2,
		num = 1,
		price = 200,
		discount = 100,
		icon='hongshuijing',
		describe="一二三四五, 上山打老虎.一二三四五, 上山打老虎.一二三四五, 上山打老虎.一二三四五, 上山打老虎.一二三四五, 上山打老虎.一二三四五, 上山打老虎.一二三四五, 上山打老虎.",
		tag=ENUM.EStoreCardMark.Recommend,
	},
	[3]={
		index = 3,
		name="卡名字3",
		type=ENUM.EStoreCardType.CrystalCard,
		id = 1,
		num = 1,
		price = 300,
		discount = 100,
		icon='hongshuijing',
		describe="一二三四五, 上山打老虎.一二三四五, 上山打老虎.一二三四五, 上山打老虎.一二三四五, 上山打老虎.一二三四五, 上山打老虎.一二三四五, 上山打老虎.一二三四五, 上山打老虎.",
		tag=ENUM.EStoreCardMark.Abate,
	},
	[4]={
		index = 4,
		name="卡名字4",
		type=1,
		id = 1,
		num = 1,
		price = 400,
		discount = 100,
		icon='hongshuijing',
		describe="一二三四五, 上山打老虎.一二三四五, 上山打老虎.一二三四五, 上山打老虎.一二三四五, 上山打老虎.一二三四五, 上山打老虎.一二三四五, 上山打老虎.一二三四五, 上山打老虎.",
		tag=ENUM.EStoreCardMark.Hot,
	},
	[5]={
		index = 5,
		name="卡名字5",
		type=1,
		id = 1,
		num = 1,
		price = 500,
		discount = 100,
		icon='hongshuijing',
		describe="一二三四五, 上山打老虎.一二三四五, 上山打老虎.一二三四五, 上山打老虎.一二三四五, 上山打老虎.一二三四五, 上山打老虎.一二三四五, 上山打老虎.一二三四五, 上山打老虎.",
		money="500元",
		tag=ENUM.EStoreCardMark.Quota,
	},
	[6]={
		index = 6,
		name="卡名字6",
		type=1,
		id = 1,
		num = 1,
		price = 600,
		discount = 100,
		icon='hongshuijing',
		describe="一二三四五, 上山打老虎.一二三四五, 上山打老虎.一二三四五, 上山打老虎.一二三四五, 上山打老虎.一二三四五, 上山打老虎.一二三四五, 上山打老虎.一二三四五, 上山打老虎.",
		tag=ENUM.EStoreCardMark.Interval,
	},
}
_storeCard.ret = 0

local _index = 0
local _level = 1

gc_sync_store_data = {}
function gc_sync_store_data.cg()
 	_timerId = timer.create("gc_sync_store_data.gc", 1000, 1);
end 

function gc_sync_store_data.gc()
	msg_store.gc_sync_store_data(_storeCard.list, _storeCard.ret)
	timer.stop(_timerId)
end











