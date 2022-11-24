ShiYiQuTaoFaZhan = Class("ShiYiQuTaoFaZhan",PlayMethodBase)

local EDifficulty = 
{
	normal = 1,
	hard = 2,
}

function ShiYiQuTaoFaZhan:Init(data)
	self:ClearData(data);
	self:initData(data);
end

function ShiYiQuTaoFaZhan:GameResult(isWin,awards,param)
	
end

function ShiYiQuTaoFaZhan:EndGame()
	
end

function ShiYiQuTaoFaZhan:initData(data)
	--难度
	self.curDifficulty = EDifficulty.normal;

	--当前步数
	self.curStep = 0;

	--剩余重置次数
	self.resetNumber = 0;

	--当前出战英雄id
	self.curHeroID = {};

	--每一关敌人英雄id
	self.enemyID = {};
	for i=1,12 do
		self.enemyID[i] = {};
	end
end

function ShiYiQuTaoFaZhan:SetEnemyID(stepNum,posNum,id)
	self.enemyID[stepNum][posNum] = id;
end