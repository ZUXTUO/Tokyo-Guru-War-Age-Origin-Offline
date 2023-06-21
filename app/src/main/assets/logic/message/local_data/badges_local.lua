--
-- Created by IntelliJ IDEA.
-- User: pokong
-- Date: 2015/8/13
-- Time: 10:33
-- To change this template use File | Settings | File Templates.
--

badges_local = {};

--声明timer, 延迟返回使用
local _timerId = nil

-------------------------------------返回抢夺队伍列表-------------------------------------
local _contingentData = {
	[1] = {
		player_id = 101; --玩家ID
		player_name = "测试玩家名字1"; --玩家名字
		player_icon = "assetbundles/prefabs/ui/image/icon/small_icon/human/anjiuheinai_y.png"; --玩家ICON
		fight = 101; --战力值
		reward_id = 20000001;--奖励物品ID
		reward_num = 1; --奖励物品数量
		cards_list = {
			{
				id = 30000001; --卡ID
				lv = 1; --等级
			};
			{
				id = 30000002; --卡ID
				lv = 1; --等级
			};
			{
				id = 30000003; --卡ID
				lv = 1; --等级
			};
		}
	};

	[2] = {
		player_id = 102; --玩家ID
		player_name = "测试玩家名字2"; --玩家名字
		player_icon = "assetbundles/prefabs/ui/image/icon/small_icon/human/anjiuheinai_y.png"; --玩家ICON
		fight = 102; --战力值
		reward_id = 20000001;--奖励物品ID
		reward_num = 1; --奖励物品数量
		cards_list = {
			{
				id = 30000001; --卡ID
				lv = 1; --等级
			};
			{
				id = 30000002; --卡ID
				lv = 1; --等级
			};
			{
				id = 30000003; --卡ID
				lv = 1; --等级
			};
		}
	};

	[3] = {
		player_id = 103; --玩家ID
		player_name = "测试玩家名字3"; --玩家名字
		player_icon = "assetbundles/prefabs/ui/image/icon/small_icon/human/anjiuheinai_y.png"; --玩家ICON
		fight = 103; --战力值
		reward_id = 20000001;--奖励物品ID
		reward_num = 1; --奖励物品数量
		cards_list = {
			{
				id = 30000001; --卡ID
				lv = 1; --等级
			};
			{
				id = 30000002; --卡ID
				lv = 1; --等级
			};
			{
				id = 30000003; --卡ID
				lv = 1; --等级
			};
		}
	};

	[4] = {
		player_id = 104; --玩家ID
		player_name = "测试玩家名字4"; --玩家名字
		player_icon = "assetbundles/prefabs/ui/image/icon/small_icon/human/anjiuheinai_y.png"; --玩家ICON
		fight = 104; --战力值
		reward_id = 20000001;--奖励物品ID
		reward_num = 1; --奖励物品数量
		cards_list = {
			{
				id = 30000001; --卡ID
				lv = 1; --等级
			};
			{
				id = 30000002; --卡ID
				lv = 1; --等级
			};
			{
				id = 30000003; --卡ID
				lv = 1; --等级
			};
		}
	};

};




local _data = {
	[1] = {
		player_info = {
			playerid = 1;
			name = "1号玩家";
			image = 32000000;
			teams = {{10001,10002},{},{},{},{},{},{},{},{},{}};
		};
		package_info = {
			hero = {
				{
					dataid = 10001;				--唯一编号
					number = 30001000;				--编号
					level = 1;					--等级
					cur_exp = 10;				--当前经验
					equip = {1,2,3,4};			--装备 1 主武器 2 副武器 3 头盔 4 铠甲 5 靴子 6 饰品 7 鞋子 暂时未用 8 项链 暂时未用
					souls = 5;					--拥有英魂数
				};
				{
					dataid = 10002;				--唯一编号
					number = 30001001;				--编号
					level = 1;					--等级
					cur_exp = 10;				--当前经验
					equip = {1,2,3,4};			--装备 1 主武器 2 副武器 3 头盔 4 铠甲 5 靴子 6 饰品 7 鞋子 暂时未用 8 项链 暂时未用
					souls = 5;					--拥有英魂数
				};
			};
			equip = {
				{dataid = 1,number = 10000001,level = 1};
				{dataid = 2,number = 10000001,level = 1};
				{dataid = 3,number = 10000001,level = 1};
				{dataid = 4,number = 10000001,level = 1};
			};
			item = {
				{dataid = 20001; number = 20000001;count = 1};
				{dataid = 20002; number = 20000001;count = 1};
				{dataid = 20003; number = 20000001;count = 1};
			};
		};

		other_data = {
			reward_list = {
				{reward_id = 1; reward_num = 1};
			};
		};

	};
};




--[[得到例表]]
function badges_local.cg_contingent_time()
	_timerId = timer.create("badges_local.gc_contingent", 50, 1);
end
function badges_local.gc_contingent()
	badges.gc_contingent(_data);
	timer.stop(_timerId);
end

