--[[
-File    : fight_event.lua
-Author  : dengchao
-Date    : 2015/1/7
-Function: 客户端战斗事件脚本, 战斗过程中有很多事件需要统计,以此来判断战斗情况.
]]--

script.run 'logic/object/fight_condition.lua'

FightEvent = {}
local this = FightEvent
local fightTask = nil
-- 战斗统计数据
local fightData = {kill={monster=0,hero=0},}
local updateEvent = false
--[[战斗时间超时]]
function FightEvent.OnTimeOver( )
	--fightOver( 'timeOver' )
end

--[[战斗开始: 检查关卡完成条件表,将本关卡需要的条件记录下来]]
function FightEvent.OnFightBegin( levelID )
	fightResult = nil;
	fightTask = {
		[1] = { boss = 1},
		[2] = { clean = 1},
		[3] = { hp = 100 }
	}
end

--[[战斗结束,计算星级,向服务器发送消息]]
function FightEvent.OnFightOver()
		
	if fightResult then
		-- 计算星级
		local star = 0
		
		local passTask = Fight.GetPassTask();
		for k,v in pairs(passTask) do
			local result = true;
			for m,n in pairs(v) do
				if not FightCondition.Check(m,n, g_dataCenter.fight_info.single_enemy_flag) then
					result = false;
					break;
				end
			end
			if result then
				star = star + 1;
			end
		end

        --SettlementUi.Init({id = FightScene.GetCurHurdleID()});
		
		ObjectManager.EnableAllAi(false);

        Root.get_root_ui_2d_fight():set_active(false);
		
		--SceneManager.PopScene(FightScene);
    else

    end
end

--[[杀死了一个对象]]
function FightEvent.OnKill( )
	updateEvent = true
end

--[[obj死了]]
function FightEvent.OnDead(obj)		
	obj:OnDead()
	-- updateEvent = true
end

return FightEvent
